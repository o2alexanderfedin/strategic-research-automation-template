# Dockerfile for isolated strategic research automation
# Provides secure, containerized Claude Code execution

FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    jq \
    pandoc \
    texlive-xetex \
    bash \
    coreutils \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code CLI
RUN curl -fsSL https://install.claude.ai/cli | sh

# Add Claude to PATH
ENV PATH="/root/.claude/local:${PATH}"

# Set working directory
WORKDIR /workspace

# Copy scripts and configuration
COPY scripts/ /workspace/scripts/
COPY config/ /workspace/config/
COPY context/ /workspace/context/
COPY templates/ /workspace/templates/

# Make scripts executable
RUN chmod +x /workspace/scripts/*.sh
RUN chmod +x /workspace/scripts/setup/*

# Default command: show usage
CMD ["bash", "-c", "echo 'Strategic Research Automation Container' && echo '' && echo 'Usage:' && echo '  docker run -v $(pwd):/workspace -e CLAUDE_API_KEY=<key> <image> ./scripts/run-autonomous-analysis.sh ...'"]
