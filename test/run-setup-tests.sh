#!/usr/bin/env bash
# Test runner for setup script security and edge case tests
#
# Runs BATS tests for:
# - setup-scripts.bats (unit tests for sed, quoting, security)
# - setup-integration.bats (integration tests with real inputs)

set -e

# Colors
# shellcheck disable=SC2034
RED='\033[0;31m'
# shellcheck disable=SC2034
GREEN='\033[0;32m'
# shellcheck disable=SC2034
YELLOW='\033[1;33m'
# shellcheck disable=SC2034
BLUE='\033[0;34m'
# shellcheck disable=SC2034
BOLD='\033[1m'
NC='\033[0m'

# Counters
# shellcheck disable=SC2034
TOTAL_TESTS=0
# shellcheck disable=SC2034
PASSED_TESTS=0
# shellcheck disable=SC2034
FAILED_TESTS=0

# Print header
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       Setup Scripts Security & Edge Case Tests        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if bats is available
if ! command -v bats &> /dev/null; then
    echo -e "${RED}✗ bats not found${NC}"
    echo -e "${YELLOW}ℹ Install bats to run these tests:${NC}"
    echo "  brew install bats-core  # macOS"
    echo "  apt install bats        # Ubuntu/Debian"
    echo ""
    exit 1
fi

# Check if we're in the right directory
if [ ! -d "test" ]; then
    echo -e "${RED}✗ test directory not found${NC}"
    echo "Run this script from the repository root"
    exit 1
fi

# Run setup-scripts.bats (unit tests)
echo -e "${BOLD}Running Setup Scripts Unit Tests...${NC}"
echo ""

if bats test/setup-scripts.bats; then
    UNIT_RESULT="PASS"
    echo ""
    echo -e "${GREEN}✓ Setup scripts unit tests passed${NC}"
else
    UNIT_RESULT="FAIL"
    echo ""
    echo -e "${RED}✗ Setup scripts unit tests failed${NC}"
fi

echo ""
echo "========================================="
echo ""

# Run setup-integration.bats (integration tests)
echo -e "${BOLD}Running Setup Scripts Integration Tests...${NC}"
echo ""

if bats test/setup-integration.bats; then
    INTEGRATION_RESULT="PASS"
    echo ""
    echo -e "${GREEN}✓ Setup scripts integration tests passed${NC}"
else
    INTEGRATION_RESULT="FAIL"
    echo ""
    echo -e "${RED}✗ Setup scripts integration tests failed${NC}"
fi

echo ""
echo "========================================="
echo ""

# Summary
echo -e "${BOLD}Test Summary:${NC}"
echo ""
echo -e "  Unit Tests:        $UNIT_RESULT"
echo -e "  Integration Tests: $INTEGRATION_RESULT"
echo ""

if [ "$UNIT_RESULT" = "PASS" ] && [ "$INTEGRATION_RESULT" = "PASS" ]; then
    echo -e "${GREEN}${BOLD}✓ All setup script tests passed!${NC}"
    echo ""
    exit 0
else
    echo -e "${RED}${BOLD}✗ Some tests failed${NC}"
    echo ""
    exit 1
fi
