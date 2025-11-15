#!/usr/bin/env bash
#
# Basic markdown validation without external dependencies
# Tests: file exists, has content, basic structure

set -e

FILE="$1"

if [[ -z "$FILE" ]]; then
    echo "Usage: $0 <markdown-file>"
    exit 1
fi

if [[ ! -f "$FILE" ]]; then
    echo "ERROR: File not found: $FILE"
    exit 1
fi

if [[ ! -s "$FILE" ]]; then
    echo "ERROR: File is empty: $FILE"
    exit 1
fi

# Check for basic markdown structure
if ! grep -q "^# " "$FILE"; then
    echo "ERROR: No top-level heading found in $FILE"
    exit 1
fi

# Check for suspicious patterns
if grep -q "TODO" "$FILE"; then
    echo "WARNING: TODO markers found in $FILE"
    # Don't fail, just warn
fi

if grep -q "XXX\|FIXME" "$FILE"; then
    echo "ERROR: XXX or FIXME markers found in $FILE"
    exit 1
fi

echo "✓ Basic markdown structure valid: $FILE"
exit 0
