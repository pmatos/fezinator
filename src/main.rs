use anyhow::Result;
use clap::{Parser, Subcommand};

mod analyzer;
mod cli;
mod db;
mod error;
mod extractor;
mod simulator;

use cli::analyze::AnalyzeCommand;
use cli::extract::ExtractCommand;
use cli::list::ListCommand;
use cli::remove::RemoveCommand;
use cli::simulate::SimulateCommand;

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
    Remove(RemoveCommand),
    Analyze(AnalyzeCommand),
    Simulate(SimulateCommand),
}

fn main() -> Result<()> {
    // Initialize logging with INFO level by default
    env_logger::Builder::from_env(env_logger::Env::default().default_filter_or("info")).init();

    let cli = Cli::parse();

    match cli.command {
        Commands::Extract(cmd) => cmd.execute(),
        Commands::List(cmd) => cmd.execute(),
        Commands::Remove(cmd) => cmd.execute(),
        Commands::Analyze(cmd) => cmd.execute(),
        Commands::Simulate(cmd) => cmd.execute(),
    }
}
