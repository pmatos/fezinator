use super::state::InitialState;
use crate::analyzer::BlockAnalysis;
use crate::db::ExtractionInfo;
use crate::error::{Error, Result};

pub struct AssemblyGenerator {
    #[allow(dead_code)]
    pub target_arch: String,
}

impl AssemblyGenerator {
    pub fn new() -> Self {
        Self {
            target_arch: "x86_64".to_string(),
        }
    }

    pub fn generate_simulation_file(
        &self,
        extraction: &ExtractionInfo,
        analysis: &BlockAnalysis,
        initial_state: &InitialState,
    ) -> Result<String> {
        let mut assembly = String::new();

        // File header
        assembly.push_str("; Generated assembly file for block simulation\n");
        assembly.push_str(&format!(
            "; Block: 0x{:08x} - 0x{:08x}\n",
            extraction.start_address, extraction.end_address
        ));
        assembly.push_str(&format!(
            "; Architecture: {}\n",
            extraction.binary_architecture
        ));
        assembly.push('\n');

        // Assembly directives
        assembly.push_str("BITS 64\n");
        assembly.push_str("SECTION .data\n");
        assembly.push_str("    ; Output buffer for register/memory state\n");
        assembly.push_str("    output_buffer times 4096 db 0\n");
        assembly.push('\n');
        assembly.push_str("SECTION .text\n");
        assembly.push_str("    global _start\n");
        assembly.push('\n');
        assembly.push_str("_start:\n");

        // Generate preamble
        assembly.push_str(&self.generate_preamble(initial_state)?);

        // Generate the actual block code
        assembly.push_str(&self.generate_block_code(extraction)?);

        // Generate epilogue
        assembly.push_str(&self.generate_epilogue(analysis)?);

        Ok(assembly)
    }

    fn generate_preamble(&self, initial_state: &InitialState) -> Result<String> {
        let mut preamble = String::new();

        preamble.push_str("    ; === PREAMBLE: Set up initial state ===\n");

        // Set up registers
        for (reg, value) in &initial_state.registers {
            preamble.push_str(&format!("    mov {reg}, 0x{value:016x}\n"));
        }

        // Set up stack values
        for (i, value) in initial_state.stack_setup.iter().enumerate() {
            let offset = (i + 1) * 8;
            preamble.push_str(&format!("    mov qword [rsp-{offset}], 0x{value:016x}\n"));
        }

        // Set up memory locations
        for (addr, data) in &initial_state.memory_locations {
            match data.len() {
                1 => preamble.push_str(&format!(
                    "    mov byte [0x{addr:016x}], 0x{:02x}\n",
                    data[0]
                )),
                2 => preamble.push_str(&format!(
                    "    mov word [0x{addr:016x}], 0x{:04x}\n",
                    u16::from_le_bytes([data[0], data[1]])
                )),
                4 => preamble.push_str(&format!(
                    "    mov dword [0x{addr:016x}], 0x{:08x}\n",
                    u32::from_le_bytes([data[0], data[1], data[2], data[3]])
                )),
                8 => preamble.push_str(&format!(
                    "    mov qword [0x{addr:016x}], 0x{:016x}\n",
                    u64::from_le_bytes([
                        data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7]
                    ])
                )),
                _ => {
                    // For larger data, write byte by byte
                    for (i, byte) in data.iter().enumerate() {
                        preamble.push_str(&format!(
                            "    mov byte [0x{:016x}], 0x{byte:02x}\n",
                            addr + i as u64
                        ));
                    }
                }
            }
        }

        preamble.push('\n');
        preamble.push_str("    ; === EXTRACTED BLOCK CODE ===\n");

        Ok(preamble)
    }

    fn generate_block_code(&self, extraction: &ExtractionInfo) -> Result<String> {
        let mut block_code = String::new();

        // Disassemble the block to generate assembly code
        let disassembled = self.disassemble_block(&extraction.assembly_block)?;

        for instruction in disassembled {
            // Convert Intel syntax to NASM syntax
            let nasm_instruction = self.convert_to_nasm_syntax(&instruction);
            block_code.push_str(&format!("    {nasm_instruction}\n"));
        }

        block_code.push('\n');

        Ok(block_code)
    }

    fn disassemble_block(&self, block: &[u8]) -> Result<Vec<String>> {
        use capstone::prelude::*;

        let cs = Capstone::new()
            .x86()
            .mode(arch::x86::ArchMode::Mode64)
            .syntax(arch::x86::ArchSyntax::Intel)
            .detail(true)
            .build()
            .map_err(|e| Error::Simulation(format!("Failed to create disassembler: {e}")))?;

        let insns = cs
            .disasm_all(block, 0x1000)
            .map_err(|e| Error::Simulation(format!("Failed to disassemble block: {e}")))?;

        let mut instructions = Vec::new();
        for insn in insns.iter() {
            let mnemonic = insn.mnemonic().unwrap_or("unknown");
            let op_str = insn.op_str().unwrap_or("");

            if op_str.is_empty() {
                instructions.push(mnemonic.to_string());
            } else {
                instructions.push(format!("{mnemonic} {op_str}"));
            }
        }

        Ok(instructions)
    }

    fn generate_epilogue(&self, _analysis: &BlockAnalysis) -> Result<String> {
        let mut epilogue = String::new();

        epilogue.push_str("    ; === EPILOGUE: Capture final state ===\n");

        // Store all registers to output buffer
        let registers = [
            "rax", "rbx", "rcx", "rdx", "rsi", "rdi", "rbp", "rsp", "r8", "r9", "r10", "r11",
            "r12", "r13", "r14", "r15",
        ];

        for (i, reg) in registers.iter().enumerate() {
            let offset = i * 8;
            epilogue.push_str(&format!(
                "    mov qword [output_buffer + {offset}], {reg}\n"
            ));
        }

        // Store flags
        epilogue.push_str("    pushfq\n");
        epilogue.push_str("    pop rax\n");
        epilogue.push_str("    mov qword [output_buffer + 128], rax\n");

        // Store memory locations (we'll store them starting at offset 256)
        let mut memory_offset = 256;

        // For now, we'll store stack values as a simple example
        for i in 1..=8 {
            let stack_offset = i * 8;
            epilogue.push_str(&format!("    mov rax, qword [rsp-{stack_offset}]\n"));
            epilogue.push_str(&format!("    mov [output_buffer + {memory_offset}], rax\n"));
            epilogue.push_str(&format!(
                "    mov qword [output_buffer + {}], 0x{:016x}\n",
                memory_offset + 8,
                8u64
            )); // Size
            memory_offset += 16;
        }

        // Add end marker
        epilogue.push_str(&format!(
            "    mov qword [output_buffer + {memory_offset}], 0\n"
        ));
        epilogue.push_str(&format!(
            "    mov qword [output_buffer + {}], 0\n",
            memory_offset + 8
        ));

        // Write output buffer to stdout
        epilogue.push_str("    ; Write output buffer to stdout\n");
        epilogue.push_str("    mov rax, 1                    ; sys_write\n");
        epilogue.push_str("    mov rdi, 1                    ; stdout\n");
        epilogue.push_str("    mov rsi, output_buffer        ; buffer\n");
        epilogue.push_str("    mov rdx, 4096                 ; length\n");
        epilogue.push_str("    syscall\n");
        epilogue.push('\n');

        // Exit cleanly
        epilogue.push_str("    ; Exit cleanly\n");
        epilogue.push_str("    mov rax, 60                   ; sys_exit\n");
        epilogue.push_str("    mov rdi, 0                    ; exit code\n");
        epilogue.push_str("    syscall\n");

        Ok(epilogue)
    }

    fn convert_to_nasm_syntax(&self, instruction: &str) -> String {
        // Convert Intel syntax to NASM syntax
        let mut result = instruction.to_string();

        // Remove "ptr" keywords that NASM doesn't understand
        result = result.replace(" ptr ", " ");
        result = result.replace(" ptr,", ",");
        result = result.replace(",ptr ", ", ");

        // Handle specific Intel/NASM syntax differences
        result = result.replace("dword ptr [", "dword [");
        result = result.replace("qword ptr [", "qword [");
        result = result.replace("word ptr [", "word [");
        result = result.replace("byte ptr [", "byte [");

        // Handle memory references that might have complex expressions
        // This is a simplified approach - a full implementation would need more sophisticated parsing
        if result.contains("[") && result.contains("ptr") {
            result = result.replace(" ptr", "");
        }

        result
    }
}
