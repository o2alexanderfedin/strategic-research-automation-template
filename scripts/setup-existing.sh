#!/usr/bin/env bash
# Strategic Research Automation - Setup for Existing Projects
# This script adds strategic research automation to an existing consulting or research project

set -e  # Exit on error

# Colors for output
# shellcheck disable=SC2034
RED='\033[0;31m'
# shellcheck disable=SC2034
GREEN='\033[0;32m'
# shellcheck disable=SC2034
YELLOW='\033[1;33m'
# shellcheck disable=SC2034
BLUE='\033[0;34m'
# shellcheck disable=SC2034
CYAN='\033[0;36m'
# shellcheck disable=SC2034
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to escape special characters for sed replacement
# Escapes: & (means "matched text"), / (alternative delimiter), and \ (escape char)
escape_for_sed() {
    echo "$1" | sed 's/[&/\]/\\&/g'
}

echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Strategic Research Automation - Existing Project    ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

# Detect project directory
PROJECT_DIR=$(pwd)
echo -e "${BLUE}Project directory: $PROJECT_DIR${NC}"

# Verify this is an existing project
if [ ! -d ".git" ]; then
    echo -e "${RED}Error: This doesn't appear to be a git repository${NC}"
    echo -e "${YELLOW}Please run this script from your project root, or initialize git first:${NC}"
    echo "  git init"
    exit 1
fi

# Check if already has research automation
if [ -d ".claude/skills" ] && [ -d ".claude/commands" ]; then
    echo -e "${YELLOW}Warning: Research automation structure already exists${NC}"
    read -p "Do you want to overwrite it? (y/N): " OVERWRITE
    if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
        echo -e "${RED}Aborted.${NC}"
        exit 1
    fi
    echo -e "${YELLOW}Backing up existing .claude to .claude.backup${NC}"
    mv .claude .claude.backup
fi

if [ -d "context" ]; then
    echo -e "${YELLOW}Warning: context/ directory already exists${NC}"
    read -p "Do you want to merge context files? (Y/n): " MERGE_CONTEXT
    if [[ "$MERGE_CONTEXT" =~ ^[Nn]$ ]]; then
        echo -e "${YELLOW}Backing up existing context to context.backup${NC}"
        mv context context.backup
    fi
fi

# Detect project characteristics
echo ""
echo -e "${BLUE}Detecting project characteristics...${NC}"

DETECTED_INDUSTRY=""
# shellcheck disable=SC2034
DETECTED_LANG=""

# Try to detect industry from existing files
if grep -qi "technology\|system\|advanced system\|Regulatory Body\|Industry Standard ABC" README.md 2>/dev/null || \
   grep -qi "technology\|system" *.md 2>/dev/null; then
    DETECTED_INDUSTRY="technology"
    echo -e "${GREEN}Detected: technology industry${NC}"
elif grep -qi "healthcare\|medical\|EHR\|HIPAA\|FHIR" README.md 2>/dev/null || \
     grep -qi "healthcare\|medical" *.md 2>/dev/null; then
    DETECTED_INDUSTRY="healthcare"
    echo -e "${GREEN}Detected: Healthcare industry${NC}"
elif grep -qi "fintech\|financial\|RegTech\|compliance\|KYC" README.md 2>/dev/null || \
     grep -qi "fintech\|financial" *.md 2>/dev/null; then
    DETECTED_INDUSTRY="fintech"
    echo -e "${GREEN}Detected: FinTech industry${NC}"
elif grep -qi "SaaS\|software.*service\|enterprise.*software" README.md 2>/dev/null; then
    DETECTED_INDUSTRY="saas"
    echo -e "${GREEN}Detected: SaaS industry${NC}"
else
    echo -e "${YELLOW}Could not auto-detect industry${NC}"
fi

# Interactive prompts
echo ""
echo -e "${BLUE}Project Configuration${NC}"
read -p "Project name (default: $(basename "$PROJECT_DIR")): " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    PROJECT_NAME=$(basename "$PROJECT_DIR")
    echo -e "${YELLOW}Using: $PROJECT_NAME${NC}"
fi

read -p "Company name (your consulting firm): " COMPANY_NAME
while [ -z "$COMPANY_NAME" ]; do
    echo -e "${RED}Company name cannot be empty${NC}"
    read -p "Company name (your consulting firm): " COMPANY_NAME
done

read -p "Client name (or press Enter for 'Internal'): " CLIENT_NAME
if [ -z "$CLIENT_NAME" ]; then
    CLIENT_NAME="Internal"
fi

if [ -n "$DETECTED_INDUSTRY" ]; then
    read -p "Industry [$DETECTED_INDUSTRY]: " INDUSTRY
    if [ -z "$INDUSTRY" ]; then
        INDUSTRY=$DETECTED_INDUSTRY
    fi
else
    echo ""
    echo "Select industry:"
    echo "  1. technology"
    echo "  2. Healthcare"
    echo "  3. FinTech"
    echo "  4. SaaS"
    echo "  5. Manufacturing"
    echo "  6. Energy"
    echo "  7. Other"
    read -p "Choice [1-7]: " INDUSTRY_CHOICE
    case $INDUSTRY_CHOICE in
        1) INDUSTRY="technology" ;;
        2) INDUSTRY="healthcare" ;;
        3) INDUSTRY="fintech" ;;
        4) INDUSTRY="saas" ;;
        5) INDUSTRY="manufacturing" ;;
        6) INDUSTRY="energy" ;;
        7)
            read -p "Enter industry name: " INDUSTRY
            INDUSTRY=$(echo "$INDUSTRY" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
            ;;
        *) INDUSTRY="other" ;;
    esac
fi

echo ""
echo "Select research focus:"
echo "  1. Market Analysis"
echo "  2. Technology Assessment"
echo "  3. Due Diligence"
echo "  4. Competitive Intelligence"
echo "  5. Regulatory Compliance"
echo "  6. Strategic Partnerships"
echo "  7. Product-Market Fit"
echo "  8. Market Entry"
echo "  9. Innovation Assessment"
echo "  10. Comprehensive"
read -p "Choice [1-10]: " FOCUS_CHOICE
case $FOCUS_CHOICE in
    1) RESEARCH_FOCUS="market_analysis" ;;
    2) RESEARCH_FOCUS="technology_assessment" ;;
    3) RESEARCH_FOCUS="due_diligence" ;;
    4) RESEARCH_FOCUS="competitive_intelligence" ;;
    5) RESEARCH_FOCUS="regulatory_compliance" ;;
    6) RESEARCH_FOCUS="strategic_partnerships" ;;
    7) RESEARCH_FOCUS="product_market_fit" ;;
    8) RESEARCH_FOCUS="market_entry" ;;
    9) RESEARCH_FOCUS="innovation_assessment" ;;
    10) RESEARCH_FOCUS="comprehensive" ;;
    *) RESEARCH_FOCUS="comprehensive" ;;
esac

# Download template files
echo ""
echo -e "${GREEN}Downloading Strategic Research Automation Template files...${NC}"

TEMPLATE_URL="https://raw.githubusercontent.com/o2alexanderfedin/strategic-research-automation-template/main"

# Create temporary directory
TMP_DIR=$(mktemp -d)
# shellcheck disable=SC2064
trap "rm -rf $TMP_DIR" EXIT

# Download skills
echo -e "${BLUE}Setting up AI research skills...${NC}"
mkdir -p .claude/skills

SKILLS=(
    "sprint-orchestrator"
    "opportunity-discovery"
    "technical-researcher"
    "market-analyst"
    "solution-architect"
    "compliance-analyst"
    "roadmap-planner"
    "report-synthesizer"
)

for skill in "${SKILLS[@]}"; do
    mkdir -p ".claude/skills/$skill"
    if curl -sSL "$TEMPLATE_URL/.claude/skills/$skill/SKILL.md" -o ".claude/skills/$skill/SKILL.md" 2>/dev/null; then
        echo -e "${GREEN}✓ Downloaded skill: $skill${NC}"
    else
        echo -e "${YELLOW}⚠ Could not download skill: $skill (using local template)${NC}"
    fi
done

# Download commands
echo -e "${BLUE}Setting up workflow commands...${NC}"
mkdir -p .claude/commands

COMMANDS=(
    "init-project"
    "discover-opportunities"
    "create-sprint"
    "execute-sprint"
    "execute-task"
    "synthesize-report"
    "score-opportunity"
    "compare-sprints"
    "export-findings"
    "validate-quality"
    "update-context"
    "finalize-release"
)

for cmd in "${COMMANDS[@]}"; do
    if curl -sSL "$TEMPLATE_URL/.claude/commands/$cmd.md" -o ".claude/commands/$cmd.md" 2>/dev/null; then
        echo -e "${GREEN}✓ Downloaded command: $cmd${NC}"
    else
        echo -e "${YELLOW}⚠ Could not download command: $cmd (using local template)${NC}"
    fi
done

# Download config files
echo -e "${BLUE}Setting up configuration...${NC}"
mkdir -p config

CONFIG_FILES=(
    "project-config.yml"
    "sprint-config.yml"
    "quality-standards.yml"
    "scoring-rubric.yml"
    "glossary.yml"
)

# Escape special characters in variables for sed
PROJECT_NAME_ESC=$(escape_for_sed "$PROJECT_NAME")
COMPANY_NAME_ESC=$(escape_for_sed "$COMPANY_NAME")
CLIENT_NAME_ESC=$(escape_for_sed "$CLIENT_NAME")
INDUSTRY_ESC=$(escape_for_sed "$INDUSTRY")
RESEARCH_FOCUS_ESC=$(escape_for_sed "$RESEARCH_FOCUS")

for config in "${CONFIG_FILES[@]}"; do
    if curl -sSL "$TEMPLATE_URL/config/$config" -o "$TMP_DIR/$config" 2>/dev/null; then
        # Replace placeholders
        sed \
            -e "s|{{PROJECT_NAME}}|$PROJECT_NAME_ESC|g" \
            -e "s|{{COMPANY_NAME}}|$COMPANY_NAME_ESC|g" \
            -e "s|{{CLIENT_NAME}}|$CLIENT_NAME_ESC|g" \
            -e "s|{{INDUSTRY}}|$INDUSTRY_ESC|g" \
            -e "s|{{RESEARCH_FOCUS}}|$RESEARCH_FOCUS_ESC|g" \
            "$TMP_DIR/$config" > "config/$config"
        echo -e "${GREEN}✓ Downloaded config: $config${NC}"
    else
        echo -e "${YELLOW}⚠ Could not download config: $config${NC}"
    fi
done

# Download industry-specific templates if available
if [ "$INDUSTRY" != "other" ]; then
    echo -e "${BLUE}Checking for $INDUSTRY-specific templates...${NC}"
    if curl -sSL "$TEMPLATE_URL/templates/$INDUSTRY/glossary.yml" -o "config/glossary.yml" 2>/dev/null; then
        echo -e "${GREEN}✓ Applied $INDUSTRY terminology${NC}"
    fi
fi

# Set up context structure
echo -e "${BLUE}Setting up context files...${NC}"

if [ ! -d "context" ] || [[ "$MERGE_CONTEXT" =~ ^[Yy]$ ]]; then
    mkdir -p context

    # Create or update company profile
    if [ ! -f "context/company-profile.md" ]; then
        cat > context/company-profile.md << EOF
# $COMPANY_NAME Company Profile

## Overview
[Brief company description]

Industry: $INDUSTRY

## Core Competencies
- [Competency 1]
- [Competency 2]
- [Competency 3]

## Strategic Goals
- [Goal 1]
- [Goal 2]
- [Goal 3]

## Available Resources
### Team
- [Team composition and skills]

### Budget
- [Budget constraints and allocation]

### Infrastructure
- [Existing infrastructure and capabilities]

## Past Projects
- [Relevant past project 1]
- [Relevant past project 2]

## Constraints and Limitations
- [Constraint 1]
- [Constraint 2]
EOF
        echo -e "${GREEN}✓ Created context/company-profile.md${NC}"
    else
        echo -e "${YELLOW}⚠ context/company-profile.md exists, skipping${NC}"
    fi

    # Create or update client info
    if [ ! -f "context/client-info.md" ]; then
        cat > context/client-info.md << EOF
# $CLIENT_NAME Client Information

## Client Profile
**Name**: $CLIENT_NAME
**Industry**: $INDUSTRY
**Size**: [Company size]

## Background
[Client background and current situation]

## Goals and Objectives
- [Objective 1]
- [Objective 2]
- [Objective 3]

## Success Criteria
- [How client defines success]

## Constraints
- **Budget**: [Budget constraints]
- **Timeline**: [Timeline requirements]
- **Regulatory**: [Regulatory considerations]

## Stakeholders
- [Key stakeholder 1 and their role]
- [Key stakeholder 2 and their role]
EOF
        echo -e "${GREEN}✓ Created context/client-info.md${NC}"
    else
        echo -e "${YELLOW}⚠ context/client-info.md exists, skipping${NC}"
    fi

    # Create or update industry background
    if [ ! -f "context/industry-background.md" ]; then
        cat > context/industry-background.md << EOF
# $INDUSTRY Industry Background

## Industry Overview
[Overview of the $INDUSTRY sector]

## Current Trends
- [Trend 1]
- [Trend 2]
- [Trend 3]

## Regulatory Landscape
[Key regulations and regulatory bodies]

## Competitive Dynamics
[Competitive environment description]

## Technology Landscape
[Key technologies and innovation trends]

## Market Conditions
- **Market Size**: [TAM/SAM/SOM if known]
- **Growth Rate**: [CAGR]
- **Key Players**: [Major competitors]
EOF
        echo -e "${GREEN}✓ Created context/industry-background.md${NC}"
    else
        echo -e "${YELLOW}⚠ context/industry-background.md exists, skipping${NC}"
    fi
fi

# Create workspace directories
echo -e "${BLUE}Creating workspace directories...${NC}"
mkdir -p sprints
mkdir -p temp
mkdir -p reports
mkdir -p scripts
echo -e "${GREEN}✓ Workspace directories created${NC}"

# Handle CLAUDE.md
if [ -f "CLAUDE.md" ]; then
    echo -e "${YELLOW}CLAUDE.md already exists${NC}"
    read -p "Do you want to replace it? (y/N): " REPLACE_CLAUDE
    if [[ "$REPLACE_CLAUDE" =~ ^[Yy]$ ]]; then
        mv CLAUDE.md CLAUDE.md.backup
        if curl -sSL "$TEMPLATE_URL/CLAUDE.md" -o CLAUDE.md 2>/dev/null; then
            sed -i.bak \
                -e "s|{{PROJECT_NAME}}|$PROJECT_NAME_ESC|g" \
                -e "s|{{COMPANY_NAME}}|$COMPANY_NAME_ESC|g" \
                -e "s|{{INDUSTRY}}|$INDUSTRY_ESC|g" \
                CLAUDE.md && rm CLAUDE.md.bak
            echo -e "${GREEN}✓ CLAUDE.md created (original backed up to CLAUDE.md.backup)${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ Keeping existing CLAUDE.md${NC}"
    fi
else
    if curl -sSL "$TEMPLATE_URL/CLAUDE.md" -o CLAUDE.md 2>/dev/null; then
        sed -i.bak \
            -e "s|{{PROJECT_NAME}}|$PROJECT_NAME_ESC|g" \
            -e "s|{{COMPANY_NAME}}|$COMPANY_NAME_ESC|g" \
            -e "s|{{INDUSTRY}}|$INDUSTRY_ESC|g" \
            CLAUDE.md && rm CLAUDE.md.bak
        echo -e "${GREEN}✓ Created CLAUDE.md${NC}"
    fi
fi

# Merge .gitignore intelligently
if [ -f ".gitignore" ]; then
    echo -e "${BLUE}Updating .gitignore...${NC}"

    # Add research automation specific entries if not present
    if ! grep -q "# Strategic Research Automation" .gitignore 2>/dev/null; then
        cat >> .gitignore << 'EOF'

# Strategic Research Automation
# Research artifacts (temp files during research)
temp/

# Environment variables (contains API keys)
.env

# Optional: Exclude personal task tracking
# context/current-tasks.md

# Reports (uncomment if reports should not be committed)
# reports/

# Sprint work in progress (uncomment to exclude)
# sprints/*/temp/
EOF
        echo -e "${GREEN}✓ Updated .gitignore${NC}"
    else
        echo -e "${YELLOW}⚠ .gitignore already has research automation entries${NC}"
    fi
else
    echo -e "${YELLOW}No .gitignore found, creating one${NC}"
    cat > .gitignore << 'EOF'
# Strategic Research Automation
temp/
.env

# OS
.DS_Store
Thumbs.db

# Editors
.vscode/
.idea/
*.swp
*.swo
*~
EOF
    echo -e "${GREEN}✓ Created .gitignore${NC}"
fi

# Create .env if it doesn't exist
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    cp .env.example .env
    echo -e "${GREEN}✓ Created .env from .env.example${NC}"
    echo -e "${YELLOW}⚠ IMPORTANT: Edit .env and add your ANTHROPIC_API_KEY${NC}"
elif [ ! -f ".env" ]; then
    cat > .env << 'EOF'
# Anthropic API Key (required)
ANTHROPIC_API_KEY=your_api_key_here

# Optional: Claude Code configuration
CLAUDE_MODEL=claude-sonnet-4-5-20250929

# Optional: Research configuration overrides
# MAX_PARALLEL_TASKS=6
# MIN_FILES_PER_SPRINT=25
EOF
    echo -e "${GREEN}✓ Created .env template${NC}"
    echo -e "${YELLOW}⚠ IMPORTANT: Edit .env and add your ANTHROPIC_API_KEY${NC}"
fi

# Git commit
echo ""
echo -e "${GREEN}Creating git commit...${NC}"

git add .claude config context sprints temp reports scripts .gitignore CLAUDE.md .env 2>/dev/null || true

if git diff --staged --quiet; then
    echo -e "${YELLOW}No changes to commit${NC}"
else
    git commit -m "feat: Add strategic research automation

Added strategic research automation infrastructure to existing project:
- AI-powered research skills (.claude/skills/)
- Workflow slash commands (.claude/commands/)
- Configuration and quality standards (config/)
- Context structure (context/)
- Automation scripts (scripts/)
- Workspace directories (sprints/, temp/, reports/)

Project: $PROJECT_NAME
Company: $COMPANY_NAME
Industry: $INDUSTRY
Research Focus: $RESEARCH_FOCUS

Generated with Strategic Research Automation Template
https://github.com/o2alexanderfedin/strategic-research-automation-template
" || echo -e "${YELLOW}Commit created (or already exists)${NC}"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║      Strategic Research Automation Complete! 🎉       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Your project now has:"
echo -e "  ${GREEN}✓${NC} 8 specialized AI research skills (.claude/skills/)"
echo -e "  ${GREEN}✓${NC} 13 workflow slash commands (.claude/commands/)"
echo -e "  ${GREEN}✓${NC} Configuration and quality standards (config/)"
echo -e "  ${GREEN}✓${NC} Context structure (context/)"
echo -e "  ${GREEN}✓${NC} Workspace directories (sprints/, temp/, reports/)"
echo ""
echo -e "${BOLD}Next steps:${NC}"
echo "  1. Edit .env and add your ANTHROPIC_API_KEY"
echo "  2. Review and enhance context files:"
echo "     - vim context/company-profile.md"
echo "     - vim context/client-info.md"
echo "     - vim context/industry-background.md"
echo "  3. Discover strategic opportunities:"
echo "     - ./scripts/setup/claude-eng -p '/discover-opportunities'"
echo "  4. Execute your first research sprint:"
echo "     - ./scripts/setup/claude-eng -p '/execute-sprint 01'"
echo ""
echo -e "${BOLD}Documentation:${NC}"
echo "  - Quick start: https://github.com/o2alexanderfedin/strategic-research-automation-template#readme"
echo "  - Commands: cat .claude/commands/README.md"
echo "  - Skills: cat .claude/skills/README.md"
echo ""
echo -e "${BLUE}Happy researching! Transform weeks into hours. 🚀${NC}"
