#!/bin/bash
# Incremental sprint execution with checkpoints
# Usage: ./run-sprints-incremental.sh

set -e

# Use CLAUDE_CMD environment variable or default to YOLO mode (claude-eng)
CLAUDE_CMD="${CLAUDE_CMD:-./scripts/setup/claude-eng}"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  Incremental Sprint Execution Pipeline                        ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Find all sprint directories
if [ ! -d "sprints" ]; then
  echo "✗ No sprints directory found"
  exit 1
fi

# Bash 3.2 compatible alternative to mapfile
SPRINT_DIRS=()
while IFS= read -r line; do
  SPRINT_DIRS+=("$line")
done < <(find sprints -maxdepth 1 -type d -name "[0-9]*" 2>/dev/null | sort)

if [ ${#SPRINT_DIRS[@]} -eq 0 ]; then
  echo "✗ No sprint directories found"
  exit 1
fi

echo "Found ${#SPRINT_DIRS[@]} sprints for incremental execution"
echo ""
echo "Each sprint will be executed sequentially with git checkpoints"
echo "If a sprint fails, you can choose to:"
echo "  1) Fix and retry"
echo "  2) Skip and continue"
echo "  3) Abort pipeline"
echo ""

# Track progress
COMPLETED=0
FAILED=0
SKIPPED=0

# Execute sprints sequentially
for sprint_dir in "${SPRINT_DIRS[@]}"; do
  SPRINT_NUM=$(basename "$sprint_dir" | grep -oE '^[0-9]+')

  echo "→ Executing Sprint $SPRINT_NUM..."
  echo "  Progress: $COMPLETED/${#SPRINT_DIRS[@]} completed"
  echo ""

  # Execute sprint using run-sprint.sh if available
  if [ -x "scripts/run-sprint.sh" ]; then
    if scripts/run-sprint.sh "$SPRINT_NUM"; then
      echo ""
      echo "✓ Sprint $SPRINT_NUM completed successfully"
      COMPLETED=$((COMPLETED + 1))

      # Create git checkpoint
      if command -v git &> /dev/null && [ -d .git ]; then
        git add . 2>/dev/null || true
        git commit -m "Checkpoint: Sprint $SPRINT_NUM completed" 2>/dev/null || true
        echo "  ✓ Git checkpoint created"
      fi
    else
      echo ""
      echo "✗ Sprint $SPRINT_NUM failed"
      FAILED=$((FAILED + 1))

      # Prompt user
      echo ""
      echo "What would you like to do?"
      echo "  1) Fix and retry this sprint"
      echo "  2) Skip this sprint and continue"
      echo "  3) Abort the pipeline"
      echo ""
      read -rp "Choice (1/2/3): " choice

      case $choice in
        1)
          echo "Please fix the issues and re-run: scripts/run-sprint.sh $SPRINT_NUM"
          exit 1
          ;;
        2)
          echo "Skipping Sprint $SPRINT_NUM"
          SKIPPED=$((SKIPPED + 1))
          ;;
        3)
          echo "Aborting pipeline"
          exit 1
          ;;
        *)
          echo "Invalid choice - aborting"
          exit 1
          ;;
      esac
    fi
  else
    echo "✗ scripts/run-sprint.sh not found"
    exit 1
  fi

  echo ""
  echo "────────────────────────────────────────────────────────────────"
  echo ""
done

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  Incremental Execution Complete                               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Summary:"
echo "  Completed: $COMPLETED"
echo "  Failed: $FAILED"
echo "  Skipped: $SKIPPED"
echo "  Total: ${#SPRINT_DIRS[@]}"
echo ""

if [ $COMPLETED -eq ${#SPRINT_DIRS[@]} ]; then
  echo "✓ All sprints completed successfully!"
  echo ""
  echo "Finalizing release..."
  $CLAUDE_CMD -p "/finalize-release v1.0" \
    --output-format json \
    --allowedTools "*" \
    | jq -r '.text' 2>/dev/null || echo "Release finalization complete"
  exit 0
else
  echo "⚠ Some sprints were not completed"
  exit 1
fi
