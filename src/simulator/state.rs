use crate::error::{Error, Result};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

const OUTPUT_BUFFER_SIZE: usize = 4096;
const REGISTER_SECTION_SIZE: usize = 128;
const FLAGS_SECTION_SIZE: usize = 8;
const MEMORY_SECTION_OFFSET: usize = 256;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct InitialState {
    pub registers: HashMap<String, u64>,
    pub memory_locations: HashMap<u64, Vec<u8>>,
    pub stack_setup: Vec<u64>,
}

impl Default for InitialState {
    fn default() -> Self {
        Self::new()
    }
}

impl InitialState {
    pub fn new() -> Self {
        Self {
            registers: HashMap::new(),
            memory_locations: HashMap::new(),
            stack_setup: Vec::new(),
        }
    }

    pub fn set_register(&mut self, name: &str, value: u64) {
        self.registers.insert(name.to_string(), value);
    }

    pub fn set_memory(&mut self, address: u64, data: Vec<u8>) {
        self.memory_locations.insert(address, data);
    }

    pub fn add_stack_value(&mut self, value: u64) {
        self.stack_setup.push(value);
    }

    #[allow(dead_code)]
    pub fn get_register(&self, name: &str) -> Option<u64> {
        self.registers.get(name).copied()
    }

    #[allow(dead_code)]
    pub fn get_memory(&self, address: u64) -> Option<&Vec<u8>> {
        self.memory_locations.get(&address)
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FinalState {
    pub registers: HashMap<String, u64>,
    pub flags: u64,
    pub memory_locations: HashMap<u64, Vec<u8>>,
}

impl Default for FinalState {
    fn default() -> Self {
        Self::new()
    }
}

impl FinalState {
    pub fn new() -> Self {
        Self {
            registers: HashMap::new(),
            flags: 0,
            memory_locations: HashMap::new(),
        }
    }

    pub fn parse_from_output(output: &[u8]) -> Result<Self> {
        // Validate buffer size with proper bounds checking
        if output.len() < OUTPUT_BUFFER_SIZE {
            return Err(Error::Simulation(format!(
                "Output buffer too small: {} bytes, expected at least {} bytes",
                output.len(),
                OUTPUT_BUFFER_SIZE
            )));
        }

        let mut state = FinalState::new();

        // Parse registers (first 16 * 8 = 128 bytes)
        let register_names = [
            "rax", "rbx", "rcx", "rdx", "rsi", "rdi", "rbp", "rsp", "r8", "r9", "r10", "r11",
            "r12", "r13", "r14", "r15",
        ];

        for (i, &name) in register_names.iter().enumerate() {
            let offset = i * 8;
            if offset + 8 <= output.len() {
                let value = u64::from_le_bytes([
                    output[offset],
                    output[offset + 1],
                    output[offset + 2],
                    output[offset + 3],
                    output[offset + 4],
                    output[offset + 5],
                    output[offset + 6],
                    output[offset + 7],
                ]);
                state.registers.insert(name.to_string(), value);
            }
        }

        // Parse flags (at offset 128)
        if output.len() >= REGISTER_SECTION_SIZE + FLAGS_SECTION_SIZE {
            state.flags = u64::from_le_bytes([
                output[REGISTER_SECTION_SIZE],
                output[REGISTER_SECTION_SIZE + 1],
                output[REGISTER_SECTION_SIZE + 2],
                output[REGISTER_SECTION_SIZE + 3],
                output[REGISTER_SECTION_SIZE + 4],
                output[REGISTER_SECTION_SIZE + 5],
                output[REGISTER_SECTION_SIZE + 6],
                output[REGISTER_SECTION_SIZE + 7],
            ]);
        }

        // Parse memory locations (starting at offset 256)
        // Memory locations are stored as address:size:data triplets
        let mut offset = MEMORY_SECTION_OFFSET;
        while offset + 16 <= output.len() {
            let address = u64::from_le_bytes([
                output[offset],
                output[offset + 1],
                output[offset + 2],
                output[offset + 3],
                output[offset + 4],
                output[offset + 5],
                output[offset + 6],
                output[offset + 7],
            ]);

            let size = u64::from_le_bytes([
                output[offset + 8],
                output[offset + 9],
                output[offset + 10],
                output[offset + 11],
                output[offset + 12],
                output[offset + 13],
                output[offset + 14],
                output[offset + 15],
            ]);

            if address == 0 && size == 0 {
                break; // End marker
            }

            offset += 16;

            // Validate size to prevent buffer overflow
            if size > (output.len() - offset) as u64 {
                return Err(Error::Simulation(format!(
                    "Memory data size {} exceeds remaining buffer size {}",
                    size,
                    output.len() - offset
                )));
            }

            if offset + size as usize <= output.len() {
                // Use with_capacity to optimize memory allocations
                let mut data = Vec::with_capacity(size as usize);
                data.extend_from_slice(&output[offset..offset + size as usize]);
                state.memory_locations.insert(address, data);
                offset += size as usize;
            } else {
                break;
            }
        }

        Ok(state)
    }

    #[allow(dead_code)]
    pub fn get_register(&self, name: &str) -> Option<u64> {
        self.registers.get(name).copied()
    }

    #[allow(dead_code)]
    pub fn get_memory(&self, address: u64) -> Option<&Vec<u8>> {
        self.memory_locations.get(&address)
    }
}
