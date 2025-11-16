# Strategic Research Automation Template

[![GitHub Template](https://img.shields.io/badge/template-Use%20this%20template-brightgreen)](https://github.com/o2alexanderfedin/strategic-research-automation-template/generate)
[![Version](https://img.shields.io/badge/version-3.5.3-blue.svg)](CHANGELOG.md)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Setup Time](https://img.shields.io/badge/setup-5%20minutes-green)]()
[![Quick Start](https://img.shields.io/badge/quick%20start-2%20commands-brightgreen)](#-start-here-for-first-time-users)

> **Turn weeks of research into hours**

AI does the research work for you. You answer a few questions, then it automatically finds opportunities, researches them deeply, and writes professional reports with recommendations.

---

## 🚀 START HERE (For First-Time Users)

**Get your first strategic research report in 2 commands:**

```bash
# 1. Clone this repository
git clone https://github.com/o2alexanderfedin/strategic-research-automation-template.git
cd strategic-research-automation-template

# 2. Run the full automation script
./scripts/run-full.sh

# Answer a few quick questions, then go get coffee ☕
```

**What happens:**
1. Script asks you quick questions about your company and client
2. Discovers strategic opportunities automatically
3. Executes ALL research sprints completely hands-free (no more prompts!)
4. Generates professional reports with scoring and PDFs

**Requirements**: Claude subscription (desktop app or API) - that's it!

**Cost**: ~$50-$200 in API usage (one-time for this research)
**Time**: 2-6 hours completely unattended after initial questions
**Output**: 3-10 strategic reports with scoring, PDFs, and 25+ research files each

[Advanced Usage](#documentation) • [Customization](#customization) • [Examples](#examples)

---

## Overview

**The Problem:**
Research takes forever. Consultants spend 2-3 weeks per project, costing $15K-$30K in time. Quality varies. Deadlines get missed.

**The Solution:**
This tool does the research automatically. Run one command, answer a few questions, and AI handles everything:
- Finds strategic opportunities for you
- Researches each one thoroughly (regulations, market size, competitors, technical requirements)
- Writes professional reports with recommendations
- Scores and prioritizes everything

**The Results:**
What took 2-3 weeks now takes 2-6 hours, costs $50-$200 in AI usage, and runs completely unattended while you do other work.

**Who this is for**:
- **Consulting firms** conducting strategic research and proposal development for clients
- **Product teams** evaluating market entry opportunities and feature prioritization decisions
- **Investment firms** performing due diligence, opportunity assessment, and competitive analysis
- **Business development** teams analyzing strategic partnerships, M&A targets, and market expansion
- **Innovation teams** researching emerging technologies, regulatory changes, and market trends

**Key benefits**:
- **Save weeks of time** - research that took 2-3 weeks now takes 2-6 hours
- **Always thorough** - same rigorous research process every time
- **Properly cited** - every claim backed by real sources
- **Runs fast** - researches multiple opportunities at the same time
- **Professional output** - polished reports ready to share with clients (PDF, Word, or Markdown)
- **Trackable** - complete history of what was researched and when

---

## Features

### What The AI Does For You

The AI has 8 specialized research roles that work together automatically:

| Role | What It Does |
|------|--------------|
| **Opportunity Discovery** | Finds strategic opportunities based on your company and client |
| **Technical Researcher** | Researches regulations, technical standards, and requirements |
| **Market Analyst** | Analyzes market size, competitors, and customer needs |
| **Solution Architect** | Designs technical solutions and architectures |
| **Compliance Analyst** | Figures out certification and testing requirements |
| **Roadmap Planner** | Creates implementation plans and timelines |
| **Report Synthesizer** | Writes executive summaries and final reports |
| **Sprint Orchestrator** | Coordinates all the research work |

### Advanced Commands (Optional)

For power users who want more control:

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

#### YOLO Mode (Advanced)

For fully autonomous operation without permission prompts, use the `claude-eng` wrapper:

```bash
# Interactive YOLO mode
./scripts/setup/claude-eng

# Non-interactive with prompt
./scripts/setup/claude-eng -p "/execute-sprint 01"

# Complete automation with YOLO mode
./scripts/setup/claude-eng -p "/execute-all"
```

**YOLO mode is the default** for this template - providing:
- **Zero permission prompts** - fully autonomous operation from start to finish
- **All tools enabled** - unrestricted research capabilities
- **Custom system prompts** - project-specific automation from `.claude-system-prompt.md`
- **Perfect for**: Overnight batch processing, CI/CD integration, large-scale research pipelines

**Why YOLO-only?** This template is designed for professional research automation. Manual permission prompts interrupt workflows and prevent true automation. YOLO mode delivers the promise: **weeks to hours, completely hands-free**.

**Security note**: YOLO mode has unrestricted access to your system. Only use in controlled, trusted research environments.

**What you get**:
- 25-38 granular research files per sprint
- 10-page strategic reports (5,000-7,500 words)
- Opportunity scoring and prioritization
- Multi-format exports (MD, PDF, DOCX)
- Complete audit trail with citations
- Git-tracked version history

---

## Quick Start

Choose your installation method:

### Method 1: GitHub Template (Recommended)

**Perfect for**: New research projects (2 minutes)

1. Click **"Use this template"** button above
2. Clone your new repository
3. Run setup:
   ```bash
   ./scripts/setup-template.sh
   ```
4. Answer 5-6 questions about your project
5. Start researching!

**Ready to research in 2 minutes** ⚡

> **For repository owners**: If the "Use this template" button is not visible, see [GITHUB_TEMPLATE_SETUP.md](GITHUB_TEMPLATE_SETUP.md) for quick CLI setup to enable template repository.

### Method 2: Existing Project

**Perfect for**: Adding research automation to existing consulting/research projects

```bash
cd your-consulting-project
curl -sSL https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main/scripts/setup-existing.sh -o setup.sh
chmod +x setup.sh && ./setup.sh
```

Your existing project + strategic research automation!

### Method 3: Cookiecutter (Power Users)

**Perfect for**: Full customization, teams, multiple projects

```bash
pip install cookiecutter
cookiecutter gh:o2alexanderfedin/strategic-research-automation-template
```

**Need help?** See [QUICK_START.md](QUICK_START.md) for detailed setup guides.

---

### First Research Sprint (After Setup)

1. **Discover Opportunities** (5 minutes):
   ```bash
   ./scripts/setup/claude-eng -p "/discover-opportunities"
   # AI autonomously identifies 5-10 strategic fit areas
   ```

2. **Execute Sprint** (45 minutes):
   ```bash
   ./scripts/setup/claude-eng -p "/execute-sprint 01"
   # Fully autonomous: Generates 25+ research files + 10-page report
   ```

3. **Export Deliverable** (2 minutes):
   ```bash
   ./scripts/setup/claude-eng -p "/export-findings 01 pdf"
   # Professional PDF ready for stakeholders
   ```

**Total time**: ~1 hour from setup to deliverable 🚀

**Expected output**:
```
✓ Sprint initialized: Core System Verification Platform
✓ Task 01: 32 research files (regulatory analysis, compliance standards)
✓ Task 02: 27 files (TAM $12B, SAM $450M, SOM $45M-$85M)
✓ Task 03: 29 files (system architecture, implementation framework)
✓ Task 04: 25 files (compliance pathways, testing strategy)
✓ Task 05: 28 files (3-year roadmap, partnership strategy)
✓ Task 06: Strategic report (6,847 words, score 95/100 - STRONG GO)
✓ PDF exported: reports/01-core-system-verification.pdf
```

---

## Examples

### Real Project Results: Technology Sector Compliance Analysis

**Project**: Enterprise organization evaluating regulatory compliance opportunities for strategic positioning
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

- **[Technology Sector](docs/EXAMPLE-INDUSTRY-A.md)** - Enterprise software compliance analysis (reference implementation)
- **[Service Sector](docs/EXAMPLE-CROSS-INDUSTRY-ADAPTATION.md)** - Cross-industry adaptation guide
- **[Multi-Industry](docs/)** - Additional examples across various verticals

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

Framework is industry-agnostic and can be adapted to any vertical:
- **Technology**: Enterprise software, SaaS platforms, system integration
- **Professional Services**: Consulting, managed services, business process outsourcing
- **Manufacturing**: Industrial systems, supply chain, quality management
- **Financial Services**: Compliance solutions, risk management, fintech platforms
- **Healthcare**: Digital health, data integration, quality systems
- **Energy**: Renewable systems, resource management, compliance frameworks

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

Methodology proven in real consulting engagements across multiple industry verticals (2024-2025).

Built with:
- [AI Hive®](https://o2.services) by O2.services
- Map-reduce research paradigm
- Git flow for version control

---

## Get Started

Ready to 10x your strategic research with fully autonomous automation?

```bash
git clone https://github.com/o2alexanderfedin/strategic-research-automation-template
cd strategic-research-automation-template
./scripts/setup/claude-eng -p "/init-project 'My Project' 'Industry' 'Company'"
```

**Then run completely hands-free**:
```bash
# Discover + execute all opportunities autonomously
./scripts/run-autonomous-analysis.sh "My Project" "My Company" "context.pdf"

# Returns in 2-4 hours with complete strategic portfolio
```

Questions? [Open an issue](https://github.com/o2alexanderfedin/strategic-research-automation-template/issues/new) or read the [docs](docs/).

---

**Authentication**: This framework requires Claude Code v2.0+ to be authenticated. You have two options:
- **Claude Code CLI** (Recommended): Run `claude auth` - uses your existing Claude subscription at no additional API cost
- **Anthropic API Key**: Set `ANTHROPIC_API_KEY` in `.env` - pay-per-use pricing

Most users already have Claude Code authenticated and don't need an API key.
