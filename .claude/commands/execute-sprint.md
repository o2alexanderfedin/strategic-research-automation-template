---
description: Execute all tasks for a sprint with parallel execution and synthesis
argument-hint: [sprint-number]
allowed-tools: Task, Read, Write, TodoWrite, Bash
---

# Execute Complete Sprint

You are executing the `/execute-sprint` command to run all 6 tasks for a sprint.

## Purpose

Execute all 6 tasks for a sprint with parallel execution of Tasks 01-05, followed by sequential execution of Task 06 (synthesis), ensuring efficient research completion while maintaining quality.

## Steps to Execute

### Step 1: Validate Sprint

Check $1 is valid sprint number 01-99
Verify sprint directory exists: sprints/$1-*/
Verify all 6 task files present
Confirm temp directory ready: temp/$1-*/
Validate context files populated

### Step 2: Load Configuration

Read config/project-config.yml for max_parallel_tasks, git_enabled settings
Read config/sprint-config.yml for sprint metadata
Read all context files for skill agents

### Step 3: Initialize Progress Tracking

Output verbose startup message:
```
🚀 SPRINT EXECUTION STARTING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Sprint: [sprint-name]
Number: [sprint-number]
Total Tasks: 6
Expected Duration: 30-60 minutes

Configuration:
✓ Sprint directory validated
✓ Context files loaded
✓ Output directory ready: temp/[sprint-number]-*/
✓ Parallel execution enabled (5 tasks simultaneously)

Tasks to Execute:
  1. Technical Requirements Research
  2. Market & Competitive Analysis
  3. Solution Architecture Design
  4. Certification Pathway Analysis
  5. Implementation Roadmap
  6. Final Report Synthesis (after tasks 1-5 complete)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Create progress tracking list with 6 tasks, mark all as pending initially

### Step 4: Execute Tasks 01-05 in Parallel

Output progress message:
```
📊 PHASE 1: PARALLEL RESEARCH (Tasks 01-05)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Launching 5 research agents simultaneously...

🔬 Agent 1: Technical Researcher
   → Analyzing technical requirements, regulations, and SMT feasibility
   → Output: temp/[sprint]/01-technical/

📈 Agent 2: Market Analyst
   → Researching TAM/SAM/SOM, competitors, and customer needs
   → Output: temp/[sprint]/02-market/

🏗️ Agent 3: Solution Architect
   → Designing system architecture and POC specifications
   → Output: temp/[sprint]/03-architecture/

✅ Agent 4: Compliance Analyst
   → Researching certification pathways and testing requirements
   → Output: temp/[sprint]/04-compliance/

🗺️ Agent 5: Roadmap Planner
   → Creating implementation roadmap and partnership strategy
   → Output: temp/[sprint]/05-roadmap/

Expected completion: 20-40 minutes (agents work in parallel)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏳ Research in progress... (updates will appear as agents complete tasks)
```

Launch 5 skill agents concurrently using Task tool:
- Task tool → technical-researcher (Task 01)
- Task tool → market-analyst (Task 02)
- Task tool → solution-architect (Task 03)
- Task tool → compliance-analyst (Task 04)
- Task tool → roadmap-planner (Task 05)

Each agent operates independently, creating research files in temp/$1-*/

### Step 5: Monitor Parallel Execution

Track completion of each skill agent and provide real-time updates:
```
⏱️ PROGRESS UPDATE [MM:SS elapsed]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Agent Status:
  🔬 Technical Researcher:    ✓ Complete (8 files, 12,340 words)
  📈 Market Analyst:          ⏳ In Progress (5 files so far...)
  🏗️ Solution Architect:      ⏳ In Progress (3 files so far...)
  ✅ Compliance Analyst:      ⏳ Starting research...
  🗺️ Roadmap Planner:         ⏳ Starting research...

Overall: 2/5 agents complete (40%)
Total files created: 16
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Update progress tracking as each task completes
Collect file counts and word counts
Handle any errors gracefully with detailed error messages

When each agent completes, output:
```
✅ Agent X completed: [Task Name]
   → Files created: [count]
   → Total words: [count]
   → Key finding: [brief summary]
```

### Step 6: Execute Task 06 (Synthesis)

Wait for all Tasks 01-05 to complete

Output transition message:
```
✅ ALL RESEARCH AGENTS COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total research files created: [count]
Total research words: [count]
Research quality: All agents completed successfully

📝 PHASE 2: REPORT SYNTHESIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Starting final report generation...

Tasks:
  1. Reading all research files from temp/[sprint]/
  2. Analyzing findings across all research areas
  3. Applying scoring rubric (0-100 scale)
  4. Generating executive summary
  5. Creating strategic recommendations
  6. Compiling final report (5,000-7,500 words)

Expected completion: 5-10 minutes
⏳ Synthesis in progress...
```

Mark Task 06 as in_progress
Launch Task tool → report-synthesizer
Report synthesizer reads all temp/$1-*/ files
Applies scoring rubric from config/scoring-rubric.yml
Generates comprehensive strategic report (5,000-7,500 words)
Writes to reports/$1-*-report.md

During synthesis, output periodic progress:
```
⏱️ Synthesis progress... [MM:SS elapsed]
   → Read 28 research files
   → Analyzed 45,230 words of research
   → Calculated opportunity score: 84/100
   → Writing executive summary...
```

### Step 7: Validate Sprint Completion

Check all 6 tasks completed successfully
Verify research file count meets minimum (25+ files typical)
Ensure final report exists and meets length requirement
Confirm report includes go/no-go recommendation
Validate scoring completed

### Step 8: Git Workflow

If git_enabled in config:
- Create feature branch: git flow feature start sprint-$1-execution
- Stage all generated files: git add temp/$1-*/ reports/$1-*.md
- Commit with descriptive message
- Finish feature: git flow feature finish sprint-$1-execution
- Push to remote: git push origin develop

### Step 9: Generate Sprint Summary

Output comprehensive completion summary:
```
✅ SPRINT COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Sprint: [sprint-name]
Number: [sprint-number]
Execution Time: [HH:MM:SS]

📊 Research Output:
   → Research files created: [count] files
   → Total research words: [count] words
   → Final report: reports/[sprint]-report.md ([word-count] words)
   → Quality validation: PASSED

🎯 Opportunity Assessment:
   → Overall Score: [score]/100 ([GO/NO-GO/CONDITIONAL])
   → Market Opportunity: $[amount] ([timeframe])
   → Investment Required: $[amount] ([timeframe])
   → Technical Feasibility: [High/Medium/Low]
   → Recommendation: [brief statement]

📂 Generated Files:
   ✓ temp/[sprint]/01-technical/ ([X] files)
   ✓ temp/[sprint]/02-market/ ([X] files)
   ✓ temp/[sprint]/03-architecture/ ([X] files)
   ✓ temp/[sprint]/04-compliance/ ([X] files)
   ✓ temp/[sprint]/05-roadmap/ ([X] files)
   ✓ reports/[sprint]-report.md

🔗 Git Status:
   ✓ Feature branch created: sprint-[XX]-execution
   ✓ All files committed
   ✓ Merged to develop branch

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Next Steps:
  1. Review report: cat reports/[sprint]-report.md
  2. Export findings: /export-findings [sprint-num] pdf
  3. Execute next sprint: /execute-sprint [next-num]
  4. Compare opportunities: /compare-sprints

🎉 Sprint execution successful!
```

List all files created with detailed statistics
Provide key findings from report
Show opportunity score and recommendation
Display execution metrics (time, file count, word count)

### Step 10: Update Configuration

Update sprint status in config/sprint-config.yml to "completed"

## Success Criteria

- All 6 tasks completed successfully
- Minimum 25 research files created
- Final report exists (5,000-7,500 words)
- Opportunity score calculated (0-100)
- Go/no-go recommendation provided
- Git commits created (if enabled)

## Error Handling

If sprint not found, guide user to run /create-sprint
If prerequisites missing, specify what's needed
If task execution fails, provide diagnostic info and recovery options

## Expected Output

User receives comprehensive sprint summary with file statistics, opportunity score, recommendation, and next steps.
