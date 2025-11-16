#!/bin/bash

# Comprehensive validation script for slash commands
# Sprint 03, Task 04 - TDD Test Infrastructure
# Tests: 169 tests across 13 commands

set -e

# Colors for output
# shellcheck disable=SC2034
RED='\033[0;31m'
# shellcheck disable=SC2034
GREEN='\033[0;32m'
# shellcheck disable=SC2034
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Test result tracking
FAILED_TEST_NAMES=""

# Helper functions
print_test_header() {
    echo ""
    echo "========================================="
    echo "$1"
    echo "========================================="
}

print_test() {
    echo -n "  Testing: $1... "
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
}

pass_test() {
    echo -e "${GREEN}PASS${NC}"
    PASSED_TESTS=$((PASSED_TESTS + 1))
}

fail_test() {
    echo -e "${RED}FAIL${NC}"
    echo "    Error: $1"
    FAILED_TESTS=$((FAILED_TESTS + 1))
    FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - $2\n"
}

# Navigate to template root
cd "$(dirname "$0")/../.."

# Command definitions
COMMAND_FILES=(
    ".claude/commands/init-project.md"
    ".claude/commands/create-sprint.md"
    ".claude/commands/execute-task.md"
    ".claude/commands/execute-sprint.md"
    ".claude/commands/execute-all.md"
    ".claude/commands/synthesize-report.md"
    ".claude/commands/score-opportunity.md"
    ".claude/commands/compare-sprints.md"
    ".claude/commands/export-findings.md"
    ".claude/commands/validate-quality.md"
    ".claude/commands/update-context.md"
    ".claude/commands/finalize-release.md"
    ".claude/commands/discover-opportunities.md"
)

COMMAND_NAMES=(
    "init-project"
    "create-sprint"
    "execute-task"
    "execute-sprint"
    "execute-all"
    "synthesize-report"
    "score-opportunity"
    "compare-sprints"
    "export-findings"
    "validate-quality"
    "update-context"
    "finalize-release"
    "discover-opportunities"
)

# Argument counts for each command
COMMAND_ARGS=(
    3  # init-project
    3  # create-sprint
    2  # execute-task
    1  # execute-sprint
    0  # execute-all
    1  # synthesize-report
    1  # score-opportunity
    0  # compare-sprints
    2  # export-findings
    1  # validate-quality
    1  # update-context
    1  # finalize-release
    0  # discover-opportunities
)

print_test_header "CATEGORY 1: File Existence Tests (13 tests)"

for i in "${!COMMAND_FILES[@]}"; do
    file="${COMMAND_FILES[$i]}"
    cmd="${COMMAND_NAMES[$i]}"

    print_test "Command file exists: $file"
    if [ -f "$file" ]; then
        pass_test
    else
        fail_test "File does not exist: $file" "File existence: $cmd"
    fi
done

print_test_header "CATEGORY 2: YAML Frontmatter Tests (52 tests)"

for i in "${!COMMAND_FILES[@]}"; do
    file="${COMMAND_FILES[$i]}"
    cmd="${COMMAND_NAMES[$i]}"

    if [ ! -f "$file" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 4))
        FAILED_TESTS=$((FAILED_TESTS + 4))
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - YAML frontmatter: $cmd - description\n"
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - YAML frontmatter: $cmd - argument-hint\n"
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - YAML frontmatter: $cmd - allowed-tools\n"
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - YAML frontmatter: $cmd - valid structure\n"
        continue
    fi

    # Test 1: Has YAML frontmatter delimiter
    print_test "YAML frontmatter structure: $cmd"
    if grep -q "^---$" "$file"; then
        pass_test
    else
        fail_test "Missing YAML frontmatter delimiters (---)" "YAML structure: $cmd"
    fi

    # Test 2: Has description field
    print_test "YAML field 'description': $cmd"
    if grep -qE "^description:" "$file"; then
        pass_test
    else
        fail_test "Missing 'description:' field in YAML frontmatter" "YAML description: $cmd"
    fi

    # Test 3: Has allowed-tools field
    print_test "YAML field 'allowed-tools': $cmd"
    if grep -qE "^allowed-tools:" "$file"; then
        pass_test
    else
        fail_test "Missing 'allowed-tools:' field in YAML frontmatter" "YAML allowed-tools: $cmd"
    fi

    # Test 4: Valid YAML structure (frontmatter ends with ---)
    print_test "YAML frontmatter closure: $cmd"
    frontmatter_count=$(grep -c "^---$" "$file" || echo "0")
    if [ "$frontmatter_count" -ge 2 ]; then
        pass_test
    else
        fail_test "YAML frontmatter not properly closed (need 2 '---' markers, found $frontmatter_count)" "YAML closure: $cmd"
    fi
done

print_test_header "CATEGORY 3: Content Structure Tests (13 tests)"

for i in "${!COMMAND_FILES[@]}"; do
    file="${COMMAND_FILES[$i]}"
    cmd="${COMMAND_NAMES[$i]}"

    if [ ! -f "$file" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        FAILED_TESTS=$((FAILED_TESTS + 1))
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - Content structure: $cmd\n"
        continue
    fi

    print_test "Has substantive content: $cmd"
    word_count=$(wc -w < "$file" | tr -d ' ')
    if [ "$word_count" -gt 100 ]; then
        pass_test
    else
        fail_test "Insufficient content (only $word_count words, need >100)" "Content length: $cmd"
    fi
done

print_test_header "CATEGORY 4: Required Sections Tests (39 tests)"

for i in "${!COMMAND_FILES[@]}"; do
    file="${COMMAND_FILES[$i]}"
    cmd="${COMMAND_NAMES[$i]}"

    if [ ! -f "$file" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 3))
        FAILED_TESTS=$((FAILED_TESTS + 3))
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - Required sections: $cmd - purpose\n"
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - Required sections: $cmd - steps\n"
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - Required sections: $cmd - success criteria\n"
        continue
    fi

    # Test 1: Has Purpose/Objective section
    print_test "Has purpose statement: $cmd"
    if grep -qiE "(## Purpose|## Objective|## Overview)" "$file"; then
        pass_test
    else
        fail_test "Missing purpose/objective section" "Purpose section: $cmd"
    fi

    # Test 2: Has Steps section
    print_test "Has steps/instructions: $cmd"
    if grep -qiE "(## Steps|## Execution|## Process|### Step)" "$file"; then
        pass_test
    else
        fail_test "Missing steps/instructions section" "Steps section: $cmd"
    fi

    # Test 3: Has Success Criteria or Expected Output
    print_test "Has success criteria: $cmd"
    if grep -qiE "(## Success|## Expected Output|## Output|## Result)" "$file"; then
        pass_test
    else
        fail_test "Missing success criteria or expected output section" "Success section: $cmd"
    fi
done

print_test_header "CATEGORY 5: Argument References Tests (26 tests)"

for i in "${!COMMAND_FILES[@]}"; do
    file="${COMMAND_FILES[$i]}"
    cmd="${COMMAND_NAMES[$i]}"
    expected_args="${COMMAND_ARGS[$i]}"

    if [ ! -f "$file" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 2))
        FAILED_TESTS=$((FAILED_TESTS + 2))
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - Argument references: $cmd - count\n"
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - Argument references: $cmd - validation\n"
        continue
    fi

    # Test 1: Has appropriate argument references
    print_test "Argument references ($expected_args args): $cmd"
    if [ "$expected_args" -eq 0 ]; then
        # Should not have argument references
        if ! grep -qE '\$1|\$2|\$3' "$file"; then
            pass_test
        else
            fail_test "Command should not reference arguments (expected 0 args)" "Arg refs: $cmd"
        fi
    elif [ "$expected_args" -eq 1 ]; then
        if grep -qE '\$1' "$file"; then
            pass_test
        else
            fail_test "Command should reference \$1 (expected 1 arg)" "Arg refs: $cmd"
        fi
    elif [ "$expected_args" -eq 2 ]; then
        if grep -qE '\$1' "$file" && grep -qE '\$2' "$file"; then
            pass_test
        else
            fail_test "Command should reference \$1 and \$2 (expected 2 args)" "Arg refs: $cmd"
        fi
    elif [ "$expected_args" -eq 3 ]; then
        if grep -qE '\$1' "$file" && grep -qE '\$2' "$file" && grep -qE '\$3' "$file"; then
            pass_test
        else
            fail_test "Command should reference \$1, \$2, and \$3 (expected 3 args)" "Arg refs: $cmd"
        fi
    fi

    # Test 2: Has validation logic if arguments expected
    print_test "Argument validation logic: $cmd"
    if [ "$expected_args" -gt 0 ]; then
        if grep -qiE "(validate|check|verify).*(argument|parameter|\\\$1)" "$file"; then
            pass_test
        else
            fail_test "Missing argument validation logic for $expected_args argument(s)" "Arg validation: $cmd"
        fi
    else
        pass_test  # No validation needed for zero-argument commands
    fi
done

print_test_header "CATEGORY 6: No Placeholder Text Tests (13 tests)"

for i in "${!COMMAND_FILES[@]}"; do
    file="${COMMAND_FILES[$i]}"
    cmd="${COMMAND_NAMES[$i]}"

    if [ ! -f "$file" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        FAILED_TESTS=$((FAILED_TESTS + 1))
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - No placeholders: $cmd\n"
        continue
    fi

    print_test "No placeholder text: $cmd"
    # Exclude legitimate tool names like "TodoWrite" from placeholder detection
    if grep -qiE '\[?TODO\]?|\[?TBD\]?|\[?PLACEHOLDER\]?|\[?FIXME\]?|\[?XXX\]?' "$file" && \
       ! grep -qE 'TodoWrite|allowed-tools.*Todo' "$file"; then
        fail_test "Found placeholder text (TODO, TBD, PLACEHOLDER, FIXME, XXX)" "Placeholders: $cmd"
    else
        pass_test
    fi
done

print_test_header "CATEGORY 7: File Size Tests (13 tests)"

for i in "${!COMMAND_FILES[@]}"; do
    file="${COMMAND_FILES[$i]}"
    cmd="${COMMAND_NAMES[$i]}"

    if [ ! -f "$file" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        FAILED_TESTS=$((FAILED_TESTS + 1))
        FAILED_TEST_NAMES="${FAILED_TEST_NAMES}  - File size: $cmd\n"
        continue
    fi

    print_test "File size reasonable: $cmd"
    file_size=$(wc -c < "$file" | tr -d ' ')
    if [ "$file_size" -gt 500 ]; then
        pass_test
    else
        fail_test "File too small ($file_size bytes, need >500)" "File size: $cmd"
    fi
done

# Summary
print_test_header "TEST SUMMARY"
echo ""
echo "Total Tests:  $TOTAL_TESTS"
echo -e "Passed:       ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed:       ${RED}$FAILED_TESTS${NC}"
echo ""

if [ "$FAILED_TESTS" -gt 0 ]; then
    echo -e "${RED}FAILED TESTS:${NC}"
    echo -e "$FAILED_TEST_NAMES"
fi

# Success rate
if [ "$TOTAL_TESTS" -gt 0 ]; then
    success_rate=$(awk "BEGIN {printf \"%.1f\", ($PASSED_TESTS/$TOTAL_TESTS)*100}")
    echo "Success Rate: $success_rate%"
else
    echo "Success Rate: N/A (no tests run)"
fi
echo ""

if [ "$FAILED_TESTS" -eq 0 ]; then
    echo -e "${GREEN}✓ ALL TESTS PASSED!${NC}"
    echo ""
    exit 0
else
    echo -e "${RED}✗ SOME TESTS FAILED${NC}"
    echo ""
    exit 1
fi
