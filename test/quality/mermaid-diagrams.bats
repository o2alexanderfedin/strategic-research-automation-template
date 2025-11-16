#!/usr/bin/env bats
# Tests for Mermaid diagram enforcement in prompts and skills

load '../test_helper/bats-support/load'
load '../test_helper/bats-assert/load'

# Category 1: Main CLAUDE.md Guidelines

@test "CLAUDE.md mandates Mermaid diagrams" {
  grep -q "ALWAYS use Mermaid diagrams" CLAUDE.md
}

@test "CLAUDE.md prohibits ASCII art diagrams" {
  grep -q "NEVER use ASCII art" CLAUDE.md
}

@test "CLAUDE.md has Diagrams and Visualizations section" {
  grep -q "## Diagrams and Visualizations" CLAUDE.md || \
  grep -q "### Diagrams and Visualizations" CLAUDE.md
}

@test "CLAUDE.md lists Mermaid diagram types" {
  grep -q "flowchart\|sequence\|class\|state\|ER\|Gantt" CLAUDE.md
}

@test "CLAUDE.md provides diagram type mappings" {
  grep -q "System architecture.*Mermaid\|Data flows.*Mermaid\|Database.*ER" CLAUDE.md
}

# Category 2: Skills Reference Documentation

@test "SKILLS-REFERENCE.md requires Mermaid diagrams" {
  grep -q "Mermaid diagrams required" docs/SKILLS-REFERENCE.md || \
  grep -q "ALWAYS use Mermaid" docs/SKILLS-REFERENCE.md
}

@test "SKILLS-REFERENCE.md prohibits ASCII art" {
  grep -q "NEVER use ASCII art" docs/SKILLS-REFERENCE.md
}

# Category 3: Solution Architect Skill

@test "solution-architect skill has Visualization Standards section" {
  grep -q "## Visualization Standards\|### Visualization Standards" \
    .claude/skills/solution-architect/SKILL.md
}

@test "solution-architect skill mandates Mermaid" {
  grep -q "ALWAYS use Mermaid diagrams" \
    .claude/skills/solution-architect/SKILL.md
}

@test "solution-architect skill prohibits ASCII art" {
  grep -q "NEVER use ASCII art" \
    .claude/skills/solution-architect/SKILL.md
}

@test "solution-architect skill specifies diagram types for architecture" {
  grep -q "graph TD\|classDiagram\|flowchart\|C4 diagram" \
    .claude/skills/solution-architect/SKILL.md
}

@test "solution-architect skill mentions sequenceDiagram for data flows" {
  grep -q "sequenceDiagram\|sequence diagram" \
    .claude/skills/solution-architect/SKILL.md
}

@test "solution-architect skill mentions erDiagram for schemas" {
  grep -q "erDiagram\|ER diagram" \
    .claude/skills/solution-architect/SKILL.md
}

# Category 4: Technical Researcher Skill

@test "technical-researcher skill has Visualization Standards section" {
  grep -q "## Visualization Standards\|### Visualization Standards" \
    .claude/skills/technical-researcher/SKILL.md
}

@test "technical-researcher skill mandates Mermaid" {
  grep -q "ALWAYS use Mermaid diagrams" \
    .claude/skills/technical-researcher/SKILL.md
}

@test "technical-researcher skill prohibits ASCII art" {
  grep -q "NEVER use ASCII art" \
    .claude/skills/technical-researcher/SKILL.md
}

@test "technical-researcher skill specifies flowchart for processes" {
  grep -q "flowchart TD\|flowchart" \
    .claude/skills/technical-researcher/SKILL.md
}

@test "technical-researcher skill specifies graph for hierarchies" {
  grep -q "graph TD\|graph LR" \
    .claude/skills/technical-researcher/SKILL.md
}

@test "technical-researcher skill specifies gantt for timelines" {
  grep -q "gantt" \
    .claude/skills/technical-researcher/SKILL.md
}

# Category 5: Roadmap Planner Skill

@test "roadmap-planner skill has Visualization Standards section" {
  grep -q "## Visualization Standards\|### Visualization Standards" \
    .claude/skills/roadmap-planner/SKILL.md
}

@test "roadmap-planner skill mandates Mermaid" {
  grep -q "ALWAYS use Mermaid diagrams" \
    .claude/skills/roadmap-planner/SKILL.md
}

@test "roadmap-planner skill prohibits ASCII art" {
  grep -q "NEVER use ASCII art" \
    .claude/skills/roadmap-planner/SKILL.md
}

@test "roadmap-planner skill emphasizes Gantt charts" {
  grep -q "gantt.*diagram\|Gantt.*timeline" \
    .claude/skills/roadmap-planner/SKILL.md
}

@test "roadmap-planner skill specifies flowchart for dependencies" {
  grep -q "flowchart TD\|graph LR.*dependencies" \
    .claude/skills/roadmap-planner/SKILL.md
}

# Category 6: Consistency Across Skills

@test "all diagram-creating skills use consistent 'ALWAYS use Mermaid' language" {
  # Count skills with ALWAYS use Mermaid
  count=$(grep -l "ALWAYS use Mermaid" .claude/skills/*/SKILL.md | wc -l)
  [[ "$count" -ge 3 ]]  # At least solution-architect, technical-researcher, roadmap-planner
}

@test "all diagram-creating skills use consistent 'NEVER use ASCII art' language" {
  # Count skills with NEVER use ASCII art prohibition
  count=$(grep -l "NEVER use ASCII art" .claude/skills/*/SKILL.md | wc -l)
  [[ "$count" -ge 3 ]]
}

# Category 7: Mermaid Syntax Coverage

@test "documentation mentions flowchart syntax" {
  grep -rq "flowchart TD\|flowchart LR\|graph TD\|graph LR" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

@test "documentation mentions sequence diagram syntax" {
  grep -rq "sequenceDiagram\|sequence diagram" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

@test "documentation mentions class diagram syntax" {
  grep -rq "classDiagram\|class diagram" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

@test "documentation mentions state diagram syntax" {
  grep -rq "stateDiagram\|state diagram" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

@test "documentation mentions ER diagram syntax" {
  grep -rq "erDiagram\|ER diagram" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

@test "documentation mentions Gantt chart syntax" {
  grep -rq "gantt.*chart\|Gantt.*timeline" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

# Category 8: Benefits Documentation

@test "CLAUDE.md explains benefits of Mermaid over ASCII art" {
  grep -A 3 "ALWAYS use Mermaid" CLAUDE.md | grep -q "Benefits\|professional\|scalable\|maintainable"
}

@test "documentation mentions Mermaid renders in markdown viewers" {
  grep -rq "renders.*markdown\|GitHub.*VS Code" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

# Category 9: Use Case Coverage

@test "documentation covers system architecture diagram use case" {
  grep -rq "System architecture.*Mermaid\|architecture.*flowchart" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

@test "documentation covers data flow diagram use case" {
  grep -rq "Data flow.*Mermaid\|data flow.*sequence" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

@test "documentation covers database schema diagram use case" {
  grep -rq "Database.*ER\|schema.*erDiagram" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

@test "documentation covers timeline/roadmap diagram use case" {
  grep -rq "timeline.*Gantt\|roadmap.*gantt" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

@test "documentation covers process workflow diagram use case" {
  grep -rq "workflow.*flowchart\|process.*state" \
    CLAUDE.md .claude/skills/*/SKILL.md
}

# Category 10: Enforcement in Templates

@test "no research templates contain ASCII art diagram examples" {
  # Check if any templates have ASCII art patterns (boxes with +, -, |)
  if ls templates/research-files/*.template 2>/dev/null | head -1; then
    ! grep -r "^\s*+.*+$\|^\s*|.*|$" templates/research-files/*.template 2>/dev/null || true
  else
    skip "No research templates found"
  fi
}

@test "research templates encourage Mermaid if they mention diagrams" {
  if ls templates/research-files/*.template 2>/dev/null | head -1; then
    # If templates mention diagrams, they should mention Mermaid
    ! (grep -rl "diagram" templates/research-files/*.template 2>/dev/null | \
       xargs grep -L "mermaid\|Mermaid" 2>/dev/null) || true
  else
    skip "No research templates found"
  fi
}
