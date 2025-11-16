# Changelog

All notable changes to the Strategic Research Automation Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Planned

- Advanced export formats (HTML, interactive reports)
- Multi-language support for reports
- Web UI for non-technical users
- Integration with external data sources (APIs, databases)

---

## [3.4.0] - 2025-11-16

### Added - Stream-JSON Parser for Animated Progress Indicators

#### Game-Changing Enhancement
Implemented **stream-json parser** that converts Claude CLI's structured event stream into human-friendly, animated progress indicators with heartbeat proving the system is alive.

#### Problem Solved
Even with unbuffered output and verbose messages, rookies still wondered "is it working?" during silent processing periods. No visual proof of activity between operations.

#### Solution
**Stream-JSON Parser** (`scripts/stream-json-parser.sh`):

**1. Animated Heartbeat**
```
⠋ Working... 3s elapsed
⠙ Working... 5s elapsed  ← Spins every 2 seconds
⠹ Working... 7s elapsed  ← Visual proof system is alive
```

**2. Tool Execution Visibility**
```
🔧 Tool: Read
   Input: {"file_path":"/path/to/file"}...
📥 Tool execution complete
```

**3. Real-Time Text Streaming**
- Word-by-word output as Claude writes
- Thinking indicators (`💭 Thinking...`)
- Response completion markers

**4. Rich Metadata**
```
✅ Task Complete
   Duration: 7s
   Tokens: 9 in / 324 out
   Cached: 20,808 tokens
   Cost: $0.117
```

**5. Graceful Fallback**
- If `jq` missing → falls back to unbuffered default output
- If parser missing → uses traditional text display
- Always works, just with less visual feedback

#### Implementation

**claude-eng wrapper** now uses:
```bash
claude --output-format stream-json \
       --include-partial-messages | stream-json-parser.sh
```

**Parser features:**
- Background heartbeat thread (spinning indicator)
- JSON event parsing with `jq`
- Colored, formatted output
- Tool execution tracking
- Duration/token/cost metrics

#### Key Benefits

1. **Never Looks Frozen**
   - Heartbeat animates every 2 seconds
   - "Working... Xs elapsed" counter increments
   - Visual proof of continuous activity

2. **Complete Transparency**
   - See exactly which tools Claude is using
   - Tool input preview (truncated)
   - Real-time response streaming

3. **Professional Output**
   - Clean, colored formatting
   - Clear visual hierarchy
   - Emoji indicators for context

4. **Dependency Management**
   - Requires: `jq` (JSON processor)
   - Optional: `stdbuf` (for fallback mode)
   - Automatic fallback if dependencies missing

#### Impact

**Before** (unbuffered output):
```
[Silent periods between operations]
[Rookies wonder: "Is it frozen?"]
```

**After** (stream-json parser):
```
⠋ Working... 3s elapsed
🔧 Tool: Bash
📥 Tool execution complete
Here is the output...
✅ Task Complete (7s, $0.11)
```

**Result**: Rookies have constant visual confirmation the system is working, with detailed progress at every step.

---

## [3.3.1] - 2025-11-15

### Fixed - Unbuffered Output for Immediate Real-Time Visibility

#### Problem
Even with verbose progress indicators, output was buffered by the system, causing delays of several seconds before rookies could see any progress. This made it appear the system was frozen.

#### Solution
Implemented comprehensive unbuffered output strategy across all automation tools:

**1. `claude-eng` wrapper**
- Uses `stdbuf -oL -eL` for line-buffered output (zero buffering delay)
- Redirects all Claude CLI output to stderr (`2>&1 >&2`) for immediate display
- Falls back gracefully if stdbuf unavailable
- Technical: Line buffering flushes on every newline, not when buffer fills

**2. `run-full.sh`**
- Wraps all `claude-eng` calls with stdbuf for unbuffered execution
- Applies stdbuf to `tee` commands (unbuffered logging to file)
- Disables terminal flow control (`stty -ixon`)
- Sets `PYTHONUNBUFFERED=1` environment variable

**3. Documentation**
- Updated `VERBOSITY-GUIDE.md` with unbuffered output explanation
- Documented technical approach (`stdbuf -oL -eL`)
- Added troubleshooting section

#### Impact
- ✅ **Instant output**: Every line appears immediately, not in bursts
- ✅ **No frozen appearance**: Continuous stream confirms active execution
- ✅ **Better rookie experience**: See what's happening in real-time
- ✅ **Synchronized logging**: Terminal and log file stay perfectly in sync

**Before**: Output appeared in bursts every 4-8 seconds (buffer fills)
**After**: Output appears line-by-line as it's generated (immediate)

---

## [3.3.0] - 2025-11-15

### Added - Comprehensive Verbosity and Progress Feedback for Rookie Users

#### Problem Solved
Rookie users were confused during long 2-6 hour autonomous research runs, thinking the system was frozen with no feedback or progress indicators.

#### Solution
Enhanced all automation tools with comprehensive, real-time progress feedback:

**1. Enhanced `run-full.sh`**
- **Discovery Phase**: Clear startup messages and real-time sprint creation tracking
- **Execution Phase**:
  - Heartbeat updates every 10 seconds showing elapsed time
  - Real-time file creation counts
  - Visual progress bars with sprint headers
  - Detailed completion summaries per sprint
  - Overall progress percentages (e.g., "1/3 sprints, 33% complete")
- **Export Phase**: Per-sprint export progress with success/failure indicators

**2. Improved `claude-eng` wrapper**
- Added `--verbose` flag support for detailed startup information
- Shows YOLO mode configuration (system prompt, CLI location, permissions)
- Clear "Starting autonomous research execution..." confirmation

**3. Enhanced Slash Commands**

`/execute-sprint`:
- Startup banner with full configuration details
- Phase-based execution visibility (Research → Synthesis)
- Real-time agent status updates with emojis (🔬📈🏗️✅🗺️)
- Individual agent completion notifications with metrics
- Comprehensive completion summary with statistics

`/execute-all`:
- Multi-sprint execution overview with parallelization details
- Progress updates every 30 seconds
- Active sprint status tracking across all parallel executions
- Recent activity log with timestamps
- Estimated time remaining calculations

**4. New Documentation**
- Created `docs/VERBOSITY-GUIDE.md` with:
  - Complete explanation of all progress indicators
  - Symbol legend (✓ ⏳ → 📊 🎯 etc.)
  - Monitoring techniques for long-running operations
  - Troubleshooting guide for frozen execution scenarios
  - Tips for rookie vs. experienced users

#### Impact
- ✅ **Real-time visibility**: Progress updates every 10-30 seconds
- ✅ **Tangible progress**: File creation counts updating in real-time
- ✅ **Time awareness**: Elapsed time and completion estimates
- ✅ **Status tracking**: Individual agent and sprint progress
- ✅ **User confidence**: Clear confirmation the system is actively working

**Before**: Users thought system was frozen during silent 2-6 hour runs
**After**: Continuous, detailed feedback provides complete visibility and confidence

---

## [3.2.1] - 2025-11-15

### Changed

- **Simplified automation script to 3 freeform questions**
  - Reduced from 10+ detailed questions to 3 simple, freeform questions
  - Question 1: About your company (name, services, URLs - all in freeform text)
  - Question 2: About the client (name, URLs, any other info - freeform)
  - Question 3: Additional context (optional)
  - Claude now researches all details automatically using web search

- **Enhanced autonomous research capabilities**
  - Context files now include "Instructions for Claude" sections
  - Claude researches company capabilities, client needs, and industry context
  - Discovery phase explicitly instructs Claude to research before identifying opportunities
  - Truly hands-free operation - user provides minimal input, Claude does all analysis

### Fixed

- Typo in final summary report (`wee -l` → `wc -l`)

### Benefits

- ✓ **Even more rookie-friendly** - no need to know company details upfront
- ✓ **Less time to start** - answer 3 questions instead of 10+
- ✓ **More autonomous** - Claude researches everything automatically
- ✓ **Better results** - AI discovers details users might not know or forget to mention

---

## [3.2.0] - 2025-11-15

### Added

- **Fully Automated One-Command Research Script** (`scripts/run-full.sh`)
  - **Zero interruptions** - ask all questions upfront, then run completely hands-free
  - **Rookie-friendly** - simple question/answer format like setup-template.sh
  - **Complete automation** - discovery → execution → export, all in one command
  - **Configurable scope** - choose 1-10 opportunities, with time/cost estimates
  - **Progress logging** - complete execution log for troubleshooting
  - **Multi-format export** - automatically exports to markdown/pdf/docx/all

### Features

**Usage**:
```bash
./scripts/run-full.sh
```

**What it does**:
1. Asks questions upfront (company info, client info, research focus, # opportunities)
2. Creates context files automatically from your answers
3. Discovers strategic opportunities (no user interaction needed)
4. Executes ALL research sprints autonomously
5. Generates final reports and exports
6. Logs everything for review

**Time estimates**:
- 1-3 opportunities: 1-2 hours, $30-$60
- 4-6 opportunities: 3-4 hours, $100-$150
- 7-10 opportunities: 5-6 hours, $200+

**Perfect for**:
- Non-technical users who want simple automation
- Consultants who need quick turnaround
- Anyone who wants to "set it and forget it"

### Benefits

- ✓ **No Claude Code expertise needed** - just answer questions
- ✓ **No interruptions** - runs completely hands-free until done
- ✓ **No manual file editing** - context files created automatically
- ✓ **Predictable execution** - clear time and cost estimates
- ✓ **Complete logging** - everything tracked in timestamped log file
- ✓ **Production-ready output** - exports in professional formats

### Technical Details

**File**: `scripts/run-full.sh` (335 lines, executable)

**Workflow**:
1. Information gathering via interactive prompts
2. Automatic context file creation (company-profile.md, client-info.md, industry-background.md)
3. Autonomous opportunity discovery
4. Sequential sprint execution (all sprints, no user input)
5. Automatic export in chosen format(s)
6. Summary report with duration, costs, output locations

**Logging**: Creates timestamped log file (automation-YYYYMMDD-HHMMSS.log)

---

## [3.1.0] - 2025-11-15

### Security

- **CRITICAL FIX**: Sed delimiter issues with URLs and paths containing forward slashes
  - Changed all sed delimiters from `/` to `|` in setup scripts
  - Fixes error: "bad flag in substitute command: '/'"
  - Affects: `scripts/setup-template.sh`, `scripts/setup-existing.sh`

- **HIGH FIX**: Special character escaping in sed replacements
  - Added `escape_for_sed()` helper function to both setup scripts
  - Escapes special characters: `&` (matched text), `/` (delimiter), `\` (escape)
  - Prevents sed replacement bugs with ampersands in user input (e.g., "Company & Co.")

### Added

- **Comprehensive test coverage** (42 tests total)
  - 25 unit tests in `test/setup-scripts.bats`
    - Sed delimiter handling with URLs
    - Special character escaping (&, /, \, $, `, quotes)
    - Variable quoting and glob expansion
    - Security verification (no eval, proper quoting)
  - 17 integration tests in `test/setup-integration.bats`
    - Real-world setup scenarios with edge cases
    - Directory structure and file customization
  - Test runner: `test/run-setup-tests.sh`

- **Security audit documentation**
  - Complete analysis in `docs/SECURITY_AUDIT.md`
  - 23 scripts analyzed, 2 modified, 21 verified secure
  - Security rating: EXCELLENT ⭐⭐⭐⭐⭐
  - Edge cases tested: URLs, ampersands, quotes, UTF-8, mixed special chars

- **GitHub template repository setup**
  - Documentation: `GITHUB_TEMPLATE_SETUP.md`
  - CLI command to enable template: `gh api -X PATCH /repos/...`
  - Web UI instructions included

### Changed

- **Authentication documentation clarified**
  - API key now clearly marked as **optional** if using Claude Code CLI auth
  - `.env.example`: Two authentication options documented
    - Option 1 (Recommended): Claude Code CLI auth (`claude auth`) - FREE
    - Option 2: Anthropic API key - pay-per-use
  - Setup script: Changed alarming "IMPORTANT: add API key" to informational message
  - README: Added clear "Authentication" section with recommendations

- **Setup script improvements**
  - Better user messaging about authentication options
  - Next steps prioritize verifying existing auth over requiring API key
  - Less intimidating for new users

### Fixed

- Sed failures when user input contains URLs (e.g., `https://example.com/path`)
- Sed failures when user input contains ampersands (e.g., `Company & Co.`)
- Sed failures when user input contains backslashes or other special characters
- Confusing/misleading API key requirement messaging

### Technical Details

**Files Modified**:
- `scripts/setup-template.sh`: Lines 62, 270-276, 282-288, 303-304, 350-351, 389, 427-429, 446, 530-532
- `scripts/setup-existing.sh`: Lines 18, 239-243, 248-253, 402-404, 414-416
- `.env.example`: Lines 5-29 (authentication section rewritten)
- `README.md`: Lines 392-396 (authentication note clarified)

**Edge Cases Now Handled**:
- ✓ URLs with forward slashes: `https://www.linkedin.com/company/name/`
- ✓ Multiple URLs in single field
- ✓ Ampersands in company names: `Company & Co.`
- ✓ Quotes: `Project "Alpha" Phase I`
- ✓ Parentheses: `Company (Consulting)`
- ✓ Dollar signs: `$100.00`
- ✓ Backticks: `` `command` ``
- ✓ UTF-8 characters: `Société Française™`
- ✓ Mixed special characters

**Real-World Example Fixed**:
```bash
Industry: research-it-by-yourself.-here-are-some-sources:-https://www.linkedin.com/company/innova-technology-inc/-https://innova-technology.com/-https://clutch.co/profile/innova-1
```
This exact input now works correctly without errors.

---

## [3.0.0] - 2025-11-14

### BREAKING CHANGES

- **YOLO-Only Mode by Default** - Template now uses fully autonomous execution mode
  - All scripts default to `./scripts/setup/claude-eng` instead of `claude`
  - Zero permission prompts - uninterrupted execution from start to finish
  - Users can override with `CLAUDE_CMD=claude` environment variable if needed

**Migration Impact**: Existing users expecting interactive mode will now get fully autonomous execution. Set `export CLAUDE_CMD="claude"` to restore interactive behavior.

### Changed

- **Philosophy Shift**: From interactive to fully autonomous research automation
  - All 6 automation scripts converted to YOLO mode default
  - All 7 documentation files updated with YOLO mode examples
  - README.md emphasizes "completely hands-free automation"
  - TEMPLATE_STRATEGY.md updated with YOLO-only philosophy

- **Documentation Updates**:
  - README.md: Added YOLO-only philosophy and "Why YOLO-only?" section
  - QUICK_START.md: All 30+ examples converted to claude-eng
  - Command reference tables updated with YOLO mode syntax
  - Setup guides updated for autonomous operation

### Added

- Comprehensive YOLO mode documentation across all guides
- Security considerations for autonomous operation
- Migration path documentation for existing users

### Tested

- All 247 tests pass (100% success rate)
  - Comprehensive Testing Suite: 190/190 ✓
  - BATS Integration Tests: 30/30 ✓
  - BATS Setup Tests: 20/20 ✓
  - Documentation Tests: 7/7 ✓

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
  - Example configurations for technology industry

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
