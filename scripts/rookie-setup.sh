#!/usr/bin/env bash
# Ultra-Simple Rookie Setup - Zero to Running in 5 Minutes
# For first-time users with Claude subscription

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Print welcome banner
clear
echo ""
echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}${BOLD}║                                                            ║${NC}"
echo -e "${GREEN}${BOLD}║   🚀 ROOKIE QUICK START - ZERO TO RUNNING IN 5 MINUTES   ║${NC}"
echo -e "${GREEN}${BOLD}║                                                            ║${NC}"
echo -e "${GREEN}${BOLD}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}This wizard will:${NC}"
echo "  1. Check your system (Claude CLI, dependencies)"
echo "  2. Ask 4 quick questions about your research"
echo "  3. Set everything up automatically"
echo "  4. Launch fully autonomous research"
echo ""
echo -e "${YELLOW}Requirements:${NC}"
echo "  ✓ Claude subscription (desktop app or API access)"
echo "  ✓ Basic terminal knowledge"
echo "  ✓ 5 minutes of your time"
echo ""
echo -e "${YELLOW}What you'll get:${NC}"
echo "  ✓ 5-10 strategic opportunity reports"
echo "  ✓ Professional PDF exports"
echo "  ✓ 25+ research files per opportunity"
echo "  ✓ Automated scoring and recommendations"
echo ""
echo -e "${YELLOW}Time: ${NC}2-6 hours (completely unattended)"
echo -e "${YELLOW}Cost: ${NC}\$50-\$200 in API usage (one-time for this research)"
echo ""
read -r -p "Ready to begin? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo -e "${RED}Cancelled. Run ./scripts/rookie-setup.sh when ready!${NC}"
    exit 0
fi

echo ""
echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${BLUE}  STEP 1/4: System Check${NC}"
echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check Claude CLI
echo -n "→ Checking Claude CLI... "
if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>&1 | head -1)
    echo -e "${GREEN}✓ Found: ${CLAUDE_VERSION}${NC}"
else
    echo -e "${RED}✗ Not found${NC}"
    echo ""
    echo -e "${YELLOW}Claude CLI is required. Install from:${NC}"
    echo "  https://docs.claude.com"
    echo ""
    echo "After installing Claude CLI, run this script again."
    exit 1
fi

# Check git
echo -n "→ Checking git... "
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version | awk '{print $3}')
    echo -e "${GREEN}✓ Found: git ${GIT_VERSION}${NC}"
else
    echo -e "${RED}✗ Not found${NC}"
    echo ""
    echo -e "${YELLOW}Git is required but not installed.${NC}"
    exit 1
fi

# Check jq (optional but recommended)
echo -n "→ Checking jq (for progress visibility)... "
if command -v jq &> /dev/null; then
    JQ_VERSION=$(jq --version 2>&1)
    echo -e "${GREEN}✓ Found: ${JQ_VERSION}${NC}"
else
    echo -e "${YELLOW}⚠ Not found (optional)${NC}"
    echo -e "${CYAN}  Install jq for better progress visibility:${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "    brew install jq"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "    sudo apt-get install jq   # Debian/Ubuntu"
        echo "    sudo yum install jq        # RedHat/CentOS"
    fi
    echo ""
    read -r -p "Continue without jq? (y/n): " CONTINUE_WITHOUT_JQ
    if [[ ! "$CONTINUE_WITHOUT_JQ" =~ ^[Yy]$ ]]; then
        echo -e "${RED}Cancelled. Install jq and run again.${NC}"
        exit 1
    fi
fi

# Check installation of claude-eng wrapper
echo -n "→ Checking claude-eng wrapper... "
if [ -x "scripts/setup/claude-eng" ]; then
    echo -e "${GREEN}✓ Found${NC}"
else
    echo -e "${RED}✗ Not found${NC}"
    echo ""
    echo -e "${YELLOW}Installing claude-eng wrapper...${NC}"
    if [ -x "scripts/setup/install.sh" ]; then
        cd scripts/setup
        INSTALL_NON_INTERACTIVE=1 ./install.sh > /dev/null 2>&1
        cd ../..
        echo -e "${GREEN}✓ Installed successfully${NC}"
    else
        echo -e "${RED}Installation script not found. Are you in the correct directory?${NC}"
        exit 1
    fi
fi

echo ""
echo -e "${GREEN}✓ System check complete!${NC}"
echo ""

echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${BLUE}  STEP 2/4: Quick Questions${NC}"
echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${CYAN}Tell us about your research (or press Enter for defaults):${NC}"
echo ""

# Question 1: Company Name
read -r -p "1. Your company name [My Company]: " COMPANY_NAME
COMPANY_NAME=${COMPANY_NAME:-"My Company"}

# Question 2: Industry
read -r -p "2. Industry you're researching [technology]: " INDUSTRY
INDUSTRY=${INDUSTRY:-"technology"}

# Question 3: Research Topic
read -r -p "3. Research topic [Strategic Industry Analysis]: " TOPIC
TOPIC=${TOPIC:-"Strategic Industry Analysis"}

# Question 4: Client Name (optional)
read -r -p "4. Client name (optional) [Internal Research]: " CLIENT_NAME
CLIENT_NAME=${CLIENT_NAME:-"Internal Research"}

echo ""
echo -e "${CYAN}Great! Here's what we'll set up:${NC}"
echo "  Company:  ${BOLD}${COMPANY_NAME}${NC}"
echo "  Industry: ${BOLD}${INDUSTRY}${NC}"
echo "  Topic:    ${BOLD}${TOPIC}${NC}"
echo "  Client:   ${BOLD}${CLIENT_NAME}${NC}"
echo ""
read -r -p "Look good? (y/n): " CONFIRM_INFO
if [[ ! "$CONFIRM_INFO" =~ ^[Yy]$ ]]; then
    echo -e "${RED}Cancelled. Run the script again to start over.${NC}"
    exit 0
fi

echo ""
echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${BLUE}  STEP 3/4: Auto-Configuration${NC}"
echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Create context files
echo -n "→ Creating company profile... "
mkdir -p context
cat > context/company-profile.md <<EOF
# ${COMPANY_NAME} - Company Profile

## Core Capabilities

- Strategic analysis and market research
- Technology assessment and evaluation
- Competitive intelligence and benchmarking
- Business development and partnership strategy

## Technical Expertise

- Industry analysis methodologies
- Market sizing and forecasting
- Technology trend analysis
- Regulatory compliance assessment

## Industry Focus

Primary: ${INDUSTRY}

## Geographic Coverage

Global with focus on major markets (North America, Europe, Asia-Pacific)

## Team Strengths

- Cross-functional expertise
- Data-driven decision making
- Rapid research and synthesis
- Client-focused deliverables
EOF
echo -e "${GREEN}✓${NC}"

echo -n "→ Creating client information... "
cat > context/client-info.md <<EOF
# ${CLIENT_NAME} - Client Background

## Client Overview

Client: ${CLIENT_NAME}
Industry: ${INDUSTRY}
Research Focus: ${TOPIC}

## Research Objectives

1. Identify strategic opportunities in ${INDUSTRY}
2. Assess market landscape and competitive dynamics
3. Evaluate technical feasibility and risks
4. Provide actionable recommendations

## Success Criteria

- Comprehensive market analysis
- Evidence-based recommendations
- Clear prioritization of opportunities
- Actionable implementation roadmap

## Constraints

- Timeline: Deliver insights as quickly as possible
- Budget: Optimize for value and thoroughness
- Quality: Maintain high standards for citations and evidence
EOF
echo -e "${GREEN}✓${NC}"

echo -n "→ Creating project configuration... "
cat > config/project-config.yml <<EOF
# Project Configuration - Auto-generated by rookie-setup.sh

project:
  name: "${TOPIC}"
  industry: "${INDUSTRY}"
  company: "${COMPANY_NAME}"
  client: "${CLIENT_NAME}"
  start_date: $(date +%Y-%m-%d)

research:
  min_files_per_sprint: 25
  citation_style: "APA"
  max_parallel_tasks: 4

quality:
  min_citation_ratio: 0.7
  min_word_count: 500
  max_word_count: 5000

output:
  formats: ["markdown", "pdf", "docx"]
  export_directory: "exports"
EOF
echo -e "${GREEN}✓${NC}"

echo -n "→ Initializing git repository... "
if [ ! -d ".git" ]; then
    git init > /dev/null 2>&1
    git add . > /dev/null 2>&1
    git commit -m "Initial commit: Rookie setup for ${TOPIC}" > /dev/null 2>&1
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⚠ Already initialized${NC}"
fi

echo ""
echo -e "${GREEN}✓ Configuration complete!${NC}"
echo ""

echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${BLUE}  STEP 4/4: Launch Autonomous Research${NC}"
echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${CYAN}Ready to launch fully autonomous research!${NC}"
echo ""
echo -e "${YELLOW}What happens next:${NC}"
echo "  1. Claude will discover strategic opportunities automatically"
echo "  2. For each opportunity, research will run completely hands-free"
echo "  3. Professional reports will be generated automatically"
echo "  4. Everything will be exported to PDF/DOCX"
echo ""
echo -e "${YELLOW}You'll see:${NC}"
echo "  • Animated progress indicators (⠋⠙⠹⠸)"
echo "  • Real-time status updates"
echo "  • Tool execution visibility"
echo "  • File creation counts"
echo ""
echo -e "${GREEN}${BOLD}TIME TO GO GET COFFEE! ☕${NC}"
echo ""
echo -e "${CYAN}This will run for 2-6 hours completely unattended.${NC}"
echo -e "${CYAN}You can safely close this terminal - research will continue.${NC}"
echo ""
read -r -p "Launch now? (y/n): " LAUNCH
if [[ ! "$LAUNCH" =~ ^[Yy]$ ]]; then
    echo ""
    echo -e "${YELLOW}Not launching yet. To start later, run:${NC}"
    echo "  ./scripts/run-full.sh"
    echo ""
    exit 0
fi

echo ""
echo -e "${GREEN}${BOLD}🚀 LAUNCHING AUTONOMOUS RESEARCH...${NC}"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Launch the full automation script
exec ./scripts/run-full.sh
