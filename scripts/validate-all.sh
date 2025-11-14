#!/bin/bash
# Validate quality standards for all sprints
# Usage: ./validate-all.sh

set -e

# Use CLAUDE_CMD environment variable or default to 'claude'
CLAUDE_CMD="${CLAUDE_CMD:-claude}"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  Quality Validation Pipeline                                  ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Find all sprint directories
if [ ! -d "sprints" ]; then
  echo "✗ No sprints directory found"
  exit 1
fi

mapfile -t SPRINT_DIRS < <(find sprints -maxdepth 1 -type d -name "[0-9]*" 2>/dev/null | sort)

if [ ${#SPRINT_DIRS[@]} -eq 0 ]; then
  echo "✗ No sprint directories found"
  exit 1
fi

echo "Found ${#SPRINT_DIRS[@]} sprints to validate"
echo ""

# Track failed sprints
FAILED_SPRINTS=()
PASSED_SPRINTS=()

# Validate each sprint
for sprint_dir in "${SPRINT_DIRS[@]}"; do
  SPRINT_NUM=$(basename "$sprint_dir" | grep -oE '^[0-9]+')

  echo "→ Validating Sprint $SPRINT_NUM..."

  if $CLAUDE_CMD -p "/validate-quality $SPRINT_NUM" \
    --output-format json \
    --allowedTools "*" \
    | jq -r '.text' 2>/dev/null | grep -q "PASS\|✓\|valid"; then
    echo "  ✓ Sprint $SPRINT_NUM passed"
    PASSED_SPRINTS+=("$SPRINT_NUM")
  else
    echo "  ✗ Sprint $SPRINT_NUM failed"
    FAILED_SPRINTS+=("$SPRINT_NUM")
  fi
done

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  Validation Summary                                           ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "PASSED: ${#PASSED_SPRINTS[@]}/${#SPRINT_DIRS[@]}"
echo "FAILED: ${#FAILED_SPRINTS[@]}/${#SPRINT_DIRS[@]}"
echo ""

if [ ${#FAILED_SPRINTS[@]} -gt 0 ]; then
  echo "Failed sprints:"
  for sprint in "${FAILED_SPRINTS[@]}"; do
    echo "  - Sprint $sprint"
  done
  echo ""
  exit 1
else
  echo "✓ All sprints passed quality validation"
  exit 0
fi
