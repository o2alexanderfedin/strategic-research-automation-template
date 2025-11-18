#!/usr/bin/env bash
#
# Copy static HTML template to docs/index.html
# Template binds to sprints-data.json via JavaScript
#
# Usage: ./scripts/publish/generate-pages-html.sh [output-dir]

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
OUTPUT_DIR="${1:-$PROJECT_ROOT/docs}"
TEMPLATE_FILE="$PROJECT_ROOT/docs/index-template.html"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     GitHub Pages HTML Generator                   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Check if template exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo -e "${YELLOW}⚠ Template not found at: $TEMPLATE_FILE${NC}"
    echo -e "${YELLOW}Creating default template...${NC}"
    # Template will be created by setup script
    exit 1
fi

# Copy template to output
cp "$TEMPLATE_FILE" "$OUTPUT_DIR/index.html"

# Create .nojekyll file to disable Jekyll processing on GitHub Pages
touch "$OUTPUT_DIR/.nojekyll"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✓ HTML Template Copied Successfully!             ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}Output:${NC} $OUTPUT_DIR/index.html"
echo -e "${BOLD}Template:${NC} $TEMPLATE_FILE"
echo -e "${BOLD}Jekyll disabled:${NC} $OUTPUT_DIR/.nojekyll created"
echo ""
echo -e "${YELLOW}Note:${NC} This HTML template loads data from sprints-data.json"
echo -e "${YELLOW}Run:${NC} ./scripts/publish/generate-pages-data.sh to create/update data"
echo ""
