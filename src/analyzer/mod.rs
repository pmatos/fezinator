use anyhow::{anyhow, Result};
use capstone::prelude::*;
use capstone::{Capstone, Insn, InsnGroupId};
use serde::{Deserialize, Serialize};
use std::collections::HashSet;

#[derive(Debug, Clone)]
pub struct BlockAnalysis {
    pub live_in_registers: HashSet<String>,
    pub live_out_registers: HashSet<String>,
    pub exit_points: Vec<ExitPoint>,
    pub memory_accesses: Vec<MemoryAccess>,
    pub instructions_count: usize,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ExitPoint {
    pub offset: u64,
    pub exit_type: ExitType,
    pub target: Option<u64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum ExitType {
    FallThrough,       // Normal sequential execution
    UnconditionalJump, // JMP
    ConditionalJump,   // Jcc
    Call,              // CALL
    Return,            // RET
    IndirectJump,      // JMP [reg] or JMP [mem]
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MemoryAccess {
    pub offset: u64,
    pub access_type: AccessType,
    pub size: usize,
    pub is_stack: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum AccessType {
    Read,
    Write,
    ReadWrite,
}

pub struct Analyzer {
    architecture: String,
}

impl Analyzer {
    pub fn new(architecture: &str) -> Self {
        Analyzer {
            architecture: architecture.to_string(),
        }
    }

    pub fn analyze_block(&self, code: &[u8], base_address: u64) -> Result<BlockAnalysis> {
        let cs = self.create_capstone()?;

        let insns = cs
            .disasm_all(code, base_address)
            .map_err(|e| anyhow!("Failed to disassemble: {}", e))?;

        let mut analysis = BlockAnalysis {
            live_in_registers: HashSet::new(),
            live_out_registers: HashSet::new(),
            exit_points: Vec::new(),
            memory_accesses: Vec::new(),
            instructions_count: insns.len(),
        };

        let mut read_regs = HashSet::new();
        let mut written_regs = HashSet::new();
        let mut last_offset = base_address;

        for insn in insns.iter() {
            last_offset = insn.address() + insn.bytes().len() as u64;

            // Analyze registers
            self.analyze_registers(&cs, insn, &mut read_regs, &mut written_regs)?;

            // Analyze control flow
            if let Some(exit) = self.analyze_control_flow(
                &cs,
                insn,
                base_address,
                base_address + code.len() as u64,
            )? {
                analysis.exit_points.push(exit);
            }

            // Analyze memory accesses
            if let Some(mem_access) = self.analyze_memory_access(&cs, insn)? {
                analysis.memory_accesses.push(mem_access);
            }
        }

        // Calculate live-in registers (read before written)
        for reg in &read_regs {
            if !written_regs.contains(reg) {
                analysis.live_in_registers.insert(reg.clone());
            }
        }

        // All written registers are potentially live-out
        analysis.live_out_registers = written_regs;

        // If no explicit exit found, it falls through
        if analysis.exit_points.is_empty() {
            analysis.exit_points.push(ExitPoint {
                offset: last_offset,
                exit_type: ExitType::FallThrough,
                target: None,
            });
        }

        Ok(analysis)
    }

    fn create_capstone(&self) -> Result<Capstone> {
        let cs = match self.architecture.as_str() {
            "x86" | "i386" => Capstone::new()
                .x86()
                .mode(arch::x86::ArchMode::Mode32)
                .detail(true)
                .build()
                .map_err(|e| anyhow!("Failed to create x86 capstone: {}", e))?,
            "x86_64" => Capstone::new()
                .x86()
                .mode(arch::x86::ArchMode::Mode64)
                .detail(true)
                .build()
                .map_err(|e| anyhow!("Failed to create x86_64 capstone: {}", e))?,
            _ => {
                return Err(anyhow!(
                "Unsupported architecture: {}. Only x86 and x86_64 architectures are supported.",
                self.architecture
            ))
            }
        };

        Ok(cs)
    }

    fn analyze_registers(
        &self,
        _cs: &Capstone,
        insn: &Insn,
        read_regs: &mut HashSet<String>,
        written_regs: &mut HashSet<String>,
    ) -> Result<()> {
        let mnemonic = insn.mnemonic().unwrap_or("");
        let operands = insn.op_str().unwrap_or("");

        // Manual register analysis since capstone's register detection isn't reliable
        self.analyze_registers_manual(mnemonic, operands, read_regs, written_regs)?;

        Ok(())
    }

    fn analyze_registers_manual(
        &self,
        mnemonic: &str,
        operands: &str,
        read_regs: &mut HashSet<String>,
        written_regs: &mut HashSet<String>,
    ) -> Result<()> {
        // Split operands by comma
        let ops: Vec<&str> = operands.split(',').map(|s| s.trim()).collect();

        match mnemonic {
            "mov" | "movzx" | "movsx" => {
                // mov dst, src - dst is written, src is read
                if ops.len() >= 2 {
                    // Handle destination
                    if ops[0].contains('[') && ops[0].contains(']') {
                        // Memory destination - extract addressing registers as read
                        self.extract_read_registers(ops[0], read_regs);
                    } else {
                        // Register destination - mark as written
                        self.extract_written_registers(ops[0], written_regs);
                    }

                    // Handle source - always read
                    self.extract_read_registers(ops[1], read_regs);
                }
            }
            "add" | "sub" | "and" | "or" | "xor" => {
                // op dst, src - dst is read and written, src is read
                if ops.len() >= 2 {
                    self.extract_read_registers(ops[0], read_regs); // read before modify
                    self.extract_written_registers(ops[0], written_regs); // written after
                    self.extract_read_registers(ops[1], read_regs);
                }
                // These also affect flags
                written_regs.insert("rflags".to_string());
            }
            "cmp" | "test" => {
                // cmp/test op1, op2 - both operands are read, flags written
                for op in &ops {
                    self.extract_read_registers(op, read_regs);
                }
                written_regs.insert("rflags".to_string());
            }
            "inc" | "dec" | "neg" | "not" => {
                // unary operations - operand is read and written
                if !ops.is_empty() {
                    self.extract_read_registers(ops[0], read_regs);
                    self.extract_written_registers(ops[0], written_regs);
                }
                if mnemonic != "not" {
                    // not doesn't affect flags
                    written_regs.insert("rflags".to_string());
                }
            }
            "jz" | "jnz" | "je" | "jne" | "jl" | "jle" | "jg" | "jge" | "js" | "jns" | "jc"
            | "jnc" | "jo" | "jno" => {
                // conditional jumps read flags
                read_regs.insert("rflags".to_string());
            }
            "push" => {
                // push src - src is read, rsp is read and written
                if !ops.is_empty() {
                    self.extract_read_registers(ops[0], read_regs);
                }
                read_regs.insert("rsp".to_string());
                written_regs.insert("rsp".to_string());
            }
            "pop" => {
                // pop dst - dst is written, rsp is read and written
                if !ops.is_empty() {
                    self.extract_written_registers(ops[0], written_regs);
                }
                read_regs.insert("rsp".to_string());
                written_regs.insert("rsp".to_string());
            }
            "call" => {
                // call affects rsp and potentially many registers
                read_regs.insert("rsp".to_string());
                written_regs.insert("rsp".to_string());
                // Conservative: assume call can modify rax, rcx, rdx (caller-saved)
                written_regs.insert("rax".to_string());
                written_regs.insert("rcx".to_string());
                written_regs.insert("rdx".to_string());
            }
            "ret" => {
                // ret reads rsp and rax (return value)
                read_regs.insert("rsp".to_string());
                read_regs.insert("rax".to_string());
                written_regs.insert("rsp".to_string());
            }
            "lea" => {
                // lea dst, src - dst is written, registers in src are read
                if ops.len() >= 2 {
                    self.extract_written_registers(ops[0], written_regs);
                    self.extract_read_registers(ops[1], read_regs);
                }
            }
            _ => {
                // For unknown instructions, conservatively analyze operands
                for (i, op) in ops.iter().enumerate() {
                    if i == 0 {
                        // First operand is usually destination (written)
                        self.extract_written_registers(op, written_regs);
                    }
                    // All operands are potentially read
                    self.extract_read_registers(op, read_regs);
                }
            }
        }

        Ok(())
    }

    fn extract_read_registers(&self, operand: &str, read_regs: &mut HashSet<String>) {
        // Extract register names from operand string
        for reg in self.find_registers_in_operand(operand) {
            read_regs.insert(reg);
        }
    }

    fn extract_written_registers(&self, operand: &str, written_regs: &mut HashSet<String>) {
        // For memory operands like [reg], the register is read, not written
        if operand.contains('[') && operand.contains(']') {
            // Memory reference - this is a memory write, not a register write
            // The addressing registers should be handled separately
        } else {
            // Direct register operand
            for reg in self.find_registers_in_operand(operand) {
                written_regs.insert(reg);
            }
        }
    }

    fn find_registers_in_operand(&self, operand: &str) -> Vec<String> {
        let mut registers = Vec::new();

        // List of x86/x86_64 registers to look for
        let reg_patterns = [
            // 64-bit registers
            "rax", "rbx", "rcx", "rdx", "rsi", "rdi", "rbp", "rsp", "r8", "r9", "r10", "r11", "r12",
            "r13", "r14", "r15", // 32-bit registers
            "eax", "ebx", "ecx", "edx", "esi", "edi", "ebp", "esp", // 16-bit registers
            "ax", "bx", "cx", "dx", "si", "di", "bp", "sp", // 8-bit registers
            "al", "bl", "cl", "dl", "ah", "bh", "ch", "dh",
        ];

        let operand_lower = operand.to_lowercase();

        for &reg in &reg_patterns {
            if operand_lower.contains(reg) {
                // Check if it's a whole word (not part of another word)
                if let Some(start) = operand_lower.find(reg) {
                    let end = start + reg.len();
                    let before_ok = start == 0
                        || !operand_lower
                            .chars()
                            .nth(start - 1)
                            .unwrap()
                            .is_alphanumeric();
                    let after_ok = end >= operand_lower.len()
                        || !operand_lower.chars().nth(end).unwrap().is_alphanumeric();

                    if before_ok && after_ok {
                        // Normalize to canonical form (prefer 64-bit names)
                        let canonical = self.normalize_register_to_64bit(reg);
                        if !registers.contains(&canonical) {
                            registers.push(canonical);
                        }
                    }
                }
            }
        }

        registers
    }

    fn normalize_register_to_64bit(&self, reg: &str) -> String {
        match reg {
            "eax" | "ax" | "al" | "ah" => "rax".to_string(),
            "ebx" | "bx" | "bl" | "bh" => "rbx".to_string(),
            "ecx" | "cx" | "cl" | "ch" => "rcx".to_string(),
            "edx" | "dx" | "dl" | "dh" => "rdx".to_string(),
            "esi" | "si" => "rsi".to_string(),
            "edi" | "di" => "rdi".to_string(),
            "ebp" | "bp" => "rbp".to_string(),
            "esp" | "sp" => "rsp".to_string(),
            _ => reg.to_string(), // Already 64-bit or other register
        }
    }

    fn analyze_control_flow(
        &self,
        cs: &Capstone,
        insn: &Insn,
        block_start: u64,
        block_end: u64,
    ) -> Result<Option<ExitPoint>> {
        let detail = cs
            .insn_detail(insn)
            .map_err(|e| anyhow!("Failed to get instruction details: {}", e))?;
        let groups = detail.groups();

        // Check if it's a jump
        if groups.contains(&InsnGroupId(7)) {
            // CS_GRP_JUMP
            let exit_type = if insn.mnemonic() == Some("jmp") {
                ExitType::UnconditionalJump
            } else {
                ExitType::ConditionalJump
            };

            // Try to get jump target
            let target = self.get_jump_target(cs, insn);

            // Check if jump is within block
            if let Some(tgt) = target {
                if tgt >= block_start && tgt < block_end {
                    // Jump within block, not an exit
                    return Ok(None);
                }
            }

            return Ok(Some(ExitPoint {
                offset: insn.address(),
                exit_type,
                target,
            }));
        }

        // Check if it's a call
        if groups.contains(&InsnGroupId(2)) {
            // CS_GRP_CALL
            return Ok(Some(ExitPoint {
                offset: insn.address(),
                exit_type: ExitType::Call,
                target: self.get_jump_target(cs, insn),
            }));
        }

        // Check if it's a return
        if groups.contains(&InsnGroupId(3)) {
            // CS_GRP_RET
            return Ok(Some(ExitPoint {
                offset: insn.address(),
                exit_type: ExitType::Return,
                target: None,
            }));
        }

        Ok(None)
    }

    fn get_jump_target(&self, _cs: &Capstone, insn: &Insn) -> Option<u64> {
        // For now, we'll use the instruction operand string to extract jump targets
        // This is a simplified approach
        let op_str = insn.op_str()?;

        // Try to parse hex address (0x...)
        if let Some(hex_start) = op_str.find("0x") {
            let hex_str = &op_str[hex_start + 2..];
            let end = hex_str
                .find(|c: char| !c.is_ascii_hexdigit())
                .unwrap_or(hex_str.len());
            if let Ok(addr) = u64::from_str_radix(&hex_str[..end], 16) {
                return Some(addr);
            }
        }

        None
    }

    fn analyze_memory_access(&self, _cs: &Capstone, insn: &Insn) -> Result<Option<MemoryAccess>> {
        // Simplified memory access detection based on operand string
        let op_str = insn.op_str().unwrap_or("");

        // Check if instruction has memory operand (contains [])
        if !op_str.contains('[') || !op_str.contains(']') {
            return Ok(None);
        }

        // Check if it's a stack access
        let is_stack = op_str.contains("esp")
            || op_str.contains("rsp")
            || op_str.contains("ebp")
            || op_str.contains("rbp");

        // Determine access type based on instruction
        let mnemonic = insn.mnemonic().unwrap_or("");
        let access_type = match mnemonic {
            "mov" | "movzx" | "movsx" => {
                // mov dest, src - if memory is first operand, it's a write
                if op_str.find('[').unwrap_or(usize::MAX) < op_str.find(',').unwrap_or(usize::MAX) {
                    AccessType::Write
                } else {
                    AccessType::Read
                }
            }
            "lea" | "cmp" | "test" => AccessType::Read,
            "push" | "call" => AccessType::Write,
            "pop" | "ret" => AccessType::Read,
            _ if mnemonic.starts_with("st") => AccessType::Write, // store instructions
            _ if mnemonic.starts_with("ld") => AccessType::Read,  // load instructions
            _ => AccessType::ReadWrite,                           // conservative default
        };

        // Estimate size based on instruction suffix or default
        let size = match mnemonic.chars().last() {
            Some('b') => 1,
            Some('w') => 2,
            Some('d') => 4,
            Some('q') => 8,
            _ => 4, // default to 32-bit
        };

        Ok(Some(MemoryAccess {
            offset: insn.address(),
            access_type,
            size,
            is_stack,
        }))
    }
}
