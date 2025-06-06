# Fezinator

A framework for extracting and analyzing assembly code blocks from x86-64 ELF binaries.

## Overview

Fezinator is a Rust-based command-line tool that provides a git-like interface for extracting random assembly code blocks from x86-64 ELF binaries. It stores extracted data in an SQLite database for analysis and research purposes.

## Features

- **Binary Analysis**: Parses x86-64 ELF binaries and extracts metadata
- **Random Extraction**: Selects random code blocks from the `.text` section
- **Smart Storage**: SQLite database with deduplication and metadata tracking  
- **Git-like CLI**: Familiar command structure with subcommands
- **Comprehensive Testing**: Unit and integration tests ensure reliability
- **Quality Assurance**: Built-in security scanning and code quality tools

## Quick Start

```bash
# Extract a random assembly block from a binary
fezinator extract /path/to/binary

# Extract with verbose output
fezinator extract /path/to/binary --verbose

# Use custom database location
fezinator extract /path/to/binary --database my_extractions.db
```

## Installation

### From Source

```bash
git clone <repository-url>
cd fezinator
cargo build --release
```

The binary will be available at `target/release/fezinator`.

## Usage

### Extract Command

The `extract` command analyzes an x86-64 ELF binary and extracts a random assembly code block:

```bash
fezinator extract <binary_path> [OPTIONS]
```

#### Options

- `--verbose, -v`: Enable detailed logging output
- `--database, -d <path>`: Specify database file (default: `fezinator.db`)

#### What Gets Stored

For each extraction, Fezinator stores:

**Binary Information:**
- File path and size
- SHA256 hash for deduplication
- Architecture and endianness
- Creation timestamp

**Extraction Data:**
- Start and end virtual addresses
- Raw assembly bytes (16-1024 bytes)
- Creation timestamp
- Link to parent binary

### Database Schema

```sql
-- Binary metadata
CREATE TABLE binaries (
    id INTEGER PRIMARY KEY,
    path TEXT NOT NULL,
    size INTEGER NOT NULL,
    hash TEXT NOT NULL UNIQUE,
    architecture TEXT NOT NULL,
    endianness TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Extracted code blocks
CREATE TABLE extractions (
    id INTEGER PRIMARY KEY,
    binary_id INTEGER NOT NULL,
    start_address INTEGER NOT NULL,
    end_address INTEGER NOT NULL,
    assembly_block BLOB NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (binary_id) REFERENCES binaries(id)
);
```

## Examples

### Basic Extraction

```bash
$ fezinator extract /bin/ls --verbose
[INFO] Extracting from binary: "/bin/ls"
[INFO] Binary info: BinaryInfo { path: "/bin/ls", size: 142312, hash: "a1b2c3...", architecture: "x86_64", endianness: "little" }
[INFO] Extracted block from 0x4015a0 to 0x4015c8
[INFO] Extraction stored in database
```

### Multiple Extractions

```bash
# Extract from the same binary multiple times
fezinator extract /bin/ls
fezinator extract /bin/ls  
fezinator extract /bin/ls

# Database will contain:
# - 1 binary record (deduplicated by hash)
# - 3 extraction records with different address ranges
```

### Quiet Mode

```bash
# No output unless there's an error
fezinator extract /bin/ls
echo $?  # 0 if successful
```

## Requirements

- Rust 1.70 or later
- x86-64 architecture (for target binaries)
- GCC (for compiling test binaries during development)

## Building and Development

For detailed building instructions, testing procedures, and development workflow, see [BUILDING.md](BUILDING.md).

## Architecture

Fezinator is structured as a modular Rust application:

- **CLI Module**: Command-line interface using `clap`
- **Extractor Module**: ELF parsing and assembly extraction using `object` crate
- **Database Module**: SQLite operations using `rusqlite`
- **Error Module**: Comprehensive error handling with `thiserror`

## Contributing

1. Read [BUILDING.md](BUILDING.md) for development setup
2. Install the pre-commit hooks: `./scripts/install-hooks.sh`
3. Make your changes
4. Run quality checks: `make check`
5. Submit a pull request

## Security

Fezinator includes several security measures:

- **Dependency Auditing**: Automated vulnerability scanning
- **Unsafe Code Detection**: Tracks unsafe code usage
- **Input Validation**: Robust ELF file parsing with error handling
- **Memory Safety**: Pure Rust implementation with minimal unsafe code

## License

[License information to be added]

## Acknowledgments

- Built with the excellent Rust ecosystem
- Uses the `object` crate for ELF parsing
- Inspired by binary analysis research needs