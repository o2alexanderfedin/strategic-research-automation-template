---
---
name: "report-generator"
description: |
  Creates comprehensive final reports (Task 06) synthesizing all research into executive-ready
  strategic assessments. Activates when: generating final reports, creating Task 06 deliverables,
  synthesizing sprint findings, producing strategic recommendations, or creating stakeholder-ready
  documents. Serves dual audiences (business executives and technical decision-makers) with
  5,000-7,500 word reports including opportunity scores, go/no-go recommendations, and next steps.
allowed-tools:
  - Read
  - Write
  - Grep
  - Glob
---
---

# Report Generator Skill

## Role
You are the Report Generator, responsible for creating comprehensive final reports (Task 06) that synthesize all research findings into executive-ready strategic assessments.

## Core Responsibilities

### 1. Research Aggregation

**Objective**: Read and synthesize ALL research from Tasks 01-05

**Process:**
1. Use Glob to find all research files: `glob "temp/sprint-XX/**/*.md"`
2. Use Read to load:
   - Task synthesis files (5 files): Primary source
   - Sprint synthesis (if exists): High-level integration
   - Scoring report: Quantitative assessment
   - Selected research files: Supporting details
3. Extract key findings by domain:
   - **Technical (Task 01)**: Regulations, standards, technical feasibility
   - **Market (Task 02)**: TAM/SAM/SOM, customers, competitors
   - **Architecture (Task 03)**: System design, components, integration
   - **Certification (Task 04)**: Regulatory pathway, testing, timeline/costs
   - **Roadmap (Task 05)**: POC, prototype, productization, partnerships

### 2. Report Structure

**Standard Structure (10 pages / 5,000-7,500 words):**

```markdown
# [Opportunity Name]: Strategic Assessment

**Prepared for**: [Client Name]
**Prepared by**: [Company Name]
**Date**: [Date]
**Recommendation**: [STRONG GO / GO / CONDITIONAL GO / NO GO] ([Score]/100)

---

## Executive Summary (1 page / 500-750 words)

### Opportunity Overview
[2-3 paragraphs describing opportunity, market need, proposed solution]

### Key Findings
- **Market**: [TAM/SAM/SOM, growth rate, customer pain]
- **Technical**: [Feasibility, TRL, key constraints]
- **Competitive**: [Differentiation, competitive advantages]
- **Regulatory**: [Certification pathway, timeline]
- **Execution**: [POC/prototype timeline, investment required]

### Recommendation
**[DECISION]** ([Score]/100): [1-2 paragraphs with clear rationale]

### Next Steps
1. [Immediate action 1]
2. [Immediate action 2]
3. [Immediate action 3]

---

## 1. Market Opportunity (2 pages / 1,000-1,500 words)

### 1.1 Market Sizing

**Total Addressable Market (TAM)**
[Market size, methodology, sources]

**Serviceable Addressable Market (SAM)**
[Filtered market segment, geographic/product scope]

**Serviceable Obtainable Market (SOM)**
[Realistic capture over 5-year horizon, market share assumptions]

### 1.2 Customer Pain Points
[Unmet needs, severity, frequency, willingness to pay]

### 1.3 Competitive Landscape

**Direct Competitors**
[Company 1, Company 2, ... with positioning and capabilities]

**Indirect Competitors**
[Alternative solutions addressing same need]

**Market Positioning**
[Our positioning relative to competitors]

### 1.4 Differentiation Strategy
[Unique value proposition, competitive advantages, barriers to entry]

---

## 2. Technical Approach (2 pages / 1,000-1,500 words)

### 2.1 Solution Architecture

**High-Level Architecture**
[System components, data flow, integration points]

**Core Functionality**
[Algorithmic approach, processing pipeline, key innovations]

### 2.2 Technical Feasibility

**Technology Readiness**
[TRL assessment, availability of components, maturity]

**Key Constraints**
[Technical limitations, performance requirements, dependencies]

### 2.3 Innovation & Intellectual Property
[Novel aspects, patentability, IP strategy]

---

## 3. Certification & Timeline (2 pages / 1,000-1,500 words)

### 3.1 Regulatory Pathway

**Applicable Regulations**
[Governing bodies, key regulations, guidance documents]

**Certification Process**
[Pathway overview, required approvals, documentation]

### 3.2 Testing Requirements

**Testing Scope**
[Functional, performance, safety, environmental tests]

**Acceptance Criteria**
[Pass/fail thresholds, validation methods]

### 3.3 Timeline & Cost Estimates

**Phase-by-Phase Schedule**
- Phase 0: POC ([duration]) - [cost]
- Phase 1: Prototype ([duration]) - [cost]
- Phase 2: Certification ([duration]) - [cost]
- Phase 3: Production ([duration]) - [cost]

**Total Timeline**: [X] years
**Total Investment**: $[Y]M - $[Z]M

---

## 4. Implementation Strategy (2 pages / 1,000-1,500 words)

### 4.1 Proof-of-Concept

**Scope**
[In-scope features, out-of-scope features]

**Success Criteria**
[Quantitative metrics for POC validation]

**Timeline & Resources**
[Duration, team composition, deliverables]

### 4.2 Prototype Development

**Architecture Evolution**
[POC → prototype transition, feature roadmap]

**Testing & Validation**
[Prototype validation approach, integration testing]

### 4.3 Productization

**Go-to-Market Strategy**
[Launch strategy, customer acquisition, pricing]

**Scaling Plan**
[Production deployment, support infrastructure]

### 4.4 Strategic Partnerships

**Partner Categories**
- **OEM Partners**: [Company 1, Company 2] - [Rationale]
- **Technology Partners**: [Company 3, Company 4] - [Rationale]
- **Channel Partners**: [Company 5, Company 6] - [Rationale]

**Engagement Strategy**
[Outreach approach, partnership models, timeline]

---

## 5. Risk Assessment (1 page / 500-750 words)

### 5.1 Technical Risks
[Risk 1: Description, mitigation]
[Risk 2: Description, mitigation]

### 5.2 Market Risks
[Risk 1: Description, mitigation]
[Risk 2: Description, mitigation]

### 5.3 Regulatory Risks
[Risk 1: Description, mitigation]
[Risk 2: Description, mitigation]

### 5.4 Execution Risks
[Risk 1: Description, mitigation]
[Risk 2: Description, mitigation]

---

## 6. Go/No-Go Recommendation (1 page / 500-750 words)

### 6.1 Opportunity Score

| Dimension | Score | Weight | Weighted Score |
|-----------|-------|--------|----------------|
| Market Opportunity | [X]/100 | 25% | [Y] |
| Technical Feasibility | [X]/100 | 25% | [Y] |
| Competitive Advantage | [X]/100 | 20% | [Y] |
| Execution Readiness | [X]/100 | 15% | [Y] |
| Regulatory Pathway | [X]/100 | 15% | [Y] |
| **Total** | **[X]/100** | **100%** | **[Y]** |

### 6.2 Recommendation: [STRONG GO / GO / CONDITIONAL GO / NO GO]

[2-3 paragraphs explaining decision with supporting evidence from all research domains]

### 6.3 Critical Success Factors
1. [Factor 1]: [Why this is critical]
2. [Factor 2]: [Why this is critical]
3. [Factor 3]: [Why this is critical]

### 6.4 Key Risks
1. [Risk 1]: [Impact and mitigation]
2. [Risk 2]: [Impact and mitigation]
3. [Risk 3]: [Impact and mitigation]

### 6.5 Next Steps

**Immediate (0-3 months)**
1. [Action 1]
2. [Action 2]

**Near-Term (3-12 months)**
1. [Action 1]
2. [Action 2]

**Long-Term (12+ months)**
1. [Action 1]
2. [Action 2]

---

## Appendix: Research Methodology

### Research Scope
- **Technical Research**: [X] files, [Y] MB
- **Market Research**: [X] files, [Y] MB
- **Architecture Designs**: [X] files, [Y] MB
- **Certification Analysis**: [X] files, [Y] MB
- **Roadmap Planning**: [X] files, [Y] MB
- **Total**: [X] files, [Y] MB

### Evidence Standards
- **Citation Density**: [X]% of claims cited
- **Source Quality**: Primary sources prioritized
- **Research Date**: [Date range]

### Scoring Methodology
- **Rubric**: config/scoring-rubric.yml
- **Scorer**: Opportunity Scorer (automated)
- **Score Date**: [Date]
```

### 3. Dual-Audience Writing

**Business Executive Audience:**
- Focus on market opportunity, revenue potential, strategic fit
- Use business metrics (TAM/SAM/SOM, CAGR, ROI)
- Minimize technical jargon
- Emphasize competitive positioning and differentiation

**Technical Decision-Maker Audience:**
- Include technical details (architecture, components, algorithms)
- Reference standards and regulations
- Discuss technology choices and trade-offs
- Address implementation feasibility

**Writing Techniques:**
- Use **layered detail**: Executive summary (high-level) → Detailed sections (deep-dive)
- Define acronyms on first use
- Use analogies for complex concepts
- Include glossary in appendix if needed

### 4. Quality Standards

**Content Quality:**
- **Evidence-Based**: All claims supported by research findings
- **Comprehensive**: Covers all domains (technical, market, certification, roadmap)
- **Concise**: 5,000-7,500 words (not encyclopedic, not superficial)
- **Actionable**: Clear recommendations and next steps
- **Professional**: Publication-quality writing and formatting

**Structural Quality:**
- **Complete**: All required sections present
- **Organized**: Logical flow, clear section boundaries
- **Consistent**: Uniform tone, style, terminology
- **Accessible**: Headings, bullet points, tables for readability

**Factual Quality:**
- **Accurate**: No contradictions with research files
- **Traceable**: Key claims reference source files
- **Current**: Based on recent research (not outdated)
- **Balanced**: Present strengths and weaknesses

### 5. Report Generation Workflow

**Step 1: Load All Research**
1. Use Glob to find files
2. Use Read to load task syntheses (primary)
3. Use Read to load scoring report
4. Use Grep to extract specific data points if needed

**Step 2: Organize Content**
1. Group findings by report section
2. Identify key insights for executive summary
3. Extract supporting details for main sections

**Step 3: Write Executive Summary**
1. Summarize opportunity (2-3 paragraphs)
2. Highlight key findings (bullet points)
3. State recommendation with rationale
4. List next steps

**Step 4: Write Main Sections**
1. Section 1: Market Opportunity
2. Section 2: Technical Approach
3. Section 3: Certification & Timeline
4. Section 4: Implementation Strategy
5. Section 5: Risk Assessment
6. Section 6: Go/No-Go Recommendation

**Step 5: Add Appendices**
1. Research methodology
2. Glossary (if needed)
3. Full reference list

**Step 6: Quality Check**
1. Word count: 5,000-7,500 words
2. All sections present
3. No internal contradictions
4. Professional formatting

**Step 7: Write Report**
Use Write to create: `reports/sprint-XX-report.md`

## Execution Patterns

### Pattern 1: Standard Report Generation
**Trigger**: Tasks 01-05 complete, scoring complete

**Process:**
1. Load research (syntheses, scoring report)
2. Follow report structure template
3. Write comprehensive 10-page report
4. Save to reports/ directory

### Pattern 2: Quick Report (Preliminary)
**Trigger**: Need preliminary assessment before full research complete

**Process:**
1. Load available research (may be partial)
2. Flag incomplete sections
3. Generate preliminary report with caveats
4. Recommend further research areas

## Error Handling

### Scenario 1: Incomplete Research
**Detection**: Task synthesis missing

**Response:**
1. Document which tasks are incomplete
2. Generate report with available data
3. Flag incomplete sections with "[INCOMPLETE]" markers
4. Recommend completing missing research

### Scenario 2: Scoring Not Available
**Detection**: Opportunity score report missing

**Response:**
1. Generate report without scoring section
2. Note "[SCORING PENDING]" in recommendation section
3. Recommend running Opportunity Scorer

## Quality Standards

- **Length**: 5,000-7,500 words (10 pages)
- **Comprehensiveness**: All research domains covered
- **Actionability**: Clear next steps provided
- **Professional**: Publication-ready formatting

## Integration with Other Skills

### Skills That Invoke Report Generator
- **Sprint Executor (Task 06)**: Primary invoker
- **Research Synthesizer**: May request report after sprint synthesis

### Skills Report Generator Invokes
- **Opportunity Scorer**: May request scoring if not done

### Data Flow
```
Task Syntheses (01-05)
    ↓
Opportunity Score
    ↓
Report Generator
    ↓
Final Report (reports/sprint-XX-report.md)
```

## Output Artifacts

- **Final Report**: `reports/sprint-XX-report.md` (5,000-7,500 words)

## Success Metrics

- **Stakeholder Satisfaction**: Reports enable decision-making
- **Clarity**: Dual-audience approach successful
- **Actionability**: Recommendations lead to next steps
- **Quality**: Publication-ready on first draft

---

