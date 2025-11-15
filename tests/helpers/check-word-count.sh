#!/usr/bin/env bash
#
# Check word count is within expected range

set -e

FILE="$1"
MIN="$2"
MAX="$3"

if [[ -z "$FILE" ]] || [[ -z "$MIN" ]] || [[ -z "$MAX" ]]; then
    echo "Usage: $0 <file> <min-words> <max-words>"
    exit 1
fi

if [[ ! -f "$FILE" ]]; then
    echo "ERROR: File not found: $FILE"
    exit 1
fi

# Count words in the whole file (including code blocks for comprehensive docs)
WORD_COUNT=$(wc -w < "$FILE" | tr -d ' ')

if [[ $WORD_COUNT -lt $MIN ]]; then
    echo "✗ Word count too low: $WORD_COUNT (minimum: $MIN) in $FILE"
    exit 1
fi

if [[ $WORD_COUNT -gt $MAX ]]; then
    echo "✗ Word count too high: $WORD_COUNT (maximum: $MAX) in $FILE"
    exit 1
fi

echo "✓ Word count within range: $WORD_COUNT words ($MIN-$MAX) in $FILE"
exit 0
