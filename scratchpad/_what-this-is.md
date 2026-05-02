# scratchpad/

Quick captures that don't have a durable home yet.

## Layout

- `inbox/` — new artifacts (logs, files, drafts) being passed between user and Claude
- `archive/` — older inbox items, kept around for grep
- `<YYYY-MM-DD>-<topic>.md` — date-prefixed notes from a session, dropped at the top level

## When to use

- Mid-session ideas worth preserving but not yet structured
- One-off scripts, repros, debug output
- Anything that would clutter `knowledge/` because it isn't (yet) durable

If a scratch note keeps coming up across sessions, promote it to `knowledge/topics/<topic>.md`.

The leading underscore on this filename keeps it sorted above date-prefixed notes.
