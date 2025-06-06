use anyhow::Result;
use object::{Object, ObjectSection};
use rand::Rng;
use sha2::{Digest, Sha256};
use std::fs;
use std::path::PathBuf;

use crate::db::BinaryInfo;
use crate::error::FezinatorError;

#[cfg(test)]
mod tests;

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

    pub fn get_binary_info(&self) -> Result<BinaryInfo> {
        let file = object::File::parse(&*self.binary_data)
            .map_err(|e| FezinatorError::BinaryParsing(e.to_string()))?;

        if !file.is_little_endian() && !file.is_64() {
            return Err(FezinatorError::InvalidBinary(
                "Only x86-64 ELF binaries are supported".into(),
            )
            .into());
        }

        let mut hasher = Sha256::new();
        hasher.update(&self.binary_data);
        let hash = format!("{:x}", hasher.finalize());

        Ok(BinaryInfo {
            path: self.binary_path.to_string_lossy().to_string(),
            size: self.binary_data.len() as u64,
            hash,
            architecture: "x86_64".to_string(),
            endianness: if file.is_little_endian() {
                "little"
            } else {
                "big"
            }
            .to_string(),
        })
    }

    pub fn extract_random_block(&self) -> Result<(u64, u64, Vec<u8>)> {
        let file = object::File::parse(&*self.binary_data)
            .map_err(|e| FezinatorError::BinaryParsing(e.to_string()))?;

        let text_section = file
            .section_by_name(".text")
            .ok_or_else(|| FezinatorError::InvalidBinary("No .text section found".into()))?;

        let section_data = text_section
            .data()
            .map_err(|e| FezinatorError::BinaryParsing(e.to_string()))?;

        if section_data.is_empty() {
            return Err(FezinatorError::InvalidBinary("Empty .text section".into()).into());
        }

        let section_addr = text_section.address();
        let section_size = section_data.len();

        let mut rng = rand::thread_rng();

        let max_block_size = std::cmp::min(1024, section_size);
        let min_block_size = std::cmp::min(16, section_size);

        let block_size = rng.gen_range(min_block_size..=max_block_size);
        let max_start = section_size.saturating_sub(block_size);
        let start_offset = if max_start > 0 {
            rng.gen_range(0..=max_start)
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
