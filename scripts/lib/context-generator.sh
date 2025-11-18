#!/usr/bin/env bash
#
# Context File Generator
# Single Responsibility: Generate context files for Claude research
#
# Usage: source scripts/lib/context-generator.sh

set -e

#
# Generate company profile context file
#
# Arguments:
#   $1 - Company information (raw user input)
#   $2 - Output file path (default: context/company-profile.md)
#
generate_company_context() {
    local company_info="$1"
    local output_file="${2:-context/company-profile.md}"

    mkdir -p "$(dirname "$output_file")"

    cat > "$output_file" <<EOF
# Company Profile

## Raw Information Provided

$company_info

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
}

#
# Generate client information context file
#
# Arguments:
#   $1 - Client information (raw user input)
#   $2 - Additional context (optional)
#   $3 - Output file path (default: context/client-info.md)
#
generate_client_context() {
    local client_info="$1"
    local additional_context="$2"
    local output_file="${3:-context/client-info.md}"

    mkdir -p "$(dirname "$output_file")"

    cat > "$output_file" <<EOF
# Client Information

## Raw Information Provided

$client_info

${additional_context:+## Additional Context

$additional_context}

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
}

#
# Generate industry background context file
#
# Arguments:
#   $1 - Output file path (default: context/industry-background.md)
#
generate_industry_context() {
    local output_file="${1:-context/industry-background.md}"

    mkdir -p "$(dirname "$output_file")"

    cat > "$output_file" <<'EOF'
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
}

#
# Generate all context files at once
#
# Arguments:
#   $1 - Company information
#   $2 - Client information
#   $3 - Additional context (optional)
#
generate_all_contexts() {
    local company_info="$1"
    local client_info="$2"
    local additional_context="$3"

    generate_company_context "$company_info"
    generate_client_context "$client_info" "$additional_context"
    generate_industry_context
}
