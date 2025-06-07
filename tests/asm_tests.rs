use anyhow::{anyhow, Result};
use capstone::prelude::*;
use std::collections::HashSet;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;
use tempfile::TempDir;

use fezinator::analyzer::Analyzer;
use fezinator::extractor::Extractor;

#[derive(Debug, Clone)]
struct AsmTest {
    pub name: String,
    pub bits: u32,
    pub live_in: HashSet<String>,
    pub live_out: HashSet<String>,
    pub expected_exits: Vec<String>,
    pub expected_memory: Vec<MemoryExpectation>,
    pub assembly_code: String,
}

#[derive(Debug, Clone)]
struct MemoryExpectation {
    pub access_type: String, // "STORE", "LOAD", "RW"
    pub register: Option<String>,
}

impl AsmTest {
    fn parse_from_file(path: &Path) -> Result<Self> {
        let content = fs::read_to_string(path)?;
        let name = path
            .file_stem()
            .and_then(|s| s.to_str())
            .unwrap_or("unknown")
            .to_string();

        let mut bits = 64; // default
        let mut live_in = HashSet::new();
        let mut live_out = HashSet::new();
        let mut expected_exits = Vec::new();
        let mut expected_memory = Vec::new();
        let mut assembly_lines = Vec::new();

        for line in content.lines() {
            let line = line.trim();

            if line.starts_with("; BITS:") {
                bits = line
                    .trim_start_matches("; BITS:")
                    .trim()
                    .parse()
                    .map_err(|e| anyhow!("Invalid BITS value: {}", e))?;
            } else if line.starts_with("; LIVEIN:") {
                let regs = line.trim_start_matches("; LIVEIN:").trim();
                live_in = regs
                    .split(',')
                    .map(|s| s.trim().to_lowercase())
                    .filter(|s| !s.is_empty())
                    .collect();
            } else if line.starts_with("; LIVEOUT:") {
                let regs = line.trim_start_matches("; LIVEOUT:").trim();
                live_out = regs
                    .split(',')
                    .map(|s| s.trim().to_lowercase())
                    .filter(|s| !s.is_empty())
                    .collect();
            } else if line.starts_with("; EXITS:") {
                let exits = line.trim_start_matches("; EXITS:").trim();
                expected_exits = exits
                    .split(',')
                    .map(|s| s.trim().to_string())
                    .filter(|s| !s.is_empty())
                    .collect();
            } else if line.starts_with("; MEMORY:") {
                let mem_spec = line.trim_start_matches("; MEMORY:").trim();
                expected_memory.extend(Self::parse_memory_spec(mem_spec)?);
            } else if !line.starts_with(';') && !line.is_empty() {
                // Remove inline annotations from assembly code
                let clean_line = if let Some(comment_pos) = line.find(';') {
                    line[..comment_pos].trim()
                } else {
                    line
                };
                if !clean_line.is_empty() {
                    assembly_lines.push(clean_line.to_string());
                }
            }
        }

        let assembly_code = assembly_lines.join("\n");

        Ok(AsmTest {
            name,
            bits,
            live_in,
            live_out,
            expected_exits,
            expected_memory,
            assembly_code,
        })
    }

    fn parse_memory_spec(spec: &str) -> Result<Vec<MemoryExpectation>> {
        let mut expectations = Vec::new();

        for item in spec.split(',') {
            let item = item.trim();
            if item.is_empty() {
                continue;
            }

            let parts: Vec<&str> = item.split_whitespace().collect();
            if parts.len() >= 1 {
                let access_type = parts[0].to_uppercase();
                let register = if parts.len() > 1 {
                    Some(parts[1].to_lowercase())
                } else {
                    None
                };

                expectations.push(MemoryExpectation {
                    access_type,
                    register,
                });
            }
        }

        Ok(expectations)
    }

    fn create_nasm_file(&self) -> Result<String> {
        let mut nasm_content = String::new();

        // Add NASM directives
        nasm_content.push_str(&format!("BITS {}\n", self.bits));
        nasm_content.push_str("section .text\n");
        nasm_content.push_str("global _start\n");
        nasm_content.push_str("_start:\n");

        // Add the assembly code with proper indentation
        for line in self.assembly_code.lines() {
            if line.trim().ends_with(':') {
                // Label
                nasm_content.push_str(&format!("{}\n", line.trim()));
            } else {
                // Instruction
                nasm_content.push_str(&format!("    {}\n", line.trim()));
            }
        }

        // Add exit syscall for completeness
        if self.bits == 64 {
            nasm_content.push_str("    mov rax, 60\n"); // sys_exit
            nasm_content.push_str("    mov rdi, 0\n"); // exit status
            nasm_content.push_str("    syscall\n");
        } else {
            nasm_content.push_str("    mov eax, 1\n"); // sys_exit
            nasm_content.push_str("    mov ebx, 0\n"); // exit status
            nasm_content.push_str("    int 0x80\n");
        }

        Ok(nasm_content)
    }

    fn assemble_and_extract(&self) -> Result<(u64, u64, Vec<u8>)> {
        // Check if NASM is available
        if !Command::new("nasm").arg("--version").output().is_ok() {
            return Err(anyhow!(
                "NASM is not available. Please install NASM to run assembly tests."
            ));
        }

        let temp_dir = TempDir::new()?;
        let asm_file = temp_dir.path().join(format!("{}.asm", self.name));
        let obj_file = temp_dir.path().join(format!("{}.o", self.name));
        let elf_file = temp_dir.path().join(format!("{}", self.name));

        // Write NASM source
        let nasm_content = self.create_nasm_file()?;
        fs::write(&asm_file, nasm_content)?;

        // Assemble with NASM
        let output = Command::new("nasm")
            .args([
                "-f",
                if self.bits == 64 { "elf64" } else { "elf32" },
                "-o",
                obj_file.to_str().unwrap(),
                asm_file.to_str().unwrap(),
            ])
            .output()?;

        if !output.status.success() {
            return Err(anyhow!(
                "NASM assembly failed: {}",
                String::from_utf8_lossy(&output.stderr)
            ));
        }

        // Link to create executable
        let output = Command::new("ld")
            .args(["-o", elf_file.to_str().unwrap(), obj_file.to_str().unwrap()])
            .output()?;

        if !output.status.success() {
            return Err(anyhow!(
                "Linking failed: {}",
                String::from_utf8_lossy(&output.stderr)
            ));
        }

        // Extract the specific code block we care about
        let extractor = Extractor::new(elf_file.clone())?;

        // Parse the ELF to find the exact location of our code
        use object::{Object, ObjectSection};
        let data = std::fs::read(&elf_file)?;
        let obj_file = object::File::parse(&*data)?;

        // Find the .text section
        let text_section = obj_file
            .section_by_name(".text")
            .ok_or_else(|| anyhow!("No .text section found"))?;

        let section_data = text_section.data()?;
        let section_addr = text_section.address();

        // Create a disassembler to find our actual code (before the exit syscalls)
        let cs = match self.bits {
            64 => Capstone::new()
                .x86()
                .mode(arch::x86::ArchMode::Mode64)
                .detail(false)
                .build(),
            32 => Capstone::new()
                .x86()
                .mode(arch::x86::ArchMode::Mode32)
                .detail(false)
                .build(),
            _ => return Err(anyhow!("Unsupported architecture: {} bits", self.bits)),
        }
        .map_err(|e| anyhow!("Failed to create disassembler: {}", e))?;

        let insns = cs.disasm_all(section_data, section_addr)?;

        // Find the end of our test code (before the exit syscalls)
        // We look for the syscall instruction (or int 0x80 for 32-bit)
        let mut end_idx = insns.len();
        for (i, insn) in insns.iter().enumerate() {
            let mnemonic = insn.mnemonic().unwrap_or("");
            if mnemonic == "syscall" || (mnemonic == "int" && insn.op_str() == Some("0x80")) {
                // Also include the instructions setting up the syscall
                end_idx = i.saturating_sub(if self.bits == 64 { 2 } else { 2 }); // mov rax/eax, N; mov rdi/ebx, 0
                break;
            }
        }

        if end_idx == 0 {
            return Err(anyhow!("Could not find test code boundaries"));
        }

        // Extract from _start to just before the exit syscalls
        let start_addr = insns[0].address();
        let end_addr = if end_idx < insns.len() {
            insns[end_idx].address()
        } else {
            let last_insn = &insns[insns.len() - 1];
            last_insn.address() + last_insn.bytes().len() as u64
        };

        // Extract the exact range
        extractor.extract_range(start_addr, end_addr)
    }

    fn run_test(&self) -> Result<()> {
        println!("Running assembly test: {}", self.name);

        let (start_addr, end_addr, assembly_block) = self.assemble_and_extract()?;

        println!(
            "  Extracted block: 0x{:x} - 0x{:x} ({} bytes)",
            start_addr,
            end_addr,
            assembly_block.len()
        );
        println!(
            "  Raw bytes: {:02x?}",
            &assembly_block[..assembly_block.len().min(32)]
        );

        // Create analyzer
        let architecture = if self.bits == 64 { "x86_64" } else { "i386" };
        let analyzer = Analyzer::new(architecture);

        // First, let's see what instructions we actually extracted
        let cs = match self.bits {
            64 => Capstone::new()
                .x86()
                .mode(arch::x86::ArchMode::Mode64)
                .detail(false)
                .build(),
            32 => Capstone::new()
                .x86()
                .mode(arch::x86::ArchMode::Mode32)
                .detail(false)
                .build(),
            _ => return Err(anyhow!("Unsupported architecture: {} bits", self.bits)),
        }
        .map_err(|e| anyhow!("Failed to create disassembler: {}", e))?;

        let insns = cs
            .disasm_all(&assembly_block, start_addr)
            .map_err(|e| anyhow!("Failed to disassemble block: {}", e))?;

        println!("  Disassembled instructions:");
        for insn in insns.iter() {
            println!(
                "    0x{:x}: {} {}",
                insn.address(),
                insn.mnemonic().unwrap_or("?"),
                insn.op_str().unwrap_or("")
            );
        }

        // Analyze the block
        let analysis = analyzer.analyze_block(&assembly_block, start_addr)?;

        // Normalize register names for comparison
        let normalize_regs = |regs: &HashSet<String>| -> HashSet<String> {
            regs.iter()
                .map(|r| Self::normalize_register_name(r))
                .collect()
        };

        let actual_live_in = normalize_regs(&analysis.live_in_registers);
        let actual_live_out = normalize_regs(&analysis.live_out_registers);
        let expected_live_in = normalize_regs(&self.live_in);
        let expected_live_out = normalize_regs(&self.live_out);

        // Check live-in registers
        if actual_live_in != expected_live_in {
            return Err(anyhow!(
                "Live-in registers mismatch in test '{}'\nExpected: {:?}\nActual: {:?}",
                self.name,
                expected_live_in,
                actual_live_in
            ));
        }

        // Check live-out registers
        if actual_live_out != expected_live_out {
            return Err(anyhow!(
                "Live-out registers mismatch in test '{}'\nExpected: {:?}\nActual: {:?}",
                self.name,
                expected_live_out,
                actual_live_out
            ));
        }

        // TODO: Add checks for exits and memory accesses
        // This would require more sophisticated parsing of the expected results

        println!("✓ Assembly test '{}' passed", self.name);
        Ok(())
    }

    fn normalize_register_name(reg: &str) -> String {
        let reg = reg.to_lowercase();

        // Map register aliases to canonical names
        match reg.as_str() {
            "rflags" | "eflags" | "flags" => "rflags".to_string(),
            _ => reg,
        }
    }
}

fn find_asm_test_files() -> Vec<PathBuf> {
    let test_dir = Path::new("tests/asm");
    if !test_dir.exists() {
        return Vec::new();
    }

    let mut files = Vec::new();
    if let Ok(entries) = fs::read_dir(test_dir) {
        for entry in entries.flatten() {
            if let Some(ext) = entry.path().extension() {
                if ext == "asm" {
                    files.push(entry.path());
                }
            }
        }
    }

    files.sort();
    files
}

#[test]
fn test_asm_integration() {
    let test_files = find_asm_test_files();

    if test_files.is_empty() {
        println!("No assembly test files found in tests/asm/");
        return;
    }

    let mut passed = 0;
    let mut failed = 0;

    for test_file in test_files {
        match AsmTest::parse_from_file(&test_file) {
            Ok(test) => match test.run_test() {
                Ok(_) => passed += 1,
                Err(e) => {
                    eprintln!("❌ Test failed: {}", e);
                    failed += 1;
                }
            },
            Err(e) => {
                eprintln!("❌ Failed to parse test file {:?}: {}", test_file, e);
                failed += 1;
            }
        }
    }

    println!(
        "\nAssembly test results: {} passed, {} failed",
        passed, failed
    );

    if failed > 0 {
        panic!("Some assembly tests failed");
    }
}
