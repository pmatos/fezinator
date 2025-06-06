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

## Linting and Formatting

### Check Code Format
```bash
cargo fmt --check
```

### Format Code
```bash
cargo fmt
```

### Run Clippy Linter
```bash
cargo clippy -- -D warnings
```

### Run All Checks
```bash
cargo fmt --check && cargo clippy -- -D warnings && cargo test
```

## Development Workflow

Before committing any changes, ensure:

1. Code is properly formatted:
   ```bash
   cargo fmt
   ```

2. No linting warnings:
   ```bash
   cargo clippy -- -D warnings
   ```

3. All tests pass:
   ```bash
   cargo test
   ```

4. Release build succeeds:
   ```bash
   cargo build --release
   ```

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