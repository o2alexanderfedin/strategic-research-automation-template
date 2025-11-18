---
description: Create git release for completed strategic research project
argument-hint: [version]
allowed-tools: Read, Write, Bash
---

# Finalize Project Release

You are executing the `/finalize-release` command to create git release $1.

## Purpose

Create comprehensive git release with semantic versioning, release notes, and repository tags for completed strategic research project.

## Steps to Execute

### Step 1: Validate Version Argument

Check $1 is valid semantic version format: vX.Y or vX.Y.Z.
Example: v1.0, v1.0.0, v2.1.3.
If invalid, ERROR with format guidance.

### Step 2: Validate Project Completion

Check all sprints executed (verify reports/ has sprint reports).
Confirm minimum quality standards met.
Verify comparison report exists (reports/00-cross-sprint-analysis.md).

### Step 3: Update Version in README

Read README.md.
Replace version string with $1.
Write updated README.md.

### Step 4: Generate Release Notes

Create RELEASE_NOTES.md with:
- Project summary
- Sprints completed (list all with scores)
- Key findings and top opportunities
- Total research output (files, words)
- Strategic recommendations
- Aggregate metrics (TAM, investment)

### Step 5: Update CHANGELOG

Read CHANGELOG.md (or create if doesn't exist).
Prepend new release section:
```markdown
## [$1] - [date]

### Completed
- Sprint 01: [Name] - Score: XX/100
- Sprint 02: [Name] - Score: YY/100
[list all sprints]

### Research Output
- Total Files: [insert count]
- Total Words: [insert word count]
- Reports Generated: [insert number]

### Top Recommendations
1. [Sprint XX]: [Name] - STRONG GO
2. [Sprint YY]: [Name] - GO
3. [Sprint ZZ]: [Name] - GO
```

### Step 6: Execute Git Flow Release

Use Bash tool:
```bash
git checkout develop
git flow release start $1
git add README.md CHANGELOG.md RELEASE_NOTES.md
git commit -m "Prepare release $1: Strategic research complete"
git flow release finish -m "Release $1" $1
```

### Step 7: Create Git Tags

Tag is created automatically by git flow finish.
Verify tag exists: git tag -l "$1".

### Step 8: Push Release

```bash
git push origin master --tags
git push origin develop
```

### Step 9: Generate GitHub Pages

Generate professional landing page for research results (v2 architecture recommended):
```bash
# V2 (recommended) - JSON + static HTML
./scripts/publish/generate-pages-v2.sh
git add docs/index.html docs/sprints-data.json docs/.nojekyll
git commit -m "Add GitHub Pages landing page (v2) for $1"
git push origin main

# V1 (fallback) - if v2 not available
./scripts/publish/generate-pages.sh
git add docs/pages/
git commit -m "Add GitHub Pages landing page (v1) for $1"
git push origin main
```

This creates a beautiful landing page at `https://<username>.github.io/<repo>/` with:
- Overview statistics (sprint count, research files, total TAM, average score)
- Cards for each sprint with scores and recommendations
- Links to HTML/PDF/Markdown versions of reports
- V2: Client-side data binding with JSON for better maintainability

### Step 10: Create GitHub Release (Optional)

If gh CLI available:
```bash
gh release create $1 \
  --title "Strategic Research: Version $1" \
  --notes-file RELEASE_NOTES.md \
  --target master
```

### Step 11: Output Release Confirmation

Display release summary with version, tag, and release notes location.

## Success Criteria

- Version validated and updated
- Release notes generated
- CHANGELOG updated
- Git release created with tag
- Repositories pushed (master + develop)
- GitHub Pages landing page generated
- GitHub release created (if available)

## Error Handling

If version format invalid, provide examples.
If project incomplete, list missing requirements.
If git operations fail, provide diagnostic information.

## Expected Output

User receives confirmation of release creation with version tag and instructions for accessing release artifacts.
