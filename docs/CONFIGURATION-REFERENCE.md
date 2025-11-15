# Configuration Reference

**Framework**: Strategic Research Automation
**Audience**: Advanced users and developers
**Last Updated**: 2025-11-14

---

This reference documents all configuration schemas for the Strategic Research Automation Framework. Understanding these schemas enables you to customize framework behavior for your industry and use case.

## Table of Contents

- [Configuration Overview](#configuration-overview)
- [project-config.yml](#project-configyml)
- [sprint-config.yml](#sprint-configyml)
- [quality-standards.yml](#quality-standardsyml)
- [scoring-rubric.yml](#scoring-rubricyml)
- [Glossary](#glossary)

---

## Configuration Overview

### Configuration Files

All configuration files reside in `config/`:

| File | Purpose | Scope |
|------|---------|-------|
| `project-config.yml` | Project-wide settings | Global |
| `sprint-config.yml` | Sprint definitions | Per-sprint |
| `quality-standards.yml` | Evidence requirements | Research quality |
| `scoring-rubric.yml` | Opportunity scoring | Prioritization |

### YAML Format

- **Indentation**: 2 spaces (never tabs)
- **Comments**: Use `#` for inline documentation
- **Quotes**: Use for strings with special characters
- **Validation**: Run `/validate-config` to check syntax

### Configuration Hierarchy

```
project-config.yml (global defaults)
  ↓ (overridden by)
sprint-config.yml (sprint-specific settings)
  ↓ (overridden by)
Task files (task-specific customization)
```

---

## project-config.yml

**Purpose**: Global project settings including parallelization, output format, and git configuration.

### Full Schema

```yaml
# Project Information
project:
  name: "Project Name"                    # Required. String. Project display name
  industry: "technology sector"                    # Required. String. Industry vertical
  company: "Company Name"                 # Required. String. Your company name
  created: "2025-11-14"                   # Auto-generated. ISO 8601 date
  version: "1.0.0"                        # Required. Semantic version

# Research Configuration
research:
  parallel_execution: true                # Optional. Boolean. Default: true
  max_parallel_tasks: 5                   # Optional. Integer (1-20). Default: 5
  max_parallel_sprints: 3                 # Optional. Integer (1-10). Default: 3
  timeout_minutes: 120                    # Optional. Integer. Default: 120
  depth: "standard"                       # Optional. Enum: [quick, standard, comprehensive]. Default: standard

# Output Configuration
output:
  format: "markdown"                      # Optional. Enum: [markdown, pdf, docx, html]. Default: markdown
  report_length_min: 5000                 # Optional. Integer. Default: 5000 words
  report_length_max: 7500                 # Optional. Integer. Default: 7500 words
  executive_summary_length: 500           # Optional. Integer. Default: 500 words
  include_appendices: true                # Optional. Boolean. Default: true

# Quality Configuration
quality:
  citation_ratio_min: 0.80                # Optional. Float (0.0-1.0). Default: 0.80
  min_research_files: 25                  # Optional. Integer. Default: 25
  evidence_required: true                 # Optional. Boolean. Default: true
  terminology_check: true                 # Optional. Boolean. Default: true

# Git Configuration
git:
  auto_commit: true                       # Optional. Boolean. Default: true
  auto_push: false                        # Optional. Boolean. Default: false
  branch_prefix: "feature/"               # Optional. String. Default: "feature/"
  commit_message_template: "[Sprint {sprint}] {message}"  # Optional. String template
```

### Field Descriptions

**project.name**:
- Type: String
- Required: Yes
- Description: Descriptive project name (displayed in reports)
- Example: `"Industry Regulation XYZ advanced system Analysis"`

**research.parallel_execution**:
- Type: Boolean
- Default: `true`
- Description: Enable parallel execution of tasks
- Impact: Dramatically reduces execution time for sprints

**research.max_parallel_tasks**:
- Type: Integer (1-20)
- Default: `5`
- Description: Maximum concurrent tasks during MAP phase
- Recommendation: Set to CPU core count or lower

**research.depth**:
- Type: Enum: `quick`, `standard`, `comprehensive`
- Default: `standard`
- Description: Research depth and thoroughness
- `quick`: 3-5 files per task, 15-30 min per sprint
- `standard`: 5-7 files per task, 45-90 min per sprint
- `comprehensive`: 8-10 files per task, 2-3 hours per sprint

**output.format**:
- Type: Enum: `markdown`, `pdf`, `docx`, `html`
- Default: `markdown`
- Description: Default export format for reports
- Note: PDF/DOCX require Pandoc installation

**quality.citation_ratio_min**:
- Type: Float (0.0-1.0)
- Default: `0.80`
- Description: Minimum percentage of claims with citations
- Example: `0.80` = 80% of claims must have evidence

### Example Configurations

**Startup Configuration** (speed-focused):
```yaml
project:
  name: "Startup Opportunity Analysis"
  industry: "SaaS"
  company: "FastGrowth Ventures"

research:
  parallel_execution: true
  max_parallel_tasks: 8                   # Higher for I/O-bound tasks
  depth: "quick"                          # Faster research

output:
  report_length_min: 3000                 # Shorter reports
  report_length_max: 5000

quality:
  citation_ratio_min: 0.70                # Lower evidence threshold
```

**Enterprise Configuration** (thoroughness-focused):
```yaml
project:
  name: "Enterprise Strategic Assessment"
  industry: "Healthcare"
  company: "HealthCorp"

research:
  parallel_execution: false               # Sequential for review gates
  max_parallel_tasks: 3                   # Conservative
  depth: "comprehensive"                  # Thorough research

output:
  report_length_min: 7000                 # Longer reports
  report_length_max: 10000

quality:
  citation_ratio_min: 0.90                # Higher evidence standard
  evidence_required: true
```

---

## sprint-config.yml

**Purpose**: Define all sprints in the portfolio with task structure and priorities.

### Full Schema

```yaml
sprints:
  - id: "01"                              # Required. String (two-digit). Unique sprint ID
    name: "Sprint Name"                   # Required. String. Short descriptive name
    description: "Sprint description"     # Required. String. One-sentence summary
    priority: "high"                      # Optional. Enum: [high, medium, low]. Default: medium
    estimated_duration: "2-3 hours"       # Optional. String. Human-readable estimate

    tasks:
      - id: "01"                          # Required. String. Task ID (01-06)
        name: "Technical Research"        # Required. String. Task name
        parallel_subtasks: 4              # Optional. Integer. Parallel research streams

      - id: "02"
        name: "Market Analysis"
        parallel_subtasks: 3

      - id: "03"
        name: "Solution Architecture"
        parallel_subtasks: 3

      - id: "04"
        name: "Certification Strategy"
        parallel_subtasks: 3

      - id: "05"
        name: "Roadmap Planning"
        parallel_subtasks: 3

      - id: "06"
        name: "Report Synthesis"
        parallel_subtasks: 1              # Always 1 (REDUCE phase)
```

### Field Descriptions

**sprints[].id**:
- Type: String (two-digit: 01-99)
- Required: Yes
- Unique: Yes
- Description: Unique sprint identifier
- Example: `"01"`, `"05"`, `"10"`

**sprints[].priority**:
- Type: Enum: `high`, `medium`, `low`
- Default: `medium`
- Description: Sprint prioritization hint
- Impact: Affects execution order in `/execute-all`

**tasks[].parallel_subtasks**:
- Type: Integer (1-10)
- Description: Number of parallel research streams within task
- Recommendation: 3-5 for most tasks, 1 for Task 06 (synthesis)

### Example Configurations

**technology sector Industry Regulation XYZ Portfolio**:
```yaml
sprints:
  - id: "01"
    name: "operation Control Verification"
    description: "advanced methodology-based verification for advanced system operation control systems under Industry Regulation XYZ"
    priority: "high"
    estimated_duration: "2-3 hours"
    tasks:
      - id: "01"
        name: "Technical Research"
        parallel_subtasks: 4
      # ... tasks 02-06

  - id: "02"
    name: "Propulsion Monitoring"
    description: "Electric propulsion system monitoring and fault detection"
    priority: "high"
    estimated_duration: "2 hours"
    tasks:
      # ... tasks 01-06

  # ... sprints 03-10
```

**Healthcare EHR Portfolio**:
```yaml
sprints:
  - id: "01"
    name: "EHR Interoperability"
    description: "HL7 FHIR-based integration platform for hospital EHR systems"
    priority: "high"
    estimated_duration: "2-3 hours"
    tasks:
      # ... tasks 01-06
```

---

## quality-standards.yml

**Purpose**: Define evidence requirements and quality criteria for research outputs.

### Full Schema

```yaml
# Evidence Standards
evidence:
  citation_required: true                 # Optional. Boolean. Default: true
  min_citation_ratio: 0.80                # Optional. Float (0.0-1.0). Default: 0.80
  citation_format: "apa"                  # Optional. Enum: [apa, mla, chicago]. Default: apa
  primary_sources_preferred: true         # Optional. Boolean. Default: true

# Terminology Standards
terminology:
  consistency_check: true                 # Optional. Boolean. Default: true
  industry_glossary: "config/glossary.yml"  # Optional. String. Path to glossary
  acronym_expansion_first_use: true       # Optional. Boolean. Default: true

# Cross-Reference Standards
cross_references:
  validation_enabled: true                # Optional. Boolean. Default: true
  broken_link_tolerance: 0                # Optional. Integer. Max broken links allowed

# Report Structure Standards
report_structure:
  sections_required:                      # Optional. List of strings
    - "Executive Summary"
    - "Technical Feasibility"
    - "Market Opportunity"
    - "Solution Architecture"
    - "Certification Strategy"
    - "Execution Roadmap"
    - "Investment Requirements"
    - "Risk Assessment"
    - "Recommendation"
  min_section_length: 300                 # Optional. Integer. Words per section

# Recommendations Standards
recommendations:
  evidence_based: true                    # Optional. Boolean. Default: true
  actionable: true                        # Optional. Boolean. Default: true
  quantitative_scoring: true              # Optional. Boolean. Default: true
```

### Example Configurations

**Regulatory-Heavy Industry** (technology sector, Healthcare):
```yaml
evidence:
  citation_required: true
  min_citation_ratio: 0.90                # Higher evidence standard
  primary_sources_preferred: true

terminology:
  consistency_check: true
  industry_glossary: "config/glossary-technology sector.yml"
```

**Fast-Moving Industry** (Consumer Tech, Startups):
```yaml
evidence:
  citation_required: true
  min_citation_ratio: 0.70                # Lower threshold for speed

report_structure:
  min_section_length: 200                 # Shorter sections
```

---

## scoring-rubric.yml

**Purpose**: Define opportunity scoring dimensions, weights, criteria, and thresholds.

### Full Schema

```yaml
scoring:
  dimensions:
    market_opportunity:
      weight: 0.25                        # Required. Float (sum of all weights = 1.0)
      criteria:
        tam_size: 0.30                    # Required. Float (sum of criteria = 1.0)
        growth_rate: 0.25
        customer_willingness: 0.25
        revenue_potential: 0.20

    technical_feasibility:
      weight: 0.20
      criteria:
        technology_maturity: 0.30
        integration_complexity: 0.25
        capability_match: 0.25
        development_timeline: 0.20

    competitive_position:
      weight: 0.15
      criteria:
        differentiation: 0.35
        barriers_to_entry: 0.30
        competitive_landscape: 0.35

    execution_readiness:
      weight: 0.20
      criteria:
        capability_match: 0.30
        resource_requirements: 0.25
        partnership_potential: 0.25
        time_to_market: 0.20

    regulatory_pathway:
      weight: 0.20
      criteria:
        regulatory_clarity: 0.40
        certification_complexity: 0.30
        precedent_availability: 0.20
        timeline_predictability: 0.10

  # Recommendation Thresholds
  thresholds:
    strong_go: 80                         # Optional. Integer (0-100). Default: 80
    go: 65                                # Optional. Integer (0-100). Default: 65
    conditional: 50                       # Optional. Integer (0-100). Default: 50
    no_go: 0                              # Optional. Integer (0-100). Default: 0
```

### Field Descriptions

**dimensions.<dimension>.weight**:
- Type: Float (0.0-1.0)
- Constraint: Sum of all dimension weights must equal 1.0
- Description: Importance weighting for this dimension

**dimensions.<dimension>.criteria.<criterion>**:
- Type: Float (0.0-1.0)
- Constraint: Sum of criteria within dimension must equal 1.0
- Description: Sub-weighting within dimension

**thresholds**:
- Type: Integer (0-100)
- Description: Score ranges for recommendation tiers
- `strong_go`: 80-100 (highly recommended)
- `go`: 65-79 (recommended)
- `conditional`: 50-64 (recommended with conditions)
- `no_go`: 0-49 (not recommended)

### Example Configurations

**Regulatory-Heavy Industry** (technology sector):
```yaml
scoring:
  dimensions:
    regulatory_pathway:
      weight: 0.30                        # Increased from 0.20
      criteria:
        regulatory_clarity: 0.40
        certification_complexity: 0.30
        precedent_availability: 0.20
        timeline_predictability: 0.10

    market_opportunity:
      weight: 0.20                        # Decreased from 0.25
```

**Fast-Moving Market** (Consumer Tech):
```yaml
scoring:
  dimensions:
    execution_readiness:
      weight: 0.30                        # Increased from 0.20
      criteria:
        time_to_market: 0.40              # Increased from 0.20
        mvp_feasibility: 0.30
        agile_development: 0.30

    regulatory_pathway:
      weight: 0.10                        # Decreased from 0.20
```

**Capital-Constrained Startup**:
```yaml
scoring:
  dimensions:
    execution_readiness:
      weight: 0.25
      criteria:
        capital_efficiency: 0.35          # Added custom criterion
        bootstrap_ability: 0.25           # Added custom criterion
        time_to_revenue: 0.40
```

---

## Glossary

**Location**: `config/glossary.yml` (optional)

**Purpose**: Define industry-specific terminology for consistency checking.

### Schema

```yaml
terms:
  - term: "advanced system"
    definition: "Electric Vertical Takeoff and Landing system"
    category: "technology sector"
    preferred: true
    aliases:
      - "electric VTOL"
      - "electric vertical takeoff"

  - term: "Industry Regulation XYZ"
    definition: "Modernization of Special Airworthiness Certification"
    category: "regulation"
    preferred: true
```

---

## Next Steps

- **Usage**: See [Usage Guide](./USAGE.md) for applying configurations
- **Customization**: Read [Customization Guide](./CUSTOMIZATION.md) for industry adaptation
- **Examples**: Review [technology sector Example](./EXAMPLE-technology sector-Industry Regulation XYZ.md) for complete configurations
- **Troubleshooting**: Check [Troubleshooting Guide](./TROUBLESHOOTING.md) for configuration issues

---

**Document Version**: 1.0
**Word Count**: ~950 words
**Last Updated**: 2025-11-14
