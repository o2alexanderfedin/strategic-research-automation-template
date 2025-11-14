# Strategic Research Automation Template

> **Status**: Work in Progress - Under Active Development

This repository is a GitHub template for autonomous strategic research automation using Claude Code.

## Overview

This template provides a complete framework for conducting strategic research using Claude Code's autonomous capabilities. It includes:

- **Claude Code Skills** - 8 specialized skills for research automation
- **Slash Commands** - 13 commands for research workflow
- **Bash Automation Scripts** - 7 scripts for autonomous research execution
- **Configuration Templates** - Quality standards, scoring rubrics, sprint configs
- **Documentation** - Complete setup, usage, and customization guides

## Current Status

This template is currently under development. The following sprints are planned:

- [ ] Sprint 00: GitHub Repository Setup (In Progress)
- [ ] Sprint 01: Template Repository Structure
- [ ] Sprint 02: Claude Code Skills
- [ ] Sprint 03: Slash Commands
- [ ] Sprint 04: Bash Automation Scripts
- [ ] Sprint 05: Documentation and Setup Guides
- [ ] Sprint 06: Testing, Validation, and Release

Expected v1.0 release: TBD

## Development

This template is being developed as a git submodule within the [mosaic-vtol](https://github.com/o2alexanderfedin/mosaic-vtol) repository.

For development progress and planning, see the parent repository's `sprints/` directory.

## License

MIT License - See [LICENSE](LICENSE) for details.

## Contact

**Developer**: Alexander Fedin
**Email**: o2alexanderfedin@gmail.com
**GitHub**: [@o2alexanderfedin](https://github.com/o2alexanderfedin)

---

**Note**: This README will be updated with complete documentation once development is complete.

## Automation Scripts (Sprint 04 Complete)

This template includes 7 bash automation scripts for hands-free strategic research execution:

### Setup Scripts
- `scripts/setup/claude-eng` - YOLO mode wrapper for Claude Code CLI
- `scripts/setup/.claude-system-prompt.md` - Engineering best practices prompt
- `scripts/setup/install.sh` - Automated installation of YOLO mode

### Core Automation Scripts
1. **`scripts/run-autonomous-analysis.sh`** - Fully autonomous discovery + execution
2. **`scripts/run-complete-analysis.sh`** - Full project execution with manual sprint definitions
3. **`scripts/run-sprint.sh`** - Single sprint execution with quality validation

### Utility Scripts
4. **`scripts/export-reports.sh`** - Multi-format export (PDF, DOCX, HTML)
5. **`scripts/validate-all.sh`** - Quality validation pipeline for all sprints
6. **`scripts/run-sprints-incremental.sh`** - Incremental execution with checkpoints

### Infrastructure
- **`.github/workflows/ci-research-pipeline.yml`** - CI/CD automation
- **`Dockerfile`** - Containerized isolated execution

## Quick Start

### 1. Install Prerequisites

```bash
# Install Claude Code CLI
# Follow: https://docs.claude.com

# Install YOLO mode (recommended)
cd scripts/setup
./install.sh
```

### 2. Configure Environment

```bash
# Set your Claude command
export CLAUDE_CMD="$HOME/claude-eng"  # Uses YOLO mode
# OR
export CLAUDE_CMD="claude"  # Uses standard mode

# Add to ~/.bashrc or ~/.zshrc
echo 'export CLAUDE_CMD="$HOME/claude-eng"' >> ~/.bashrc
```

### 3. Run Autonomous Analysis

```bash
# Fully autonomous: Discovery + Execution
./scripts/run-autonomous-analysis.sh \
  "MOSAIC eVTOL Analysis" \
  "Hupyy" \
  "MOSAIC_Final_Rule.pdf"

# Manual sprint definitions
./scripts/run-complete-analysis.sh \
  "Project Name" \
  "Industry" \
  "Company Name" \
  "Sprint1|Description1" \
  "Sprint2|Description2"

# Single sprint
./scripts/run-sprint.sh 01
```

## Testing

Comprehensive test suite with 50+ BATS tests:

```bash
# Install BATS
brew install bats-core shellcheck

# Run all tests
bats test/

# Run specific test suite
bats test/setup/*.bats
bats test/run-sprint.bats

# Shellcheck compliance
shellcheck scripts/*.sh
# All automation scripts pass with ZERO warnings
```
