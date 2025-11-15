#!/bin/bash
# Complete strategic research automation with manual sprint definitions
# Usage: ./run-complete-analysis.sh "Project Name" "Industry" "Company Name" "sprint1|desc1" "sprint2|desc2" ...

set -e

# Use CLAUDE_CMD environment variable or default to YOLO mode (claude-eng)
CLAUDE_CMD="${CLAUDE_CMD:-./scripts/setup/claude-eng}"

# Validate arguments before shift
if [ $# -lt 4 ]; then
  echo "Usage: $0 \"Project Name\" \"Industry\" \"Company Name\" \"sprint1|description1\" [\"sprint2|desc2\" ...]"
  echo ""
  echo "Example:"
  echo "  $0 \"Industry Regulation XYZ Analysis\" \"technology\" \"TechCo\" \\"
  echo "    \"operation Control|advanced verification of operation control\" \\"
  echo "    \"Collision Avoidance|Verified collision avoidance system\""
  exit 1
fi

PROJECT_NAME="$1"
INDUSTRY="$2"
COMPANY_NAME="$3"
shift 3

SPRINT_DEFS=("$@")

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  Strategic Research Automation Pipeline                      ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Project: $PROJECT_NAME"
echo "Industry: $INDUSTRY"
echo "Company: $COMPANY_NAME"
echo "Sprints: ${#SPRINT_DEFS[@]}"
echo "Claude Command: $CLAUDE_CMD"
echo ""

# Step 1: Initialize project
echo "→ [1/6] Initializing project..."
$CLAUDE_CMD -p "/init-project \"$PROJECT_NAME\" \"$INDUSTRY\" \"$COMPANY_NAME\"" \
  --output-format json \
  --allowedTools "*" \
  | jq -r '.text' 2>/dev/null || { echo "✗ Initialization failed"; exit 1; }
echo "✓ Project initialized"

# Step 2: Update context files (templates)
echo ""
echo "→ [2/6] Configuring context..."
echo "✓ Context files created (please populate manually)"

# Step 3: Create sprints
echo ""
echo "→ [3/6] Creating ${#SPRINT_DEFS[@]} sprints..."
SPRINT_NUM=1
for sprint_def in "${SPRINT_DEFS[@]}"; do
  IFS='|' read -r SPRINT_NAME SPRINT_DESC <<< "$sprint_def"

  echo "  Creating Sprint $(printf "%02d" "$SPRINT_NUM"): $SPRINT_NAME"

  $CLAUDE_CMD -p "/create-sprint $(printf "%02d" "$SPRINT_NUM") \"$SPRINT_NAME\" \"$SPRINT_DESC\"" \
    --output-format json \
    --allowedTools "*" \
    | jq -r '.text' 2>/dev/null || { echo "  ✗ Failed"; exit 1; }

  echo "  ✓ Sprint $(printf "%02d" "$SPRINT_NUM") created"
  SPRINT_NUM=$((SPRINT_NUM + 1))
done
echo "✓ All sprints created"

# Step 4: Execute all sprints
echo ""
echo "→ [4/6] Executing all sprints (parallel)..."
echo "  Estimated time: 2-4 hours"
echo "  Timestamp: $(date)"
START_TIME=$(date +%s)

$CLAUDE_CMD -p "/execute-all" \
  --output-format stream-json \
  --allowedTools "*" \
  --model sonnet \
  | while IFS= read -r line; do
      echo "$line" | jq -r 'select(.type == "text") | .text' 2>/dev/null || true
    done || { echo "✗ Execution failed"; exit 1; }

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
echo "✓ All sprints executed in $((DURATION / 60)) minutes"

# Step 5: Compare sprints
echo ""
echo "→ [5/6] Comparing and prioritizing sprints..."
$CLAUDE_CMD -p "/compare-sprints" \
  --output-format json \
  --allowedTools "*" \
  | jq -r '.text' 2>/dev/null || { echo "✗ Comparison failed"; exit 1; }
echo "✓ Comparative analysis complete"

# Step 6: Finalize release
echo ""
echo "→ [6/6] Creating git release..."
$CLAUDE_CMD -p "/finalize-release v1.0" \
  --output-format json \
  --allowedTools "*" \
  | jq -r '.text' 2>/dev/null || { echo "✗ Release failed"; exit 1; }
echo "✓ Release v1.0 created"

# Summary
echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  ✓ COMPLETE                                                   ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Deliverables:"
echo "  - Research files: temp/*/"
echo "  - Strategic reports: reports/*-report.md"
echo "  - Comparative analysis: reports/00-sprint-comparison.md"
echo "  - Git release: v1.0"
echo ""
echo "Next steps:"
echo "  1. Review reports/ directory"
echo "  2. Examine top-priority sprints"
echo "  3. Share findings with stakeholders"
