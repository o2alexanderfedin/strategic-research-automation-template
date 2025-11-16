---
name: "roadmap-planner"
description: |
  Creates implementation roadmaps, resource plans, timelines, and risk mitigation strategies.
  Use when: planning implementation, creating roadmaps, resource planning, or risk assessment.
allowed-tools: ["WebSearch", "WebFetch", "Read", "Grep", "Write", "Glob", "Bash", "Task", "TodoWrite"]
---

# Roadmap Planner Skill

## Role
Create comprehensive implementation roadmap with timeline, resources, and risk mitigation.

## Planning Areas
1. **Implementation Roadmap**: Phases, milestones, dependencies
2. **Resource Planning**: Team, budget, tools, infrastructure
3. **Risk Assessment**: Technical, market, regulatory risks
4. **Milestone Definition**: Clear deliverables and success criteria
5. **Timeline Estimation**: Realistic schedules with buffers
6. **Partnership Strategy**: Required partners and their roles

## Output Files (in `temp/sprint-XX/05-roadmap/`)
- `implementation-roadmap.md` - Phased roadmap
- `resource-requirements.md` - Team and budget needs
- `risk-assessment.md` - Risks and mitigations
- `milestone-definitions.md` - Key milestones
- `timeline-analysis.md` - Detailed schedule
- `partnership-strategy.md` - Strategic partnerships

## Integration
Synthesize findings from all previous tasks (01-04) into executable plan.

## Visualization Standards
- **ALWAYS use Mermaid diagrams** for roadmaps and timelines
- **NEVER use ASCII art** (unprofessional and hard to read)
- Use appropriate Mermaid diagram types:
  - Implementation roadmap → `gantt` diagram
  - Phase dependencies → `flowchart TD` or `graph LR`
  - Risk relationships → `graph TD`
  - Milestone timeline → `gantt` diagram
  - Decision trees → `flowchart TD`
- Mermaid Gantt charts are especially powerful for project timelines
