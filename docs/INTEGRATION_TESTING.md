# Integration Testing Strategy

**Framework**: Strategic Research Automation Template
**Version**: 3.0.0
**Last Updated**: 2025-11-14

---

## Philosophy

Integration testing for this framework involves running **actual AI research** which is:
- ⏱️ **Time-intensive**: 45+ minutes per sprint
- 💰 **Cost-intensive**: $10-$20 in API calls per sprint
- 🔄 **Non-deterministic**: AI outputs vary

**Therefore**: Integration tests are **NOT part of CI/CD**. They run separately on-demand or scheduled.

---

## Tiered Testing Strategy

### Tier 1: Fast Unit Tests (CI/CD) ✅
**Run on**: Every commit
**Duration**: < 5 minutes
**Cost**: $0

**What we test**:
- ✅ Script syntax (shellcheck)
- ✅ YAML validity
- ✅ File structure
- ✅ Command argument handling
- ✅ Documentation links
- ✅ Mock executions (no actual AI calls)

**Current implementation**: 247 tests, 100% pass rate

```bash
# Run fast tests (safe for CI/CD)
./scripts/test/comprehensive-testing.sh
bats test/*.bats test/setup/*.bats
./tests/documentation/test-readme.sh
```

**CI/CD**: ✅ Already integrated via `.github/workflows/`

---

### Tier 2: Integration Tests (Manual/Scheduled) 🔧
**Run on**: On-demand, before releases, weekly schedule
**Duration**: 1-4 hours
**Cost**: $50-$200 per full run

**What we test**:
- 🔍 Actual AI skill execution
- 📝 Research file generation (quality, quantity, citations)
- 📊 Report synthesis
- 🎯 Scoring accuracy
- 📤 Export pipeline (PDF, DOCX)
- 🔗 End-to-end workflows

**Implementation**: Manual runbook (see below)

---

### Tier 3: End-to-End Production Tests (Pre-Release) 🚀
**Run on**: Before major releases only
**Duration**: 4-8 hours
**Cost**: $200-$400

**What we test**:
- Full portfolio (5-10 sprints)
- Cross-sprint comparison
- Real-world scenarios
- Performance benchmarks
- Stress testing

**Implementation**: Release checklist (see below)

---

## Integration Test Runbook

### Setup (One-Time)

```bash
# 1. Create integration test environment
mkdir -p ~/integration-tests/strategic-research

# 2. Clone template to test directory
cd ~/integration-tests/strategic-research
git clone https://github.com/o2alexanderfedin/strategic-research-automation-template test-env
cd test-env

# 3. Configure test API key (separate from dev)
export ANTHROPIC_API_KEY="sk-ant-integration-test-key"

# 4. Create test context
cat > context/company-profile.md << 'EOF'
# Test Company Profile
Core Capabilities: Software development, AI/ML, Cloud infrastructure
Technical Expertise: Python, TypeScript, AWS, GCP
Domain Expertise: Technology sector, SaaS platforms
EOF

cat > context/client-info.md << 'EOF'
# Test Client
Industry: Technology sector
Challenge: Market opportunity analysis
Requirements: Strategic research for 3 opportunities
EOF
```

---

### Test Suite 1: Single Sprint (Quick Validation)

**Duration**: ~1 hour
**Cost**: ~$15
**Purpose**: Verify basic functionality before deeper testing

```bash
# Test 1.1: Discovery
./scripts/setup/claude-eng -p "/discover-opportunities"

# Validate:
# - Creates sprints/ directory
# - Generates 5-10 opportunity definitions
# - Files have substantial content (>500 words each)

# Test 1.2: Execute Single Sprint
./scripts/setup/claude-eng -p "/execute-sprint 01"

# Validate:
# - Creates temp/01-*/ directory
# - Generates 25+ research files
# - Files have citations (80%+ ratio)
# - No placeholder text
# - Creates reports/01-*-report.md
# - Report is 5,000-7,500 words

# Test 1.3: Scoring
./scripts/setup/claude-eng -p "/score-opportunity 01"

# Validate:
# - Score is 0-100
# - All dimensions scored
# - Recommendation present (GO/NO-GO/CONDITIONAL)

# Test 1.4: Export
./scripts/setup/claude-eng -p "/export-findings 01 pdf"

# Validate:
# - PDF created in reports/
# - PDF has table of contents
# - PDF has proper formatting
# - Citations render correctly
```

**Success Criteria**:
- ✅ All files generated
- ✅ Quality standards met
- ✅ No errors in execution
- ✅ Export successful

---

### Test Suite 2: Multi-Sprint (Comprehensive)

**Duration**: ~3 hours
**Cost**: ~$50
**Purpose**: Full workflow validation

```bash
# Test 2.1: Full Pipeline
./scripts/run-autonomous-analysis.sh "Integration Test" "TestCo" "context/client-info.md"

# Validate:
# - Discovers 5+ opportunities
# - Executes all sprints in parallel
# - All sprints complete successfully
# - Quality validation passes
# - Comparative analysis generated

# Test 2.2: Incremental Execution
./scripts/run-sprints-incremental.sh

# Validate:
# - Processes sprints sequentially
# - Checkpoints work correctly
# - Can resume from failure

# Test 2.3: Comparison
./scripts/setup/claude-eng -p "/compare-sprints"

# Validate:
# - Comparison matrix generated
# - All sprints included
# - Scoring consistent
# - Prioritization makes sense
```

**Success Criteria**:
- ✅ Complete portfolio generated
- ✅ All quality checks pass
- ✅ Comparative analysis accurate
- ✅ Execution time < 4 hours

---

### Test Suite 3: Error Handling

**Duration**: ~30 minutes
**Cost**: ~$5
**Purpose**: Verify graceful failure

```bash
# Test 3.1: Invalid Arguments
./scripts/run-sprint.sh invalid-sprint-number
# Expected: Clear error message, exit code 1

# Test 3.2: Missing Context
rm context/company-profile.md
./scripts/setup/claude-eng -p "/discover-opportunities"
# Expected: Warning about missing context, uses template

# Test 3.3: Network Interruption
# (Simulate by pausing network mid-execution)
# Expected: Retry logic, clear error messages

# Test 3.4: Partial Execution
# Delete some research files mid-sprint
./scripts/setup/claude-eng -p "/validate-quality 01"
# Expected: Identifies missing files, provides recovery options
```

---

### Test Suite 4: YOLO Mode Verification

**Duration**: ~45 minutes
**Cost**: ~$10
**Purpose**: Verify fully autonomous operation

```bash
# Test 4.1: No Permission Prompts
# Run in background, monitor for interactive prompts
nohup ./scripts/setup/claude-eng -p "/execute-sprint 01" > test.log 2>&1 &
tail -f test.log

# Validate:
# - No "[y/N]" prompts
# - No waiting for user input
# - Execution completes unattended

# Test 4.2: Parallel Execution
# Start multiple sprints simultaneously
./scripts/setup/claude-eng -p "/execute-sprint 01" &
./scripts/setup/claude-eng -p "/execute-sprint 02" &
./scripts/setup/claude-eng -p "/execute-sprint 03" &
wait

# Validate:
# - All complete successfully
# - No resource conflicts
# - No permission deadlocks

# Test 4.3: Overnight Batch
# Start late evening, check morning
nohup ./scripts/run-autonomous-analysis.sh "Overnight Test" "TestCo" > overnight.log 2>&1 &

# Validate next morning:
# - Completed without intervention
# - All results present
# - Log shows no errors
```

---

## Integration Test Schedule

### Recommended Schedule

| Test Type | Frequency | Trigger | Duration | Cost |
|-----------|-----------|---------|----------|------|
| Single Sprint | Weekly | Manual | 1 hour | $15 |
| Multi-Sprint | Bi-weekly | Manual | 3 hours | $50 |
| Error Handling | Monthly | Manual | 30 min | $5 |
| YOLO Mode | Before each release | Manual | 45 min | $10 |
| Full E2E | Major releases only | Manual | 4-8 hours | $200 |

### Trigger Events

**When to run integration tests**:
- ✅ Before major releases (v3.x.0, v4.0.0)
- ✅ After significant changes to automation scripts
- ✅ After changes to claude-eng wrapper
- ✅ When skills are modified
- ✅ Weekly sanity check (single sprint)
- ✅ After API/dependency upgrades

**When NOT to run**:
- ❌ On every commit (use fast unit tests)
- ❌ On documentation-only changes
- ❌ On minor config tweaks
- ❌ Multiple times per day

---

## Optional: Scheduled Integration Tests

For teams that want automated integration testing without blocking CI/CD:

```yaml
# .github/workflows/integration-tests.yml
name: Integration Tests (Scheduled)

on:
  schedule:
    - cron: '0 2 * * 0'  # Weekly on Sunday at 2 AM
  workflow_dispatch:      # Manual trigger

jobs:
  integration-test:
    runs-on: ubuntu-latest
    timeout-minutes: 240  # 4 hours max

    steps:
      # ... setup steps ...

      - name: Run Single Sprint Test
        run: |
          ./scripts/setup/claude-eng -p "/execute-sprint 01"
          ./scripts/setup/claude-eng -p "/validate-quality 01"

      - name: Notify on Failure
        if: failure()
        uses: actions/github-script@v6
        with:
          script: |
            github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: 'Integration Test Failure',
              body: 'Weekly integration test failed. See logs.'
            })
```

**Key differences from CI/CD**:
- 🕐 Runs on schedule (weekly), not every commit
- 🔕 Non-blocking - doesn't prevent deployments
- 📧 Notifies on failure instead of blocking
- ⏱️ Longer timeout (4 hours vs. 5 minutes)
- 💰 Budget-aware (weekly vs. per-commit)

---

## Cost Management

### Budget Planning

**Monthly costs** (assuming weekly schedule):
- Single sprint tests: 4 × $15 = $60/month
- Multi-sprint tests: 2 × $50 = $100/month
- Error handling: 1 × $5 = $5/month
- YOLO mode: 2 × $10 = $20/month

**Total**: ~$185/month for comprehensive integration testing

### Cost Optimization

1. **Use smaller test cases**:
   - Reduce sprint count (test 1-2 instead of 5-10)
   - Use narrower research scope
   - Cache common research patterns

2. **Tiered execution**:
   - Quick tests weekly ($15)
   - Comprehensive tests bi-weekly ($50)
   - Full E2E only before releases ($200)

3. **Shared test environment**:
   - Team members coordinate
   - Reuse test results within sprint
   - Share API key quota

---

## Measuring Success

### Integration Test Metrics

Track these metrics over time:

| Metric | Target | Purpose |
|--------|--------|---------|
| **Execution Success Rate** | >95% | Reliability |
| **Quality Standard Compliance** | 100% | Output quality |
| **File Generation Rate** | 25-38 per sprint | Completeness |
| **Citation Ratio** | >80% | Evidence quality |
| **Export Success** | 100% | Delivery |
| **Execution Time** | <60 min per sprint | Performance |
| **Cost per Sprint** | $10-$20 | Efficiency |

### Red Flags

Stop and investigate if:
- ❌ Success rate drops below 90%
- ❌ File count drops below 20 per sprint
- ❌ Citation ratio drops below 70%
- ❌ Execution time exceeds 90 minutes
- ❌ Cost exceeds $30 per sprint
- ❌ Exports fail repeatedly

---

## Integration Test Results Template

Document each test run:

```markdown
# Integration Test Results

**Date**: 2025-11-14
**Tester**: [Name]
**Template Version**: v3.0.0
**Test Suite**: Single Sprint

## Environment
- OS: Ubuntu 22.04
- Claude Code: v2.1.0
- API Key: integration-test-001

## Results

### Test 1.1: Discovery ✅
- Duration: 3 minutes
- Opportunities found: 7
- Files generated: 7 sprint definitions
- Quality: All >500 words

### Test 1.2: Execute Sprint ✅
- Duration: 52 minutes
- Files generated: 32 research files
- Citations: 87% (target: >80%)
- Report: 6,234 words (target: 5,000-7,500)

### Test 1.3: Scoring ✅
- Score: 89/100
- Recommendation: STRONG GO
- All dimensions scored: ✓

### Test 1.4: Export ✅
- PDF generated: ✓
- File size: 2.3 MB
- TOC present: ✓
- Citations render: ✓

## Overall Status: ✅ PASS

**Total Duration**: 58 minutes
**Total Cost**: $14.50
**Issues**: None
**Notes**: Execution slightly slower than expected (52 vs 45 min target)
```

---

## Quick Reference

### Run Integration Tests Locally

```bash
# Quick validation (1 hour, $15)
./test/integration/single-sprint-test.sh

# Comprehensive (3 hours, $50)
./test/integration/multi-sprint-test.sh

# Error handling (30 min, $5)
./test/integration/error-handling-test.sh

# YOLO mode (45 min, $10)
./test/integration/yolo-mode-test.sh
```

### Check Test Status

```bash
# View last test results
cat test/integration/last-run.json

# View test history
ls -lt test/integration/results/

# Check API usage
grep "API calls" test/integration/results/*.log
```

---

## Next Steps

1. **For Contributors**: Run single sprint test before major PRs
2. **For Maintainers**: Run weekly single sprint tests
3. **For Releases**: Run full E2E before tagging release
4. **For Teams**: Set up scheduled weekly integration tests

---

**Remember**: Integration tests are valuable but expensive. Use them strategically, not automatically.

**Golden Rule**: Fast tests in CI/CD, slow tests on schedule.
