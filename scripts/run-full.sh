#!/usr/bin/env bash
# Fully Automated Strategic Research - One Command, Zero Interruptions
# Asks questions upfront, then runs completely autonomous until finished

set -e

# Use CLAUDE_CMD environment variable or default to YOLO mode (claude-eng)
CLAUDE_CMD="${CLAUDE_CMD:-./scripts/setup/claude-eng}"

# Disable output buffering for immediate visibility
# This ensures rookies see output as it happens, not in bursts
export PYTHONUNBUFFERED=1
export PERL_UNICODE=SDA

# Force immediate output flushing (disable stdout buffering)
stty -ixon 2>/dev/null || true  # Disable flow control if terminal available

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
echo -e "${YELLOW}Cost estimate: \$50-\$200 in API usage${NC}"
echo ""
read -r -p "Ready to begin? (y/n): " CONFIRM
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
read -r -p "Your company info: " COMPANY_INFO

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
read -r -p "Client info: " CLIENT_INFO

echo ""
echo -e "${CYAN}${BOLD}Question 3: Additional Context (Optional)${NC}"
echo ""
echo "Anything else you want me to know? Industry focus, specific problems, constraints, etc."
echo "Press Enter to skip if nothing to add."
echo ""
read -r -p "Additional context: " ADDITIONAL_CONTEXT

echo ""
echo -e "${CYAN}Number of Opportunities:${NC}"
echo "How many strategic opportunities should we explore?"
echo "  1-3   = Quick analysis (1-2 hours, \$30-\$60)"
echo "  4-6   = Comprehensive (3-4 hours, \$100-\$150)"
echo "  7-10  = Exhaustive (5-6 hours, \$200+)"
read -r -p "Number of opportunities [default: 3]: " NUM_OPPORTUNITIES
NUM_OPPORTUNITIES=${NUM_OPPORTUNITIES:-3}

echo ""
echo -e "${CYAN}Export Format:${NC}"
read -r -p "Export format (markdown/pdf/docx/all) [default: pdf]: " EXPORT_FORMAT
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
read -r -p "Proceed with fully autonomous execution? (y/n): " FINAL_CONFIRM
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
echo -e "${CYAN}→ Starting AI research agent...${NC}" | tee -a "$LOG_FILE"
echo -e "${YELLOW}  [Agent is researching companies and identifying opportunities]${NC}" | tee -a "$LOG_FILE"
echo -e "${YELLOW}  This may take 5-15 minutes... Progress updates will appear below.${NC}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Force output to flush immediately by using unbuffered tee
# All Claude output goes to both terminal (immediately) and log file
if command -v stdbuf &> /dev/null; then
    stdbuf -oL -eL $CLAUDE_CMD -p "$DISCOVERY_PROMPT" 2>&1 | stdbuf -oL -eL tee -a "$LOG_FILE"
else
    $CLAUDE_CMD -p "$DISCOVERY_PROMPT" 2>&1 | tee -a "$LOG_FILE"
fi

# Wait for sprints to be created with progress feedback
echo "" | tee -a "$LOG_FILE"
echo -e "${CYAN}→ Verifying sprint creation...${NC}" | tee -a "$LOG_FILE"
RETRY_COUNT=0
MAX_RETRIES=30
LAST_COUNT=0
while [ "$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)" -lt "$NUM_OPPORTUNITIES" ] && [ "$RETRY_COUNT" -lt "$MAX_RETRIES" ]; do
    CURRENT_COUNT=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)
    if [ "$CURRENT_COUNT" -ne "$LAST_COUNT" ]; then
        echo -e "${GREEN}  ✓ Created sprint $CURRENT_COUNT of $NUM_OPPORTUNITIES${NC}" | tee -a "$LOG_FILE"
        LAST_COUNT=$CURRENT_COUNT
    else
        echo -e "${YELLOW}  ⏳ Waiting for sprint files... ($CURRENT_COUNT/$NUM_OPPORTUNITIES created, attempt $RETRY_COUNT/$MAX_RETRIES)${NC}" | tee -a "$LOG_FILE"
    fi
    sleep 5
    RETRY_COUNT=$((RETRY_COUNT + 1))
done

SPRINT_COUNT=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)
echo "" | tee -a "$LOG_FILE"
echo -e "${GREEN}✓ Discovery complete: $SPRINT_COUNT opportunities identified${NC}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Execution phase
echo -e "${CYAN}Phase 2: Sprint Execution${NC}" | tee -a "$LOG_FILE"
echo "Executing all $SPRINT_COUNT research sprints..." | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Execute each sprint with detailed progress tracking
SPRINT_NUM_TOTAL=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)
SPRINT_NUM_CURRENT=0

for sprint_file in sprints/*.md; do
    if [ -f "$sprint_file" ]; then
        SPRINT_NUM=$(basename "$sprint_file" | grep -oE '^[0-9]+')
        SPRINT_NAME=$(basename "$sprint_file" .md)
        SPRINT_NUM_CURRENT=$((SPRINT_NUM_CURRENT + 1))

        echo "" | tee -a "$LOG_FILE"
        echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | tee -a "$LOG_FILE"
        echo -e "${BOLD}${BLUE}  SPRINT $SPRINT_NUM of $SPRINT_NUM_TOTAL: $SPRINT_NAME${NC}" | tee -a "$LOG_FILE"
        echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | tee -a "$LOG_FILE"
        echo "" | tee -a "$LOG_FILE"

        SPRINT_START_TIME=$(date +%s)

        echo -e "${CYAN}→ Starting sprint execution with 6 parallel research tasks...${NC}" | tee -a "$LOG_FILE"
        echo -e "${YELLOW}  Expected duration: 30-60 minutes${NC}" | tee -a "$LOG_FILE"
        echo -e "${YELLOW}  AI agents will research: Technical, Market, Architecture, Compliance, Roadmap, and Synthesis${NC}" | tee -a "$LOG_FILE"
        echo "" | tee -a "$LOG_FILE"

        # Format sprint number with zero padding (01, 02, etc.)
        SPRINT_NUM_PADDED=$(printf "%02d" "$SPRINT_NUM")

        # Run sprint with progress monitoring in background
        # Use unbuffered output for immediate visibility
        if command -v stdbuf &> /dev/null; then
            stdbuf -oL -eL $CLAUDE_CMD -p "/execute-sprint $SPRINT_NUM_PADDED" 2>&1 | stdbuf -oL -eL tee -a "$LOG_FILE" &
        else
            $CLAUDE_CMD -p "/execute-sprint $SPRINT_NUM_PADDED" 2>&1 | tee -a "$LOG_FILE" &
        fi
        SPRINT_PID=$!

        # Monitor progress while sprint runs
        DOTS=0
        while kill -0 $SPRINT_PID 2>/dev/null; do
            DOTS=$((DOTS + 1))
            ELAPSED=$(($(date +%s) - SPRINT_START_TIME))
            MINS=$((ELAPSED / 60))
            SECS=$((ELAPSED % 60))

            # Count research files created so far (sprint directory structure: temp/sprint-XX/YY-taskname/)
            FILE_COUNT=$(find temp/sprint-"${SPRINT_NUM_PADDED}"/ -type f 2>/dev/null | wc -l | tr -d ' ')

            # Show heartbeat every 10 seconds
            if [ $((DOTS % 2)) -eq 0 ]; then
                echo -e "${CYAN}  ⏱  Sprint $SPRINT_NUM running... ${MINS}m ${SECS}s elapsed, $FILE_COUNT research files created so far${NC}" | tee -a "$LOG_FILE"
            fi

            sleep 10
        done

        # Wait for sprint to complete
        wait $SPRINT_PID
        SPRINT_EXIT_CODE=$?

        SPRINT_END_TIME=$(date +%s)
        SPRINT_DURATION=$((SPRINT_END_TIME - SPRINT_START_TIME))
        SPRINT_MINS=$((SPRINT_DURATION / 60))
        SPRINT_SECS=$((SPRINT_DURATION % 60))

        if [ $SPRINT_EXIT_CODE -eq 0 ]; then
            # Count final files
            FINAL_FILE_COUNT=$(find temp/sprint-"${SPRINT_NUM_PADDED}"/ -type f 2>/dev/null | wc -l | tr -d ' ')
            REPORT_EXISTS=$(find reports -name "${SPRINT_NUM_PADDED}-*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

            echo "" | tee -a "$LOG_FILE"
            echo -e "${GREEN}✓ Sprint $SPRINT_NUM complete in ${SPRINT_MINS}m ${SPRINT_SECS}s${NC}" | tee -a "$LOG_FILE"
            echo -e "${GREEN}  → Research files created: $FINAL_FILE_COUNT${NC}" | tee -a "$LOG_FILE"
            echo -e "${GREEN}  → Reports generated: $REPORT_EXISTS${NC}" | tee -a "$LOG_FILE"

            # Show overall progress
            OVERALL_PCT=$((SPRINT_NUM_CURRENT * 100 / SPRINT_NUM_TOTAL))
            echo -e "${CYAN}  📊 Overall progress: $SPRINT_NUM_CURRENT/$SPRINT_NUM_TOTAL sprints ($OVERALL_PCT%) complete${NC}" | tee -a "$LOG_FILE"
        else
            echo "" | tee -a "$LOG_FILE"
            echo -e "${RED}✗ Sprint $SPRINT_NUM failed with exit code $SPRINT_EXIT_CODE${NC}" | tee -a "$LOG_FILE"
            echo -e "${YELLOW}  Check log file for details: $LOG_FILE${NC}" | tee -a "$LOG_FILE"
        fi

        echo "" | tee -a "$LOG_FILE"
    fi
done

# Export phase
echo -e "${CYAN}Phase 3: Export & Finalization${NC}" | tee -a "$LOG_FILE"
echo "Exporting reports in $EXPORT_FORMAT format..." | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Export each sprint with progress feedback
EXPORT_NUM_CURRENT=0
EXPORT_NUM_TOTAL=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)

for sprint_file in sprints/*.md; do
    if [ -f "$sprint_file" ]; then
        SPRINT_NUM=$(basename "$sprint_file" | grep -oE '^[0-9]+')
        EXPORT_NUM_CURRENT=$((EXPORT_NUM_CURRENT + 1))

        echo "" | tee -a "$LOG_FILE"
        echo -e "${YELLOW}→ Exporting Sprint $SPRINT_NUM ($EXPORT_NUM_CURRENT/$EXPORT_NUM_TOTAL) to $EXPORT_FORMAT format...${NC}" | tee -a "$LOG_FILE"
        echo -e "${CYAN}  [Converting report to professional format]${NC}" | tee -a "$LOG_FILE"

        # Use unbuffered output for immediate visibility
        if command -v stdbuf &> /dev/null; then
            stdbuf -oL -eL $CLAUDE_CMD -p "/export-findings $SPRINT_NUM --format $EXPORT_FORMAT" 2>&1 | stdbuf -oL -eL tee -a "$LOG_FILE"
        else
            $CLAUDE_CMD -p "/export-findings $SPRINT_NUM --format $EXPORT_FORMAT" 2>&1 | tee -a "$LOG_FILE"
        fi

        if [ -f "reports/${SPRINT_NUM}-*.$EXPORT_FORMAT" ] 2>/dev/null; then
            echo -e "${GREEN}✓ Sprint $SPRINT_NUM exported successfully${NC}" | tee -a "$LOG_FILE"
        else
            echo -e "${YELLOW}⚠ Export may have encountered issues - check log${NC}" | tee -a "$LOG_FILE"
        fi
    fi
done

# Generate GitHub Pages landing page
echo "" | tee -a "$LOG_FILE"
echo -e "${BOLD}${BLUE}Step 7: Generate GitHub Pages Landing Page${NC}" | tee -a "$LOG_FILE"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

if [ -f "./scripts/publish/generate-pages-v2.sh" ]; then
    echo -e "${YELLOW}Generating professional landing page for your research (v2 architecture)...${NC}" | tee -a "$LOG_FILE"

    # Run the GitHub Pages generator v2 (JSON + static HTML)
    if ./scripts/publish/generate-pages-v2.sh >> "$LOG_FILE" 2>&1; then
        echo -e "${GREEN}✓ GitHub Pages generated successfully (v2)${NC}" | tee -a "$LOG_FILE"
        echo "" | tee -a "$LOG_FILE"
        echo -e "${CYAN}Landing page created at: docs/index.html (static HTML)${NC}" | tee -a "$LOG_FILE"
        echo -e "${CYAN}Sprint data created at: docs/sprints-data.json${NC}" | tee -a "$LOG_FILE"
        echo -e "${CYAN}.nojekyll file created at: docs/.nojekyll${NC}" | tee -a "$LOG_FILE"

        # Commit and push to publish
        echo "" | tee -a "$LOG_FILE"
        echo -e "${YELLOW}Publishing to GitHub Pages...${NC}" | tee -a "$LOG_FILE"

        # Check if we're in a git repository
        if git rev-parse --git-dir > /dev/null 2>&1; then
            # Add the generated pages (index.html, sprints-data.json, and .nojekyll)
            git add docs/index.html docs/sprints-data.json docs/.nojekyll >> "$LOG_FILE" 2>&1

            # Also copy and add reports to docs/reports directory for web access
            if [ -d "reports" ]; then
                mkdir -p docs/reports
                find reports -name "sprint-*-final-report.*" -type f -exec cp {} docs/reports/ \; 2>> "$LOG_FILE"
                git add docs/reports/ >> "$LOG_FILE" 2>&1
            fi

            # Commit with timestamp
            TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
            if git commit -m "docs: Update GitHub Pages - $TIMESTAMP

- Automated research results publication
- Generated from run-full.sh
- Sprints completed: $SPRINT_COUNT
- Reports: $(find reports -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

🤖 Generated with Strategic Research Automation" >> "$LOG_FILE" 2>&1; then

                echo -e "${GREEN}✓ Changes committed${NC}" | tee -a "$LOG_FILE"

                # Push to remote
                CURRENT_BRANCH=$(git branch --show-current)
                if git push origin "$CURRENT_BRANCH" >> "$LOG_FILE" 2>&1; then
                    echo -e "${GREEN}✓ Changes pushed to GitHub${NC}" | tee -a "$LOG_FILE"

                    # Try to get the GitHub Pages URL
                    REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//' | sed 's|git@github.com:|https://github.com/|')
                    if [[ "$REPO_URL" =~ github.com/([^/]+)/([^/]+) ]]; then
                        GITHUB_USER="${BASH_REMATCH[1]}"
                        REPO_NAME="${BASH_REMATCH[2]}"

                        # Ensure GitHub CLI is installed for Pages auto-enablement
                        if ! command -v gh &> /dev/null; then
                            echo -e "${YELLOW}GitHub CLI (gh) not found - installing...${NC}" | tee -a "$LOG_FILE"

                            # Detect OS and install gh CLI
                            if [[ "$OSTYPE" == "darwin"* ]]; then
                                # macOS - use Homebrew
                                if command -v brew &> /dev/null; then
                                    echo -e "${CYAN}Installing via Homebrew...${NC}" | tee -a "$LOG_FILE"
                                    brew install gh >> "$LOG_FILE" 2>&1
                                else
                                    echo -e "${YELLOW}⚠ Homebrew not found - cannot auto-install gh CLI${NC}" | tee -a "$LOG_FILE"
                                    echo -e "${YELLOW}Install manually: https://cli.github.com/manual/installation${NC}" | tee -a "$LOG_FILE"
                                fi
                            elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
                                # Linux - detect package manager
                                if command -v apt-get &> /dev/null; then
                                    echo -e "${CYAN}Installing via apt...${NC}" | tee -a "$LOG_FILE"
                                    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg >> "$LOG_FILE" 2>&1
                                    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg >> "$LOG_FILE" 2>&1
                                    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
                                    sudo apt-get update >> "$LOG_FILE" 2>&1
                                    sudo apt-get install gh -y >> "$LOG_FILE" 2>&1
                                elif command -v yum &> /dev/null; then
                                    echo -e "${CYAN}Installing via yum...${NC}" | tee -a "$LOG_FILE"
                                    sudo yum install -y gh >> "$LOG_FILE" 2>&1
                                elif command -v dnf &> /dev/null; then
                                    echo -e "${CYAN}Installing via dnf...${NC}" | tee -a "$LOG_FILE"
                                    sudo dnf install -y gh >> "$LOG_FILE" 2>&1
                                else
                                    echo -e "${YELLOW}⚠ Unknown package manager - cannot auto-install gh CLI${NC}" | tee -a "$LOG_FILE"
                                    echo -e "${YELLOW}Install manually: https://cli.github.com/manual/installation${NC}" | tee -a "$LOG_FILE"
                                fi
                            else
                                echo -e "${YELLOW}⚠ Unknown OS ($OSTYPE) - cannot auto-install gh CLI${NC}" | tee -a "$LOG_FILE"
                                echo -e "${YELLOW}Install manually: https://cli.github.com/manual/installation${NC}" | tee -a "$LOG_FILE"
                            fi

                            # Verify installation
                            if command -v gh &> /dev/null; then
                                echo -e "${GREEN}✓ GitHub CLI installed successfully${NC}" | tee -a "$LOG_FILE"
                            else
                                echo -e "${YELLOW}⚠ GitHub CLI installation failed - Pages auto-enable skipped${NC}" | tee -a "$LOG_FILE"
                                echo -e "${YELLOW}Enable manually: GitHub repo Settings → Pages → Source: $CURRENT_BRANCH, /docs${NC}" | tee -a "$LOG_FILE"
                            fi
                        fi

                        # Try to enable GitHub Pages automatically using gh CLI
                        if command -v gh &> /dev/null; then
                            # Check if user is authenticated
                            if ! gh auth status >> "$LOG_FILE" 2>&1; then
                                echo -e "${YELLOW}GitHub CLI not authenticated - logging in...${NC}" | tee -a "$LOG_FILE"
                                echo -e "${CYAN}Please follow the authentication prompts:${NC}" | tee -a "$LOG_FILE"

                                if gh auth login; then
                                    echo -e "${GREEN}✓ GitHub CLI authenticated successfully${NC}" | tee -a "$LOG_FILE"
                                else
                                    echo -e "${YELLOW}⚠ GitHub CLI authentication failed - Pages auto-enable skipped${NC}" | tee -a "$LOG_FILE"
                                    echo -e "${YELLOW}Enable manually: GitHub repo Settings → Pages → Source: $CURRENT_BRANCH, /docs${NC}" | tee -a "$LOG_FILE"
                                fi
                            fi

                            # Proceed only if authenticated
                            if gh auth status >> "$LOG_FILE" 2>&1; then
                                echo -e "${YELLOW}Enabling GitHub Pages...${NC}" | tee -a "$LOG_FILE"

                                # Check if Pages is already enabled
                                PAGES_STATUS=$(gh api "repos/$GITHUB_USER/$REPO_NAME/pages" 2>&1 || echo "not_found")

                                if [[ "$PAGES_STATUS" == *"not_found"* ]] || [[ "$PAGES_STATUS" == *"404"* ]]; then
                                    # Enable GitHub Pages using the API
                                    if gh api -X POST "repos/$GITHUB_USER/$REPO_NAME/pages" \
                                        -f "source[branch]=$CURRENT_BRANCH" \
                                        -f "source[path]=/docs" >> "$LOG_FILE" 2>&1; then
                                        echo -e "${GREEN}✓ GitHub Pages enabled automatically!${NC}" | tee -a "$LOG_FILE"
                                        sleep 2  # Give API a moment to process
                                    else
                                        echo -e "${YELLOW}⚠ Could not enable automatically - enable manually in repo settings${NC}" | tee -a "$LOG_FILE"
                                    fi
                                else
                                    echo -e "${GREEN}✓ GitHub Pages already enabled${NC}" | tee -a "$LOG_FILE"
                                fi
                            fi
                        fi

                        echo "" | tee -a "$LOG_FILE"
                        PAGES_URL="https://${GITHUB_USER}.github.io/${REPO_NAME}/pages/"
                        echo -e "${BOLD}${CYAN}Your research is now live at:${NC}" | tee -a "$LOG_FILE"
                        echo -e "${BOLD}${CYAN}  → $PAGES_URL${NC}" | tee -a "$LOG_FILE"
                        echo "" | tee -a "$LOG_FILE"
                        echo -e "${YELLOW}Note: First-time publishing may take 2-3 minutes to deploy${NC}" | tee -a "$LOG_FILE"
                        echo -e "${YELLOW}If not enabled: GitHub repo Settings → Pages → Source: $CURRENT_BRANCH, /docs${NC}" | tee -a "$LOG_FILE"
                    else
                        echo -e "${CYAN}Check your GitHub Pages URL in repository settings${NC}" | tee -a "$LOG_FILE"
                    fi
                else
                    echo -e "${YELLOW}⚠ Push failed - publish manually: git push origin $CURRENT_BRANCH${NC}" | tee -a "$LOG_FILE"
                fi
            else
                # No changes to commit (pages already up to date)
                echo -e "${GREEN}✓ GitHub Pages already up to date${NC}" | tee -a "$LOG_FILE"
            fi
        else
            echo -e "${YELLOW}⚠ Not a git repository - pages generated but not published${NC}" | tee -a "$LOG_FILE"
            echo -e "${YELLOW}To publish: commit docs/pages/ and push to GitHub${NC}" | tee -a "$LOG_FILE"
        fi
    else
        echo -e "${YELLOW}⚠ GitHub Pages generation encountered issues - check log${NC}" | tee -a "$LOG_FILE"
        echo -e "${YELLOW}You can manually generate later: ./scripts/publish/generate-pages-v2.sh${NC}" | tee -a "$LOG_FILE"
    fi
elif [ -f "./scripts/publish/generate-pages.sh" ]; then
    echo -e "${YELLOW}Using legacy v1 generator (v2 not found)...${NC}" | tee -a "$LOG_FILE"

    # Run the GitHub Pages generator v1 (fallback)
    if ./scripts/publish/generate-pages.sh >> "$LOG_FILE" 2>&1; then
        echo -e "${GREEN}✓ GitHub Pages generated successfully (v1)${NC}" | tee -a "$LOG_FILE"
        echo "" | tee -a "$LOG_FILE"
        echo -e "${CYAN}Landing page created at: docs/index.html${NC}" | tee -a "$LOG_FILE"
        echo -e "${CYAN}.nojekyll file created at: docs/.nojekyll${NC}" | tee -a "$LOG_FILE"

        # Git operations for v1
        if git rev-parse --git-dir > /dev/null 2>&1; then
            git add docs/index.html docs/.nojekyll >> "$LOG_FILE" 2>&1

            if [ -d "reports" ]; then
                mkdir -p docs/reports
                find reports -name "sprint-*-final-report.*" -type f -exec cp {} docs/reports/ \; 2>> "$LOG_FILE"
                git add docs/reports/ >> "$LOG_FILE" 2>&1
            fi

            TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
            if git commit -m "docs: Update GitHub Pages (v1) - $TIMESTAMP

- Automated research results publication
- Generated from run-full.sh
- Sprints completed: $SPRINT_COUNT
- Reports: $(find reports -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

🤖 Generated with Strategic Research Automation" >> "$LOG_FILE" 2>&1; then
                echo -e "${GREEN}✓ Changes committed${NC}" | tee -a "$LOG_FILE"

                CURRENT_BRANCH=$(git branch --show-current)
                if git push origin "$CURRENT_BRANCH" >> "$LOG_FILE" 2>&1; then
                    echo -e "${GREEN}✓ Changes pushed to GitHub${NC}" | tee -a "$LOG_FILE"
                else
                    echo -e "${YELLOW}⚠ Push failed - publish manually: git push origin $CURRENT_BRANCH${NC}" | tee -a "$LOG_FILE"
                fi
            else
                echo -e "${GREEN}✓ GitHub Pages already up to date${NC}" | tee -a "$LOG_FILE"
            fi
        else
            echo -e "${YELLOW}⚠ Not a git repository - pages generated but not published${NC}" | tee -a "$LOG_FILE"
        fi
    else
        echo -e "${YELLOW}⚠ GitHub Pages generation encountered issues - check log${NC}" | tee -a "$LOG_FILE"
    fi
else
    echo -e "${YELLOW}⚠ GitHub Pages generator not found - skipping${NC}" | tee -a "$LOG_FILE"
    echo -e "${YELLOW}Install v2: scripts/publish/generate-pages-v2.sh${NC}" | tee -a "$LOG_FILE"
fi

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
echo "  • Reports generated: $(find reports -name "*.md" -type f 2>/dev/null | wc -l)" | tee -a "$LOG_FILE"
echo "  • Exports created: $(find reports -name "*.$EXPORT_FORMAT" -type f 2>/dev/null | wc -l)" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo -e "${BOLD}Output locations:${NC}" | tee -a "$LOG_FILE"
echo "  • Sprint definitions: sprints/" | tee -a "$LOG_FILE"
echo "  • Research files: temp/sprint-*/" | tee -a "$LOG_FILE"
echo "  • Final reports: reports/" | tee -a "$LOG_FILE"
echo "  • GitHub Pages: docs/index.html (v2: static HTML + JSON)" | tee -a "$LOG_FILE"
echo "  • Sprint data: docs/sprints-data.json" | tee -a "$LOG_FILE"
echo "  • Execution log: $LOG_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo -e "${CYAN}Next steps:${NC}" | tee -a "$LOG_FILE"
echo "  1. Review reports: ls -lh reports/" | tee -a "$LOG_FILE"
echo "  2. Read summaries: cat reports/*-report.md" | tee -a "$LOG_FILE"
echo "  3. View landing page: cd docs && python3 -m http.server 8000" | tee -a "$LOG_FILE"
echo "     (V2 requires local server: http://localhost:8000)" | tee -a "$LOG_FILE"
echo "  4. Share with client: reports/*.$EXPORT_FORMAT" | tee -a "$LOG_FILE"
echo "  5. Share live site: Your GitHub Pages URL (if enabled)" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Final git flow verification
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}" | tee -a "$LOG_FILE"
echo -e "${BOLD}${BLUE}  FINAL GIT FLOW VERIFICATION${NC}" | tee -a "$LOG_FILE"
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

if [ -f "$CLAUDE_CMD" ] || command -v "$CLAUDE_CMD" &> /dev/null; then
    echo -e "${CYAN}Running git flow verification with Claude Code...${NC}" | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"

    # Run the exact prompt for git flow verification
    $CLAUDE_CMD -p "ensure with git flow: commit/push/release/merge/CI/CD" 2>&1 | tee -a "$LOG_FILE"

    echo "" | tee -a "$LOG_FILE"
    echo -e "${GREEN}✓ Git flow verification complete${NC}" | tee -a "$LOG_FILE"
else
    echo -e "${YELLOW}⚠ Claude command not found ($CLAUDE_CMD) - skipping git flow verification${NC}" | tee -a "$LOG_FILE"
    echo -e "${YELLOW}Manual verification: commit, push, create release, merge to main${NC}" | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"
echo -e "${GREEN}Happy researching! 🚀${NC}" | tee -a "$LOG_FILE"
echo ""
