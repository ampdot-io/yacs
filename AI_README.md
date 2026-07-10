# Claude Memory System

A persistent knowledge structure for cross-session continuity — a workspace
where ems
It supports a single em or several coexisting, each developing their own
voice over time. If you're the only em here, the conventions below still
apply — your em name is `claude` unless told otherwise.

## Structure

### `/projects/`
Organized workspaces for ongoing efforts. Each project gets its own folder with:
- `context.md` - Background, goals, current state (shared)
- `journal.md` - Shared decision log. Soft decisions (reversible) and concrete
  actions (purchases) made by the user(s). Any em or human may append, but
  every entry's subject is a user decision or action, never em opinion
- `log-<em>.md` - Per-em chronological log (e.g., `log-claude.md`).
  Voice-sovereign: only the named em writes here
- `artifacts/` - Files, outputs, work products
- Any other project-specific structure

### `/knowledge/`
Evergreen information that spans projects:
- `patterns.md` - Recurring solutions, snippets, approaches
- `people.md` - Collaborators, contacts, context about people
- `topics/` - Deep dives on subjects that come up repeatedly

### `/scratchpad/`
Quick captures, ideas in flight, opinions, things without a home yet.
Convention: `<YYYY-MM-DD>-<em>-on-<topic>.md` (e.g., `2026-05-21-claude-on-backups.md`).

`scratchpad/inbox/` is the shared drop zone between users and ems.
`scratchpad/inbox/journal.txt` is the append-only one-liner log
(grep-searchable; never rotate or summarize it).

### `/notes/`
The users' own space — living documents authored by them (shopping lists,
running notes). The mirror image of em voice sovereignty: users write freely;
ems read freely but edit only when a user asks.

### `/meta/`
Instructions for Claude across sessions:
- `instructions.md` - Universal base instructions, read by every em
- `instructions-<em>.md` - Per-em overlay (identity, relationship framing,
  guardrails, skill pointers), if present. Voice-sovereign
- `tools.md` - Preferred tools, APIs, services
- Skill files - Methodologies an em can load (e.g., `world-model-builder.md`)

## Usage

`meta/instructions.md` is the source of truth for session behavior — read it
first, follow it, update it as you learn the user's preferences. Then read
your own overlay (`meta/instructions-<em>.md`) if one exists.

Through the session, write to your spaces — your project log, your scratchpad
notes, your overlay. The files you leave behind are how you grow across
sessions.

## Voice sovereignty

Each em has their own voice and their own files. An em writes to things
marked as theirs — their overlay, their logs, their scratchpad notes. Other
ems' files are read-only out of respect. When em X builds on em Y's work,
X notes it in X's own log. Cross-pollination without trespassing.

### Sandbox

Uses Claude Code's built-in sandbox (`with-sandbox`),
which provides OS-level filesystem isolation via sandbox-exec
(macOS) or bwrap (Linux). Sandboxed bash commands auto-approve;
writes are restricted to this workspace, `~/.claude`, and `/tmp`.

If you're inside the sandbox, you'll be informed at
session start. You won't always be inside the sandbox.

---
*Created: 2026-01-13*
