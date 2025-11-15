# Strategic Research Automation Template

**Transform strategic opportunity analysis from weeks to hours**

Automate comprehensive research using AI-powered skills, parallel execution, and proven map-reduce methodology. Generate publication-quality strategic reports with evidence-based recommendations.

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](CHANGELOG.md)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-v2.0+-purple.svg)](https://docs.claude.com)

[Quick Start](#quick-start) •  [Documentation](#documentation) • [Examples](#examples) • [Contributing](#contributing)

---

## Overview

This framework automates strategic opportunity analysis through eight specialized AI skills and thirteen workflow commands. Born from a real consulting engagement (Hupyy × MOSAIC Aviation Analysis, 2024-2025), it reduces research time by 95%+ while maintaining publication quality and evidence-based rigor.

Traditional strategic research is slow, expensive, and inconsistent. Consultants spend 2-3 weeks per opportunity, costing $15K-$30K in labor. Quality varies by analyst expertise. Deadlines compress. Clients wait.

This framework changes everything: 45 minutes per opportunity, $10-$20 in API costs, consistent methodology, parallel execution, and comprehensive audit trails. What took weeks now takes an afternoon.

**Who this is for**:
- **Consulting firms** conducting strategic research and proposal development for clients
- **Product teams** evaluating market entry opportunities and feature prioritization decisions
- **Investment firms** performing due diligence, opportunity assessment, and competitive analysis
- **Business development** teams analyzing strategic partnerships, M&A targets, and market expansion
- **Innovation teams** researching emerging technologies, regulatory changes, and market trends

**Key benefits**:
- **95%+ time reduction** - strategic research from weeks to hours
- **Consistent methodology** - same rigorous approach across all opportunities
- **Evidence-based analysis** - every claim supported by credible citations
- **Parallel execution** - leverage multiple CPU cores for maximum research speed
- **Publication-quality deliverables** - professional reports in PDF, DOCX, and Markdown
- **Audit trail** - complete git history and research file provenance

---

## Features

### Eight Specialized Skills

AI-powered research agents (skills) that automatically activate based on research context:

| Skill | Purpose | Activates For |
|-------|---------|---------------|
| **Sprint Orchestrator** | Manages multi-sprint execution | Multi-sprint workflows |
| **Opportunity Discovery** | Auto-identifies strategic opportunities | Context analysis |
| **Technical Researcher** | Deep technical and regulatory analysis | Task 01 - Technical landscape |
| **Market Analyst** | TAM/SAM/SOM, competitive intelligence | Task 02 - Market assessment |
| **Solution Architect** | System design and POC specifications | Task 03 - Architecture design |
| **Compliance Analyst** | Certification pathways and testing | Task 04 - Compliance strategy |
| **Roadmap Planner** | Implementation strategy and partnerships | Task 05 - Roadmap planning |
| **Report Synthesizer** | Executive-ready strategic reports | Task 06 - Final synthesis |

### Thirteen Slash Commands

User-invoked commands for complete workflow control:

```bash
/init-project              # Initialize new research project
/discover-opportunities    # Auto-discover strategic fit areas
/create-sprint            # Define new opportunity sprint
/execute-task             # Run single research task
/execute-sprint           # Run complete sprint (parallel)
/execute-all              # Run all sprints automatically
/synthesize-report        # Generate strategic report
/score-opportunity        # Apply scoring rubric
/compare-sprints          # Prioritize across opportunities
/export-findings          # Export to PDF/DOCX/HTML
/validate-quality         # Check quality standards
/update-context           # Modify project context
/finalize-release         # Create git release
```

### Complete Automation

Fully autonomous mode: from context files to complete portfolio in one command.

```bash
# Autonomous discovery + execution
./scripts/run-autonomous-analysis.sh "Project Name" "Company" "Context.pdf"

# Or manual sprint definitions
./scripts/run-complete-analysis.sh "Project" "Industry" "Company" \
  "Sprint1|Description" "Sprint2|Description"
```

**What you get**:
- 25-38 granular research files per sprint
- 10-page strategic reports (5,000-7,500 words)
- Opportunity scoring and prioritization
- Multi-format exports (MD, PDF, DOCX)
- Complete audit trail with citations
- Git-tracked version history

---

## Quick Start

### 1. Prerequisites

Ensure you have:
- [Claude Code CLI](https://docs.claude.com) installed
- Git configured
- Active Claude API access

**Verify installation**:
```bash
claude --version    # Should show v2.0 or higher
git --version       # Any recent version
```

### 2. Create Project from Template

```bash
# Use this GitHub template
# Click "Use this template" button on GitHub
# Or clone directly:
git clone https://github.com/o2alexanderfedin/strategic-research-automation-template my-project
cd my-project
```

### 3. Configure Context

Edit context files with your information:

```bash
# Company capabilities and expertise
vim context/company-profile.md

# Client domain and pain points
vim context/client-info.md

# Industry-specific background (optional)
vim context/industry-background.md
```

**Tip**: High-quality context files = high-quality research outputs

### 4. Discover Opportunities

Let AI identify strategic fit areas:

```bash
claude -p "/discover-opportunities"
# Reviews context, identifies 5-10 opportunities
# Auto-generates sprint definitions
```

### 5. Execute First Sprint

```bash
claude -p "/execute-sprint 01"
# Runs all 6 tasks in parallel (~45 minutes)
# Generates 25-38 research files + strategic report
```

**Expected output**:
```
✓ Sprint 01 initialized: eVTOL Flight Control Verification
✓ Task 01 completed: 32 files (DO-178C analysis, FAA regulations, SMT verification)
✓ Task 02 completed: 27 files (TAM $12B, SAM $450M, SOM $45M-$85M)
✓ Task 03 completed: 29 files (system architecture, verification framework)
✓ Task 04 completed: 25 files (certification pathways, testing strategy)
✓ Task 05 completed: 28 files (3-year roadmap, partnership strategy)
✓ Task 06 completed: Strategic report (6,847 words, score 95/100 - STRONG GO)
```

**Next**: Review `reports/01-sprint-name-report.md` for go/no-go recommendation.

---

## Examples

### Real Project Results: MOSAIC Aviation Analysis

**Project**: Hupyy evaluating MOSAIC eVTOL opportunities for strategic positioning
**Scope**: 10 strategic opportunities analyzed
**Output**: 349 files (20MB), 10 strategic reports, comparative analysis
**Time**: 15 hours total vs. 6-8 weeks manual
**Outcome**: Identified top 3 priorities with execution roadmaps

**Results comparison**:

| Metric | Traditional | Automated | Improvement |
|--------|-------------|-----------|-------------|
| Time per opportunity | 2-3 weeks | 45 minutes | 95%+ faster |
| Cost per opportunity | $15K-$30K | $10-$20 | 99%+ cheaper |
| Files generated | Variable | 25-38 | Consistent |
| Report quality | Variable | Standardized | Reliable |

### Example Projects

Complete working examples with full source code:

- **[Aviation MOSAIC](examples/aviation-mosaic/)** - eVTOL opportunity analysis (reference implementation)
- **[Healthcare EHR](examples/healthcare-digital/)** - Digital health integration opportunities
- **[FinTech RegTech](examples/fintech-saas/)** - Compliance automation opportunities

Each example includes:
- Complete context files
- Sprint configurations
- Sample research outputs
- Final strategic reports

---

## How It Works

The framework uses a **map-reduce approach**:

### MAP Phase (Parallel Research)

```
Context → [Task 01: Technical] → Research Files (25-35)
       → [Task 02: Market]    → Research Files (20-30)
       → [Task 03: Architecture] → Research Files (25-35)
       → [Task 04: Compliance] → Research Files (20-30)
       → [Task 05: Roadmap]   → Research Files (25-35)
```

Each task runs in parallel, generating granular research files.

### REDUCE Phase (Synthesis)

```
All Research Files → [Task 06: Synthesizer] → Strategic Report (10 pages)
                                            → Opportunity Score (0-100)
                                            → Go/No-Go Recommendation
```

**Directory structure**:
```
project/
├── .claude/           # 8 skills + 13 commands
├── config/            # Project configuration
├── context/           # Company + client profiles
├── sprints/           # Opportunity definitions
├── temp/              # Research artifacts
└── reports/           # Strategic reports
```

See [Architecture Documentation](docs/ARCHITECTURE.md) for deep dive.

---

## Industry Customization

### Supported Industries

Pre-configured examples available:
- **Aviation**: MOSAIC regulation analysis (complete reference)
- **Healthcare**: EHR integration and digital health
- **FinTech**: RegTech compliance solutions
- **SaaS**: Product-market fit analysis
- **Manufacturing**: Supply chain optimization
- **Energy**: Renewable technology assessment

### Customization Path

Adapt for your industry in 4 steps:

1. Update terminology in `config/glossary.yml`
2. Customize skill activation triggers in `.claude/skills/*/SKILL.md`
3. Modify task research questions in `templates/tasks/*.md`
4. Adjust scoring rubric in `config/scoring-rubric.yml`

See [Customization Guide](docs/CUSTOMIZATION.md) for step-by-step instructions.

---

## Documentation

### Getting Started
- [Installation Guide](docs/SETUP.md) - Prerequisites and installation
- [Quick Start Tutorial](docs/QUICK-START.md) - 5-minute walkthrough
- [Your First Sprint](docs/examples/first-sprint.md) - Detailed tutorial

### Usage
- [Complete Workflow](docs/USAGE.md) - From init to report
- [Command Reference](docs/COMMANDS-REFERENCE.md) - All 13 commands
- [Skill Reference](docs/SKILLS-REFERENCE.md) - All 8 skills
- [Configuration Reference](docs/CONFIGURATION-REFERENCE.md) - All config schemas

### Advanced
- [Customization Guide](docs/CUSTOMIZATION.md) - Adapt to your industry
- [Architecture Deep-Dive](docs/ARCHITECTURE.md) - System design
- [Automation Scripts](docs/reference/scripts.md) - Bash automation

### Support
- [Troubleshooting](docs/TROUBLESHOOTING.md) - Common issues and solutions
- [FAQ](docs/FAQ.md) - Frequently asked questions
- [Contributing](CONTRIBUTING.md) - Join development

---

## Contributing

We welcome contributions!

**Ways to contribute**:
- Report bugs via [GitHub Issues](https://github.com/o2alexanderfedin/strategic-research-automation-template/issues)
- Suggest features via [Feature Requests](https://github.com/o2alexanderfedin/strategic-research-automation-template/issues/new?template=feature_request.md)
- Improve documentation (see [CONTRIBUTING.md](CONTRIBUTING.md#documentation))
- Submit pull requests (see [CONTRIBUTING.md](CONTRIBUTING.md#code))
- Share industry examples (see [examples/README.md](examples/README.md))

**New contributors**: Start with [Good First Issues](https://github.com/o2alexanderfedin/strategic-research-automation-template/issues?q=label%3A%22good+first+issue%22)

See [CONTRIBUTING.md](CONTRIBUTING.md) for complete guidelines.

---

## License

MIT License - see [LICENSE](LICENSE) for details.

Free for personal, commercial, and academic use.

---

## Credits

**Created by**: Alexander Fedin ([o2alexanderfedin](https://github.com/o2alexanderfedin))

Methodology proven in real consulting engagement: Hupyy × MOSAIC Aviation Analysis (2024-2025).

Built with:
- [Claude Code](https://claude.ai) by Anthropic
- Map-reduce research paradigm
- Git flow for version control

---

## Get Started

Ready to 10x your strategic research?

```bash
git clone https://github.com/o2alexanderfedin/strategic-research-automation-template
cd strategic-research-automation-template
claude -p "/init-project 'My Project' 'Industry' 'Company'"
```

Questions? [Open an issue](https://github.com/o2alexanderfedin/strategic-research-automation-template/issues/new) or read the [docs](docs/).

---

**Note**: This framework requires Claude Code v2.0+ and an active Anthropic API key.
