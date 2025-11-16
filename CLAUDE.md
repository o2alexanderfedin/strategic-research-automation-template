# Claude Code Guidelines for Strategic Research Automation

## Task Execution Strategy

### Context Optimization
Extensively use tasks and subtasks (Task tool) to optimize the context usage.

### Parallel Execution
Extensively use parallel tasks and subtasks (multiple Task tools running in the same message) to make the work be done much faster.

### Map-Reduce Approach
Use map-reduce approach with parallel tasks and subtasks for research decomposition.

### Task Reporting
Ensure each task or subtask reports back a very brief explanation on what was done, and what still needs to be done (if any).

### Problem Resolution
Ensure that in case of any problem that task or subtask experiences, it **must** spawn another [set of] subtask(s) to do necessary research and/or experiments in order to resolve the issue.

### Planning and Tracking
Extensively use planning (with TodoWrite tool), so all work is being thoroughly and reliably tracked, and nothing is skipped or lost.

### Parallelization Limits
The maximum number of tasks or subtasks running in parallel should not be more than CPU cores on this machine.

## Research Principles

### Evidence-Based Research
All claims must be supported by credible citations from:
- Industry regulations and standards
- Academic research and peer-reviewed journals
- Market reports from reputable firms
- Technical documentation and specifications
- Expert interviews (with permission)

### Citation Format
Follow the citation style specified in `config/project-config.yml` (default: APA).

### Source Quality Standards
Prioritize authoritative sources:
1. **Primary sources**: Regulatory documents, standards, official specifications
2. **Secondary sources**: Academic research, industry reports, technical documentation
3. **Tertiary sources**: News articles, blog posts (use sparingly, verify with primary/secondary sources)

### Cross-Referencing
Maintain internal consistency:
- Reference findings from other tasks within the sprint
- Link related research files
- Build upon previously established facts

## Quality Standards

### Dual-Audience Writing
All reports must serve both:
1. **Business Executives**: Clear value propositions, ROI, strategic implications
2. **Technical Decision-Makers**: Technical feasibility, architecture details, implementation requirements

### Document Structure
Every research file must include:
- **Executive Summary**: 2-3 paragraphs summarizing key findings
- **Key Findings**: Bulleted list of main discoveries
- **Supporting Evidence**: Detailed analysis with citations
- **References**: Full citation list

### File Organization
- Minimum 25 research files per sprint (configurable in `config/project-config.yml`)
- Each file should be focused and self-contained (500-5000 words)
- Use clear, descriptive filenames
- Organize files by task (01-technical, 02-market, 03-architecture, etc.)

## Git Workflow

### No Pull Requests
This is a solo research workflow - commit directly to main branch.

### Commit Frequently
Commit research files as they are completed:
```bash
git add temp/sprint-XX/
git commit -m "Sprint XX, Task YY: [brief description of research completed]"
git push
```

### Sprint Milestones
Create a git tag/release after completing each sprint:
```bash
git tag -a sprint-XX-complete -m "Sprint XX: [Sprint Name] - Complete"
git push --tags
```

## Configuration Management

### Project Configuration
All project settings are in `config/` directory:
- **project-config.yml**: Project metadata, research parameters
- **sprint-config.yml**: Sprint definitions and task breakdown
- **quality-standards.yml**: Evidence requirements, quality thresholds
- **scoring-rubric.yml**: Opportunity scoring criteria
- **glossary.yml**: Industry-specific terminology

### Environment Variables
Sensitive data goes in `.env` (never commit):
- API keys (ANTHROPIC_API_KEY, etc.)
- Credentials for external services
- Runtime configuration overrides

### Context Files
Project-specific context in `context/` directory:
- **company-profile.md**: Your company's capabilities, goals, constraints
- **client-info.md**: Client background, requirements, preferences
- **industry-background.md**: Industry-specific knowledge and context

## Skills and Commands

### Skills (Model-Invoked Agents)
Claude Code will automatically invoke skills based on task requirements:
- **sprint-orchestrator**: Coordinates multi-task sprint execution
- **technical-researcher**: Investigates regulatory, technical, standards
- **market-analyst**: Analyzes TAM/SAM/SOM, competitors, customers
- **solution-architect**: Designs system architecture and components
- **compliance-analyst**: Researches certification pathways and testing
- **roadmap-planner**: Creates implementation roadmaps and timelines
- **report-synthesizer**: Synthesizes final reports with scoring

### Commands (User-Invoked)
Execute commands via Claude Code CLI:
- `/init-project`: Initialize new research project
- `/create-sprint <name>`: Create new sprint directory structure
- `/execute-sprint <id>`: Execute all tasks in a sprint
- `/execute-task <sprint-id> <task-id>`: Execute single task
- `/synthesize-report <sprint-id>`: Create final sprint report
- `/score-opportunity <sprint-id>`: Score opportunity using rubric
- `/validate-quality <sprint-id>`: Run quality assurance checks

## Automation Principles

### Autonomous Operation
Skills operate autonomously within their domain:
- Skills make research decisions without asking for permission
- Skills parallelize research where beneficial
- Skills create comprehensive research files (not summaries)

### Human Checkpoints
Stop for human input only for:
- Strategic decisions (which opportunities to pursue)
- Go/No-Go recommendations requiring business judgment
- Ambiguous requirements or conflicting information
- Budget or timeline constraints

### Error Handling
If a skill encounters an issue:
1. Document the issue clearly
2. Attempt alternative approaches (different sources, search strategies)
3. If unresolvable, flag in research notes and continue
4. Never leave placeholders or "TODO" markers

## Output Standards

### Research Files
- Write in markdown format
- Include metadata header (title, date, author skill, sprint/task)
- Use clear section headings
- Include inline citations [Author, Year]
- Add full reference list at end

### Diagrams and Visualizations
- **ALWAYS use Mermaid diagrams** for all visual representations
- **NEVER use ASCII art** for diagrams (hard to read, unprofessional)
- Mermaid supports: flowcharts, sequence diagrams, class diagrams, state diagrams, ER diagrams, Gantt charts, pie charts, and more
- Benefits: Clean, professional, scalable, maintainable, renders beautifully in markdown viewers
- Example use cases:
  - System architecture → Mermaid flowchart or C4 diagram
  - Data flows → Mermaid flowchart or sequence diagram
  - Process workflows → Mermaid flowchart or state diagram
  - Database schemas → Mermaid ER diagram
  - Project timelines → Mermaid Gantt chart
  - Component relationships → Mermaid class or component diagram

### Final Reports
- Professional formatting suitable for stakeholder presentations
- Executive summary (1-2 pages)
- Detailed findings (10-30 pages depending on complexity)
- Appendices for supporting data
- Export in multiple formats (markdown, PDF, DOCX)

### Deliverables
Each sprint produces:
- Research files in `temp/sprint-XX/`
- Final report in `reports/sprint-XX-final-report.md`
- Opportunity score (0-100) with breakdown
- Go/No-Go recommendation with justification
