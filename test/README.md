# Test Suite Documentation

Comprehensive testing for the Strategic Research Automation Template.

---

## Quick Reference

| Test Suite | Files | Duration | Purpose |
|------------|-------|----------|---------|
| **Setup Tests** | 50 tests | <30s | Validate installation and wrapper scripts |
| **Quality Tests** | 41 tests | <10s | Enforce Mermaid diagrams and quality standards |
| **Documentation Tests** | 7 tests | <5s | Validate README and docs |
| **Command Tests** | 100+ tests | <1min | Validate slash command structure |
| **Integration Tests** | Various | 1-8 hours | End-to-end validation (expensive!) |

**Total Fast Tests**: 198+ tests in <2 minutes, $0 cost

---

## Running Tests

### All Fast Tests (Recommended)

```bash
# Run all setup and quality tests
bats test/setup/*.bats test/quality/*.bats

# Run documentation tests
bash tests/documentation/test-readme.sh

# Run command validation
bash scripts/test/comprehensive-testing.sh
```

### Individual Test Suites

#### 1. Setup Tests (50 tests)

```bash
# All setup tests
bats test/setup/*.bats

# Individual suites
bats test/setup/install.bats           # Installation script tests
bats test/setup/claude-eng.bats        # Wrapper script tests
bats test/setup/stream-json-parser.bats # Parser tests (NEW in v3.4.0)
```

**Coverage**:
- Installation script validation
- claude-eng wrapper functionality
- Stream-JSON parser implementation
- Argument passing and validation
- Error handling
- Security (no credential exposure)
- Shellcheck compliance

#### 2. Quality Tests (41 tests)

```bash
# Mermaid diagram enforcement
bats test/quality/mermaid-diagrams.bats
```

**Coverage** (NEW in v3.4.1):
- CLAUDE.md mandates Mermaid diagrams
- All skills enforce Mermaid over ASCII art
- Diagram type mappings documented
- Consistency across skills
- Benefits and use cases covered
- Template compliance

#### 3. Documentation Tests

```bash
# README validation
bash tests/documentation/test-readme.sh
```

**Coverage**:
- Installation steps present
- All skills mentioned
- Commands referenced
- Badges and visual elements
- Quick start guide completeness

#### 4. Command Tests (100+ tests)

```bash
# Comprehensive command validation
bash scripts/test/comprehensive-testing.sh
```

**Coverage** (10 categories):
1. Command invocation (YAML frontmatter, descriptions)
2. Argument handling (validation, references)
3. Functional testing (directory creation, skill integration)
4. Integration testing (command chaining)
5. Tool access (allowed-tools fields)
6. Error handling (error sections, validation)
7. Output validation (expected output sections)
8. Performance (parallelization, file sizes)
9. User experience (descriptions, success criteria)
10. Command-skill integration

---

## Test Categories

### Fast Tests (CI/CD)

**Run on every commit** - cheap, fast, deterministic:

- ✅ **Static Analysis**: shellcheck, YAML validation
- ✅ **Structure**: File existence, permissions
- ✅ **Content**: Required sections, formatting
- ✅ **Logic**: Argument handling, error paths
- ✅ **Quality**: Mermaid enforcement, standards
- ✅ **Security**: No credential exposure

**Characteristics**:
- Duration: <2 minutes total
- Cost: $0 (no API calls)
- Deterministic: Same input = same output
- Non-blocking: Safe for CI/CD

### Integration Tests (Manual/Scheduled)

**Run weekly or pre-release** - expensive, slow, valuable:

See [`test/integration/README.md`](integration/README.md) for details.

**Characteristics**:
- Duration: 1-8 hours
- Cost: $15-$200 per run
- Non-deterministic: AI outputs vary
- Blocking: Not suitable for per-commit CI/CD

---

## New in v3.4.0+

### Stream-JSON Parser Tests (v3.4.0)

**File**: `test/setup/stream-json-parser.bats`
**Tests**: 30
**Coverage**:
- Parser existence and shellcheck compliance
- JSON event parsing (system, stream_event, result)
- Heartbeat animation (spinning indicators)
- Output formatting (colors, emojis)
- Tool visibility and metadata display
- Error handling (empty input, invalid JSON)
- Integration with claude-eng wrapper
- Performance (streaming, 2-second heartbeat)

### Mermaid Diagram Tests (v3.4.1)

**File**: `test/quality/mermaid-diagrams.bats`
**Tests**: 41
**Coverage**:
- CLAUDE.md mandates Mermaid, prohibits ASCII art
- All diagram-creating skills enforce Mermaid
- Visualization standards sections present
- Diagram type mappings (flowchart, sequence, Gantt, etc.)
- Benefits documentation (professional, scalable)
- Use case coverage (architecture, data flows, timelines)
- Template compliance

---

## Test Organization

```
test/
├── README.md                          # This file
├── setup/                             # Setup and wrapper tests
│   ├── install.bats                   # Installation script
│   ├── claude-eng.bats                # Wrapper script
│   └── stream-json-parser.bats        # Stream-JSON parser (NEW)
├── quality/                           # Quality enforcement tests
│   └── mermaid-diagrams.bats          # Diagram standards (NEW)
├── integration/                       # Expensive end-to-end tests
│   ├── README.md                      # Integration test docs
│   └── single-sprint-test.sh          # Quick validation (~1hr)
├── test_helper/                       # BATS testing libraries
│   ├── bats-assert/                   # Assertion helpers
│   └── bats-support/                  # Support utilities
└── fixtures/                          # Test data
    ├── test-client.md
    └── test-company.md
```

---

## Writing New Tests

### BATS Test Template

```bash
#!/usr/bin/env bats
# Tests for <component>

load '../test_helper/bats-support/load'
load '../test_helper/bats-assert/load'

setup() {
  TEST_TEMP_DIR="$(mktemp -d)"
  export TEST_TEMP_DIR
}

teardown() {
  rm -rf "$TEST_TEMP_DIR"
}

@test "component exists and is executable" {
  [[ -x path/to/component ]]
}

@test "component passes shellcheck" {
  if command -v shellcheck &> /dev/null; then
    shellcheck path/to/component
  else
    skip "shellcheck not installed"
  fi
}

# Add more tests...
```

### Test Categories

Organize tests into these categories:

1. **Static Analysis** - File existence, shellcheck, permissions
2. **Argument Validation** - Input handling, error cases
3. **Error Conditions** - Missing files, invalid input
4. **Function-Level Unit** - Individual function behavior
5. **Integration Workflow** - Component interactions
6. **Output Format** - Correct output structure
7. **Security** - No credential exposure
8. **Performance** - Speed, efficiency checks
9. **User Experience** - Help messages, clarity
10. **Standards Compliance** - Quality requirements

---

## CI/CD Integration

### GitHub Actions (Recommended)

```yaml
# .github/workflows/fast-tests.yml
name: Fast Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install BATS
        run: |
          sudo apt-get update
          sudo apt-get install -y bats
      - name: Install shellcheck
        run: sudo apt-get install -y shellcheck
      - name: Run Setup Tests
        run: bats test/setup/*.bats
      - name: Run Quality Tests
        run: bats test/quality/*.bats
      - name: Run Documentation Tests
        run: bash tests/documentation/test-readme.sh
      - name: Run Command Tests
        run: bash scripts/test/comprehensive-testing.sh
```

### Pre-commit Hooks

```bash
# .git/hooks/pre-commit
#!/bin/bash
echo "Running fast tests..."
bats test/setup/*.bats test/quality/*.bats || exit 1
bash tests/documentation/test-readme.sh || exit 1
echo "✅ All tests passed!"
```

---

## Troubleshooting

### BATS Not Found

```bash
# macOS
brew install bats-core

# Ubuntu/Debian
sudo apt-get install bats

# Manual install
git clone https://github.com/bats-core/bats-core.git
cd bats-core
sudo ./install.sh /usr/local
```

### Shellcheck Warnings

Tests will fail if shellcheck finds issues. Fix them:

```bash
# Check specific file
shellcheck scripts/stream-json-parser.sh

# Disable specific warning (use sparingly)
# shellcheck disable=SC2034
VARIABLE="value"
```

### Tests Pass Locally, Fail in CI

**Common causes**:
- Different shellcheck versions
- Missing dependencies (jq, etc.)
- Path differences (use absolute paths in tests)
- Environment variables not set

**Solution**: Run tests in clean environment:

```bash
docker run --rm -v "$PWD:/work" -w /work ubuntu:latest bash -c "
  apt-get update && apt-get install -y bats shellcheck jq
  bats test/setup/*.bats test/quality/*.bats
"
```

---

## Best Practices

1. **Fast Tests First**: Keep fast tests (<5min) separate from slow integration tests
2. **No API Calls**: Fast tests should never make real API calls
3. **Cleanup**: Always cleanup temp files in teardown()
4. **Skip Gracefully**: Use `skip "reason"` for optional dependencies
5. **Clear Names**: Test names should clearly describe what's being tested
6. **Categories**: Group related tests by category comments
7. **Shellcheck**: All shell scripts must pass shellcheck
8. **Mocks**: Use mocks for external dependencies
9. **Assertions**: Use bats-assert helpers for clear error messages
10. **Documentation**: Update this README when adding test suites

---

## Support

**Questions?**
- Fast tests: See this file
- Integration tests: See `integration/README.md`
- BATS syntax: https://bats-core.readthedocs.io/
- GitHub issues: https://github.com/o2alexanderfedin/strategic-research-automation-template/issues

**Remember**: Tests are documentation that never goes out of date!
