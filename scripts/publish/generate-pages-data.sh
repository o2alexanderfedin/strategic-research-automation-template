#!/usr/bin/env bash
#
# Generate sprints-data.json from sprint reports
# Separates data extraction from HTML presentation
#
# Usage: ./scripts/publish/generate-pages-data.sh [output-dir] [reports-dir] [config-file]

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
echo -e "${BLUE}║     GitHub Pages Data Generator                   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Extract project info from config
PROJECT_NAME=$(grep "^project_name:" "$CONFIG_FILE" 2>/dev/null | cut -d: -f2- | sed 's/^[[:space:]]*//' | sed 's/"//g' | sed "s/'//g" || echo "Strategic Research")
INDUSTRY=$(grep "^industry:" "$CONFIG_FILE" 2>/dev/null | cut -d: -f2- | sed 's/^[[:space:]]*//' | sed 's/"//g' | sed "s/'//g" || echo "Technology")
# Clean up template placeholders if config wasn't initialized
PROJECT_NAME=$(echo "$PROJECT_NAME" | sed 's/{{.*}}/Strategic Research/g')
INDUSTRY=$(echo "$INDUSTRY" | sed 's/{{.*}}/Technology/g')

# Get repository URL for cross-linking
REPO_URL=$(git config --get remote.origin.url 2>/dev/null | sed 's/\.git$//' | sed 's|git@github.com:|https://github.com/|' || echo "")

# Count sprints and research files
SPRINT_COUNT=$(find "$REPORTS_DIR" -maxdepth 1 -name "sprint-*-final-report.md" -type f 2>/dev/null | wc -l | tr -d ' ')
RESEARCH_FILE_COUNT=$(find "$PROJECT_ROOT/temp" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

# Calculate total TAM and average score
TOTAL_TAM=0
TOTAL_SCORE=0
SCORE_COUNT=0

echo -e "${YELLOW}Scanning sprint reports...${NC}"

# Start JSON output
JSON_FILE="$OUTPUT_DIR/sprints-data.json"
cat > "$JSON_FILE" << 'EOF'
{
  "meta": {
EOF

# Add metadata
cat >> "$JSON_FILE" << EOF
    "project_name": "$PROJECT_NAME",
    "industry": "$INDUSTRY",
    "generated_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "repository_url": "$REPO_URL"
EOF

# We'll update these after processing sprints
cat >> "$JSON_FILE" << 'EOF'
  },
  "sprints": [
EOF

# Process each sprint report
FIRST_SPRINT=true
for report in "$REPORTS_DIR"/sprint-*-final-report.md; do
    if [[ ! -f "$report" ]]; then
        continue
    fi

    # Add comma separator for all but first sprint
    if [ "$FIRST_SPRINT" = true ]; then
        FIRST_SPRINT=false
    else
        echo "," >> "$JSON_FILE"
    fi

    # Extract sprint number and name from filename
    filename=$(basename "$report")
    sprint_num=$(echo "$filename" | grep -o 'sprint-[0-9]*' | grep -o '[0-9]*')
    sprint_num_padded=$(printf "%02d" "$sprint_num")

    # Read the report to extract metadata
    title=$(grep "^# " "$report" | head -1 | sed 's/^# //' || echo "Sprint $sprint_num")

    # Clean up title: remove redundant prefixes (iteratively)
    while true; do
        new_title=$(echo "$title" | sed -E '
            s/^Sprint [0-9]+: ?//;
            s/^Sprint [0-9]+ //;
            s/^Strategic Research Report: ?//;
            s/^Strategic Report: ?//;
            s/^ +//;
            s/ +$//
        ')
        if [ "$new_title" = "$title" ]; then
            break
        fi
        title="$new_title"
    done

    # Escape double quotes in title for JSON
    title=$(echo "$title" | sed 's/"/\\"/g')

    # Extract description
    description=$(grep -A 20 "## Executive Summary" "$report" | grep -v "^#" | grep -v "^$" | grep -v "^\*\*" | head -1 || echo "Strategic research analysis")
    description=$(echo "$description" | sed 's/\*\*//g' | sed 's/__//g' | sed 's/"/\\"/g' | cut -c1-200)

    # Extract score
    score=$(grep -iE "(score:|overall score)" "$report" | grep -oE '[0-9]+(\.[0-9]+)?' | head -1 || echo "75")
    score=$(echo "$score" | awk '{print int($1)}')

    # Extract TAM
    tam=$(grep -i "TAM" "$report" | grep -oE '\$[0-9.]+[BMK]' | head -1 | sed 's/\$//' || echo "10B")

    # Parse TAM into numeric value and unit
    tam_unit=$(echo "$tam" | grep -oE '[BMK]$' || echo "B")
    tam_value=$(echo "$tam" | sed 's/[BMK]$//')

    # Convert to billions for numeric comparison
    if [[ "$tam_unit" == "B" ]]; then
        tam_numeric=$(echo "$tam_value" | awk '{print $1}')
    elif [[ "$tam_unit" == "M" ]]; then
        tam_numeric=$(echo "$tam_value / 1000" | bc -l | awk '{printf "%.2f", $1}')
    elif [[ "$tam_unit" == "K" ]]; then
        tam_numeric=$(echo "$tam_value / 1000000" | bc -l | awk '{printf "%.4f", $1}')
    else
        tam_numeric="0"
    fi

    # Calculate recommendation
    if [[ $score -ge 80 ]]; then
        recommendation="STRONG GO"
        rec_class="strong-go"
    elif [[ $score -ge 70 ]]; then
        recommendation="GO"
        rec_class="go"
    elif [[ $score -ge 60 ]]; then
        recommendation="CONSIDER"
        rec_class="consider"
    else
        recommendation="NO GO"
        rec_class="no-go"
    fi

    # Get file modification time for generated_at
    if [[ "$OSTYPE" == "darwin"* ]]; then
        file_time=$(stat -f "%Sm" -t "%Y-%m-%dT%H:%M:%SZ" "$report" 2>/dev/null || date -u +%Y-%m-%dT%H:%M:%SZ)
    else
        file_time=$(stat -c "%y" "$report" 2>/dev/null | cut -d' ' -f1-2 | sed 's/ /T/' | sed 's/$/Z/' || date -u +%Y-%m-%dT%H:%M:%SZ)
    fi

    echo -e "${GREEN}✓${NC} Sprint $sprint_num: $title (Score: $score/100)"

    # Output JSON object for this sprint
    cat >> "$JSON_FILE" << EOF
    {
      "number": $sprint_num,
      "number_padded": "$sprint_num_padded",
      "title": "$title",
      "description": "$description",
      "score": $score,
      "recommendation": "$recommendation",
      "recommendation_class": "$rec_class",
      "tam": "$tam",
      "tam_numeric": $tam_numeric,
      "tam_unit": "$tam_unit",
      "industry": "$INDUSTRY",
      "files": {
        "report_html": "reports/sprint-$sprint_num_padded-final-report.html",
        "report_pdf": "reports/sprint-$sprint_num_padded-final-report.pdf",
        "report_md": "reports/sprint-$sprint_num_padded-final-report.md"
      },
      "generated_at": "$file_time"
    }
EOF

    # Accumulate totals
    TOTAL_TAM=$(echo "$TOTAL_TAM + $tam_numeric" | bc -l)
    TOTAL_SCORE=$(echo "$TOTAL_SCORE + $score" | bc)
    SCORE_COUNT=$((SCORE_COUNT + 1))

done

# Close sprints array
echo "" >> "$JSON_FILE"
cat >> "$JSON_FILE" << 'EOF'
  ]
}
EOF

# Calculate final stats
if [[ $SCORE_COUNT -gt 0 ]]; then
    avg_score=$(echo "$TOTAL_SCORE / $SCORE_COUNT" | bc)
else
    avg_score=0
fi
total_tam_rounded=$(echo "$TOTAL_TAM" | awk '{print int($1+0.5)}')

# Update metadata with calculated values using jq (if available) or sed
if command -v jq &> /dev/null; then
    # Use jq for proper JSON manipulation
    tmp_file=$(mktemp)
    jq ".meta.sprint_count = $SPRINT_COUNT | \
        .meta.research_file_count = $RESEARCH_FILE_COUNT | \
        .meta.total_tam_billions = $total_tam_rounded | \
        .meta.average_score = $avg_score" "$JSON_FILE" > "$tmp_file"
    mv "$tmp_file" "$JSON_FILE"
else
    # Fallback: sed insertion (less robust but works without jq)
    sed -i.bak '/"repository_url":/a\
    ,\
    "sprint_count": '"$SPRINT_COUNT"',\
    "research_file_count": '"$RESEARCH_FILE_COUNT"',\
    "total_tam_billions": '"$total_tam_rounded"',\
    "average_score": '"$avg_score"'
' "$JSON_FILE"
    rm -f "$JSON_FILE.bak"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✓ Sprint Data Generated Successfully!            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}Output:${NC} $JSON_FILE"
echo -e "${BOLD}Sprints:${NC} $SPRINT_COUNT"
echo -e "${BOLD}Research Files:${NC} $RESEARCH_FILE_COUNT+"
echo -e "${BOLD}Total TAM:${NC} \$${total_tam_rounded}B+"
echo -e "${BOLD}Average Score:${NC} $avg_score/100"
echo ""
echo -e "${YELLOW}Next step:${NC} Generate HTML with ./scripts/publish/generate-pages-html.sh"
echo ""
