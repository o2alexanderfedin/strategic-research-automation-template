#!/usr/bin/env bats
# Tests for scripts/run-autonomous-analysis.sh

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup() {
  TEST_TEMP_DIR="$(mktemp -d)"
  export TEST_TEMP_DIR
  export CLAUDE_CMD="$PWD/test/mocks/mock-claude-cmd.sh"
}

teardown() {
  rm -rf "$TEST_TEMP_DIR"
}

@test "run-autonomous-analysis.sh exists and is executable" {
  [[ -x scripts/run-autonomous-analysis.sh ]]
}

@test "run-autonomous-analysis.sh passes shellcheck with zero warnings" {
  shellcheck scripts/run-autonomous-analysis.sh
}

@test "run-autonomous-analysis.sh validates arguments" {
  run scripts/run-autonomous-analysis.sh
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Usage:" ]]
}

@test "run-autonomous-analysis.sh displays autonomous banner" {
  run scripts/run-autonomous-analysis.sh "Test Project" "TestCo"
  [[ "$output" =~ "AUTONOMOUS" || "$output" =~ "Pipeline" ]]
}
