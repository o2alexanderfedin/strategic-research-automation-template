# Architecture Documentation

**Framework**: Strategic Research Automation
**Audience**: Advanced users and developers
**Last Updated**: 2025-11-14

---

This document explains the system architecture, design decisions, and technical implementation of the Strategic Research Automation Framework. Understanding the architecture helps you customize the framework, troubleshoot issues, and extend functionality.

## Table of Contents

- [High-Level Architecture](#high-level-architecture)
- [Map-Reduce Paradigm](#map-reduce-paradigm)
- [Component Architecture](#component-architecture)
- [Directory Structure](#directory-structure)
- [Data Flow](#data-flow)
- [Configuration System](#configuration-system)
- [Extension Points](#extension-points)
- [Design Decisions and Trade-offs](#design-decisions-and-trade-offs)

---

## High-Level Architecture

The framework is built on a **map-reduce paradigm** that enables parallel research execution and centralized synthesis.

```
┌─────────────────────────────────────────────────────────────────┐
│                      Context Layer                              │
│  (Company Profile, Client Info, Industry Background)            │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────────────┐
│                  Sprint Orchestrator                            │
│         (Reads sprint config, launches parallel tasks)          │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ↓
┌─────────────────────────────────────────────────────────────────┐
│                    MAP PHASE (Parallel)                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐       │
│  │ Task 01  │  │ Task 02  │  │ Task 03  │  │ Task 04  │  ...  │
│  │Technical │  │ Market   │  │Solution  │  │Compliance│       │
│  │Researcher│  │ Analyst  │  │Architect │  │ Analyst  │       │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘       │
│       │             │             │             │              │
│    6-7 files    5-6 files     6 files      6 files            │
└───────┼─────────────┼─────────────┼─────────────┼──────────────┘
        │             │             │             │
        └─────────────┴─────────────┴─────────────┘
                         │
                         ↓
┌─────────────────────────────────────────────────────────────────┐
│                 REDUCE PHASE (Synthesis)                        │
│                                                                 │
│              Task 06: Report Synthesizer                        │
│    (Aggregates 29-31 files, applies scoring rubric)            │
│                                                                 │
│         Output: 10-page Strategic Assessment Report            │
└─────────────────────────────────────────────────────────────────┘
```

### Key Principles

1. **Parallelization**: Tasks 01-05 execute simultaneously for speed
2. **Specialization**: Each skill focuses on one research dimension
3. **Statelessness**: Skills operate independently with no inter-dependencies
4. **Aggregation**: Single synthesis point (Task 06) produces cohesive report
5. **Configurability**: YAML-based declarative configuration

---

## Map-Reduce Paradigm

The framework applies the map-reduce pattern from distributed computing to strategic research.

### MAP Phase: Parallel Research

**Objective**: Break research into independent, parallelizable tasks

**Implementation**:
- **5 specialized skills** (Tasks 01-05) execute simultaneously
- Each skill receives:
  - Context files (company, client, industry)
  - Task-specific research questions
  - Quality standards
- Each skill produces:
  - 5-7 granular research files
  - Citations and evidence
  - Structured findings

**Characteristics**:
- **Independent**: No communication between skills
- **Stateless**: Each skill starts fresh with context
- **Parallel**: Limited only by CPU cores and `max_parallel_tasks`
- **Scalable**: Add more tasks without affecting others

**Example**:
```
Task 01 (Technical) ──→ 7 files: requirements, regulations, standards, etc.
Task 02 (Market)    ──→ 6 files: market sizing, competitive landscape, etc.
Task 03 (Solution)  ──→ 6 files: architecture, components, integration, etc.
Task 04 (Compliance)──→ 6 files: regulations, testing, certification, etc.
Task 05 (Roadmap)   ──→ 6 files: POC spec, timeline, risks, etc.
```

Total: 31 independent research files

### REDUCE Phase: Synthesis

**Objective**: Aggregate all research into cohesive strategic report

**Implementation**:
- **1 synthesizer skill** (Task 06) executes after all MAP tasks complete
- Reads all 29-31 research files from `temp/<sprint>/`
- Applies scoring rubric from `config/scoring-rubric.yml`
- Generates structured report with:
  - Executive summary
  - Detailed assessments across all dimensions
  - Scoring and recommendation
  - Evidence-based argumentation

**Characteristics**:
- **Sequential**: Waits for all MAP tasks to complete
- **Stateful**: Aggregates state from all research files
- **Single point**: One synthesis ensures coherence
- **Scoring**: Applies quantitative rubric for objectivity

**Output**: `reports/<NN>-sprint-report.md` (5,000-7,500 words)

### Why Map-Reduce?

1. **Speed**: Parallel execution reduces time from days to hours
2. **Scalability**: Add research dimensions without re-architecting
3. **Maintainability**: Skills are independent, easy to modify
4. **Quality**: Specialized skills produce deeper research than generalists
5. **Consistency**: Single synthesis point ensures coherent narrative

---

## Component Architecture

The framework consists of three primary component types: Skills, Commands, and Scripts.

### Skills (MAP and REDUCE Functions)

Skills are specialized AI agents that Claude Code invokes automatically based on context.

**Location**: `.claude/skills/`

**8 Skills**:

1. **Sprint Orchestrator** (`sprint-orchestrator/`)
   - Coordinates multi-sprint execution
   - Resource allocation and prioritization
   - Cross-sprint analysis

2. **Opportunity Discovery** (`opportunity-discovery/`)
   - Analyzes context to identify opportunities
   - Generates sprint definitions automatically
   - Fit scoring and ranking

3. **Technical Researcher** (`technical-researcher/`)
   - Task 01: Technical requirements, regulations, feasibility
   - Outputs 6-7 research files

4. **Market Analyst** (`market-analyst/`)
   - Task 02: TAM/SAM/SOM, competitive landscape, customer needs
   - Outputs 5-6 research files

5. **Solution Architect** (`solution-architect/`)
   - Task 03: System design, architecture, POC specification
   - Outputs 6 research files

6. **Compliance Analyst** (`compliance-analyst/`)
   - Task 04: Regulations, standards, certification strategy
   - Outputs 6 research files

7. **Roadmap Planner** (`roadmap-planner/`)
   - Task 05: POC plan, productization, timeline, risks
   - Outputs 6 research files

8. **Report Synthesizer** (`report-synthesizer/`)
   - Task 06: Aggregation, scoring, strategic report generation
   - Outputs 1 comprehensive report (5,000-7,500 words)

**Skill Structure**:
```
.claude/skills/<skill-name>/
├── SKILL.md         # Skill definition and prompt
└── examples/        # Example outputs (optional)
```

**Skill Activation**:
- Automatic based on context triggers (e.g., "technical research" → technical-researcher)
- Manual via slash commands (e.g., `/execute-task 01 01`)

### Commands (User Interface)

Slash commands provide user-facing interface for common workflows.

**Location**: `.claude/commands/`

**13 Commands**:

| Command | Purpose |
|---------|---------|
| `/init-project` | Initialize project structure |
| `/discover-opportunities` | Autonomous opportunity identification |
| `/create-sprint` | Manual sprint definition |
| `/execute-task` | Execute single task |
| `/execute-sprint` | Execute full sprint (Tasks 01-06) |
| `/execute-all` | Execute all sprints in portfolio |
| `/synthesize-report` | Generate strategic report (Task 06) |
| `/score-opportunity` | Apply scoring rubric to sprint |
| `/compare-sprints` | Cross-sprint prioritization |
| `/export-findings` | Export to PDF/DOCX/HTML |
| `/validate-quality` | Check quality standards |
| `/update-context` | Update context files |
| `/finalize-release` | Git release with tagging |

**Command Structure**:
```
.claude/commands/<command-name>.md
# Markdown file containing command prompt
```

### Scripts (Bash Automation)

Bash scripts provide non-interactive automation for CI/CD and batch execution.

**Location**: `scripts/`

**7 Scripts**:

| Script | Purpose |
|--------|---------|
| `00-discovery-and-execution.sh` | Fully autonomous (discover + execute + export) |
| `01-init-project.sh` | Project initialization |
| `02-create-sprint.sh` | Sprint creation |
| `03-execute-task.sh` | Task execution |
| `04-execute-sprint.sh` | Sprint execution |
| `05-execute-all.sh` | Portfolio execution |
| `06-synthesize-report.sh` | Report synthesis |

**Script Features**:
- YOLO mode for unattended execution (`--yolo` flag)
- Error handling and validation
- Progress logging
- Docker integration (optional)

### Configuration System

YAML-based declarative configuration for all framework behavior.

**Location**: `config/`

**4 Configuration Files**:

| File | Purpose |
|------|---------|
| `project-config.yml` | Project-wide settings (parallelization, output format, git) |
| `sprint-config.yml` | Sprint definitions and task structure |
| `quality-standards.yml` | Evidence requirements, citation ratios, terminology |
| `scoring-rubric.yml` | Opportunity scoring dimensions, weights, thresholds |

**Configuration Hierarchy**:
```
project-config.yml (global defaults)
  ↓
sprint-config.yml (per-sprint overrides)
  ↓
Task files (per-task customization)
```

---

## Directory Structure

```
strategic-research-framework/
├── .claude/                          # Claude Code integration
│   ├── skills/                       # 8 specialized skills
│   │   ├── sprint-orchestrator/
│   │   ├── opportunity-discovery/
│   │   ├── technical-researcher/
│   │   ├── market-analyst/
│   │   ├── solution-architect/
│   │   ├── compliance-analyst/
│   │   ├── roadmap-planner/
│   │   └── report-synthesizer/
│   └── commands/                     # 13 slash commands
│       ├── init-project.md
│       ├── discover-opportunities.md
│       ├── execute-task.md
│       └── ... (10 more commands)
│
├── config/                           # Configuration files
│   ├── project-config.yml            # Project settings
│   ├── sprint-config.yml             # Sprint definitions
│   ├── quality-standards.yml         # Evidence requirements
│   └── scoring-rubric.yml            # Opportunity scoring
│
├── context/                          # Project context
│   ├── company-profile.md            # Your capabilities
│   ├── client-info.md                # Client background
│   └── industry-background.md        # Sector context
│
├── sprints/                          # Sprint and task definitions
│   ├── 01-sprint-name/
│   │   ├── README.md                 # Sprint overview
│   │   ├── 01-technical-research.md
│   │   ├── 02-market-analysis.md
│   │   ├── 03-solution-architecture.md
│   │   ├── 04-certification-strategy.md
│   │   ├── 05-roadmap-planning.md
│   │   └── 06-report-synthesis.md
│   ├── 02-sprint-name/
│   └── ... (up to 10+ sprints)
│
├── temp/                             # Ephemeral research artifacts
│   ├── 01-sprint/
│   │   ├── 01-technical/             # 6-7 files
│   │   ├── 02-market/                # 5-6 files
│   │   ├── 03-solution/              # 6 files
│   │   ├── 04-compliance/            # 6 files
│   │   └── 05-roadmap/               # 6 files
│   └── ... (per sprint)
│
├── reports/                          # Final deliverables
│   ├── 00-opportunity-discovery.md   # Discovery report
│   ├── 00-sprint-comparison.md       # Prioritization matrix
│   ├── 01-sprint-report.md           # Sprint 01 report
│   ├── 02-sprint-report.md           # Sprint 02 report
│   └── ... (per sprint)
│
├── templates/                        # Reusable templates
│   ├── sprint-readme.md
│   ├── task-template.md
│   └── report-template.md
│
├── scripts/                          # Bash automation
│   ├── 00-discovery-and-execution.sh
│   ├── 01-init-project.sh
│   └── ... (7 scripts total)
│
├── examples/                         # Industry examples
│   ├── technology sector-mosaic/
│   ├── healthcare-ehr/
│   └── fintech-regtech/
│
├── docs/                             # Documentation
│   ├── README.md
│   ├── SETUP.md
│   ├── QUICK-START.md
│   ├── USAGE.md
│   ├── CUSTOMIZATION.md
│   ├── ARCHITECTURE.md               # This document
│   ├── SKILLS-REFERENCE.md
│   ├── COMMANDS-REFERENCE.md
│   ├── CONFIGURATION-REFERENCE.md
│   ├── TROUBLESHOOTING.md
│   ├── CONTRIBUTING.md
│   ├── EXAMPLE-technology sector-Industry Regulation XYZ.md
│   └── EXAMPLE-HEALTHCARE-CONVERSION.md
│
├── .gitignore                        # Git ignore (temp/ excluded)
├── CHANGELOG.md                      # Version history
└── LICENSE                           # MIT License
```

### Key Directory Purposes

- **`.claude/`**: Framework integration with Claude Code (skills and commands)
- **`config/`**: Declarative configuration (YAML files)
- **`context/`**: Project-specific background information
- **`sprints/`**: Sprint and task definitions (persistent)
- **`temp/`**: Ephemeral research files (gitignored, regenerable)
- **`reports/`**: Final deliverables (committed to git)
- **`scripts/`**: Automation for batch execution
- **`docs/`**: Comprehensive documentation

---

## Data Flow

### Sprint Execution Flow

```
1. User Command
   /execute-sprint 01
        ↓
2. Sprint Orchestrator Skill
   - Reads config/sprint-config.yml
   - Reads context/*.md files
   - Identifies Tasks 01-05 for parallel execution
        ↓
3. Parallel MAP Phase (Tasks 01-05)
   ┌─────────────────────────────────────┐
   │ Task 01: Technical Researcher Skill │
   │  - Reads sprints/01/01-technical.md │
   │  - Conducts research                │
   │  - Writes temp/01/01-technical/*.md │
   │  - Outputs 6-7 files                │
   └─────────────────────────────────────┘
   [... Tasks 02-05 in parallel ...]
        ↓
4. REDUCE Phase (Task 06)
   Report Synthesizer Skill
   - Reads all temp/01/*/*.md files (29-31 files)
   - Reads config/scoring-rubric.yml
   - Applies scoring criteria
   - Generates reports/01-sprint-report.md
        ↓
5. Quality Validation (Optional)
   /validate-quality 01
   - Checks file count (25+ required)
   - Checks citation ratio (80%+ required)
   - Validates terminology consistency
        ↓
6. Export (Optional)
   /export-findings 01 pdf
   - Converts markdown to PDF via Pandoc
   - Outputs reports/01-sprint-report.pdf
```

### Configuration Flow

```
Context Files (context/*.md)
    ↓
Project Config (config/project-config.yml)
    ↓
Sprint Config (config/sprint-config.yml)
    ↓
Task Files (sprints/*/0X-task.md)
    ↓
Skill Execution (reads all above)
    ↓
Research Files (temp/*)
    ↓
Scoring Rubric (config/scoring-rubric.yml)
    ↓
Strategic Report (reports/*)
```

### Validation Flow

```
Research Files (temp/*)
    ↓
Quality Validator
  ├─→ File Count Check (min 25 files)
  ├─→ Citation Ratio Check (min 80%)
  ├─→ Terminology Consistency Check
  ├─→ Cross-Reference Validation
  └─→ Report Structure Check
    ↓
Validation Report
  ├─→ PASS: Proceed to export
  └─→ FAIL: Remediation required
```

---

## Configuration System

The configuration system uses YAML for human-readable, version-controlled settings.

### Configuration Architecture

```
config/
├── project-config.yml         # Global project settings
├── sprint-config.yml          # Sprint definitions
├── quality-standards.yml      # Evidence requirements
└── scoring-rubric.yml         # Opportunity scoring
```

### Configuration Validation

**Validation occurs at**:
1. Project initialization (`/init-project`)
2. Sprint creation (`/create-sprint`)
3. Execution start (`/execute-sprint`)

**Validation rules**:
- Required fields present
- Valid value ranges
- Dependency constraints (e.g., weights sum to 1.0)
- YAML syntax correctness

**Example validation**:
```yaml
# Scoring rubric validation
scoring:
  dimensions:
    market_opportunity:
      weight: 0.25
    technical_feasibility:
      weight: 0.20
    # ... other dimensions ...

# Validation: sum of weights must equal 1.0
# If not, error: "Scoring weights sum to 0.85, must equal 1.0"
```

### Configuration Inheritance

**Hierarchy**:
```
project-config.yml (baseline defaults)
  ↓ (overridden by)
sprint-config.yml (sprint-specific settings)
  ↓ (overridden by)
Task files (task-specific customization)
```

**Example**:
```yaml
# project-config.yml
research:
  max_parallel_tasks: 5

# sprint-config.yml (Sprint 03)
sprints:
  - id: "03"
    research:
      max_parallel_tasks: 3  # Overrides global setting for Sprint 03 only
```

---

## Extension Points

The framework provides multiple extension points for customization.

### 1. Custom Skills

Create industry-specific skill variants by copying existing skills.

**Example**: Healthcare compliance analyst skill

```bash
# Copy base skill
cp -r .claude/skills/compliance-analyst .claude/skills/healthcare-compliance-analyst

# Edit .claude/skills/healthcare-compliance-analyst/SKILL.md
# Modify activation triggers and research areas
```

See [Customization Guide](./CUSTOMIZATION.md#skill-customization) for details.

### 2. Custom Commands

Add domain-specific slash commands.

**Example**: Generate compliance checklist command

```bash
# Create new command
touch .claude/commands/generate-compliance-checklist.md

# Define command behavior in markdown file
```

See [Command Customization](./CUSTOMIZATION.md#command-customization) for details.

### 3. Custom Scoring Criteria

Add new scoring dimensions or criteria.

**Example**: Environmental impact scoring

```yaml
# config/scoring-rubric.yml
scoring:
  dimensions:
    environmental_impact:  # New custom dimension
      weight: 0.15
      criteria:
        carbon_reduction: 0.40
        sustainability: 0.30
        esg_alignment: 0.30
```

### 4. Custom Quality Standards

Define industry-specific evidence requirements.

**Example**: Clinical validation for healthcare

```yaml
# config/quality-standards.yml
quality:
  evidence:
    clinical_validation_required: true  # Healthcare-specific
    minimum_study_size: 100             # Healthcare-specific
```

### 5. Template Customization

Modify report templates for branding or structure.

```bash
# Edit report template
vim templates/report-template.md
```

---

## Design Decisions and Trade-offs

### Why Map-Reduce?

**Decision**: Use map-reduce paradigm for research workflow

**Rationale**:
- **Parallelization**: Dramatically reduces execution time (days → hours)
- **Scalability**: Add research dimensions without re-architecting
- **Maintainability**: Independent skills are easy to modify
- **Quality**: Specialization produces deeper research than generalists

**Trade-offs**:
- **Complexity**: More moving parts than monolithic approach
- **Coordination**: Requires orchestration layer (Sprint Orchestrator skill)
- **Context duplication**: Each skill re-reads context files

**Alternative considered**: Sequential execution with single generalist skill
- **Rejected because**: Too slow for multi-sprint portfolios

### Why YAML Configuration?

**Decision**: Use YAML for all configuration

**Rationale**:
- **Human-readable**: Non-technical users can edit
- **Version control friendly**: Diffs are clear
- **Validation**: Schema validation tools available
- **Portability**: Language-agnostic format

**Trade-offs**:
- **Indentation sensitivity**: YAML errors are cryptic
- **Limited data types**: No functions or complex logic

**Alternative considered**: JSON
- **Rejected because**: Less readable, no comments

### Why Claude Code Skills?

**Decision**: Use Claude Code skills for AI agent implementation

**Rationale**:
- **Context-aware**: Skills activate based on semantic triggers
- **Model-invoked**: No manual orchestration needed
- **Reusable**: Skills work across projects
- **Maintained**: Anthropic maintains Claude Code framework

**Trade-offs**:
- **Claude Code dependency**: Requires Claude Code CLI
- **Skill syntax**: Learning curve for skill definition

**Alternative considered**: LangChain agents
- **Rejected because**: More complex, less maintained

### Why Bash Scripts?

**Decision**: Use bash for automation scripts

**Rationale**:
- **Universal**: Available on all Unix-like systems
- **Simple**: No dependencies beyond bash and Claude Code
- **Portable**: Works on macOS, Linux, Windows (WSL)
- **Transparent**: Easy to read and modify

**Trade-offs**:
- **Limited features**: No complex data structures
- **Error handling**: Bash error handling is verbose

**Alternative considered**: Python scripts
- **Rejected because**: Adds dependency, overkill for simple automation

### Why Git Flow?

**Decision**: Use git flow for release management

**Rationale**:
- **Structured**: Clear branching model (develop, release, master)
- **Audit trail**: Version history for recommendations
- **Collaboration**: Standard workflow if team grows
- **Rollback**: Easy to revert to previous releases

**Trade-offs**:
- **Overhead**: More complex than simple git workflow
- **Solo development**: Git flow is designed for teams (less critical for solo)

**Alternative considered**: Trunk-based development
- **Rejected because**: Less clear for milestone tracking

---

## Next Steps

- **Implementation**: See [Setup Guide](../SETUP.md) for installation
- **Usage**: Read [Usage Guide](./USAGE.md) for workflows
- **Customization**: Consult [Customization Guide](./CUSTOMIZATION.md) for adaptation
- **Reference**: Review [Skills Reference](./SKILLS-REFERENCE.md) and [Commands Reference](./COMMANDS-REFERENCE.md)
- **Examples**: Explore [technology sector Example](./EXAMPLE-technology sector-Industry Regulation XYZ.md)

---

**Document Version**: 1.0
**Word Count**: ~1,900 words
**Last Updated**: 2025-11-14
