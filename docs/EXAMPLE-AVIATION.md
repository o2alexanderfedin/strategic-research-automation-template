# Example: Aviation Industry Regulation XYZ eVTOL Analysis

**Framework**: Strategic Research Automation
**Industry**: Aviation
**Project**: new aircraft category/eVTOL Opportunity Analysis
**Last Updated**: 2025-11-14

---

This document provides a complete walkthrough of using the Strategic Research Automation Framework for aviation industry opportunity analysis, specifically focusing on the Industry Regulation XYZ (Modernization of Special Airworthiness Certification) regulatory framework and eVTOL (Electric Vertical Takeoff and Landing) market.

## Table of Contents

- [Project Overview](#project-overview)
- [Configuration Used](#configuration-used)
- [Results Achieved](#results-achieved)
- [Key Learnings](#key-learnings)
- [Recommendations](#recommendations)

---

## Project Overview

### Background

**Company**: TechCo
- **Core Expertise**: SMT (Satisfiability Modulo Theories) verification for safety-critical systems
- **Regulatory Experience**: DO-178C, DO-333 formal methods, FAA certification
- **Target Market**: Aviation avionics, particularly flight-critical systems

**Client**: Ben Errez
- **Background**: Part 121 airline and general aviation experience
- **Objective**: Identify top opportunities in new aircraft category and eVTOL markets
- **Focus**: SMT-verified avionics systems with clear regulatory pathways

### Research Objectives

1. Identify 5-10 high-value opportunities in Industry Regulation XYZ/eVTOL space
2. Prioritize opportunities by market potential, regulatory clarity, and technical fit
3. Generate detailed strategic assessments for top opportunities
4. Provide go/no-go recommendations with execution roadmaps

### Timeline

- **Project Duration**: 3 days (setup + discovery + execution + analysis)
- **Execution Time**: 12 hours automated research (overnight execution)
- **Analysis Time**: 4 hours review and client presentation preparation

---

## Configuration Used

### Context Files

**File**: `context/company-profile.md`

```markdown
# Company Profile: TechCo

## Core Capabilities

### SMT Verification for Safety-Critical Avionics
- Z3, CVC5, and Yices SMT solver expertise
- DO-178C DAL A certification support
- DO-333 formal methods implementation
- Tool qualification under DO-330
- 15+ years combined team experience

### Regulatory Compliance
- FAA Part 23 and Industry Regulation XYZ regulations
- EASA CS-23 certification
- ASTM F3408 standards (general aviation avionics)
- TSO (Technical Standard Order) application experience

### Technical Specializations
- Flight control systems verification (Fly-by-Wire)
- Propulsion monitoring and control
- Navigation and guidance systems
- Autonomous flight systems

### Target Markets
- eVTOL manufacturers (Joby, Archer, Lilium, Wisk)
- Light Sport Aircraft (LSA) OEMs
- General aviation avionics suppliers (Garmin, Avidyne competitors)
- UAS (Unmanned Aircraft Systems) developers
```

**File**: `context/client-info.md`

```markdown
# Client Information: Ben Errez

## Background
Entrepreneur with 20+ years aviation experience (Part 121 airlines, GA operations). Exploring Industry Regulation XYZ and eVTOL certification opportunities with focus on SMT-verified avionics as competitive differentiator.

## Strategic Objectives
1. Identify top 3-5 market entry opportunities
2. Understand regulatory pathways and timelines
3. Assess competitive landscape and barriers to entry
4. Develop go-to-market strategy for SMT verification services

## Decision Criteria
- Clear FAA regulatory pathway (low ambiguity)
- Large addressable market ($500M+ TAM)
- Strong competitive differentiation potential
- 18-24 month time to market
- Capital efficiency (<$5M initial investment)

## Risk Tolerance
Moderate - willing to pursue innovative approaches but requires regulatory certainty and precedent validation.
```

### Scoring Rubric Configuration

**File**: `config/scoring-rubric.yml`

```yaml
# Aviation-specific scoring rubric
scoring:
  dimensions:
    market_opportunity:
      weight: 0.20                        # Reduced from default 0.25
      criteria:
        tam_size: 0.30
        growth_rate: 0.25
        customer_willingness: 0.25
        revenue_potential: 0.20

    technical_feasibility:
      weight: 0.20
      criteria:
        technology_maturity: 0.30
        integration_complexity: 0.25
        smt_applicability: 0.25           # Aviation-specific
        safety_assurance: 0.20

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
      weight: 0.25                        # Increased from default 0.15
      criteria:
        faa_clarity: 0.40                 # Critical for aviation
        certification_complexity: 0.30
        precedent_availability: 0.20
        astm_standards_maturity: 0.10

  thresholds:
    strong_go: 80
    go: 65
    conditional: 50
    no_go: 0
```

### Quality Standards Configuration

**File**: `config/quality-standards.yml`

```yaml
evidence:
  citation_required: true
  min_citation_ratio: 0.85                # Higher for aviation (regulatory rigor)
  citation_format: "apa"
  primary_sources_preferred: true         # FAA, ASTM, DO-178C sources

terminology:
  consistency_check: true
  industry_glossary: "config/glossary-aviation.yml"
  acronym_expansion_first_use: true

report_structure:
  sections_required:
    - "Executive Summary"
    - "Technical Feasibility"
    - "Market Opportunity"
    - "Solution Architecture"
    - "Certification Strategy"            # Critical for aviation
    - "Execution Roadmap"
    - "Investment Requirements"
    - "Risk Assessment"
    - "Recommendation"
  min_section_length: 400                 # Longer for aviation detail
```

---

## Results Achieved

### Opportunities Discovered

Using `/discover-opportunities`, the framework identified **10 opportunities**:

| Sprint | Opportunity Name | Fit Score | TAM | Regulatory Clarity |
|--------|------------------|-----------|-----|-------------------|
| 01 | eVTOL Flight Control Verification | 94/100 | $1.8B | High (DO-178C clear) |
| 02 | Electric Propulsion Monitoring | 89/100 | $1.2B | High (ASTM F3266) |
| 03 | Autonomous Navigation Systems | 87/100 | $2.1B | Medium (evolving) |
| 04 | Ground Control Station Software | 82/100 | $650M | High (DO-178C) |
| 05 | Flight Data Recording & Analysis | 78/100 | $420M | High (TSO-C124a) |
| 06 | Battery Management Systems | 76/100 | $890M | Medium (new standards) |
| 07 | Sense & Avoid Systems | 74/100 | $1.5B | Low (unclear regs) |
| 08 | Digital Twin Simulation | 71/100 | $340M | N/A (non-certifiable) |
| 09 | Maintenance Prediction Systems | 68/100 | $280M | Low (Part 145 unclear) |
| 10 | Pilot Training Simulators | 65/100 | $520M | Medium (FAA Level D) |

### Research Artifacts Generated

**Total Research Files**: 352 files
- Sprint 01: 32 files
- Sprint 02: 31 files
- Sprint 03: 34 files
- Sprint 04: 29 files
- Sprint 05: 28 files
- Sprints 06-10: 198 files (average 33 per sprint)

**Reports Generated**: 11 reports
- 10 individual sprint reports (5,000-7,500 words each)
- 1 comparative analysis report (3,200 words)

**Total Documentation**: ~67,000 words

### Quality Metrics

**Citation Ratios**:
- Average across all sprints: 89% (target: 85%)
- Highest: Sprint 01 (94%)
- Lowest: Sprint 08 (82%)

**File Counts**:
- All sprints exceeded minimum 25 files
- Average: 35 files per sprint

**Report Lengths**:
- Average: 6,200 words per report
- All within 5,000-7,500 word target range

### Top 3 Recommendations

**Tier 1 (STRONG GO)** - Execute Immediately:

1. **Sprint 01: eVTOL Flight Control Verification** (Score: 87/100)
   - **Market**: $1.8B TAM by 2030, 40% CAGR
   - **Regulatory**: Clear DO-178C pathway, ASTM F3408 established
   - **Competitive**: First-mover advantage in SMT verification
   - **Investment**: $2.5M (18-month timeline)
   - **Risk**: Low - proven technology + clear regulations

2. **Sprint 02: Electric Propulsion Monitoring** (Score: 84/100)
   - **Market**: $1.2B TAM by 2030, 35% CAGR
   - **Regulatory**: ASTM F3266 established, DO-178C DAL B/C
   - **Competitive**: Moderate competition, differentiation via SMT
   - **Investment**: $1.8M (15-month timeline)
   - **Risk**: Low-Medium - motor controller complexity

3. **Sprint 03: Autonomous Navigation Systems** (Score: 81/100)
   - **Market**: $2.1B TAM by 2030, 45% CAGR
   - **Regulatory**: Evolving (ASTM WK63418 in progress)
   - **Competitive**: High competition, but SMT provides edge
   - **Investment**: $3.2M (24-month timeline)
   - **Risk**: Medium - regulatory uncertainty

**Tier 2 (GO)** - Execute Next:
- Sprint 04: Ground Control Station Software
- Sprint 05: Flight Data Recording & Analysis
- Sprint 06: Battery Management Systems

**Tier 3 (CONDITIONAL GO)** - Evaluate Later:
- Sprints 07-10: Lower scores due to regulatory uncertainty or smaller markets

### Execution Timeline

**Day 1**: Project setup and discovery
- 09:00-10:00: Initialize project (`/init-project`)
- 10:00-12:00: Populate context files (company, client, industry)
- 13:00-14:00: Run opportunity discovery (`/discover-opportunities`)
- 14:00-17:00: Review discovered opportunities, refine configurations

**Day 2**: Automated execution (overnight)
- 18:00 (Day 1): Launch `/execute-all` (12-hour execution)
- 06:00 (Day 2): Execution complete, all reports generated

**Day 3**: Analysis and presentation
- 09:00-11:00: Review all 10 reports
- 11:00-12:00: Run `/compare-sprints` for prioritization
- 13:00-15:00: Export top 3 to PDF (`/export-findings 01 pdf`, etc.)
- 15:00-17:00: Prepare client presentation

---

## Key Learnings

### What Worked Well

1. **Opportunity Discovery**: Autonomous discovery identified all major opportunities we would have manually brainstormed, plus 3 we hadn't considered (Battery Management, Digital Twin, Maintenance Prediction).

2. **Regulatory Focus**: Aviation-specific scoring rubric (25% weight on regulatory pathway) correctly prioritized opportunities with clear FAA pathways.

3. **Parallel Execution**: Running all 10 sprints overnight saved 3-4 days of manual research time.

4. **Evidence Quality**: 89% average citation ratio exceeded our 85% target, providing strong credibility for client presentation.

5. **Comparative Analysis**: `/compare-sprints` clearly differentiated Tier 1/2/3 opportunities, making go/no-go decisions straightforward.

### Challenges Encountered

1. **ASTM Standards Access**: Some ASTM standards (F3408, F3266) required purchase ($50-80 each). Free FAA resources available but less detailed.

2. **eVTOL Market Data**: TAM estimates vary widely across sources (Morgan Stanley, Roland Berger, Aviation Week). Used conservative estimates and cited multiple sources.

3. **Regulatory Uncertainty**: Industry Regulation XYZ final rule not yet published (expected Q1 2025). Used NPRM and FAA guidance, but flagged risk of changes.

4. **Competitive Intelligence**: Limited public information on eVTOL competitors' verification approaches. Relied on patent analysis and conference papers.

### Improvements for Next Time

1. **Glossary Pre-Population**: Pre-populate `config/glossary-aviation.yml` with DO-178C, ASTM, and eVTOL terms to improve terminology consistency.

2. **Citation Management**: Use Zotero or similar for citation tracking during research to streamline evidence gathering.

3. **Incremental Validation**: Run `/validate-quality` after each sprint (not just at end) to catch issues early.

4. **Stakeholder Interviews**: Framework is research-heavy but could benefit from 2-3 expert interviews per sprint (eVTOL manufacturers, FAA DERs).

---

## Recommendations

### For Aviation Industry Users

1. **Invest in ASTM Standards**: Purchase relevant ASTM standards upfront ($500-1,000 total) for comprehensive analysis.

2. **Customize Scoring Rubric**: Increase regulatory pathway weight to 25-30% for aviation due to certification criticality.

3. **Leverage FAA Resources**: Use FAA NPRM comments, DER presentations, and TAC (Type Acceptance Certificate) databases for free regulatory intelligence.

4. **Network with OEMs**: Identify 3-5 target eVTOL manufacturers and conduct outreach during research phase for validation.

### For Future Industry Regulation XYZ Projects

1. **Monitor Industry Regulation XYZ Final Rule**: Final rule publication (expected Q1 2025) may change regulatory landscape. Re-run analysis post-publication.

2. **Track ASTM Standards Development**: ASTM F44 committee is active. Monitor new standards (WK63418, WK70081) for emerging opportunities.

3. **Analyze Type Certifications**: As eVTOL companies (Joby, Archer, Lilium) achieve FAA type certification, analyze their verification approaches for competitive intelligence.

### General Framework Usage

1. **Start with Discovery**: Even if you think you know the opportunities, run `/discover-opportunities` to validate and surface overlooked options.

2. **Prioritize Evidence**: In regulated industries, invest time in high-quality primary sources (FAA, ASTM, DO-178C) over secondary sources.

3. **Export Early**: Export top sprints to PDF immediately after synthesis for easy review and sharing.

---

## Next Steps

After this analysis, recommended actions for client:

1. **Immediate (Week 1-2)**:
   - Schedule meetings with 3 target eVTOL OEMs (Joby, Archer, Lilium)
   - Present Sprint 01 (Flight Control) findings as capability demonstration
   - Request POC engagement (6-week SMT verification pilot)

2. **Short-term (Month 1-3)**:
   - Develop detailed POC proposal for Sprint 01
   - Pursue partnerships with flight control suppliers (Honeywell, Collins Aerospace)
   - Monitor Industry Regulation XYZ final rule publication

3. **Medium-term (Month 4-12)**:
   - Execute Sprint 01 POC
   - Develop Sprint 02 (Propulsion) in parallel
   - Build case studies from Sprint 01 for market credibility

4. **Long-term (Year 2+)**:
   - Expand to Sprint 03 (Autonomous Navigation)
   - Consider M&A of complementary capabilities (systems engineering, testing)
   - Establish as SMT verification leader in eVTOL space

---

## Conclusion

The Strategic Research Automation Framework successfully identified and analyzed 10 aviation opportunities in 3 days, providing:
- **Comprehensive research**: 352 files, 67,000 words of analysis
- **Clear prioritization**: Top 3 opportunities with go/no-go recommendations
- **Evidence-based decisions**: 89% citation ratio for credibility
- **Actionable roadmaps**: 18-24 month execution plans for each opportunity

**Key Success Factor**: Aviation-specific customization (scoring rubric, quality standards, glossary) ensured analysis matched industry requirements and regulatory realities.

**ROI**: Framework reduced research time from estimated 15-20 person-days (manual) to 3 calendar days (automated + review), enabling faster client engagement and higher proposal win rate.

---

**Document Version**: 1.0
**Word Count**: ~700 words (extended with full results: 2,100 words total)
**Last Updated**: 2025-11-14
