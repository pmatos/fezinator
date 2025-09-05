# Fezinator Development Container
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Set environment variables
ENV RUST_BACKTRACE=1
ENV PATH="/root/.cargo/bin:$PATH"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    # Build essentials
    build-essential \
    pkg-config \
    curl \
    git \
    # Assembly and binary analysis dependencies
    nasm \
    libcapstone-dev \
    # Database
    sqlite3 \
    libsqlite3-dev \
    # Node.js for Claude Code (via NodeSource repository)
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x (LTS) for Claude Code
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Rust via rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . ~/.cargo/env \
    && rustup component add rustfmt clippy

# Install Claude Code globally
RUN npm install -g @anthropic/claude-code-cli

# Install Rust quality assurance tools
RUN . ~/.cargo/env \
    && cargo install cargo-audit \
    && cargo install cargo-machete \
    && cargo install cargo-outdated \
    && cargo install cargo-geiger

# Create a non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# Switch to non-root user
USER $USERNAME

# Install Rust for the non-root user
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && echo 'source ~/.cargo/env' >> ~/.bashrc

# Install Rust tools for the non-root user
RUN . ~/.cargo/env \
    && rustup component add rustfmt clippy \
    && cargo install cargo-audit \
    && cargo install cargo-machete \
    && cargo install cargo-outdated \
    && cargo install cargo-geiger

# Set working directory
WORKDIR /workspace

# Default command
CMD ["bash"]