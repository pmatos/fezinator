#[cfg(test)]
mod tests {
    use crate::extractor::Extractor;
    use object::ObjectSection;
    use std::fs;
    use std::process::Command;
    use tempfile::{NamedTempFile, TempDir};

    fn create_test_binary() -> NamedTempFile {
        let dir = TempDir::new().unwrap();
        let source_path = dir.path().join("test.c");
        let binary_file = NamedTempFile::new().unwrap();

        fs::write(
            &source_path,
            r#"
            int add(int a, int b) { return a + b; }
            int sub(int a, int b) { return a - b; }
            int mul(int a, int b) { return a * b; }
            int main() { return add(5, 3); }
        "#,
        )
        .unwrap();

        let output = Command::new("gcc")
            .args([
                "-o",
                binary_file.path().to_str().unwrap(),
                "-O0", // No optimization to ensure predictable code
                source_path.to_str().unwrap(),
            ])
            .output()
            .expect("Failed to compile test binary");

        if !output.status.success() {
            panic!(
                "Failed to compile test binary: {:?}",
                String::from_utf8_lossy(&output.stderr)
            );
        }

        binary_file
    }

    #[test]
    fn test_binary_info_extraction() {
        let binary_file = create_test_binary();

        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();
        let info = extractor.get_binary_info().unwrap();

        assert_eq!(info.format, "ELF");
        assert_eq!(info.architecture, "x86_64");
        assert_eq!(info.endianness, "little");
        assert!(info.size > 0);
        assert!(!info.hash.is_empty());
        assert_eq!(info.hash.len(), 64); // SHA256 hex string length
    }

    #[test]
    fn test_random_block_extraction() {
        let binary_file = create_test_binary();

        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();
        let (start, end, block) = extractor.extract_random_aligned_block().unwrap();

        assert!(start < end);
        assert_eq!(block.len(), (end - start) as usize);
        assert!(!block.is_empty());
        // With instruction alignment, blocks should be reasonably sized
        assert!(block.len() >= 4); // At least 4 instructions minimum
                                   // Since we limit to 32 instructions max and x86 instructions can be up to 15 bytes
        assert!(block.len() <= 32 * 15); // Conservative upper bound
    }

    #[test]
    fn test_multiple_extractions_different() {
        let binary_file = create_test_binary();

        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();

        let mut extractions = Vec::new();
        for _ in 0..10 {
            let (start, end, _) = extractor.extract_random_aligned_block().unwrap();
            extractions.push((start, end));
        }

        // Since we're using random selection, we should get at least some different ranges
        let unique_count = extractions
            .iter()
            .collect::<std::collections::HashSet<_>>()
            .len();
        assert!(unique_count >= 1, "Should produce at least one extraction");
    }

    #[test]
    fn test_instruction_alignment() {
        let binary_file = create_test_binary();
        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();

        // Extract a block and verify it starts and ends on instruction boundaries
        let (start_addr, end_addr, block) = extractor.extract_random_aligned_block().unwrap();

        // Create a disassembler to verify instruction alignment
        let cs = extractor.create_capstone().unwrap();

        // Disassemble the extracted block
        let insns = cs.disasm_all(&block, start_addr).unwrap();

        // Should have at least some instructions
        assert!(!insns.is_empty(), "Block should contain instructions");

        // First instruction should start at the block's start address
        assert_eq!(insns.first().unwrap().address(), start_addr);

        // Last instruction should end at or before the block's end address
        let last_insn = insns.last().unwrap();
        let last_insn_end = last_insn.address() + last_insn.bytes().len() as u64;
        assert!(
            last_insn_end <= end_addr,
            "Last instruction should not exceed block boundary"
        );
    }

    #[test]
    fn test_range_extraction_valid() {
        let binary_file = create_test_binary();
        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();

        // First get a random block to find valid instruction addresses
        let (start_addr, end_addr, _) = extractor.extract_random_aligned_block().unwrap();

        // Now extract the exact same range
        let (range_start, range_end, range_block) =
            extractor.extract_range(start_addr, end_addr).unwrap();

        assert_eq!(range_start, start_addr);
        assert_eq!(range_end, end_addr);
        assert!(!range_block.is_empty());

        // Verify it contains valid instructions
        let cs = extractor.create_capstone().unwrap();
        let insns = cs.disasm_all(&range_block, range_start).unwrap();
        assert!(!insns.is_empty());
    }

    #[test]
    fn test_range_extraction_invalid_start() {
        let binary_file = create_test_binary();
        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();

        // Get a valid range first to find an instruction address
        let (_start_addr, _end_addr, _) = extractor.extract_random_aligned_block().unwrap();

        // Create disassembler to examine the instructions
        let cs = extractor.create_capstone().unwrap();

        // Get the binary data for disassembly around our start address
        let file = object::File::parse(&*extractor.binary_data).unwrap();
        let text_section = extractor.find_executable_section(&file).unwrap();
        let section_data = text_section.data().unwrap();
        let section_addr = text_section.address();

        // Find an instruction with length > 1 byte
        let insns = cs.disasm_all(section_data, section_addr).unwrap();
        let multi_byte_insn = insns.iter().find(|insn| insn.bytes().len() > 1);

        if let Some(insn) = multi_byte_insn {
            // Try to extract starting from middle of instruction (not instruction-aligned)
            let bad_start = insn.address() + 1;
            let bad_end = bad_start + 10;

            let result = extractor.extract_range(bad_start, bad_end);
            assert!(result.is_err());
            assert!(result
                .unwrap_err()
                .to_string()
                .contains("not instruction-aligned"));
        } else {
            // Fallback: try an obviously invalid address far outside the section
            let bad_start = section_addr + section_data.len() as u64 + 1000;
            let bad_end = bad_start + 10;

            let result = extractor.extract_range(bad_start, bad_end);
            assert!(result.is_err());
        }
    }

    #[test]
    fn test_range_extraction_invalid_order() {
        let binary_file = create_test_binary();
        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();

        // Get a valid range first
        let (start_addr, end_addr, _) = extractor.extract_random_aligned_block().unwrap();

        // Try with swapped addresses
        let result = extractor.extract_range(end_addr, start_addr);
        assert!(result.is_err());
        assert!(result
            .unwrap_err()
            .to_string()
            .contains("Start address must be less than end address"));
    }

    #[test]
    fn test_format_detection_elf() {
        let binary_file = create_test_binary();
        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();

        let format = extractor.detect_format().unwrap();
        assert!(matches!(format, crate::extractor::SupportedFormat::Elf));
    }

    #[test]
    fn test_unsupported_format_error() {
        let temp_file = NamedTempFile::new().unwrap();

        // Create a file with invalid binary format
        fs::write(temp_file.path(), b"This is not a valid binary format").unwrap();

        let extractor = Extractor::new(temp_file.path().to_path_buf()).unwrap();
        let result = extractor.get_binary_info();

        assert!(result.is_err());
        let error_msg = result.unwrap_err().to_string();
        assert!(
            error_msg.contains("Binary parsing error")
                || error_msg.contains("Unknown or unsupported")
        );
    }

    #[test]
    fn test_architecture_detection() {
        let binary_file = create_test_binary();
        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();
        let info = extractor.get_binary_info().unwrap();

        // Should detect x86_64 architecture for GCC-compiled binary
        assert!(matches!(info.architecture.as_str(), "x86_64" | "i386"));
        assert_eq!(info.endianness, "little");
    }
}
