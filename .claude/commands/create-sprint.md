---
description: Create a new sprint with complete task definitions and directory structure
argument-hint: [sprint-number] "[sprint-name]" "[description]"
allowed-tools: Bash, Read, Write, Glob
---

# Create New Sprint

You are executing the `/create-sprint` command to create a new sprint definition with all task files.

## Purpose

Create a comprehensive sprint definition by copying templates, customizing task files, and updating configuration. Each sprint represents one strategic opportunity area with 6 research tasks.

## Steps to Execute

### Step 1: Validate Arguments

**Check $1 (sprint-number)**:
- Must be 2-digit format: 01-99
- Example validation: if not [0-9][0-9], ERROR

**Check $2 (sprint-name)**:
- Must be non-empty quoted string
- Will be used for directory naming (slugified)
- Example: "operation Control Verification", "AI Pilot Assistance"

**Check $3 (description)**:
- Must be non-empty quoted string
- Brief description of opportunity area
- Example: "Automated operation control verification for new technology sector standards"

**Verify prerequisites**:
- config/sprint-config.yml exists
- templates/sprint-template/ exists (from template repo)
- Sprint $1 not already defined in config

### Step 2: Slugify Sprint Name

Convert $2 to URL-safe slug:
- Lowercase all characters
- Replace spaces with hyphens
- Remove special characters
- Example: "AI Pilot Assistance" → "ai-pilot-assistance"

Store as $SLUG variable.

### Step 3: Create Sprint Directory

Use Bash tool:
```bash
mkdir -p sprints/$1-$SLUG
mkdir -p temp/$1-$SLUG
```

### Step 4: Copy and Customize Task Templates

For each task file (01-06), use Read to load template, customize, and Write to sprint directory:

**Task 01 - Technical & Regulatory Landscape:**
```markdown
# Sprint $1, Task 01: Technical & Regulatory Landscape
## $2

### Objective
Research technical requirements, regulatory standards, and compliance pathways for: $3

### Research Questions
1. What are the relevant technical standards and regulations?
2. What are current compliance requirements?
3. What verification and validation approaches exist?
4. What precedents or prior approvals are relevant?
5. What technical risks or challenges exist?
6. What documentation and testing is required?

### Expected Deliverables
- Technical standards analysis (5-7 files)
- Regulatory pathway documentation
- Compliance requirements summary
- Risk assessment
- Synthesis document

### Success Criteria
- Minimum 5 research files created
- All claims cited with authoritative sources
- Technical accuracy verified
- Regulatory pathways clearly documented
```

**Task 02 - Market & Competitive Assessment:**
```markdown
# Sprint $1, Task 02: Market & Competitive Assessment
## $2

### Objective
Analyze market opportunity, size estimates, competitive landscape, and customer needs for: $3

### Research Questions
1. What is the total addressable market (TAM)?
2. What is serviceable addressable market (SAM) and serviceable obtainable market (SOM)?
3. Who are the key competitors and what are their offerings?
4. What are customer pain points and unmet needs?
5. What is the market growth rate (CAGR)?
6. What pricing models and revenue potential exist?

### Expected Deliverables
- Market sizing analysis (TAM/SAM/SOM)
- Competitive landscape mapping
- Customer needs assessment
- Pricing and business model analysis
- Synthesis document

### Success Criteria
- Market sizes quantified with sources
- Competitors identified and analyzed
- Customer insights documented
- Business case outlined
```

**Task 03 - Solution Architecture Design:**
```markdown
# Sprint $1, Task 03: Solution Architecture Design
## $2

### Objective
Design comprehensive solution architecture, technical components, and integration approach for: $3

### Research Questions
1. What are the key system components and their interactions?
2. What technologies and platforms should be used?
3. How does the solution integrate with existing systems?
4. What are scalability and performance considerations?
5. What are deployment and infrastructure requirements?
6. What are security and data privacy requirements?

### Expected Deliverables
- System architecture diagrams and documentation
- Component specifications
- Technology stack recommendations
- Integration approach
- Scalability and performance analysis
- Synthesis document

### Success Criteria
- Architecture clearly documented
- Technology choices justified
- Integration points specified
- Scalability addressed
```

**Task 04 - Certification & Testing Strategy:**
```markdown
# Sprint $1, Task 04: Certification & Testing Strategy
## $2

### Objective
Define certification pathway, testing requirements, and quality assurance approach for: $3

### Research Questions
1. What certifications or approvals are required?
2. What testing standards must be met?
3. What is the certification process and timeline?
4. What documentation is required for approval?
5. What testing infrastructure and capabilities are needed?
6. What are costs and risks in certification process?

### Expected Deliverables
- Certification pathway roadmap
- Testing strategy and test plans
- Documentation requirements
- Timeline and milestone analysis
- Cost estimates
- Synthesis document

### Success Criteria
- Certification path clearly defined
- Testing requirements specified
- Timeline realistic and achievable
- Costs estimated
```

**Task 05 - Implementation Roadmap:**
```markdown
# Sprint $1, Task 05: Implementation Roadmap
## $2

### Objective
Create comprehensive implementation roadmap with phases, milestones, resources, and risk mitigation for: $3

### Research Questions
1. What are the implementation phases and sequencing?
2. What are key milestones and decision points?
3. What resources (team, budget, partnerships) are required?
4. What is the realistic timeline for each phase?
5. What are critical risks and mitigation strategies?
6. What are quick wins vs. long-term objectives?

### Expected Deliverables
- Phased implementation roadmap
- Resource requirements analysis
- Risk register and mitigation plans
- Timeline with milestones
- Investment requirements
- Synthesis document

### Success Criteria
- Roadmap is actionable and detailed
- Resources realistically estimated
- Risks identified with mitigations
- Timeline achievable
```

**Task 06 - Final Report Synthesis:**
```markdown
# Sprint $1, Task 06: Final Report Synthesis
## $2

### Objective
Synthesize all research findings into comprehensive strategic report with scoring and go/no-go recommendation for: $3

### Process
This task is executed by the report-synthesizer skill, which:
1. Reads all research files from Tasks 01-05
2. Applies scoring rubric from config/scoring-rubric.yml
3. Generates 10-page strategic report (5,000-7,500 words)
4. Calculates weighted opportunity score (0-100)
5. Provides clear go/no-go recommendation

### Report Structure
1. Executive Summary
2. Market Opportunity Analysis
3. Technical Approach & Architecture
4. Certification & Timeline
5. Implementation Strategy
6. Risk Assessment
7. Opportunity Scoring (5 dimensions)
8. Go/No-Go Recommendation
9. Appendices

### Success Criteria
- Report is 5,000-7,500 words
- All required sections present
- Scoring methodology applied
- Clear recommendation with rationale
- Publication-ready quality
```

**Create README.md for sprint:**
```markdown
# Sprint $1: $2

**Description**: $3
**Status**: Defined (not yet executed)
**Tasks**: 6 (Technical, Market, Architecture, Certification, Roadmap, Report)

## Overview

This sprint investigates the strategic opportunity: $2

## Tasks

1. **Task 01**: Technical & Regulatory Landscape
2. **Task 02**: Market & Competitive Assessment
3. **Task 03**: Solution Architecture Design
4. **Task 04**: Certification & Testing Strategy
5. **Task 05**: Implementation Roadmap
6. **Task 06**: Final Report Synthesis

## Execution

Run: `/execute-sprint $1`

Or execute tasks individually:
```
/execute-task $1 01
/execute-task $1 02
/execute-task $1 03
/execute-task $1 04
/execute-task $1 05
/synthesize-report $1
```

## Expected Outputs

- **Research Files**: 25+ files in temp/$1-$SLUG/
- **Final Report**: reports/$1-$SLUG-report.md
- **Opportunity Score**: 0-100 with recommendation

## Quality Standards

- Minimum 25 research files
- 80%+ citation density
- Evidence-based findings
- Dual-audience (business + technical)
```

### Step 5: Update Sprint Configuration

Read config/sprint-config.yml, append new sprint, write back:

```yaml
  - id: "$1"
    name: "$2"
    description: "$3"
    priority: "medium"  # User can adjust later
    status: "defined"
    estimated_duration: "5 days"
    tasks:
      - { id: "01", name: "Technical & Regulatory Landscape" }
      - { id: "02", name: "Market & Competitive Assessment" }
      - { id: "03", name: "Solution Architecture Design" }
      - { id: "04", name: "Certification & Testing Strategy" }
      - { id: "05", name: "Implementation Roadmap" }
      - { id: "06", name: "Final Report Synthesis" }
```

### Step 6: Validate Sprint Structure

Verify all files created:
- sprints/$1-$SLUG/README.md
- sprints/$1-$SLUG/01-technical-regulatory.md
- sprints/$1-$SLUG/02-market-competitive.md
- sprints/$1-$SLUG/03-solution-architecture.md
- sprints/$1-$SLUG/04-certification-testing.md
- sprints/$1-$SLUG/05-implementation-roadmap.md
- sprints/$1-$SLUG/06-final-report.md
- temp/$1-$SLUG/ directory exists

Total: 7 files + 1 directory

### Step 7: Output Success Summary

```
✅ Sprint $1 Created Successfully: $2

📁 Sprint Directory:
   ✓ sprints/$1-$SLUG/
   ✓ temp/$1-$SLUG/

📄 Task Files Created (7 files):
   ✓ README.md
   ✓ 01-technical-regulatory.md
   ✓ 02-market-competitive.md
   ✓ 03-solution-architecture.md
   ✓ 04-certification-testing.md
   ✓ 05-implementation-roadmap.md
   ✓ 06-final-report.md

⚙️  Configuration Updated:
   ✓ config/sprint-config.yml (sprint $1 added)

📋 Sprint Details:
   Number: $1
   Name: $2
   Description: $3
   Status: Defined (ready for execution)
   Tasks: 6 research tasks

🎯 Research Scope:
   Expected Output: 25+ research files
   Final Report: 5,000-7,500 words
   Opportunity Score: 0-100 with recommendation

🚀 Next Steps:

1. Customize task files (optional):
   - Edit sprints/$1-$SLUG/*.md files
   - Refine research questions for your context
   - Add specific technical requirements

2. Execute sprint:
   /execute-sprint $1
   → Runs all 6 tasks in parallel (Tasks 01-05)
   → Synthesizes final report (Task 06)
   → Generates opportunity score and recommendation

3. Or execute tasks individually:
   /execute-task $1 01  # Technical research
   /execute-task $1 02  # Market analysis
   [etc.]

✅ Sprint ready for execution!
```

## Success Criteria

- [ ] Sprint directory created: sprints/$1-$SLUG/
- [ ] Temp directory created: temp/$1-$SLUG/
- [ ] All 7 files created with customized content
- [ ] Sprint $1 added to config/sprint-config.yml
- [ ] Task files reference $1, $2, $3 correctly
- [ ] Sprint slug correctly generated from $2

## Error Handling

### Invalid Sprint Number

If $1 not in format 01-99:
```
❌ ERROR: Invalid sprint number format

Sprint number must be 2 digits: 01-99
Got: "$1"

Examples: 01, 02, 10, 25

Usage: /create-sprint [sprint-number] "[name]" "[description]"
Example: /create-sprint 01 "operation Control" "advanced verification for operation systems"
```

### Missing Sprint Name

If $2 is empty:
```
❌ ERROR: Sprint name is required

Usage: /create-sprint [sprint-number] "[name]" "[description]"

Sprint name should describe the opportunity area.
Example: /create-sprint 01 "operation Control Verification" "Description here"

Use quotes for multi-word names.
```

### Missing Description

If $3 is empty:
```
❌ ERROR: Sprint description is required

Usage: /create-sprint [sprint-number] "[name]" "[description]"

Description should briefly explain the opportunity.
Example: /create-sprint 01 "Sprint Name" "Automated operation control verification for new technology sector standards"

Use quotes for multi-word descriptions.
```

### Sprint Already Exists

If sprint $1 already in config/sprint-config.yml:
```
❌ ERROR: Sprint $1 already exists

Sprint $1 is already defined in config/sprint-config.yml

Options:
1. Choose different sprint number
2. Delete existing sprint:
   - Remove from config/sprint-config.yml
   - Delete sprints/$1-*/ directory
   - Delete temp/$1-*/ directory

Then retry: /create-sprint $1 "$2" "$3"
```

### Templates Not Found

If templates/sprint-template/ missing:
```
❌ ERROR: Sprint templates not found

Expected: templates/sprint-template/ directory

This directory should contain task templates.
Ensure you're using the strategic research automation template repository.

If templates are missing, reinitialize project or clone template repository.
```

## Expected Output

User receives confirmation of sprint creation with:
1. List of all files created
2. Sprint configuration details
3. Next steps for execution
4. Optional customization guidance

Sprint is ready for `/execute-sprint $1` command.
