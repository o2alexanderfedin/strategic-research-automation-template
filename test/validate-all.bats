#!/usr/bin/env bats
# Tests for scripts/validate-all.sh

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

@test "validate-all.sh exists and is executable" {
  [[ -x scripts/validate-all.sh ]]
}

@test "validate-all.sh passes shellcheck with zero warnings" {
  shellcheck scripts/validate-all.sh
}

@test "validate-all.sh finds sprint directories" {
  run scripts/validate-all.sh
  [[ "$output" =~ "Found" || "$output" =~ "Validating" ]]
}

@test "validate-all.sh displays summary" {
  run scripts/validate-all.sh
  [[ "$output" =~ "Summary" || "$output" =~ "PASSED" || "$output" =~ "FAILED" ]]
}
