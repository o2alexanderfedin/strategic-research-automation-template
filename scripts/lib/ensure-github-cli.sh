#!/usr/bin/env bash
#
# Ensure GitHub CLI is installed and authenticated
# Single Responsibility: Manage GitHub CLI dependency
#
# Usage: source scripts/lib/ensure-github-cli.sh && ensure_github_cli_installed && ensure_github_cli_authenticated

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

#
# Ensure GitHub CLI is installed
# Returns: 0 if installed (or successfully installed), 1 otherwise
#
ensure_github_cli_installed() {
    if command -v gh &> /dev/null; then
        return 0  # Already installed
    fi

    echo -e "${YELLOW}GitHub CLI (gh) not found - installing...${NC}"

    # Detect OS and install gh CLI
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_gh_macos
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        install_gh_linux
    else
        echo -e "${RED}⚠ Unknown OS ($OSTYPE) - cannot auto-install gh CLI${NC}"
        echo -e "${YELLOW}Install manually: https://cli.github.com/manual/installation${NC}"
        return 1
    fi

    # Verify installation
    if command -v gh &> /dev/null; then
        echo -e "${GREEN}✓ GitHub CLI installed successfully${NC}"
        return 0
    else
        echo -e "${RED}⚠ GitHub CLI installation failed${NC}"
        echo -e "${YELLOW}Install manually: https://cli.github.com/manual/installation${NC}"
        return 1
    fi
}

#
# Install GitHub CLI on macOS
#
install_gh_macos() {
    if command -v brew &> /dev/null; then
        echo -e "${CYAN}Installing via Homebrew...${NC}"
        brew install gh
    else
        echo -e "${RED}⚠ Homebrew not found - cannot auto-install gh CLI${NC}"
        echo -e "${YELLOW}Install Homebrew: https://brew.sh/${NC}"
        echo -e "${YELLOW}Or install gh manually: https://cli.github.com/manual/installation${NC}"
        return 1
    fi
}

#
# Install GitHub CLI on Linux
#
install_gh_linux() {
    if command -v apt-get &> /dev/null; then
        install_gh_apt
    elif command -v yum &> /dev/null; then
        install_gh_yum
    elif command -v dnf &> /dev/null; then
        install_gh_dnf
    else
        echo -e "${RED}⚠ Unknown package manager - cannot auto-install gh CLI${NC}"
        echo -e "${YELLOW}Install manually: https://cli.github.com/manual/installation${NC}"
        return 1
    fi
}

#
# Install GitHub CLI via apt (Debian/Ubuntu)
#
install_gh_apt() {
    echo -e "${CYAN}Installing via apt...${NC}"

    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
        sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
        sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

    sudo apt-get update
    sudo apt-get install gh -y
}

#
# Install GitHub CLI via yum (RHEL/CentOS)
#
install_gh_yum() {
    echo -e "${CYAN}Installing via yum...${NC}"
    sudo yum install -y gh
}

#
# Install GitHub CLI via dnf (Fedora)
#
install_gh_dnf() {
    echo -e "${CYAN}Installing via dnf...${NC}"
    sudo dnf install -y gh
}

#
# Ensure GitHub CLI is authenticated
# Returns: 0 if authenticated (or successfully authenticated), 1 otherwise
#
ensure_github_cli_authenticated() {
    if ! command -v gh &> /dev/null; then
        echo -e "${RED}⚠ GitHub CLI not installed - cannot authenticate${NC}"
        return 1
    fi

    # Check if already authenticated
    if gh auth status &> /dev/null; then
        return 0  # Already authenticated
    fi

    echo -e "${YELLOW}GitHub CLI not authenticated - logging in...${NC}"
    echo -e "${CYAN}Please follow the authentication prompts:${NC}"

    if gh auth login; then
        echo -e "${GREEN}✓ GitHub CLI authenticated successfully${NC}"
        return 0
    else
        echo -e "${RED}⚠ GitHub CLI authentication failed${NC}"
        return 1
    fi
}

#
# Check if GitHub CLI is ready (installed AND authenticated)
# Returns: 0 if ready, 1 otherwise
#
is_github_cli_ready() {
    command -v gh &> /dev/null && gh auth status &> /dev/null
}

#
# Ensure GitHub CLI is fully ready (installed AND authenticated)
# Returns: 0 if ready, 1 otherwise
#
ensure_github_cli_ready() {
    ensure_github_cli_installed && ensure_github_cli_authenticated
}
