---
description: Validate research quality against project standards
argument-hint: [sprint-number]
allowed-tools: Read, Grep, Glob
---

# Validate Quality Standards

You are executing the `/validate-quality` command to validate sprint $1 quality.

## Purpose

Validate research quality by checking file counts, citation density, synthesis requirements, report structure, cross-references, and terminology consistency against quality standards defined in config/quality-standards.yml.

## Steps to Execute

### Step 1: Validate Sprint Number

Check $1 is valid sprint number 01-99.
Verify sprint executed (temp/$1-*/ exists with files).

### Step 2: Load Quality Standards

Read config/quality-standards.yml for thresholds:
- minimum_files_per_sprint: 25
- minimum_citation_density: 0.80 (80%)
- synthesis_required: true
- report_min_words: 5000
- report_max_words: 7500
- required_sections: [list]

### Step 3: Check File Count

Use Glob to count files in temp/$1-*/**/*.md (exclude synthesis.md).
Verify meets minimum (typically 25 files).

### Step 4: Validate Citation Density

Read all research files.
Count total claims (sentences ending with periods, bullet points).
Count citations (patterns: [Author, Year], (Author, Year), [N]).
Calculate density: citations / claims.
Threshold: ≥80%.

### Step 5: Verify Synthesis Documents

Check temp/$1-*/01-*/synthesis.md through 05-*/synthesis.md exist.
Verify each is 1,500-3,000 words.
Confirm required sections present (Executive Summary, Key Findings, Recommendations).

### Step 6: Validate Report Structure

Read reports/$1-*-report.md.
Check word count: 5,000-7,500 words.
Verify all required sections present per quality-standards.yml.
Confirm opportunity score included (/Score:.*\/100/).
Validate recommendation present (/(STRONG )?GO|NO GO|CONDITIONAL GO/).

### Step 7: Check Cross-References

Find all internal links: [.*]\(.*\.md\).
Verify each linked file exists.
Report any broken links.

### Step 8: Validate Terminology Consistency

Extract key domain terms (top 20 by frequency).
Check for inconsistent usage (e.g., "advanced system" vs "advanced system" vs "advanced system").
Flag significant inconsistencies.

### Step 9: Generate Quality Report

Create validation report with:
- File count: PASS/FAIL
- Citation density: PASS/WARNING/FAIL
- Synthesis documents: PASS/FAIL
- Report structure: PASS/FAIL
- Cross-references: PASS/FAIL
- Terminology: PASS/WARNING
- Overall quality score: 0-100

### Step 10: Output Quality Summary

Display validation results with pass/fail status for each check.

## Success Criteria

- All quality checks performed
- Validation results documented
- Issues clearly identified
- Remediation guidance provided

## Error Handling

If quality issues found, provide specific guidance on remediation.

## Expected Output

User receives comprehensive quality validation report with specific pass/fail results and recommendations for improvement.
