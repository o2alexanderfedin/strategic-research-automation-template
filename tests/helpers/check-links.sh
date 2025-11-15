#!/usr/bin/env bash
#
# Simple link checker for markdown files
# Checks internal links only (external would require network)

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

BASEDIR=$(dirname "$FILE")
ERRORS=0

# Extract markdown links [text](path) and check if path exists (for relative links)
while IFS= read -r link; do
    # Skip external links (http, https, mailto, etc.)
    if [[ "$link" =~ ^(http|https|mailto|ftp):// ]]; then
        continue
    fi

    # Skip anchors only (starting with #)
    if [[ "$link" =~ ^# ]]; then
        continue
    fi

    # Remove anchor from link
    link_path="${link%%#*}"

    # Skip empty links
    if [[ -z "$link_path" ]]; then
        continue
    fi

    # Check if file exists relative to the markdown file
    if [[ ! -e "$BASEDIR/$link_path" ]]; then
        echo "ERROR: Broken link in $FILE: $link_path"
        ((ERRORS++))
    fi
done < <(grep -oP '\]\(\K[^)]+' "$FILE" 2>/dev/null || true)

if [[ $ERRORS -gt 0 ]]; then
    echo "✗ Found $ERRORS broken links in $FILE"
    exit 1
fi

echo "✓ All internal links valid: $FILE"
exit 0
