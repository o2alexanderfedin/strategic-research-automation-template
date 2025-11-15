#!/usr/bin/env bash
#
# Check that required sections exist in markdown file

set -e

FILE="$1"
shift
REQUIRED_SECTIONS=("$@")

if [[ -z "$FILE" ]] || [[ ${#REQUIRED_SECTIONS[@]} -eq 0 ]]; then
    echo "Usage: $0 <file> <section1> <section2> ..."
    exit 1
fi

if [[ ! -f "$FILE" ]]; then
    echo "ERROR: File not found: $FILE"
    exit 1
fi

ERRORS=0

for section in "${REQUIRED_SECTIONS[@]}"; do
    if ! grep -qi "^#.*$section" "$FILE"; then
        echo "ERROR: Required section missing in $FILE: $section"
        ((ERRORS++))
    fi
done

if [[ $ERRORS -gt 0 ]]; then
    echo "✗ $ERRORS required sections missing in $FILE"
    exit 1
fi

echo "✓ All required sections present in $FILE"
exit 0
