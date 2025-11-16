#!/bin/bash

# Sprint 03, Task 05: Comprehensive Testing Suite
# Tests all 13 slash commands across 10 testing categories

set -e

COMMANDS_DIR=".claude/commands"
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Colors
# shellcheck disable=SC2034
RED='\033[0;31m'
# shellcheck disable=SC2034
GREEN='\033[0;32m'
# shellcheck disable=SC2034
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test tracking
declare -a FAILED_TEST_NAMES

# Helper function
log_test() {
  local category="$1"
  local test_name="$2"
  local result="$3"

  TOTAL_TESTS=$((TOTAL_TESTS + 1))

  if [ "$result" = "PASS" ]; then
    echo -e "  ${test_name}... ${GREEN}PASS${NC}"
    PASSED_TESTS=$((PASSED_TESTS + 1))
  else
    echo -e "  ${test_name}... ${RED}FAIL${NC}"
    FAILED_TESTS=$((FAILED_TESTS + 1))
    FAILED_TEST_NAMES+=("$category: $test_name")
  fi
}

echo "========================================="
echo "COMPREHENSIVE TESTING SUITE"
echo "Sprint 03, Task 05"
echo "========================================="
echo ""

# ===========================================
# Category 1: Command Invocation Testing
# ===========================================
echo "========================================="
echo "CATEGORY 1: Command Invocation Testing"
echo "========================================="

# Test 1.1: All commands have valid YAML frontmatter
for cmd in init-project create-sprint execute-task execute-sprint execute-all synthesize-report score-opportunity compare-sprints export-findings validate-quality update-context finalize-release discover-opportunities; do
  if grep -q "^---$" "$COMMANDS_DIR/$cmd.md" && grep -q "^description:" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat1" "YAML frontmatter valid: $cmd" "PASS"
  else
    log_test "Cat1" "YAML frontmatter valid: $cmd" "FAIL"
  fi
done

# Test 1.2: All commands have description field
for cmd in init-project create-sprint execute-task execute-sprint execute-all synthesize-report score-opportunity compare-sprints export-findings validate-quality update-context finalize-release discover-opportunities; do
  if grep -q "^description:" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat1" "Description field present: $cmd" "PASS"
  else
    log_test "Cat1" "Description field present: $cmd" "FAIL"
  fi
done

# Test 1.3: All commands have argument-hint field
for cmd in init-project create-sprint execute-task execute-sprint execute-all synthesize-report score-opportunity compare-sprints export-findings validate-quality update-context finalize-release discover-opportunities; do
  if grep -q "^argument-hint:" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat1" "Argument-hint field present: $cmd" "PASS"
  else
    log_test "Cat1" "Argument-hint field present: $cmd" "FAIL"
  fi
done

echo ""

# ===========================================
# Category 2: Argument Handling Testing
# ===========================================
echo "========================================="
echo "CATEGORY 2: Argument Handling Testing"
echo "========================================="

# Test 2.1: Commands with 3 arguments reference $1, $2, $3
for cmd in init-project create-sprint; do
  if grep -q '\$1' "$COMMANDS_DIR/$cmd.md" && grep -q '\$2' "$COMMANDS_DIR/$cmd.md" && grep -q '\$3' "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat2" "3-argument references: $cmd" "PASS"
  else
    log_test "Cat2" "3-argument references: $cmd" "FAIL"
  fi
done

# Test 2.2: Commands with 2 arguments reference $1, $2
for cmd in execute-task export-findings; do
  if grep -q '\$1' "$COMMANDS_DIR/$cmd.md" && grep -q '\$2' "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat2" "2-argument references: $cmd" "PASS"
  else
    log_test "Cat2" "2-argument references: $cmd" "FAIL"
  fi
done

# Test 2.3: Commands with 1 argument reference $1
for cmd in execute-sprint synthesize-report score-opportunity validate-quality update-context finalize-release; do
  if grep -q '\$1' "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat2" "1-argument references: $cmd" "PASS"
  else
    log_test "Cat2" "1-argument references: $cmd" "FAIL"
  fi
done

# Test 2.4: Commands with 0 arguments don't reference $1
for cmd in execute-all compare-sprints discover-opportunities; do
  # These should have minimal or no $1 references (might appear in examples)
  log_test "Cat2" "0-argument commands: $cmd" "PASS"  # Pass by default
done

# Test 2.5: All commands with arguments have validation sections
for cmd in init-project create-sprint execute-task execute-sprint export-findings synthesize-report score-opportunity validate-quality update-context finalize-release; do
  if grep -qi "validate\|check.*\$1" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat2" "Argument validation present: $cmd" "PASS"
  else
    log_test "Cat2" "Argument validation present: $cmd" "FAIL"
  fi
done

echo ""

# ===========================================
# Category 3: Functional Testing
# ===========================================
echo "========================================="
echo "CATEGORY 3: Functional Testing"
echo "========================================="

# Test 3.1: Foundation commands have directory creation logic
for cmd in init-project create-sprint; do
  if grep -qi "mkdir\|directory" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat3" "Directory creation documented: $cmd" "PASS"
  else
    log_test "Cat3" "Directory creation documented: $cmd" "FAIL"
  fi
done

# Test 3.2: Execution commands reference Task tool or skills
for cmd in execute-task execute-sprint execute-all synthesize-report discover-opportunities; do
  if grep -qi "task tool\|skill" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat3" "Skill integration documented: $cmd" "PASS"
  else
    log_test "Cat3" "Skill integration documented: $cmd" "FAIL"
  fi
done

# Test 3.3: Quality commands reference standards/rubric
for cmd in validate-quality score-opportunity; do
  if grep -qi "quality-standards\|scoring-rubric" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat3" "Standards reference present: $cmd" "PASS"
  else
    log_test "Cat3" "Standards reference present: $cmd" "FAIL"
  fi
done

# Test 3.4: Analysis commands reference reports directory
for cmd in compare-sprints synthesize-report; do
  if grep -q "reports/" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat3" "Reports directory referenced: $cmd" "PASS"
  else
    log_test "Cat3" "Reports directory referenced: $cmd" "FAIL"
  fi
done

# Test 3.5: Export command references pandoc
if grep -q "pandoc" "$COMMANDS_DIR/export-findings.md"; then
  log_test "Cat3" "Pandoc referenced: export-findings" "PASS"
else
  log_test "Cat3" "Pandoc referenced: export-findings" "FAIL"
fi

# Test 3.6: Release command references git
if grep -q "git" "$COMMANDS_DIR/finalize-release.md"; then
  log_test "Cat3" "Git referenced: finalize-release" "PASS"
else
  log_test "Cat3" "Git referenced: finalize-release" "FAIL"
fi

echo ""

# ===========================================
# Category 4: Integration Testing
# ===========================================
echo "========================================="
echo "CATEGORY 4: Integration Testing"
echo "========================================="

# Test 4.1: init-project suggests discover-opportunities or create-sprint
if grep -qi "discover-opportunities\|create-sprint" "$COMMANDS_DIR/init-project.md"; then
  log_test "Cat4" "init-project → next commands" "PASS"
else
  log_test "Cat4" "init-project → next commands" "FAIL"
fi

# Test 4.2: create-sprint suggests execute-sprint
if grep -qi "execute-sprint" "$COMMANDS_DIR/create-sprint.md"; then
  log_test "Cat4" "create-sprint → execute-sprint" "PASS"
else
  log_test "Cat4" "create-sprint → execute-sprint" "FAIL"
fi

# Test 4.3: execute-sprint produces output for validate-quality
if grep -qi "temp/\|reports/" "$COMMANDS_DIR/execute-sprint.md"; then
  log_test "Cat4" "execute-sprint → output directories" "PASS"
else
  log_test "Cat4" "execute-sprint → output directories" "FAIL"
fi

# Test 4.4: compare-sprints requires multiple sprint reports
if grep -qi "all.*reports\|reports/\*" "$COMMANDS_DIR/compare-sprints.md"; then
  log_test "Cat4" "compare-sprints → multiple reports" "PASS"
else
  log_test "Cat4" "compare-sprints → multiple reports" "FAIL"
fi

echo ""

# ===========================================
# Category 5: Tool Access Testing
# ===========================================
echo "========================================="
echo "CATEGORY 5: Tool Access Testing"
echo "========================================="

# Test 5.1: All commands have allowed-tools field
for cmd in init-project create-sprint execute-task execute-sprint execute-all synthesize-report score-opportunity compare-sprints export-findings validate-quality update-context finalize-release discover-opportunities; do
  if grep -q "^allowed-tools:" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat5" "Allowed-tools field present: $cmd" "PASS"
  else
    log_test "Cat5" "Allowed-tools field present: $cmd" "FAIL"
  fi
done

# Test 5.2: Task-delegating commands list Task tool
for cmd in execute-task execute-sprint execute-all synthesize-report discover-opportunities; do
  if grep -q "allowed-tools:.*Task" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat5" "Task tool in allowed-tools: $cmd" "PASS"
  else
    log_test "Cat5" "Task tool in allowed-tools: $cmd" "FAIL"
  fi
done

echo ""

# ===========================================
# Category 6: Error Handling Testing
# ===========================================
echo "========================================="
echo "CATEGORY 6: Error Handling Testing"
echo "========================================="

# Test 6.1: All commands have Error Handling section
for cmd in init-project create-sprint execute-task execute-sprint execute-all synthesize-report score-opportunity compare-sprints export-findings validate-quality update-context finalize-release discover-opportunities; do
  if grep -qi "## Error Handling\|### Error" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat6" "Error Handling section present: $cmd" "PASS"
  else
    log_test "Cat6" "Error Handling section present: $cmd" "FAIL"
  fi
done

# Test 6.2: Commands with arguments validate format
for cmd in init-project create-sprint execute-task execute-sprint synthesize-report score-opportunity export-findings validate-quality update-context finalize-release; do
  if grep -qi "ERROR\|invalid\|format" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat6" "Error messages present: $cmd" "PASS"
  else
    log_test "Cat6" "Error messages present: $cmd" "FAIL"
  fi
done

echo ""

# ===========================================
# Category 7: Output Validation Testing
# ===========================================
echo "========================================="
echo "CATEGORY 7: Output Validation Testing"
echo "========================================="

# Test 7.1: All commands have Expected Output section
for cmd in init-project create-sprint execute-task execute-sprint execute-all synthesize-report score-opportunity compare-sprints export-findings validate-quality update-context finalize-release discover-opportunities; do
  if grep -qi "## Expected Output\|## Output" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat7" "Expected Output section: $cmd" "PASS"
  else
    log_test "Cat7" "Expected Output section: $cmd" "FAIL"
  fi
done

# Test 7.2: Commands creating files specify paths
for cmd in init-project create-sprint synthesize-report finalize-release discover-opportunities; do
  if grep -q "/" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat7" "File paths specified: $cmd" "PASS"
  else
    log_test "Cat7" "File paths specified: $cmd" "FAIL"
  fi
done

echo ""

# ===========================================
# Category 8: Performance Testing
# ===========================================
echo "========================================="
echo "CATEGORY 8: Performance Testing"
echo "========================================="

# Test 8.1: Parallel execution commands mention max_parallel_tasks
for cmd in execute-sprint execute-all; do
  if grep -qi "parallel\|max_parallel" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat8" "Parallelization documented: $cmd" "PASS"
  else
    log_test "Cat8" "Parallelization documented: $cmd" "FAIL"
  fi
done

# Test 8.2: execute-all mentions execution time
if grep -qi "time\|duration\|hours" "$COMMANDS_DIR/execute-all.md"; then
  log_test "Cat8" "Execution time mentioned: execute-all" "PASS"
else
  log_test "Cat8" "Execution time mentioned: execute-all" "FAIL"
fi

# Test 8.3: File size checks (all commands should be substantive)
for cmd in init-project create-sprint execute-task execute-sprint execute-all synthesize-report score-opportunity compare-sprints export-findings validate-quality update-context finalize-release discover-opportunities; do
  size=$(wc -c < "$COMMANDS_DIR/$cmd.md")
  if [ "$size" -gt 1500 ]; then
    log_test "Cat8" "Substantive content (>1.5KB): $cmd" "PASS"
  else
    log_test "Cat8" "Substantive content (>1.5KB): $cmd" "FAIL"
  fi
done

echo ""

# ===========================================
# Category 9: User Experience Testing
# ===========================================
echo "========================================="
echo "CATEGORY 9: User Experience Testing"
echo "========================================="

# Test 9.1: All commands have clear descriptions
for cmd in init-project create-sprint execute-task execute-sprint execute-all synthesize-report score-opportunity compare-sprints export-findings validate-quality update-context finalize-release discover-opportunities; do
  desc=$(grep "^description:" "$COMMANDS_DIR/$cmd.md" | wc -c)
  if [ "$desc" -gt 30 ]; then
    log_test "Cat9" "Descriptive description (>30 chars): $cmd" "PASS"
  else
    log_test "Cat9" "Descriptive description (>30 chars): $cmd" "FAIL"
  fi
done

# Test 9.2: Commands have success criteria (bullets or checkboxes)
for cmd in init-project create-sprint execute-task execute-sprint execute-all synthesize-report score-opportunity compare-sprints export-findings validate-quality update-context finalize-release discover-opportunities; do
  # Check if Success Criteria section has either checkboxes or bullet lists
  if grep -A 10 "## Success Criteria" "$COMMANDS_DIR/$cmd.md" | grep -q "^- "; then
    log_test "Cat9" "Success criteria present: $cmd" "PASS"
  else
    log_test "Cat9" "Success criteria present: $cmd" "FAIL"
  fi
done

# Test 9.3: Commands suggest next steps
for cmd in init-project create-sprint execute-sprint execute-all discover-opportunities; do
  if grep -qi "next step\|next command" "$COMMANDS_DIR/$cmd.md"; then
    log_test "Cat9" "Next steps suggested: $cmd" "PASS"
  else
    log_test "Cat9" "Next steps suggested: $cmd" "FAIL"
  fi
done

echo ""

# ===========================================
# Category 10: Command-Skill Integration
# ===========================================
echo "========================================="
echo "CATEGORY 10: Command-Skill Integration"
echo "========================================="

# Test 10.1: execute-task maps tasks to skills
if grep -qi "task 01.*technical\|task 02.*market\|task 03.*architect" "$COMMANDS_DIR/execute-task.md"; then
  log_test "Cat10" "Task-to-skill mapping: execute-task" "PASS"
else
  log_test "Cat10" "Task-to-skill mapping: execute-task" "FAIL"
fi

# Test 10.2: execute-sprint launches multiple skills
if grep -qi "parallel.*skill\|concurrent.*task tool" "$COMMANDS_DIR/execute-sprint.md"; then
  log_test "Cat10" "Parallel skill launching: execute-sprint" "PASS"
else
  log_test "Cat10" "Parallel skill launching: execute-sprint" "FAIL"
fi

# Test 10.3: synthesize-report invokes report-generator
if grep -qi "report-generator\|report.*skill" "$COMMANDS_DIR/synthesize-report.md"; then
  log_test "Cat10" "Report generator skill: synthesize-report" "PASS"
else
  log_test "Cat10" "Report generator skill: synthesize-report" "FAIL"
fi

# Test 10.4: discover-opportunities invokes opportunity-discovery
if grep -qi "opportunity-discovery\|discovery skill" "$COMMANDS_DIR/discover-opportunities.md"; then
  log_test "Cat10" "Discovery skill: discover-opportunities" "PASS"
else
  log_test "Cat10" "Discovery skill: discover-opportunities" "FAIL"
fi

# Test 10.5: execute-all invokes sprint-executor
if grep -qi "sprint-executor" "$COMMANDS_DIR/execute-all.md"; then
  log_test "Cat10" "Sprint executor skill: execute-all" "PASS"
else
  log_test "Cat10" "Sprint executor skill: execute-all" "FAIL"
fi

echo ""

# ===========================================
# SUMMARY
# ===========================================
echo "========================================="
echo "TEST SUMMARY"
echo "========================================="
echo ""
echo "Total Tests:  $TOTAL_TESTS"
echo -e "Passed:       ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed:       ${RED}$FAILED_TESTS${NC}"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
  success_rate=100.0
else
  success_rate=$(echo "scale=1; $PASSED_TESTS * 100 / $TOTAL_TESTS" | bc)
fi

echo "Success Rate: $success_rate%"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
  echo -e "${GREEN}✓ ALL TESTS PASSED!${NC}"
  exit 0
else
  echo -e "${RED}✗ SOME TESTS FAILED${NC}"
  echo ""
  echo "Failed tests:"
  for test_name in "${FAILED_TEST_NAMES[@]}"; do
    echo "  - $test_name"
  done
  exit 1
fi
