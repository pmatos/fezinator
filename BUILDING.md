# Building Fezinator

This document describes how to build and test the Fezinator framework.

## Prerequisites

- Rust 1.70 or later
- Cargo (comes with Rust)
- GCC or Clang (for compiling test binaries)
- SQLite (bundled with rusqlite)

## Building

### Debug Build
```bash
cargo build
```

### Release Build
```bash
cargo build --release
```

The compiled binary will be located at:
- Debug: `target/debug/fezinator`
- Release: `target/release/fezinator`

## Testing

### Run All Tests
```bash
cargo test
```

### Run Unit Tests Only
```bash
cargo test --bins
```

### Run Integration Tests Only
```bash
cargo test --test integration_test
```

### Run Tests with Output
```bash
cargo test -- --nocapture
```

## Quality Assurance Tools

### Static Analysis Tools

Fezinator uses several complementary tools for code quality:

- **cargo-audit**: Security vulnerability scanner
- **cargo-machete**: Unused dependency detector  
- **cargo-outdated**: Outdated dependency checker
- **cargo-geiger**: Unsafe code detector

#### Install QA Tools
```bash
# Install all tools at once
make install-tools

# Or install individually
cargo install cargo-audit cargo-machete cargo-outdated cargo-geiger
```

### Formatting and Linting

#### Check Code Format
```bash
cargo fmt --check
```

#### Format Code
```bash
cargo fmt
```

#### Run Clippy Linter
```bash
cargo clippy -- -D warnings
```

### Security and Dependencies

#### Security Audit
```bash
cargo audit
```

#### Check for Unused Dependencies
```bash
cargo machete
```

#### Check for Outdated Dependencies
```bash
cargo outdated --root-deps-only
```

#### Check for Unsafe Code
```bash
cargo geiger --forbid-only
```

### Comprehensive Quality Checks

#### Using Make (Recommended)
```bash
# Run all quality checks
make check

# Run quick checks (no security scans)
make quick

# Run pre-commit checks
make pre-commit

# Run security checks only
make security

# Run dependency checks only
make deps
```

#### Using QA Script
```bash
# Run all checks
./scripts/qa.sh

# Run quick checks only
./scripts/qa.sh --quick

# Run security checks only
./scripts/qa.sh --security

# Run dependency checks only
./scripts/qa.sh --deps
```

### Pre-commit Hooks

Install git hooks to run checks automatically before commits:

```bash
./scripts/install-hooks.sh
```

The pre-commit hook runs:
- Code formatting (with auto-fix)
- Clippy lints
- Tests
- Build
- Security audit

To bypass for a specific commit:
```bash
git commit --no-verify
```

## Development Workflow

Before committing any changes, run:

```bash
# Recommended: use make for comprehensive checks
make pre-commit

# Or use the QA script
./scripts/qa.sh --quick

# Or run individual commands
cargo fmt
cargo clippy -- -D warnings
cargo test
cargo build --release
```

The pre-commit hook will automatically run these checks if installed.

## Common Issues

### Test Binary Compilation Fails
Integration tests require GCC to compile test binaries. Ensure GCC is installed:
- Ubuntu/Debian: `sudo apt-get install gcc`
- macOS: `xcode-select --install`
- Arch Linux: `sudo pacman -S gcc`

### SQLite Errors
The project uses bundled SQLite, but if you encounter issues:
- Ensure you have development headers: `sudo apt-get install libsqlite3-dev` (Ubuntu/Debian)
- Or use system SQLite by removing `"bundled"` feature from `rusqlite` in `Cargo.toml`