# Quick Start Guide - Strategic Research Automation Template

Transform strategic research from weeks to hours in **2 minutes**. Fully autonomous, zero permission prompts, hands-free execution.

**YOLO Mode by Default**: This template uses fully autonomous operation for professional research automation.

---

## ⚡ The Fastest Path

### New Research Project (One Command)

```bash
curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/quick-start.sh | \
  bash -s my-project --industry technology --focus comprehensive
```

That's it! Your research framework is ready with:
- ✅ Complete context structure (company, client, industry)
- ✅ 8 specialized AI research skills
- ✅ 13 workflow slash commands
- ✅ Git repository with flow initialized
- ✅ Quality standards and scoring rubric

### Existing Project (Three Commands)

```bash
cd your-consulting-project
curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/setup-existing.sh -o setup.sh
chmod +x setup.sh && ./setup.sh
```

Answer a few questions, and you're automated!

---

## 📋 Installation Methods

Choose the method that fits your workflow:

| Method | Best For | Time | Customization |
|--------|----------|------|---------------|
| **One-liner** | Quick prototypes, single opportunities | 2 min | Minimal |
| **GitHub Template** | New consulting engagements | 3 min | Standard |
| **Existing Project** | Retrofitting research automation | 5 min | Adaptive |
| **Cookiecutter** | Power users, research teams | 10 min | Full |

### Method 1: One-Liner

**Non-Interactive (fastest):**
```bash
curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/quick-start.sh | \
  bash -s my-project \
    --industry technology \
    --focus market_analysis \
    --company "Acme Consulting" \
    --client "Client Corp"
```

**Interactive:**
```bash
curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/quick-start.sh | \
  bash -s my-research-project
# Runs setup.sh interactively
```

**All Options:**
```bash
curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/quick-start.sh | \
  bash -s PROJECT_NAME \
    --industry INDUSTRY \              # technology, services, manufacturing, etc.
    --focus RESEARCH_FOCUS \           # market_analysis, technology_assessment, etc.
    --company "YOUR_COMPANY" \
    --client "CLIENT_NAME" \
    --desc "PROJECT DESCRIPTION"
```

### Method 2: GitHub Template

1. **Click "Use this template"** on GitHub
2. **Clone** your new repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/your-research-project.git
   cd your-research-project
   ```
3. **Run setup:**
   ```bash
   ./scripts/setup.sh
   ```
4. **Answer questions:**
   - Project name
   - Industry (technology/services/manufacturing/etc.)
   - Research focus (market analysis/tech assessment/etc.)
   - Company and client names
   - Output preferences (formats, detail level)

Done! Start researching with autonomous YOLO mode.

### Method 3: Existing Project

1. **Navigate to your project:**
   ```bash
   cd your-existing-consulting-project
   ```

2. **Download and run setup:**
   ```bash
   curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/setup-existing.sh -o setup.sh
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Script will:**
   - Auto-detect your industry if possible
   - Download template skills and commands
   - Create context structure intelligently
   - Merge with existing git history
   - Create commit with research automation

### Method 4: Cookiecutter (Power Users)

1. **Install cookiecutter:**
   ```bash
   pip install cookiecutter
   ```

2. **Generate project:**
   ```bash
   cookiecutter gh:o2alexanderfedin/strategic-research-automation-template
   ```

3. **Answer detailed prompts:**
   - Full project customization
   - Industry-specific templates
   - Quality thresholds and scoring
   - Output format preferences
   - Pre/post generation hooks run automatically

---

## 🎯 First Steps After Setup

### 1. Configure Context (5 minutes)

```bash
# Define your company's capabilities
nano context/company-profile.md
# Add: Core competencies, past projects, differentiators, constraints

# Define your client's needs
nano context/client-info.md
# Add: Industry domain, pain points, requirements, decision criteria

# Add industry background (optional but recommended)
nano context/industry-background.md
# Add: Regulations, standards, market dynamics, key players
```

**Tip**: Quality context = quality research. Spend time here.

### 2. Discover Opportunities (5 minutes)

Let AI autonomously identify strategic fit areas:

```bash
# Fully autonomous discovery (YOLO mode)
./scripts/setup/claude-eng -p "/discover-opportunities"
```

**What happens:**
- AI analyzes your context files
- Identifies 5-10 high-potential opportunity areas
- Auto-generates sprint definitions with research questions
- Creates initial sprint directory structure

**Expected output:**
```
✓ Analyzed company-profile.md (12 core capabilities identified)
✓ Analyzed client-info.md (8 pain points mapped)
✓ Analyzed industry-background.md (4 regulatory frameworks found)

Discovered 7 strategic opportunities:
  1. advanced system operation Control Verification (Score: 95/100 - STRONG FIT)
  2. Advanced Air Mobility Infrastructure (Score: 88/100 - STRONG FIT)
  3. Autonomous Systems Certification (Score: 82/100 - MODERATE FIT)
  ...

Created sprint definitions in sprints/
Run /execute-sprint 01 to begin research
```

### 3. Execute First Sprint (45 minutes)

```bash
# Fully autonomous sprint execution (YOLO mode)
./scripts/setup/claude-eng -p "/execute-sprint 01"
```

**What happens:**
- Runs 6 research tasks in parallel (~45 minutes total)
- Generates 25-38 granular research files
- Synthesizes 10-page strategic report
- Scores opportunity (0-100 scale)
- Provides go/no-go recommendation

**Expected output:**
```
Sprint 01: advanced system operation Control Verification
✓ Task 01 - Technical Analysis (32 files, 18,432 words)
  - Industry Standard ABC software certification requirements
  - Regulatory Body regulatory framework (Part 23, Part 27)
  - Formal verification methods (verification solvers, model checking)

✓ Task 02 - Market Assessment (27 files, 15,847 words)
  - TAM: $12.4B by 2030
  - SAM: $450M (technology software verification)
  - SOM: $45M-$85M (advanced system segment)

✓ Task 03 - Architecture Design (29 files, 16,923 words)
  - System architecture and component breakdown
  - Technology stack recommendations
  - POC implementation roadmap

✓ Task 04 - Compliance Strategy (25 files, 14,256 words)
  - Certification pathways (Industry Standard ABC levels)
  - Testing requirements and methodologies
  - Timeline and resource estimates

✓ Task 05 - Implementation Roadmap (28 files, 17,094 words)
  - 3-year phased roadmap
  - Partnership opportunities (OEMs, regulators)
  - Resource requirements and hiring plan

✓ Task 06 - Final Report (1 file, 6,847 words)
  - Executive summary (2 pages)
  - Strategic analysis (8 pages)
  - Opportunity score: 95/100 - STRONG GO
  - Recommendation: Prioritize for immediate development

All files saved to: temp/01-advanced system-operation-control-verification/
Report saved to: reports/01-advanced system-operation-control-verification-report.md
```

### 4. Review Results (10 minutes)

```bash
# Read the strategic report
cat reports/01-advanced system-operation-control-verification-report.md

# Or export to PDF/DOCX for stakeholders
./scripts/setup/claude-eng -p "/export-findings 01 --format pdf"
```

**Next**: Decide to pursue (STRONG GO) or move to next opportunity.

---

## 🧭 Daily Research Workflow

### Starting a New Engagement

```bash
# 1. Initialize project (YOLO mode)
./scripts/setup/claude-eng -p "/init-project 'Client Engagement' 'Industry' 'Company Name'"

# 2. Configure context
vim context/company-profile.md
vim context/client-info.md

# 3. Discover opportunities (fully autonomous)
./scripts/setup/claude-eng -p "/discover-opportunities"

# 4. Execute first sprint (fully autonomous)
./scripts/setup/claude-eng -p "/execute-sprint 01"
```

### Working Through Multiple Opportunities

```bash
# Execute all sprints autonomously (RECOMMENDED)
./scripts/run-autonomous-analysis.sh "Project" "Company" "context.pdf"

# Or execute manually with YOLO mode
./scripts/setup/claude-eng -p "/execute-sprint 01"  # Wait for completion
./scripts/setup/claude-eng -p "/execute-sprint 02"  # Wait for completion
./scripts/setup/claude-eng -p "/execute-sprint 03"  # Etc.

# Compare opportunities
./scripts/setup/claude-eng -p "/compare-sprints"  # Generates prioritization matrix
```

### YOLO Mode Details (Default Behavior)

For fully autonomous execution without any permission prompts:

```bash
# YOLO mode: Interactive
./scripts/setup/claude-eng
# Then use commands normally - no permission prompts

# YOLO mode: Execute sprint directly
./scripts/setup/claude-eng -p "/execute-sprint 01"

# YOLO mode: Complete automation
./scripts/setup/claude-eng -p "/execute-all"

# YOLO mode: Overnight batch processing
nohup ./scripts/setup/claude-eng -p "/execute-all" > research.log 2>&1 &
# Check progress: tail -f research.log
```

**When to use YOLO mode:**
- ✅ Overnight batch processing of multiple sprints
- ✅ CI/CD integration for automated research pipelines
- ✅ Large-scale opportunity screening (10+ opportunities)
- ✅ Time-sensitive research with tight deadlines

**When NOT to use YOLO mode:**
- ❌ First time using the framework (use interactive mode to learn)
- ❌ Exploratory research with unclear requirements
- ❌ Client data that requires human review checkpoints
- ❌ Untrusted or public environments

**Security note**: YOLO mode bypasses all permission checks. Only use in controlled environments with reviewed prompts.

### Delivering to Stakeholders

```bash
# Generate executive summary across all opportunities (YOLO mode)
./scripts/setup/claude-eng -p "/synthesize-portfolio"

# Export professional deliverables
./scripts/setup/claude-eng -p "/export-findings --all --format pdf"
./scripts/setup/claude-eng -p "/export-findings --all --format docx"

# Create release for client delivery
./scripts/setup/claude-eng -p "/finalize-release v1.0 'Strategic Opportunity Portfolio - Q4 2024'"
```

---

## 📚 Key Commands Reference

### Essential Commands

| Command | Purpose | Example (YOLO mode) |
|---------|---------|---------|
| `/init-project` | Initialize new research project | `./scripts/setup/claude-eng -p "/init-project 'Industry Regulation XYZ Analysis' 'technology' 'TechCo'"` |
| `/discover-opportunities` | Auto-discover strategic fit areas | `./scripts/setup/claude-eng -p "/discover-opportunities"` |
| `/create-sprint` | Manually define opportunity sprint | `./scripts/setup/claude-eng -p "/create-sprint 'advanced system Verification' 'operation control certification'"` |
| `/execute-sprint` | Run complete sprint (6 tasks) | `./scripts/setup/claude-eng -p "/execute-sprint 01"` |
| `/execute-task` | Run single task | `./scripts/setup/claude-eng -p "/execute-task 01 02"` |
| `/synthesize-report` | Generate final report | `./scripts/setup/claude-eng -p "/synthesize-report 01"` |
| `/score-opportunity` | Apply scoring rubric | `./scripts/setup/claude-eng -p "/score-opportunity 01"` |
| `/compare-sprints` | Prioritize opportunities | `./scripts/setup/claude-eng -p "/compare-sprints"` |
| `/export-findings` | Export to PDF/DOCX | `./scripts/setup/claude-eng -p "/export-findings 01 --format pdf'"` |

### Advanced Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `/validate-quality` | Check quality standards | `/validate-quality 01` |
| `/update-context` | Modify project context | `/update-context --add-capability "AI/ML"` |
| `/finalize-release` | Create git release | `/finalize-release v1.0 "Portfolio Complete"` |

### Command Locations

Commands are installed in `.claude/commands/`:
- **Project-specific** customizations here
- **Industry-specific** variations available in templates

Skills auto-activate based on context in `.claude/skills/`:
- 8 specialized research agents
- Autonomous parallel execution
- Evidence-based methodology

---

## 🎨 Industry-Specific Quick Starts

### technology (Industry Regulation XYZ/advanced system)

```bash
# Create project
curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/quick-start.sh | \
  bash -s mosaic-analysis --industry technology --focus comprehensive

cd mosaic-analysis

# Add industry context
cat > context/industry-background.md << 'EOF'
# Industry Regulation XYZ Regulation Background

## Overview
Modernization of Special Airworthiness Certification (Industry Regulation XYZ) is an Regulatory Body initiative
to update certification standards for light sport system, potentially including advanced system.

## Key Regulations
- Part 23 (Normal Category system)
- Part 27 (Normal Category Rotorcraft)
- Industry Regulation XYZ NPRM (Notice of Proposed Rulemaking)
- Industry Standard ABC (Software Certification)

## Market Context
- advanced system market projected at $12.4B by 2030
- 50+ advanced system manufacturers globally
- Certification pathways still emerging
EOF

# Discover opportunities (fully autonomous)
./scripts/setup/claude-eng -p "/discover-opportunities"
```

### Healthcare (Digital Health/EHR)

```bash
# Create project
curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/quick-start.sh | \
  bash -s ehr-integration --industry healthcare --focus technology_assessment

cd ehr-integration

# Add healthcare context
cat > context/industry-background.md << 'EOF'
# Digital Health Landscape

## Regulatory Framework
- HIPAA compliance requirements
- HL7 FHIR interoperability standards
- FDA software as medical device (SaMD) guidance
- ONC certification criteria

## Market Dynamics
- EHR market size: $38.8B (2024)
- Interoperability challenges
- Patient data access requirements (21st Century Cures Act)
EOF

# Discover opportunities (fully autonomous)
./scripts/setup/claude-eng -p "/discover-opportunities"
```

### FinTech (RegTech/Compliance)

```bash
# Create project
curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/quick-start.sh | \
  bash -s regtech-automation --industry fintech --focus regulatory_compliance

cd regtech-automation

# Add fintech context
cat > context/industry-background.md << 'EOF'
# RegTech Compliance Landscape

## Regulatory Requirements
- KYC/AML compliance (Bank Secrecy Act, PATRIOT Act)
- Payment Card Industry Data Security Standard (PCI-DSS)
- General Data Protection Regulation (GDPR)
- Financial Industry Regulatory Authority (FINRA) rules

## Market Opportunity
- RegTech market: $18.5B (2024), CAGR 23.5%
- Compliance cost pressure driving automation
- AI/ML adoption accelerating
EOF

# Discover opportunities (fully autonomous)
./scripts/setup/claude-eng -p "/discover-opportunities"
```

---

## 🔧 Troubleshooting

### Setup Issues

**Problem**: "Permission denied" when running setup.sh
```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

**Problem**: Placeholders not replaced in context files
```bash
# Check that files contain {{VARIABLE}} format
grep -r "{{PROJECT_NAME}}" context/

# Re-run setup if needed
./scripts/setup.sh
```

**Problem**: Git not initialized
```bash
# Initialize git manually
git init
git add .
git commit -m "Initial commit: Strategic research automation setup"
```

### Research Execution Issues

**Problem**: Skills not activating
```bash
# Verify skills are installed
ls -la .claude/skills/

# Check Claude Code version
claude --version  # Should be v2.0+

# Manually invoke skill
./scripts/setup/claude-eng -p "@technical-researcher Analyze Industry Standard ABC requirements"
```

**Problem**: Tasks running sequentially instead of parallel
```bash
# Check config
cat config/project-config.yml | grep parallel

# Verify CPU cores available
sysctl -n hw.ncpu  # macOS
nproc              # Linux

# Adjust max parallel tasks in config
vim config/project-config.yml
# Set: max_parallel_tasks: 6
```

**Problem**: Research files not generating
```bash
# Check quality standards
cat config/quality-standards.yml

# Run with verbose logging
./scripts/setup/claude-eng -p "/execute-task 01 01"

# Validate sprint configuration
cat sprints/sprint-01.yml
```

### Quality Issues

**Problem**: Reports lack citations
```bash
# Check evidence requirements
cat config/quality-standards.yml

# Update citation style
vim config/project-config.yml
# Set: citation_style: apa

# Re-run with strict quality
/validate-quality 01 --strict
```

**Problem**: Files too short or generic
```bash
# Increase minimum file count
vim config/project-config.yml
# Set: min_files_per_sprint: 30

# Increase target word count
# Set: target_report_words: 8000

# Re-execute sprint
/execute-sprint 01 --regenerate
```

---

## 📖 Learning Path

### Day 1: Setup and First Sprint (2 hours)

1. ✅ Install template (5 minutes)
2. ✅ Configure context files (15 minutes)
3. ✅ Discover opportunities (5 minutes)
4. ✅ Execute first sprint (45 minutes)
5. ✅ Review strategic report (30 minutes)
6. ✅ Export deliverables (5 minutes)

**Goal**: Understand end-to-end workflow, generate first opportunity analysis.

### Day 2: Multi-Opportunity Portfolio (4 hours)

1. ✅ Execute 3-5 sprints (3 hours)
2. ✅ Compare and prioritize opportunities (30 minutes)
3. ✅ Synthesize portfolio report (30 minutes)
4. ✅ Export professional deliverables (15 minutes)

**Goal**: Build complete portfolio, understand prioritization methodology.

### Week 1: Customization and Optimization (8 hours)

1. ✅ Customize scoring rubric for your domain (1 hour)
2. ✅ Add industry-specific patterns to skills (2 hours)
3. ✅ Create custom research templates (2 hours)
4. ✅ Optimize parallel execution settings (1 hour)
5. ✅ Build reusable context templates (2 hours)

**Goal**: Tailor framework to your specific consulting practice.

### Week 2: Production Deployment (ongoing)

1. ✅ Use for real client engagement
2. ✅ Gather stakeholder feedback
3. ✅ Iterate on quality standards
4. ✅ Build institutional knowledge base
5. ✅ Train team members on workflow

**Goal**: Integrate into daily consulting practice, achieve ROI.

---

## 💡 Pro Tips

### Context Quality

```bash
# High-quality context files drive high-quality research
# Spend 20% of time on context, save 80% later

# Company profile: Be specific
✗ "We do software consulting"
✓ "We specialize in safety-critical software certification (Industry Standard ABC, ISO 26262)
   with 15 years experience in technology and automotive sectors.
   Team of 8 engineers (3 DERs, 2 PhDs). Past clients: Boeing, Airbus, Tesla."

# Client info: Capture decision criteria
✗ "Client wants to enter advanced system market"
✓ "Client (Series B advanced system startup, $50M funding) needs certification roadmap
   to satisfy investors. Timeline: 18 months to first operation.
   Decision criteria: Cost <$2M, proven methodology, Regulatory Body credibility."
```

### Parallel Execution

```bash
# Maximize throughput with parallel sprints
# If you have 8 CPU cores, run 2 sprints simultaneously

# Terminal 1
./scripts/setup/claude-eng -p "/execute-sprint 01"

# Terminal 2 (while sprint 01 runs)
./scripts/setup/claude-eng -p "/execute-sprint 02"

# Terminal 3 (while 01 and 02 run)
./scripts/setup/claude-eng -p "/execute-sprint 03"

# Monitor progress
watch -n 5 'find temp/ -type f | wc -l'  # Count research files
```

### Quality Assurance

```bash
# Always validate before delivering to clients
/validate-quality 01 --strict

# Check for common issues:
# - Missing citations
# - Placeholder text
# - Inconsistent findings
# - Insufficient evidence

# Export validation report
/validate-quality --all --export report.html
```

### Reusability

```bash
# Build reusable templates for your domain
# Save successful configurations

# After successful sprint:
mkdir -p templates/technology-certification/
cp sprints/01-*.yml templates/technology-certification/sprint-template.yml
cp config/scoring-rubric.yml templates/technology-certification/

# Reuse for next engagement:
cp templates/technology-certification/sprint-template.yml sprints/new-sprint.yml
vim sprints/new-sprint.yml  # Customize for new opportunity
```

---

## 🚀 Next Steps

### Immediate Actions

1. **Run First Sprint** (45 minutes)
   - Execute complete opportunity analysis
   - See framework in action
   - Understand output structure

2. **Customize for Your Domain** (2 hours)
   - Update scoring rubric
   - Add industry-specific context
   - Tune quality standards

3. **Build Portfolio** (1 day)
   - Execute 5-10 opportunities
   - Compare and prioritize
   - Export deliverables

### For Consulting Firms

1. **Standardize Methodology**
   - Create firm-wide templates
   - Document best practices
   - Train all consultants

2. **Build Knowledge Base**
   - Accumulate context files
   - Share successful patterns
   - Create industry playbooks

3. **Measure ROI**
   - Track time savings
   - Measure client satisfaction
   - Calculate cost reduction

### For Product Teams

1. **Opportunity Pipeline**
   - Continuously discover opportunities
   - Maintain scored backlog
   - Align with product roadmap

2. **Evidence-Based Decisions**
   - Support feature prioritization
   - Validate market assumptions
   - Reduce uncertainty

3. **Stakeholder Communication**
   - Professional deliverables
   - Data-driven recommendations
   - Audit trail for decisions

---

## 📞 Getting Help

### Resources

- **Documentation**: [Full Guide](README.md)
- **Detailed Setup**: [TEMPLATE_STRATEGY.md](TEMPLATE_STRATEGY.md)
- **Architecture**: [ARCHITECTURE.md](docs/ARCHITECTURE.md)
- **Examples**: [examples/](examples/)
- **Troubleshooting**: [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)

### Common Questions

**Q: Can I use this for my existing consulting practice?**
A: Yes! Use `scripts/setup-existing.sh`. It integrates seamlessly with existing projects.

**Q: What if my industry isn't listed?**
A: The framework is industry-agnostic. Industry templates are optional optimizations.
Start with "other" and customize as you go.

**Q: How much does it cost to run?**
A: Approximately $10-$20 in Claude API costs per sprint (6 tasks, 25-38 files).
Far cheaper than manual consulting labor.

**Q: Can I customize the research questions?**
A: Absolutely! Edit `templates/tasks/*.md` to modify research questions,
evidence requirements, and output structure.

**Q: How do I get template updates?**
A: Option 1: Git remote sync (manual).
Option 2: Re-run setup script periodically.
Option 3: Cherry-pick specific improvements from template repo.

**Q: Is this only for Claude Code?**
A: Skills and commands are Claude Code-specific, but methodology works with any AI assistant.
Research templates, quality standards, and scoring rubrics are universal.

**Q: Can multiple consultants work on the same project?**
A: Yes! The framework uses git for version control. Standard git collaboration applies:
- Create feature branches for different opportunities
- Merge research files
- Review and approve strategic reports

**Q: What about data privacy and client confidentiality?**
A: All research runs locally or via your API keys. No data shared with third parties
(except Claude API for AI processing). Add `.env` to `.gitignore`.
Consider running locally with Claude Desktop for maximum privacy.

---

## ✨ You're Ready!

You now have everything you need to transform strategic research.

**Your next command:**

```bash
# Initialize and configure
./scripts/setup/claude-eng -p "/init-project 'My Engagement' 'My Industry' 'My Company'"
# Then edit context files (vim context/*.md)

# Run fully autonomous research
./scripts/setup/claude-eng -p "/discover-opportunities"
./scripts/setup/claude-eng -p "/execute-sprint 01"
```

**What to expect:**
- First sprint: 45 minutes, 25-38 files, 10-page report
- Portfolio of 5-10 opportunities: 4-8 hours, complete prioritization
- Stakeholder deliverables: Professional PDF/DOCX exports

Happy researching! Transform weeks into hours. 🚀

---

**Version**: 2.0.0
**Last Updated**: 2025-11-14
**Template**: [github.com/o2alexanderfedin/strategic-research-automation-template](https://github.com/o2alexanderfedin/strategic-research-automation-template)
