# Fezinator

A framework for extracting and analyzing assembly code blocks from ELF and PE binaries.

## Overview

Fezinator is a Rust-based command-line tool that provides a git-like interface for extracting random assembly code blocks from ELF (Linux) and PE (Windows) binaries. It stores extracted data in an SQLite database for analysis and research purposes.

## Features

- **Multi-Format Support**: Supports both ELF (Linux) and PE (Windows) binary formats
- **Architecture Support**: Works with x86, x86_64, ARM, and AArch64 architectures
- **Random Extraction**: Selects random code blocks from executable sections
- **Smart Storage**: SQLite database with deduplication and metadata tracking  
- **Format Detection**: Automatically detects binary format and rejects unsupported types
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

The `extract` command analyzes an ELF or PE binary and extracts a random assembly code block:

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
- Binary format (ELF or PE)
- Architecture (x86, x86_64, ARM, AArch64)
- Endianness (little or big)
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
    format TEXT NOT NULL,
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
[INFO] Binary info: BinaryInfo { path: "/bin/ls", size: 142312, hash: "a1b2c3...", format: "ELF", architecture: "x86_64", endianness: "little" }
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

### Format Detection

```bash
# Automatically detects and supports ELF files
$ fezinator extract /bin/ls
# Success: ELF format detected and processed

# Automatically detects and supports PE files  
$ fezinator extract program.exe
# Success: PE format detected and processed

# Rejects unsupported formats with clear error messages
$ fezinator extract script.sh
# Error: Unknown or unsupported binary format. Only ELF and PE formats are supported.

$ fezinator extract archive.zip
# Error: Binary parsing error: ...
```

## Requirements

- Rust 1.70 or later
- Supported binary formats: ELF (Linux), PE (Windows)
- Supported architectures: x86, x86_64, ARM, AArch64
- GCC (for compiling test binaries during development)

## Building and Development

For detailed building instructions, testing procedures, and development workflow, see [BUILDING.md](BUILDING.md).

## Architecture

Fezinator is structured as a modular Rust application:

- **CLI Module**: Command-line interface using `clap`
- **Extractor Module**: ELF parsing and assembly extraction using `object` crate
- **Database Module**: SQLite operations using `rusqlite`
- **Error Module**: Comprehensive error handling with `thiserror`

## Cross-Platform Testing

Fezinator supports cross-platform testing to compare native execution on Intel/AMD64 with emulated execution on ARM64 using FEX-Emu. This enables testing and validation of x86/x86_64 assembly blocks across different host architectures.

### Export/Import Workflow

The export/import system allows you to share simulation results between different machines:

#### 1. Extract and Simulate on Intel Machine

```bash
# Extract assembly blocks from binaries
fezinator extract /path/to/binary

# Analyze the extracted blocks
fezinator analyze 1

# Run simulations natively on Intel
fezinator simulate 1 --emulator native

# Export results for cross-platform comparison
fezinator export --block 1 --output block1_intel.json
```

#### 2. Transfer and Import on ARM64 Machine

```bash
# Transfer the JSON file to ARM64 machine
scp block1_intel.json arm64-host:~/

# On ARM64 machine, import the results
fezinator import-results block1_intel.json

# Run simulations with FEX-Emu
fezinator simulate 1 --emulator fex-emu

# Compare native Intel vs FEX-Emu results
fezinator compare 1 --emulators native,fex-emu --detailed-registers
```

### Available Commands

#### Export Command

Export simulation data to JSON format for cross-platform sharing:

```bash
# Export a specific block
fezinator export --block 1 --output results.json

# Export all blocks
fezinator export --output full_database.json

# Export only blocks with simulations
fezinator export --simulated-only --output simulated_blocks.json
```

#### Import Results Command

Import simulation data from another machine:

```bash
# Import all data from JSON
fezinator import-results results.json

# Import only simulations (skip binaries/extractions)
fezinator import-results --simulations-only results.json

# Skip importing simulations for blocks that already have them
fezinator import-results --skip-existing-simulations results.json

# Dry run to see what would be imported
fezinator import-results --dry-run results.json
```

#### Compare Command

Compare simulation results across different emulators:

```bash
# Basic comparison
fezinator compare 1

# Filter by specific emulators
fezinator compare 1 --emulators native,fex-emu

# Show detailed register differences
fezinator compare 1 --detailed-registers --detailed-memory

# Export comparison to JSON
fezinator compare 1 --export-json comparison_report.json
```

### Host Information Tracking

Fezinator automatically tracks host information in simulation results:

- **Host Architecture**: x86_64, aarch64, etc.
- **Machine ID**: Hostname or generated identifier
- **Emulator Used**: native@x86_64#intel-dev-001, fex-emu@aarch64#arm-server-001

This enables precise identification of where each simulation was performed.

### Example Workflow

```bash
# Intel machine workflow
fezinator extract /bin/ls
fezinator analyze 1
fezinator simulate 1 --emulator native
fezinator export --block 1 --output ls_intel.json

# ARM64 machine workflow
fezinator import-results ls_intel.json
fezinator simulate 1 --emulator fex-emu
fezinator compare 1 --emulators native,fex-emu

# Output shows:
# ✓ Exit codes match: ✓
# ✓ Flags match: ✓
# ✓ Registers match: ✗ (3 differences)
# ✓ Overall consensus: ✗ FAIL
```

This workflow enables systematic testing of FEX-Emu compatibility and performance against native execution.

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