#!/usr/bin/env bash
# Extract SKILL.md content from design files (Version 2)
# Extracts only the frontmatter and skill prompt, excluding extra YAML examples

set -e

DESIGN_DIR="/Users/alexanderfedin/Projects/hapyy/proposals/mosaic-vtol/temp/02-skills/02-skill-designs"
OUTPUT_DIR="/Users/alexanderfedin/Projects/hapyy/proposals/mosaic-vtol/template/.claude/skills"

# Function to extract SKILL.md content
extract_skill() {
    local design_file="$1"
    local skill_name="$2"
    local output_file="$OUTPUT_DIR/$skill_name/SKILL.md"

    echo "Extracting $skill_name..."

    # Create skill directory
    mkdir -p "$OUTPUT_DIR/$skill_name"

    # Extract content in two phases:
    # 1. Frontmatter (first ```yaml...``` block)
    # 2. Skill prompt (from "# [Skill] Skill" to "## Activation Trigger" section)

    # Phase 1: Extract frontmatter
    awk '
        BEGIN { found_first=0; in_yaml=0 }
        /^```yaml$/ && !found_first { in_yaml=1; found_first=1; next }
        /^```$/ && in_yaml { exit }
        in_yaml { print }
    ' "$design_file" > "$output_file.frontmatter"

    # Phase 2: Extract prompt (from markdown section)
    awk '
        /^# .*Skill$/ { in_prompt=1 }
        in_prompt && /^## Activation Trigger Optimization/ { exit }
        in_prompt && /^## Tool Justification/ { exit }
        in_prompt && /^## Test Scenarios/ { exit }
        in_prompt { print }
    ' "$design_file" > "$output_file.prompt"

    # Combine into final SKILL.md
    {
        echo "---"
        cat "$output_file.frontmatter"
        echo "---"
        echo ""
        cat "$output_file.prompt"
    } > "$output_file"

    # Cleanup temp files
    rm -f "$output_file.frontmatter" "$output_file.prompt"

    # Count lines for verification
    line_count=$(wc -l < "$output_file")
    echo "  ✓ Created $output_file ($line_count lines)"
}

echo "========================================"
echo "  Extracting Skills from Design Files"
echo "========================================"
echo ""

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
echo "========================================"
echo "  Extraction Complete!"
echo "========================================"
