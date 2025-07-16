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

    #[error("Simulation error: {0}")]
    Simulation(String),
}

pub type Error = FezinatorError;
pub type Result<T> = std::result::Result<T, Error>;
