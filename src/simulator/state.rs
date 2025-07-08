use crate::error::{Error, Result};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct InitialState {
    pub registers: HashMap<String, u64>,
    pub memory_locations: HashMap<u64, Vec<u8>>,
    pub stack_setup: Vec<u64>,
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

impl FinalState {
    pub fn new() -> Self {
        Self {
            registers: HashMap::new(),
            flags: 0,
            memory_locations: HashMap::new(),
        }
    }

    pub fn parse_from_output(output: &[u8]) -> Result<Self> {
        if output.len() < 4096 {
            return Err(Error::Simulation("Output buffer too small".to_string()));
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
        if output.len() >= 136 {
            state.flags = u64::from_le_bytes([
                output[128],
                output[129],
                output[130],
                output[131],
                output[132],
                output[133],
                output[134],
                output[135],
            ]);
        }

        // Parse memory locations (starting at offset 256)
        // For now, we'll implement a simple format where memory locations
        // are stored as address:size:data triplets
        let mut offset = 256;
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

            if offset + size as usize <= output.len() {
                let data = output[offset..offset + size as usize].to_vec();
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
