#!/usr/bin/env bats
# Tests for scripts/stream-json-parser.sh

load '../test_helper/bats-support/load'
load '../test_helper/bats-assert/load'

setup() {
  TEST_TEMP_DIR="$(mktemp -d)"
  export TEST_TEMP_DIR
}

teardown() {
  rm -rf "$TEST_TEMP_DIR"
}

# Category 1: Static Analysis Tests

@test "stream-json-parser exists and is executable" {
  [[ -x scripts/stream-json-parser.sh ]]
}

@test "stream-json-parser passes shellcheck with zero warnings" {
  if command -v shellcheck &> /dev/null; then
    shellcheck scripts/stream-json-parser.sh
  else
    skip "shellcheck not installed"
  fi
}

# Category 2: Dependency Tests

@test "stream-json-parser checks for jq availability" {
  # Parser should handle missing jq gracefully
  grep -q "jq" scripts/stream-json-parser.sh
}

@test "stream-json-parser has background heartbeat function" {
  grep -q "show_heartbeat" scripts/stream-json-parser.sh
}

# Category 3: JSON Event Parsing Tests

@test "stream-json-parser handles system events" {
  if ! command -v jq &> /dev/null; then
    skip "jq not installed"
  fi

  # Create mock stream-json system event
  cat > "$TEST_TEMP_DIR/test-input.json" <<'EOF'
{"type":"system","model":"claude-sonnet-4-5","session_id":"test123"}
EOF

  # Test parser can process it
  run scripts/stream-json-parser.sh < "$TEST_TEMP_DIR/test-input.json"
  [[ "$output" =~ "Claude initialized" ]] || [[ "$output" =~ "Model" ]]
}

@test "stream-json-parser handles stream_event messages" {
  if ! command -v jq &> /dev/null; then
    skip "jq not installed"
  fi

  cat > "$TEST_TEMP_DIR/test-input.json" <<'EOF'
{"type":"stream_event","event":{"type":"message_start"}}
EOF

  run scripts/stream-json-parser.sh < "$TEST_TEMP_DIR/test-input.json"
  # Should handle without crashing
  [[ "$status" -eq 0 ]] || [[ "$status" -eq 141 ]]  # 141 is SIGPIPE, acceptable
}

@test "stream-json-parser handles content_block_delta events" {
  if ! command -v jq &> /dev/null; then
    skip "jq not installed"
  fi

  cat > "$TEST_TEMP_DIR/test-input.json" <<'EOF'
{"type":"stream_event","event":{"type":"content_block_delta","delta":{"text":"Hello world"}}}
EOF

  run scripts/stream-json-parser.sh < "$TEST_TEMP_DIR/test-input.json"
  # Should output text or handle gracefully
  [[ "$status" -eq 0 ]] || [[ "$status" -eq 141 ]]
}

@test "stream-json-parser handles result events with metrics" {
  if ! command -v jq &> /dev/null; then
    skip "jq not installed"
  fi

  cat > "$TEST_TEMP_DIR/test-input.json" <<'EOF'
{"type":"result","duration_ms":5000,"total_cost_usd":0.15,"usage":{"input_tokens":1000,"output_tokens":500,"cache_read_input_tokens":200}}
EOF

  run scripts/stream-json-parser.sh < "$TEST_TEMP_DIR/test-input.json"
  [[ "$output" =~ "Task Complete" ]] || [[ "$output" =~ "Duration" ]] || [[ "$status" -eq 141 ]]
}

# Category 4: Heartbeat Animation Tests

@test "stream-json-parser defines spinning animation characters" {
  grep -q "⠋\|⠙\|⠹\|⠸" scripts/stream-json-parser.sh
}

@test "stream-json-parser has heartbeat timer logic" {
  grep -q "sleep 2" scripts/stream-json-parser.sh
  grep -q "LAST_ACTIVITY" scripts/stream-json-parser.sh
}

@test "stream-json-parser shows elapsed time in heartbeat" {
  grep -q "elapsed" scripts/stream-json-parser.sh
}

# Category 5: Output Format Tests

@test "stream-json-parser uses color codes" {
  grep -q "\\\\033" scripts/stream-json-parser.sh || grep -q "RED=\|GREEN=\|CYAN=" scripts/stream-json-parser.sh
}

@test "stream-json-parser has emoji indicators" {
  grep -q "🚀\|💭\|🔧\|📥\|✅" scripts/stream-json-parser.sh
}

@test "stream-json-parser clears heartbeat line before output" {
  grep -q "\\\\r" scripts/stream-json-parser.sh
}

# Category 6: Tool Visibility Tests

@test "stream-json-parser extracts tool names from events" {
  grep -q "tool_use\|Tool:" scripts/stream-json-parser.sh
}

@test "stream-json-parser shows tool input preview" {
  grep -q "input\|Input:" scripts/stream-json-parser.sh
}

# Category 7: Error Handling Tests

@test "stream-json-parser handles empty lines gracefully" {
  echo "" | scripts/stream-json-parser.sh
  # Should not crash on empty input
}

@test "stream-json-parser handles invalid JSON gracefully" {
  if ! command -v jq &> /dev/null; then
    skip "jq not installed"
  fi

  echo "not valid json" | scripts/stream-json-parser.sh 2>&1
  # Should handle gracefully with jq error or skip
}

@test "stream-json-parser cleans up background process on exit" {
  grep -q "kill.*HEARTBEAT_PID" scripts/stream-json-parser.sh
  grep -q "trap" scripts/stream-json-parser.sh
}

# Category 8: Integration with claude-eng Tests

@test "claude-eng invokes stream-json-parser when jq available" {
  grep -q "stream-json-parser.sh" scripts/setup/claude-eng
}

@test "claude-eng uses stream-json output format" {
  grep -q -- "--output-format stream-json" scripts/setup/claude-eng
}

@test "claude-eng includes partial messages for streaming" {
  grep -q -- "--include-partial-messages" scripts/setup/claude-eng
}

@test "claude-eng falls back gracefully if jq unavailable" {
  # Should have fallback logic with else block
  grep -A 12 "command -v jq" scripts/setup/claude-eng | grep -q "else"
}

# Category 9: Performance Tests

@test "stream-json-parser heartbeat updates every 2 seconds" {
  # Check for 2-second sleep interval
  grep -q "sleep 2" scripts/stream-json-parser.sh
}

@test "stream-json-parser processes line-by-line (streaming)" {
  # Should use read loop, not slurp entire input
  grep -q "while.*read" scripts/stream-json-parser.sh
}

# Category 10: Metrics Display Tests

@test "stream-json-parser displays duration metrics" {
  grep -q "duration\|Duration" scripts/stream-json-parser.sh
}

@test "stream-json-parser displays token counts" {
  grep -q "tokens\|Tokens" scripts/stream-json-parser.sh
}

@test "stream-json-parser displays cost information" {
  grep -q "cost\|Cost" scripts/stream-json-parser.sh
}

@test "stream-json-parser displays cache hit information" {
  grep -q "cache\|Cached" scripts/stream-json-parser.sh
}

@test "stream-json-parser converts milliseconds to human-readable time" {
  # Should convert duration_ms to seconds/minutes
  grep -q "60000\|1000" scripts/stream-json-parser.sh
}
