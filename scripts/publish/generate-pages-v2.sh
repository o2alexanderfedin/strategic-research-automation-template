#!/usr/bin/env bash
#
# Generate GitHub Pages with JSON + Static HTML architecture (v2)
# Separates data extraction from presentation for better maintainability
#
# Usage: ./scripts/publish/generate-pages-v2.sh [output-dir] [reports-dir] [config-file]

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
OUTPUT_DIR="${1:-$PROJECT_ROOT/docs}"
REPORTS_DIR="${2:-$PROJECT_ROOT/reports}"
CONFIG_FILE="${3:-$PROJECT_ROOT/config/project-config.yml}"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     GitHub Pages Generator v2 (JSON + HTML)       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# Step 1: Generate JSON data
echo -e "${BOLD}Step 1: Generating sprint data (JSON)...${NC}"
"$SCRIPT_DIR/generate-pages-data.sh" "$OUTPUT_DIR" "$REPORTS_DIR" "$CONFIG_FILE"

echo ""

# Step 2: Copy static HTML template (only if it doesn't exist or --force flag)
if [ ! -f "$OUTPUT_DIR/index.html" ] || [ "$4" = "--force" ]; then
    echo -e "${BOLD}Step 2: Copying static HTML template...${NC}"
    "$SCRIPT_DIR/generate-pages-html.sh" "$OUTPUT_DIR"
else
    echo -e "${YELLOW}Step 2: Skipping HTML copy (already exists, use --force to overwrite)${NC}"
    echo ""
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✓ GitHub Pages Generated Successfully! (v2)      ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}Architecture:${NC} JSON Data + Static HTML Template"
echo -e "${BOLD}Data File:${NC} $OUTPUT_DIR/sprints-data.json"
echo -e "${BOLD}HTML Template:${NC} $OUTPUT_DIR/index.html (static, loads JSON via JavaScript)"
echo ""
echo -e "${YELLOW}Benefits of v2 architecture:${NC}"
echo "  ✓ Idempotent: JSON regenerated, HTML never modified"
echo "  ✓ Maintainable: HTML/CSS/JS in proper files, not bash heredocs"
echo "  ✓ Testable: JSON schema validation, JS unit tests"
echo "  ✓ Extensible: Add filtering, sorting, search with client-side JS"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review: cat $OUTPUT_DIR/sprints-data.json"
echo "2. Test locally: open $OUTPUT_DIR/index.html (needs local server for CORS)"
echo "3. Enable GitHub Pages: Settings → Pages → Source: main, /docs"
echo "4. Site will be live at: https://<username>.github.io/<repo>/"
echo ""
