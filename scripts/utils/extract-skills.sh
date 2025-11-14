#!/usr/bin/env bash
# Extract SKILL.md content from design files
# This script parses the design documents and extracts the complete SKILL.md content

set -e

DESIGN_DIR="/Users/alexanderfedin/Projects/hapyy/proposals/mosaic-vtol/temp/02-skills/02-skill-designs"
OUTPUT_DIR="/Users/alexanderfedin/Projects/hapyy/proposals/mosaic-vtol/template/.claude/skills"

# Function to extract SKILL.md content from design file
extract_skill() {
    local design_file="$1"
    local skill_name="$2"
    local output_file="$OUTPUT_DIR/$skill_name/SKILL.md"

    echo "Extracting $skill_name from $design_file..."

    # Create skill directory
    mkdir -p "$OUTPUT_DIR/$skill_name"

    # Extract frontmatter (between first ```yaml and ```)
    # Then extract prompt (from "# [Skill Name] Skill" to end of file or next major section)

    # For now, create a placeholder that we'll manually populate
    # This script helps identify the structure

    awk '
        /^```yaml$/ { in_frontmatter=1; next }
        /^```$/ && in_frontmatter { in_frontmatter=0; print "---"; next }
        in_frontmatter { print }
    ' "$design_file" > "$output_file.tmp"

    # Add the frontmatter
    echo "---" > "$output_file"
    cat "$output_file.tmp" >> "$output_file"
    rm "$output_file.tmp"

    # Add prompt section (simplified - extract markdown section)
    awk '
        /^# .*Skill$/ { in_prompt=1 }
        in_prompt && /^## Test Scenarios/ { exit }
        in_prompt { print }
    ' "$design_file" >> "$output_file"

    echo "Created: $output_file"
}

# Extract each skill
extract_skill "$DESIGN_DIR/01-sprint-executor.md" "sprint-executor"
extract_skill "$DESIGN_DIR/02-research-synthesizer.md" "research-synthesizer"
extract_skill "$DESIGN_DIR/03-quality-validator.md" "quality-validator"
extract_skill "$DESIGN_DIR/04-opportunity-scorer.md" "opportunity-scorer"
extract_skill "$DESIGN_DIR/05-report-generator.md" "report-generator"
extract_skill "$DESIGN_DIR/06-comparative-analyzer.md" "comparative-analyzer"
extract_skill "$DESIGN_DIR/07-sprint-progress-tracker.md" "sprint-progress-tracker"
extract_skill "$DESIGN_DIR/08-opportunity-discovery.md" "opportunity-discovery"

echo ""
echo "Skill extraction complete!"
