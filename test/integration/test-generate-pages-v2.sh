#!/usr/bin/env bash
#
# Comprehensive Integration Test for V2 Architecture
# Tests JSON generation, HTML binding, and complete workflow
#
# Usage: ./test/integration/test-generate-pages-v2.sh

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TEST_DIR="$PROJECT_ROOT/test/integration/test-v2-temp"
REPORTS_DIR="$TEST_DIR/reports"
OUTPUT_DIR="$TEST_DIR/output"

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Helper functions
pass() {
    echo -e "${GREEN}✓${NC} $1"
    TESTS_PASSED=$((TESTS_PASSED + 1))
}

fail() {
    echo -e "${RED}✗${NC} $1"
    TESTS_FAILED=$((TESTS_FAILED + 1))
}

info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

section() {
    echo ""
    echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}${BLUE}  $1${NC}"
    echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   V2 Architecture Integration Test Suite          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# ============================================
# Setup Test Environment
# ============================================
section "Setting Up Test Environment"

info "Cleaning previous test artifacts..."
rm -rf "$TEST_DIR"
mkdir -p "$REPORTS_DIR"
mkdir -p "$OUTPUT_DIR"

info "Creating test sprint reports..."

# Create Sprint 01 report
cat > "$REPORTS_DIR/sprint-01-final-report.md" << 'EOF'
# Strategic Research Report: Test Sprint 01

## Executive Summary
This is a comprehensive test report for the new JSON + HTML architecture validation.
The report validates data extraction, JSON generation, and HTML binding.

## Opportunity Scoring
**Overall Score**: 90.0/100
**Recommendation**: **STRONG GO**

## Market Size
**TAM**: $8.5B total addressable market

## Technical Analysis
Detailed technical feasibility assessment completed.

## Competitive Landscape
5 major competitors identified and analyzed.
EOF

# Create Sprint 02 report
cat > "$REPORTS_DIR/sprint-02-final-report.md" << 'EOF'
# Sprint 02: Test Sprint 02 with Edge Cases

## Executive Summary
Testing the v2 architecture with JSON data binding, special characters, and edge cases.
This report includes "quotes", $symbols, and other special characters to test escaping.

## Opportunity Scoring
**Overall Score**: 82.5/100
**Recommendation**: **STRONG GO**

## Market Size
**TAM**: $6.3B total addressable market
EOF

# Create Sprint 03 report
cat > "$REPORTS_DIR/sprint-03-final-report.md" << 'EOF'
# Sprint 03 Strategic Report: Test Sprint 03 Title Cleanup

## Executive Summary
Final test report for validation of title cleanup logic.

## Opportunity Scoring
**Overall Score**: 75.0/100
**Recommendation**: **GO**

## Market Size
**TAM**: $4.2B total addressable market
EOF

# Create Sprint 04 report (lower score for NO GO test)
cat > "$REPORTS_DIR/sprint-04-final-report.md" << 'EOF'
# Sprint 04: Low Score Test

## Executive Summary
Testing NO GO recommendation with low score.

## Opportunity Scoring
**Overall Score**: 55.0/100
**Recommendation**: **NO GO**

## Market Size
**TAM**: $2.1B total addressable market
EOF

pass "Created 4 test sprint reports"

# Create minimal config file
mkdir -p "$TEST_DIR/config"
cat > "$TEST_DIR/config/project-config.yml" << 'EOF'
project_name: "Test Project - V2 Architecture"
industry: "Technology"
EOF

pass "Created test configuration"

# ============================================
# Test 1: JSON Data Generation
# ============================================
section "Test 1: JSON Data Generation"

info "Running generate-pages-data.sh..."
"$PROJECT_ROOT/scripts/publish/generate-pages-data.sh" "$OUTPUT_DIR" "$REPORTS_DIR" "$TEST_DIR/config/project-config.yml" > /dev/null 2>&1

if [ -f "$OUTPUT_DIR/sprints-data.json" ]; then
    pass "JSON file created successfully"
else
    fail "JSON file not created"
fi

# ============================================
# Test 2: JSON Schema Validation
# ============================================
section "Test 2: JSON Schema Validation"

JSON_FILE="$OUTPUT_DIR/sprints-data.json"

# Check if jq is available for parsing
if command -v jq &> /dev/null; then
    info "Using jq for JSON validation"

    # Validate JSON syntax
    if jq . "$JSON_FILE" > /dev/null 2>&1; then
        pass "JSON syntax is valid"
    else
        fail "JSON syntax is invalid"
    fi

    # Validate meta fields
    project_name=$(jq -r '.meta.project_name' "$JSON_FILE")
    if [ "$project_name" = "Test Project - V2 Architecture" ]; then
        pass "Meta: project_name extracted correctly"
    else
        fail "Meta: project_name incorrect (got: $project_name)"
    fi

    industry=$(jq -r '.meta.industry' "$JSON_FILE")
    if [ "$industry" = "Technology" ]; then
        pass "Meta: industry extracted correctly"
    else
        fail "Meta: industry incorrect (got: $industry)"
    fi

    sprint_count=$(jq -r '.meta.sprint_count' "$JSON_FILE")
    if [ "$sprint_count" = "4" ]; then
        pass "Meta: sprint_count = 4 (correct)"
    else
        fail "Meta: sprint_count incorrect (expected 4, got: $sprint_count)"
    fi

    avg_score=$(jq -r '.meta.average_score' "$JSON_FILE")
    expected_avg=75  # (90 + 82 + 75 + 55) / 4 = 75.5 -> 75
    if [ "$avg_score" = "$expected_avg" ]; then
        pass "Meta: average_score = $avg_score (correct)"
    else
        fail "Meta: average_score incorrect (expected $expected_avg, got: $avg_score)"
    fi

    total_tam=$(jq -r '.meta.total_tam_billions' "$JSON_FILE")
    expected_tam=21  # 8.5 + 6.3 + 4.2 + 2.1 = 21.1 -> 21
    if [ "$total_tam" = "$expected_tam" ]; then
        pass "Meta: total_tam_billions = $total_tam (correct)"
    else
        fail "Meta: total_tam_billions incorrect (expected $expected_tam, got: $total_tam)"
    fi

    # Validate sprints array
    sprints_length=$(jq '.sprints | length' "$JSON_FILE")
    if [ "$sprints_length" = "4" ]; then
        pass "Sprints: array contains 4 sprints"
    else
        fail "Sprints: array incorrect length (expected 4, got: $sprints_length)"
    fi

    # Validate Sprint 01 data
    sprint1_title=$(jq -r '.sprints[0].title' "$JSON_FILE")
    if [[ "$sprint1_title" =~ "Test Sprint 01" ]]; then
        pass "Sprint 01: title extracted correctly"
    else
        fail "Sprint 01: title incorrect (got: $sprint1_title)"
    fi

    sprint1_score=$(jq -r '.sprints[0].score' "$JSON_FILE")
    if [ "$sprint1_score" = "90" ]; then
        pass "Sprint 01: score = 90 (correct)"
    else
        fail "Sprint 01: score incorrect (expected 90, got: $sprint1_score)"
    fi

    sprint1_rec=$(jq -r '.sprints[0].recommendation' "$JSON_FILE")
    if [ "$sprint1_rec" = "STRONG GO" ]; then
        pass "Sprint 01: recommendation = STRONG GO (correct)"
    else
        fail "Sprint 01: recommendation incorrect (got: $sprint1_rec)"
    fi

    # Validate Sprint 04 (NO GO)
    sprint4_rec=$(jq -r '.sprints[3].recommendation' "$JSON_FILE")
    if [ "$sprint4_rec" = "NO GO" ]; then
        pass "Sprint 04: recommendation = NO GO (correct)"
    else
        fail "Sprint 04: recommendation incorrect (got: $sprint4_rec)"
    fi

    sprint4_class=$(jq -r '.sprints[3].recommendation_class' "$JSON_FILE")
    if [ "$sprint4_class" = "no-go" ]; then
        pass "Sprint 04: recommendation_class = no-go (correct)"
    else
        fail "Sprint 04: recommendation_class incorrect (got: $sprint4_class)"
    fi

else
    info "jq not available, skipping detailed JSON validation"
    # Basic validation without jq
    if grep -q '"project_name"' "$JSON_FILE"; then
        pass "JSON contains project_name field"
    else
        fail "JSON missing project_name field"
    fi
fi

# ============================================
# Test 3: Title Cleanup (v3.9.0 regression)
# ============================================
section "Test 3: Title Cleanup (v3.9.0 Regression Test)"

if command -v jq &> /dev/null; then
    # Check that titles don't have redundant prefixes
    for i in 0 1 2 3; do
        title=$(jq -r ".sprints[$i].title" "$JSON_FILE")
        if [[ "$title" =~ ^Sprint\ [0-9]+:\ Sprint ]]; then
            fail "Sprint $((i+1)): Title has redundant prefix: $title"
        elif [[ "$title" =~ ^Strategic\ Research\ Report:\ Strategic ]]; then
            fail "Sprint $((i+1)): Title has redundant 'Strategic Research Report' prefix: $title"
        else
            pass "Sprint $((i+1)): Title cleaned properly: $title"
        fi
    done
else
    info "jq not available, skipping title cleanup validation"
fi

# ============================================
# Test 4: HTML Template Generation
# ============================================
section "Test 4: HTML Template Generation"

info "Running generate-pages-html.sh..."
"$PROJECT_ROOT/scripts/publish/generate-pages-html.sh" "$OUTPUT_DIR" > /dev/null 2>&1

if [ -f "$OUTPUT_DIR/index.html" ]; then
    pass "index.html created successfully"
else
    fail "index.html not created"
fi

if [ -f "$OUTPUT_DIR/.nojekyll" ]; then
    pass ".nojekyll marker created (Jekyll disabled)"
else
    fail ".nojekyll marker not created"
fi

# ============================================
# Test 5: HTML Content Validation
# ============================================
section "Test 5: HTML Content Validation"

HTML_FILE="$OUTPUT_DIR/index.html"

if grep -q '<script>' "$HTML_FILE"; then
    pass "HTML contains JavaScript section"
else
    fail "HTML missing JavaScript section"
fi

if grep -q 'loadSprintData' "$HTML_FILE"; then
    pass "HTML contains data binding function"
else
    fail "HTML missing data binding function"
fi

if grep -q 'sprints-data.json' "$HTML_FILE"; then
    pass "HTML references correct JSON data file"
else
    fail "HTML doesn't reference JSON data file"
fi

# Check for CSS Grid layout (v3.9.0 fix)
if grep -q 'grid-template-columns' "$HTML_FILE"; then
    pass "HTML uses CSS Grid layout (v3.9.0 fix verified)"
else
    fail "HTML missing CSS Grid layout"
fi

# Check for XSS protection
if grep -q 'escapeHtml' "$HTML_FILE"; then
    pass "HTML includes XSS protection function"
else
    fail "HTML missing XSS protection"
fi

# ============================================
# Test 6: Complete V2 Workflow
# ============================================
section "Test 6: Complete V2 Workflow (generate-pages-v2.sh)"

# Clean output and run complete workflow
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

info "Running generate-pages-v2.sh (complete workflow)..."
if "$PROJECT_ROOT/scripts/publish/generate-pages-v2.sh" "$OUTPUT_DIR" "$REPORTS_DIR" "$TEST_DIR/config/project-config.yml" > /dev/null 2>&1; then
    pass "V2 workflow completed without errors"
else
    fail "V2 workflow failed"
fi

if [ -f "$OUTPUT_DIR/sprints-data.json" ] && [ -f "$OUTPUT_DIR/index.html" ]; then
    pass "V2 workflow created both JSON and HTML"
else
    fail "V2 workflow missing output files"
fi

# ============================================
# Test 7: Idempotence Test
# ============================================
section "Test 7: Idempotence Test"

info "Running data generator twice..."
"$PROJECT_ROOT/scripts/publish/generate-pages-data.sh" "$OUTPUT_DIR" "$REPORTS_DIR" "$TEST_DIR/config/project-config.yml" > /dev/null 2>&1
FIRST_HASH=$(md5 -q "$OUTPUT_DIR/sprints-data.json" 2>/dev/null || md5sum "$OUTPUT_DIR/sprints-data.json" | cut -d' ' -f1)

sleep 1  # Wait 1 second to ensure different timestamp

"$PROJECT_ROOT/scripts/publish/generate-pages-data.sh" "$OUTPUT_DIR" "$REPORTS_DIR" "$TEST_DIR/config/project-config.yml" > /dev/null 2>&1
SECOND_HASH=$(md5 -q "$OUTPUT_DIR/sprints-data.json" 2>/dev/null || md5sum "$OUTPUT_DIR/sprints-data.json" | cut -d' ' -f1)

# Note: Hashes will differ due to generated_at timestamp, but structure should be same
if command -v jq &> /dev/null; then
    # Compare without timestamps
    jq 'del(.meta.generated_at) | del(.sprints[].generated_at)' "$OUTPUT_DIR/sprints-data.json" > /tmp/json1.txt
    "$PROJECT_ROOT/scripts/publish/generate-pages-data.sh" "$OUTPUT_DIR" "$REPORTS_DIR" "$TEST_DIR/config/project-config.yml" > /dev/null 2>&1
    jq 'del(.meta.generated_at) | del(.sprints[].generated_at)' "$OUTPUT_DIR/sprints-data.json" > /tmp/json2.txt

    if diff -q /tmp/json1.txt /tmp/json2.txt > /dev/null 2>&1; then
        pass "Data generator is idempotent (excluding timestamps)"
    else
        fail "Data generator produces different output on subsequent runs"
    fi

    rm -f /tmp/json1.txt /tmp/json2.txt
else
    info "jq not available, skipping detailed idempotence test"
fi

# ============================================
# Test 8: Special Characters & Escaping
# ============================================
section "Test 8: Special Characters & Escaping"

if command -v jq &> /dev/null; then
    sprint2_desc=$(jq -r '.sprints[1].description' "$JSON_FILE")

    # Check that description contains special characters correctly escaped
    if [ -n "$sprint2_desc" ]; then
        pass "Sprint 02: Description with special characters extracted"
    else
        fail "Sprint 02: Description not extracted"
    fi

    # Validate JSON doesn't have unescaped quotes breaking structure
    if jq . "$JSON_FILE" > /dev/null 2>&1; then
        pass "Special characters properly escaped in JSON"
    else
        fail "Special characters broke JSON structure"
    fi
fi

# ============================================
# Results Summary
# ============================================
section "Test Results Summary"

TOTAL_TESTS=$((TESTS_PASSED + TESTS_FAILED))

echo ""
echo -e "${BOLD}Total Tests:${NC} $TOTAL_TESTS"
echo -e "${GREEN}${BOLD}Passed:${NC} $TESTS_PASSED"
if [ $TESTS_FAILED -gt 0 ]; then
    echo -e "${RED}${BOLD}Failed:${NC} $TESTS_FAILED"
fi
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✓ ALL TESTS PASSED                               ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BOLD}V2 Architecture Status:${NC} ${GREEN}READY FOR PRODUCTION${NC}"
    echo ""

    # Cleanup
    info "Cleaning up test artifacts..."
    rm -rf "$TEST_DIR"

    exit 0
else
    echo -e "${RED}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║  ✗ TESTS FAILED                                   ║${NC}"
    echo -e "${RED}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Test artifacts preserved at: $TEST_DIR${NC}"
    echo ""

    exit 1
fi
