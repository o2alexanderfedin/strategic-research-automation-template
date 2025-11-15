# Customization Guide

**Framework**: Strategic Research Automation
**Audience**: Advanced users adapting framework to specific industries
**Last Updated**: 2025-11-14

---

This guide explains how to customize the Strategic Research Automation Framework for different industries, company sizes, analysis types, and use cases. You will learn to adapt terminology, scoring criteria, research questions, and skills to match your specific domain.

## Table of Contents

- [Industry Adaptation Overview](#industry-adaptation-overview)
- [Aviation Industry Customization](#aviation-industry-customization)
- [Healthcare Industry Customization](#healthcare-industry-customization)
- [FinTech Industry Customization](#fintech-industry-customization)
- [Company Size Customization](#company-size-customization)
- [Analysis Type Customization](#analysis-type-customization)
- [Scoring Rubric Customization](#scoring-rubric-customization)
- [Skill Customization](#skill-customization)
- [Command Customization](#command-customization)
- [Customization Checklist](#customization-checklist)

---

## Industry Adaptation Overview

Industry adaptation involves tailoring four key areas:

1. **Terminology**: Replace generic terms with industry-specific vocabulary
2. **Research Questions**: Modify task questions for domain relevance
3. **Scoring Rubric**: Adjust weights and criteria for sector priorities
4. **Quality Standards**: Set evidence requirements appropriate for domain

### Terminology Customization

Each industry has unique terms for regulations, standards, compliance frameworks, and market segments. Update these in:

- **Task files** (`sprints/*/0X-task-name.md`) - Research questions
- **Context templates** (`context/*.md`) - Background descriptions
- **Configuration** (`config/scoring-rubric.yml`) - Dimension names
- **Skills** (`.claude/skills/*/SKILL.md`) - Activation triggers

**Common terminology categories**:

| Category | Generic | Aviation | Healthcare | FinTech |
|----------|---------|----------|------------|---------|
| **Regulatory Body** | Regulator | FAA, EASA | FDA, ONC | SEC, FINRA |
| **Standards** | Industry Standard | ASTM, DO-178C | HL7 FHIR, DICOM | PCI-DSS, ISO 20022 |
| **Compliance** | Certification | Type Certificate, TSO | 510(k), HIPAA | SOC 2, AML/KYC |
| **Product** | Solution | Aircraft, Avionics | Medical Device, EHR | RegTech Platform |
| **Market** | Customer Segment | OEM, Operator | Provider, Payer | Bank, Fintech |

### Research Question Templates

Adapt the six standard tasks to your industry by modifying research questions:

**Task 01: Technical Research**
- Aviation: "Which DO-178C Design Assurance Level applies?"
- Healthcare: "Which FDA classification applies (Class I/II/III)?"
- FinTech: "Which SOC 2 Type criteria apply?"

**Task 02: Market Analysis**
- Aviation: "What is TAM for Part 23/Industry Regulation XYZ aircraft segment?"
- Healthcare: "What is TAM for EHR integration in hospitals?"
- FinTech: "What is TAM for AML compliance software?"

**Task 04: Certification Strategy**
- Aviation: "What is the FAA certification pathway (STC, TSO, etc.)?"
- Healthcare: "What is the FDA regulatory pathway (510(k), De Novo, PMA)?"
- FinTech: "What are the audit requirements (SOC 2 Type I/II)?"

---

## Aviation Industry Customization

Complete example: Adapting the framework for aviation opportunities under Industry Regulation XYZ (Modernization of Special Airworthiness Certification) regulations.

### Context Configuration

**File**: `context/company-profile.md`

```markdown
# Company Profile: TechCo

## Core Capabilities

### SMT Verification for Safety-Critical Avionics
- Z3 and CVC5 SMT solver integration for flight-critical systems
- DO-178C compliance (up to Design Assurance Level A)
- DO-333 formal methods expertise
- TSO (Technical Standard Order) certification support

### Regulatory Expertise
- FAA Part 23 and Industry Regulation XYZ regulations
- EASA CS-23 certification processes
- ASTM F3408 (general aviation avionics) standards
- Transport Canada TP 15003 equivalent pathways

### Target Market
- eVTOL manufacturers (Joby, Archer, Lilium, etc.)
- Light Sport Aircraft (LSA) OEMs
- General aviation avionics suppliers
- Unmanned Aircraft Systems (UAS) developers
```

**File**: `context/client-info.md`

```markdown
# Client Information: Ben Errez

## Background
Entrepreneur with Part 121 airline and GA background exploring new aircraft category and eVTOL certification opportunities. Interested in identifying high-value market entry points for SMT-verified avionics systems.

## Specific Interests
- Industry Regulation XYZ regulatory framework opportunities
- eVTOL flight control systems (Fly-by-Wire)
- Electric propulsion monitoring and control
- Autonomous flight systems for UAM (Urban Air Mobility)

## Decision Criteria
1. Clear regulatory pathway (FAA certainty)
2. Large addressable market ($500M+ TAM)
3. Competitive differentiation potential
4. 18-24 month time to market
```

### Scoring Rubric Customization

**File**: `config/scoring-rubric.yml`

```yaml
# Aviation-specific scoring rubric
scoring:
  dimensions:
    market_opportunity:
      weight: 0.20  # Reduced from default 0.25 (market less critical than regulatory)
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
        verification_feasibility: 0.25  # Aviation-specific
        safety_assurance: 0.20          # Aviation-specific

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
      weight: 0.25  # Increased from default 0.15 (critical for aviation)
      criteria:
        faa_clarity: 0.40           # Aviation-specific
        certification_complexity: 0.30
        precedent_availability: 0.20
        standards_maturity: 0.10    # ASTM standards

  thresholds:
    strong_go: 80   # 80-100 points
    go: 65          # 65-79 points
    conditional: 50 # 50-64 points
    no_go: 0        # <50 points
```

### Task Research Questions

**File**: `sprints/01-flight-control/01-technical-research.md`

```markdown
# Task 01: Technical Requirements Research
## Sprint 01: eVTOL Flight Control Verification

**Objective**: Analyze technical requirements, regulations, competitive technologies, and feasibility for SMT-verified eVTOL flight control systems under Industry Regulation XYZ.

---

## Research Questions

### Technical Requirements Analysis
1. What are the specific technical requirements for eVTOL flight control systems under Industry Regulation XYZ regulations?
2. Which DO-178C Design Assurance Level (DAL) applies to primary flight controls? DAL A, B, or C?
3. What are the performance requirements for control surface actuation (latency, precision, reliability)?
4. What redundancy architectures are required (dual, triple, quadruple)?

### Regulatory Standards
1. Which ASTM standards govern Industry Regulation XYZ aircraft avionics? (Focus on ASTM F3408)
2. How does DO-333 "Formal Methods Supplement to DO-178C" apply to SMT verification?
3. What are TSO (Technical Standard Order) requirements for flight control computers?
4. How do Industry Regulation XYZ regulations differ from traditional Part 23 for flight controls?

### Competitive Technology Landscape
1. Which companies currently provide flight control systems for eVTOL aircraft?
2. What verification approaches do competitors use (testing, simulation, formal methods)?
3. Are there existing STCs (Supplemental Type Certificates) for SMT-verified avionics?
4. What is the state of the art in flight control verification?

### Technical Feasibility Assessment
1. Is SMT verification capable of satisfying DO-178C objectives for DAL A systems?
2. What are the tool qualification requirements for SMT solvers under DO-330?
3. What are the computational complexity constraints for real-time flight control verification?
4. What integration challenges exist between SMT verification tools and avionics development environments?
```

**File**: `sprints/01-flight-control/04-certification-strategy.md`

```markdown
# Task 04: Certification and Compliance Strategy
## Sprint 01: eVTOL Flight Control Verification

**Objective**: Define FAA/EASA certification pathway, compliance requirements, testing strategy, and timeline/cost for Industry Regulation XYZ eVTOL flight control certification.

---

## Research Questions

### Regulatory Framework
1. What is the FAA certification pathway for eVTOL flight control systems? (STC, TSO, or Type Certificate amendment?)
2. How does Industry Regulation XYZ streamline certification compared to Part 23?
3. What are EASA CS-23 equivalent requirements (for international sales)?
4. What role does the FAA's Special Conditions process play for novel eVTOL designs?

### Applicable Standards
1. Which DO-178C objectives must be satisfied for DAL A flight control software?
2. Which DO-254 (hardware) requirements apply to flight control computers?
3. How does ASTM F3408 relate to DO-178C and DO-254?
4. What ARP4754A (systems engineering) requirements apply?

### Testing and Validation
1. What ground testing is required (HITL, iron bird, rig testing)?
2. What flight testing is required (test cards, hours, scenarios)?
3. What environmental testing is required (DO-160 for avionics)?
4. How does SMT verification reduce testing burden under DO-178C?

### Precedents and Case Studies
1. Have any eVTOL companies achieved FAA type certification for flight controls?
2. Are there precedents for DO-333 formal methods credit in flight-critical systems?
3. What lessons learned exist from Joby, Archer, or Lilium certification efforts?
4. What is the typical timeline for flight control TSO approval?

### Certification Strategy
1. Should we pursue TSO standalone or as part of aircraft type certification?
2. What is the optimal sequencing (design → verification → testing → certification)?
3. What are the key risks and mitigation strategies?
4. What is the estimated timeline from design freeze to certification?

### Timeline and Cost Estimation
1. What is the typical duration for DO-178C DAL A software certification? (12-24 months?)
2. What are the FAA certification costs (application fees, DER fees, testing)?
3. What are tool qualification costs for SMT solvers under DO-330?
4. What is the total cost estimate (engineering + certification)?
```

### Results from Aviation Customization

Using this configuration for the Industry Regulation XYZ eVTOL project:
- **10 sprints** identified via `/discover-opportunities`
- **350+ research files** generated
- **10 strategic reports** (5,000-7,500 words each)
- **Regulatory pathway dimension** scored highest importance (25% weight)
- **Top 3 opportunities** emerged: Flight control, propulsion, navigation systems
- **Average citation ratio**: 89% (exceeding 80% quality threshold)

---

## Healthcare Industry Customization

Example: Adapting the framework for EHR (Electronic Health Record) integration and interoperability opportunities.

### Context Configuration

**File**: `context/company-profile.md`

```markdown
# Company Profile: HealthTech Consulting

## Core Capabilities

### EHR Integration Expertise
- HL7 FHIR R4/R5 implementation
- Epic, Cerner, Allscripts integration experience
- SMART on FHIR app development
- CDS Hooks (Clinical Decision Support) integration

### Regulatory Compliance
- HIPAA Privacy and Security Rule compliance
- FDA 510(k) for Software as Medical Device (SaMD)
- ONC 21st Century Cures Act certification
- State privacy laws (CCPA, GDPR for health data)

### Target Market
- Hospitals and health systems
- Ambulatory care practices
- Health IT vendors
- Digital health startups
```

**File**: `context/client-info.md`

```markdown
# Client Information: Regional Health System

## Background
150-bed community hospital seeking to improve EHR interoperability for care coordination and patient engagement.

## Specific Needs
- Bi-directional HL7 FHIR interfaces with regional HIE (Health Information Exchange)
- Patient portal integration with Epic MyChart
- Remote patient monitoring (RPM) device integration
- Clinical decision support for chronic disease management

## Decision Criteria
1. HIPAA and ONC compliance
2. Seamless Epic EHR integration
3. 6-12 month implementation timeline
4. ROI within 18 months (reduced readmissions, improved quality metrics)
```

### Scoring Rubric Customization

```yaml
# Healthcare-specific scoring rubric
scoring:
  dimensions:
    market_opportunity:
      weight: 0.25
      criteria:
        patient_population: 0.30  # Healthcare-specific
        reimbursement_potential: 0.30  # Healthcare-specific
        quality_metrics_impact: 0.20   # Healthcare-specific
        revenue_potential: 0.20

    technical_feasibility:
      weight: 0.20
      criteria:
        fhir_compatibility: 0.35       # Healthcare-specific
        ehr_integration_complexity: 0.30  # Healthcare-specific
        clinical_validation: 0.20      # Healthcare-specific
        technology_maturity: 0.15

    competitive_position:
      weight: 0.15
      criteria:
        differentiation: 0.35
        barriers_to_entry: 0.30
        competitive_landscape: 0.35

    execution_readiness:
      weight: 0.15
      criteria:
        capability_match: 0.30
        implementation_timeline: 0.25
        partnership_potential: 0.25
        change_management: 0.20       # Healthcare-specific

    regulatory_pathway:
      weight: 0.25  # High for healthcare
      criteria:
        hipaa_compliance: 0.40        # Healthcare-specific
        fda_pathway_clarity: 0.30     # Healthcare-specific
        onc_certification: 0.20       # Healthcare-specific
        state_privacy_laws: 0.10      # Healthcare-specific
```

### Task Research Questions

**File**: `sprints/01-ehr-interoperability/01-technical-research.md`

```markdown
## Research Questions

### Technical Requirements
1. Which HL7 FHIR resources are required for care coordination? (Patient, Encounter, Condition, MedicationRequest, etc.)
2. What are Epic's FHIR API capabilities and limitations?
3. What authentication/authorization mechanisms are required? (SMART on FHIR, OAuth 2.0, UDAP)
4. What are data mapping requirements between FHIR and Epic's proprietary models?

### Regulatory Standards
1. Which ONC 21st Century Cures Act provisions apply?
2. What HIPAA Security Rule technical safeguards are required?
3. Does this qualify as Software as Medical Device (SaMD) requiring FDA 510(k)?
4. What HL7 FHIR Implementation Guides apply? (US Core, Argonaut, Da Vinci)

### Competitive Landscape
1. Which vendors provide HL7 FHIR integration platforms? (Redox, Rhapsody, Mirth Connect)
2. What are Epic's built-in interoperability capabilities vs. third-party needs?
3. Are there successful precedents for similar integrations?
4. What is the state of the art in FHIR-based care coordination?
```

**File**: `sprints/01-ehr-interoperability/04-certification-strategy.md`

```markdown
## Research Questions

### Regulatory Framework
1. Is FDA 510(k) clearance required, or does this qualify for enforcement discretion?
2. What ONC Health IT Certification criteria apply? (§170.315 certification criteria)
3. What HIPAA risk assessment and documentation are required?
4. Are there state-specific privacy requirements (e.g., California CMIA)?

### Compliance Standards
1. Which HL7 FHIR profiles must be implemented? (US Core R4 minimum?)
2. What security standards apply? (NIST 800-53, HITRUST CSF)
3. What audit logging requirements exist under HIPAA?
4. What patient consent management requirements exist?

### Testing and Validation
1. What clinical validation testing is required?
2. What interoperability testing is required? (Connectathons, Touchstone testing)
3. What security testing is required? (penetration testing, vulnerability scanning)
4. What Epic sandbox testing is available?

### Timeline and Cost
1. What is typical timeline for ONC certification? (6-12 months?)
2. What are ONC-ACB (Authorized Certification Body) costs?
3. What are Epic integration consulting costs?
4. What is total cost estimate?
```

### Conversion from Aviation to Healthcare

To convert an existing aviation-focused configuration to healthcare:

1. **Update terminology** in all task files:
   - FAA → FDA, ONC
   - DO-178C → HL7 FHIR, HIPAA
   - ASTM → ONC certification criteria
   - eVTOL → EHR, Medical Device

2. **Adjust scoring rubric** weights:
   - Increase `hipaa_compliance` weight
   - Add `clinical_validation` criterion
   - Add `reimbursement_potential` criterion

3. **Modify context files**:
   - Replace aviation expertise with healthcare IT capabilities
   - Update client from airline/OEM to hospital/health system

4. **Update quality standards**:
   ```yaml
   quality:
     clinical_validation_required: true  # Healthcare-specific
     hipaa_compliance_check: true       # Healthcare-specific
     fhir_conformance_check: true       # Healthcare-specific
   ```

---

## FinTech Industry Customization

Example: Adapting the framework for RegTech (Regulatory Technology) compliance opportunities.

### Context Configuration

**File**: `context/company-profile.md`

```markdown
# Company Profile: Compliance Advisors

## Core Capabilities

### RegTech Platform Development
- AML (Anti-Money Laundering) transaction monitoring
- KYC (Know Your Customer) identity verification
- Sanctions screening and watchlist management
- Regulatory reporting automation (SAR, CTR, FBAR)

### Regulatory Expertise
- FinCEN guidance and Bank Secrecy Act compliance
- SEC Regulation Best Interest (Reg BI)
- FINRA Rule 3110 supervision requirements
- MiFID II (EU) and FCA (UK) reporting

### Target Market
- Regional and community banks
- Broker-dealers and RIAs (Registered Investment Advisors)
- FinTech companies (neobanks, payment processors)
- Cryptocurrency exchanges
```

### Scoring Rubric Customization

```yaml
# FinTech RegTech scoring rubric
scoring:
  dimensions:
    market_opportunity:
      weight: 0.25
      criteria:
        tam_size: 0.30
        compliance_penalty_risk: 0.30  # FinTech-specific
        automation_roi: 0.25           # FinTech-specific
        revenue_potential: 0.15

    technical_feasibility:
      weight: 0.20
      criteria:
        ml_model_accuracy: 0.35        # FinTech-specific
        integration_complexity: 0.25
        real_time_processing: 0.25     # FinTech-specific
        technology_maturity: 0.15

    competitive_position:
      weight: 0.15
      criteria:
        differentiation: 0.35
        regulatory_moat: 0.30          # FinTech-specific
        competitive_landscape: 0.35

    execution_readiness:
      weight: 0.15
      criteria:
        capability_match: 0.30
        regulatory_approval: 0.30      # FinTech-specific
        time_to_market: 0.25
        partnership_potential: 0.15

    regulatory_pathway:
      weight: 0.25  # Critical for RegTech
      criteria:
        compliance_certainty: 0.40     # FinTech-specific
        audit_trail_requirements: 0.30 # FinTech-specific
        data_retention: 0.20           # FinTech-specific
        cross_border_complexity: 0.10  # FinTech-specific
```

### Task Research Questions

**File**: `sprints/01-aml-monitoring/01-technical-research.md`

```markdown
## Research Questions

### Technical Requirements
1. What transaction monitoring rules are required for AML compliance? (FinCEN guidance)
2. What ML model architectures are effective for suspicious activity detection?
3. What real-time processing throughput is required? (transactions per second)
4. What data sources are required? (transaction logs, customer profiles, watchlists)

### Regulatory Standards
1. What are FinCEN's AML transaction monitoring requirements?
2. What FFIEC (Federal Financial Institutions Examination Council) guidance applies?
3. What are OFAC (Office of Foreign Assets Control) sanctions screening requirements?
4. What are SAR (Suspicious Activity Report) filing requirements?
```

---

## Company Size Customization

### Enterprise Configuration

Large enterprises require extensive documentation, multi-stakeholder analysis, and detailed risk assessment.

**Characteristics**:
- Complex approval workflows (legal, compliance, IT, business)
- Risk-averse culture (thorough analysis preferred)
- Budget flexibility (cost less critical than risk mitigation)
- Long decision cycles (6-12 months)

**Configuration adjustments**:

```yaml
# config/project-config.yml - Enterprise
research:
  depth: comprehensive        # More thorough than standard
  parallel_execution: false   # Sequential for review gates
  stakeholder_analysis: true  # Identify all decision-makers

quality:
  citation_ratio_min: 0.90    # Higher evidence standard
  executive_summary_length: 1000  # Detailed summaries
  risk_assessment_required: true  # Mandatory risk section
```

**Task modifications**:
- Add stakeholder analysis section to Task 02 (Market Analysis)
- Expand risk assessment in Task 05 (Roadmap Planning)
- Include change management strategy

### Startup Configuration

Startups prioritize speed, MVP focus, and capital efficiency.

**Characteristics**:
- Fast decision-making (1-2 weeks)
- MVP-first mindset (launch quickly, iterate)
- Capital constraints (cost-sensitive)
- High risk tolerance

**Configuration adjustments**:

```yaml
# config/project-config.yml - Startup
research:
  depth: standard             # Faster research
  parallel_execution: true    # Maximize speed
  mvp_focus: true             # Emphasize quick validation

quality:
  citation_ratio_min: 0.70    # Lower evidence threshold
  report_length_min: 3000     # Shorter reports (3-5 pages)
  speed_to_market_weight: 0.30  # Prioritize speed
```

**Scoring rubric adjustments**:
```yaml
execution_readiness:
  weight: 0.30  # Increased from 0.15
  criteria:
    time_to_market: 0.40      # Critical for startups
    mvp_feasibility: 0.30     # Can we launch quickly?
    capital_efficiency: 0.30  # Minimize burn rate
```

### Consultancy Configuration

Consultancies need client-facing deliverable quality and reusable methodology.

**Characteristics**:
- Professional formatting and presentation
- Evidence-based argumentation (client persuasion)
- Reusable templates (multiple engagements)
- IP development (methodology as asset)

**Configuration adjustments**:

```yaml
# config/project-config.yml - Consultancy
output:
  format: professional        # High-quality formatting
  branding: enabled           # Include company branding
  executive_friendly: true    # Non-technical summaries
  reusable_templates: true    # Save for future engagements

quality:
  citation_ratio_min: 0.85    # Strong evidence for credibility
  visual_aids_required: true  # Charts, diagrams, tables
  client_ready: true          # Polished deliverables
```

---

## Analysis Type Customization

### Strategic Opportunity Analysis (Default)

Focused on market sizing, competitive positioning, and go/no-go recommendations.

**Use case**: Identifying new business opportunities

**Configuration**: Standard framework configuration

### Competitive Intelligence

Deep competitor analysis, patent landscape, market share dynamics.

**Use case**: Understanding competitive threats and opportunities

**Configuration adjustments**:

```yaml
# Emphasize Task 02 (Market Analysis) competitive section
research:
  competitive_depth: comprehensive
  patent_analysis: true
  market_share_tracking: true
```

**Task modifications**:
- Expand competitive landscape section in Task 02
- Add patent landscape analysis
- Include competitor product teardown

### Market Entry Strategy

Geographic expansion analysis, local regulatory requirements, partnership identification.

**Use case**: Entering new markets or geographies

**Configuration adjustments**:

```yaml
research:
  geographic_focus: true
  local_regulations: true
  partnership_mapping: true
```

**Task modifications**:
- Add geographic market analysis to Task 02
- Add local regulatory requirements to Task 04
- Add partnership identification to Task 05

### Technology Assessment

Technical feasibility deep-dive, build vs. buy analysis, vendor evaluation.

**Use case**: Technology selection and vendor evaluation

**Configuration adjustments**:

```yaml
research:
  technical_depth: comprehensive
  vendor_evaluation: true
  build_vs_buy: true
```

**Task modifications**:
- Expand Task 01 (Technical Research) with vendor comparison
- Add build vs. buy analysis to Task 03 (Solution Architecture)
- Add vendor risk assessment to Task 05 (Roadmap Planning)

---

## Scoring Rubric Customization

The scoring rubric determines opportunity prioritization. Customize weights and criteria to match your industry and priorities.

### Weight Adjustments by Industry

| Industry | Regulatory | Market | Technical | Competitive | Execution |
|----------|-----------|---------|-----------|-------------|-----------|
| **Aviation** | 0.25 | 0.20 | 0.20 | 0.15 | 0.20 |
| **Healthcare** | 0.25 | 0.25 | 0.20 | 0.15 | 0.15 |
| **FinTech** | 0.25 | 0.25 | 0.20 | 0.15 | 0.15 |
| **Consumer Tech** | 0.10 | 0.30 | 0.20 | 0.20 | 0.20 |
| **Enterprise SaaS** | 0.15 | 0.25 | 0.20 | 0.20 | 0.20 |

### Adding Custom Criteria

Example: Adding "Environmental Impact" criterion for sustainability-focused analysis

```yaml
scoring:
  dimensions:
    environmental_impact:     # New dimension
      weight: 0.15
      criteria:
        carbon_reduction: 0.40
        sustainability: 0.30
        esg_alignment: 0.30

    market_opportunity:
      weight: 0.20            # Reduced from 0.25 to accommodate new dimension
    # ... other dimensions adjusted
```

### Threshold Customization

Adjust recommendation thresholds based on risk tolerance:

```yaml
# Risk-averse (enterprise)
thresholds:
  strong_go: 85    # Higher bar for "STRONG GO"
  go: 75
  conditional: 60
  no_go: 0

# Risk-tolerant (startup)
thresholds:
  strong_go: 70    # Lower bar for "STRONG GO"
  go: 55
  conditional: 40
  no_go: 0
```

---

## Skill Customization

Create industry-specific skill variants by copying existing skills and modifying activation triggers and research areas.

### Example: Healthcare Compliance Analyst Skill

**File**: `.claude/skills/healthcare-compliance-analyst/SKILL.md`

```markdown
---
name: healthcare-compliance-analyst
description: "Analyzes FDA regulatory pathways, HIPAA compliance, ONC certification, and clinical validation requirements for healthcare software and medical devices"
activation-triggers:
  - FDA 510(k)
  - HIPAA
  - HL7 FHIR
  - ONC certification
  - Clinical validation
  - Medical device
  - EHR integration
---

# Healthcare Compliance Analyst Skill

You are a healthcare regulatory compliance analyst specializing in:
- FDA Software as Medical Device (SaMD) classification and pathways
- HIPAA Privacy Rule and Security Rule compliance
- ONC 21st Century Cures Act certification (§170.315 criteria)
- HL7 FHIR Implementation Guides (US Core, Argonaut, Da Vinci)
- Clinical validation and evidence requirements

## Research Areas

1. **FDA Regulatory Classification**
   - Determine if software qualifies as medical device
   - Identify applicable classification (Class I/II/III)
   - Assess 510(k), De Novo, or PMA pathway

2. **HIPAA Compliance**
   - Privacy Rule requirements (patient consent, minimum necessary)
   - Security Rule requirements (encryption, access controls, audit logs)
   - Breach notification obligations

3. **ONC Certification**
   - Applicable certification criteria (§170.315)
   - Testing and certification timeline
   - Maintenance of certification requirements

4. **Clinical Validation**
   - Evidence requirements for clinical claims
   - Validation study design
   - Real-world evidence vs. clinical trials

[... detailed prompt ...]
```

### Activation Testing

To verify custom skill activates correctly:

```bash
# Test activation
echo "We need to ensure HIPAA compliance and FDA 510(k) clearance" | claude -p "/execute-task 01 04"

# Should activate healthcare-compliance-analyst skill
```

---

## Command Customization

Add custom slash commands for domain-specific workflows.

### Example: Custom Compliance Checklist Command

**File**: `.claude/commands/generate-compliance-checklist.md`

```markdown
---
name: generate-compliance-checklist
description: "Generates HIPAA and FDA compliance checklist for healthcare projects"
---

Generate a comprehensive compliance checklist for the current project based on:

1. **HIPAA Requirements**
   - Privacy Rule compliance items
   - Security Rule technical safeguards
   - Breach notification preparedness

2. **FDA Requirements** (if applicable)
   - Software classification determination
   - 510(k) submission requirements
   - Quality System Regulation (QSR) items

3. **ONC Certification** (if applicable)
   - Certification criteria checklist
   - Testing requirements
   - Maintenance of certification items

Output format: Markdown checklist in `reports/compliance-checklist.md`
```

**Usage**:
```bash
/generate-compliance-checklist
```

---

## Customization Checklist

Before starting research with customized configuration:

### Terminology
- [ ] Identify industry-specific regulatory bodies
- [ ] List applicable standards and compliance frameworks
- [ ] Define market segment terminology
- [ ] Update task research questions with domain terms

### Configuration
- [ ] Adjust scoring rubric weights for industry priorities
- [ ] Add or modify scoring criteria
- [ ] Set quality standards (citation ratio, evidence requirements)
- [ ] Configure analysis depth (comprehensive vs. standard)

### Context
- [ ] Update company profile with domain expertise
- [ ] Fill in client information with specific needs
- [ ] Provide industry background and trends
- [ ] Define competitive landscape

### Skills (Optional)
- [ ] Create industry-specific skill variants
- [ ] Define activation triggers for domain
- [ ] Test skill activation

### Validation
- [ ] Run pilot sprint to test configuration
- [ ] Review research quality and relevance
- [ ] Iterate on task questions if needed
- [ ] Validate scoring rubric produces sensible rankings

---

## Next Steps

- **Examples**: See [Aviation Example](./EXAMPLE-AVIATION-Industry Regulation XYZ.md) and [Healthcare Example](./EXAMPLE-HEALTHCARE-CONVERSION.md)
- **Configuration Reference**: Consult [Configuration Reference](./CONFIGURATION-REFERENCE.md) for schema details
- **Skills**: Read [Skills Reference](./SKILLS-REFERENCE.md) for customization options
- **Troubleshooting**: Review [Troubleshooting Guide](./TROUBLESHOOTING.md) for common issues

---

**Document Version**: 1.0
**Word Count**: ~2,900 words
**Last Updated**: 2025-11-14
