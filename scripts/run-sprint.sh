#!/bin/bash
# Execute a single sprint with quality validation and scoring
# Usage: ./run-sprint.sh [sprint-number]

set -e

# Use CLAUDE_CMD environment variable or default to YOLO mode (claude-eng)
CLAUDE_CMD="${CLAUDE_CMD:-./scripts/setup/claude-eng}"

SPRINT_NUM="$1"

if [ -z "$SPRINT_NUM" ]; then
  echo "Usage: $0 [sprint-number]"
  echo ""
  echo "Examples:"
  echo "  $0 01    # Execute sprint 01"
  echo "  $0 05    # Execute sprint 05"
  exit 1
fi

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  EXECUTING SPRINT $SPRINT_NUM                                     ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Execute sprint
echo "→ Executing Sprint $SPRINT_NUM..."
START_TIME=$(date +%s)

$CLAUDE_CMD -p "/execute-sprint $SPRINT_NUM" \
  --output-format stream-json \
  --allowedTools "*" \
  | while IFS= read -r line; do
      echo "$line" | jq -r 'select(.type == "text") | .text' 2>/dev/null || true
    done

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo ""
echo "✓ Sprint $SPRINT_NUM completed in $((DURATION / 60)) minutes"

# Validate quality
echo ""
echo "→ Validating quality standards..."
$CLAUDE_CMD -p "/validate-quality $SPRINT_NUM" \
  --output-format json \
  --allowedTools "*" \
  | jq -r '.text' 2>/dev/null || echo "Quality validation completed"

# Score opportunity
echo ""
echo "→ Scoring opportunity..."
$CLAUDE_CMD -p "/score-opportunity $SPRINT_NUM" \
  --output-format json \
  --allowedTools "*" \
  | jq -r '.text' 2>/dev/null || echo "Scoring completed"

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  ✓ Sprint $SPRINT_NUM Complete                                   ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
