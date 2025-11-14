#!/usr/bin/env bats
# Tests for scripts/run-complete-analysis.sh

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

@test "run-complete-analysis.sh exists and is executable" {
  [[ -x scripts/run-complete-analysis.sh ]]
}

@test "run-complete-analysis.sh passes shellcheck with zero warnings" {
  shellcheck scripts/run-complete-analysis.sh
}

@test "run-complete-analysis.sh validates arguments" {
  run scripts/run-complete-analysis.sh
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Usage:" ]]
}

@test "run-complete-analysis.sh displays pipeline banner" {
  run scripts/run-complete-analysis.sh "Test Project" "Tech" "TestCo" "Sprint1|Desc1"
  [[ "$output" =~ "Strategic Research" || "$output" =~ "Pipeline" ]]
}
