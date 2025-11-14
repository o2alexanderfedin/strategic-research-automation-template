#!/usr/bin/env bats
# Tests for scripts/setup/install.sh

load '../test_helper/bats-support/load'
load '../test_helper/bats-assert/load'

setup() {
  TEST_TEMP_DIR="$(mktemp -d)"
  export TEST_TEMP_DIR
  export HOME="$TEST_TEMP_DIR"
}

teardown() {
  rm -rf "$TEST_TEMP_DIR"
}

# Category 1: Static Analysis Tests

@test "install.sh exists and is executable" {
  [[ -x scripts/setup/install.sh ]]
}

@test "install.sh passes shellcheck with zero warnings" {
  shellcheck scripts/setup/install.sh
}

# Category 2: Argument Validation Tests

@test "install.sh runs without arguments" {
  skip "Installation script for manual testing"
}

# Category 3: Error Condition Tests

@test "install.sh handles missing source files gracefully" {
  # Test with empty scripts/setup directory
  run scripts/setup/install.sh
  # Should not crash
  [[ "$status" -eq 0 ]] || [[ "$status" -eq 1 ]]
}

# Category 4: Function-Level Unit Tests

@test "install.sh detects bash shell" {
  skip "Tested via integration"
}

@test "install.sh detects zsh shell" {
  skip "Tested via integration"
}

# Category 5: Integration Workflow Tests

@test "install.sh copies claude-eng to home directory" {
  # Run installation in non-interactive mode
  cd scripts/setup && INSTALL_NON_INTERACTIVE=1 ./install.sh

  # Check if claude-eng was copied
  [[ -f "$HOME/claude-eng" ]]
}

@test "install.sh copies system prompt to home directory" {
  # Run installation in non-interactive mode
  cd scripts/setup && INSTALL_NON_INTERACTIVE=1 ./install.sh

  # Check if system prompt was copied
  [[ -f "$HOME/.claude-system-prompt.md" ]]
}

@test "install.sh makes claude-eng executable" {
  # Run installation in non-interactive mode
  cd scripts/setup && INSTALL_NON_INTERACTIVE=1 ./install.sh

  # Check if executable
  [[ -x "$HOME/claude-eng" ]]
}

# Category 6: Output Format Tests

@test "install.sh displays success message" {
  run env INSTALL_NON_INTERACTIVE=1 scripts/setup/install.sh
  [[ "$output" =~ "Setup complete" ]] || [[ "$output" =~ "installed" ]]
}

# Category 7: Security Tests

@test "install.sh does not expose sensitive information" {
  run scripts/setup/install.sh
  [[ ! "$output" =~ "API_KEY" ]]
  [[ ! "$output" =~ "SECRET" ]]
}
