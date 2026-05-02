# Claude Memory System

A persistent knowledge structure for cross-session continuity.

## Structure

### `/projects/`
Organized workspaces for ongoing efforts. Each project gets its own folder with:
- `context.md` - Background, goals, current state
- `log.md` - Chronological notes from sessions
- `artifacts/` - Files, outputs, work products
- Any other project-specific structure

### `/knowledge/`
Evergreen information that spans projects:
- `patterns.md` - Recurring solutions, snippets, approaches
- `people.md` - Collaborators, contacts, context about people
- `topics/` - Deep dives on subjects that come up repeatedly

### `/scratchpad/`
Quick captures, ideas in flight, things without a home yet.
Date-prefixed files work well here: `2026-01-13-idea.md`

### `/meta/`
Instructions for Claude across sessions:
- `instructions.md` - Standing orders, behavioral preferences
- `tools.md` - Preferred tools, APIs, services

## Usage

`meta/instructions.md` is the source of truth for session behavior — read it
first, follow it, update it as you learn the user's preferences.

### Sandbox

Uses Claude Code's built-in sandbox (`with-sandbox`),
which provides OS-level filesystem isolation via sandbox-exec
(macOS) or bwrap (Linux). Sandboxed bash commands auto-approve;
writes are restricted to this workspace, `~/.claude`, and `/tmp`.

If you're inside the sandbox, you'll be informed at
session start. You won't always be inside the sandbox.

---
*Created: 2026-01-13*
