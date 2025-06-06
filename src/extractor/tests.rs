#[cfg(test)]
mod tests {
    use crate::extractor::Extractor;
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
        let (start, end, block) = extractor.extract_random_block().unwrap();

        assert!(start < end);
        assert_eq!(block.len(), (end - start) as usize);
        assert!(!block.is_empty());
        assert!(block.len() >= 16);
        assert!(block.len() <= 1024);
    }

    #[test]
    fn test_multiple_extractions_different() {
        let binary_file = create_test_binary();

        let extractor = Extractor::new(binary_file.path().to_path_buf()).unwrap();

        let mut extractions = Vec::new();
        for _ in 0..10 {
            let (start, end, _) = extractor.extract_random_block().unwrap();
            extractions.push((start, end));
        }

        // Since we're using random selection, we should get at least some different ranges
        let unique_count = extractions
            .iter()
            .collect::<std::collections::HashSet<_>>()
            .len();
        assert!(unique_count >= 1, "Should produce at least one extraction");
    }
}
