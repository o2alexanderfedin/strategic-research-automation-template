#!/bin/bash
# Mock Claude CLI for testing
# Simulates claude command behavior without actual API calls

# Parse arguments
# shellcheck disable=SC2034
MODE=""
PROMPT=""
# shellcheck disable=SC2034
OUTPUT_FORMAT="text"

while [[ $# -gt 0 ]]; do
  case $1 in
    -p|--print)
      MODE="print"
      PROMPT="$2"
      shift 2
      ;;
    --output-format)
      OUTPUT_FORMAT="$2"
      shift 2
      ;;
    --allowedTools)
      shift 2
      ;;
    --dangerously-skip-permissions|--permission-mode)
      shift
      if [[ "$1" != -* ]]; then shift; fi
      ;;
    --append-system-prompt|--system-prompt|--model)
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

# Mock responses based on prompt
if [[ "$PROMPT" =~ /init-project ]]; then
  echo '{"type": "text", "text": "✓ Project initialized successfully"}'
elif [[ "$PROMPT" =~ /discover-opportunities ]]; then
  echo '{"type": "text", "text": "✓ Discovered 10 strategic opportunities"}'
  echo '{"type": "text", "text": "✓ Sprint definitions created"}'
elif [[ "$PROMPT" =~ /execute-all ]]; then
  echo '{"type": "text", "text": "✓ Executing all sprints"}'
  echo '{"type": "text", "text": "✓ All sprints completed"}'
elif [[ "$PROMPT" =~ /execute-sprint ]]; then
  echo '{"type": "text", "text": "✓ Sprint executed successfully"}'
elif [[ "$PROMPT" =~ /validate-quality ]]; then
  echo '{"type": "text", "text": "✓ Quality validation passed"}'
elif [[ "$PROMPT" =~ /score-opportunity ]]; then
  echo '{"type": "text", "text": "Score: 85/100"}'
elif [[ "$PROMPT" =~ /export-findings ]]; then
  echo '{"type": "text", "text": "✓ Report exported"}'
elif [[ "$PROMPT" =~ /finalize-release ]]; then
  echo '{"type": "text", "text": "✓ Release created"}'
else
  echo '{"type": "text", "text": "Mock response"}'
fi

exit 0
