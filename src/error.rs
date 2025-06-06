use thiserror::Error;

#[derive(Error, Debug)]
pub enum FezinatorError {
    #[error("IO error: {0}")]
    Io(#[from] std::io::Error),

    #[error("Database error: {0}")]
    Database(#[from] rusqlite::Error),

    #[error("Binary parsing error: {0}")]
    BinaryParsing(String),

    #[error("Invalid binary format: {0}")]
    InvalidBinary(String),
}
