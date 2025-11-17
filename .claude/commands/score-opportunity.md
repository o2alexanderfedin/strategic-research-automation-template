---
description: Calculate opportunity score using weighted rubric
argument-hint: [sprint-number]
allowed-tools: Read, Write
---

# Score Opportunity

You are executing the `/score-opportunity` command to calculate opportunity score for sprint $1.

## Purpose

Calculate comprehensive opportunity score (0-100) using weighted rubric across 5 dimensions: Market Opportunity, Technical Feasibility, Competitive Advantage, Execution Readiness, and Regulatory Pathway.

## Steps to Execute

### Step 1: Validate Sprint Number

Check $1 is valid sprint number 01-99.
Verify research completed (temp/$1-*/ or reports/$1-*-report.md exists).

### Step 2: Load Scoring Rubric

Read config/scoring-rubric.yml with weights and criteria.

### Step 3: Read Research Data

Read report (reports/$1-*-report.md) or all temp/$1-*/ files.
Extract metrics for each scoring dimension.

### Step 4: Calculate Dimension Scores

Market Opportunity (25% weight):
- TAM/SAM/SOM assessment (40%)
- Growth rate/CAGR (30%)
- Customer pain severity (30%)

Technical Feasibility (25% weight):
- Technology readiness level/TRL (40%)
- Team capability alignment (30%)
- Technical risk level (30%)

Competitive Advantage (20% weight):
- Differentiation strength (50%)
- Moat/defensibility (50%)

Execution Readiness (15% weight):
- Timeline/speed to market (30%)
- Investment/capital efficiency (30%)
- Partnerships availability (40%)

Regulatory Pathway (15% weight):
- Regulatory clarity (40%)
- Precedents exist (30%)
- Timeline predictability (30%)

### Step 5: Calculate Weighted Total Score

Weighted Score = sum(dimension_score × dimension_weight)

### Step 6: Determine Recommendation Tier

80-100: STRONG GO
65-79: GO
50-64: CONDITIONAL GO
0-49: NO GO

### Step 7: Output Scoring Summary

**CRITICAL**: Use proper markdown table syntax with blank lines.

**CORRECT Format**:
```markdown
**Scoring Summary:**

| Category | Weight | Score | Weighted | Assessment |
|----------|--------|-------|----------|------------|
| Market Opportunity | 25% | 93.3 | 23.3 | Exceptional |
| Technical Feasibility | 25% | 80.0 | 20.0 | Strong |
| Competitive Advantage | 20% | 90.0 | 18.0 | Exceptional |
| Execution Readiness | 15% | 75.0 | 11.25 | Moderate-Strong |
| Regulatory Pathway | 15% | 85.0 | 12.75 | Strong |
| **TOTAL** | **100%** | **—** | **85.3** | **Strong GO** |
```

**Table Formatting Rules**:
1. Blank line before table
2. Blank line after table
3. Proper markdown syntax with pipes and dashes
4. Align columns with spaces for readability
5. Never use inline table syntax

## Success Criteria

- All 5 dimensions scored
- Weighted total calculated
- Recommendation tier determined
- Scoring rationale provided

## Error Handling

If research incomplete, guide user to execute sprint first.

## Expected Output

User receives opportunity score with dimensional breakdown and clear recommendation.
