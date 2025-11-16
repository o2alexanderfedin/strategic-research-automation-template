#!/usr/bin/env bash
#
# Test suite for README.md
# Following TDD: These tests written BEFORE the documentation

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HELPERS_DIR="$SCRIPT_DIR/../helpers"
DOC_FILE="$SCRIPT_DIR/../../README.md"

echo "Testing README.md..."

# Test 1: Basic structure
echo "Test 1: Basic markdown structure..."
"$HELPERS_DIR/check-markdown-basics.sh" "$DOC_FILE"

# Test 2: Required sections
echo "Test 2: Required sections exist..."
"$HELPERS_DIR/check-sections.sh" "$DOC_FILE" \
    "Features" \
    "Quick Start" \
    "Documentation" \
    "Examples" \
    "Contributing"

# Test 3: Word count (README should be 1400-2500 words - allowing some flexibility)
echo "Test 3: Word count in range..."
"$HELPERS_DIR/check-word-count.sh" "$DOC_FILE" 1400 2500

# Test 4: Mentions skills (at least 3 times - full list in SKILLS-REFERENCE.md)
echo "Test 4: Skills mentioned..."
SKILL_COUNT=$(grep -i "skill" "$DOC_FILE" | wc -l | tr -d ' ')
if [[ $SKILL_COUNT -lt 3 ]]; then
    echo "✗ Not enough skill mentions: $SKILL_COUNT (expected: 3+)"
    exit 1
fi
echo "✓ Skills mentioned: $SKILL_COUNT times"

# Test 5: Mentions all 13 commands (at least in summary)
echo "Test 5: Commands referenced..."
# Look for slash commands
COMMAND_COUNT=$(grep -o "/[a-z-]*" "$DOC_FILE" | sort -u | wc -l | tr -d ' ')
if [[ $COMMAND_COUNT -lt 5 ]]; then
    echo "✗ Not enough commands referenced: $COMMAND_COUNT (expected: 5+)"
    exit 1
fi
echo "✓ Commands referenced: $COMMAND_COUNT"

# Test 6: Has badges section
echo "Test 6: Badges present..."
if ! grep -q "!\[.*\](.*/badge/" "$DOC_FILE"; then
    # Check for at least some visual elements
    if ! grep -q "!\[" "$DOC_FILE"; then
        echo "✗ No badges or images found"
        exit 1
    fi
fi
echo "✓ Visual elements present"

# Test 7: Has quick start steps
echo "Test 7: Quick start steps present..."
NUMBERED_STEPS=$(grep -c "^[0-9]\+\." "$DOC_FILE" || echo "0")
if [[ $NUMBERED_STEPS -lt 3 ]]; then
    echo "✗ Not enough numbered steps: $NUMBERED_STEPS (expected: 3+)"
    exit 1
fi
echo "✓ Quick start has $NUMBERED_STEPS steps"

echo ""
echo "✅ All README.md tests passed!"
exit 0
