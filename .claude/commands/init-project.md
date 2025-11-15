---
description: Initialize a new strategic research project with complete directory structure and configuration
argument-hint: [project-name] [industry] [company-name]
allowed-tools: Bash, Read, Write, Glob
---

# Initialize New Strategic Research Project

You are executing the `/init-project` command to initialize a new strategic research project from this template repository.

## Purpose

Initialize a new strategic research project with parameterized configuration, establishing the foundation for sprint-based opportunity analysis across any industry and company combination. This command creates the complete directory structure, configuration files, context templates, and git repository needed for research automation.

## Steps to Execute

### Step 1: Validate Arguments

**Validate all three required arguments:**

- **$1 (project-name)**: Must be provided, alphanumeric with hyphens, 3-50 characters
  - If empty or invalid: ERROR "Project name is required. Format: lowercase-with-hyphens"
  - Example: "technology sector-opportunity-analysis", "ai-manufacturing-study"

- **$2 (industry)**: Must be provided, describe target industry
  - If empty: ERROR "Industry is required. Examples: technology sector, healthcare, fintech, manufacturing"
  - Length: 3-30 characters

- **$3 (company-name)**: Must be provided, host company conducting research
  - If empty: ERROR "Company name is required. Example: 'TechCo' or 'Acme Consulting'"

**Check prerequisites:**
- Verify current directory is template repository
- Confirm project directory doesn't already exist: ./$1/
  - If exists: ERROR "Project directory already exists. Choose different name or delete existing."

### Step 2: Create Directory Structure

Use Bash tool to create complete directory structure:

```bash
mkdir -p sprints temp reports config context
```

Required directories:
- **sprints/**: Sprint definitions and task files
- **temp/**: Research findings workspace (output from skills)
- **reports/**: Final strategic reports and syntheses
- **config/**: Project configuration files
- **context/**: Client and company profile information

### Step 3: Initialize Configuration Files

Use Write tool to create all configuration files with parameterized content:

**Create config/project-config.yml:**
```yaml
# Project Configuration - Strategic Research Automation
project:
  name: "$1"
  company: "$3"
  client: "To be specified"  # User should populate after initialization
  industry: "$2"
  analysis_type: "strategic_opportunity"
  created_date: "{{current_date}}"

research:
  parallel_execution: true
  max_parallel_tasks: 8  # Adjust based on CPU cores
  evidence_required: true
  citation_style: "APA"
  minimum_file_count: 25  # Per sprint

quality:
  dual_audience: true  # Business + technical
  synthesis_required: true
  scoring_enabled: true
  citation_density_threshold: 0.80  # 80% of claims must be cited

output:
  temp_directory: "temp"
  reports_directory: "reports"
  export_formats:
    - "markdown"
    - "pdf"  # Requires pandoc
```

**Create config/sprint-config.yml:**
```yaml
# Sprint Configuration
# Add sprints using /create-sprint or /discover-opportunities
sprints: []
```

**Create config/quality-standards.yml:**
```yaml
# Quality Control Standards
evidence:
  citations_required: true
  minimum_citation_density: 0.80
  sources:
    - "industry_regulations"
    - "academic_research"
    - "market_reports"
    - "competitor_analysis"
    - "technical_documentation"

structure:
  minimum_files_per_task: 5
  minimum_files_per_sprint: 25
  synthesis_required: true
  report_min_words: 5000
  report_max_words: 7500

required_sections:
  - "Executive Summary"
  - "Market Opportunity"
  - "Technical Approach"
  - "Certification & Timeline"
  - "Implementation Strategy"
  - "Risk Assessment"
  - "Go/No-Go Recommendation"
```

**Create config/scoring-rubric.yml:**
```yaml
# Opportunity Scoring Rubric
dimensions:
  market_opportunity:
    weight: 0.25
    criteria:
      tam_sam_som: { weight: 0.40, description: "Market size and addressable opportunity" }
      growth_rate: { weight: 0.30, description: "Market growth trajectory (CAGR)" }
      customer_pain: { weight: 0.30, description: "Severity and urgency of problem" }

  technical_feasibility:
    weight: 0.25
    criteria:
      technology_readiness: { weight: 0.40, description: "TRL level and maturity" }
      team_capability: { weight: 0.30, description: "Team expertise alignment" }
      risk_level: { weight: 0.30, description: "Technical risk assessment" }

  competitive_advantage:
    weight: 0.20
    criteria:
      differentiation: { weight: 0.50, description: "Unique value proposition strength" }
      moat_strength: { weight: 0.50, description: "Defensibility and barriers to entry" }

  execution_readiness:
    weight: 0.15
    criteria:
      timeline: { weight: 0.30, description: "Speed to market" }
      investment: { weight: 0.30, description: "Capital efficiency" }
      partnerships: { weight: 0.40, description: "Required partnerships and availability" }

  regulatory_pathway:
    weight: 0.15
    criteria:
      clarity: { weight: 0.40, description: "Regulatory path clarity" }
      precedents: { weight: 0.30, description: "Similar approvals exist" }
      timeline: { weight: 0.30, description: "Certification timeline predictability" }

recommendation_tiers:
  strong_go: { range: [80, 100], action: "Execute immediately - high confidence" }
  go: { range: [65, 79], action: "Execute soon - good opportunity" }
  conditional_go: { range: [50, 64], action: "Conditional - requires mitigation" }
  no_go: { range: [0, 49], action: "Do not pursue - risks outweigh benefits" }
```

### Step 4: Create Context Templates

Use Write tool to create context template files:

**Create context/client-info.md:**
```markdown
# Client Information

## Client Overview
- **Client Name**: [Client or "Internal" for internal initiatives]
- **Industry**: $2
- **Geography**: [Primary markets]
- **Company Size**: [Employees, revenue, market cap]

## Strategic Context
### Business Objectives
- [Key strategic goals]
- [Growth targets]
- [Market position aspirations]

### Pain Points & Challenges
- [Critical problems to solve]
- [Inefficiencies or gaps]
- [Regulatory or competitive pressures]

### Requirements & Constraints
- **Budget**: [Available investment range]
- **Timeline**: [Desired timeframe]
- **Technical Constraints**: [Existing systems, standards compliance]
- **Organizational Constraints**: [Change management, skills availability]

## Decision-Making Context
- **Key Stakeholders**: [Decision makers and influencers]
- **Success Criteria**: [How success will be measured]
- **Risk Tolerance**: [Conservative, moderate, aggressive]

**Instructions**: Populate this file with detailed client context before running /discover-opportunities or /create-sprint.
```

**Create context/company-profile.md:**
```markdown
# Company Profile: $3

## Company Overview
- **Company Name**: $3
- **Industry Focus**: $2
- **Core Competencies**: [Primary expertise areas]
- **Years in Business**: [Company maturity]

## Technical Capabilities
### Technologies & Platforms
- [Programming languages, frameworks, tools]
- [Cloud platforms and infrastructure]
- [Specialized software or hardware]

### Domain Expertise
- [Industry-specific knowledge]
- [Regulatory compliance experience]
- [Technical certifications]

### Team Strengths
- [Key technical talents]
- [Unique skill combinations]
- [Notable achievements]

## Competitive Positioning
### Unique Differentiators
- [What sets company apart]
- [Proprietary technologies or methods]
- [Strategic partnerships]

### Previous Successes
- [Relevant past projects]
- [Case studies and outcomes]
- [Client testimonials]

## Strategic Priorities
- [Growth objectives]
- [Market expansion plans]
- [Investment areas]

**Instructions**: Populate this file with comprehensive company capabilities before running /discover-opportunities.
```

**Create context/industry-background.md:**
```markdown
# Industry Background: $2

## Industry Overview
[Provide high-level industry context, trends, and dynamics]

## Key Regulations & Standards
[List relevant regulations, standards bodies, compliance requirements]

## Market Dynamics
- **Market Size**: [TAM/SAM estimates if known]
- **Growth Rate**: [CAGR and trends]
- **Key Players**: [Major competitors and market leaders]

## Technology Trends
[Emerging technologies, digital transformation initiatives]

## Challenges & Opportunities
[Industry pain points, unmet needs, innovation opportunities]

**Instructions**: This file is optional but improves opportunity discovery quality.
```

### Step 5: Initialize Git Repository

Use Bash tool to initialize git with git flow:

```bash
git init
git flow init -d  # Use defaults: master, develop, feature/, release/, hotfix/, tag prefix v
```

**Create .gitignore:**
```
# Research outputs
temp/*/
*.tmp

# Environment
.env
.env.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
```

### Step 6: Create Project README

Use Write tool to create README.md:

```markdown
# Strategic Research Project: $1

**Industry**: $2
**Company**: $3
**Created**: {{current_date}}
**Framework**: Strategic Research Automation Template

## Overview

This project uses AI-powered research automation to identify and analyze strategic opportunities in the $2 industry for $3.

## Quick Start

1. **Populate context files**:
   - Edit `context/client-info.md` with client details
   - Edit `context/company-profile.md` with company capabilities
   - Optional: Edit `context/industry-background.md`

2. **Discover opportunities** (automated):
   ```
   /discover-opportunities
   ```

3. **Or create sprints manually**:
   ```
   /create-sprint 01 "Opportunity Name" "Description"
   ```

4. **Execute research**:
   ```
   /execute-sprint 01
   ```

## Directory Structure

- **sprints/**: Sprint definitions (6 tasks each)
- **temp/**: Research outputs (25+ files per sprint)
- **reports/**: Final strategic reports
- **config/**: Project and quality configuration
- **context/**: Client and company information

## Commands Available

- `/discover-opportunities` - Auto-generate sprint opportunities
- `/create-sprint [num] "[name]" "[description]"` - Create sprint manually
- `/execute-sprint [num]` - Execute all 6 tasks for sprint
- `/execute-all` - Execute all sprints in parallel
- `/compare-sprints` - Rank and prioritize all opportunities
- `/validate-quality [num]` - Check quality standards
- `/export-findings [num] [format]` - Export to PDF/DOCX
- `/finalize-release [version]` - Create git release

## Methodology

Research follows 6-task sprint structure:
1. **Task 01**: Technical & Regulatory Landscape
2. **Task 02**: Market & Competitive Assessment
3. **Task 03**: Solution Architecture Design
4. **Task 04**: Certification & Testing Strategy
5. **Task 05**: Implementation Roadmap
6. **Task 06**: Final Report Synthesis (scored 0-100)

## Quality Standards

- Minimum 25 research files per sprint
- 80%+ citation density (evidence-based)
- Final reports: 5,000-7,500 words
- Dual-audience: business + technical

## License

[Specify project license]
```

### Step 7: Create Initial Commit

Use Bash tool to create initial commit:

```bash
git add .
git commit -m "Initialize $1 strategic research project

Project: $1
Industry: $2
Company: $3
Framework: Strategic Research Automation Template

Directory structure and configuration files created.
Ready for context population and sprint execution."
```

### Step 8: Output Success Summary

Display formatted success message:

```
✅ Project Initialized Successfully: $1

📁 Directory Structure Created:
   ✓ sprints/    (Sprint definitions - ready)
   ✓ temp/       (Research workspace - ready)
   ✓ reports/    (Strategic reports - ready)
   ✓ config/     (4 configuration files created)
   ✓ context/    (3 template files created)

⚙️  Configuration Files:
   ✓ config/project-config.yml
   ✓ config/sprint-config.yml
   ✓ config/quality-standards.yml
   ✓ config/scoring-rubric.yml

📝 Context Templates:
   ✓ context/client-info.md
   ✓ context/company-profile.md
   ✓ context/industry-background.md

🔧 Git Repository:
   ✓ Initialized with git flow
   ✓ Branch: develop
   ✓ Initial commit created

📋 Project Details:
   Industry: $2
   Company: $3
   Configuration: Strategic opportunity analysis
   Quality: Evidence-based, dual-audience reports

🚀 Next Steps:

1. Populate context files with real information:
   - Edit context/client-info.md (client background and needs)
   - Edit context/company-profile.md (capabilities and strengths)
   - Optional: Edit context/industry-background.md

2. Choose your workflow:

   Option A - Automated Discovery (Recommended):
   /discover-opportunities
   → AI discovers 5-10 opportunities automatically
   → Generates sprint definitions for each
   → Then run: /execute-all

   Option B - Manual Sprint Creation:
   /create-sprint 01 "Opportunity Name" "Brief description"
   → Repeat for each opportunity area
   → Then run: /execute-sprint 01

✅ Project ready for research execution!
```

## Success Criteria

- [ ] All 5 directories created (sprints/, temp/, reports/, config/, context/)
- [ ] 4 configuration files created with valid YAML and parameterized content
- [ ] 3 context template files created with instructions
- [ ] Git repository initialized with git flow
- [ ] Initial commit exists on develop branch
- [ ] README.md contains project metadata ($1, $2, $3)
- [ ] .gitignore excludes temporary and environment files

## Error Handling

### Missing Arguments

If $1 (project-name) is empty:
```
❌ ERROR: Project name is required

Usage: /init-project [project-name] [industry] [company-name]

Example: /init-project "technology sector-opportunity-analysis" "technology sector" "TechCo"

Project name format:
- Lowercase letters and hyphens
- 3-50 characters
- Examples: "ai-manufacturing", "healthcare-digital-twin"
```

If $2 (industry) is empty:
```
❌ ERROR: Industry is required

Usage: /init-project [project-name] [industry] [company-name]

Example: /init-project "technology sector-opportunity-analysis" "technology sector" "TechCo"

Common industries:
- technology sector, aerospace, defense
- healthcare, medtech, biotech
- fintech, banking, insurance
- manufacturing, automotive, industrial
- energy, cleantech, utilities
```

If $3 (company-name) is empty:
```
❌ ERROR: Company name is required

Usage: /init-project [project-name] [industry] [company-name]

Example: /init-project "technology sector-opportunity-analysis" "technology sector" "TechCo"

Company name: Your company conducting the research
```

### Project Already Exists

If directory $1/ already exists:
```
❌ ERROR: Project directory already exists: $1/

Options:
1. Choose a different project name
2. Delete existing directory: rm -rf $1/
3. Archive existing project: mv $1/ $1-archive-{{timestamp}}/

Then retry: /init-project "$1" "$2" "$3"
```

### Git Not Installed

If git command not found:
```
❌ ERROR: Git is not installed

Install Git:
- macOS: brew install git
- Ubuntu/Debian: sudo apt install git
- Windows: Download from https://git-scm.com/

After installation, retry: /init-project "$1" "$2" "$3"
```

### Git Flow Not Available

If git flow command not found (proceed with basic git):
```
⚠️  WARNING: Git flow not installed (optional)

Initializing basic git repository instead.

To enable git flow later:
- macOS: brew install git-flow
- Ubuntu/Debian: sudo apt install git-flow
- Then run: git flow init
```

### Write Permission Denied

If cannot create directories or files:
```
❌ ERROR: Permission denied writing to current directory

Solutions:
1. Run from a directory where you have write permissions
2. Check directory ownership: ls -la
3. If needed, run with appropriate permissions

Recommended: Use a directory in your home folder or workspace.
```

## Expected Output

Upon successful completion, user receives:
1. Confirmation of all directories and files created
2. Summary of git repository status
3. Clear next steps with command examples
4. Guidance on populating context files

Project is ready for `/discover-opportunities` or `/create-sprint` commands.
