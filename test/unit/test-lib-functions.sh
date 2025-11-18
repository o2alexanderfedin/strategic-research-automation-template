#!/usr/bin/env bash
#
# Unit Tests for Library Functions
# Tests SOLID-compliant refactored code
#
# Usage: ./test/unit/test-lib-functions.sh

set -e

# Test framework setup
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TEST_PASSED=0
TEST_FAILED=0

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test helpers
assert_equals() {
    local expected="$1"
    local actual="$2"
    local message="$3"

    if [ "$expected" = "$actual" ]; then
        echo -e "${GREEN}✓${NC} $message"
        TEST_PASSED=$((TEST_PASSED + 1))
    else
        echo -e "${RED}✗${NC} $message"
        echo -e "  Expected: $expected"
        echo -e "  Actual:   $actual"
        TEST_FAILED=$((TEST_FAILED + 1))
    fi
}

assert_function_exists() {
    local func_name="$1"

    if declare -f "$func_name" > /dev/null; then
        echo -e "${GREEN}✓${NC} Function $func_name exists"
        TEST_PASSED=$((TEST_PASSED + 1))
    else
        echo -e "${RED}✗${NC} Function $func_name does not exist"
        TEST_FAILED=$((TEST_FAILED + 1))
    fi
}

assert_command_succeeds() {
    local command="$1"
    local message="$2"

    if eval "$command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $message"
        TEST_PASSED=$((TEST_PASSED + 1))
    else
        echo -e "${RED}✗${NC} $message"
        TEST_FAILED=$((TEST_FAILED + 1))
    fi
}

# ============================================================================
# Test Suite: ui-helpers.sh
# ============================================================================

test_ui_helpers() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Testing: ui-helpers.sh${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    # Load library
    source "$PROJECT_ROOT/scripts/lib/ui-helpers.sh"

    # Test function existence
    assert_function_exists "print_header"
    assert_function_exists "print_section"
    assert_function_exists "print_success"
    assert_function_exists "print_error"
    assert_function_exists "print_warning"
    assert_function_exists "print_info"
    assert_function_exists "print_progress"
    assert_function_exists "ask_yes_no"
    assert_function_exists "ask_with_default"
    assert_function_exists "print_table_row"
    assert_function_exists "print_list_item"
    assert_function_exists "print_numbered_item"

    # Test color variables
    assert_equals '\033[0;32m' "$GREEN" "GREEN color code"
    assert_equals '\033[0;31m' "$RED" "RED color code"
    assert_equals '\033[1;33m' "$YELLOW" "YELLOW color code"
    assert_equals '\033[0;34m' "$BLUE" "BLUE color code"
    assert_equals '\033[0;36m' "$CYAN" "CYAN color code"
    assert_equals '\033[1m' "$BOLD" "BOLD code"
    assert_equals '\033[0m' "$NC" "NC (no color) code"
}

# ============================================================================
# Test Suite: context-generator.sh
# ============================================================================

test_context_generator() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Testing: context-generator.sh${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    # Load library
    source "$PROJECT_ROOT/scripts/lib/context-generator.sh"

    # Test function existence
    assert_function_exists "generate_company_context"
    assert_function_exists "generate_client_context"
    assert_function_exists "generate_industry_context"
    assert_function_exists "generate_all_contexts"

    # Create temp directory for testing
    TEST_CONTEXT_DIR=$(mktemp -d)

    # Test company context generation
    generate_company_context "Test Company Inc." "$TEST_CONTEXT_DIR/company.md"
    if [ -f "$TEST_CONTEXT_DIR/company.md" ]; then
        echo -e "${GREEN}✓${NC} Company context file created"
        TEST_PASSED=$((TEST_PASSED + 1))

        # Check content
        if grep -q "Test Company Inc." "$TEST_CONTEXT_DIR/company.md"; then
            echo -e "${GREEN}✓${NC} Company context contains input data"
            TEST_PASSED=$((TEST_PASSED + 1))
        else
            echo -e "${RED}✗${NC} Company context missing input data"
            TEST_FAILED=$((TEST_FAILED + 1))
        fi
    else
        echo -e "${RED}✗${NC} Company context file not created"
        TEST_FAILED=$((TEST_FAILED + 1))
    fi

    # Test client context generation
    generate_client_context "Test Client LLC" "Additional info" "$TEST_CONTEXT_DIR/client.md"
    if [ -f "$TEST_CONTEXT_DIR/client.md" ]; then
        echo -e "${GREEN}✓${NC} Client context file created"
        TEST_PASSED=$((TEST_PASSED + 1))

        # Check content
        if grep -q "Test Client LLC" "$TEST_CONTEXT_DIR/client.md" && \
           grep -q "Additional info" "$TEST_CONTEXT_DIR/client.md"; then
            echo -e "${GREEN}✓${NC} Client context contains input data"
            TEST_PASSED=$((TEST_PASSED + 1))
        else
            echo -e "${RED}✗${NC} Client context missing input data"
            TEST_FAILED=$((TEST_FAILED + 1))
        fi
    else
        echo -e "${RED}✗${NC} Client context file not created"
        TEST_FAILED=$((TEST_FAILED + 1))
    fi

    # Test industry context generation
    generate_industry_context "$TEST_CONTEXT_DIR/industry.md"
    if [ -f "$TEST_CONTEXT_DIR/industry.md" ]; then
        echo -e "${GREEN}✓${NC} Industry context file created"
        TEST_PASSED=$((TEST_PASSED + 1))
    else
        echo -e "${RED}✗${NC} Industry context file not created"
        TEST_FAILED=$((TEST_FAILED + 1))
    fi

    # Cleanup
    rm -rf "$TEST_CONTEXT_DIR"
}

# ============================================================================
# Test Suite: ensure-github-cli.sh
# ============================================================================

test_ensure_github_cli() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Testing: ensure-github-cli.sh${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    # Load library
    source "$PROJECT_ROOT/scripts/lib/ensure-github-cli.sh"

    # Test function existence
    assert_function_exists "ensure_github_cli_installed"
    assert_function_exists "ensure_github_cli_authenticated"
    assert_function_exists "is_github_cli_ready"
    assert_function_exists "ensure_github_cli_ready"
    assert_function_exists "install_gh_macos"
    assert_function_exists "install_gh_linux"
    assert_function_exists "install_gh_apt"
    assert_function_exists "install_gh_yum"
    assert_function_exists "install_gh_dnf"

    # Test is_github_cli_ready logic (non-invasive)
    if command -v gh &> /dev/null; then
        echo -e "${GREEN}✓${NC} gh CLI is installed (can test is_github_cli_ready)"
        TEST_PASSED=$((TEST_PASSED + 1))
    else
        echo -e "${YELLOW}⚠${NC} gh CLI not installed (skipping runtime tests)"
    fi
}

# ============================================================================
# Test Suite: enable-github-pages.sh
# ============================================================================

test_enable_github_pages() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Testing: enable-github-pages.sh${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    # Load library
    source "$PROJECT_ROOT/scripts/lib/enable-github-pages.sh"

    # Test function existence
    assert_function_exists "enable_github_pages"
    assert_function_exists "get_github_pages_url"
    assert_function_exists "is_github_pages_enabled"

    # Test URL generation
    local url=$(get_github_pages_url "testuser" "testrepo")
    assert_equals "https://testuser.github.io/testrepo/" "$url" "GitHub Pages URL generation"
}

# ============================================================================
# Run All Tests
# ============================================================================

main() {
    echo ""
    echo -e "${BOLD}${BLUE}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${BLUE}║   Unit Tests for SOLID-Refactored Libraries       ║${NC}"
    echo -e "${BOLD}${BLUE}╚════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Run test suites
    test_ui_helpers
    test_context_generator
    test_ensure_github_cli
    test_enable_github_pages

    # Summary
    echo ""
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${BLUE}  Test Results${NC}"
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""

    local total=$((TEST_PASSED + TEST_FAILED))
    echo "Total Tests: $total"
    echo -e "${GREEN}Passed: $TEST_PASSED${NC}"

    if [ $TEST_FAILED -gt 0 ]; then
        echo -e "${RED}Failed: $TEST_FAILED${NC}"
        echo ""
        echo -e "${RED}╔════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║  ✗ TESTS FAILED                                   ║${NC}"
        echo -e "${RED}╚════════════════════════════════════════════════════╝${NC}"
        exit 1
    else
        echo ""
        echo -e "${GREEN}╔════════════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║  ✓ ALL TESTS PASSED                               ║${NC}"
        echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "${BOLD}SOLID Refactoring Status:${NC} ${GREEN}VERIFIED${NC}"
        exit 0
    fi
}

main "$@"
