use anyhow::Result;
use rusqlite::{params, Connection};
use serde::{Deserialize, Serialize};
use std::path::Path;

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
}
