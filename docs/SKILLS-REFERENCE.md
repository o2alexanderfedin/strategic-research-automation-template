# Skills API Reference

**Framework**: Strategic Research Automation
**Audience**: Advanced users and developers
**Last Updated**: 2025-11-14

---

This reference documents all eight specialized skills that power the Strategic Research Automation Framework. Each skill is an AI agent that activates automatically based on context and produces specific research outputs.

## Table of Contents

- [Overview](#overview)
- [Sprint Orchestrator](#sprint-orchestrator)
- [Opportunity Discovery](#opportunity-discovery)
- [Technical Researcher](#technical-researcher)
- [Market Analyst](#market-analyst)
- [Solution Architect](#solution-architect)
- [Compliance Analyst](#compliance-analyst)
- [Roadmap Planner](#roadmap-planner)
- [Report Synthesizer](#report-synthesizer)

---

## Overview

### Skill Activation

Skills activate automatically based on:
- **Context triggers**: Keywords or phrases (e.g., "technical research" → Technical Researcher)
- **Task execution**: Slash commands (e.g., `/execute-task 01 01` → Technical Researcher)
- **Sprint orchestration**: Sprint Orchestrator launches appropriate skills

### Skill Structure

Each skill resides in `.claude/skills/<skill-name>/`:
```
.claude/skills/<skill-name>/
├── SKILL.md         # Skill definition with activation triggers and prompt
└── examples/        # Example outputs (optional)
```

### Common Inputs

All skills receive:
- **Context files**: `context/company-profile.md`, `context/client-info.md`, `context/industry-background.md`
- **Task definition**: `sprints/<NN>-<name>/<task-id>-<task-name>.md`
- **Configuration**: `config/project-config.yml`, `config/quality-standards.yml`

---

## Sprint Orchestrator

**Location**: `.claude/skills/sprint-orchestrator/`

### Purpose

Coordinates multi-sprint execution, resource allocation, and cross-sprint analysis.

### Activation Triggers

- `/execute-all` command
- Multi-sprint mentions in context
- Portfolio analysis requests
- Cross-sprint comparison requests

### Research Areas

1. **Project Coordination**
   - Sprint sequencing and dependency management
   - Resource allocation across sprints
   - Progress tracking and reporting

2. **Portfolio Analysis**
   - Cross-sprint comparison
   - Opportunity prioritization
   - Strategic roadmap generation

3. **Quality Assurance**
   - Validate all sprints meet quality standards
   - Identify gaps or inconsistencies
   - Recommend remediation

### Inputs

- **Configuration**: `config/sprint-config.yml` (all sprint definitions)
- **Context**: All context files
- **Previous reports**: `reports/*-sprint-report.md` (for comparison)

### Outputs

1. **Execution Plan** (`temp/execution-plan.md`)
   - Sprint execution order
   - Resource allocation
   - Timeline estimates

2. **Sprint Comparison Report** (`reports/00-sprint-comparison.md`)
   - Scoring matrix across all sprints
   - Tier 1/2/3 categorization
   - Prioritized recommendations

3. **Progress Reports** (`temp/progress/*.md`)
   - Per-sprint status updates
   - Overall portfolio progress

### Quality Standards

- All sprints must be defined in `config/sprint-config.yml`
- Comparison report must include all executed sprints
- Scoring must use consistent rubric across all sprints
- Recommendations must be evidence-based with references

### Example Usage

```bash
/execute-all
# Activates Sprint Orchestrator
# Coordinates execution of all configured sprints
# Generates comparison report
```

---

## Opportunity Discovery

**Location**: `.claude/skills/opportunity-discovery/`

### Purpose

Analyzes company capabilities and client needs to autonomously identify high-fit opportunities.

### Activation Triggers

- `/discover-opportunities` command
- "Identify opportunities" in context
- Strategic fit analysis requests
- Portfolio generation requests

### Research Areas

1. **Capability-Need Matching**
   - Analyze company capabilities from `context/company-profile.md`
   - Analyze client needs from `context/client-info.md`
   - Identify intersection points (high fit)

2. **Market Gap Analysis**
   - Read industry background from `context/industry-background.md`
   - Identify underserved markets or emerging needs
   - Match to company capabilities

3. **Opportunity Definition**
   - Generate 5-10 specific opportunity descriptions
   - Define technical scope and market potential
   - Estimate fit score (0-100)

4. **Sprint Configuration Generation**
   - Auto-generate sprint definitions
   - Create task files with industry-specific research questions
   - Update `config/sprint-config.yml`

### Inputs

- **Context**: `context/company-profile.md` (capabilities)
- **Context**: `context/client-info.md` (needs)
- **Context**: `context/industry-background.md` (market trends)
- **Configuration**: `config/scoring-rubric.yml` (fit criteria)

### Outputs

1. **Opportunity Discovery Report** (`reports/00-opportunity-discovery.md`)
   - 5-10 identified opportunities
   - Fit scores and rationale
   - High-level market sizing
   - Recommended prioritization

2. **Sprint Configurations** (`config/sprint-config.yml` updated)
   - Auto-generated sprint definitions
   - Task structures for each opportunity

3. **Task Files** (`sprints/<NN>-<name>/*.md` created)
   - Industry-specific research questions
   - Customized for each opportunity

### Quality Standards

- Minimum 5 opportunities identified
- All opportunities have fit score ≥70/100
- Each opportunity has clear technical and market rationale
- Sprint configurations are complete and valid YAML

### Example Usage

```bash
/discover-opportunities
# Analyzes context files
# Identifies 8 opportunities for Industry Regulation XYZ advanced system market
# Generates sprint configs and task files automatically
```

---

## Technical Researcher

**Location**: `.claude/skills/technical-researcher/`

### Purpose

Conducts comprehensive technical requirements analysis, regulatory research, competitive technology assessment, and feasibility evaluation.

### Activation Triggers

- `/execute-task <sprint> 01` command
- "Technical requirements" or "technical research" mentions
- Task 01 execution in any sprint

### Research Areas

1. **Technical Requirements Analysis**
   - System requirements and specifications
   - Performance, safety, reliability requirements
   - Industry-specific technical standards

2. **Regulatory Standards**
   - Applicable regulations and compliance frameworks
   - Certification requirements and testing standards
   - Industry best practices and guidelines

3. **Competitive Technology Landscape**
   - Existing solutions and approaches
   - State of the art and emerging technologies
   - Competitive differentiation opportunities

4. **Technical Feasibility Assessment**
   - Technology maturity and readiness
   - Integration complexity and risks
   - Development timeline and resource requirements

### Inputs

- **Task file**: `sprints/<NN>-<name>/01-technical-research.md`
- **Context**: All context files
- **Configuration**: `config/quality-standards.yml`

### Outputs

6-7 research files in `temp/<NN>-sprint/01-technical/`:

1. **`requirements-analysis.md`** - Detailed technical requirements
2. **`regulatory-standards.md`** - Applicable regulations and standards
3. **`competitive-technology.md`** - Technology landscape analysis
4. **`feasibility-assessment.md`** - Technical feasibility evaluation
5. **`integration-considerations.md`** - Integration complexity and risks
6. **`standards-compliance.md`** - Compliance requirements and precedents
7. **`technology-precedents.md`** - Prior art and case studies (optional)

### Quality Standards

- Minimum 6 research files generated
- Citation ratio ≥80% (all claims supported by evidence)
- Industry-specific terminology used consistently
- Cross-references between related research files
- Evidence-based feasibility conclusions

### Example Output Structure

**File**: `temp/01-advanced system-operation-control/01-technical/requirements-analysis.md`

```markdown
# Technical Requirements Analysis: advanced system operation Control Systems
## Sprint 01 - Task 01

**Created**: 2025-11-14
**Category**: Technical Requirements

---

## Primary operation Control Requirements

### Design Assurance Level (DAL)
Primary operation controls for advanced system system fall under DAL A (catastrophic failure condition) per Industry Standard ABC [1]. This requires:
- Comprehensive verification and validation
- Full requirements traceability
- Formal methods consideration per Compliance Framework DEF [2]

### Performance Requirements
- Control surface actuation latency: <10ms [3]
- Position accuracy: ±0.5 degrees [3]
- Reliability: MTBF >10,000 operation hours [4]

[Citations with sources]

---

## References

[1] RTCA Industry Standard ABC, "Software Considerations in Airborne Systems and Equipment Certification", 2012
[2] RTCA Compliance Framework DEF, "Formal Methods Supplement to Industry Standard ABC", 2011
[3] SAE ARP4754A, "Guidelines for Development of Civil system and Systems", 2010
[4] Industry analysis based on Joby technology sector G-1 type certification application, 2023
```

---

## Market Analyst

**Location**: `.claude/skills/market-analyst/`

### Purpose

Conducts market sizing (TAM/SAM/SOM), customer needs analysis, competitive landscape assessment, and differentiation strategy.

### Activation Triggers

- `/execute-task <sprint> 02` command
- "Market analysis" or "market sizing" mentions
- Task 02 execution in any sprint

### Research Areas

1. **Market Sizing**
   - Total Addressable Market (TAM)
   - Serviceable Available Market (SAM)
   - Serviceable Obtainable Market (SOM)
   - Growth projections and trends

2. **Customer Needs Analysis**
   - Target customer segments
   - Pain points and unmet needs
   - Willingness to pay
   - Buying process and decision criteria

3. **Competitive Landscape**
   - Direct and indirect competitors
   - Market share and positioning
   - Competitive strengths and weaknesses
   - Barriers to entry

4. **Differentiation Strategy**
   - Unique value proposition
   - Competitive advantages
   - Positioning opportunities
   - Partnership potential

### Inputs

- **Task file**: `sprints/<NN>-<name>/02-market-analysis.md`
- **Context**: All context files
- **Configuration**: `config/quality-standards.yml`

### Outputs

5-6 research files in `temp/<NN>-sprint/02-market/`:

1. **`market-sizing.md`** - TAM/SAM/SOM analysis with data sources
2. **`competitive-landscape.md`** - Competitor analysis and market share
3. **`customer-needs.md`** - Target customer segments and pain points
4. **`differentiation-strategy.md`** - Unique value proposition and positioning
5. **`partnership-opportunities.md`** - Strategic partnership identification
6. **`market-trends.md`** - Growth drivers and market dynamics (optional)

### Quality Standards

- Minimum 5 research files generated
- Citation ratio ≥80% (data-driven claims)
- Conservative market sizing estimates
- Comprehensive competitor coverage (top 5-10 competitors)
- Evidence-based differentiation strategy

### Example Output Structure

**File**: `temp/01-advanced system-operation-control/02-market/market-sizing.md`

```markdown
# Market Sizing: advanced system operation Control Systems
## Sprint 01 - Task 02

**Created**: 2025-11-14
**Category**: Market Analysis

---

## Total Addressable Market (TAM)

### advanced system system Market
- Global advanced system system market: $15.2B by 2030 [1]
- operation control systems: 12-15% of system cost [2]
- **TAM for advanced system operation controls: $1.8-2.3B by 2030**

### new system category Market
- Estimated 5,000-8,000 Industry Regulation XYZ system deliveries 2025-2030 [3]
- operation control avionics: $50K-80K per system [4]
- **TAM for Industry Regulation XYZ operation controls: $250-640M by 2030**

### Combined TAM: $2.05-2.94B by 2030

---

## Serviceable Available Market (SAM)

### advanced methodology-Verified Systems Segment
- Safety-critical operation controls requiring rigorous verification: 40% of market [5]
- **SAM: $820M-1.18B by 2030**

[... detailed analysis continues ...]

---

## References

[1] Morgan Stanley Research, "advanced system Market Forecast", 2024
[2] technology sector Week, "advanced system Development Cost Breakdown", 2023
[3] GAMA, "Industry Regulation XYZ Rulemaking Impact Analysis", 2024
[... additional citations ...]
```

---

## Solution Architect

**Location**: `.claude/skills/solution-architect/`

### Purpose

Designs system architecture, component specifications, integration approach, and proof-of-concept (POC) specifications.

### Activation Triggers

- `/execute-task <sprint> 03` command
- "Architecture" or "system design" mentions
- Task 03 execution in any sprint

### Research Areas

1. **System Architecture Design**
   - High-level architecture overview
   - Component decomposition
   - Interface definitions
   - Technology stack selection

2. **Component Design**
   - Detailed component specifications
   - Responsibilities and capabilities
   - Performance requirements
   - Dependencies and interfaces

3. **Integration Strategy**
   - Integration architecture and approach
   - Data flow and communication protocols
   - Third-party system integration
   - Testing and validation approach

4. **Proof of Concept Specification**
   - POC scope and objectives
   - Success criteria and metrics
   - Development approach and timeline
   - Resource requirements

### Inputs

- **Task file**: `sprints/<NN>-<name>/03-solution-architecture.md`
- **Context**: All context files
- **Previous research**: `temp/<NN>-sprint/01-technical/` (technical requirements)

### Outputs

6 research files in `temp/<NN>-sprint/03-solution/`:

1. **`architecture-overview.md`** - High-level system architecture
2. **`component-designs.md`** - Detailed component specifications
3. **`integration-strategy.md`** - Integration approach and data flow
4. **`data-model.md`** - Data structures and schemas
5. **`verification-approach.md`** - Testing and validation strategy
6. **`poc-specification.md`** - POC scope, success criteria, and plan

### Quality Standards

- All 6 research files generated
- Architecture is complete, coherent, and feasible
- Component designs are detailed and implementable
- Integration strategy addresses all third-party systems
- POC specification includes measurable success criteria
- **Mermaid diagrams required** for architecture visualization (NEVER use ASCII art)

### Example Output Structure

**File**: `temp/01-advanced system-operation-control/03-solution/architecture-overview.md`

```markdown
# System Architecture: advanced system operation Control Verification
## Sprint 01 - Task 03

**Created**: 2025-11-14
**Category**: Solution Architecture

---

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│               operation Control Software (C/C++)               │
│                    (Customer Codebase)                      │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ↓
┌─────────────────────────────────────────────────────────────┐
│              advanced verification Platform                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ CBMC Frontend│  │  Z3 Solver   │  │  CVC5 Solver │     │
│  │ (C → advanced methodology)    │  │              │  │              │     │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘     │
│         │                 │                 │              │
│         └─────────────────┴─────────────────┘              │
│                           │                                │
│                    ┌──────▼──────┐                         │
│                    │ Verification │                         │
│                    │   Results    │                         │
│                    └──────┬───────┘                         │
└───────────────────────────┼─────────────────────────────────┘
                            │
                            ↓
┌─────────────────────────────────────────────────────────────┐
│              Industry Standard ABC Compliance Artifacts                   │
│  - Verification test cases                                  │
│  - Requirements traceability matrix                         │
│  - Tool qualification data (DO-330)                         │
└─────────────────────────────────────────────────────────────┘
```

## Key Components

### 1. CBMC Frontend
- Converts C/C++ operation control code to advanced methodology formulas
- Supports ACSL (ANSI/ISO C Specification Language) annotations
- Generates bounded model checking queries

### 2. verification solver Layer
- Dual solver approach (Z3 + CVC5) for cross-validation
- Bounded verification with configurable loop unrolling
- Timeout management (configurable per property)

[... detailed architecture continues ...]
```

---

## Compliance Analyst

**Location**: `.claude/skills/compliance-analyst/`

### Purpose

Analyzes regulatory pathways, certification requirements, compliance testing, and timeline/cost estimates.

### Activation Triggers

- `/execute-task <sprint> 04` command
- "Certification" or "compliance" mentions
- Task 04 execution in any sprint

### Research Areas

1. **Regulatory Framework**
   - Applicable regulations and governing bodies
   - Certification pathways and processes
   - Regulatory precedents and guidance

2. **Standards and Compliance**
   - Industry standards (Industry Standard ABC, HL7 FHIR, etc.)
   - Compliance requirements and documentation
   - Tool qualification (if applicable)

3. **Testing and Validation**
   - Required testing (ground, operation, environmental)
   - Validation approach and acceptance criteria
   - Third-party testing and certification

4. **Timeline and Cost**
   - Certification timeline estimates
   - Cost breakdown (fees, consulting, testing)
   - Risk factors and mitigation

### Inputs

- **Task file**: `sprints/<NN>-<name>/04-certification-strategy.md`
- **Context**: All context files
- **Previous research**: `temp/<NN>-sprint/01-technical/` and `temp/<NN>-sprint/03-solution/`

### Outputs

6 research files in `temp/<NN>-sprint/04-compliance/`:

1. **`regulatory-framework.md`** - Regulations and certification pathways
2. **`standards-compliance.md`** - Industry standards and requirements
3. **`testing-requirements.md`** - Testing and validation strategy
4. **`certification-precedents.md`** - Prior certifications and lessons learned
5. **`certification-strategy.md`** - Recommended approach and sequencing
6. **`timeline-cost-estimate.md`** - Schedule and budget estimates

### Quality Standards

- All 6 research files generated
- Complete regulatory coverage (all applicable standards identified)
- Realistic timeline estimates based on precedents
- Cost estimates include all major categories
- Risk assessment with mitigation strategies
- Evidence-based recommendations

---

## Roadmap Planner

**Location**: `.claude/skills/roadmap-planner/`

### Purpose

Develops proof-of-concept plans, prototype roadmaps, productization strategies, partnership plans, and risk assessments.

### Activation Triggers

- `/execute-task <sprint> 05` command
- "Roadmap" or "implementation plan" mentions
- Task 05 execution in any sprint

### Research Areas

1. **POC Specification**
   - POC scope and objectives
   - Success criteria and validation
   - Timeline and resource requirements

2. **Prototype Development Plan**
   - Prototype features and capabilities
   - Development phases and milestones
   - Technology and tooling selection

3. **Productization Strategy**
   - Product features and roadmap
   - Go-to-market strategy
   - Pricing and business model

4. **Partnership Roadmap**
   - Strategic partnership identification
   - Partnership value proposition
   - Engagement approach

5. **Risk Assessment**
   - Technical, market, regulatory risks
   - Mitigation strategies
   - Contingency planning

### Inputs

- **Task file**: `sprints/<NN>-<name>/05-roadmap-planning.md`
- **Context**: All context files
- **Previous research**: All prior tasks (01-04)

### Outputs

6 research files in `temp/<NN>-sprint/05-roadmap/`:

1. **`poc-specification.md`** - POC scope, objectives, success criteria
2. **`prototype-plan.md`** - Prototype development roadmap
3. **`productization-strategy.md`** - Product roadmap and GTM
4. **`partnership-roadmap.md`** - Strategic partnerships and outreach
5. **`risk-assessment.md`** - Risks and mitigation strategies
6. **`execution-timeline.md`** - Integrated timeline across all phases

### Quality Standards

- All 6 research files generated
- POC has measurable success criteria
- Roadmap is realistic and phased (POC → Prototype → Product)
- Partnerships are specific and actionable
- Risks are comprehensive with concrete mitigation
- Timeline is evidence-based with dependencies

---

## Report Synthesizer

**Location**: `.claude/skills/report-synthesizer/`

### Purpose

Aggregates all research findings, applies scoring rubric, and generates comprehensive strategic assessment reports.

### Activation Triggers

- `/execute-task <sprint> 06` command
- `/synthesize-report <sprint>` command
- Task 06 execution in any sprint

### Research Areas

1. **Research Aggregation**
   - Read all 29-31 research files from Tasks 01-05
   - Extract key findings and evidence
   - Identify themes and patterns

2. **Opportunity Scoring**
   - Apply scoring rubric from `config/scoring-rubric.yml`
   - Calculate dimension scores (market, technical, competitive, execution, regulatory)
   - Generate overall score (0-100) and recommendation tier

3. **Strategic Report Generation**
   - Executive summary (1-2 pages)
   - Detailed assessments across all dimensions
   - Evidence-based recommendations
   - Go/no-go decision with rationale

### Inputs

- **All research files**: `temp/<NN>-sprint/01-technical/`, `temp/<NN>-sprint/02-market/`, etc. (29-31 files)
- **Scoring rubric**: `config/scoring-rubric.yml`
- **Quality standards**: `config/quality-standards.yml`

### Outputs

1. **Strategic Assessment Report** (`reports/<NN>-sprint-report.md`)
   - 5,000-7,500 words
   - 10-12 pages (formatted)
   - Dual audience: Executive summary + detailed analysis

### Report Structure

```markdown
# [Opportunity Name]: Strategic Assessment

**Prepared for**: [Client Name]
**Prepared by**: [Company Name]
**Date**: [Date]
**Recommendation**: [STRONG GO / GO / CONDITIONAL GO / NO GO] ([Score]/100)

---

## Executive Summary
[2-3 paragraphs: Opportunity overview, key findings, recommendation]

## Technical Feasibility Assessment
[Synthesized from Task 01 research]

## Market Opportunity Analysis
[Synthesized from Task 02 research]

## Solution Architecture
[Synthesized from Task 03 research]

## Certification and Compliance Strategy
[Synthesized from Task 04 research]

## Execution Roadmap
[Synthesized from Task 05 research]

## Investment Requirements
[Financial summary across all dimensions]

## Risk Assessment
[Consolidated risks from all tasks]

## Competitive Positioning
[Competitive analysis and differentiation]

## Recommendation and Rationale
[Go/no-go with evidence-based justification]

## Opportunity Scoring
[Detailed scoring breakdown]

## Appendices
[Research file index, glossary, references]
```

### Quality Standards

- Report length: 5,000-7,500 words
- All sections present and complete
- Evidence-based claims with citations (80%+ citation ratio)
- Dual audience: Executive summary + detailed analysis
- Actionable recommendations with clear next steps
- Scoring uses consistent rubric across all opportunities

---

## Next Steps

- **Usage**: See [Usage Guide](./USAGE.md) for workflow examples
- **Commands**: Consult [Commands Reference](./COMMANDS-REFERENCE.md) for slash commands
- **Customization**: Read [Customization Guide](./CUSTOMIZATION.md) for skill adaptation
- **Examples**: Review [technology sector Example](./EXAMPLE-technology sector-Industry Regulation XYZ.md)

---

**Document Version**: 1.0
**Word Count**: ~1,800 words
**Last Updated**: 2025-11-14
