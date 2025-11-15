# Contributing Guide

**Framework**: Strategic Research Automation
**Last Updated**: 2025-11-14

---

Thank you for your interest in contributing to the Strategic Research Automation Framework! This document provides guidelines for contributing code, documentation, examples, and community support.

## Table of Contents

- [Welcome](#welcome)
- [Ways to Contribute](#ways-to-contribute)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Testing Requirements](#testing-requirements)
- [Pull Request Process](#pull-request-process)
- [Community Guidelines](#community-guidelines)
- [Recognition](#recognition)

---

## Welcome

We welcome contributions of all kinds from the community. Whether you are:
- Fixing a typo in documentation
- Adding a new industry-specific example
- Developing a custom skill
- Improving performance
- Reporting bugs

Your contributions help make this framework better for everyone.

### Project Goals

The Strategic Research Automation Framework aims to:
1. Reduce strategic research time from weeks to hours
2. Maintain high-quality, evidence-based outputs
3. Support multiple industries with minimal customization
4. Provide reusable, maintainable components

---

## Ways to Contribute

### 1. Documentation Contributions

**What we need**:
- Fixing typos, grammar, and clarity issues
- Adding examples and walkthroughs
- Translating documentation to other languages
- Creating video tutorials or guides
- Improving API reference documentation

**How to contribute**:
```bash
# Fork repository
git clone https://github.com/your-username/framework
cd framework

# Create documentation branch
git checkout -b docs/improve-setup-guide

# Make changes
vim docs/SETUP.md

# Commit and push
git add docs/SETUP.md
git commit -m "docs: Improve setup guide for Windows users"
git push origin docs/improve-setup-guide

# Open pull request on GitHub
```

**Guidelines**:
- Follow [style guide](./style-guide.md) for consistency
- Use US English spelling
- Include code examples where helpful
- Test all command examples before submitting

---

### 2. Code Contributions

**What we need**:
- Bug fixes
- New skills for specialized research areas
- Custom slash commands for common workflows
- Performance optimizations
- Test coverage improvements

**How to contribute**:
```bash
# Fork and clone repository
git clone https://github.com/your-username/framework
cd framework

# Create feature branch
git checkout -b feature/add-patent-analysis-skill

# Make changes (e.g., add new skill)
mkdir -p .claude/skills/patent-analyst
vim .claude/skills/patent-analyst/SKILL.md

# Add tests
vim tests/test-patent-analyst.sh

# Run tests locally
./tests/run-all-tests.sh

# Commit with descriptive message
git add .claude/skills/patent-analyst
git commit -m "feat: Add patent analysis skill for competitive intelligence"
git push origin feature/add-patent-analysis-skill

# Open pull request
```

**Guidelines**:
- Write tests for new features
- Follow existing code patterns
- Update documentation for new features
- Run linters before submitting

---

### 3. Example Contributions

**What we need**:
- Industry-specific examples (FinTech, Manufacturing, Energy, etc.)
- Custom configuration examples (startup, enterprise, consultancy)
- Case studies from real projects
- Benchmark results and performance comparisons

**How to contribute**:
```bash
# Create example
mkdir -p examples/fintech-regtech
vim examples/fintech-regtech/README.md
vim examples/fintech-regtech/config/scoring-rubric.yml

# Include sample outputs
mkdir -p examples/fintech-regtech/sample-output
# ... add sample reports

# Submit pull request
git add examples/fintech-regtech
git commit -m "docs: Add FinTech RegTech example with AML use case"
git push origin examples/fintech-regtech
```

**Guidelines**:
- Include complete example (config, context, sample output)
- Anonymize client data or use fictional examples
- Provide README explaining the example
- Include word counts and performance metrics

---

### 4. Testing Contributions

**What we need**:
- Quality validation scripts
- Integration tests
- Performance benchmarks
- Edge case identification

**How to contribute**:
```bash
# Add test script
vim tests/test-quality-validation.sh

# Make executable
chmod +x tests/test-quality-validation.sh

# Run test
./tests/test-quality-validation.sh

# Commit
git add tests/test-quality-validation.sh
git commit -m "test: Add quality validation integration test"
git push origin test/quality-validation
```

**Guidelines**:
- Use bash for test scripts (portable)
- Include expected outputs
- Handle both success and failure cases
- Document test purpose and usage

---

### 5. Community Support

**What we need**:
- Answering questions in GitHub Discussions
- Reviewing pull requests
- Triaging issues (labeling, reproducing bugs)
- Helping new users get started

**How to contribute**:
- Monitor GitHub Discussions for unanswered questions
- Review open pull requests and provide constructive feedback
- Test reported bugs and provide reproduction steps
- Welcome new contributors and help them navigate the codebase

---

## Development Setup

### Prerequisites

- **Git**: Version 2.x or higher
- **Claude Code**: Latest version
- **Bash**: Version 4.x or higher (for scripts)
- **Python**: 3.8+ (optional, for test utilities)
- **Pandoc**: 2.x or higher (optional, for export features)

### Fork and Clone

```bash
# Fork repository on GitHub
# Then clone your fork
git clone https://github.com/your-username/framework
cd framework

# Add upstream remote
git remote add upstream https://github.com/original/framework
git fetch upstream
```

### Create Development Environment

```bash
# Create feature branch
git checkout -b feature/your-feature-name

# Install dependencies (if any)
# Currently, framework has minimal dependencies

# Run tests to verify setup
./tests/run-all-tests.sh
```

### Keep Fork Updated

```bash
# Fetch latest changes from upstream
git fetch upstream

# Merge upstream changes to your main branch
git checkout main
git merge upstream/main

# Rebase your feature branch
git checkout feature/your-feature-name
git rebase main
```

---

## Coding Standards

### Markdown Style

- **Indentation**: 2 spaces (never tabs)
- **Line length**: 80-120 characters (soft limit)
- **Headings**: Use ATX-style (`#`, `##`, `###`)
- **Lists**: Consistent bullet style (`-` for unordered, `1.` for ordered)
- **Code blocks**: Always specify language (` ```bash`, ` ```yaml`)

**Example**:
```markdown
## Section Title

This is a paragraph with proper formatting.

- Bullet point one
- Bullet point two
  - Nested bullet
- Bullet point three

```bash
# Code example
/execute-sprint 01
```
```

### YAML Style

- **Indentation**: 2 spaces (never tabs)
- **Quotes**: Use for strings with special characters
- **Comments**: Inline comments for parameter explanations
- **Alignment**: Align values for readability

**Example**:
```yaml
# Good YAML style
scoring:
  dimensions:
    market_opportunity:
      weight: 0.25                        # Market size and growth
      criteria:
        tam_size: 0.30
        growth_rate: 0.25

# Bad YAML style (avoid)
scoring:
    dimensions:
        market_opportunity:
            weight:0.25  # No space after colon, inconsistent indent
```

### Bash Script Style

- **Shebang**: Always start with `#!/usr/bin/env bash`
- **Error handling**: Use `set -euo pipefail`
- **Functions**: Use functions for reusable logic
- **Comments**: Explain complex logic
- **Variables**: Use `${VAR}` syntax

**Example**:
```bash
#!/usr/bin/env bash
set -euo pipefail

# Function to validate sprint number
validate_sprint_number() {
  local sprint_num="$1"
  if [[ ! "$sprint_num" =~ ^[0-9]{2}$ ]]; then
    echo "Error: Sprint number must be two digits (01-99)"
    return 1
  fi
}

# Main script logic
main() {
  local sprint_num="${1:-}"
  validate_sprint_number "$sprint_num" || exit 1
  echo "Executing sprint ${sprint_num}..."
}

main "$@"
```

### Skill Prompt Style

- **Clear activation triggers**: Define specific keywords
- **Structured research areas**: Organize by category
- **Output format specification**: Define expected file structure
- **Quality criteria**: State evidence requirements

**Example**:
```markdown
---
name: custom-analyst
description: "Analyzes [domain-specific area] with focus on [key aspects]"
activation-triggers:
  - keyword1
  - keyword2
  - phrase pattern
---

# Custom Analyst Skill

You are a [role] specializing in [expertise areas].

## Research Areas

### 1. [Category Name]
- [Specific research question]
- [Specific research question]

[... additional categories ...]

## Output Format

Generate research files in `temp/<NN>-sprint/<task>/`:
1. `file-name-1.md` - [Description]
2. `file-name-2.md` - [Description]

## Quality Standards

- Citation ratio ≥80%
- Primary sources preferred
- [Domain-specific requirements]
```

---

## Testing Requirements

### Unit Tests

**Required for**:
- New skills
- New commands
- Utility scripts

**Example** (`tests/test-custom-skill.sh`):
```bash
#!/usr/bin/env bash
set -euo pipefail

# Test custom skill activation
test_skill_activation() {
  local result
  result=$(echo "trigger keyword" | ./scripts/setup/claude-eng -p "/execute-task 01 01")

  if [[ "$result" =~ "custom-analyst skill activated" ]]; then
    echo "PASS: Skill activation"
    return 0
  else
    echo "FAIL: Skill activation"
    return 1
  fi
}

# Run tests
test_skill_activation
```

### Integration Tests

**Required for**:
- End-to-end workflows
- Configuration changes
- Cross-component features

**Example** (`tests/test-sprint-execution.sh`):
```bash
#!/usr/bin/env bash
set -euo pipefail

# Test complete sprint execution
test_sprint_execution() {
  # Initialize project
  /init-project "Test Project" "technology sector" "Test Company"

  # Create sprint
  /create-sprint 01 "Test Sprint" "Test description"

  # Execute sprint
  /execute-sprint 01

  # Validate outputs
  if [[ -f "reports/01-sprint-report.md" ]]; then
    echo "PASS: Sprint execution"
    return 0
  else
    echo "FAIL: Report not generated"
    return 1
  fi
}

test_sprint_execution
```

### Test Coverage

Aim for:
- **Unit tests**: 80%+ coverage of new code
- **Integration tests**: All major workflows
- **Documentation**: All code examples tested

---

## Pull Request Process

### Before Submitting

- [ ] Create feature branch from `main`
- [ ] Write clear, atomic commits
- [ ] Update documentation for new features
- [ ] Run tests locally (`./tests/run-all-tests.sh`)
- [ ] Update `CHANGELOG.md` with changes
- [ ] Run linters (shellcheck for bash, markdownlint for docs)

### PR Template

When opening a pull request, use this template:

```markdown
## Description
[Clear description of what this PR does]

## Related Issue
Fixes #[issue number] (if applicable)

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Example/tutorial
- [ ] Test improvement

## Testing
[Describe how you tested this change]

## Checklist
- [ ] Tests pass locally
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Code follows style guidelines
- [ ] No linting errors
```

### Review Process

1. **Automatic checks**: CI/CD runs tests and linters
2. **Maintainer review**: Maintainer reviews code and provides feedback (typically within 48 hours)
3. **Revisions**: Address feedback and push updates
4. **Approval**: Once approved, maintainer will merge
5. **Merge**: Squash and merge to `main` branch

### Commit Message Guidelines

Use conventional commits format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `test`: Test additions or changes
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `chore`: Build process or auxiliary tool changes

**Examples**:
```
feat(skills): Add patent analysis skill for competitive intelligence

- Analyzes patent landscape for opportunities
- Identifies IP gaps and freedom-to-operate risks
- Generates patent citation network diagrams

Closes #42
```

```
fix(config): Correct YAML validation for scoring rubric

- Fix bug where weights not validated to sum to 1.0
- Add validation error message with corrective guidance
- Add test case for weight validation

Fixes #58
```

---

## Community Guidelines

### Code of Conduct

We are committed to providing a welcoming and inclusive environment. All contributors must:

- **Be respectful**: Treat all community members with respect
- **Be inclusive**: Welcome newcomers and diverse perspectives
- **Give constructive feedback**: Focus on improvement, not criticism
- **Assume good intentions**: Give benefit of the doubt
- **No harassment**: Zero tolerance for harassment or discrimination

### Communication Channels

- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: Questions, ideas, and general discussion
- **Pull Requests**: Code contributions and reviews

### Asking for Help

When asking for help:
1. Search existing issues and discussions first
2. Provide clear, reproducible examples
3. Include environment details (OS, Claude Code version, etc.)
4. Be patient - maintainers and community are volunteers

---

## Recognition

### Contributors

All contributors are acknowledged in:
- `README.md` contributors section
- `CHANGELOG.md` release notes
- GitHub repository insights

### Significant Contributions

Contributors with sustained, significant contributions may be invited to:
- Become repository maintainers
- Join core team discussions
- Shape framework roadmap

---

## Questions?

If you have questions about contributing:
- Open a GitHub Discussion
- Tag maintainers in your question
- Review existing documentation first

Thank you for contributing to the Strategic Research Automation Framework!

---

**Document Version**: 1.0
**Word Count**: ~1,450 words
**Last Updated**: 2025-11-14
