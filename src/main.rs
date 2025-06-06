use anyhow::Result;
use clap::{Parser, Subcommand};

mod cli;
mod db;
mod error;
mod extractor;

use cli::extract::ExtractCommand;

#[derive(Parser)]
#[command(name = "fezinator")]
#[command(about = "A framework for extracting and analyzing assembly code blocks from ELF and PE binaries", long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    Extract(ExtractCommand),
}

fn main() -> Result<()> {
    env_logger::init();

    let cli = Cli::parse();

    match cli.command {
        Commands::Extract(cmd) => cmd.execute(),
    }
}
