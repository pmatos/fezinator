use anyhow::Result;
use clap::Args;
use log::{debug, info};
use std::path::PathBuf;

use crate::db::Database;
use crate::extractor::Extractor;

#[derive(Args)]
pub struct ExtractCommand {
    #[arg(help = "Path to the binary file (ELF or PE format)")]
    binary: PathBuf,

    #[arg(short, long, help = "Enable verbose logging")]
    verbose: bool,

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
        if self.verbose {
            info!("Extracting from binary: {:?}", self.binary);
        }

        let mut db = Database::new(&self.database)?;
        db.init()?;

        let extractor = Extractor::new(self.binary)?;
        let binary_info = extractor.get_binary_info()?;

        if self.verbose {
            info!("Binary info: {:?}", binary_info);
        }

        let (start_addr, end_addr, assembly_block) = extractor.extract_random_block()?;

        if self.verbose {
            info!(
                "Extracted block from 0x{:x} to 0x{:x}",
                start_addr, end_addr
            );
            debug!("Assembly block size: {} bytes", assembly_block.len());
        }

        db.store_extraction(&binary_info, start_addr, end_addr, &assembly_block)?;

        if self.verbose {
            info!("Extraction stored in database");
        }

        Ok(())
    }
}
