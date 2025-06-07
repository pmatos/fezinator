use anyhow::Result;
use capstone::prelude::*;
use object::{Architecture, BinaryFormat, Object, ObjectSection, SectionKind};
use rand::Rng;
use sha2::{Digest, Sha256};
use std::fs;
use std::path::PathBuf;

use crate::db::BinaryInfo;
use crate::error::FezinatorError;

#[cfg(test)]
mod tests;

#[derive(Debug, Clone)]
pub enum SupportedFormat {
    Elf,
    Pe,
}

impl SupportedFormat {
    fn as_str(&self) -> &'static str {
        match self {
            SupportedFormat::Elf => "ELF",
            SupportedFormat::Pe => "PE",
        }
    }
}

pub struct Extractor {
    binary_path: PathBuf,
    binary_data: Vec<u8>,
}

impl Extractor {
    pub fn new(binary_path: PathBuf) -> Result<Self> {
        let binary_data = fs::read(&binary_path)?;
        Ok(Extractor {
            binary_path,
            binary_data,
        })
    }

    fn detect_format(&self) -> Result<SupportedFormat> {
        let file = object::File::parse(&*self.binary_data)
            .map_err(|e| FezinatorError::BinaryParsing(e.to_string()))?;

        match file.format() {
            BinaryFormat::Elf => Ok(SupportedFormat::Elf),
            BinaryFormat::Pe => Ok(SupportedFormat::Pe),
            BinaryFormat::Coff => Err(FezinatorError::InvalidBinary(
                "COFF format is not supported. Please use PE format for Windows binaries.".into(),
            )
            .into()),
            BinaryFormat::MachO => Err(FezinatorError::InvalidBinary(
                "Mach-O format is not supported. Only ELF and PE formats are supported.".into(),
            )
            .into()),
            BinaryFormat::Wasm => Err(FezinatorError::InvalidBinary(
                "WebAssembly format is not supported. Only ELF and PE formats are supported."
                    .into(),
            )
            .into()),
            BinaryFormat::Xcoff => Err(FezinatorError::InvalidBinary(
                "XCOFF format is not supported. Only ELF and PE formats are supported.".into(),
            )
            .into()),
            _ => Err(FezinatorError::InvalidBinary(
                "Unknown or unsupported binary format. Only ELF and PE formats are supported."
                    .into(),
            )
            .into()),
        }
    }

    fn get_architecture_info(&self, file: &object::File) -> Result<(String, String)> {
        let architecture =
            match file.architecture() {
                Architecture::X86_64 => "x86_64",
                Architecture::I386 => "i386",
                _ => return Err(FezinatorError::InvalidBinary(
                    "Unsupported architecture. Only x86 and x86_64 architectures are supported."
                        .into(),
                )
                .into()),
            };

        let endianness = if file.is_little_endian() {
            "little"
        } else {
            "big"
        };

        Ok((architecture.to_string(), endianness.to_string()))
    }

    pub fn get_binary_info(&self) -> Result<BinaryInfo> {
        let file = object::File::parse(&*self.binary_data)
            .map_err(|e| FezinatorError::BinaryParsing(e.to_string()))?;

        let format = self.detect_format()?;
        let (architecture, endianness) = self.get_architecture_info(&file)?;

        let mut hasher = Sha256::new();
        hasher.update(&self.binary_data);
        let hash = format!("{:x}", hasher.finalize());

        Ok(BinaryInfo {
            path: self.binary_path.to_string_lossy().to_string(),
            size: self.binary_data.len() as u64,
            hash,
            format: format.as_str().to_string(),
            architecture,
            endianness,
        })
    }

    fn find_executable_section<'a>(
        &self,
        file: &'a object::File<'a>,
    ) -> Result<object::Section<'a, 'a>> {
        // Try common executable section names in order of preference
        let section_names = match self.detect_format()? {
            SupportedFormat::Elf => vec![".text"],
            SupportedFormat::Pe => vec![".text", "CODE", ".code"],
        };

        for section_name in section_names {
            if let Some(section) = file.section_by_name(section_name) {
                return Ok(section);
            }
        }

        // If no named section found, look for the first executable section
        for section in file.sections() {
            // Check if section is executable by looking at section kind
            if section.kind() == SectionKind::Text {
                return Ok(section);
            }
        }

        Err(FezinatorError::InvalidBinary("No executable section found".into()).into())
    }

    pub fn create_capstone(&self) -> Result<capstone::Capstone> {
        let binary_info = self.get_binary_info()?;

        let cs = match binary_info.architecture.as_str() {
            "i386" => capstone::Capstone::new()
                .x86()
                .mode(arch::x86::ArchMode::Mode32)
                .detail(false)
                .build()
                .map_err(|e| {
                    FezinatorError::BinaryParsing(format!("Failed to create x86 capstone: {}", e))
                })?,
            "x86_64" => capstone::Capstone::new()
                .x86()
                .mode(arch::x86::ArchMode::Mode64)
                .detail(false)
                .build()
                .map_err(|e| {
                    FezinatorError::BinaryParsing(format!(
                        "Failed to create x86_64 capstone: {}",
                        e
                    ))
                })?,
            _ => {
                return Err(FezinatorError::InvalidBinary(format!(
                    "Unsupported architecture for disassembly: {}",
                    binary_info.architecture
                ))
                .into())
            }
        };

        Ok(cs)
    }

    pub fn extract_random_aligned_block(&self) -> Result<(u64, u64, Vec<u8>)> {
        let file = object::File::parse(&*self.binary_data)
            .map_err(|e| FezinatorError::BinaryParsing(e.to_string()))?;

        let text_section = self.find_executable_section(&file)?;

        let section_data = text_section
            .data()
            .map_err(|e| FezinatorError::BinaryParsing(e.to_string()))?;

        if section_data.is_empty() {
            return Err(FezinatorError::InvalidBinary("Empty executable section".into()).into());
        }

        let section_addr = text_section.address();
        let cs = self.create_capstone()?;

        // Disassemble the entire section to get instruction boundaries
        let insns = cs.disasm_all(section_data, section_addr).map_err(|e| {
            FezinatorError::BinaryParsing(format!("Failed to disassemble section: {}", e))
        })?;

        if insns.len() < 2 {
            return Err(
                FezinatorError::InvalidBinary("Not enough instructions in section".into()).into(),
            );
        }

        let mut rng = rand::rng();

        // Define block size in terms of instruction count
        let min_instructions = std::cmp::min(4, insns.len() / 2);
        let max_instructions = std::cmp::min(32, insns.len() - 1);

        if min_instructions >= max_instructions {
            return Err(FezinatorError::InvalidBinary(
                "Section too small for block extraction".into(),
            )
            .into());
        }

        let instruction_count = rng.random_range(min_instructions..=max_instructions);

        // Pick a random starting instruction
        let max_start_idx = insns.len() - instruction_count;
        let start_idx = if max_start_idx > 0 {
            rng.random_range(0..max_start_idx)
        } else {
            0
        };

        let end_idx = start_idx + instruction_count;

        // Get the address range
        let start_addr = insns[start_idx].address();
        let end_addr = if end_idx < insns.len() {
            insns[end_idx].address()
        } else {
            // If we're at the end, use the last instruction's end address
            let last_insn = &insns[insns.len() - 1];
            last_insn.address() + last_insn.bytes().len() as u64
        };

        // Extract the bytes from the section data
        let start_offset = (start_addr - section_addr) as usize;
        let end_offset = (end_addr - section_addr) as usize;

        if end_offset > section_data.len() {
            return Err(
                FezinatorError::InvalidBinary("Block extends beyond section".into()).into(),
            );
        }

        let assembly_block = section_data[start_offset..end_offset].to_vec();

        Ok((start_addr, end_addr, assembly_block))
    }
}
