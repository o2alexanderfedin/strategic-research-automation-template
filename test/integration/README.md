# Integration Tests

**⚠️ WARNING**: These tests make **real API calls** and are **expensive** to run.

---

## Quick Reference

| Test Suite | Duration | Cost | Purpose |
|------------|----------|------|---------|
| `single-sprint-test.sh` | ~1 hour | ~$15 | Quick validation |
| Manual full test | ~3 hours | ~$50 | Comprehensive |
| Pre-release E2E | ~4-8 hours | ~$200 | Full validation |

---

## When to Run

✅ **DO RUN**:
- Before major releases (v3.x.0, v4.0.0)
- Weekly sanity check (single sprint)
- After significant automation changes
- After modifying claude-eng wrapper
- After skill modifications

❌ **DON'T RUN**:
- On every commit (use fast tests in CI/CD)
- On documentation changes
- Multiple times per day
- Without budget approval

---

## Running Integration Tests

### Quick Validation (~1 hour, $15)

```bash
# Run single sprint test
./test/integration/single-sprint-test.sh

# What it tests:
# - Opportunity discovery (creates 5+ sprints)
# - Sprint execution (generates 25+ files)
# - Quality validation (citation ratio, word count)
# - Scoring (0-100 score, recommendation)
# - Export (PDF generation)
```

### Full Test (Manual, ~3 hours, $50)

```bash
# 1. Setup test environment
export ANTHROPIC_API_KEY="your-test-key"

# 2. Run full pipeline
./scripts/run-autonomous-analysis.sh "Integration Test" "TestCo" "context/client-info.md"

# 3. Validate results
./scripts/validate-all.sh

# 4. Check comparative analysis
./scripts/setup/claude-eng -p "/compare-sprints"

# 5. Export all
./scripts/export-reports.sh all
```

---

## Test Results

Results are saved to: `test/integration/results/`

### View Last Test

```bash
# JSON summary
cat test/integration/results/last-run.json

# Full log
ls -lt test/integration/results/*.log | head -1 | xargs cat
```

### Example Results

```json
{
  "timestamp": "20251114-143022",
  "test_type": "single-sprint",
  "duration_seconds": 3420,
  "status": "PASS",
  "opportunities_discovered": 7,
  "files_generated": 32,
  "report_word_count": 6234,
  "results_file": "test/integration/results/single-sprint-20251114-143022.log"
}
```

---

## Cost Tracking

### Monthly Budget (Recommended Schedule)

| Activity | Frequency | Cost/Run | Monthly |
|----------|-----------|----------|---------|
| Weekly single sprint | 4x | $15 | $60 |
| Bi-weekly comprehensive | 2x | $50 | $100 |
| Pre-release E2E | 1x | $200 | $200 |
| **TOTAL** | | | **$360** |

### Cost Optimization

1. **Reduce frequency**: Run weekly instead of daily
2. **Share results**: Team coordinates test runs
3. **Cache patterns**: Reuse common research
4. **Smaller scope**: Test 1-2 sprints instead of 5-10

---

## CI/CD Integration

**Note**: Integration tests are **NOT** run in CI/CD.

### Why Not?

- ⏱️ Too slow (1+ hours vs. 5 minutes target)
- 💰 Too expensive ($15+ per run vs. $0)
- 🚫 Blocks deployments
- 🔄 Non-deterministic (AI outputs vary)

### What Runs in CI/CD?

Fast unit tests only (<5 minutes, $0):
- Script syntax validation (shellcheck)
- YAML validation
- File structure checks
- Mock executions (no API calls)
- Documentation tests

See: `.github/workflows/fast-tests.yml`

### Optional: Scheduled Integration Tests

For automated but non-blocking integration tests:

```yaml
# .github/workflows/integration-scheduled.yml
on:
  schedule:
    - cron: '0 2 * * 0'  # Weekly on Sunday at 2 AM
  workflow_dispatch:      # Manual trigger only
```

This runs integration tests:
- ✅ Weekly (not per-commit)
- ✅ Non-blocking (doesn't prevent deployments)
- ✅ Budget-controlled (once per week)
- ✅ Notifies on failure (creates issue)

---

## Troubleshooting

### Test Fails: "API key not found"

```bash
# Set API key
export ANTHROPIC_API_KEY="sk-ant-your-key"

# Verify
echo $ANTHROPIC_API_KEY
```

### Test Fails: "No sprints discovered"

**Cause**: Context files may be empty or missing

**Solution**:
```bash
# Check context
ls -la context/
cat context/company-profile.md
cat context/client-info.md

# Add content if missing
vim context/company-profile.md
```

### Test Slow: "Execution taking >90 minutes"

**Cause**: Parallel execution may be disabled

**Solution**:
```bash
# Check config
cat config/project-config.yml | grep parallel

# Enable parallel execution
vim config/project-config.yml
# Set: parallel_execution: true
```

### Test Fails: "Files < 25"

**Cause**: Research questions may be too narrow

**Solution**:
```bash
# Check sprint definition
cat sprints/01-*/01-technical-research.md

# Add more research questions (aim for 15-20 per task)
```

---

## Documentation

Complete integration testing documentation:
- **Strategy**: `docs/INTEGRATION_TESTING.md`
- **Test Suites**: This directory
- **CI/CD**: `.github/workflows/fast-tests.yml`

---

## Support

**Questions?**
- Check: `docs/INTEGRATION_TESTING.md`
- Review: Test logs in `results/`
- Ask: GitHub issues

**Remember**: Integration tests are valuable but expensive. Use strategically!
