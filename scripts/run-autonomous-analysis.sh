#!/bin/bash
# Fully autonomous strategic research: Discovery + Execution
# Usage: ./run-autonomous-analysis.sh "Project Name" "Company Name" [client-source]

set -e

# Use CLAUDE_CMD environment variable or default to YOLO mode (claude-eng)
CLAUDE_CMD="${CLAUDE_CMD:-./scripts/setup/claude-eng}"

PROJECT_NAME="$1"
COMPANY_NAME="$2"
CLIENT_SOURCE="${3:-context/client-info.md}"

if [ -z "$PROJECT_NAME" ] || [ -z "$COMPANY_NAME" ]; then
  echo "Usage: $0 \"Project Name\" \"Company Name\" [client-info-file-or-url]"
  echo ""
  echo "Examples:"
  echo "  $0 \"Industry Regulation XYZ Analysis\" \"TechCo\" \"Industry Regulation XYZ_Final_Rule.pdf\""
  echo "  $0 \"Digital Health\" \"HealthTech\" \"https://example.com/client-brief.pdf\""
  echo "  $0 \"RegTech Opportunities\" \"FinServe\" \"context/finra-requirements.md\""
  exit 1
fi

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  FULLY AUTONOMOUS Strategic Research Pipeline                 ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Project: $PROJECT_NAME"
echo "Company: $COMPANY_NAME"
echo "Client Source: $CLIENT_SOURCE"
echo "Claude Command: $CLAUDE_CMD"
echo ""
echo "This script will:"
echo "  1. Discover strategic opportunities (Claude analyzes fit)"
echo "  2. Auto-generate sprint definitions"
echo "  3. Execute all sprints in parallel"
echo "  4. Synthesize findings and create release"
echo ""
echo "ZERO manual sprint definition required!"
echo ""

# Step 1: Initialize project
echo "→ [1/5] Initializing project..."
$CLAUDE_CMD -p "/init-project \"$PROJECT_NAME\" \"research\" \"$COMPANY_NAME\"" \
  --output-format json \
  --allowedTools "*" \
  | jq -r '.text' 2>/dev/null || { echo "✗ Initialization failed"; exit 1; }
echo "✓ Project initialized"

# Step 2: Setup context
echo ""
echo "→ [2/5] Setting up context..."

# Check for company profile
if [ -f "$HOME/.research-automation/companies/$COMPANY_NAME.md" ]; then
  echo "  Using cached company profile for $COMPANY_NAME"
  mkdir -p context
  cp "$HOME/.research-automation/companies/$COMPANY_NAME.md" context/company-profile.md
else
  echo "  ⚠ No cached company profile - using template"
  mkdir -p context
  cat > context/company-profile.md <<EOF
# Company Profile: $COMPANY_NAME

## Core Capabilities
[To be populated]

## Technology Stack
[List key technologies]

## Domain Expertise
[Industries and problem types]

## Competitive Advantages
[Unique differentiators]
EOF
fi

# Setup client context
if [ -f "$CLIENT_SOURCE" ]; then
  echo "  Using client info from: $CLIENT_SOURCE"
  cp "$CLIENT_SOURCE" context/client-info.md
elif [[ "$CLIENT_SOURCE" =~ ^https?:// ]]; then
  echo "  Fetching client info from URL: $CLIENT_SOURCE"
  curl -sL "$CLIENT_SOURCE" > context/client-info.md || {
    echo "  ✗ Failed to fetch URL"
    exit 1
  }
else
  echo "  ⚠ Client source not found - using template"
  cat > context/client-info.md <<EOF
# Client Information

## Overview
[Client or domain context]

## Industry
[Sector and market]

## Pain Points
[Problems that need solving]

## Regulatory Context
[Applicable regulations]
EOF
fi

echo "✓ Context configured"

# Step 3: Discover opportunities
echo ""
echo "→ [3/5] DISCOVERING STRATEGIC OPPORTUNITIES..."
echo "  Claude is analyzing $COMPANY_NAME capabilities × Client domain..."
echo "  This typically takes 2-5 minutes..."
echo ""

START_TIME=$(date +%s)

$CLAUDE_CMD -p "/discover-opportunities" \
  --output-format stream-json \
  --allowedTools "*" \
  --model sonnet \
  | while IFS= read -r line; do
      echo "$line" | jq -r 'select(.type == "text") | .text' 2>/dev/null || true
    done || { echo "✗ Discovery failed"; exit 1; }

END_TIME=$(date +%s)
DISCOVERY_DURATION=$((END_TIME - START_TIME))
echo ""
echo "✓ Opportunities discovered in $((DISCOVERY_DURATION / 60)) minutes"

# Verify opportunities were found
if [ ! -f "config/sprint-config.yml" ] || [ ! -s "config/sprint-config.yml" ]; then
  echo "✗ No opportunities discovered. Check context files for sufficient detail."
  exit 1
fi

SPRINT_COUNT=$(grep -c "^  - id:" config/sprint-config.yml 2>/dev/null || echo "0")
echo "  Found: $SPRINT_COUNT strategic opportunities"
echo ""

# Step 4: Execute all sprints
echo "→ [4/5] EXECUTING ALL DISCOVERED SPRINTS..."
echo "  Parallel execution of $SPRINT_COUNT sprints"
echo "  Estimated time: 2-4 hours"
echo "  Timestamp: $(date)"
echo ""

START_TIME=$(date +%s)

$CLAUDE_CMD -p "/execute-all" \
  --output-format stream-json \
  --allowedTools "*" \
  --model sonnet \
  | while IFS= read -r line; do
      echo "$line" | jq -r 'select(.type == "text") | .text' 2>/dev/null || true
    done || { echo "✗ Execution failed"; exit 1; }

END_TIME=$(date +%s)
EXECUTION_DURATION=$((END_TIME - START_TIME))
echo ""
echo "✓ All sprints executed in $((EXECUTION_DURATION / 60)) minutes"

# Step 5: Finalize release
echo ""
echo "→ [5/5] Creating final release..."
$CLAUDE_CMD -p "/finalize-release v1.0" \
  --output-format json \
  --allowedTools "*" \
  | jq -r '.text' 2>/dev/null || { echo "✗ Release failed"; exit 1; }
echo "✓ Release v1.0 created"

# Summary
TOTAL_TIME=$((EXECUTION_DURATION + DISCOVERY_DURATION))
echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  ✓ FULLY AUTONOMOUS EXECUTION COMPLETE                        ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Total execution time: $((TOTAL_TIME / 60)) minutes"
echo ""
echo "Deliverables:"
echo "  - Discovery report: reports/00-opportunity-discovery.md"
echo "  - Research files: temp/*/ ($SPRINT_COUNT sprints)"
echo "  - Strategic reports: reports/*-report.md ($SPRINT_COUNT reports)"
echo "  - Comparative analysis: reports/00-sprint-comparison.md"
echo "  - Git release: v1.0"
echo ""
echo "Summary preview:"
if [ -f "reports/00-opportunity-discovery.md" ]; then
  grep -A 2 "^### [0-9]" reports/00-opportunity-discovery.md 2>/dev/null | head -30 || true
fi
echo ""
echo "Next steps:"
echo "  1. Review reports/00-opportunity-discovery.md for strategic fit"
echo "  2. Review reports/ directory for detailed analyses"
echo "  3. Review reports/00-sprint-comparison.md for prioritization"
echo "  4. Share findings with stakeholders"
