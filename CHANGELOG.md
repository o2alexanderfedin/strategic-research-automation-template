# Changelog

All notable changes to the Strategic Research Automation Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Planned

- Complete documentation suite (in progress)
- Advanced export formats (HTML, interactive reports)
- Multi-language support for reports
- Web UI for non-technical users
- Integration with external data sources (APIs, databases)

---

## [2.0.0] - 2025-11-14

### Added

- **Sprint 04: Bash Automation Scripts** - Complete autonomous execution framework
  - `scripts/run-autonomous-analysis.sh` - Fully autonomous discovery + execution
  - `scripts/run-complete-analysis.sh` - Full project execution pipeline
  - `scripts/run-sprint.sh` - Single sprint execution with validation
  - `scripts/export-reports.sh` - Multi-format export automation
  - `scripts/validate-all.sh` - Quality validation pipeline
  - `scripts/run-sprints-incremental.sh` - Incremental execution with checkpoints
  - YOLO mode wrapper (`claude-eng`) for unrestricted operations
  - Docker containerization for isolated execution
  - CI/CD pipeline (`.github/workflows/ci-research-pipeline.yml`)
  - 50+ BATS tests with 100% pass rate

- **Sprint 05: Documentation & Setup Guides** (in progress)
  - Comprehensive README with real project results
  - Complete setup and installation guide
  - Quick start tutorial (5-minute walkthrough)
  - Test infrastructure for documentation validation

### Changed

- Updated template structure for Sprint 04 automation
- Enhanced git flow integration with automated releases
- Improved error handling and logging across all scripts

### Fixed

- Shellcheck compliance across all automation scripts (zero warnings)
- Race conditions in parallel sprint execution
- Configuration validation edge cases

---

## [1.0.0] - 2025-11-08

### Added

- **Sprint 02: Claude Code Skills** - Eight specialized research agents
  - Sprint Orchestrator skill
  - Opportunity Discovery skill (autonomous sprint identification)
  - Technical Researcher skill (Task 01 specialization)
  - Market Analyst skill (Task 02 specialization)
  - Solution Architect skill (Task 03 specialization)
  - Compliance Analyst skill (Task 04 specialization)
  - Roadmap Planner skill (Task 05 specialization)
  - Report Synthesizer skill (Task 06 specialization)

- **Sprint 03: Slash Commands** - Thirteen workflow automation commands
  - `/init-project` - Project initialization
  - `/discover-opportunities` - Autonomous opportunity discovery
  - `/create-sprint` - Sprint configuration
  - `/execute-task` - Single task execution
  - `/execute-sprint` - Complete sprint execution
  - `/execute-all` - Multi-sprint batch execution
  - `/synthesize-report` - Report generation
  - `/score-opportunity` - Rubric-based scoring
  - `/compare-sprints` - Comparative analysis
  - `/export-findings` - Multi-format export
  - `/validate-quality` - Quality assurance
  - `/update-context` - Context management
  - `/finalize-release` - Git release automation

### Changed

- Transitioned from single-sprint to multi-sprint architecture
- Enhanced parallel execution with CPU-aware task limits
- Improved evidence-based research with citation tracking

---

## [0.2.0] - 2025-10-30

### Added

- **Sprint 01: Template Repository Structure**
  - Directory organization (`.claude/`, `config/`, `context/`, `sprints/`, `temp/`, `reports/`)
  - Configuration file templates (project-config.yml, sprint-config.yml, quality-standards.yml, scoring-rubric.yml, glossary.yml)
  - Context file templates (company-profile.md, client-info.md, industry-background.md)
  - Sprint and task templates
  - Example configurations for aviation industry

### Changed

- Standardized file naming conventions
- Enhanced YAML configuration validation

---

## [0.1.0] - 2025-10-15

### Added

- **Sprint 00: GitHub Repository Setup**
  - Initial repository structure
  - MIT License
  - Basic README
  - .gitignore configuration
  - Git LFS for large files
  - GitHub template designation

### Changed

- Repository visibility (private → public)
- GitHub repository settings optimized for template usage

---

## Version Numbering

### Semantic Versioning Guidelines

**MAJOR version** (X.0.0):
- Incompatible API changes
- Major architecture redesigns
- Breaking changes to configuration formats
- Removal of deprecated features

**MINOR version** (0.X.0):
- New features (new skills, commands, capabilities)
- Backwards-compatible functionality additions
- New industry examples or templates
- Enhanced automation workflows

**PATCH version** (0.0.X):
- Bug fixes
- Documentation improvements
- Performance optimizations
- Minor configuration updates

---

## Upgrade Notes

### Upgrading from v1.x to v2.0

**Breaking Changes**:
- Bash automation scripts require new environment variables
- Configuration file schema updated (auto-migration provided)
- YOLO mode setup requires one-time installation

**Migration Steps**:

```bash
# 1. Backup current configuration
cp -r config config.backup

# 2. Pull latest template
git fetch template
git merge template/main

# 3. Run migration script
./scripts/migrate-v1-to-v2.sh

# 4. Verify configuration
yamllint config/*.yml

# 5. Test with single sprint
./scripts/run-sprint.sh 01
```

### Upgrading from v0.x to v1.0

**Breaking Changes**:
- Skills and commands introduced (requires Claude Code v2.0+)
- Configuration structure changed significantly

**Migration Steps**:

```bash
# 1. Upgrade Claude Code
claude --upgrade

# 2. Pull latest template
git fetch template
git merge template/main

# 3. Manually merge configuration changes
# Compare config.backup/ with new config/ templates

# 4. Test skills
claude -p "/init-project 'Test' 'Industry' 'Company'"
```

---

## Deprecation Warnings

### Deprecated in v2.0 (to be removed in v3.0)

- **Old sprint execution method**: Direct Claude prompts without commands
  - Use `/execute-sprint` instead
  - Migration: Replace `claude -p "Execute sprint 01"` with `claude -p "/execute-sprint 01"`

- **Manual report synthesis**: Creating reports without `/synthesize-report` command
  - Use automated synthesis for consistency
  - Migration: Use `/synthesize-report <sprint-id>`

### Removed in v2.0

- **Deprecated in v1.0**:
  - Single-file configuration (replaced by modular config/)
  - Hardcoded quality thresholds (now in quality-standards.yml)

---

## Contribution Guidelines

### How to Update CHANGELOG

When contributing changes:

1. **Add entry to [Unreleased]** section
2. **Use appropriate category**: Added, Changed, Deprecated, Removed, Fixed, Security
3. **Be specific**: Link to issues/PRs when relevant
4. **Follow format**: Keep consistent style

**Example**:

```markdown
### Added

- New healthcare industry template ([#123](link-to-pr))
- Custom scoring rubric for regulatory compliance ([#124](link-to-pr))
```

### Release Process

1. Update [Unreleased] section with all changes
2. Create new version section (e.g., `## [2.1.0] - 2025-12-01`)
3. Move relevant [Unreleased] items to new version
4. Update version links at bottom
5. Create git tag: `git tag -a v2.1.0 -m "Release v2.1.0"`
6. Push tag: `git push --tags`

---

## Links

- [Repository](https://github.com/o2alexanderfedin/strategic-research-automation-template)
- [Issues](https://github.com/o2alexanderfedin/strategic-research-automation-template/issues)
- [Discussions](https://github.com/o2alexanderfedin/strategic-research-automation-template/discussions)
- [Releases](https://github.com/o2alexanderfedin/strategic-research-automation-template/releases)

---

[Unreleased]: https://github.com/o2alexanderfedin/strategic-research-automation-template/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/o2alexanderfedin/strategic-research-automation-template/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/o2alexanderfedin/strategic-research-automation-template/compare/v0.2.0...v1.0.0
[0.2.0]: https://github.com/o2alexanderfedin/strategic-research-automation-template/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/o2alexanderfedin/strategic-research-automation-template/releases/tag/v0.1.0
