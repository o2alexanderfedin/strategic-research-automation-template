# Installation and Setup Guide

Complete guide for installing and configuring the Strategic Research Automation Template.

**Estimated time**: 15-30 minutes
**Difficulty**: Beginner
**Prerequisites**: Basic command line familiarity

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation Methods](#installation-methods)
- [Configuration](#configuration)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Next Steps](#next-steps)

---

## Prerequisites

Before installing this template, ensure you have:

### Required

- **[Claude Code CLI](https://docs.claude.com)** v2.0 or higher
- **Git** for version control
- **Active Anthropic API key** with Claude API access

### Recommended

- **Bash shell** (macOS/Linux native, Windows via WSL)
- **Text editor** with markdown support (VS Code, vim, etc.)
- **4+ CPU cores** for parallel execution
- **8+ GB RAM** for comfortable operation

### Optional

- **Docker** for containerized execution
- **pandoc** for advanced export formats (PDF, DOCX)
- **yamllint** for configuration validation

---

## Verification

### Verify Prerequisites

```bash
# Check Claude Code installation
claude --version
# Expected: Claude Code v2.0.0 or higher

# Check Git
git --version
# Expected: git version 2.x.x or higher

# Check API key
echo $ANTHROPIC_API_KEY
# Expected: sk-ant-...
# If empty, set it:
export ANTHROPIC_API_KEY="your-api-key-here"
# Add to ~/.bashrc or ~/.zshrc for persistence
```

### Verify System Resources

```bash
# Check CPU cores (macOS)
sysctl -n hw.ncpu
# Recommended: 4+

# Check CPU cores (Linux)
nproc
# Recommended: 4+

# Check available memory (macOS)
sysctl hw.memsize | awk '{print $2/1024/1024/1024 " GB"}'
# Recommended: 8+ GB

# Check available memory (Linux)
free -g
# Recommended: 8+ GB
```

---

## Installation Methods

### Method 1: GitHub Template (Recommended)

**Use this method for new projects:**

1. **Visit the template repository**:
   ```
   https://github.com/o2alexanderfedin/strategic-research-automation-template
   ```

2. **Click "Use this template"** button (green button near top right)

3. **Configure your new repository**:
   - Repository name: `my-research-project`
   - Description: "Strategic research for [your project]"
   - Visibility: Private (recommended for proprietary research)
   - Include all branches: No (unchecked)

4. **Clone your new repository**:
   ```bash
   git clone https://github.com/YOUR-USERNAME/my-research-project
   cd my-research-project
   ```

**Benefits**:
- Clean git history
- Easy updates from template
- GitHub integration ready

### Method 2: Direct Clone

**Use this method for quick testing:**

```bash
# Clone the template
git clone https://github.com/o2alexanderfedin/strategic-research-automation-template my-project
cd my-project

# Remove original git remote (if you want independent repo)
git remote remove origin

# Optional: Add your own remote
git remote add origin https://github.com/YOUR-USERNAME/your-repo
```

### Method 3: Download ZIP

**Use this method if you don't need git history:**

```bash
# Download and extract
curl -L https://github.com/o2alexanderfedin/strategic-research-automation-template/archive/refs/heads/main.zip -o template.zip
unzip template.zip
cd strategic-research-automation-template-main

# Initialize git if desired
git init
```

---

## Configuration

### Step 1: Environment Setup

Create `.env` file in project root:

```bash
# Copy example
cp .env.example .env

# Edit with your values
vim .env
```

**Required `.env` variables**:

```bash
# Anthropic API Configuration
ANTHROPIC_API_KEY=sk-ant-your-key-here

# Claude Code Configuration
CLAUDE_MODEL=claude-sonnet-4-5-20250929   # or claude-opus, claude-haiku
CLAUDE_MAX_TOKENS=8000
CLAUDE_TEMPERATURE=0.1

# Project Configuration
PROJECT_NAME="My Research Project"
COMPANY_NAME="Your Company"
INDUSTRY="Your Industry"

# Git Configuration
GIT_AUTHOR_NAME="Your Name"
GIT_AUTHOR_EMAIL="your.email@example.com"

# Optional: Parallel Execution
MAX_PARALLEL_TASKS=5   # Adjust based on CPU cores
```

### Step 2: Project Configuration

Edit project configuration file:

```bash
vim config/project-config.yml
```

**Key settings to customize**:

```yaml
project:
  name: "Your Project Name"
  industry: "technology sector"  # Or Healthcare, FinTech, etc.
  company: "Your Company Name"
  description: "Strategic opportunity analysis for..."

research:
  parallel_execution: true
  max_parallel_tasks: 5  # ≤ CPU cores
  minimum_file_count: 25
  citation_requirement: 0.80  # 80% of claims must have citations

quality:
  word_count_target:
    research_file: [500, 5000]
    strategic_report: [5000, 7500]
  evidence_threshold: 0.80

export:
  formats: [markdown, pdf, docx]
  pdf_engine: "pandoc"  # or "weasyprint"
```

### Step 3: Context Files

Configure your company and client context:

#### Company Profile

```bash
vim context/company-profile.md
```

**Template**:

```markdown
# Your Company Profile

## Core Capabilities

- Capability 1: Description
- Capability 2: Description
- Capability 3: Description

## Technical Expertise

- Technology stack (languages, frameworks, tools)
- Domain expertise (industries, regulations, standards)
- Methodologies (agile, advanced methodologies, etc.)

## Past Projects

Brief examples of relevant past work to inform opportunity assessment.

## Strategic Goals

What your company wants to achieve (growth, new markets, partnerships, etc.)

## Constraints

- Geographic limitations
- Industry restrictions
- Budget constraints
- Timeline requirements
```

#### Client Information

```bash
vim context/client-info.md
```

**Template**:

```markdown
# Client Information

## Client Profile

- Company: Client Name
- Industry: Industry sector
- Size: Employee count, revenue, market cap
- Location: Geographic presence

## Current Situation

What challenges is the client facing? What opportunities are they exploring?

## Requirements

What does the client need? What are their success criteria?

## Context Documents

List any background materials, RFPs, or domain knowledge documents.
```

### Step 4: Scoring Rubric (Optional)

Customize opportunity scoring criteria:

```bash
vim config/scoring-rubric.yml
```

**Example customization**:

```yaml
scoring_criteria:
  market_size:
    weight: 0.20
    description: "Total addressable market (TAM) potential"

  technical_feasibility:
    weight: 0.25
    description: "Technical complexity and company capability match"

  regulatory_clarity:
    weight: 0.15
    description: "Regulatory pathway clarity"
    # Increase weight for heavily regulated industries

  competitive_advantage:
    weight: 0.15
    description: "Unique positioning vs competitors"

  time_to_market:
    weight: 0.10
    description: "Speed to market entry"

  resource_requirements:
    weight: 0.10
    description: "Investment and resource needs"

  strategic_fit:
    weight: 0.05
    description: "Alignment with company strategy"
```

---

## Verification

### Test Installation

```bash
# Test YOLO mode wrapper
./scripts/setup/claude-eng -p "Test message"
# Expected: Fully autonomous response from Claude

# Test project structure
ls -la
# Expected: .claude/, config/, context/, scripts/, templates/, etc.

# Validate configuration files
yamllint config/*.yml
# Expected: No errors (install yamllint if needed: pip install yamllint)

# Test git
git status
# Expected: Clean working tree or expected changes
```

### Initialize First Project

```bash
# Use init-project command (YOLO mode - fully autonomous)
./scripts/setup/claude-eng -p "/init-project 'Test Project' 'Test Industry' 'Test Company'"

# Expected output:
# ✓ Project initialized: Test Project
# ✓ Configuration files created
# ✓ Context templates created
# ✓ Git repository configured
# (All executed autonomously without permission prompts)
```

---

## Troubleshooting

### Issue: Claude Code not found

**Symptom**:
```bash
$ claude --version
command not found: claude
```

**Solution**:
```bash
# Check if Claude Code is installed
which claude

# If not installed, install from https://docs.claude.com

# If installed but not in PATH, add to PATH:
export PATH="$PATH:/path/to/claude-install-dir"
# Add to ~/.bashrc or ~/.zshrc for persistence
```

### Issue: API Key Not Working

**Symptom**:
```bash
Error: Invalid API key
```

**Solution**:
```bash
# Verify key is set
echo $ANTHROPIC_API_KEY

# If empty or incorrect, reset:
export ANTHROPIC_API_KEY="sk-ant-your-actual-key"

# Test with simple autonomous request
./scripts/setup/claude-eng -p "Hello"

# Make permanent (add to ~/.bashrc or ~/.zshrc):
echo 'export ANTHROPIC_API_KEY="sk-ant-your-key"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: Configuration File Errors

**Symptom**:
```
Error: Invalid YAML in config/project-config.yml
```

**Solution**:
```bash
# Validate YAML syntax
yamllint config/project-config.yml

# Common issues:
# - Tabs instead of spaces (YAML requires spaces)
# - Inconsistent indentation
# - Missing spaces after colons
# - Unquoted special characters

# Reset to default if needed
cp templates/config/project-config.yml config/
```

### Issue: Permission Denied

**Symptom**:
```
Error: EACCES: permission denied
```

**Solution**:
```bash
# Check file permissions
ls -la scripts/

# Make scripts executable
chmod +x scripts/*.sh
chmod +x scripts/**/*.sh

# For directory creation issues
sudo chown -R $USER:$USER .
```

---

## Platform-Specific Notes

### macOS

**Recommended setup**:
```bash
# Install Homebrew (if not already)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install optional tools
brew install yamllint pandoc git-flow
```

### Linux (Ubuntu/Debian)

**Recommended setup**:
```bash
# Update package list
sudo apt update

# Install optional tools
sudo apt install yamllint pandoc git-flow
```

### Windows (WSL Recommended)

**Install WSL**:
```powershell
# In PowerShell (as Administrator)
wsl --install -d Ubuntu

# Launch Ubuntu and follow Linux setup above
```

**Native Windows** (not recommended):
- Use Git Bash for shell commands
- Some scripts may need modification
- Consider Docker for isolation

---

## Next Steps

After successful installation and configuration:

1. **Complete Quick Start tutorial**: [QUICK-START.md](QUICK-START.md)
   - 5-minute walkthrough
   - Create your first strategic report

2. **Review usage documentation**: [USAGE.md](USAGE.md)
   - Complete workflow guide
   - All commands and skills

3. **Explore examples**: [examples/technology sector-mosaic/](../examples/technology sector-mosaic/)
   - Real project walkthrough
   - Expected outputs and reports

4. **Customize for your industry**: [CUSTOMIZATION.md](CUSTOMIZATION.md)
   - Industry-specific adaptations
   - Configuration templates

---

## Support

### Getting Help

- **Documentation**: [Complete docs](README.md#documentation)
- **Troubleshooting**: [Common issues](TROUBLESHOOTING.md)
- **GitHub Issues**: [Report bugs](https://github.com/o2alexanderfedin/strategic-research-automation-template/issues)
- **Community**: [GitHub Discussions](https://github.com/o2alexanderfedin/strategic-research-automation-template/discussions)

### Before Reporting Issues

- [ ] Verified prerequisites are installed
- [ ] Checked troubleshooting guide
- [ ] Searched existing issues
- [ ] Tested with latest template version
- [ ] Can reproduce with minimal example

---

## Updates and Maintenance

### Updating the Template

```bash
# Add template as remote (if using GitHub template method)
git remote add template https://github.com/o2alexanderfedin/strategic-research-automation-template
git fetch template

# View available updates
git log HEAD..template/main --oneline

# Merge updates (may require conflict resolution)
git merge template/main

# OR cherry-pick specific commits
git cherry-pick <commit-hash>
```

### Version Check

```bash
# Check current template version
cat .template-version
# Or check CHANGELOG.md

# Check for updates
git fetch template
git log HEAD..template/main
```

---

**Setup complete!** You're ready to start automating strategic research.

Next: [Quick Start Tutorial →](QUICK-START.md)
