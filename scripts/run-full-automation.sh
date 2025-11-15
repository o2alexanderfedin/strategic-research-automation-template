#!/usr/bin/env bash
# Fully Automated Strategic Research - One Command, Zero Interruptions
# Asks questions upfront, then runs completely autonomous until finished

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Print header
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Fully Automated Strategic Research - One Command        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}This will:${NC}"
echo "  1. Gather information about your company and client"
echo "  2. Discover strategic opportunities automatically"
echo "  3. Execute ALL research sprints completely hands-free"
echo "  4. Generate final reports and exports"
echo ""
echo -e "${YELLOW}Time estimate: 2-6 hours (runs unattended)${NC}"
echo -e "${YELLOW}Cost estimate: \$50-$200 in API usage${NC}"
echo ""
read -p "Ready to begin? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ]; then
    echo -e "${RED}Cancelled.${NC}"
    exit 0
fi

echo ""
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${BLUE}  STEP 1: Information Gathering${NC}"
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Company Information
echo -e "${CYAN}About Your Company:${NC}"
echo ""

read -p "Company name: " COMPANY_NAME
read -p "What does your company do? (brief description): " COMPANY_DESCRIPTION
read -p "Key capabilities (comma-separated): " COMPANY_CAPABILITIES
read -p "Team size (optional, press Enter to skip): " TEAM_SIZE
read -p "Notable past projects (optional, comma-separated): " PAST_PROJECTS

echo ""
echo -e "${CYAN}About Your Client:${NC}"
echo ""

read -p "Client company name: " CLIENT_NAME
read -p "Client industry: " CLIENT_INDUSTRY
read -p "Client website (if known): " CLIENT_WEBSITE
read -p "Client LinkedIn URL (if known): " CLIENT_LINKEDIN
read -p "What problem are they trying to solve?: " CLIENT_PROBLEM
read -p "What are their goals? (brief): " CLIENT_GOALS

echo ""
echo -e "${CYAN}Research Focus:${NC}"
echo ""

read -p "What should we research for this client? (e.g., 'AI integration opportunities', 'market expansion strategy'): " RESEARCH_FOCUS

echo ""
echo -e "${CYAN}Number of Opportunities:${NC}"
echo "How many strategic opportunities should we explore?"
echo "  1-3   = Quick analysis (1-2 hours, \$30-\$60)"
echo "  4-6   = Comprehensive (3-4 hours, \$100-\$150)"
echo "  7-10  = Exhaustive (5-6 hours, \$200+)"
read -p "Number of opportunities [default: 3]: " NUM_OPPORTUNITIES
NUM_OPPORTUNITIES=${NUM_OPPORTUNITIES:-3}

echo ""
echo -e "${CYAN}Export Format:${NC}"
read -p "Export format (markdown/pdf/docx/all) [default: pdf]: " EXPORT_FORMAT
EXPORT_FORMAT=${EXPORT_FORMAT:-pdf}

# Summary
echo ""
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${BLUE}  Configuration Summary${NC}"
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${BOLD}Company:${NC} $COMPANY_NAME"
echo -e "${BOLD}Client:${NC} $CLIENT_NAME ($CLIENT_INDUSTRY)"
echo -e "${BOLD}Research Focus:${NC} $RESEARCH_FOCUS"
echo -e "${BOLD}Opportunities:${NC} $NUM_OPPORTUNITIES"
echo -e "${BOLD}Export Format:${NC} $EXPORT_FORMAT"
echo ""
read -p "Proceed with fully autonomous execution? (y/n): " FINAL_CONFIRM
if [ "$FINAL_CONFIRM" != "y" ]; then
    echo -e "${RED}Cancelled.${NC}"
    exit 0
fi

# Create context files
echo ""
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${BLUE}  STEP 2: Creating Context Files${NC}"
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Company profile
echo -e "${GREEN}→ Creating company profile...${NC}"
cat > context/company-profile.md <<EOF
# $COMPANY_NAME Company Profile

## Overview

$COMPANY_DESCRIPTION

## Core Competencies

EOF

# Add capabilities
IFS=',' read -ra CAPS <<< "$COMPANY_CAPABILITIES"
for cap in "${CAPS[@]}"; do
    echo "- $(echo $cap | xargs)" >> context/company-profile.md
done

cat >> context/company-profile.md <<EOF

## Team

${TEAM_SIZE:+Team Size: $TEAM_SIZE}

## Past Projects

EOF

# Add past projects if provided
if [ -n "$PAST_PROJECTS" ]; then
    IFS=',' read -ra PROJECTS <<< "$PAST_PROJECTS"
    for project in "${PROJECTS[@]}"; do
        echo "- $(echo $project | xargs)" >> context/company-profile.md
    done
else
    echo "- [Add relevant past projects]" >> context/company-profile.md
fi

echo -e "${GREEN}✓ Company profile created${NC}"

# Client info
echo -e "${GREEN}→ Creating client information...${NC}"
cat > context/client-info.md <<EOF
# $CLIENT_NAME Client Information

## Client Profile

**Name**: $CLIENT_NAME
**Industry**: $CLIENT_INDUSTRY
${CLIENT_WEBSITE:+**Website**: $CLIENT_WEBSITE}
${CLIENT_LINKEDIN:+**LinkedIn**: $CLIENT_LINKEDIN}

## Problem Statement

$CLIENT_PROBLEM

## Goals and Objectives

$CLIENT_GOALS

## Research Focus

$RESEARCH_FOCUS
EOF

echo -e "${GREEN}✓ Client information created${NC}"

# Industry background
echo -e "${GREEN}→ Creating industry background...${NC}"
cat > context/industry-background.md <<EOF
# $CLIENT_INDUSTRY Industry Background

## Industry Overview

This research will focus on the $CLIENT_INDUSTRY sector, with emphasis on:
- $RESEARCH_FOCUS

## Research Objectives

We will analyze strategic opportunities for $CLIENT_NAME in the context of:
1. Current market trends and dynamics
2. Technology landscape and innovations
3. Regulatory and compliance requirements
4. Competitive positioning
5. Implementation feasibility

## Target Outcomes

Identify and evaluate the top $NUM_OPPORTUNITIES strategic opportunities that align with:
- $COMPANY_NAME's capabilities: $COMPANY_CAPABILITIES
- $CLIENT_NAME's goals: $CLIENT_GOALS
- Market viability and ROI potential
EOF

echo -e "${GREEN}✓ Industry background created${NC}"

# Start autonomous execution
echo ""
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${BLUE}  STEP 3: Autonomous Research Execution${NC}"
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Starting fully autonomous research...${NC}"
echo -e "${YELLOW}This will run unattended until completion.${NC}"
echo -e "${YELLOW}You can safely close this window - progress is logged.${NC}"
echo ""

# Log file
LOG_FILE="automation-$(date +%Y%m%d-%H%M%S).log"
echo "Log file: $LOG_FILE"
echo ""

# Start timestamp
START_TIME=$(date +%s)
echo "Started at: $(date)" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Discovery phase
echo -e "${CYAN}Phase 1: Opportunity Discovery${NC}" | tee -a "$LOG_FILE"
echo "Finding top $NUM_OPPORTUNITIES strategic opportunities..." | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Create discovery prompt
DISCOVERY_PROMPT="Analyze the context files and identify exactly $NUM_OPPORTUNITIES strategic opportunities for $CLIENT_NAME.

Focus on: $RESEARCH_FOCUS

For each opportunity, create a sprint definition file in sprints/ directory (01-opportunity-name.md, 02-opportunity-name.md, etc.).

Each sprint should include:
- Clear opportunity title
- Business value proposition
- Technical feasibility assessment
- Market potential
- Implementation complexity

Create exactly $NUM_OPPORTUNITIES sprint files and respond with 'DISCOVERY COMPLETE' when done."

# Run discovery
echo "$DISCOVERY_PROMPT" | ./scripts/setup/claude-eng 2>&1 | tee -a "$LOG_FILE"

# Wait for sprints to be created
RETRY_COUNT=0
MAX_RETRIES=10
while [ $(ls -1 sprints/*.md 2>/dev/null | wc -l) -lt $NUM_OPPORTUNITIES ] && [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    echo "Waiting for sprint files to be created... ($RETRY_COUNT/$MAX_RETRIES)" | tee -a "$LOG_FILE"
    sleep 5
    RETRY_COUNT=$((RETRY_COUNT + 1))
done

SPRINT_COUNT=$(ls -1 sprints/*.md 2>/dev/null | wc -l)
echo "" | tee -a "$LOG_FILE"
echo -e "${GREEN}✓ Discovery complete: $SPRINT_COUNT opportunities identified${NC}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Execution phase
echo -e "${CYAN}Phase 2: Sprint Execution${NC}" | tee -a "$LOG_FILE"
echo "Executing all $SPRINT_COUNT research sprints..." | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Execute each sprint
for sprint_file in sprints/*.md; do
    if [ -f "$sprint_file" ]; then
        SPRINT_NUM=$(basename "$sprint_file" | grep -oE '^[0-9]+')
        SPRINT_NAME=$(basename "$sprint_file" .md)

        echo -e "${YELLOW}→ Executing Sprint $SPRINT_NUM: $SPRINT_NAME${NC}" | tee -a "$LOG_FILE"

        # Run sprint
        ./scripts/setup/claude-eng -p "/execute-sprint $SPRINT_NUM" 2>&1 | tee -a "$LOG_FILE"

        echo -e "${GREEN}✓ Sprint $SPRINT_NUM complete${NC}" | tee -a "$LOG_FILE"
        echo "" | tee -a "$LOG_FILE"
    fi
done

# Export phase
echo -e "${CYAN}Phase 3: Export & Finalization${NC}" | tee -a "$LOG_FILE"
echo "Exporting reports in $EXPORT_FORMAT format..." | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Export each sprint
for sprint_file in sprints/*.md; do
    if [ -f "$sprint_file" ]; then
        SPRINT_NUM=$(basename "$sprint_file" | grep -oE '^[0-9]+')

        echo -e "${YELLOW}→ Exporting Sprint $SPRINT_NUM to $EXPORT_FORMAT${NC}" | tee -a "$LOG_FILE"

        ./scripts/setup/claude-eng -p "/export-findings $SPRINT_NUM --format $EXPORT_FORMAT" 2>&1 | tee -a "$LOG_FILE"

        echo -e "${GREEN}✓ Sprint $SPRINT_NUM exported${NC}" | tee -a "$LOG_FILE"
    fi
done

# Final summary
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
HOURS=$((DURATION / 3600))
MINUTES=$(((DURATION % 3600) / 60))

echo "" | tee -a "$LOG_FILE"
echo -e "${BOLD}${GREEN}═══════════════════════════════════════════════════════════${NC}" | tee -a "$LOG_FILE"
echo -e "${BOLD}${GREEN}  AUTOMATION COMPLETE!${NC}" | tee -a "$LOG_FILE"
echo -e "${BOLD}${GREEN}═══════════════════════════════════════════════════════════${NC}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo "Finished at: $(date)" | tee -a "$LOG_FILE"
echo "Total duration: ${HOURS}h ${MINUTES}m" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo -e "${BOLD}Results:${NC}" | tee -a "$LOG_FILE"
echo "  • Opportunities analyzed: $SPRINT_COUNT" | tee -a "$LOG_FILE"
echo "  • Reports generated: $(ls -1 reports/*.md 2>/dev/null | wc -l)" | tee -a "$LOG_FILE"
echo "  • Exports created: $(ls -1 reports/*.$EXPORT_FORMAT 2>/dev/null | wee -l)" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo -e "${BOLD}Output locations:${NC}" | tee -a "$LOG_FILE"
echo "  • Sprint definitions: sprints/" | tee -a "$LOG_FILE"
echo "  • Research files: temp/sprint-*/" | tee -a "$LOG_FILE"
echo "  • Final reports: reports/" | tee -a "$LOG_FILE"
echo "  • Execution log: $LOG_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo -e "${CYAN}Next steps:${NC}" | tee -a "$LOG_FILE"
echo "  1. Review reports: ls -lh reports/" | tee -a "$LOG_FILE"
echo "  2. Read summaries: cat reports/*-report.md" | tee -a "$LOG_FILE"
echo "  3. Share with client: reports/*.$EXPORT_FORMAT" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo -e "${GREEN}Happy researching! 🚀${NC}" | tee -a "$LOG_FILE"
echo ""
