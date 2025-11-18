#!/usr/bin/env bash
#
# Fully Automated Strategic Research - One Command, Zero Interruptions (v2)
# Refactored with SOLID principles - clean, modular, testable
#
# Usage: ./scripts/run-full-v2.sh

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Load libraries (Dependency Inversion Principle)
source "$SCRIPT_DIR/lib/ui-helpers.sh"
source "$SCRIPT_DIR/lib/context-generator.sh"
source "$SCRIPT_DIR/lib/ensure-github-cli.sh"
source "$SCRIPT_DIR/lib/enable-github-pages.sh"

# Configuration
CLAUDE_CMD="${CLAUDE_CMD:-./scripts/setup/claude-eng}"
export PYTHONUNBUFFERED=1
export PERL_UNICODE=SDA
stty -ixon 2>/dev/null || true

# ============================================================================
# User Input Phase
# ============================================================================

collect_user_input() {
    print_header "Fully Automated Strategic Research - One Command"

    echo -e "${CYAN}This will:${NC}"
    print_list_item "Gather information about your company and client"
    print_list_item "Discover strategic opportunities automatically"
    print_list_item "Execute ALL research sprints completely hands-free"
    print_list_item "Generate final reports and exports"
    echo ""
    echo -e "${YELLOW}Time estimate: 2-6 hours (runs unattended)${NC}"
    echo -e "${YELLOW}Cost estimate: \$50-\$200 in API usage${NC}"
    echo ""

    if ! ask_yes_no "Ready to begin?"; then
        echo -e "${RED}Cancelled.${NC}"
        exit 0
    fi

    print_section "STEP 1: Information Gathering"

    # Company information
    echo -e "${CYAN}${BOLD}Question 1: About Your Company${NC}"
    echo ""
    echo "Tell me about your company. Include:"
    print_list_item "Company name"
    print_list_item "What you do / services you offer"
    print_list_item "Website or LinkedIn URL (if you have one)"
    echo ""
    echo "Example: 'Hupyy - We do AI consulting and development. https://linkedin.com/company/hupyy'"
    echo ""
    read -r -p "Your company info: " COMPANY_INFO

    # Client information
    echo ""
    echo -e "${CYAN}${BOLD}Question 2: About Your Client${NC}"
    echo ""
    echo "Tell me about the client. Include:"
    print_list_item "Client company name"
    print_list_item "Their website or LinkedIn URL"
    print_list_item "Any other info you have about them"
    echo ""
    echo "Example: 'Innova Technology - https://innova-technology.com/ - They do enterprise software'"
    echo ""
    read -r -p "Client info: " CLIENT_INFO

    # Additional context
    echo ""
    echo -e "${CYAN}${BOLD}Question 3: Additional Context (Optional)${NC}"
    echo ""
    echo "Anything else you want me to know? Industry focus, specific problems, constraints, etc."
    echo "Press Enter to skip if nothing to add."
    echo ""
    read -r -p "Additional context: " ADDITIONAL_CONTEXT

    # Number of opportunities
    echo ""
    echo -e "${CYAN}Number of Opportunities:${NC}"
    echo "How many strategic opportunities should we explore?"
    echo "  1-3   = Quick analysis (1-2 hours, \$30-\$60)"
    echo "  4-6   = Comprehensive (3-4 hours, \$100-\$150)"
    echo "  7-10  = Exhaustive (5-6 hours, \$200+)"
    NUM_OPPORTUNITIES=$(ask_with_default "Number of opportunities" "3")

    # Export format
    echo ""
    EXPORT_FORMAT=$(ask_with_default "Export format (markdown/pdf/docx/all)" "pdf")

    # Configuration summary
    print_section "Configuration Summary"
    print_table_row "Your Company" "$COMPANY_INFO"
    print_table_row "Client" "$CLIENT_INFO"
    print_table_row "Additional Context" "${ADDITIONAL_CONTEXT:-None}"
    print_table_row "Opportunities to explore" "$NUM_OPPORTUNITIES"
    print_table_row "Export Format" "$EXPORT_FORMAT"
    echo ""
    echo -e "${YELLOW}I will research both companies, figure out what you offer,"
    echo -e "identify what the client needs, and analyze opportunities.${NC}"
    echo ""

    if ! ask_yes_no "Proceed with fully autonomous execution?"; then
        echo -e "${RED}Cancelled.${NC}"
        exit 0
    fi
}

# ============================================================================
# Context Generation Phase
# ============================================================================

setup_context_files() {
    print_section "STEP 2: Creating Context Files"

    print_progress "Creating company profile..."
    generate_company_context "$COMPANY_INFO"
    print_success "Company profile created"

    print_progress "Creating client information..."
    generate_client_context "$CLIENT_INFO" "$ADDITIONAL_CONTEXT"
    print_success "Client information created"

    print_progress "Creating industry background..."
    # shellcheck disable=SC2119
    generate_industry_context
    print_success "Industry background created"
}

# ============================================================================
# Research Execution Phase
# ============================================================================

execute_research() {
    print_section "STEP 3: Autonomous Research Execution"

    echo -e "${YELLOW}Starting fully autonomous research...${NC}"
    echo -e "${YELLOW}This will run unattended until completion.${NC}"
    echo -e "${YELLOW}You can safely close this window - progress is logged.${NC}"
    echo ""

    # Log file setup
    LOG_FILE="automation-$(date +%Y%m%d-%H%M%S).log"
    print_info "Log file: $LOG_FILE"
    echo ""

    START_TIME=$(date +%s)
    echo "Started at: $(date)" | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"

    # Discovery phase
    run_discovery_phase

    # Execution phase
    run_sprint_execution_phase

    # Export phase
    run_export_phase

    # Calculate duration
    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))
    HOURS=$((DURATION / 3600))
    MINUTES=$(((DURATION % 3600) / 60))

    print_success "All research completed in ${HOURS}h ${MINUTES}m"
}

run_discovery_phase() {
    echo -e "${CYAN}Phase 1: Research & Opportunity Discovery${NC}" | tee -a "$LOG_FILE"
    echo "Researching companies and finding top $NUM_OPPORTUNITIES strategic opportunities..." | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"

    local discovery_prompt="I need you to research and identify strategic opportunities. Here's what to do:

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

    print_progress "Starting AI research agent..."
    echo -e "${YELLOW}  [Agent is researching companies and identifying opportunities]${NC}" | tee -a "$LOG_FILE"
    echo -e "${YELLOW}  This may take 5-15 minutes... Progress updates will appear below.${NC}" | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"

    if command -v stdbuf &> /dev/null; then
        stdbuf -oL -eL $CLAUDE_CMD -p "$discovery_prompt" 2>&1 | stdbuf -oL -eL tee -a "$LOG_FILE"
    else
        $CLAUDE_CMD -p "$discovery_prompt" 2>&1 | tee -a "$LOG_FILE"
    fi

    # Wait for sprint files
    wait_for_sprint_files
}

wait_for_sprint_files() {
    echo "" | tee -a "$LOG_FILE"
    print_progress "Verifying sprint creation..."

    local retry_count=0
    local max_retries=30
    local last_count=0

    while [ "$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)" -lt "$NUM_OPPORTUNITIES" ] && [ "$retry_count" -lt "$max_retries" ]; do
        local current_count
        current_count=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)
        if [ "$current_count" -ne "$last_count" ]; then
            print_success "Created sprint $current_count of $NUM_OPPORTUNITIES"
            last_count=$current_count
        else
            echo -e "${YELLOW}  ⏳ Waiting for sprint files... ($current_count/$NUM_OPPORTUNITIES created, attempt $retry_count/$max_retries)${NC}" | tee -a "$LOG_FILE"
        fi
        sleep 5
        retry_count=$((retry_count + 1))
    done

    local sprint_count
    sprint_count=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)
    echo "" | tee -a "$LOG_FILE"
    print_success "Discovery complete: $sprint_count opportunities identified"
    echo "" | tee -a "$LOG_FILE"
}

run_sprint_execution_phase() {
    echo -e "${CYAN}Phase 2: Sprint Execution${NC}" | tee -a "$LOG_FILE"
    local sprint_count
    sprint_count=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)
    echo "Executing all $sprint_count research sprints..." | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"

    local sprint_num_current=0
    local sprint_num_total
    sprint_num_total=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)

    for sprint_file in sprints/*.md; do
        if [ -f "$sprint_file" ]; then
            local sprint_num
            sprint_num=$(basename "$sprint_file" | grep -oE '^[0-9]+')
            local sprint_name
            sprint_name=$(basename "$sprint_file" .md)
            sprint_num_current=$((sprint_num_current + 1))

            echo "" | tee -a "$LOG_FILE"
            echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | tee -a "$LOG_FILE"
            echo -e "${BOLD}${BLUE}  SPRINT $sprint_num of $sprint_num_total: $sprint_name${NC}" | tee -a "$LOG_FILE"
            echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | tee -a "$LOG_FILE"
            echo "" | tee -a "$LOG_FILE"

            local sprint_num_padded
            sprint_num_padded=$(printf "%02d" "$sprint_num")

            if command -v stdbuf &> /dev/null; then
                stdbuf -oL -eL $CLAUDE_CMD -p "/execute-sprint $sprint_num_padded" 2>&1 | stdbuf -oL -eL tee -a "$LOG_FILE"
            else
                $CLAUDE_CMD -p "/execute-sprint $sprint_num_padded" 2>&1 | tee -a "$LOG_FILE"
            fi
        fi
    done
}

run_export_phase() {
    echo -e "${CYAN}Phase 3: Export & Finalization${NC}" | tee -a "$LOG_FILE"
    echo "Exporting reports in $EXPORT_FORMAT format..." | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"

    local export_num_current=0
    local export_num_total
    export_num_total=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)

    for sprint_file in sprints/*.md; do
        if [ -f "$sprint_file" ]; then
            local sprint_num
            sprint_num=$(basename "$sprint_file" | grep -oE '^[0-9]+')
            export_num_current=$((export_num_current + 1))

            echo "" | tee -a "$LOG_FILE"
            print_progress "Exporting Sprint $sprint_num ($export_num_current/$export_num_total) to $EXPORT_FORMAT format..."

            if command -v stdbuf &> /dev/null; then
                stdbuf -oL -eL $CLAUDE_CMD -p "/export-findings $sprint_num --format $EXPORT_FORMAT" 2>&1 | stdbuf -oL -eL tee -a "$LOG_FILE"
            else
                $CLAUDE_CMD -p "/export-findings $sprint_num --format $EXPORT_FORMAT" 2>&1 | tee -a "$LOG_FILE"
            fi
        fi
    done
}

# ============================================================================
# GitHub Pages Deployment Phase
# ============================================================================

deploy_to_github_pages() {
    print_section "Step 7: Generate GitHub Pages Landing Page"

    if [ ! -f "./scripts/publish/generate-pages-v2.sh" ]; then
        print_warning "GitHub Pages generator not found - skipping"
        return 1
    fi

    print_progress "Generating professional landing page (v2 architecture)..."

    if ./scripts/publish/generate-pages-v2.sh >> "$LOG_FILE" 2>&1; then
        print_success "GitHub Pages generated successfully (v2)"
        echo ""
        print_info "Landing page created at: docs/index.html (static HTML)"
        print_info "Sprint data created at: docs/sprints-data.json"
        print_info ".nojekyll file created at: docs/.nojekyll"

        # Git operations
        commit_and_push_to_github
    else
        print_warning "GitHub Pages generation encountered issues - check log"
        print_info "You can manually generate later: ./scripts/publish/generate-pages-v2.sh"
        return 1
    fi
}

commit_and_push_to_github() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_warning "Not a git repository - pages generated but not published"
        return 1
    fi

    print_progress "Publishing to GitHub Pages..."

    # Stage files
    git add docs/index.html docs/sprints-data.json docs/.nojekyll >> "$LOG_FILE" 2>&1

    # Copy reports
    if [ -d "reports" ]; then
        mkdir -p docs/reports
        find reports -name "sprint-*-final-report.*" -type f -exec cp {} docs/reports/ \; 2>> "$LOG_FILE"
        git add docs/reports/ >> "$LOG_FILE" 2>&1
    fi

    # Commit
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    local sprint_count
    sprint_count=$(find sprints -name "*.md" -type f 2>/dev/null | wc -l)
    local report_count
    report_count=$(find reports -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

    if git commit -m "docs: Update GitHub Pages - $timestamp

- Automated research results publication
- Generated from run-full.sh
- Sprints completed: $sprint_count
- Reports: $report_count

🤖 Generated with Strategic Research Automation" >> "$LOG_FILE" 2>&1; then
        print_success "Changes committed"

        # Push
        local current_branch
        current_branch=$(git branch --show-current)
        if git push origin "$current_branch" >> "$LOG_FILE" 2>&1; then
            print_success "Changes pushed to GitHub"

            # Enable GitHub Pages
            enable_github_pages_if_needed "$current_branch"
        else
            print_warning "Push failed - publish manually: git push origin $current_branch"
        fi
    else
        print_success "GitHub Pages already up to date"
    fi
}

enable_github_pages_if_needed() {
    local branch="$1"

    # Extract GitHub user and repo from git remote
    local repo_url
    repo_url=$(git config --get remote.origin.url 2>/dev/null | sed 's/\.git$//' | sed 's|git@github.com:|https://github.com/|')
    if [[ "$repo_url" =~ github.com/([^/]+)/([^/]+) ]]; then
        local github_user="${BASH_REMATCH[1]}"
        local repo_name="${BASH_REMATCH[2]}"

        # Ensure GitHub CLI is ready
        if ensure_github_cli_ready; then
            # Enable GitHub Pages
            if enable_github_pages "$github_user" "$repo_name" "$branch" "/docs"; then
                echo ""
                local pages_url
                pages_url=$(get_github_pages_url "$github_user" "$repo_name")
                echo -e "${BOLD}${CYAN}Your research is now live at:${NC}"
                echo -e "${BOLD}${CYAN}  → $pages_url${NC}"
                echo ""
                print_info "First-time publishing may take 2-3 minutes to deploy"
            fi
        else
            print_warning "GitHub CLI not ready - enable Pages manually"
            print_info "GitHub repo Settings → Pages → Source: $branch, /docs"
        fi
    fi
}

# ============================================================================
# Main Execution
# ============================================================================

main() {
    # Change to project root
    cd "$PROJECT_ROOT"

    # Execute workflow
    collect_user_input
    setup_context_files
    execute_research
    deploy_to_github_pages

    # Final summary
    print_section "AUTOMATION COMPLETE!" "$GREEN"
    echo "Finished at: $(date)"
    echo ""
    print_success "All tasks completed successfully!"
    echo ""
}

# Run main function
main "$@"
