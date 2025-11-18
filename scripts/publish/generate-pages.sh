#!/usr/bin/env bash
#
# Generate GitHub Pages index.html from sprint reports
# Scans reports/ directory and creates a professional landing page
#
# Usage: ./scripts/publish/generate-pages.sh [output-dir]

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
OUTPUT_DIR="${1:-$PROJECT_ROOT/docs}"
REPORTS_DIR="$PROJECT_ROOT/reports"
CONFIG_FILE="$PROJECT_ROOT/config/project-config.yml"

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

echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     GitHub Pages Generator                        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Extract project info from config
PROJECT_NAME=$(grep "^project_name:" "$CONFIG_FILE" 2>/dev/null | cut -d: -f2- | sed 's/^[[:space:]]*//' || echo "Strategic Research")
INDUSTRY=$(grep "^industry:" "$CONFIG_FILE" 2>/dev/null | cut -d: -f2- | sed 's/^[[:space:]]*//' | sed 's/"//g' || echo "Technology")
# Clean up template placeholders if config wasn't initialized
INDUSTRY=$(echo "$INDUSTRY" | sed 's/{{.*}}/Technology/g')

# Count sprints and research files
SPRINT_COUNT=$(find "$REPORTS_DIR" -maxdepth 1 -name "sprint-*-final-report.md" -type f 2>/dev/null | wc -l | tr -d ' ')
RESEARCH_FILE_COUNT=$(find "$PROJECT_ROOT/temp" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

# Calculate total TAM and average score
TOTAL_TAM=0
TOTAL_SCORE=0
SCORE_COUNT=0

echo -e "${YELLOW}Scanning sprint reports...${NC}"

# Generate HTML header
cat > "$OUTPUT_DIR/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Strategic Research Reports</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }

        header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            font-weight: 700;
        }

        header p {
            font-size: 1.2em;
            opacity: 0.9;
        }

        main {
            padding: 40px;
        }

        .intro {
            text-align: center;
            margin-bottom: 50px;
        }

        .intro h2 {
            font-size: 2em;
            margin-bottom: 15px;
            color: #667eea;
        }

        .intro p {
            font-size: 1.1em;
            color: #666;
            max-width: 800px;
            margin: 0 auto;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 40px 0;
            padding: 30px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .stat {
            text-align: center;
            padding: 20px;
        }

        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: #667eea;
            display: block;
        }

        .stat-label {
            color: #666;
            margin-top: 5px;
            font-size: 0.9em;
        }

        .reports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .report-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 30px;
            background: white;
            transition: all 0.3s ease;
        }

        .report-card:hover {
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.2);
            transform: translateY(-5px);
        }

        .report-card h3 {
            font-size: 1.5em;
            margin-bottom: 15px;
            color: #333;
        }

        .score-badge {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .recommendation {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            margin-left: 10px;
            font-size: 0.9em;
        }

        .recommendation.strong-go {
            background: #10b981;
            color: white;
        }

        .recommendation.go {
            background: #3b82f6;
            color: white;
        }

        .recommendation.consider {
            background: #f59e0b;
            color: white;
        }

        .recommendation.no-go {
            background: #ef4444;
            color: white;
        }

        .report-card p {
            color: #666;
            margin-bottom: 15px;
        }

        .market-data {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            margin: 15px 0;
            font-size: 0.9em;
        }

        .market-data strong {
            color: #667eea;
        }

        .report-links {
            display: grid;
            grid-template-columns: repeat(2, 1fr);  /* 2x2 grid: 2 columns on desktop */
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            padding: 12px 20px;  /* Increased padding for better click targets */
            border-radius: 6px;
            text-decoration: none;
            text-align: center;
            font-weight: 600;
            transition: all 0.3s ease;
            white-space: nowrap;  /* Prevent text wrapping inside buttons */
            font-size: 0.9em;     /* Slightly smaller text for better fit */
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }

        footer {
            background: #f8f9fa;
            padding: 30px;
            text-align: center;
            color: #666;
            border-top: 1px solid #e0e0e0;
        }

        footer a {
            color: #667eea;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            header h1 {
                font-size: 1.8em;
            }

            .reports-grid {
                grid-template-columns: 1fr;
            }

            .stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .report-links {
                grid-template-columns: 1fr;  /* Single column on mobile - stacked buttons */
            }
        }
    </style>

    <!-- Mermaid.js for rendering diagrams -->
    <script type="module">
        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
        mermaid.initialize({
            startOnLoad: true,
            theme: 'default',
            securityLevel: 'loose'
        });
    </script>
</head>
<body>
    <div class="container">
        <header>
EOF

# Get repository URL for cross-linking
REPO_URL=$(git config --get remote.origin.url 2>/dev/null | sed 's/\.git$//' | sed 's|git@github.com:|https://github.com/|' || echo "")

# Add dynamic header content
cat >> "$OUTPUT_DIR/index.html" << EOF
            <h1>$PROJECT_NAME</h1>
            <p>AI-Powered Strategic Research &amp; Analysis</p>
EOF

# Add repository link if available
if [ -n "$REPO_URL" ]; then
cat >> "$OUTPUT_DIR/index.html" << EOF
            <p style="margin-top: 15px; font-size: 0.9em;">
                <a href="$REPO_URL" style="color: white; text-decoration: none; border: 1px solid rgba(255,255,255,0.5); padding: 8px 16px; border-radius: 4px; display: inline-block; transition: all 0.3s;" onmouseover="this.style.background='rgba(255,255,255,0.2)'" onmouseout="this.style.background='transparent'">
                    📂 View Repository &amp; Documentation
                </a>
            </p>
EOF
fi

cat >> "$OUTPUT_DIR/index.html" << 'EOF'
        </header>

        <main>
            <div class="intro">
                <h2>Strategic Opportunities Analyzed</h2>
                <p>Comprehensive research reports generated using AI-powered automation. Each report includes market analysis, technical feasibility, competitive landscape, and actionable recommendations.</p>
            </div>

            <div class="stats">
EOF

# Add dynamic stats
cat >> "$OUTPUT_DIR/index.html" << EOF
                <div class="stat">
                    <span class="stat-number">$SPRINT_COUNT</span>
                    <div class="stat-label">Strategic Opportunities</div>
                </div>
                <div class="stat">
                    <span class="stat-number">$RESEARCH_FILE_COUNT+</span>
                    <div class="stat-label">Research Files</div>
                </div>
EOF

# We'll add TAM and average score after processing sprints
cat >> "$OUTPUT_DIR/index.html" << 'EOF'
                <div class="stat">
                    <span class="stat-number" id="total-tam">$0B+</span>
                    <div class="stat-label">Combined TAM</div>
                </div>
                <div class="stat">
                    <span class="stat-number" id="avg-score">0/100</span>
                    <div class="stat-label">Average Score</div>
                </div>
            </div>

            <div class="reports-grid">
EOF

# Process each sprint report
for report in "$REPORTS_DIR"/sprint-*-final-report.md; do
    if [[ ! -f "$report" ]]; then
        continue
    fi

    # Extract sprint number and name from filename
    filename=$(basename "$report")
    sprint_num=$(echo "$filename" | grep -o 'sprint-[0-9]*' | grep -o '[0-9]*')

    # Read the report to extract metadata
    title=$(grep "^# " "$report" | head -1 | sed 's/^# //' || echo "Sprint $sprint_num")

    # Clean up title: remove redundant prefixes that will cause duplication
    # (The card displays "Sprint XX:" already, so remove it from the extracted title)
    # Remove patterns: "Sprint XX:", "Sprint XX ", "Strategic Report:", "Strategic Research Report:"
    # Apply patterns in a loop to handle multiple occurrences (e.g., "Sprint 02: Sprint 02: Title")
    while true; do
        new_title=$(echo "$title" | sed -E '
            s/^Sprint [0-9]+: ?//;
            s/^Sprint [0-9]+ //;
            s/^Strategic Research Report: ?//;
            s/^Strategic Report: ?//;
            s/^ +//;
            s/ +$//
        ')
        # Break if title unchanged (no more matches)
        if [ "$new_title" = "$title" ]; then
            break
        fi
        title="$new_title"
    done

    # Extract description - skip markdown headings and blank lines to get actual content
    description=$(grep -A 20 "## Executive Summary" "$report" | grep -v "^#" | grep -v "^$" | grep -v "^\*\*" | head -1 || echo "Strategic research analysis")

    # Extract score if available (handles both "Score: XX" and "**Overall Score**: XX.X/100")
    score=$(grep -iE "(score:|overall score)" "$report" | grep -oE '[0-9]+(\.[0-9]+)?' | head -1 || echo "75")
    score=$(echo "$score" | awk '{print int($1)}')  # Convert to integer

    # Extract TAM if available (looking for patterns like $XXB, $XXXB, etc.)
    tam=$(grep -i "TAM" "$report" | grep -oE '\$[0-9.]+[BMK]' | head -1 | sed 's/\$//' || echo "10B")

    # Calculate recommendation based on score
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

    # Clean description (remove markdown, trim to reasonable length)
    description=$(echo "$description" | sed 's/\*\*//g' | sed 's/__//g' | cut -c1-200)

    echo -e "${GREEN}✓${NC} Sprint $sprint_num: $title (Score: $score/100)"

    # Add card to HTML
    cat >> "$OUTPUT_DIR/index.html" << EOF
                <div class="report-card">
                    <h3>Sprint $(printf "%02d" "$sprint_num"): $title</h3>
                    <span class="score-badge">$score/100</span>
                    <span class="recommendation $rec_class">$recommendation</span>
                    <p>$description</p>
                    <div class="market-data">
                        <strong>Total Addressable Market:</strong> \$$tam<br>
                        <strong>Industry:</strong> $INDUSTRY
                    </div>
                    <div class="report-links">
                        <a href="reports/sprint-$(printf "%02d" "$sprint_num")-final-report.html" class="btn btn-primary">View Report</a>
                        <a href="reports/sprint-$(printf "%02d" "$sprint_num")-final-report.pdf" class="btn btn-secondary">PDF</a>
                        <a href="reports/sprint-$(printf "%02d" "$sprint_num")-final-report.md" class="btn btn-secondary">Markdown</a>
                    </div>
                </div>
EOF

    # Accumulate totals for stats
    # Convert TAM to numeric (remove B/M/K suffix and convert)
    tam_numeric=$(echo "$tam" | sed 's/[BMK]$//')
    if [[ "$tam" =~ B$ ]]; then
        tam_numeric=$(echo "$tam_numeric * 1" | bc 2>/dev/null || echo "$tam_numeric")
    elif [[ "$tam" =~ M$ ]]; then
        tam_numeric=$(echo "$tam_numeric / 1000" | bc 2>/dev/null || echo "0")
    fi

    TOTAL_TAM=$(echo "$TOTAL_TAM + $tam_numeric" | bc 2>/dev/null || echo "$TOTAL_TAM")
    TOTAL_SCORE=$(echo "$TOTAL_SCORE + $score" | bc)
    SCORE_COUNT=$((SCORE_COUNT + 1))

done

# Close reports grid
cat >> "$OUTPUT_DIR/index.html" << 'EOF'
            </div>
        </main>

        <footer>
EOF

# Add footer with timestamp
cat >> "$OUTPUT_DIR/index.html" << EOF
            <p>Generated with <a href="https://github.com/o2alexanderfedin/strategic-research-automation-template" target="_blank">Strategic Research Automation Template</a></p>
            <p>Last updated: $(date '+%Y-%m-%d %H:%M:%S %Z')</p>
EOF

cat >> "$OUTPUT_DIR/index.html" << 'EOF'
        </footer>
    </div>
</body>
</html>
EOF

# Update stats with calculated values
if [[ $SCORE_COUNT -gt 0 ]]; then
    avg_score=$(echo "$TOTAL_SCORE / $SCORE_COUNT" | bc)
else
    avg_score=0
fi

# Format TAM (round to nearest billion)
total_tam_rounded=$(echo "$TOTAL_TAM" | awk '{print int($1+0.5)}')

# Update the HTML with actual values
# Use regex patterns that match ANY existing value (not just 0) for idempotent updates
# This allows the script to be run multiple times as sprints are added/updated
# Pattern: Match any number/value, not just the initial placeholder "0"
if sed --version >/dev/null 2>&1; then
    # GNU sed (Linux)
    # Match: id="total-tam">$XXB+ where XX is any number (handles both $0B+, $5B+, $12B+, etc.)
    sed -i 's/id="total-tam">\$[0-9]\+B+/id="total-tam">$'"$total_tam_rounded"'B+/' "$OUTPUT_DIR/index.html"
    # Match: id="avg-score">XX/100 where XX is any number (handles both 0/100, 84/100, etc.)
    sed -i 's/id="avg-score">[0-9]\+\/100/id="avg-score">'"$avg_score"'\/100/' "$OUTPUT_DIR/index.html"
else
    # BSD sed (macOS)
    # Match: id="total-tam">$XXB+ where XX is any number (handles both $0B+, $5B+, $12B+, etc.)
    sed -i.bak 's/id="total-tam">\$[0-9][0-9]*B+/id="total-tam">$'"$total_tam_rounded"'B+/' "$OUTPUT_DIR/index.html"
    # Match: id="avg-score">XX/100 where XX is any number (handles both 0/100, 84/100, etc.)
    sed -i.bak 's/id="avg-score">[0-9][0-9]*\/100/id="avg-score">'"$avg_score"'\/100/' "$OUTPUT_DIR/index.html"
    rm -f "$OUTPUT_DIR/index.html.bak"
fi

# Validate that updates actually happened (detect silent failures)
if ! grep -q "id=\"total-tam\">\$$total_tam_rounded" "$OUTPUT_DIR/index.html"; then
    echo "WARNING: Failed to update total-tam stat - regex may not have matched"
fi
if ! grep -q "id=\"avg-score\">$avg_score/100" "$OUTPUT_DIR/index.html"; then
    echo "WARNING: Failed to update avg-score stat - regex may not have matched"
fi

# Create .nojekyll file to disable Jekyll processing on GitHub Pages
touch "$OUTPUT_DIR/.nojekyll"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✓ GitHub Pages Generated Successfully!          ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}Output:${NC} $OUTPUT_DIR/index.html"
echo -e "${BOLD}Jekyll disabled:${NC} $OUTPUT_DIR/.nojekyll created"
echo -e "${BOLD}Sprints:${NC} $SPRINT_COUNT"
echo -e "${BOLD}Research Files:${NC} $RESEARCH_FILE_COUNT+"
echo -e "${BOLD}Total TAM:${NC} \$${total_tam_rounded}B+"
echo -e "${BOLD}Average Score:${NC} $avg_score/100"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review the generated index.html"
echo "2. Enable GitHub Pages: Settings → Pages → Source: main, /docs"
echo "3. Site will be live at: https://<username>.github.io/<repo>/"
echo ""
