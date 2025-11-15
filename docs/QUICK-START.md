# Quick Start Tutorial

Get from zero to your first strategic report in 5 minutes.

**Time**: 5 minutes
**Difficulty**: Beginner
**Prerequisites**: [Setup complete](SETUP.md)

---

## What You'll Build

By the end of this tutorial, you'll have:
- Initialized research project with configuration
- Created company and client context files
- Discovered strategic opportunities automatically
- Executed your first sprint
- Generated a 10-page strategic report with scoring

**Time investment**: 5 minutes setup + 45 minutes automated execution

---

## Step 1: Verify Prerequisites (30 seconds)

```bash
# Verify Claude Code is working
claude --version
# Expected: Claude Code v2.0.0+

# Verify you're in the project directory
ls -la
# Should see: .claude/, config/, context/, scripts/, templates/

# Verify API key is set
echo $ANTHROPIC_API_KEY | head -c 20
# Should show: sk-ant-... (first 20 chars)
```

✅ **Success**: All commands return expected output
❌ **If any fail**: See [Setup Guide](SETUP.md) → Troubleshooting

---

## Step 2: Initialize Project (1 minute)

```bash
# Initialize with your project details
./scripts/setup/claude-eng -p "/init-project 'Industry Regulation XYZ advanced system Analysis' 'technology sector' 'TechCo Consulting'"
```

**What this does**:
- Creates project configuration in `config/project-config.yml`
- Generates context file templates in `context/`
- Sets up git repository with initial commit
- Prepares directory structure

**Expected output**:
```
✓ Project initialized: Industry Regulation XYZ advanced system Analysis
✓ Industry: technology sector
✓ Company: TechCo Consulting
✓ Configuration files created in config/
✓ Context templates created in context/
✓ Git repository initialized
✓ Initial commit created

Next steps:
1. Edit context/company-profile.md with your capabilities
2. Edit context/client-info.md with client background
3. Run /discover-opportunities to find strategic fit areas
```

---

## Step 3: Configure Context (2 minutes)

### Edit Company Profile

```bash
vim context/company-profile.md
```

**Minimal example** (copy/paste this):

```markdown
# TechCo Company Profile

## Core Capabilities

- Formal verification and advanced methodology-based analysis
- Industry Standard ABC and Compliance Framework DEF certification expertise
- Autonomous systems architecture and safety analysis
- Safety-critical software development

## Technical Expertise

- Programming languages: Rust, C, Python, Dafny
- Verification tools: Z3, CVC5, Klee, AFL
- Standards: Industry Standard ABC, Compliance Framework DEF, ARP4754A, DO-326A
- Domains: technology sector, autonomous systems, embedded safety

## Past Projects

- operation control software verification for business jets
- Autonomous navigation safety cases
- Regulatory Body certification consultation for avionics

## Strategic Goals

- Expand into advanced system and urban air mobility market
- Leverage Industry Regulation XYZ regulation for new market opportunities
- Build partnerships with system manufacturers
```

### Edit Client Information

```bash
vim context/client-info.md
```

**Minimal example**:

```markdown
# Industry Regulation XYZ Opportunity Analysis

## Context

The Regulatory Body's Industry Regulation XYZ (Modernization of Special Airworthiness Certification) final rule, effective July 2026, expands the Light Sport system (LSA) category to include system up to 3,000 lbs and 250 knots. This creates new certification pathways and market opportunities.

## Objective

Identify strategic opportunities where TechCo's rigorous verification and certification expertise provides competitive advantage in the expanding Industry Regulation XYZ/advanced system market.

## Success Criteria

- Identify 5-10 high-potential opportunities
- Assess technical feasibility and market potential
- Prioritize top 3 for immediate pursuit
- Develop execution roadmaps for top opportunities
```

---

## Step 4: Discover Opportunities (30 seconds to start, 20 min automated)

```bash
# Let AI analyze your context and discover opportunities
./scripts/setup/claude-eng -p "/discover-opportunities"
```

**What this does**:
- Analyzes your company capabilities (company-profile.md)
- Analyzes client context (client-info.md)
- Identifies strategic fit areas automatically
- Generates 5-10 opportunity sprint definitions
- Creates comparative scoring

**Expected output**:
```
Analyzing context...
✓ Company capabilities parsed: 4 core competencies, 8 technical skills
✓ Client domain analyzed: Industry Regulation XYZ regulation, advanced system market trends
✓ Discovering strategic fit opportunities...

Top 10 Opportunities Discovered:

1. operation Control System Verification (Score: 95/100)
   - Technical fit: 98% (Industry Standard ABC + advanced methodology expertise)
   - Market potential: $12B TAM, $450M SAM
   - Regulatory clarity: High (Industry Regulation XYZ defines pathway)

2. Collision Avoidance Verification (Score: 92/100)
   - Technical fit: 95% (advanced methodologies + autonomy)
   - Market potential: $8B TAM, $320M SAM
   - Regulatory clarity: Medium-High (evolving standards)

3. Automated Weather Decision-Making (Score: 87/100)
   - Technical fit: 88% (autonomous systems + safety)
   - Market potential: $5B TAM, $180M SAM
   - Regulatory clarity: Medium (emerging requirements)

[... 7 more opportunities ...]

Sprint configurations created in sprints/01-10/
Ready to execute with /execute-sprint [number]
```

**This takes 15-20 minutes** to complete. While it runs, you can:
- Read the reports as they generate in `reports/00-opportunity-discovery.md`
- Review sprint configurations in `sprints/` directory
- Take a coffee break ☕

---

## Step 5: Execute First Sprint (45 minutes automated)

```bash
# Execute the top-scored opportunity
./scripts/setup/claude-eng -p "/execute-sprint 01"
```

**What this does**:
- Runs all 6 tasks in parallel:
  - Task 01: Technical & Regulatory Landscape
  - Task 02: Market & Competitive Assessment
  - Task 03: Solution Architecture Design
  - Task 04: Certification & Testing Strategy
  - Task 05: Implementation Roadmap
  - Task 06: Report Synthesis
- Generates 25-38 research files
- Creates comprehensive strategic report
- Applies scoring rubric
- Provides go/no-go recommendation

**Expected output**:
```
Sprint 01: operation Control System Verification

Task 01 (Technical Researcher) - In progress...
Task 02 (Market Analyst) - In progress...
Task 03 (Solution Architect) - In progress...
Task 04 (Compliance Analyst) - In progress...
Task 05 (Roadmap Planner) - In progress...

[~40 minutes of parallel research execution]

Task 01 completed: 32 files
  - Industry Standard ABC requirements analysis
  - Regulatory Body Industry Regulation XYZ regulatory framework
  - advanced verification feasibility
  - Related standards (Compliance Framework DEF, ARP4754A)

Task 02 completed: 27 files
  - Market sizing: TAM $12B, SAM $450M, SOM $45M-$85M
  - Competitive landscape: 8 key players
  - Customer segments: advanced system manufacturers, retrofit opportunities
  - Pricing analysis

Task 03 completed: 29 files
  - System architecture for verification framework
  - Integration with existing tools
  - Deployment models
  - Proof-of-concept specification

Task 04 completed: 25 files
  - Certification pathways under Industry Regulation XYZ
  - Testing strategy and acceptance criteria
  - Timeline estimates: POC 6mo, product 18mo, certification 12mo

Task 05 completed: 28 files
  - 3-year implementation roadmap
  - Partnership strategy (tool vendors, manufacturers)
  - Resource requirements: team of 8-12
  - Investment needs: $7.5M-$14M

Task 06 (Report Synthesizer) - Generating final report...
✓ Strategic report generated: reports/01-operation-control-verification.md
✓ Report length: 6,847 words
✓ Opportunity score: 95/100 - STRONG GO
✓ Recommendation: Execute immediately

Sprint 01 complete. Review reports/01-operation-control-verification.md
```

**This takes 40-50 minutes**. Grab lunch while it runs.

---

## Step 6: Review Your Report (1 minute)

```bash
# Open the strategic report
cat reports/01-operation-control-verification.md
# Or open in your preferred markdown viewer
```

**Report structure**:
1. Executive Summary
2. Market Opportunity (TAM/SAM/SOM)
3. Technical Feasibility Assessment
4. Competitive Landscape
5. Solution Architecture
6. Certification Pathway
7. Implementation Roadmap
8. Financial Projections
9. Risk Assessment
10. Go/No-Go Recommendation

**Typical length**: 10 pages, 6,000-7,500 words

**Quality indicators**:
```bash
# Validate quality
./scripts/setup/claude-eng -p "/validate-quality 01"

# Expected output:
✓ File count: 32 (minimum: 25)
✓ Citation ratio: 87% (threshold: 80%)
✓ Report word count: 6,847 (target: 5,000-7,500)
✓ Evidence-based analysis: PASS
✓ All quality standards met
```

---

## What You've Accomplished

In 5 minutes of setup + 60 minutes of automated execution:

✅ Initialized a research project
✅ Configured company and client context
✅ Discovered 10 strategic opportunities automatically
✅ Executed deep research on top opportunity
✅ Generated 30+ research files with citations
✅ Created publication-quality 10-page strategic report
✅ Received scored recommendation (95/100 - STRONG GO)

**Traditional approach**: 2-3 weeks, $15K-$30K in consultant fees
**This framework**: ~1 hour, $10-$20 in API costs

---

## Next Steps

### Execute More Sprints

```bash
# Execute sprint 2
./scripts/setup/claude-eng -p "/execute-sprint 02"

# Or execute all remaining sprints
./scripts/setup/claude-eng -p "/execute-all"
# Warning: This runs ALL sprints. For 10 sprints, expect 8-12 hours total.
```

### Compare Opportunities

```bash
# After executing multiple sprints, compare them
./scripts/setup/claude-eng -p "/compare-sprints"

# Generates comparative report showing:
# - Side-by-side scoring
# - Prioritization matrix
# - Portfolio recommendations
```

### Export Deliverables

```bash
# Export to PDF
./scripts/setup/claude-eng -p "/export-findings 01 pdf"

# Export to DOCX
./scripts/setup/claude-eng -p "/export-findings 01 docx"

# Export all formats
./scripts/setup/claude-eng -p "/export-findings 01 all"
```

### Customize for Your Industry

See [CUSTOMIZATION.md](CUSTOMIZATION.md) to adapt the framework for:
- Healthcare (EHR, HIPAA, HL7 FHIR)
- FinTech (RegTech, compliance, Dodd-Frank)
- Manufacturing (Industry 4.0, supply chain)
- SaaS (product-market fit, competitive analysis)

---

## Tips for Success

### Context Quality = Output Quality

**Good context**:
```markdown
# Company Profile
- Specific capabilities: "Industry Standard ABC certification with 8 successful Regulatory Body audits"
- Technical depth: "Rust-based verification with Z3 verification solver integration"
- Past results: "Reduced certification time by 40% on 737 MAX project"
```

**Poor context**:
```markdown
# Company Profile
- We do software consulting
- We're really good
- We've worked on projects
```

**Improvement**: Add specifics, evidence, and technical detail.

### Start Small, Then Scale

- ✅ Execute 1 sprint first
- ✅ Review quality and results
- ✅ Refine context and configuration
- ✅ Then execute remaining sprints

**Don't**:
- ❌ Run `/execute-all` on first try
- ❌ Skip quality validation
- ❌ Use generic context

### Monitor Resource Usage

```bash
# Check system resources while sprints run
top  # or htop

# If system is struggling:
# 1. Reduce max_parallel_tasks in config/project-config.yml
# 2. Close other applications
# 3. Execute sprints sequentially instead of /execute-all
```

---

## Troubleshooting

### Sprint Takes Longer Than Expected

**Normal execution times**:
- Single sprint: 40-60 minutes
- 10 sprints parallel: 8-12 hours

**If significantly slower**:
- Check internet connection (web research requires network)
- Reduce `max_parallel_tasks` to 3-4
- Use Claude Haiku model for speed (lower quality)

### Low Quality Score

**If quality validation fails**:
```bash
# Check specific failures
./scripts/setup/claude-eng -p "/validate-quality 01"

# Common issues:
# - Too few research files: Need more comprehensive research
# - Low citation ratio: Need more source attribution
# - Report too short: Expand analysis depth
```

**Fix**:
- Improve context files (more specific, more detail)
- Increase research depth in sprint-config.yml
- Re-execute sprint after configuration changes

### API Costs Higher Than Expected

**Typical costs** (using Sonnet model):
- Single sprint: $10-$20
- 10 sprints: $100-$200

**If costs are concerning**:
- Use Claude Haiku model (70% cheaper, slightly lower quality)
- Reduce research file count targets
- Execute sprints selectively (not all 10)

---

## Success!

You've completed the quick start tutorial. You now know how to:
- Initialize research projects
- Configure company/client context
- Discover opportunities automatically
- Execute strategic research sprints
- Generate professional reports

**Continue learning**:
- [Complete Usage Guide](USAGE.md) - All commands and workflows
- [Customization Guide](CUSTOMIZATION.md) - Adapt to your industry
- [Architecture Guide](ARCHITECTURE.md) - Understand the system
- [Examples](../examples/) - Real project walkthroughs

**Questions?** See [Troubleshooting Guide](TROUBLESHOOTING.md) or [open an issue](https://github.com/o2alexanderfedin/strategic-research-automation-template/issues).

---

**Total time invested**: ~5 minutes + coffee break
**Value delivered**: Strategic analysis that would take 2-3 weeks manually

Ready to 10x your strategic research!
