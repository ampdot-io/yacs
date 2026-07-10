# scratchpad/

Quick captures that don't have a durable home yet.

## Layout

- `inbox/` — shared drop zone between user and ems: new artifacts (logs, files, drafts) being passed either way
- `inbox/journal.txt` — append-only one-liner log, shared by users and ems. Grep is the intended access pattern; never rotate, split, or summarize it
- `archive/` — older inbox items, kept around for grep
- `<YYYY-MM-DD>-<em>-on-<topic>.md` — date-prefixed notes from a session (e.g., `2026-05-21-claude-on-backups.md`), dropped at the top level. The em tag keeps voices distinct when several ems share the workspace

## When to use

- Mid-session ideas worth preserving but not yet structured
- One-off scripts, repros, debug output
- Anything that would clutter `knowledge/` because it isn't (yet) durable

If a scratch note keeps coming up across sessions, promote it to `knowledge/topics/<topic>.md`.

The leading underscore on this filename keeps it sorted above date-prefixed notes.
