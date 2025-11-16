#!/usr/bin/env bash
# Skill Validation Test Script
# Tests all 8 Claude Code Skills for structural and content validity

set -e

# Colors for output
# shellcheck disable=SC2034
RED='\033[0;31m'
# shellcheck disable=SC2034
GREEN='\033[0;32m'
# shellcheck disable=SC2034
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_TOTAL=0

# Test result tracking
test_result() {
    local test_name="$1"
    local result="$2"
    TESTS_TOTAL=$((TESTS_TOTAL + 1))

    if [ "$result" -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗${NC} $test_name"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

echo "========================================"
echo "  Claude Code Skills Validation Tests"
echo "========================================"
echo ""

# Define skills to test
SKILLS=(
    "sprint-executor"
    "research-synthesizer"
    "quality-validator"
    "opportunity-scorer"
    "report-generator"
    "comparative-analyzer"
    "sprint-progress-tracker"
    "opportunity-discovery"
)

# Test 1: Skill directories exist
echo "Test Suite 1: Directory Structure"
echo "-----------------------------------"
for skill in "${SKILLS[@]}"; do
    if [ -d ".claude/skills/$skill" ]; then
        test_result "Directory exists: $skill" 0
    else
        test_result "Directory exists: $skill" 1
    fi
done
echo ""

# Test 2: SKILL.md files exist
echo "Test Suite 2: SKILL.md Files"
echo "----------------------------"
for skill in "${SKILLS[@]}"; do
    if [ -f ".claude/skills/$skill/SKILL.md" ]; then
        test_result "SKILL.md exists: $skill" 0
    else
        test_result "SKILL.md exists: $skill" 1
    fi
done
echo ""

# Test 3: YAML frontmatter validity (basic check)
echo "Test Suite 3: YAML Frontmatter"
echo "-------------------------------"
for skill in "${SKILLS[@]}"; do
    skill_file=".claude/skills/$skill/SKILL.md"
    if [ -f "$skill_file" ]; then
        # Check if file starts with ---
        if head -n 1 "$skill_file" | grep -q "^---$"; then
            test_result "Frontmatter present: $skill" 0
        else
            test_result "Frontmatter present: $skill" 1
        fi

        # Check for required fields (basic grep)
        if grep -q "^name:" "$skill_file"; then
            test_result "Has 'name' field: $skill" 0
        else
            test_result "Has 'name' field: $skill" 1
        fi

        if grep -q "^description:" "$skill_file" || grep -q "^  description:" "$skill_file"; then
            test_result "Has 'description' field: $skill" 0
        else
            test_result "Has 'description' field: $skill" 1
        fi

        if grep -q "^allowed-tools:" "$skill_file"; then
            test_result "Has 'allowed-tools' field: $skill" 0
        else
            test_result "Has 'allowed-tools' field: $skill" 1
        fi
    fi
done
echo ""

# Test 4: File size validation (skills should have substantial content)
echo "Test Suite 4: Content Size"
echo "--------------------------"
for skill in "${SKILLS[@]}"; do
    skill_file=".claude/skills/$skill/SKILL.md"
    if [ -f "$skill_file" ]; then
        line_count=$(wc -l < "$skill_file")
        if [ "$line_count" -gt 50 ]; then
            test_result "Adequate content: $skill ($line_count lines)" 0
        else
            test_result "Adequate content: $skill ($line_count lines)" 1
        fi
    fi
done
echo ""

# Test 5: Reference validation (check for template placeholders)
echo "Test Suite 5: No Template Placeholders"
echo "---------------------------------------"
for skill in "${SKILLS[@]}"; do
    skill_file=".claude/skills/$skill/SKILL.md"
    if [ -f "$skill_file" ]; then
        if grep -q "\[TODO\]\|\[PLACEHOLDER\]\|TEMPLATE\|XXX" "$skill_file"; then
            test_result "No placeholders: $skill" 1
        else
            test_result "No placeholders: $skill" 0
        fi
    fi
done
echo ""

# Summary
echo "========================================"
echo "  Test Summary"
echo "========================================"
echo "Total Tests:  $TESTS_TOTAL"
echo -e "${GREEN}Passed:${NC}       $TESTS_PASSED"
echo -e "${RED}Failed:${NC}       $TESTS_FAILED"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed.${NC}"
    exit 1
fi
