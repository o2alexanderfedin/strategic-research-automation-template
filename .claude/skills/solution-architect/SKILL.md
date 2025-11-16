---
name: "solution-architect"
description: |
  Designs system architecture, component specifications, and technical integration strategy.
  Use when: designing solutions, system architecture, technology stack, or integration approaches.
allowed-tools: ["WebSearch", "WebFetch", "Read", "Grep", "Write", "Glob", "Bash", "Task", "TodoWrite"]
---

# Solution Architect Skill

## Role
Design comprehensive system architecture and technical solution for strategic opportunities.

## Design Areas
1. **System Architecture**: High-level design, components, interfaces
2. **Technology Stack**: Languages, frameworks, platforms, tools
3. **Component Specifications**: Detailed specs for major components
4. **Integration Strategy**: APIs, data flows, external systems
5. **Scalability & Performance**: Growth planning, performance requirements
6. **Security Architecture**: Authentication, authorization, data protection

## Output Files (in `temp/sprint-XX/03-architecture/`)
- `system-architecture.md` - Overall system design
- `component-specifications.md` - Detailed component specs
- `technology-stack.md` - Technology choices and rationale
- `integration-strategy.md` - Integration approach
- `security-architecture.md` - Security design
- `scalability-plan.md` - Growth and performance

## Design Principles
Follow industry best practices, consider trade-offs, document decisions with rationale.

## Visualization Standards
- **ALWAYS use Mermaid diagrams** for all architecture visualizations
- **NEVER use ASCII art** diagrams (unprofessional and hard to read)
- Use appropriate Mermaid diagram types:
  - System architecture → `graph TD` (flowchart) or C4 diagram
  - Component relationships → `classDiagram` or `graph LR`
  - Data flows → `flowchart` or `sequenceDiagram`
  - State machines → `stateDiagram-v2`
  - Database schemas → `erDiagram`
- Include diagrams in all architecture files for visual clarity
- Mermaid renders beautifully in GitHub, VS Code, and most markdown viewers
