#!/usr/bin/env bats
# Tests for scripts/run-sprints-incremental.sh

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup() {
  TEST_TEMP_DIR="$(mktemp -d)"
  export TEST_TEMP_DIR
  export CLAUDE_CMD="$PWD/test/mocks/mock-claude-cmd.sh"
  mkdir -p sprints/01-test-sprint
}

teardown() {
  rm -rf "$TEST_TEMP_DIR"
  rm -rf sprints/01-test-sprint
}

@test "run-sprints-incremental.sh exists and is executable" {
  [[ -x scripts/run-sprints-incremental.sh ]]
}

@test "run-sprints-incremental.sh passes shellcheck with zero warnings" {
  shellcheck scripts/run-sprints-incremental.sh
}

@test "run-sprints-incremental.sh finds sprint directories" {
  run scripts/run-sprints-incremental.sh < /dev/null
  [[ "$output" =~ "Found" || "$output" =~ "Incremental" ]]
}
