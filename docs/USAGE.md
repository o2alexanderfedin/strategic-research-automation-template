# Usage Guide

**Framework**: Strategic Research Automation
**Audience**: Users executing research workflows
**Last Updated**: 2025-11-14

---

This guide walks you through the complete workflow for using the Strategic Research Automation Framework, from project initialization to final report delivery. Each section covers one major phase of the workflow with practical examples and best practices.

## Table of Contents

- [Project Initialization](#project-initialization)
- [Sprint Creation and Management](#sprint-creation-and-management)
- [Context Management](#context-management)
- [Execution Workflows](#execution-workflows)
- [Report Synthesis and Export](#report-synthesis-and-export)
- [Quality Validation](#quality-validation)
- [Comparison and Prioritization](#comparison-and-prioritization)
- [Finalization and Release](#finalization-and-release)
- [Best Practices](#best-practices)

---

## Project Initialization

The `/init-project` command sets up your complete project structure with all necessary directories, configuration files, and templates.

### Command Syntax

```bash
/init-project "<project-name>" "<industry>" "<company-name>"
```

**Arguments**:
- `project-name` - Descriptive name for your research project
- `industry` - Industry vertical (technology sector, healthcare, fintech, etc.)
- `company-name` - Your company or consultancy name

### What Gets Created

The command generates:

1. **Directory Structure**:
   - `.claude/` - Skills and commands for Claude Code integration
   - `config/` - All configuration files (project, sprint, quality, scoring)
   - `context/` - Company profile and client information templates
   - `sprints/` - Sprint and task definition directories
   - `temp/` - Research artifacts (ephemeral)
   - `reports/` - Final strategic reports
   - `templates/` - Reusable file templates
   - `scripts/` - Bash automation scripts
   - `examples/` - Industry-specific examples

2. **Configuration Files**:
   - `config/project-config.yml` - Project-wide settings
   - `config/sprint-config.yml` - Sprint definitions (empty initially)
   - `config/quality-standards.yml` - Evidence and citation requirements
   - `config/scoring-rubric.yml` - Opportunity prioritization criteria

3. **Context Templates**:
   - `context/company-profile.md` - Your capabilities and expertise
   - `context/client-info.md` - Client background and needs
   - `context/industry-background.md` - Sector-specific context

4. **Git Repository**:
   - Initializes git repository
   - Creates `.gitignore` for temp files
   - Makes initial commit

### Example Usage

```bash
# technology sector industry example
/init-project "Industry Regulation XYZ advanced system Analysis" "technology sector" "TechCo"

# Healthcare industry example
/init-project "EHR Integration Study" "Healthcare" "HealthTech Consulting"

# FinTech industry example
/init-project "RegTech Compliance Analysis" "FinTech" "Compliance Advisors"
```

### Next Steps After Initialization

1. Edit `context/company-profile.md` with your actual capabilities
2. Fill in `context/client-info.md` with client details
3. Customize `context/industry-background.md` for your sector
4. Review and adjust `config/scoring-rubric.yml` weights
5. Proceed to sprint creation or opportunity discovery

---

## Sprint Creation and Management

Sprints are complete research cycles covering one specific opportunity. Each sprint contains 6 standardized tasks that execute in parallel (Tasks 01-05) followed by synthesis (Task 06).

### Using `/create-sprint` Command

```bash
/create-sprint <sprint-number> "<sprint-name>" "<description>"
```

**Arguments**:
- `sprint-number` - Two-digit sprint ID (01, 02, etc.)
- `sprint-name` - Short descriptive name
- `description` - One-sentence opportunity summary

**What it creates**:
- `sprints/<NN>-<name>/` directory
- `sprints/<NN>-<name>/README.md` - Sprint overview
- Six task files: `01-technical-research.md` through `06-report-synthesis.md`
- Entry in `config/sprint-config.yml`

### Example Sprint Creation

```bash
# Create sprint for advanced system operation control opportunity
/create-sprint 01 "operation Control Verification" "advanced methodology-based verification for advanced system operation control systems under Industry Regulation XYZ regulations"

# Create sprint for EHR interoperability
/create-sprint 02 "EHR Interoperability" "HL7 FHIR-based integration platform for hospital EHR systems"
```

### Manual Sprint Editing

After creation, customize task files to include industry-specific research questions:

**Example**: `sprints/01-operation-control/01-technical-research.md`

```markdown
# Task 01: Technical Requirements Research
## Sprint 01: operation Control Verification

**Objective**: Analyze technical requirements, regulations, competitive technologies, and feasibility for advanced methodology-verified advanced system operation control systems.

---

## Research Questions

### Technical Requirements Analysis
1. What are the specific technical requirements for advanced system operation control systems under Industry Regulation XYZ regulations?
2. Which Design Assurance Level (DAL) applies to these systems under Industry Standard ABC?
3. What are the performance, safety, and reliability requirements?

### Regulatory Standards
1. Which ASTM standards govern Industry Regulation XYZ system avionics systems?
2. How does Compliance Framework DEF advanced methodologies guidance apply to advanced verification?
3. What are the TSO (Technical Standard Order) requirements?

[... additional sections ...]
```

### Sprint Configuration

Sprints are tracked in `config/sprint-config.yml`:

```yaml
sprints:
  - id: "01"
    name: "operation Control Verification"
    description: "advanced methodology-based verification for advanced system operation control systems"
    priority: "high"
    estimated_duration: "2-3 hours"
    tasks:
      - id: "01"
        name: "Technical Research"
        parallel_subtasks: 4
      - id: "02"
        name: "Market Analysis"
        parallel_subtasks: 3
      # ... tasks 03-06
```

---

## Context Management

Context files provide background information that informs all research. Keep these updated as your company capabilities evolve or client needs change.

### Using `/update-context` Command

```bash
/update-context
```

This command prompts you to review and update:
- Company capabilities and expertise
- Client information and requirements
- Industry background and trends
- Competitive landscape

### When to Update Context

Update context files when:
- Starting a new client engagement
- Your company acquires new capabilities
- Industry regulations change significantly
- Team composition shifts (new expertise areas)
- Market dynamics evolve

### Context File Structure

**`context/company-profile.md`** - Your capabilities:
```markdown
# Company Profile: TechCo

## Core Capabilities

### advanced verification Expertise
- Z3, CVC5, and custom verification solver integration
- Compliance Framework DEF advanced methodologies compliance
- Safety-critical systems verification
- 15+ years combined team experience

[... detailed capabilities ...]
```

**`context/client-info.md`** - Client details:
```markdown
# Client Information: Ben Errez

## Background
Entrepreneur exploring new system category and advanced system opportunities. Focus on identifying high-value entry points for advanced methodology-verified avionics systems.

## Objectives
1. Identify top 3-5 opportunities for advanced verification in Industry Regulation XYZ context
2. Prioritize by market size, regulatory clarity, and competitive position
3. Develop go/no-go recommendations with execution roadmaps

[... additional details ...]
```

---

## Execution Workflows

The framework supports four execution modes, from single-task granularity to full portfolio automation.

### 1. Single Task Execution

Execute one specific task within a sprint for focused research or iterative refinement.

**Command**:
```bash
/execute-task <sprint-number> <task-number>
```

**Example**:
```bash
/execute-task 01 01  # Execute Sprint 01, Task 01 (Technical Research)
```

**What happens**:
1. Claude Code activates the appropriate skill (e.g., `technical-researcher` for Task 01)
2. Skill reads context files and task research questions
3. Conducts comprehensive research across all question areas
4. Generates 6-7 granular research files in `temp/01-sprint/01-technical/`
5. Each file contains citations, evidence, and structured findings

**Use cases**:
- Testing a single task before full sprint execution
- Refining research after quality validation feedback
- Deep-diving on one specific area
- Debugging task configuration

### 2. Complete Sprint Execution

Execute all tasks within one sprint with parallel execution of Tasks 01-05, followed by synthesis (Task 06).

**Command**:
```bash
/execute-sprint <sprint-number>
```

**Example**:
```bash
/execute-sprint 01  # Execute entire Sprint 01
```

**Execution flow**:
```
1. Tasks 01-05 execute in parallel (map phase):
   - Task 01: Technical Researcher skill → 6-7 files
   - Task 02: Market Analyst skill → 5-6 files
   - Task 03: Solution Architect skill → 6 files
   - Task 04: Compliance Analyst skill → 6 files
   - Task 05: Roadmap Planner skill → 6 files

2. Task 06 executes after all complete (reduce phase):
   - Report Synthesizer skill aggregates all 29-31 files
   - Applies scoring rubric
   - Generates 10-page strategic report in reports/01-sprint-report.md
```

**Duration**: 45-90 minutes depending on research complexity

**Output**:
- 29-31 research files in `temp/01-sprint/`
- 1 comprehensive report in `reports/01-sprint-report.md`
- Quality metrics log

**Use cases**:
- Standard workflow for single-opportunity analysis
- Detailed assessment before portfolio comparison
- Client deliverable generation

### 3. Full Portfolio Execution

Execute all configured sprints sequentially or in parallel batches.

**Command**:
```bash
/execute-all
```

**What happens**:
1. Reads all sprints from `config/sprint-config.yml`
2. Executes sprints based on `max_parallel_sprints` setting
3. Generates individual reports for each sprint
4. Creates cross-sprint comparison analysis
5. Produces prioritized recommendation report

**Execution flow**:
```
Sprint 01 ────┐
Sprint 02 ────┼──→ Parallel execution (respects max_parallel_sprints)
Sprint 03 ────┘
     ↓
Individual Reports (01-sprint-report.md, 02-sprint-report.md, ...)
     ↓
Cross-Sprint Analysis (/compare-sprints)
     ↓
Prioritization Report (00-sprint-comparison.md)
```

**Duration**: 6-15 hours for 10 sprints (depending on parallelization)

**Output**:
- Individual reports for each sprint
- `reports/00-sprint-comparison.md` - Comparative analysis
- Prioritized recommendation matrix

**Use cases**:
- Comprehensive opportunity portfolio analysis
- Strategic planning with multiple options
- Client presentations requiring full landscape view

### 4. Autonomous Discovery + Execution

Fully autonomous mode: analyze context, discover opportunities, generate sprints, and execute entire portfolio.

**Command sequence**:
```bash
/discover-opportunities  # Analyzes context, identifies 5-10 opportunities
/execute-all            # Executes all discovered sprints
```

**Discovery process**:
1. Reads `context/company-profile.md` (your capabilities)
2. Reads `context/client-info.md` (client needs)
3. Reads `context/industry-background.md` (market context)
4. Identifies 5-10 high-fit opportunities
5. Generates sprint definitions automatically
6. Updates `config/sprint-config.yml`

**Example output** (`reports/00-opportunity-discovery.md`):
```markdown
# Opportunity Discovery Report

Based on analysis of TechCo's advanced verification expertise and Industry Regulation XYZ technology sector context:

## Top 10 Opportunities Identified

1. **advanced system operation Control Verification** (Fit Score: 94/100)
   - Excellent capability match with advanced verification
   - Clear regulatory pathway (Industry Standard ABC, ASTM)
   - High market potential ($15B TAM)

2. **Propulsion System Safety Validation** (Fit Score: 89/100)
   [...]

[... 8 more opportunities ...]
```

**Use cases**:
- Rapid client engagement initiation
- Exploratory research without predefined opportunities
- Teaching the framework your domain over time

---

## Report Synthesis and Export

After execution, synthesize findings into strategic reports and export to client-ready formats.

### Report Synthesis

**Command**:
```bash
/synthesize-report <sprint-number>
```

**Example**:
```bash
/synthesize-report 01
```

**What it does**:
1. Aggregates all research files from `temp/01-sprint/`
2. Applies scoring rubric from `config/scoring-rubric.yml`
3. Generates structured report:
   - Executive Summary
   - Technical Feasibility Assessment
   - Market Opportunity Analysis
   - Competitive Landscape
   - Certification Strategy
   - Execution Roadmap
   - Investment Requirements
   - Risk Assessment
   - Recommendation (STRONG GO / GO / CONDITIONAL GO / NO GO)
   - Appendices (research file index)

**Output**: `reports/01-sprint-report.md` (5,000-7,500 words)

### Report Export

Convert markdown reports to professional formats for client delivery.

**Command**:
```bash
/export-findings <sprint-number> <format>
```

**Supported formats**:
- `pdf` - Professional PDF with formatting
- `docx` - Microsoft Word document
- `html` - Standalone HTML file

**Examples**:
```bash
/export-findings 01 pdf   # Creates reports/01-sprint-report.pdf
/export-findings 01 docx  # Creates reports/01-sprint-report.docx
/export-findings 01 html  # Creates reports/01-sprint-report.html
```

**Batch export** (all sprints):
```bash
for i in {01..10}; do
  /export-findings $i pdf
done
```

**Requirements**:
- Pandoc installed for PDF/DOCX export
- LaTeX (for PDF) or leave as HTML

---

## Quality Validation

Ensure research meets evidence standards before client delivery.

### Validation Command

```bash
/validate-quality <sprint-number>
```

**Example**:
```bash
/validate-quality 01
```

### Quality Criteria Checked

1. **File Count**: Minimum 25 research files generated
2. **Citation Ratio**: At least 80% of claims have citations
3. **Terminology Consistency**: Industry terms used correctly
4. **Cross-References**: Internal links between research files work
5. **Report Completeness**: All required sections present
6. **Evidence Standards**: Claims supported by data or precedents

### Example Output

```
Quality Validation Report: Sprint 01

✅ File Count: 32 files (requirement: 25+)
✅ Citation Ratio: 87% (requirement: 80%+)
✅ Report Length: 6,450 words (requirement: 5,000-7,500)
✅ Terminology: Consistent usage of Industry Regulation XYZ, Industry Standard ABC, DAL, advanced system
⚠️  Cross-References: 3 broken links found
✅ Evidence: All claims supported

Overall: PASS with minor issues

Remediation:
- Fix broken links in temp/01-sprint/03-architecture/component-designs.md
```

### Remediation Workflow

If validation fails:
1. Review specific issues identified
2. Re-execute problematic tasks: `/execute-task 01 03`
3. Manually edit research files if needed
4. Re-synthesize report: `/synthesize-report 01`
5. Re-validate: `/validate-quality 01`

---

## Comparison and Prioritization

Compare multiple sprints to prioritize execution and resource allocation.

### Comparison Command

```bash
/compare-sprints
```

**What it does**:
1. Reads all sprint reports from `reports/`
2. Extracts scores across all dimensions
3. Generates comparison matrix
4. Categorizes into tiers (Tier 1, 2, 3)
5. Recommends execution sequence

### Example Output

`reports/00-sprint-comparison.md`:

```markdown
# Sprint Comparison and Prioritization

## Scoring Matrix

| Sprint | Market | Technical | Competitive | Execution | Regulatory | **Total** | Tier |
|--------|--------|-----------|-------------|-----------|------------|-----------|------|
| 01: operation Control | 85 | 92 | 78 | 88 | 90 | **87** | 1 |
| 03: Propulsion | 82 | 89 | 75 | 85 | 88 | **84** | 1 |
| 02: Navigation | 78 | 85 | 80 | 80 | 82 | **81** | 2 |
| 05: Ground Control | 75 | 80 | 70 | 85 | 78 | **78** | 2 |
| 04: Data Recording | 70 | 75 | 65 | 80 | 75 | **73** | 2 |
[... remaining sprints ...]

## Tier 1 Recommendations (STRONG GO)
- Sprint 01: operation Control Verification
- Sprint 03: Propulsion System Safety

Execute immediately. High scores across all dimensions.

## Tier 2 Recommendations (GO)
- Sprint 02: Navigation Systems
- Sprint 05: Ground Control
- Sprint 04: Data Recording

Execute after Tier 1 or in parallel if resources permit.

[... detailed analysis ...]
```

### Use Cases

- Client presentation: "Here are our top 3 recommended opportunities"
- Resource planning: Allocate budget to highest-scoring sprints
- Strategic roadmap: Sequence execution by tier
- Risk management: Identify sprints with regulatory or competitive concerns

---

## Finalization and Release

Create a formal release with version tagging when work is complete.

### Release Command

```bash
/finalize-release <version>
```

**Example**:
```bash
/finalize-release v1.0
```

**What it does**:
1. Creates git release branch: `release/v1.0`
2. Updates `CHANGELOG.md` with all changes
3. Tags release: `git tag v1.0`
4. Pushes to remote repository
5. Creates GitHub release (if configured)
6. Archives research artifacts

**Changelog generation**:
```markdown
# Changelog

## [v1.0] - 2025-11-14

### Sprints Completed
- Sprint 01: operation Control Verification (Score: 87/100 - STRONG GO)
- Sprint 02: Navigation Systems (Score: 81/100 - GO)
[... all sprints ...]

### Reports Generated
- 10 individual sprint reports
- 1 comparative analysis report
- 11 total deliverables

### Research Artifacts
- 312 research files generated
- 87% average citation ratio
- All quality validations passed
```

### Use Cases

- Client deliverable handoff
- Internal milestone tracking
- Version control for iterative engagements
- Audit trail for recommendations

---

## Best Practices

### Start Small, Scale Up

1. Begin with a single sprint to understand workflow
2. Validate quality and iterate on configuration
3. Then execute full portfolio with `/execute-all`

### Update Context Regularly

- Keep `context/company-profile.md` current as capabilities evolve
- Update `context/client-info.md` when requirements change
- Refresh `context/industry-background.md` quarterly

### Use Git Commits Frequently

- Commit after each sprint completion
- Tag major milestones with `/finalize-release`
- Push to remote for backup and collaboration

### Customize for Your Industry

- Adjust `config/scoring-rubric.yml` weights for sector priorities
- Modify task research questions for domain-specific terminology
- Update quality standards for evidence requirements

### Validate Before Delivery

- Always run `/validate-quality` before exporting
- Review reports manually for clarity and accuracy
- Cross-check citations and data points

### Export to Multiple Formats

```bash
/export-findings 01 pdf   # For formal presentations
/export-findings 01 docx  # For collaborative editing
/export-findings 01 html  # For web publishing
```

### Leverage Parallel Execution

Configure `max_parallel_tasks` in `config/project-config.yml`:
```yaml
research:
  parallel_execution: true
  max_parallel_tasks: 8  # Adjust based on CPU cores
```

---

## Next Steps

- **New users**: Start with [Quick Start Guide](../QUICK-START.md)
- **Customization**: See [Customization Guide](./CUSTOMIZATION.md)
- **Reference**: Consult [Skills Reference](./SKILLS-REFERENCE.md) and [Commands Reference](./COMMANDS-REFERENCE.md)
- **Troubleshooting**: Review [Troubleshooting Guide](./TROUBLESHOOTING.md)
- **Advanced**: Explore [Architecture Documentation](./ARCHITECTURE.md)

---

**Document Version**: 1.0
**Word Count**: ~2,350 words
**Last Updated**: 2025-11-14
