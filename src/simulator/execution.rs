use std::path::Path;
use std::process::Command;
use std::time::{Duration, Instant};

use super::emulator::EmulatorConfig;
use crate::error::{Error, Result};

pub struct ExecutionResult {
    pub output_data: Vec<u8>,
    pub exit_code: i32,
    pub execution_time: Duration,
    #[allow(dead_code)]
    pub stderr: String,
}

pub struct ExecutionHarness {
    pub timeout_seconds: u64,
}

impl Default for ExecutionHarness {
    fn default() -> Self {
        Self::new()
    }
}

impl ExecutionHarness {
    pub fn new() -> Self {
        Self { timeout_seconds: 5 }
    }

    #[allow(dead_code)]
    pub fn with_timeout(timeout_seconds: u64) -> Self {
        Self { timeout_seconds }
    }

    pub fn execute_binary(
        &self,
        binary_path: &Path,
        emulator: Option<&EmulatorConfig>,
    ) -> Result<ExecutionResult> {
        match emulator {
            Some(emulator_config) => self.execute_with_emulator(binary_path, emulator_config),
            None => self.execute_native(binary_path),
        }
    }

    fn execute_native(&self, binary_path: &Path) -> Result<ExecutionResult> {
        let start_time = Instant::now();

        // TODO: SECURITY: Implement process sandboxing for code execution
        // This executes generated assembly directly without sandboxing, which poses significant security risks.
        // Recommendation: Implement containerization or chroot jail for execution
        // Alternative: Add strict resource limits and process isolation
        let output = Command::new(binary_path)
            .output()
            .map_err(|e| Error::Simulation(format!("Failed to execute binary: {e}")))?;

        let execution_time = start_time.elapsed();

        // TODO: PERFORMANCE: Implement proper timeout handling
        // Current implementation checks elapsed time after process finishes, not enforcing timeout during execution
        // Consider using timeout-aware spawn API or manually killing process if exceeds timeout
        if execution_time > Duration::from_secs(self.timeout_seconds) {
            return Err(Error::Simulation("Execution timeout".to_string()));
        }

        Ok(ExecutionResult {
            output_data: output.stdout,
            exit_code: output.status.code().unwrap_or(-1),
            execution_time,
            stderr: String::from_utf8_lossy(&output.stderr).to_string(),
        })
    }

    fn execute_with_emulator(
        &self,
        binary_path: &Path,
        emulator: &EmulatorConfig,
    ) -> Result<ExecutionResult> {
        let start_time = Instant::now();

        let output = match emulator {
            EmulatorConfig::Qemu { binary, args } => {
                let mut cmd = Command::new(binary);
                cmd.args(args);
                cmd.arg(binary_path);
                cmd.output()
                    .map_err(|e| Error::Simulation(format!("Failed to execute with qemu: {e}")))?
            }
            EmulatorConfig::FexEmu { binary, args } => {
                let mut cmd = Command::new(binary);
                cmd.args(args);
                cmd.arg(binary_path);
                cmd.output().map_err(|e| {
                    Error::Simulation(format!("Failed to execute with FEX-Emu: {e}"))
                })?
            }
            EmulatorConfig::Native => {
                return self.execute_native(binary_path);
            }
        };

        let execution_time = start_time.elapsed();

        if execution_time > Duration::from_secs(self.timeout_seconds) {
            return Err(Error::Simulation("Execution timeout".to_string()));
        }

        Ok(ExecutionResult {
            output_data: output.stdout,
            exit_code: output.status.code().unwrap_or(-1),
            execution_time,
            stderr: String::from_utf8_lossy(&output.stderr).to_string(),
        })
    }
}
