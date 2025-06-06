use anyhow::Result;
use clap::Args;
use log::debug;
use std::path::PathBuf;

use crate::db::Database;
use crate::extractor::Extractor;

#[derive(Args)]
pub struct ExtractCommand {
    #[arg(help = "Path to the binary file (ELF or PE format)")]
    binary: PathBuf,

    #[arg(short, long, help = "Enable verbose logging")]
    verbose: bool,

    #[arg(short, long, help = "Suppress all output")]
    quiet: bool,

    #[arg(
        short,
        long,
        default_value = "fezinator.db",
        help = "SQLite database path"
    )]
    database: PathBuf,
}

impl ExtractCommand {
    pub fn execute(self) -> Result<()> {
        if !self.quiet {
            println!("Extracting from binary: {}", self.binary.display());
        }

        if self.verbose {
            debug!("Verbose mode enabled");
        }

        let mut db = Database::new(&self.database)?;
        db.init()?;

        if !self.quiet {
            println!("Database initialized: {}", self.database.display());
        }

        let extractor = Extractor::new(self.binary.clone())?;
        let binary_info = extractor.get_binary_info()?;

        if !self.quiet {
            println!(
                "Binary info: {} {} (SHA256: {}...)",
                binary_info.format,
                binary_info.architecture,
                &binary_info.hash[..8]
            );
        }

        if self.verbose {
            debug!("Full binary info: {:?}", binary_info);
        }

        let (start_addr, end_addr, assembly_block) = extractor.extract_random_block()?;

        if !self.quiet {
            println!(
                "Extracted block: 0x{:08x} - 0x{:08x} ({} bytes)",
                start_addr,
                end_addr,
                assembly_block.len()
            );
        }

        if self.verbose {
            debug!(
                "Assembly block first 16 bytes: {:02x?}",
                &assembly_block[..16.min(assembly_block.len())]
            );
        }

        db.store_extraction(&binary_info, start_addr, end_addr, &assembly_block)?;

        if !self.quiet {
            println!("✓ Extraction stored in database successfully");
        }

        Ok(())
    }
}
