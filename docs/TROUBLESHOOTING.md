# Troubleshooting Guide

**Framework**: Strategic Research Automation
**Audience**: All users
**Last Updated**: 2025-11-14

---

This guide addresses common issues encountered when using the Strategic Research Automation Framework, with solutions and preventive measures.

## Table of Contents

- [Setup and Installation Issues](#setup-and-installation-issues)
- [Execution Issues](#execution-issues)
- [Quality and Validation Issues](#quality-and-validation-issues)
- [Configuration Issues](#configuration-issues)
- [Performance Issues](#performance-issues)
- [Export and Formatting Issues](#export-and-formatting-issues)
- [Platform-Specific Issues](#platform-specific-issues)

---

## Setup and Installation Issues

### Issue: Claude Code Not Found

**Symptoms**:
```
bash: claude: command not found
```

**Cause**: Claude Code CLI not installed or not in PATH

**Solution**:
```bash
# Check if Claude Code is installed
which claude

# If not found, install Claude Code
# Follow installation instructions at https://docs.claude.com/

# After installation, verify
claude --version
```

**Prevention**: Complete [Setup Guide](../SETUP.md) before using framework

---

### Issue: Project Directory Already Exists

**Symptoms**:
```
Error: Directory 'project-name' already exists
/init-project failed
```

**Cause**: Attempting to initialize project in existing directory

**Solution**:
```bash
# Option 1: Choose different name
/init-project "Project Name v2" "Industry" "Company"

# Option 2: Remove existing directory (if safe)
rm -rf project-name
/init-project "Project Name" "Industry" "Company"

# Option 3: Initialize in different location
cd ../another-location
/init-project "Project Name" "Industry" "Company"
```

**Prevention**: Check directory doesn't exist before `/init-project`

---

### Issue: Git Repository Initialization Fails

**Symptoms**:
```
fatal: not a git repository (or any of the parent directories): .git
Git initialization failed
```

**Cause**: Git not installed or parent directory already has git repo

**Solution**:
```bash
# Check if git is installed
git --version

# If not installed (macOS)
brew install git

# If not installed (Ubuntu/Debian)
sudo apt-get install git

# If parent directory has git repo, remove nested init
rm -rf .git
```

**Prevention**: Ensure git is installed before project initialization

---

## Execution Issues

### Issue: Task Execution Timeout

**Symptoms**:
```
Task 01 execution timed out after 120 minutes
ERROR: Timeout exceeded
```

**Cause**: Research task taking longer than configured timeout

**Solution**:
```bash
# Increase timeout in config/project-config.yml
research:
  timeout_minutes: 180  # Increase from 120 to 180

# Then retry task
/execute-task 01 01
```

**Alternative**: Reduce research depth for faster execution
```yaml
research:
  depth: "quick"  # Instead of "standard" or "comprehensive"
```

**Prevention**: Set appropriate timeout based on research complexity

---

### Issue: Insufficient Research Files Generated

**Symptoms**:
```
Quality validation FAILED
File count: 18 files (requirement: 25+)
```

**Cause**: Task execution incomplete or research questions too narrow

**Solution**:
```bash
# Option 1: Re-execute task with more detailed research questions
# Edit sprints/<NN>-*/0X-task.md to add more research questions
vim sprints/01-sprint/01-technical-research.md

# Add 2-3 more research questions per section
# Then re-execute
/execute-task 01 01

# Option 2: Lower quality threshold (not recommended)
# Edit config/quality-standards.yml
quality:
  min_research_files: 20  # Reduced from 25
```

**Prevention**: Ensure task files have comprehensive research questions (15-20 questions per task)

---

### Issue: Skill Not Activating

**Symptoms**:
```
Executing Task 01...
No skill activated
Task execution failed
```

**Cause**: Skill activation triggers not matching context

**Solution**:
```bash
# Check skill activation triggers
cat .claude/skills/technical-researcher/SKILL.md

# Verify task file contains trigger keywords
cat sprints/01-sprint/01-technical-research.md

# If triggers don't match, update task file with appropriate keywords
# E.g., for technical-researcher, include "technical requirements", "regulations", "feasibility"
```

**Prevention**: Review [Skills Reference](./SKILLS-REFERENCE.md) for activation triggers before creating task files

---

### Issue: Parallel Execution Out of Memory

**Symptoms**:
```
FATAL ERROR: Ineffective mark-compacts near heap limit Allocation failed - JavaScript heap out of memory
```

**Cause**: Too many parallel tasks for available memory

**Solution**:
```bash
# Reduce parallel execution in config/project-config.yml
research:
  max_parallel_tasks: 3  # Reduce from 5 or 8
  max_parallel_sprints: 1  # Reduce from 3

# Then retry
/execute-all
```

**Prevention**: Set `max_parallel_tasks` based on available RAM (1-2 per 4GB RAM)

---

## Quality and Validation Issues

### Issue: Low Citation Ratio

**Symptoms**:
```
Quality validation FAILED
Citation ratio: 72% (requirement: 80%+)
```

**Cause**: Insufficient evidence or citations in research files

**Solution**:
```bash
# Option 1: Re-execute tasks with emphasis on evidence
# Update config/quality-standards.yml to emphasize citations
evidence:
  citation_required: true
  primary_sources_preferred: true

# Re-execute tasks
/execute-task 01 01
/execute-task 01 02

# Option 2: Manually add citations to research files
# Edit files in temp/<NN>-sprint/ to add [1], [2], etc. citations

# Option 3: Lower threshold (not recommended for regulated industries)
quality:
  min_citation_ratio: 0.70  # Reduce from 0.80
```

**Prevention**: Configure quality standards before execution; emphasize evidence-based research

---

### Issue: Broken Cross-References

**Symptoms**:
```
Quality validation WARNING
Cross-references: 5 broken links found
```

**Cause**: Research files referencing non-existent files or sections

**Solution**:
```bash
# Identify broken links
/validate-quality 01
# Output shows which files have broken links

# Fix broken links manually
vim temp/01-sprint/03-solution/component-designs.md
# Update links to correct file paths

# Re-validate
/validate-quality 01
```

**Prevention**: Use relative paths for cross-references; validate frequently during research

---

### Issue: Report Too Short

**Symptoms**:
```
Quality validation FAILED
Report length: 3,800 words (requirement: 5,000-7,500)
```

**Cause**: Insufficient research depth or synthesis skipped details

**Solution**:
```bash
# Option 1: Increase research depth
# Edit config/project-config.yml
research:
  depth: "comprehensive"  # Increase from "standard"

# Re-execute sprint
/execute-sprint 01

# Option 2: Add more research questions to tasks
# Edit task files to include additional questions

# Option 3: Adjust report length requirement (if justified)
output:
  report_length_min: 3500  # Reduce from 5000
```

**Prevention**: Use "standard" or "comprehensive" depth for detailed reports

---

## Configuration Issues

### Issue: YAML Syntax Error

**Symptoms**:
```
Error parsing config/sprint-config.yml
YAML syntax error at line 15: mapping values are not allowed here
```

**Cause**: Invalid YAML syntax (indentation, missing colon, etc.)

**Solution**:
```bash
# Validate YAML syntax online or with tool
# https://www.yamllint.com/

# Common YAML errors:
# - Tabs instead of spaces (use 2 spaces)
# - Missing colon after key
# - Incorrect indentation

# Fix syntax error in file
vim config/sprint-config.yml

# Verify YAML is valid
python -c "import yaml; yaml.safe_load(open('config/sprint-config.yml'))"
```

**Prevention**: Use YAML-aware editor (VS Code with YAML extension) to catch syntax errors

---

### Issue: Scoring Weights Don't Sum to 1.0

**Symptoms**:
```
Configuration validation FAILED
Scoring weights sum to 0.95, must equal 1.0
```

**Cause**: Dimension weights in scoring rubric don't sum to 1.0

**Solution**:
```bash
# Edit config/scoring-rubric.yml
# Ensure all dimension weights sum to 1.0

scoring:
  dimensions:
    market_opportunity:
      weight: 0.25
    technical_feasibility:
      weight: 0.20
    competitive_position:
      weight: 0.15
    execution_readiness:
      weight: 0.20
    regulatory_pathway:
      weight: 0.20
  # Total: 0.25 + 0.20 + 0.15 + 0.20 + 0.20 = 1.0 ✓
```

**Prevention**: Double-check weights sum to 1.0 after any scoring rubric changes

---

## Performance Issues

### Issue: Slow Execution (Serial Instead of Parallel)

**Symptoms**:
```
Task 01 complete (20 minutes)
Task 02 starting... (should have been parallel)
```

**Cause**: Parallel execution disabled

**Solution**:
```bash
# Enable parallel execution in config/project-config.yml
research:
  parallel_execution: true  # Ensure set to true
  max_parallel_tasks: 5     # Set to CPU core count

# Verify setting
grep "parallel_execution" config/project-config.yml
```

**Prevention**: Review configuration before execution; default should be `parallel_execution: true`

---

### Issue: Permission Prompts Slowing Down Automation

**Symptoms**:
```
Waiting for permission to execute task...
Do you want to allow this operation? [y/N]
```

**Cause**: Interactive mode requires human approval for each operation

**Solution**: Use YOLO mode for fully autonomous execution

```bash
# YOLO mode: No permission prompts
./scripts/setup/claude-eng -p "/execute-sprint 01"

# Or for complete automation
./scripts/setup/claude-eng -p "/execute-all"

# For overnight batch processing
nohup ./scripts/setup/claude-eng -p "/execute-all" > research.log 2>&1 &
```

**Security note**: YOLO mode bypasses all permission checks. Only use in trusted environments.

**Prevention**: Use YOLO mode for batch processing, interactive mode for exploratory research

---

### Issue: Network Timeout During Research

**Symptoms**:
```
ERROR: Network request timeout after 30 seconds
Failed to retrieve research data
```

**Cause**: Slow network connection or external API rate limiting

**Solution**:
```bash
# Increase network timeout (if configurable)
# Retry failed task
/execute-task 01 02

# If persistent, check network connection
ping google.com

# Check if VPN or firewall blocking requests
```

**Prevention**: Ensure stable network connection; avoid peak usage times for external APIs

---

## Export and Formatting Issues

### Issue: Pandoc Not Found

**Symptoms**:
```
/export-findings 01 pdf
ERROR: pandoc: command not found
```

**Cause**: Pandoc not installed

**Solution**:
```bash
# Install Pandoc (macOS)
brew install pandoc

# Install Pandoc (Ubuntu/Debian)
sudo apt-get install pandoc

# Install Pandoc (Windows)
# Download from https://pandoc.org/installing.html

# Verify installation
pandoc --version

# Retry export
/export-findings 01 pdf
```

**Prevention**: Install Pandoc during initial setup (see [Setup Guide](../SETUP.md))

---

### Issue: LaTeX Not Found (PDF Export)

**Symptoms**:
```
/export-findings 01 pdf
ERROR: pdflatex not found
Pandoc requires LaTeX for PDF generation
```

**Cause**: LaTeX not installed (required for PDF export)

**Solution**:
```bash
# Install BasicTeX (macOS - smaller, faster)
brew install --cask basictex

# OR install full MacTeX (macOS - comprehensive)
brew install --cask mactex

# Install TeX Live (Ubuntu/Debian)
sudo apt-get install texlive

# Verify installation
pdflatex --version

# Retry export
/export-findings 01 pdf
```

**Alternative**: Export to DOCX or HTML instead of PDF
```bash
/export-findings 01 docx  # No LaTeX required
/export-findings 01 html  # No LaTeX required
```

**Prevention**: Install LaTeX during initial setup if PDF export is required

---

### Issue: Formatting Issues in Exported PDF

**Symptoms**: PDF has broken tables, incorrect fonts, or missing images

**Cause**: Complex markdown not fully supported by Pandoc default template

**Solution**:
```bash
# Use custom Pandoc template for better formatting
pandoc reports/01-sprint-report.md -o reports/01-sprint-report.pdf \
  --template=templates/pandoc-template.tex \
  --toc \
  --number-sections

# Or simplify markdown before export
# Remove complex tables, replace with simple lists
```

**Prevention**: Keep report markdown simple; test export early in project

---

## Platform-Specific Issues

### macOS: Permission Denied on Scripts

**Symptoms**:
```
bash: ./scripts/01-init-project.sh: Permission denied
```

**Cause**: Script files not executable

**Solution**:
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Retry script
./scripts/01-init-project.sh
```

**Prevention**: After cloning repository, run `chmod +x scripts/*.sh`

---

### Windows: WSL Path Issues

**Symptoms**:
```
ERROR: Cannot access /mnt/c/Users/...
Path not found
```

**Cause**: Windows path not properly converted to WSL path

**Solution**:
```bash
# Use WSL home directory instead of Windows paths
cd ~
/init-project "Project Name" "Industry" "Company"

# If you must use Windows path, ensure proper WSL path format
cd /mnt/c/Users/YourName/Projects
```

**Prevention**: Work within WSL home directory (`~`) for best compatibility

---

### Linux: Missing Dependencies

**Symptoms**:
```
ERROR: bash: command not found
```

**Cause**: Missing system dependencies

**Solution**:
```bash
# Install common dependencies (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install -y git bash curl wget

# Verify installations
git --version
bash --version
```

**Prevention**: Run dependency check before framework setup

---

## Getting Help

### Check Documentation

- [README](../README.md) - Framework overview
- [Setup Guide](../SETUP.md) - Installation and configuration
- [Usage Guide](./USAGE.md) - Workflow examples
- [Architecture](./ARCHITECTURE.md) - System design

### Command Reference

- [Skills Reference](./SKILLS-REFERENCE.md) - Skill activation and outputs
- [Commands Reference](./COMMANDS-REFERENCE.md) - Slash command syntax
- [Configuration Reference](./CONFIGURATION-REFERENCE.md) - YAML schemas

### Community Support

- **GitHub Issues**: Report bugs or request features
- **GitHub Discussions**: Ask questions, share examples
- **Contributing**: See [Contributing Guide](./CONTRIBUTING.md)

### Debugging Tips

1. **Enable verbose output**: Add `--verbose` flag to commands (if supported)
2. **Check logs**: Review execution logs in `temp/logs/`
3. **Validate configuration**: Run `/validate-config` before execution
4. **Start small**: Test with single task before full sprint
5. **Incremental validation**: Run `/validate-quality` after each task

---

**Document Version**: 1.0
**Word Count**: ~1,300 words
**Last Updated**: 2025-11-14
