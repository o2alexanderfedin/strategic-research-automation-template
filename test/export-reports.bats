#!/usr/bin/env bats
# Tests for scripts/export-reports.sh

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup() {
  TEST_TEMP_DIR="$(mktemp -d)"
  export TEST_TEMP_DIR
  export CLAUDE_CMD="$PWD/test/mocks/mock-claude-cmd.sh"
  mkdir -p reports
  echo "# Test Report" > reports/01-test-report.md
}

teardown() {
  rm -rf "$TEST_TEMP_DIR"
  rm -f reports/01-test-report.md
}

@test "export-reports.sh exists and is executable" {
  [[ -x scripts/export-reports.sh ]]
}

@test "export-reports.sh passes shellcheck with zero warnings" {
  shellcheck scripts/export-reports.sh
}

@test "export-reports.sh validates format argument" {
  run scripts/export-reports.sh invalid
  [ "$status" -eq 1 ]
}

@test "export-reports.sh accepts pdf format" {
  run scripts/export-reports.sh pdf
  [[ "$output" =~ "Export" || "$output" =~ "pdf" ]]
}

@test "export-reports.sh accepts all format" {
  run scripts/export-reports.sh all
  [[ "$output" =~ "Export" || "$output" =~ "all" ]]
}

@test "export-reports.sh finds report files" {
  run scripts/export-reports.sh pdf
  [[ "$output" =~ "Found" ]]
}
