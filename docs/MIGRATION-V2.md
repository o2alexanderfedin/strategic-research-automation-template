# Migration Guide: V1 → V2 Architecture

This guide explains how to migrate from the v1 GitHub Pages generator (bash heredoc template) to the v2 architecture (JSON + static HTML).

## Overview

### V1 Architecture (Legacy)
- **Single script**: `scripts/publish/generate-pages.sh`
- **Approach**: Bash script generates HTML via heredocs
- **Output**: Monolithic `docs/index.html` file
- **Updates**: Full HTML regeneration on every run
- **Pros**: Simple, no JavaScript required
- **Cons**: Hard to maintain, test, and extend

### V2 Architecture (Recommended)
- **Separated scripts**:
  - `scripts/publish/generate-pages-data.sh` - Data extraction → JSON
  - `docs/index-template.html` - Static HTML template
  - `scripts/publish/generate-pages-html.sh` - Template copier
  - `scripts/publish/generate-pages-v2.sh` - Unified wrapper
- **Approach**: Data layer (JSON) + presentation layer (HTML/CSS/JS)
- **Output**: `docs/sprints-data.json` + `docs/index.html` (static)
- **Updates**: Only JSON regenerated, HTML stays static
- **Pros**: Idempotent, maintainable, testable, extensible
- **Cons**: Requires JavaScript enabled in browser

## Migration Steps

### Step 1: Verify Current Setup

```bash
# Ensure v1 is working
./scripts/publish/generate-pages.sh
open docs/index.html  # Verify it works
```

### Step 2: Generate V2 Files

```bash
# Generate JSON + HTML with v2 architecture
./scripts/publish/generate-pages-v2.sh

# This creates:
# - docs/sprints-data.json (data file)
# - docs/index.html (static HTML that loads JSON)
```

### Step 3: Test V2 Output

```bash
# IMPORTANT: V2 requires a local server for CORS
# Do NOT open index.html directly in browser (fetch will fail)

# Option 1: Python 3
cd docs && python3 -m http.server 8000

# Option 2: Python 2
cd docs && python -m SimpleHTTPServer 8000

# Option 3: Node.js (if npx available)
cd docs && npx http-server -p 8000

# Option 4: PHP
cd docs && php -S localhost:8000

# Then open: http://localhost:8000
```

### Step 4: Compare Outputs

1. Open v1 output directly: `file:///path/to/docs/index.html` (v1 works without server)
2. Open v2 output via server: `http://localhost:8000` (v2 requires server)
3. Verify both display the same sprint cards, scores, and statistics

### Step 5: Commit V2 Files

```bash
# Add v2 files to git
git add docs/index.html docs/sprints-data.json docs/index-template.html
git add scripts/publish/generate-pages-v2.sh
git add scripts/publish/generate-pages-data.sh
git add scripts/publish/generate-pages-html.sh

# Commit
git commit -m "feat: Add v2 GitHub Pages architecture (JSON + static HTML)"

# Push
git push
```

### Step 6: Update Workflows (Optional)

If you have CI/CD workflows that call `generate-pages.sh`, update them to use v2:

```yaml
# Before (v1)
- name: Generate GitHub Pages
  run: ./scripts/publish/generate-pages.sh

# After (v2)
- name: Generate GitHub Pages
  run: ./scripts/publish/generate-pages-v2.sh
```

## Backward Compatibility

**Good news**: V1 remains fully supported!

- You can continue using `./scripts/publish/generate-pages.sh` (v1) indefinitely
- V2 is opt-in, not a breaking change
- Both versions coexist peacefully

## Choosing Between V1 and V2

### Use V1 if:
- ✅ You want simplicity (single script)
- ✅ You don't need client-side features (filtering, sorting, search)
- ✅ You prefer no JavaScript dependencies
- ✅ You're happy with current functionality

### Use V2 if:
- ✅ You need true idempotence (JSON regenerated, HTML unchanged)
- ✅ You want to customize HTML/CSS/JS in proper files (not bash heredocs)
- ✅ You need automated testing (JSON schema validation, integration tests)
- ✅ You plan to add features (filtering, sorting, search, charts)
- ✅ You prefer separation of concerns (data vs presentation)

## Customization

### V1 Customization
Edit `scripts/publish/generate-pages.sh` and modify the bash heredocs:

```bash
# Around line 56-385: HTML structure
cat > "$HTML_FILE" << 'EOF'
<!DOCTYPE html>
<html>
<!-- Edit inline HTML here -->
</html>
EOF
```

**Downsides**: Bash heredocs make syntax highlighting and linting difficult.

### V2 Customization
Edit `docs/index-template.html` (proper HTML file):

```html
<!-- Full syntax highlighting, linting, formatting -->
<!DOCTYPE html>
<html>
<head>
    <style>
        /* Edit CSS here */
        .report-card { /* ... */ }
    </style>
</head>
<body>
    <script>
        // Edit JavaScript here
        function loadSprintData() { /* ... */ }
    </script>
</body>
</html>
```

**Benefits**: Proper IDE support, linting, formatting, testing.

## Testing

### V1 Tests
```bash
./test/integration/test-generate-pages.sh
```

### V2 Tests
```bash
./test/integration/test-generate-pages-v2.sh
```

## Rollback

If you encounter issues with v2, simply continue using v1:

```bash
# Use v1 instead
./scripts/publish/generate-pages.sh

# Or delete v2 files (optional)
rm docs/sprints-data.json
git checkout docs/index.html  # Restore v1 version
```

## Migration Checklist

- [ ] Verify v1 works: `./scripts/publish/generate-pages.sh`
- [ ] Generate v2 files: `./scripts/publish/generate-pages-v2.sh`
- [ ] Test v2 with local server: `cd docs && python3 -m http.server 8000`
- [ ] Compare v1 vs v2 visual output
- [ ] Update CI/CD workflows (if applicable)
- [ ] Commit and push v2 files
- [ ] Update documentation/README to reference v2
- [ ] Train team on v2 architecture and benefits

## Troubleshooting

### Issue: "Failed to fetch sprints-data.json"

**Cause**: Opened `index.html` directly in browser (CORS restriction)

**Solution**: Use a local server:
```bash
cd docs && python3 -m http.server 8000
# Open http://localhost:8000
```

### Issue: "JSON syntax error"

**Cause**: YAML config values with quotes are double-escaped

**Solution**: This is fixed in v3.10.0. Upgrade or manually edit sprints-data.json.

### Issue: "No sprints found"

**Cause**: Script looks in `$PROJECT_ROOT/reports` by default

**Solution**:
```bash
# Specify custom reports directory
./scripts/publish/generate-pages-v2.sh ./docs ./custom-reports-dir
```

### Issue: "Old sprint data showing"

**Cause**: Browser cached old JSON file

**Solution**: Hard refresh (Cmd+Shift+R on Mac, Ctrl+Shift+R on Windows/Linux)

## Questions?

- **File a GitHub issue**: [Issues](https://github.com/o2alexanderfedin/strategic-research-automation-template/issues)
- **Read the docs**: See `docs/` directory for more guides
- **Check the CHANGELOG**: See what's new in each version

## Next Steps

After migrating to v2, consider:

1. **Add client-side filtering**: Filter sprints by score, recommendation, industry
2. **Add sorting**: Sort by score, TAM, date
3. **Add search**: Search by sprint title or description
4. **Add charts**: Visualize score distribution, TAM breakdown
5. **Add pagination**: Handle 50+ sprints gracefully
6. **Add dark mode**: Toggle between light/dark themes

All of these are easy with v2 architecture (edit `docs/index-template.html`), but very difficult with v1 (edit bash heredocs).
