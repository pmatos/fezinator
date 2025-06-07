use anyhow::Result;
use rusqlite::{params, Connection};
use serde::{Deserialize, Serialize};
use std::path::Path;

use crate::analyzer::BlockAnalysis;

#[cfg(test)]
mod tests;

#[derive(Debug, Serialize, Deserialize)]
pub struct BinaryInfo {
    pub path: String,
    pub size: u64,
    pub hash: String,
    pub format: String,
    pub architecture: String,
    pub endianness: String,
}

#[derive(Debug)]
pub struct ExtractionInfo {
    pub binary_path: String,
    pub binary_hash: String,
    pub binary_format: String,
    pub binary_architecture: String,
    pub start_address: u64,
    pub end_address: u64,
    pub assembly_block: Vec<u8>,
    pub created_at: String,
    pub analysis_status: String,
    pub analysis_results: Option<String>,
}

pub struct Database {
    conn: Connection,
}

impl Database {
    pub fn new(path: &Path) -> Result<Self> {
        let conn = Connection::open(path)?;
        Ok(Database { conn })
    }

    pub fn init(&mut self) -> Result<()> {
        self.conn.execute(
            "CREATE TABLE IF NOT EXISTS binaries (
                id INTEGER PRIMARY KEY,
                path TEXT NOT NULL,
                size INTEGER NOT NULL,
                hash TEXT NOT NULL UNIQUE,
                format TEXT NOT NULL,
                architecture TEXT NOT NULL,
                endianness TEXT NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            )",
            [],
        )?;

        self.conn.execute(
            "CREATE TABLE IF NOT EXISTS extractions (
                id INTEGER PRIMARY KEY,
                binary_id INTEGER NOT NULL,
                start_address INTEGER NOT NULL,
                end_address INTEGER NOT NULL,
                assembly_block BLOB NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (binary_id) REFERENCES binaries(id)
            )",
            [],
        )?;

        self.conn.execute(
            "CREATE TABLE IF NOT EXISTS analyses (
                id INTEGER PRIMARY KEY,
                extraction_id INTEGER NOT NULL UNIQUE,
                instructions_count INTEGER NOT NULL,
                live_in_registers TEXT NOT NULL,
                live_out_registers TEXT NOT NULL,
                exit_points TEXT NOT NULL,
                memory_accesses TEXT NOT NULL,
                analyzed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (extraction_id) REFERENCES extractions(id)
            )",
            [],
        )?;

        Ok(())
    }

    pub fn store_extraction(
        &mut self,
        binary_info: &BinaryInfo,
        start_addr: u64,
        end_addr: u64,
        assembly_block: &[u8],
    ) -> Result<()> {
        let tx = self.conn.transaction()?;

        let binary_id = {
            let mut stmt = tx.prepare("SELECT id FROM binaries WHERE hash = ?1")?;

            let existing_id: Option<i64> =
                stmt.query_row([&binary_info.hash], |row| row.get(0)).ok();

            match existing_id {
                Some(id) => id,
                None => {
                    tx.execute(
                        "INSERT INTO binaries (path, size, hash, format, architecture, endianness)
                         VALUES (?1, ?2, ?3, ?4, ?5, ?6)",
                        params![
                            binary_info.path,
                            binary_info.size,
                            binary_info.hash,
                            binary_info.format,
                            binary_info.architecture,
                            binary_info.endianness,
                        ],
                    )?;
                    tx.last_insert_rowid()
                }
            }
        };

        tx.execute(
            "INSERT INTO extractions (binary_id, start_address, end_address, assembly_block)
             VALUES (?1, ?2, ?3, ?4)",
            params![binary_id, start_addr, end_addr, assembly_block],
        )?;

        tx.commit()?;
        Ok(())
    }

    pub fn list_extractions(&self) -> Result<Vec<ExtractionInfo>> {
        let mut stmt = self.conn.prepare(
            "SELECT b.path, b.hash, b.format, b.architecture, 
                    e.start_address, e.end_address, e.assembly_block, e.created_at,
                    e.id,
                    CASE 
                        WHEN a.id IS NOT NULL THEN 'analyzed'
                        ELSE 'not analyzed'
                    END as analysis_status,
                    CASE 
                        WHEN a.id IS NOT NULL THEN 
                            json_object(
                                'instructions', a.instructions_count,
                                'live_in', a.live_in_registers,
                                'live_out', a.live_out_registers
                            )
                        ELSE NULL
                    END as analysis_summary
             FROM extractions e
             JOIN binaries b ON e.binary_id = b.id
             LEFT JOIN analyses a ON e.id = a.extraction_id
             ORDER BY e.created_at DESC",
        )?;

        let extractions = stmt
            .query_map([], |row| {
                Ok(ExtractionInfo {
                    binary_path: row.get(0)?,
                    binary_hash: row.get(1)?,
                    binary_format: row.get(2)?,
                    binary_architecture: row.get(3)?,
                    start_address: row.get(4)?,
                    end_address: row.get(5)?,
                    assembly_block: row.get(6)?,
                    created_at: row.get(7)?,
                    analysis_status: row.get(9)?,
                    analysis_results: row.get(10)?,
                })
            })?
            .collect::<Result<Vec<_>, _>>()?;

        Ok(extractions)
    }

    pub fn remove_extraction(
        &mut self,
        start_addr: u64,
        end_addr: u64,
        binary_hash: &str,
    ) -> Result<()> {
        let tx = self.conn.transaction()?;

        // Find the binary_id for the given hash
        let binary_id: i64 = tx.query_row(
            "SELECT id FROM binaries WHERE hash = ?1",
            params![binary_hash],
            |row| row.get(0),
        )?;

        // Delete the extraction
        let affected = tx.execute(
            "DELETE FROM extractions 
             WHERE binary_id = ?1 AND start_address = ?2 AND end_address = ?3",
            params![binary_id, start_addr, end_addr],
        )?;

        if affected == 0 {
            return Err(anyhow::anyhow!("No matching extraction found"));
        }

        // Check if this was the last extraction for this binary
        let remaining_count: i64 = tx.query_row(
            "SELECT COUNT(*) FROM extractions WHERE binary_id = ?1",
            params![binary_id],
            |row| row.get(0),
        )?;

        // If no more extractions for this binary, remove the binary entry too
        if remaining_count == 0 {
            tx.execute("DELETE FROM binaries WHERE id = ?1", params![binary_id])?;
        }

        tx.commit()?;
        Ok(())
    }

    pub fn remove_all_extractions(&mut self) -> Result<usize> {
        let tx = self.conn.transaction()?;

        // Count extractions before deletion
        let count: usize =
            tx.query_row("SELECT COUNT(*) FROM extractions", [], |row| row.get(0))?;

        // Delete in correct order due to foreign key constraints:
        // 1. Delete all analyses first (references extractions)
        tx.execute("DELETE FROM analyses", [])?;

        // 2. Delete all extractions (references binaries)
        tx.execute("DELETE FROM extractions", [])?;

        // 3. Delete all binaries (no dependencies)
        tx.execute("DELETE FROM binaries", [])?;

        tx.commit()?;
        Ok(count)
    }

    pub fn store_analysis(
        &mut self,
        start_addr: u64,
        end_addr: u64,
        binary_hash: &str,
        analysis: &BlockAnalysis,
    ) -> Result<()> {
        let tx = self.conn.transaction()?;

        // Find the extraction_id
        let extraction_id: i64 = tx.query_row(
            "SELECT e.id FROM extractions e
             JOIN binaries b ON e.binary_id = b.id
             WHERE b.hash = ?1 AND e.start_address = ?2 AND e.end_address = ?3",
            params![binary_hash, start_addr, end_addr],
            |row| row.get(0),
        )?;

        // Serialize analysis data
        let live_in_regs: Vec<&str> = analysis
            .live_in_registers
            .iter()
            .map(|s| s.as_str())
            .collect();
        let live_out_regs: Vec<&str> = analysis
            .live_out_registers
            .iter()
            .map(|s| s.as_str())
            .collect();
        let exit_points_json = serde_json::to_string(&analysis.exit_points)?;
        let memory_accesses_json = serde_json::to_string(&analysis.memory_accesses)?;

        // Insert or update analysis
        tx.execute(
            "INSERT OR REPLACE INTO analyses 
             (extraction_id, instructions_count, live_in_registers, live_out_registers, 
              exit_points, memory_accesses)
             VALUES (?1, ?2, ?3, ?4, ?5, ?6)",
            params![
                extraction_id,
                analysis.instructions_count,
                live_in_regs.join(","),
                live_out_regs.join(","),
                exit_points_json,
                memory_accesses_json,
            ],
        )?;

        tx.commit()?;
        Ok(())
    }
}
