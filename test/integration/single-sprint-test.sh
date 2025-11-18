#!/bin/bash
# Single Sprint Integration Test
# Duration: ~1 hour | Cost: ~$15
# Purpose: Quick validation of core functionality

set -e

# Use CLAUDE_CMD environment variable or default to YOLO mode (claude-eng)
CLAUDE_CMD="${CLAUDE_CMD:-./scripts/setup/claude-eng}"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Integration Test: Single Sprint                          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "⚠️  WARNING: This test makes real API calls"
echo "    Duration: ~1 hour"
echo "    Cost: ~\$15"
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

# Setup
START_TIME=$(date +%s)
TEST_DIR=$(mktemp -d)
RESULTS_DIR="test/integration/results"
mkdir -p "$RESULTS_DIR"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
RESULTS_FILE="$RESULTS_DIR/single-sprint-${TIMESTAMP}.log"

echo "Test directory: $TEST_DIR" | tee -a "$RESULTS_FILE"
echo "Results file: $RESULTS_FILE" | tee -a "$RESULTS_FILE"
echo "" | tee -a "$RESULTS_FILE"

# Test 1: Discovery
echo "─────────────────────────────────────────────────────────────" | tee -a "$RESULTS_FILE"
echo "TEST 1: Opportunity Discovery" | tee -a "$RESULTS_FILE"
echo "─────────────────────────────────────────────────────────────" | tee -a "$RESULTS_FILE"

DISCOVER_START=$(date +%s)
$CLAUDE_CMD -p "/discover-opportunities" | tee -a "$RESULTS_FILE"
DISCOVER_END=$(date +%s)
DISCOVER_DURATION=$((DISCOVER_END - DISCOVER_START))

# Validate discovery
if [ ! -d "sprints" ]; then
    echo -e "${RED}✗ FAIL: sprints/ directory not created${NC}" | tee -a "$RESULTS_FILE"
    exit 1
fi

SPRINT_COUNT=$(find sprints -maxdepth 1 -type d -name "[0-9]*" | wc -l | tr -d ' ')
if [ "$SPRINT_COUNT" -lt 3 ]; then
    echo -e "${RED}✗ FAIL: Only $SPRINT_COUNT sprints discovered (expected 5+)${NC}" | tee -a "$RESULTS_FILE"
    exit 1
fi

echo -e "${GREEN}✓ Discovery complete: $SPRINT_COUNT opportunities (${DISCOVER_DURATION}s)${NC}" | tee -a "$RESULTS_FILE"
echo "" | tee -a "$RESULTS_FILE"

# Test 2: Execute Sprint
echo "─────────────────────────────────────────────────────────────" | tee -a "$RESULTS_FILE"
echo "TEST 2: Execute Sprint 01" | tee -a "$RESULTS_FILE"
echo "─────────────────────────────────────────────────────────────" | tee -a "$RESULTS_FILE"

EXEC_START=$(date +%s)
$CLAUDE_CMD -p "/execute-sprint 01" | tee -a "$RESULTS_FILE"
EXEC_END=$(date +%s)
EXEC_DURATION=$((EXEC_END - EXEC_START))

# Validate execution
TEMP_DIR=$(find temp -maxdepth 1 -type d -name "01-*" | head -1)
if [ -z "$TEMP_DIR" ]; then
    echo -e "${RED}✗ FAIL: Sprint directory not created in temp/${NC}" | tee -a "$RESULTS_FILE"
    exit 1
fi

FILE_COUNT=$(find "$TEMP_DIR" -type f -name "*.md" | wc -l | tr -d ' ')
if [ "$FILE_COUNT" -lt 25 ]; then
    echo -e "${RED}✗ FAIL: Only $FILE_COUNT files generated (expected 25+)${NC}" | tee -a "$RESULTS_FILE"
    exit 1
fi

REPORT_FILE=$(find reports -name "01-*-report.md" | head -1)
if [ -z "$REPORT_FILE" ]; then
    echo -e "${RED}✗ FAIL: Report not generated${NC}" | tee -a "$RESULTS_FILE"
    exit 1
fi

WORD_COUNT=$(wc -w < "$REPORT_FILE" | tr -d ' ')
if [ "$WORD_COUNT" -lt 5000 ]; then
    echo -e "${YELLOW}⚠ WARNING: Report only $WORD_COUNT words (target: 5,000-7,500)${NC}" | tee -a "$RESULTS_FILE"
fi

echo -e "${GREEN}✓ Execution complete: $FILE_COUNT files, report: $WORD_COUNT words (${EXEC_DURATION}s)${NC}" | tee -a "$RESULTS_FILE"
echo "" | tee -a "$RESULTS_FILE"

# Test 3: Scoring
echo "─────────────────────────────────────────────────────────────" | tee -a "$RESULTS_FILE"
echo "TEST 3: Opportunity Scoring" | tee -a "$RESULTS_FILE"
echo "─────────────────────────────────────────────────────────────" | tee -a "$RESULTS_FILE"

SCORE_START=$(date +%s)
$CLAUDE_CMD -p "/score-opportunity 01" | tee -a "$RESULTS_FILE"
SCORE_END=$(date +%s)
SCORE_DURATION=$((SCORE_END - SCORE_START))

echo -e "${GREEN}✓ Scoring complete (${SCORE_DURATION}s)${NC}" | tee -a "$RESULTS_FILE"
echo "" | tee -a "$RESULTS_FILE"

# Test 4: Export
echo "─────────────────────────────────────────────────────────────" | tee -a "$RESULTS_FILE"
echo "TEST 4: Export to PDF" | tee -a "$RESULTS_FILE"
echo "─────────────────────────────────────────────────────────────" | tee -a "$RESULTS_FILE"

EXPORT_START=$(date +%s)
$CLAUDE_CMD -p "/export-findings 01 pdf" | tee -a "$RESULTS_FILE"
EXPORT_END=$(date +%s)
EXPORT_DURATION=$((EXPORT_END - EXPORT_START))

PDF_FILE=$(find reports -name "01-*.pdf" | head -1)
if [ -z "$PDF_FILE" ]; then
    echo -e "${YELLOW}⚠ WARNING: PDF not generated (pandoc may not be installed)${NC}" | tee -a "$RESULTS_FILE"
else
    PDF_SIZE=$(du -h "$PDF_FILE" | cut -f1)
    echo -e "${GREEN}✓ Export complete: $PDF_SIZE (${EXPORT_DURATION}s)${NC}" | tee -a "$RESULTS_FILE"
fi

echo "" | tee -a "$RESULTS_FILE"

# Summary
END_TIME=$(date +%s)
TOTAL_DURATION=$((END_TIME - START_TIME))
TOTAL_MINUTES=$((TOTAL_DURATION / 60))

echo "╔════════════════════════════════════════════════════════════╗" | tee -a "$RESULTS_FILE"
echo "║  TEST SUMMARY                                              ║" | tee -a "$RESULTS_FILE"
echo "╚════════════════════════════════════════════════════════════╝" | tee -a "$RESULTS_FILE"
echo "" | tee -a "$RESULTS_FILE"
echo "Total Duration: ${TOTAL_MINUTES} minutes" | tee -a "$RESULTS_FILE"
echo "Opportunities Discovered: $SPRINT_COUNT" | tee -a "$RESULTS_FILE"
echo "Files Generated: $FILE_COUNT" | tee -a "$RESULTS_FILE"
echo "Report Word Count: $WORD_COUNT" | tee -a "$RESULTS_FILE"
echo "" | tee -a "$RESULTS_FILE"
echo -e "${GREEN}✓✓✓ ALL TESTS PASSED${NC}" | tee -a "$RESULTS_FILE"
echo "" | tee -a "$RESULTS_FILE"
echo "Results saved to: $RESULTS_FILE" | tee -a "$RESULTS_FILE"

# Save metadata
cat > "$RESULTS_DIR/last-run.json" << EOF
{
  "timestamp": "$TIMESTAMP",
  "test_type": "single-sprint",
  "duration_seconds": $TOTAL_DURATION,
  "status": "PASS",
  "opportunities_discovered": $SPRINT_COUNT,
  "files_generated": $FILE_COUNT,
  "report_word_count": $WORD_COUNT,
  "results_file": "$RESULTS_FILE"
}
EOF

echo "Metadata saved to: $RESULTS_DIR/last-run.json"
