#!/bin/bash
# Export all reports to multiple formats
# Usage: ./export-reports.sh [format]  # format: pdf, docx, html, all

set -e

# Use CLAUDE_CMD environment variable or default to 'claude'
CLAUDE_CMD="${CLAUDE_CMD:-claude}"

FORMAT="${1:-pdf}"

if [[ ! "$FORMAT" =~ ^(pdf|docx|html|all)$ ]]; then
  echo "Usage: $0 [format]"
  echo ""
  echo "Formats:"
  echo "  pdf   - Export all reports to PDF (default)"
  echo "  docx  - Export all reports to Microsoft Word"
  echo "  html  - Export all reports to HTML"
  echo "  all   - Export to all formats"
  exit 1
fi

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  Report Export Pipeline                                       ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Format: $FORMAT"
echo ""

# Find all report files
if [ ! -d "reports" ]; then
  echo "✗ No reports directory found"
  exit 1
fi

mapfile -t REPORTS < <(find reports -name "*-report.md" 2>/dev/null | sort)

if [ ${#REPORTS[@]} -eq 0 ]; then
  echo "✗ No reports found in reports/ directory"
  exit 1
fi

echo "Found ${#REPORTS[@]} reports to export"
echo ""

# Export each report
for report in "${REPORTS[@]}"; do
  BASENAME=$(basename "$report" .md)
  SPRINT_NUM=$(echo "$BASENAME" | grep -oE '^[0-9]+' || echo "00")

  echo "→ Exporting Sprint $SPRINT_NUM ($FORMAT)..."

  if [ "$FORMAT" = "all" ]; then
    for fmt in pdf docx html; do
      $CLAUDE_CMD -p "/export-findings $SPRINT_NUM $fmt" \
        --output-format json \
        --allowedTools "*" \
        | jq -r '.text' 2>/dev/null || echo "  ✗ $fmt export failed"
    done
  else
    $CLAUDE_CMD -p "/export-findings $SPRINT_NUM $FORMAT" \
      --output-format json \
      --allowedTools "*" \
      | jq -r '.text' 2>/dev/null || echo "  ✗ Export failed"
  fi

  echo "  ✓ Sprint $SPRINT_NUM exported"
done

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  ✓ Export Complete                                            ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Exported ${#REPORTS[@]} reports to $FORMAT format(s)"
echo "Check reports/ directory for output files"
