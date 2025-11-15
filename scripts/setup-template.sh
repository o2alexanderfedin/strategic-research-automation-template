#!/usr/bin/env bash
# Strategic Research Automation Template Setup Script
# Version: 2.0.0
# Description: Interactive setup wizard for initializing strategic research methodology

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print colored messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_highlight() {
    echo -e "${CYAN}${BOLD}$1${NC}"
}

# Function to print header
print_header() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   Strategic Research Automation Setup Wizard          ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Function to validate non-empty input
validate_not_empty() {
    local input="$1"
    local field_name="$2"

    while [ -z "$input" ]; do
        print_error "$field_name cannot be empty"
        read -p "$field_name: " input
    done

    echo "$input"
}

# Function to escape special characters for sed replacement
# Escapes: & (means "matched text"), / (alternative delimiter), and \ (escape char)
escape_for_sed() {
    echo "$1" | sed 's/[&/\]/\\&/g'
}

# Function to detect project mode
detect_mode() {
    if [ -d ".git" ] && [ -f "README.md" ] && [ ! -f "TEMPLATE_STRATEGY.md" ]; then
        echo "existing"
    else
        echo "new"
    fi
}

# Function to check dependencies
check_dependencies() {
    print_info "Checking dependencies..."

    local missing=0

    # Required
    if ! command -v git &> /dev/null; then
        print_error "git is required but not installed"
        missing=1
    else
        print_success "git found"
    fi

    # Optional but recommended
    if ! command -v pandoc &> /dev/null; then
        print_warning "pandoc recommended for PDF/DOCX export (optional)"
    else
        print_success "pandoc found"
    fi

    if ! command -v yamllint &> /dev/null; then
        print_warning "yamllint recommended for config validation (optional)"
    else
        print_success "yamllint found"
    fi

    if [ $missing -eq 1 ]; then
        print_error "Please install missing dependencies and re-run setup"
        exit 1
    fi

    echo ""
}

# Main setup function
main() {
    print_header

    # Check dependencies first
    check_dependencies

    # Detect mode
    MODE=$(detect_mode)

    if [ "$MODE" = "existing" ]; then
        print_warning "Detected: Existing project"
        print_info "This will add strategic research automation to your existing project"
        echo ""
        read -p "Continue? (y/n): " CONTINUE
        if [ "$CONTINUE" != "y" ]; then
            print_error "Setup cancelled"
            exit 0
        fi
    else
        print_success "Mode: New research project"
    fi

    echo ""
    print_info "Please answer the following questions to customize your project:"
    echo ""

    # Gather project information
    read -p "Project name: " PROJECT_NAME
    PROJECT_NAME=$(validate_not_empty "$PROJECT_NAME" "Project name")

    read -p "Company name (your consulting firm): " COMPANY_NAME
    COMPANY_NAME=$(validate_not_empty "$COMPANY_NAME" "Company name")

    read -p "Client name (or press Enter to skip): " CLIENT_NAME
    if [ -z "$CLIENT_NAME" ]; then
        CLIENT_NAME="Internal"
    fi

    # Industry selection with descriptions
    echo ""
    print_highlight "Select industry:"
    echo "  1. technology (advanced system, certification, aerospace)"
    echo "  2. Healthcare (EHR, digital health, medical devices)"
    echo "  3. FinTech (RegTech, payments, compliance)"
    echo "  4. SaaS (product-market fit, enterprise software)"
    echo "  5. Manufacturing (supply chain, automation, IoT)"
    echo "  6. Energy (renewables, grid modernization)"
    echo "  7. Automotive (autonomous vehicles, EV, connectivity)"
    echo "  8. Telecommunications (5G, network infrastructure)"
    echo "  9. Retail (e-commerce, omnichannel, logistics)"
    echo "  10. Other (custom industry)"
    read -p "Choice [1-10]: " INDUSTRY_CHOICE

    case $INDUSTRY_CHOICE in
        1) INDUSTRY="technology" ;;
        2) INDUSTRY="healthcare" ;;
        3) INDUSTRY="fintech" ;;
        4) INDUSTRY="saas" ;;
        5) INDUSTRY="manufacturing" ;;
        6) INDUSTRY="energy" ;;
        7) INDUSTRY="automotive" ;;
        8) INDUSTRY="telecommunications" ;;
        9) INDUSTRY="retail" ;;
        10)
            read -p "Enter industry name: " INDUSTRY
            INDUSTRY=$(echo "$INDUSTRY" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
            ;;
        *)
            print_warning "Invalid choice, using 'other'"
            INDUSTRY="other"
            ;;
    esac

    # Research focus selection
    echo ""
    print_highlight "Select primary research focus:"
    echo "  1. Market Analysis (TAM/SAM/SOM, segments, trends)"
    echo "  2. Technology Assessment (feasibility, architecture, roadmap)"
    echo "  3. Due Diligence (investment evaluation, risk assessment)"
    echo "  4. Competitive Intelligence (competitors, positioning)"
    echo "  5. Regulatory Compliance (certification, standards, testing)"
    echo "  6. Strategic Partnerships (ecosystem mapping, alliances)"
    echo "  7. Product-Market Fit (validation, features, GTM strategy)"
    echo "  8. Market Entry (strategy, localization, distribution)"
    echo "  9. Innovation Assessment (emerging tech, disruption)"
    echo "  10. Comprehensive (full strategic analysis)"
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
        *)
            print_warning "Invalid choice, using 'comprehensive'"
            RESEARCH_FOCUS="comprehensive"
            ;;
    esac

    # Output preferences
    echo ""
    read -p "Output format (markdown/pdf/docx/all) [all]: " OUTPUT_FORMAT
    OUTPUT_FORMAT=${OUTPUT_FORMAT:-all}

    read -p "Detail level (executive/detailed/comprehensive) [detailed]: " DETAIL_LEVEL
    DETAIL_LEVEL=${DETAIL_LEVEL:-detailed}

    echo ""
    print_info "Configuration summary:"
    echo "  Project: $PROJECT_NAME"
    echo "  Company: $COMPANY_NAME"
    echo "  Client: $CLIENT_NAME"
    echo "  Industry: $INDUSTRY"
    echo "  Research Focus: $RESEARCH_FOCUS"
    echo "  Output Format: $OUTPUT_FORMAT"
    echo "  Detail Level: $DETAIL_LEVEL"
    echo ""
    read -p "Proceed with this configuration? (y/n): " CONFIRM
    if [ "$CONFIRM" != "y" ]; then
        print_error "Setup cancelled"
        exit 0
    fi

    # Industry-specific setup
    echo ""
    if [ -d "templates/$INDUSTRY" ]; then
        print_info "Applying $INDUSTRY industry template..."

        # Copy industry-specific config
        if [ -d "templates/$INDUSTRY/config" ]; then
            cp -r templates/$INDUSTRY/config/* config/ 2>/dev/null || true
            print_success "Applied $INDUSTRY configuration"
        fi

        # Copy industry-specific context examples
        if [ -d "templates/$INDUSTRY/context" ]; then
            cp -r templates/$INDUSTRY/context/* context/ 2>/dev/null || true
            print_success "Applied $INDUSTRY context templates"
        fi

        # Copy industry-specific glossary
        if [ -f "templates/$INDUSTRY/glossary.yml" ]; then
            cp templates/$INDUSTRY/glossary.yml config/glossary.yml
            print_success "Applied $INDUSTRY terminology"
        fi
    else
        print_warning "Using generic template for $INDUSTRY"
    fi

    # Replace placeholders in config files
    print_info "Customizing configuration files..."

    # Escape special characters in variables for sed
    PROJECT_NAME_ESC=$(escape_for_sed "$PROJECT_NAME")
    COMPANY_NAME_ESC=$(escape_for_sed "$COMPANY_NAME")
    CLIENT_NAME_ESC=$(escape_for_sed "$CLIENT_NAME")
    INDUSTRY_ESC=$(escape_for_sed "$INDUSTRY")
    RESEARCH_FOCUS_ESC=$(escape_for_sed "$RESEARCH_FOCUS")
    OUTPUT_FORMAT_ESC=$(escape_for_sed "$OUTPUT_FORMAT")
    DETAIL_LEVEL_ESC=$(escape_for_sed "$DETAIL_LEVEL")

    find config -type f \( -name "*.yml" -o -name "*.yaml" \) 2>/dev/null | while IFS= read -r file; do
        if [ -f "$file" ]; then
            temp_file="${file}.tmp"
            sed \
                -e "s|{{PROJECT_NAME}}|$PROJECT_NAME_ESC|g" \
                -e "s|{{COMPANY_NAME}}|$COMPANY_NAME_ESC|g" \
                -e "s|{{CLIENT_NAME}}|$CLIENT_NAME_ESC|g" \
                -e "s|{{INDUSTRY}}|$INDUSTRY_ESC|g" \
                -e "s|{{RESEARCH_FOCUS}}|$RESEARCH_FOCUS_ESC|g" \
                -e "s|{{OUTPUT_FORMAT}}|$OUTPUT_FORMAT_ESC|g" \
                -e "s|{{DETAIL_LEVEL}}|$DETAIL_LEVEL_ESC|g" \
                "$file" > "$temp_file"
            mv "$temp_file" "$file"
        fi
    done

    print_success "Configuration files customized"

    # Create context files from examples
    print_info "Creating context files..."

    mkdir -p context

    if [ -f "context/company-profile.md.example" ]; then
        sed \
            -e "s|{{COMPANY_NAME}}|$COMPANY_NAME_ESC|g" \
            -e "s|{{INDUSTRY}}|$INDUSTRY_ESC|g" \
            context/company-profile.md.example > context/company-profile.md
        print_success "Created context/company-profile.md"
    elif [ ! -f "context/company-profile.md" ]; then
        # Create from scratch if no example exists
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
        print_success "Created context/company-profile.md"
    fi

    if [ -f "context/client-info.md.example" ]; then
        sed \
            -e "s|{{CLIENT_NAME}}|$CLIENT_NAME_ESC|g" \
            -e "s|{{INDUSTRY}}|$INDUSTRY_ESC|g" \
            context/client-info.md.example > context/client-info.md
        print_success "Created context/client-info.md"
    elif [ ! -f "context/client-info.md" ]; then
        # Create from scratch if no example exists
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
        print_success "Created context/client-info.md"
    fi

    if [ -f "context/industry-background.md.example" ]; then
        sed \
            -e "s|{{INDUSTRY}}|$INDUSTRY_ESC|g" \
            context/industry-background.md.example > context/industry-background.md
        print_success "Created context/industry-background.md"
    elif [ ! -f "context/industry-background.md" ]; then
        # Create from scratch if no example exists
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
        print_success "Created context/industry-background.md"
    fi

    # Update CLAUDE.md if it exists
    if [ -f "CLAUDE.md" ]; then
        print_info "Customizing CLAUDE.md..."
        temp_file="CLAUDE.md.tmp"
        sed \
            -e "s|{{PROJECT_NAME}}|$PROJECT_NAME_ESC|g" \
            -e "s|{{COMPANY_NAME}}|$COMPANY_NAME_ESC|g" \
            -e "s|{{INDUSTRY}}|$INDUSTRY_ESC|g" \
            "CLAUDE.md" > "$temp_file"
        mv "$temp_file" "CLAUDE.md"
        print_success "CLAUDE.md customized"
    fi

    # Create directory structure
    print_info "Creating directory structure..."
    mkdir -p sprints
    mkdir -p temp
    mkdir -p reports
    print_success "Directory structure created"

    # Copy .env.example to .env if it doesn't exist
    if [ -f ".env.example" ] && [ ! -f ".env" ]; then
        cp .env.example .env
        print_success "Created .env from template"
        print_info "Review .env for optional configuration (API key not required if using Claude Code CLI auth)"
    fi

    # Remove template-specific files
    print_info "Cleaning up template files..."
    rm -f TEMPLATE_STRATEGY.md
    rm -f cookiecutter.json
    rm -rf templates/
    rm -f context/*.example
    print_success "Template files removed"

    # Git operations
    if command -v git &> /dev/null; then
        if [ "$MODE" = "new" ]; then
            print_info "Initializing git repository..."

            if [ ! -d ".git" ]; then
                git init
                print_success "Git initialized"
            fi

            # Create initial commit
            print_info "Creating initial commit..."
            git add .
            git commit -m "feat: Initialize strategic research automation

Project: $PROJECT_NAME
Company: $COMPANY_NAME
Client: $CLIENT_NAME
Industry: $INDUSTRY
Research Focus: $RESEARCH_FOCUS

Setup includes:
- 8 specialized AI research skills
- 13 workflow slash commands
- Industry-specific configuration ($INDUSTRY)
- Quality standards and scoring rubric
- Complete documentation

Generated with Strategic Research Automation Template
https://github.com/o2alexanderfedin/strategic-research-automation-template" || print_warning "Commit skipped - may already exist"

            print_success "Git repository initialized"
        else
            print_info "Adding research automation to existing project..."

            # Stage research automation files
            git add .claude config context scripts 2>/dev/null || true

            # Create commit
            git commit -m "feat: Add strategic research automation

Added strategic research automation infrastructure:
- AI-powered research skills (.claude/skills/)
- Workflow slash commands (.claude/commands/)
- Configuration and quality standards (config/)
- Context structure (context/)
- Automation scripts (scripts/)

Project: $PROJECT_NAME
Industry: $INDUSTRY
Research Focus: $RESEARCH_FOCUS

Generated with Strategic Research Automation Template
https://github.com/o2alexanderfedin/strategic-research-automation-template" || print_warning "Commit skipped - no changes or already committed"

            print_success "Research automation added to project"
        fi
    else
        print_warning "Git not found - skipping git operations"
    fi

    # Print success message and next steps
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              Setup Complete! 🎉                        ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""

    print_success "Your strategic research framework is ready!"
    echo ""

    print_info "Next steps:"
    echo ""
    echo -e "${BOLD}1. Verify Claude Code authentication:${NC}"
    echo "   - If not already authenticated, run: claude auth"
    echo "   - Or set ANTHROPIC_API_KEY in .env (see .env for details)"
    echo ""
    echo -e "${BOLD}2. Enhance context files:${NC}"
    echo "   - vim context/company-profile.md"
    echo "   - vim context/client-info.md"
    echo "   - vim context/industry-background.md"
    echo ""
    echo -e "${BOLD}3. Discover strategic opportunities:${NC}"
    echo "   - ./scripts/setup/claude-eng -p '/discover-opportunities'"
    echo ""
    echo -e "${BOLD}4. Execute your first research sprint:${NC}"
    echo "   - ./scripts/setup/claude-eng -p '/execute-sprint 01'"
    echo ""
    echo -e "${BOLD}5. Review and export results:${NC}"
    echo "   - Review: cat reports/01-*-report.md"
    echo "   - Export: ./scripts/setup/claude-eng -p '/export-findings 01 --format pdf'"
    echo ""

    print_info "Documentation:"
    echo "  - Quick Start: cat QUICK_START.md"
    echo "  - Full Guide: cat README.md"
    echo "  - Commands: cat docs/COMMANDS-REFERENCE.md"
    echo "  - Skills: cat docs/SKILLS-REFERENCE.md"
    echo ""

    print_success "Happy researching! Transform weeks into hours. 🚀"
    echo ""
}

# Run main function
main "$@"
