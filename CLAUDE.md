# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build, Test, and Lint Commands

- **Build**: `cargo build` (debug) or `cargo build --release` (release)
- **Test**: `cargo test` (all tests)
- **Lint**: `cargo clippy -- -D warnings`
- **Format**: `cargo fmt` (auto-format) or `cargo fmt --check` (check only)
- **Quality Checks**: `make check` (comprehensive) or `make quick` (fast checks)

For development workflow, always run `make pre-commit` before committing changes.

### Specific Test Commands
- Assembly tests: `cargo test ann_asm`
- Integration tests: `cargo test --test integration_test`
- Unit tests: `cargo test --bins`

## Code Architecture

Fezinator is a Rust CLI tool for extracting and analyzing assembly code blocks from ELF and PE binaries, with a git-like interface.

### Core Modules
- **cli/**: Command-line interface with subcommands (extract, list, remove, analyze)
- **extractor/**: Binary parsing and assembly extraction using `object` crate
- **db/**: SQLite database operations with `rusqlite` for storage and deduplication
- **analyzer/**: Assembly code analysis functionality
- **error.rs**: Centralized error handling with `thiserror`

### Data Flow
1. CLI parses commands and delegates to appropriate modules
2. Extractor module parses ELF/PE binaries and extracts random assembly blocks
3. Database module stores binary metadata and extractions with deduplication by SHA256 hash
4. Analyzer module provides analysis capabilities for extracted code

### Database Schema
- `binaries` table: Stores binary metadata (path, size, hash, format, architecture)
- `extractions` table: Stores assembly blocks with address ranges and references to binaries

### Key Dependencies
- `object`: ELF/PE binary parsing
- `rusqlite`: SQLite database operations with bundled SQLite
- `clap`: CLI argument parsing with derive features
- `capstone`: Assembly disassembly
- `rand`: Random block selection

## Development Notes

- Assembly test framework requires NASM assembler
- Integration tests compile test binaries using GCC
- Pre-commit hooks available via `./scripts/install-hooks.sh`
- Quality assurance tools: cargo-audit, cargo-machete, cargo-outdated, cargo-geiger
- Run build, tests and lint every time, ensuring they are successful before finishing a feature and before committing.