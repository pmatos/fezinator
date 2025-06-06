use anyhow::Result;
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

    pub fn extract_random_block(&self) -> Result<(u64, u64, Vec<u8>)> {
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
        let section_size = section_data.len();

        let mut rng = rand::rng();

        let max_block_size = std::cmp::min(1024, section_size);
        let min_block_size = std::cmp::min(16, section_size);

        let block_size = rng.random_range(min_block_size..=max_block_size);
        let max_start = section_size.saturating_sub(block_size);
        let start_offset = if max_start > 0 {
            rng.random_range(0..=max_start)
        } else {
            0
        };

        let end_offset = start_offset + block_size;
        let start_addr = section_addr + start_offset as u64;
        let end_addr = section_addr + end_offset as u64;

        let assembly_block = section_data[start_offset..end_offset].to_vec();

        Ok((start_addr, end_addr, assembly_block))
    }
}
