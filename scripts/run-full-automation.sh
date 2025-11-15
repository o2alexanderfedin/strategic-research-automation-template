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

# Question 1: Your company
echo -e "${CYAN}${BOLD}Question 1: About Your Company${NC}"
echo ""
echo "Tell me about your company. Include:"
echo "  - Company name"
echo "  - What you do / services you offer"
echo "  - Website or LinkedIn URL (if you have one)"
echo ""
echo "Example: 'Hupyy - We do AI consulting and development. https://linkedin.com/company/hupyy'"
echo ""
read -p "Your company info: " COMPANY_INFO

echo ""
echo -e "${CYAN}${BOLD}Question 2: About Your Client${NC}"
echo ""
echo "Tell me about the client. Include:"
echo "  - Client company name"
echo "  - Their website or LinkedIn URL"
echo "  - Any other info you have about them"
echo ""
echo "Example: 'Innova Technology - https://innova-technology.com/ - They do enterprise software'"
echo ""
read -p "Client info: " CLIENT_INFO

echo ""
echo -e "${CYAN}${BOLD}Question 3: Additional Context (Optional)${NC}"
echo ""
echo "Anything else you want me to know? Industry focus, specific problems, constraints, etc."
echo "Press Enter to skip if nothing to add."
echo ""
read -p "Additional context: " ADDITIONAL_CONTEXT

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
echo -e "${BOLD}Your Company:${NC} $COMPANY_INFO"
echo -e "${BOLD}Client:${NC} $CLIENT_INFO"
echo -e "${BOLD}Additional Context:${NC} ${ADDITIONAL_CONTEXT:-None}"
echo -e "${BOLD}Opportunities to explore:${NC} $NUM_OPPORTUNITIES"
echo -e "${BOLD}Export Format:${NC} $EXPORT_FORMAT"
echo ""
echo -e "${YELLOW}I will research both companies, figure out what you offer,"
echo -e "identify what the client needs, and analyze opportunities.${NC}"
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

# Company profile - simple, let Claude research the details
echo -e "${GREEN}→ Creating company profile...${NC}"
cat > context/company-profile.md <<EOF
# Company Profile

## Raw Information Provided

$COMPANY_INFO

## Instructions for Claude

Research this company to understand:
- What services/products they offer
- Their core capabilities and expertise
- Team size and structure (if publicly available)
- Notable projects or clients (if publicly available)
- Technologies and methodologies they use
- Their competitive advantages

Use web search to gather this information from their website, LinkedIn, or other public sources.
EOF

echo -e "${GREEN}✓ Company profile created${NC}"

# Client info - simple, let Claude research
echo -e "${GREEN}→ Creating client information...${NC}"
cat > context/client-info.md <<EOF
# Client Information

## Raw Information Provided

$CLIENT_INFO

${ADDITIONAL_CONTEXT:+## Additional Context

$ADDITIONAL_CONTEXT}

## Instructions for Claude

Research this client company to understand:
- Their industry and market position
- What products/services they offer
- Their current challenges and opportunities
- Technology stack and infrastructure (if publicly available)
- Strategic direction and goals
- Recent news, funding, or major initiatives

Use web search to gather comprehensive information about this company.
EOF

echo -e "${GREEN}✓ Client information created${NC}"

# Industry background - let Claude figure it out
echo -e "${GREEN}→ Creating industry background...${NC}"
cat > context/industry-background.md <<EOF
# Industry Research Context

## Task

Based on the company and client information provided, research the relevant industry context.

## Instructions for Claude

1. Identify the industry/sector based on the client's business
2. Research current market trends and dynamics
3. Understand regulatory requirements and compliance needs
4. Analyze competitive landscape
5. Identify technology trends and innovations
6. Assess market opportunities and challenges

Use this research to identify strategic opportunities where our company's capabilities
align with the client's needs and market opportunities.
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
echo -e "${CYAN}Phase 1: Research & Opportunity Discovery${NC}" | tee -a "$LOG_FILE"
echo "Researching companies and finding top $NUM_OPPORTUNITIES strategic opportunities..." | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Create discovery prompt
DISCOVERY_PROMPT="I need you to research and identify strategic opportunities. Here's what to do:

STEP 1: Research the Companies
- Read context/company-profile.md and research our company (use web search if URLs provided)
- Read context/client-info.md and research the client company thoroughly
- Read context/industry-background.md for additional context
- Understand what WE offer and what THEY need

STEP 2: Identify Opportunities
Find exactly $NUM_OPPORTUNITIES strategic opportunities where:
- Our capabilities match their potential needs
- There's clear business value for the client
- Market opportunity exists
- Implementation is feasible

STEP 3: Create Sprint Files
For each opportunity, create a sprint file in sprints/ directory:
- File format: 01-opportunity-name.md, 02-opportunity-name.md, etc.
- Include: opportunity title, business value, technical feasibility, market potential

Work autonomously. Do all the research needed. Use web search extensively.
Respond with 'DISCOVERY COMPLETE - [number] opportunities identified' when done."

# Run discovery
./scripts/setup/claude-eng -p "$DISCOVERY_PROMPT" 2>&1 | tee -a "$LOG_FILE"

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
echo "  • Exports created: $(ls -1 reports/*.$EXPORT_FORMAT 2>/dev/null | wc -l)" | tee -a "$LOG_FILE"
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
