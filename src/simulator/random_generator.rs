use rand::rngs::StdRng;
use rand::{Rng, SeedableRng};

use super::state::InitialState;
use crate::analyzer::{BlockAnalysis, MemoryAccess};

pub struct RandomStateGenerator {
    rng: StdRng,
}

impl Default for RandomStateGenerator {
    fn default() -> Self {
        Self::new()
    }
}

impl RandomStateGenerator {
    pub fn new() -> Self {
        Self {
            rng: StdRng::from_rng(&mut rand::rng()),
        }
    }

    pub fn with_seed(seed: u64) -> Self {
        Self {
            rng: StdRng::seed_from_u64(seed),
        }
    }

    pub fn generate_initial_state(&mut self, analysis: &BlockAnalysis) -> InitialState {
        let mut state = InitialState::new();

        // Generate random values for live-in registers
        for register in &analysis.live_in_registers {
            let value = self.generate_register_value(register);
            state.set_register(register, value);
        }

        // Set up stack with random but realistic values
        self.setup_stack_frame(&mut state);

        // Generate memory values for accessed locations
        for memory_access in &analysis.memory_accesses {
            if let Some(addr) = self.estimate_memory_address(memory_access) {
                let data = self.generate_memory_data(memory_access.size);
                state.set_memory(addr, data);
            }
        }

        state
    }

    fn generate_register_value(&mut self, register: &str) -> u64 {
        match register {
            // Stack pointer should be in a reasonable range
            "rsp" | "esp" => {
                let base = 0x7ffd00000000u64; // Typical user stack base
                let offset = self.rng.random_range(0x1000..0x10000); // 4KB to 64KB offset
                base + offset
            }
            // Frame pointer should be close to stack pointer
            "rbp" | "ebp" => {
                let base = 0x7ffd00000000u64;
                let offset = self.rng.random_range(0x1000..0x10000);
                base + offset
            }
            // General purpose registers can be any value, but avoid problematic ones
            _ => {
                let mut value = self.rng.random::<u64>();

                // Avoid NULL pointers and very small values that might cause issues
                if value < 0x1000 {
                    value += 0x1000;
                }

                // Avoid kernel space addresses on x86_64
                if value >= 0xffff800000000000 {
                    value &= 0x7fffffffffffffff;
                }

                value
            }
        }
    }

    fn setup_stack_frame(&mut self, state: &mut InitialState) {
        // Generate some random stack values
        let stack_depth = self.rng.random_range(1..8);
        for _ in 0..stack_depth {
            let value = self.rng.random::<u64>();
            state.add_stack_value(value);
        }
    }

    fn estimate_memory_address(&mut self, memory_access: &MemoryAccess) -> Option<u64> {
        if memory_access.is_stack {
            // Stack addresses
            let base = 0x7ffd00000000u64;
            let offset = self.rng.random_range(0x1000..0x10000);
            Some(base + offset)
        } else {
            // Heap or other memory addresses
            let base = 0x555555554000u64; // Typical heap base
            let offset = self.rng.random_range(0x1000..0x100000);
            Some(base + offset)
        }
    }

    fn generate_memory_data(&mut self, size: usize) -> Vec<u8> {
        let mut data = vec![0u8; size];
        self.rng.fill(&mut data[..]);

        // Avoid generating problematic patterns
        for byte in &mut data {
            // Avoid NULL bytes in strings
            if *byte == 0 {
                *byte = 0x20; // space character
            }
        }

        data
    }

    #[allow(dead_code)]
    pub fn random_u64(&mut self) -> u64 {
        self.rng.random()
    }

    #[allow(dead_code)]
    pub fn random_bytes(&mut self, size: usize) -> Vec<u8> {
        let mut data = vec![0u8; size];
        self.rng.fill(&mut data[..]);
        data
    }
}
