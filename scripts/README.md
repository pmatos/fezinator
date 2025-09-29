# Fezinator Scripts

This directory contains auxiliary scripts for working with fezinator.

## analyze-asm.py

A Python utility that assembles an assembly file and analyzes it with fezinator without leaving database traces.

### Usage

```bash
# Analyze 64-bit assembly
python3 scripts/analyze-asm.py --64 example.asm

# Analyze 32-bit assembly  
python3 scripts/analyze-asm.py --32 example.asm

# Verbose output
python3 scripts/analyze-asm.py --64 example.asm --verbose
```

### Features

- **Automatic Assembly**: Uses NASM to assemble your code with proper ELF preamble
- **Clean Analysis**: Uses temporary databases, leaves no traces in your main database
- **Cross-Platform**: Supports both 32-bit and 64-bit x86 architectures
- **Error Handling**: Comprehensive error checking and user-friendly messages
- **Verbose Mode**: Optional detailed output for debugging

### Requirements

- Python 3.6+
- NASM assembler (`sudo apt install nasm`)
- ld linker (usually pre-installed)
- fezinator binary (built with `cargo build --release`)

### Examples

**Simple assembly code:**
```asm
; example.asm
mov rax, 42
add rax, 10
mov rbx, rax
```

```bash
$ python3 scripts/analyze-asm.py --64 example.asm
Analyzing block #1...
  Binary: /tmp/fezinator_analyze_xyz/input
  Address range: 0x00401000 - 0x00401016

Analysis Results:
=================
Instructions: 5

Live-in Registers (0):
  <none>

Live-out Registers (4):
  - rax
  - rbx
  - rdi
  - rflags

Exit Points (1):
  - 0x00401016: Fall through

Memory Accesses (0):
  <none>

✓ Analysis completed and stored successfully
```

**Memory operations:**
```asm
; memory.asm
mov rax, [rsi]
add rax, 10
mov [rdi], rax
```

This will show memory access analysis including load and store operations.

### How It Works

1. **Preprocessing**: Adds NASM preamble with proper section headers and exit syscalls
2. **Assembly**: Uses NASM to create object file with correct architecture
3. **Linking**: Links object file into ELF executable with proper architecture flags
4. **Extraction**: Uses fezinator to extract the entire code section as a block
5. **Analysis**: Analyzes the block and displays results
6. **Cleanup**: Automatically removes all temporary files and databases

The script operates entirely in temporary directories and uses temporary database files, ensuring no interference with your main fezinator database.