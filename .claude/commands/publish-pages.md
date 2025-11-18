# Publish to GitHub Pages

Generate and publish a professional landing page showcasing all sprint reports.

## What This Does

1. **Scans** all sprint reports in `reports/` directory
2. **Generates** a beautiful HTML landing page with:
   - Project overview and statistics
   - Cards for each sprint/opportunity with scores and recommendations
   - Links to HTML, PDF, and Markdown versions of reports
   - Responsive design with professional styling
3. **Publishes** to GitHub Pages (if repository is configured)

## Architecture Versions

### V2 (Recommended) - JSON + Static HTML

The v2 architecture separates data from presentation:
- **JSON data file** (`sprints-data.json`) contains all sprint metadata
- **Static HTML template** (`index.html`) loads JSON via JavaScript
- **Benefits**: Idempotent, maintainable, testable, extensible

```bash
# Generate both JSON and HTML (recommended)
./scripts/publish/generate-pages-v2.sh

# Or specify custom output directory
./scripts/publish/generate-pages-v2.sh ./docs
```

### V1 (Legacy) - Bash Template Generation

The original monolithic script that generates HTML via bash heredocs:

```bash
# Generate the landing page (v1)
./scripts/publish/generate-pages.sh

# Or specify custom output directory
./scripts/publish/generate-pages.sh ./public
```

**Note**: V1 still works and is fully supported, but v2 is recommended for new projects.

## GitHub Pages Setup

To enable automatic publishing:

1. Create a `gh-pages` branch or use `docs/` folder in main
2. Enable GitHub Pages in repository settings
3. Point to the generated index.html location

## Output

- `docs/pages/index.html` - Landing page
- Links to all sprint reports (HTML/PDF/MD formats)
- Professional, mobile-responsive design

## Requirements

- At least one sprint report in `reports/sprint-*-final-report.md`
- Reports should include score and TAM data (extracted automatically)

## Example

After running this command, you'll have a landing page similar to:
https://o2alexanderfedin.github.io/innova-technology-proposals/

The page will automatically calculate:
- Total number of strategic opportunities
- Combined TAM across all sprints
- Average opportunity score
- Research file count

## Customization

### V2 Architecture
Edit `docs/index-template.html` (proper HTML/CSS/JS file) to:
- Change color scheme (currently purple gradient)
- Modify card layout and styling
- Add client-side filtering, sorting, search
- Extend JavaScript data binding logic

### V1 Architecture
Edit the bash heredoc template in `scripts/publish/generate-pages.sh` to:
- Change color scheme
- Modify card layout
- Add additional statistics
- Update footer branding

## Testing

```bash
# Run comprehensive v2 integration tests
./test/integration/test-generate-pages-v2.sh

# Run v1 integration tests (if available)
./test/integration/test-generate-pages.sh
```
