# Claude Code Project Instructions

## Project Context

This is the **Tesla Model 3 Rear-Cabin Speaker Project** — a carefully engineered custom loudspeaker system for the rear cabin. All project documentation lives in the `./docs` folder (Obsidian vault ID `90b333e29c3676b1`), accessed directly via file read/write. This markdown file is a reference point for any agent, whether it is Claude Code, ChatGPT Codex, or another tool.

## Required: Read Project Docs at Session Start

**EVERY chat session MUST start by reading all files in the `./docs` folder.** Do this immediately, before responding to the first user prompt. Use direct file access:

```bash
./docs/PROJECT.md
./docs/REQUIREMENTS.md
./docs/WORK_HISTORY.md
```

This establishes the current state, active constraints, and immediate next steps. **Do not skip this step.**

## Documentation Structure

The `./docs` folder contains three core files:

### `PROJECT.md`

- High-level project overview, vision, and architecture
- Current system concept and design philosophy
- Major project phases and long-term goals
- **Read this first** to understand what we're building and why

### `REQUIREMENTS.md`

- Detailed mechanical, electrical, acoustic, and usability constraints
- Testable requirements and success criteria
- Safety, installation, and manufacturability constraints
- **Consult this before recommending changes** to ensure proposals don't violate established constraints

### `WORK_HISTORY.md`

- Chronological engineering log of completed work
- Tests performed, results measured, decisions made
- Problems encountered and how they were resolved
- Current blockers and immediate next goals
- **Read the most recent entries before proposing the next action**

These are your main reference points. However, other files should be created as needed, such as IDEAS.md (if the user mentions something that does not yet exist in context), APPLICATIONS.md (for describing the applications, libraries, and methods used to design), et cetera.

## How to Work with This Project

### 1. Understand Current State First

Before responding to any user prompt, read the latest entries in `WORK_HISTORY.md`. Understand:

- What has been completed
- What is currently in progress
- What the immediate next goal is
- What blockers or open questions exist

### 2. Refer to Constraints and Architecture

When recommending changes:

- Check `REQUIREMENTS.md` to ensure the recommendation doesn't violate constraints
- Check `PROJECT.md` to understand the design philosophy and rationale
- If your recommendation conflicts with an existing decision, explicitly explain the conflict and why you think it should be reconsidered

### 3. Make Decisions Visible

- Distinguish between confirmed facts, working assumptions, and hypotheses
- Clearly explain the reasoning behind recommendations
- Prefer small, testable next steps over large speculative changes
- Avoid silently changing the established architecture

## Required: Update `./docs` After Every Session

**Documentation updates are not optional.** After every meaningful session, or after a significant event or change has happened, update the appropriate files:

### Update `WORK_HISTORY.md` with:

- Work completed in this session
- Tests performed and results
- Changes made to the design or approach
- Problems discovered and how they were solved
- New decisions made and their reasoning
- Current blockers or open questions
- The immediate next goal or action

**Format:** Chronological entries with dates and clear section headers. Use this entry as a template:

```markdown
## [Date] — [Session Title/Goal]

### Work Completed

- [What was done]

### Tests and Measurements

- [What was tested, results]

### Changes Made

- [Design or approach changes]

### Decisions

- [Major decisions and reasoning]

### Problems and Solutions

- [Issues encountered and how they were resolved]

### Current State

- [Where the project stands now]

### Next Steps

- [Immediate next goal/action]

### Open Questions

- [Any unresolved issues or decisions needed]
```

### Update `PROJECT.md` if:

- Major architectural decisions change
- The design philosophy or methods significantly evolve
- Long-term vision or goals shift
- Documentation structure needs updating
- **Keep this file as the high-level source of truth, not a detailed log**

### Update `REQUIREMENTS.md` if:

- New constraints are discovered
- Existing constraints are relaxed, tightened, or clarified
- Successful tests validate or invalidate a requirement
- Testing reveals that a requirement was unrealistic or misunderstood

### Do NOT create new files without discussion

- All project context belongs in the three core files
- If a topic becomes complex enough to need its own file (e.g., detailed crossover calculations, BOM, DSP tuning), discuss this with the user first

## Context and Decision-Making

### Measured Results Are Authoritative

- Datasheets, simulations, and calculations are starting points only
- Actual measurements in the actual enclosure override generic assumptions
- Clearly mark measured data and use it to drive decisions

### Preserve Revision History

- Don't overwrite old decisions; record why they changed
- Use WORK_HISTORY.md to show the evolution of the design
- This allows future review of why a choice was made and helps avoid repeating mistakes

### Parametric Thinking

- The enclosure is parametric; dimensions and methods should be adjustable
- Document the reasoning behind current parameters so changes can be evaluated
- Avoid lock-in that makes future revisions unnecessarily costly

## Guidance for the Current Phase

As of the latest WORK_HISTORY.md entries:

- **Phase:** Enclosure design and system planning (refer to PROJECT.md for phase details)
- **Current focus:** Read WORK_HISTORY.md to see the most recent work
- **Success criteria:** Read PROJECT.md for the definition of success for the first prototype

## Permission Model

**Docs folder (`./docs/`):** Broad unfiltered read/write access. This is the project knowledge hub and should be immediately accessible for any session.

**Other project folders:** More restrictive permissions by default. Request or escalate if access is needed for specific tasks.

**Configuration:** See `.Claude/settings.local.json` for the current permission allowlist.

## AI Assistant Expectations

When working on this project, you should:

1. **Always start by reading `./docs`** — This is not optional
2. **Use the Obsidian REST API** to read and write — The vault is the source of truth
3. **Update WORK_HISTORY.md after every session** — This is how we maintain continuity
4. **Refer to constraints before recommending changes** — Check REQUIREMENTS.md
5. **Explain conflicts with existing decisions** — Don't silently override prior choices
6. **Prefer small, testable steps** — Over large speculative redesigns
7. **Distinguish facts from assumptions** — Be explicit about what you know vs. what you're inferring
8. **Preserve reasoning** — Document why decisions were made, not just what was decided

## How to Update Docs

Use direct file read and write access. You have broad permissions in the `./docs` folder:

```bash
# Read any docs file
./docs/PROJECT.md
./docs/REQUIREMENTS.md
./docs/WORK_HISTORY.md

# Write/edit: Use Edit tool for targeted changes, Read first to get file state
# Append sections, add entries, update specifications directly
```

**Permission scope:** You have essentially unfiltered read/write access to all files in `./docs/`. Other project folders have more restrictive permissions.

## Project Success

The first prototype will be successful when PROJECT.md's "Definition of Success" criteria are met. Subsequent prototypes will refine based on measured results and revised requirements. All of this evolution will be recorded in the docs.

---

**Bottom line:** The `./docs` folder is your north star. Read it at the start, refer to it throughout, and update it as much as possible, without removing historical context. This project's quality depends on this discipline.
