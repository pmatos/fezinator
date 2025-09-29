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

    pub fn name_with_host_info(&self) -> String {
        let emulator_name = self.name();
        let host_arch = std::env::consts::ARCH;
        let machine_id = Self::get_machine_id();
        format!("{}@{}#{}", emulator_name, host_arch, machine_id)
    }

    fn get_machine_id() -> String {
        // Try to get a unique machine identifier
        // First try hostname, fallback to a hash of system info
        if let Ok(hostname) = std::process::Command::new("hostname")
            .output()
            .map(|output| String::from_utf8_lossy(&output.stdout).trim().to_string())
        {
            if !hostname.is_empty() {
                return hostname;
            }
        }

        // Fallback: use a hash of available system info
        use std::collections::hash_map::DefaultHasher;
        use std::hash::{Hash, Hasher};

        let mut hasher = DefaultHasher::new();
        std::env::consts::OS.hash(&mut hasher);
        std::env::consts::ARCH.hash(&mut hasher);
        if let Ok(user) = std::env::var("USER") {
            user.hash(&mut hasher);
        }

        format!("host-{:x}", hasher.finish())
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
