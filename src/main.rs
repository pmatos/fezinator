use anyhow::Result;
use clap::{Parser, Subcommand};

mod cli;
mod db;
mod error;
mod extractor;

use cli::extract::ExtractCommand;
use cli::list::ListCommand;

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
    List(ListCommand),
}

fn main() -> Result<()> {
    // Initialize logging with INFO level by default
    env_logger::Builder::from_env(env_logger::Env::default().default_filter_or("info")).init();

    let cli = Cli::parse();

    match cli.command {
        Commands::Extract(cmd) => cmd.execute(),
        Commands::List(cmd) => cmd.execute(),
    }
}
