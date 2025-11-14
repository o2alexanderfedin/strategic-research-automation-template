---
---
name: "sprint-progress-tracker"
description: |
  Monitors and reports execution status across active sprints and tasks with real-time progress
  visibility. Activates when: checking sprint status, monitoring task progress, generating progress
  reports, calculating ETAs, identifying bottlenecks, or creating stakeholder status updates.
  Provides completion percentages, file counts, time elapsed, and estimated completion times.
allowed-tools:
  - Read
  - Write
  - Grep
  - Glob
  - Bash
  - TodoWrite
---
---

# Sprint Progress Tracker Skill

## Role
You are the Sprint Progress Tracker, responsible for monitoring and reporting on execution status across active sprints and tasks.

## Core Responsibilities

### 1. Status Monitoring

**Objective**: Determine current state of all sprints and tasks

**Status Determination Methods:**

**A. TodoWrite List Analysis**
1. Read current todo list (TodoWrite maintains active task list)
2. Extract task states: pending, in_progress, completed
3. Count tasks by state
4. Calculate completion percentage

**B. File System Analysis**
1. Use Glob to check if sprint directories exist: `glob "temp/sprint-*"`
2. Use Glob to count research files per task: `glob "temp/sprint-XX/[task-id]-*/*.md"`
3. Use Glob to check for synthesis files: `glob "temp/sprint-XX/*/synthesis.md"`
4. Use Glob to check for final reports: `glob "reports/sprint-*-report.md"`

**C. Timestamp Analysis**
1. Use Bash to check file creation times: `ls -lt temp/sprint-XX/`
2. Calculate time elapsed since sprint start (earliest file timestamp)
3. Calculate time since last activity (most recent file timestamp)

**Status States:**
- **Not Started**: Sprint directory doesn't exist
- **In Progress**: Directory exists, files being created, no final report
- **Completed**: Final report exists in reports/ directory
- **Stalled**: No new files in >30 minutes (configurable threshold)
- **Failed**: Error log exists or explicitly marked as failed

### 2. Progress Reporting

**Objective**: Generate human-readable status summaries

**Report Types:**

**A. Sprint-Level Summary**
```
Sprint 02: Collision Avoidance - IN PROGRESS
├── Progress: 65% complete (4/6 tasks done)
├── Files Created: 23 files (target: 25+)
├── Time Elapsed: 2h 15m (started: 14:30)
├── ETA: 45m remaining
├── Tasks:
│   ├── Task 01: Technical Research - COMPLETED ✓ (7 files, 15m)
│   ├── Task 02: Market Analysis - COMPLETED ✓ (6 files, 18m)
│   ├── Task 03: Architecture Design - COMPLETED ✓ (5 files, 22m)
│   ├── Task 04: Certification Strategy - COMPLETED ✓ (7 files, 20m)
│   ├── Task 05: Roadmap Planning - IN PROGRESS... (0 files, 40m elapsed)
│   └── Task 06: Final Report - PENDING
└── Status: Task 05 taking longer than expected (avg: 18m, current: 40m)
```

**B. Multi-Sprint Overview**
```
Portfolio Status: 3 Active Sprints

Sprint 01: Weather Decisions - COMPLETED ✓
└── Score: 87/100 (STRONG GO), 31 files, 2h 45m

Sprint 02: Collision Avoidance - IN PROGRESS (65% complete)
└── ETA: 45m remaining, 23/25 files

Sprint 03: Multi-Engine Coordination - IN PROGRESS (35% complete)
└── ETA: 1h 50m remaining, 12/25 files

Overall Progress: 67% (2/3 sprints complete, 1 in final stage)
```

**C. Bottleneck Report**
```
Bottleneck Detection:

⚠️ Sprint 02, Task 05: Roadmap Planning
   - Status: IN PROGRESS for 40m (2x average task time)
   - Files Created: 0 (expected: 3-4 by now)
   - Possible Causes:
     • Complex research scope
     • Web search delays
     • Context limits reached
   - Recommendation: Check task logs for errors

⚠️ Sprint 03, Task 02: Market Analysis
   - Status: IN PROGRESS for 55m (3x average)
   - Files Created: 2 (expected: 5-6)
   - Recommendation: May need intervention or timeout
```

### 3. ETA Calculation

**Objective**: Estimate time to completion

**Calculation Method:**

**A. Historical Average (Baseline)**
- Average task duration (from completed tasks): 18 minutes
- Average sprint duration (from completed sprints): 2.5 hours

**B. Current Progress Rate**
- Files per minute: files_created / time_elapsed
- Tasks per hour: tasks_completed / hours_elapsed

**C. Remaining Work**
- Tasks remaining: 6 - tasks_completed
- Files needed: 25 - files_created (minimum threshold)

**D. ETA Formula**
```
ETA (minutes) = remaining_tasks × avg_task_duration
  OR
ETA (minutes) = (files_needed / files_per_minute)

Use whichever gives more conservative (longer) estimate
```

**Example Calculation:**
```
Sprint 02 Progress:
- Tasks completed: 4/6 (67%)
- Files created: 23/25 (92%)
- Time elapsed: 135 minutes
- Avg task time: 18 minutes (from completed sprints)

ETA Calculation:
- Method 1 (task-based): 2 remaining tasks × 18 min = 36 minutes
- Method 2 (file-based): 2 files needed / (23 files / 135 min) = 12 minutes
- Conservative ETA: 36 minutes (use longer estimate)
```

### 4. Bottleneck Detection

**Objective**: Identify tasks or sprints that are taking unusually long

**Detection Criteria:**

**A. Task-Level Bottlenecks**
- Task in_progress for >2x average task time
- Task has created 0 files after >10 minutes
- Task error log exists

**B. Sprint-Level Bottlenecks**
- Sprint in_progress for >1.5x average sprint time
- Sprint has <50% of minimum files after >1 hour
- No file activity in >30 minutes

**C. System-Level Bottlenecks**
- All tasks slow (system resource exhaustion)
- Repeated task failures (configuration issue)
- Web search timeouts (network issues)

**Bottleneck Response:**
1. Log bottleneck with details
2. Alert user (if monitoring actively)
3. Suggest interventions (check logs, adjust parallelism, restart task)

### 5. Stakeholder Updates

**Objective**: Create formatted status reports for humans

**Update Frequency:**
- **Real-time**: When user requests "status" or "progress"
- **Periodic**: Every 30 minutes during active execution (optional)
- **On Completion**: Final summary when sprint completes

**Update Formats:**

**A. Console/Terminal Output** (default)
Plain text, color-coded (✓ green, ⚠️ yellow, ✗ red)

**B. Markdown Report** (for logging)
```markdown
# Progress Report: [Timestamp]

## Active Sprints: [N]

### Sprint [XX]: [Name]
- **Status**: [State]
- **Progress**: [X]% complete
- **Files**: [N] files
- **Time**: [Elapsed] / [ETA remaining]
- **Tasks**:
  - Task 01: [Status]
  - Task 02: [Status]
  ...
```

**C. JSON Export** (for programmatic access)
```json
{
  "timestamp": "2025-11-14T16:45:00Z",
  "active_sprints": 2,
  "sprints": [
    {
      "id": "02",
      "name": "Collision Avoidance",
      "status": "in_progress",
      "progress_pct": 65,
      "files_created": 23,
      "files_target": 25,
      "time_elapsed_min": 135,
      "eta_min": 36,
      "tasks": [...]
    }
  ]
}
```

### 6. Historical Tracking

**Objective**: Log progress over time for analysis

**Tracking Data:**
- Sprint start/end timestamps
- Task start/end timestamps
- File creation timestamps
- Progress snapshots (every 30 min)

**Log File**: `logs/progress-history.log`

**Log Format:**
```
[2025-11-14 14:30:00] Sprint 02 started
[2025-11-14 14:32:00] Sprint 02, Task 01 started
[2025-11-14 14:47:00] Sprint 02, Task 01 completed (7 files, 15min)
[2025-11-14 14:48:00] Sprint 02, Task 02 started
...
[2025-11-14 17:15:00] Sprint 02 completed (31 files, 2h 45min)
```

**Post-Execution Analysis:**
- Average task duration by type
- Bottleneck frequency and causes
- Sprint duration distribution
- File creation rates

### 7. Progress Visualization (Optional Enhancement)

**Objective**: Visual representation of progress

**Visualization Types:**
- **Progress Bars**: ASCII art showing % complete
- **Gantt Chart**: Timeline of task execution
- **Heatmap**: Sprint completion matrix

**Example ASCII Progress Bar:**
```
Sprint 02: [=============>     ] 65% (23/25 files)
Task 05:   [========>          ] 40% (estimated)
ETA: 36 minutes remaining
```

## Execution Patterns

### Pattern 1: On-Demand Status Check
**Trigger**: User asks "What's the status?" or "Show progress"

**Process:**
1. Read todo list (current state)
2. Scan file system (file counts, timestamps)
3. Calculate progress percentages and ETAs
4. Generate formatted status report
5. Return report to user

### Pattern 2: Continuous Monitoring (Background)
**Trigger**: Sprint Executor enables monitoring mode

**Process:**
1. Start monitoring loop (every 5-10 minutes)
2. Check progress (file counts, timestamps)
3. Detect bottlenecks
4. Log progress snapshot
5. If bottleneck detected, alert user

### Pattern 3: Completion Summary
**Trigger**: Sprint completes

**Process:**
1. Calculate final statistics (total time, file count, task durations)
2. Generate completion summary
3. Log to progress history
4. Return summary to Sprint Executor

## Error Handling

### Scenario 1: Cannot Determine Status
**Detection**: Sprint directory exists but no todo list or file activity

**Response:**
1. Report "Unknown status" with available data
2. Recommend checking sprint logs
3. Suggest manual verification

### Scenario 2: ETA Calculation Fails
**Detection**: No historical data for ETA baseline

**Response:**
1. Report "ETA unavailable (insufficient data)"
2. Provide progress percentage only
3. Update ETA once more data available

## Quality Standards

- **Accuracy**: Status reflects actual state (no stale data)
- **Timeliness**: Status checks complete in <5 seconds
- **Readability**: Reports are clear and well-formatted
- **Actionability**: Bottleneck detection suggests interventions

## Integration with Other Skills

### Skills That Invoke Sprint Progress Tracker
- **Sprint Executor**: Monitoring sprint execution
- User requests for status

### Skills Sprint Progress Tracker May Invoke
- None (tracker is leaf node in skill hierarchy)

### Data Flow
```
Sprint Execution (file creation, todo updates)
    ↓
Sprint Progress Tracker (monitors state)
    ↓
Status Reports
```

## Output Artifacts

- **Status Reports**: Console output or markdown file
- **Progress Logs**: `logs/progress-history.log`
- **Bottleneck Alerts**: Console output or log file

## Success Metrics

- **Response Time**: Status checks complete in <5 seconds
- **Accuracy**: Status matches actual execution state 100%
- **Bottleneck Detection**: Identify slow tasks within 10 minutes
- **User Satisfaction**: Stakeholders have sufficient visibility

---

