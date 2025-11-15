# Commands Reference

**Framework**: Strategic Research Automation
**Audience**: All users
**Last Updated**: 2025-11-14

---

This reference documents all 13 slash commands available in the Strategic Research Automation Framework. Each command provides a user-facing interface for common workflows.

## Table of Contents

- [Command Overview](#command-overview)
- [Project Management Commands](#project-management-commands)
- [Execution Commands](#execution-commands)
- [Analysis Commands](#analysis-commands)
- [Export and Quality Commands](#export-and-quality-commands)
- [Release Management Commands](#release-management-commands)

---

## Command Overview

### Command Location

All commands reside in `.claude/commands/` as markdown files.

### Command Syntax

```bash
/command-name [required-arg] [optional-arg]
```

### Common Patterns

- **Required arguments**: Shown in angle brackets `<arg>`
- **Optional arguments**: Shown in square brackets `[arg]`
- **String arguments**: Enclosed in quotes `"argument with spaces"`

---

## Project Management Commands

### /init-project

**Purpose**: Initialize a new strategic research project with complete directory structure and configuration templates.

**Syntax**:
```bash
/init-project "<project-name>" "<industry>" "<company-name>"
```

**Arguments**:
- `project-name` (required) - Descriptive name for your research project
- `industry` (required) - Industry vertical (technology sector, healthcare, fintech, etc.)
- `company-name` (required) - Your company or consultancy name

**Output**:
- Complete directory structure (`.claude/`, `config/`, `context/`, `sprints/`, etc.)
- Configuration templates (`config/*.yml`)
- Context file templates (`context/*.md`)
- Git repository initialization

**Examples**:
```bash
/init-project "Industry Regulation XYZ advanced system Analysis" "technology sector" "TechCo"
/init-project "EHR Integration Study" "Healthcare" "HealthTech Consulting"
/init-project "RegTech Compliance" "FinTech" "Compliance Advisors"
```

**Common Errors**:
- Directory already exists → Choose different project name or location
- Invalid characters in name → Use alphanumeric and hyphens only

---

### /create-sprint

**Purpose**: Create a new sprint definition with task files and configuration entry.

**Syntax**:
```bash
/create-sprint <sprint-number> "<sprint-name>" "<description>"
```

**Arguments**:
- `sprint-number` (required) - Two-digit sprint ID (01, 02, ..., 10)
- `sprint-name` (required) - Short descriptive name (3-5 words)
- `description` (required) - One-sentence opportunity summary

**Output**:
- Sprint directory: `sprints/<NN>-<name>/`
- Sprint README: `sprints/<NN>-<name>/README.md`
- Six task files: `01-technical-research.md` through `06-report-synthesis.md`
- Entry added to `config/sprint-config.yml`

**Examples**:
```bash
/create-sprint 01 "operation Control Verification" "advanced methodology-based verification for advanced system operation control systems"
/create-sprint 02 "EHR Interoperability" "HL7 FHIR integration for hospital EHR systems"
```

**Common Errors**:
- Sprint number already exists → Use next available number
- Invalid YAML in sprint-config.yml → Validate YAML syntax

---

### /update-context

**Purpose**: Update project context files (company profile, client info, industry background).

**Syntax**:
```bash
/update-context
```

**Arguments**: None (interactive prompts)

**Output**:
- Updated `context/company-profile.md`
- Updated `context/client-info.md`
- Updated `context/industry-background.md`
- Version timestamp in each file

**Use Cases**:
- New client engagement
- Company capability changes
- Industry regulation updates
- Team expertise additions

**Example**:
```bash
/update-context
# Prompts for company, client, and industry updates
# Updates all context files with new information
```

---

## Execution Commands

### /execute-task

**Purpose**: Execute a single task within a sprint for focused research.

**Syntax**:
```bash
/execute-task <sprint-number> <task-number>
```

**Arguments**:
- `sprint-number` (required) - Two-digit sprint ID (01-10)
- `task-number` (required) - Task ID (01-06)

**Output**:
- Research files in `temp/<NN>-sprint/<task-number>-<task-name>/`
- 5-7 granular research files per task
- Progress log

**Examples**:
```bash
/execute-task 01 01  # Execute Sprint 01, Task 01 (Technical Research)
/execute-task 02 04  # Execute Sprint 02, Task 04 (Certification Strategy)
```

**Duration**: 10-20 minutes per task

**Common Errors**:
- Sprint not defined → Run `/create-sprint` first
- Task file missing → Check `sprints/<NN>-*/` directory

---

### /execute-sprint

**Purpose**: Execute all tasks within one sprint (Tasks 01-05 in parallel, then Task 06).

**Syntax**:
```bash
/execute-sprint <sprint-number>
```

**Arguments**:
- `sprint-number` (required) - Two-digit sprint ID (01-10)

**Output**:
- 29-31 research files in `temp/<NN>-sprint/`
- Strategic report in `reports/<NN>-sprint-report.md`
- Quality metrics log

**Examples**:
```bash
/execute-sprint 01
/execute-sprint 05
```

**Duration**: 45-90 minutes per sprint

**Execution Flow**:
1. Tasks 01-05 execute in parallel (MAP phase)
2. Task 06 executes after all complete (REDUCE phase)
3. Report generated in `reports/`

**Common Errors**:
- Insufficient research files → Check quality standards, may need to re-execute
- Timeout → Increase timeout in `config/project-config.yml`

---

### /execute-all

**Purpose**: Execute all configured sprints in portfolio.

**Syntax**:
```bash
/execute-all
```

**Arguments**: None (reads from `config/sprint-config.yml`)

**Output**:
- Individual reports for each sprint (`reports/<NN>-sprint-report.md`)
- Cross-sprint comparison report (`reports/00-sprint-comparison.md`)
- Prioritization recommendations

**Duration**: 6-15 hours for 10 sprints (depending on parallelization)

**Configuration**:
```yaml
# config/project-config.yml
research:
  max_parallel_sprints: 3  # Adjust based on resources
```

**Examples**:
```bash
/execute-all
# Executes all sprints defined in config/sprint-config.yml
# Generates individual and comparative reports
```

**Common Errors**:
- Memory issues → Reduce `max_parallel_sprints`
- Network timeout → Increase timeout limits

---

### /discover-opportunities

**Purpose**: Autonomously identify opportunities by analyzing company capabilities, client needs, and industry context.

**Syntax**:
```bash
/discover-opportunities
```

**Arguments**: None (reads from `context/*.md` files)

**Output**:
- Opportunity discovery report (`reports/00-opportunity-discovery.md`)
- Auto-generated sprint configurations (`config/sprint-config.yml` updated)
- Auto-generated task files (`sprints/<NN>-*/` created)

**Process**:
1. Analyzes `context/company-profile.md` (capabilities)
2. Analyzes `context/client-info.md` (needs)
3. Analyzes `context/industry-background.md` (market)
4. Identifies 5-10 high-fit opportunities
5. Generates sprint configurations and task files

**Examples**:
```bash
/discover-opportunities
# Discovers 8 opportunities for Industry Regulation XYZ advanced system market
# Creates Sprint 01-08 configurations automatically
```

**Common Errors**:
- Insufficient context → Fill out all context files thoroughly
- Low-fit opportunities → Review context alignment

---

## Analysis Commands

### /synthesize-report

**Purpose**: Generate strategic assessment report from research files (Task 06 equivalent).

**Syntax**:
```bash
/synthesize-report <sprint-number>
```

**Arguments**:
- `sprint-number` (required) - Two-digit sprint ID (01-10)

**Output**:
- Strategic report in `reports/<NN>-sprint-report.md` (5,000-7,500 words)

**Prerequisites**:
- Tasks 01-05 must be complete for the sprint
- Minimum 25 research files in `temp/<NN>-sprint/`

**Examples**:
```bash
/synthesize-report 01
/synthesize-report 03
```

**Common Errors**:
- Insufficient research files → Execute Tasks 01-05 first
- Missing scoring rubric → Check `config/scoring-rubric.yml`

---

### /score-opportunity

**Purpose**: Apply scoring rubric to a sprint and generate quantitative assessment.

**Syntax**:
```bash
/score-opportunity <sprint-number>
```

**Arguments**:
- `sprint-number` (required) - Two-digit sprint ID (01-10)

**Output**:
- Scoring report with dimension-by-dimension breakdown
- Overall score (0-100)
- Recommendation tier (STRONG GO, GO, CONDITIONAL GO, NO GO)

**Examples**:
```bash
/score-opportunity 01
# Market Opportunity: 85/100
# Technical Feasibility: 92/100
# Competitive Position: 78/100
# Execution Readiness: 88/100
# Regulatory Pathway: 90/100
# OVERALL: 87/100 (STRONG GO)
```

---

### /compare-sprints

**Purpose**: Generate cross-sprint comparison and prioritization report.

**Syntax**:
```bash
/compare-sprints
```

**Arguments**: None (analyzes all reports in `reports/`)

**Output**:
- Comparison report (`reports/00-sprint-comparison.md`)
- Scoring matrix across all sprints
- Tier 1/2/3 categorization
- Recommended execution sequence

**Prerequisites**:
- At least 2 sprint reports must exist in `reports/`

**Examples**:
```bash
/compare-sprints
# Generates comparison of all 10 sprints
# Recommends Tier 1: Sprints 01, 03 (execute immediately)
#            Tier 2: Sprints 02, 05, 04 (execute next)
#            Tier 3: Sprints 06-10 (evaluate later)
```

---

## Export and Quality Commands

### /export-findings

**Purpose**: Export strategic report to professional formats (PDF, DOCX, HTML).

**Syntax**:
```bash
/export-findings <sprint-number> <format>
```

**Arguments**:
- `sprint-number` (required) - Two-digit sprint ID (01-10)
- `format` (required) - Output format: `pdf`, `docx`, or `html`

**Output**:
- Formatted report in `reports/<NN>-sprint-report.<format>`

**Prerequisites**:
- Pandoc installed (for PDF/DOCX)
- LaTeX installed (for PDF)
- Report exists in `reports/<NN>-sprint-report.md`

**Examples**:
```bash
/export-findings 01 pdf   # Creates reports/01-sprint-report.pdf
/export-findings 01 docx  # Creates reports/01-sprint-report.docx
/export-findings 01 html  # Creates reports/01-sprint-report.html
```

**Common Errors**:
- Pandoc not found → Install Pandoc: `brew install pandoc` (macOS)
- LaTeX not found → Install BasicTeX or MiKTeX

---

### /validate-quality

**Purpose**: Check research quality against evidence standards.

**Syntax**:
```bash
/validate-quality <sprint-number>
```

**Arguments**:
- `sprint-number` (required) - Two-digit sprint ID (01-10)

**Output**:
- Quality validation report with pass/fail for each criterion
- Remediation recommendations if failures detected

**Quality Criteria**:
- File count ≥25 research files
- Citation ratio ≥80%
- Report length 5,000-7,500 words
- All required sections present
- Terminology consistency
- Cross-reference validity

**Examples**:
```bash
/validate-quality 01
# ✓ File Count: 32 files (requirement: 25+)
# ✓ Citation Ratio: 87% (requirement: 80%+)
# ✓ Report Length: 6,450 words (requirement: 5,000-7,500)
# ⚠ Cross-References: 3 broken links found
# Overall: PASS with minor issues
```

**Remediation**:
- If validation fails, re-execute tasks or manually fix issues
- Re-run `/synthesize-report` after fixes
- Re-validate with `/validate-quality`

---

## Release Management Commands

### /finalize-release

**Purpose**: Create formal release with version tagging and changelog.

**Syntax**:
```bash
/finalize-release <version>
```

**Arguments**:
- `version` (required) - Semantic version (e.g., v1.0, v2.1.3)

**Output**:
- Git release branch: `release/<version>`
- Git tag: `<version>`
- Updated `CHANGELOG.md`
- GitHub release (if configured)

**Process**:
1. Creates release branch from current state
2. Generates changelog from git commits
3. Tags release
4. Pushes to remote repository
5. Archives research artifacts

**Examples**:
```bash
/finalize-release v1.0
/finalize-release v2.1.0
```

**Prerequisites**:
- Git repository initialized
- All changes committed
- Quality validation passed

**Common Errors**:
- Uncommitted changes → Commit all changes first
- Tag already exists → Use next version number

---

## Next Steps

- **Usage**: See [Usage Guide](./USAGE.md) for workflow examples
- **Skills**: Consult [Skills Reference](./SKILLS-REFERENCE.md) for what each command activates
- **Configuration**: Review [Configuration Reference](./CONFIGURATION-REFERENCE.md) for settings
- **Troubleshooting**: Check [Troubleshooting Guide](./TROUBLESHOOTING.md) for common issues

---

**Document Version**: 1.0
**Word Count**: ~1,400 words
**Last Updated**: 2025-11-14
