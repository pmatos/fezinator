use crate::error::{Error, Result};
use std::str::FromStr;

#[derive(Debug, Clone, Default)]
pub enum EmulatorConfig {
    #[default]
    Native,
    Qemu {
        binary: String,
        args: Vec<String>,
    },
    FexEmu {
        binary: String,
        args: Vec<String>,
    },
}

impl EmulatorConfig {
    pub fn name(&self) -> String {
        match self {
            EmulatorConfig::Native => "native".to_string(),
            EmulatorConfig::Qemu { .. } => "qemu".to_string(),
            EmulatorConfig::FexEmu { .. } => "fex-emu".to_string(),
        }
    }

    pub fn qemu_x86_64() -> Self {
        Self::Qemu {
            binary: "qemu-x86_64".to_string(),
            args: ["-cpu", "max"].iter().map(|s| s.to_string()).collect(),
        }
    }

    pub fn qemu_i386() -> Self {
        Self::Qemu {
            binary: "qemu-i386".to_string(),
            args: ["-cpu", "max"].iter().map(|s| s.to_string()).collect(),
        }
    }

    pub fn fex_emu() -> Self {
        Self::FexEmu {
            binary: "FEXInterpreter".to_string(),
            args: vec![],
        }
    }

    pub fn is_available(&self) -> bool {
        match self {
            EmulatorConfig::Native => true,
            EmulatorConfig::Qemu { binary, .. } => std::process::Command::new(binary)
                .arg("--version")
                .output()
                .map(|output| output.status.success())
                .unwrap_or(false),
            EmulatorConfig::FexEmu { binary, .. } => std::process::Command::new(binary)
                .arg("--version")
                .output()
                .map(|output| output.status.success())
                .unwrap_or(false),
        }
    }
}

impl FromStr for EmulatorConfig {
    type Err = Error;

    fn from_str(s: &str) -> Result<Self> {
        match s.to_lowercase().as_str() {
            "native" => Ok(EmulatorConfig::Native),
            "qemu" | "qemu-x86_64" => Ok(EmulatorConfig::qemu_x86_64()),
            "qemu-i386" => Ok(EmulatorConfig::qemu_i386()),
            "fex" | "fex-emu" => Ok(EmulatorConfig::fex_emu()),
            _ => Err(Error::Simulation(format!("Unknown emulator: {s}"))),
        }
    }
}
