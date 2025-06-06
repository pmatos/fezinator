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
        cs: &Capstone,
        insn: &Insn,
        read_regs: &mut HashSet<String>,
        written_regs: &mut HashSet<String>,
    ) -> Result<()> {
        let detail = cs
            .insn_detail(insn)
            .map_err(|e| anyhow!("Failed to get instruction details: {}", e))?;

        // Get read registers
        let (regs_read, regs_write) = (detail.regs_read(), detail.regs_write());

        // Add registers to sets
        for &reg in regs_read {
            if let Some(reg_name) = cs.reg_name(reg) {
                read_regs.insert(reg_name);
            }
        }

        for &reg in regs_write {
            if let Some(reg_name) = cs.reg_name(reg) {
                written_regs.insert(reg_name);
            }
        }

        Ok(())
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
