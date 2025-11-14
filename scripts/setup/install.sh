#!/bin/bash
# Automated setup for claude-eng wrapper and system prompt
# Installs YOLO mode automation for Claude Code CLI

set -e

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  Claude Engineering Wrapper - Installation                    ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "This will install:"
echo "  1. ~/claude-eng - YOLO mode wrapper script"
echo "  2. ~/.claude-system-prompt.md - Engineering best practices"
echo "  3. CLAUDE_CMD environment variable (optional)"
echo ""

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if source files exist
if [ ! -f "$SCRIPT_DIR/claude-eng" ]; then
  echo "Error: claude-eng not found in $SCRIPT_DIR"
  exit 1
fi

if [ ! -f "$SCRIPT_DIR/.claude-system-prompt.md" ]; then
  echo "Error: .claude-system-prompt.md not found in $SCRIPT_DIR"
  exit 1
fi

# Copy files
echo "→ Installing claude-eng wrapper..."
cp "$SCRIPT_DIR/claude-eng" "$HOME/claude-eng"
chmod +x "$HOME/claude-eng"
echo "  ✓ Installed to ~/claude-eng"

echo ""
echo "→ Installing system prompt..."
cp "$SCRIPT_DIR/.claude-system-prompt.md" "$HOME/.claude-system-prompt.md"
echo "  ✓ Installed to ~/.claude-system-prompt.md"

# Detect shell and offer to add to profile
echo ""
echo "→ Configuring shell environment..."

SHELL_RC=""
if [[ "$SHELL" == *"zsh"* ]]; then
  SHELL_RC="${HOME}/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
  SHELL_RC="${HOME}/.bashrc"
fi

if [ -n "$SHELL_RC" ]; then
  # Check if CLAUDE_CMD already configured
  if [ -f "$SHELL_RC" ] && grep -q "CLAUDE_CMD" "$SHELL_RC"; then
    echo "  ✓ CLAUDE_CMD already configured in $SHELL_RC"
  else
    # Ask user if they want to add it (skip if INSTALL_NON_INTERACTIVE set)
    if [ -z "$INSTALL_NON_INTERACTIVE" ]; then
      echo ""
      echo "  Add CLAUDE_CMD to $SHELL_RC?"
      echo "  This allows scripts to automatically use ~/claude-eng"
      echo ""
      read -rp "  Add to shell profile? (y/n): " add_to_profile
    else
      add_to_profile="y"
    fi

    if [[ "$add_to_profile" == "y" ]]; then
      {
        echo ""
        echo '# Claude Engineering Wrapper'
        echo "export CLAUDE_CMD=\"\$HOME/claude-eng\""
      } >> "$SHELL_RC"
      echo "  ✓ Added CLAUDE_CMD to $SHELL_RC"
    else
      echo "  ⊘ Skipped shell profile configuration"
      echo "  To use manually: export CLAUDE_CMD=\"\$HOME/claude-eng\""
    fi
  fi
else
  echo "  ⊘ Shell detection failed - manual configuration required"
fi

# Test the installation
echo ""
echo "→ Testing installation..."

if [ -x "$HOME/claude-eng" ]; then
  echo "  ✓ claude-eng is executable"
else
  echo "  ✗ claude-eng is not executable"
  exit 1
fi

if [ -f "$HOME/.claude-system-prompt.md" ]; then
  echo "  ✓ System prompt file exists"
else
  echo "  ✗ System prompt file missing"
  exit 1
fi

# Final instructions
echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  ✓ Setup complete!                                            ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Usage:"
echo "  ~/claude-eng -p 'your prompt here'"
echo ""
echo "For automation scripts:"
echo "  export CLAUDE_CMD=\"\$HOME/claude-eng\""
echo ""

if [ -n "$SHELL_RC" ]; then
  echo "Reload your shell to activate:"
  echo "  source $SHELL_RC"
  echo ""
fi

echo "Documentation: See scripts/setup/README.md for details"
echo ""
