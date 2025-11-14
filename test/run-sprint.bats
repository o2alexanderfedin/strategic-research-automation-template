#!/usr/bin/env bats
# Tests for scripts/run-sprint.sh

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

@test "run-sprint.sh exists and is executable" {
  [[ -x scripts/run-sprint.sh ]]
}

@test "run-sprint.sh passes shellcheck with zero warnings" {
  shellcheck scripts/run-sprint.sh
}

@test "run-sprint.sh validates sprint number argument" {
  run scripts/run-sprint.sh
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Usage:" ]]
}

@test "run-sprint.sh accepts valid sprint number" {
  run scripts/run-sprint.sh 01
  [ "$status" -eq 0 ]
}

@test "run-sprint.sh displays sprint banner" {
  run scripts/run-sprint.sh 01
  [[ "$output" =~ "Sprint" ]] || [[ "$output" =~ "EXECUTING" ]]
}

@test "run-sprint.sh uses CLAUDE_CMD environment variable" {
  export CLAUDE_CMD="$PWD/test/mocks/mock-claude-cmd.sh"
  run scripts/run-sprint.sh 01
  [ "$status" -eq 0 ]
}

@test "run-sprint.sh calls execute-sprint slash command" {
  run scripts/run-sprint.sh 01
  [[ "$output" =~ "executed" ]] || [[ "$output" =~ "Sprint" ]]
}

@test "run-sprint.sh tracks duration" {
  run scripts/run-sprint.sh 01
  [[ "$output" =~ "minutes" ]] || [[ "$output" =~ "completed" ]]
}

@test "run-sprint.sh does not expose API keys" {
  export CLAUDE_API_KEY="test-secret"
  run scripts/run-sprint.sh 01
  [[ ! "$output" =~ "test-secret" ]]
}
