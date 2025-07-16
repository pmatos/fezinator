use std::fs;
use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::Command;
use tempfile::TempDir;

use crate::error::{Error, Result};

pub struct CompilationPipeline {
    pub nasm_path: PathBuf,
    pub ld_path: PathBuf,
    pub temp_dir: TempDir,
}

impl CompilationPipeline {
    pub fn new() -> Result<Self> {
        // Check if NASM is available
        let nasm_path = Self::find_executable("nasm").ok_or_else(|| {
            Error::Simulation("NASM assembler not found. Please install NASM.".to_string())
        })?;

        // Check if ld is available
        let ld_path = Self::find_executable("ld").ok_or_else(|| {
            Error::Simulation("ld linker not found. Please install binutils.".to_string())
        })?;

        // Create temporary directory
        // TODO: SECURITY: Use more secure temporary file creation
        // Current implementation creates temporary files in predictable locations
        // Recommendation: Use more secure temporary file creation with proper permissions
        let temp_dir = tempfile::TempDir::new()
            .map_err(|e| Error::Simulation(format!("Failed to create temp directory: {e}")))?;

        Ok(Self {
            nasm_path,
            ld_path,
            temp_dir,
        })
    }

    pub fn compile_and_link(
        &self,
        assembly_source: &str,
        binary_name: &str,
    ) -> Result<(PathBuf, PathBuf)> {
        let asm_file = self.temp_dir.path().join(format!("{binary_name}.asm"));
        let obj_file = self.temp_dir.path().join(format!("{binary_name}.o"));
        let binary_file = self.temp_dir.path().join(binary_name);

        // Write assembly source to file
        // TODO: PERFORMANCE: Add buffering for file I/O operations
        // Multiple file operations without buffering could impact performance
        let mut file = fs::File::create(&asm_file)
            .map_err(|e| Error::Simulation(format!("Failed to create assembly file: {e}")))?;
        file.write_all(assembly_source.as_bytes())
            .map_err(|e| Error::Simulation(format!("Failed to write assembly file: {e}")))?;

        // Assemble with NASM
        self.assemble_with_nasm(&asm_file, &obj_file)?;

        // Link with ld
        self.link_with_ld(&obj_file, &binary_file)?;

        Ok((binary_file, asm_file))
    }

    fn assemble_with_nasm(&self, asm_file: &Path, obj_file: &Path) -> Result<()> {
        let output = Command::new(&self.nasm_path)
            .args(["-f", "elf64"])
            .arg("-o")
            .arg(obj_file)
            .arg(asm_file)
            .output()
            .map_err(|e| Error::Simulation(format!("Failed to run NASM: {e}")))?;

        if !output.status.success() {
            let stderr = String::from_utf8_lossy(&output.stderr);
            return Err(Error::Simulation(format!("NASM assembly failed: {stderr}")));
        }

        Ok(())
    }

    fn link_with_ld(&self, obj_file: &Path, binary_file: &Path) -> Result<()> {
        let output = Command::new(&self.ld_path)
            .arg("-o")
            .arg(binary_file)
            .arg(obj_file)
            .output()
            .map_err(|e| Error::Simulation(format!("Failed to run ld: {e}")))?;

        if !output.status.success() {
            let stderr = String::from_utf8_lossy(&output.stderr);
            return Err(Error::Simulation(format!("ld linking failed: {stderr}")));
        }

        Ok(())
    }

    fn find_executable(name: &str) -> Option<PathBuf> {
        // TODO: BUG: Fix potential race condition in executable detection
        // Current check-then-use pattern could lead to race conditions
        // Recommendation: Consider using more robust executable detection
        std::env::var_os("PATH").and_then(|paths| {
            std::env::split_paths(&paths).find_map(|dir| {
                let full_path = dir.join(name);
                if full_path.is_file() {
                    Some(full_path)
                } else {
                    None
                }
            })
        })
    }

    #[allow(dead_code)]
    pub fn get_temp_dir(&self) -> &Path {
        self.temp_dir.path()
    }
}
