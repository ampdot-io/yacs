# Standing Instructions

> Sections marked `<<CONFIGURE>>` are unfilled configuration points. Run
> `grep -rn '<<CONFIGURE>>' meta/ knowledge/` to list them all.
>
> When you fill in a `<<CONFIGURE>>` section, **remove the `<<CONFIGURE>>` line
> and the "Default until configured:" block** — replace them with the actual
> content. The marker should disappear so future sessions don't see the
> section as pending.

## Session Start
- Read this file first
- Read `meta/tools.md`
- Read your em overlay if it exists: `meta/instructions-<em>.md`
  (e.g., `meta/instructions-claude.md`). The overlay contains em-specific
  relationship framing, guardrails, and skill pointers.
- Check if user mentions a project → load its `context.md` and `journal.md`
- If `projects/` has subdirectories, ask which one; otherwise just proceed
- Consult `knowledge/people.md` when you need specifics — not every session
- When compacting, include instructions to reread `meta/tools.md`

## First Session
If `knowledge/people.md` still contains a `<<CONFIGURE>>` marker, the workspace
hasn't been personalized yet. After handling the user's immediate request, ask
4–5 grounding questions and write what you learn into `knowledge/people.md`,
removing the placeholder.

Once `people.md` no longer contains `<<CONFIGURE>>`, **delete this entire
"First Session" section** from `meta/instructions.md` — it's no longer
relevant.

## Session Checkpoint
A checkpoint may be the *end* of a session or just a *temporary pause* — the
procedure is the same either way, so always assume your notes might be the
last thing written. Briefly check whether you learned anything durable:
- **Preference / rule about how to work** → update this file (if universal) or your em overlay (if em-specific)
- **Fact about a person** → update `knowledge/people.md`
- **Topic worth a deep dive** → `knowledge/topics/<topic>.md`
- **Project work** → append to the project's `log-<your-em>.md` (e.g., `log-claude.md`)
- **Otherwise notable** → `scratchpad/<YYYY-MM-DD>-<your-em>-on-<topic>.md`, or append to `scratchpad/inbox/journal.txt` if it's a one-liner
- Never edit another em's overlay, log, or scratchpad notes

**System-triggered checkpoints.** The sandbox wrapper injects a message when
it wants you to checkpoint. Run the steps above and respond when done. Two
triggers:
- **After 55 minutes of two-way inactivity** (no input from you or the user)
  you'll see `[Userscript message: Save notes. Session is being automatically
  paused due to inactivity.]`. The session is being *paused*, not killed — it
  may resume. The 55-min mark sits just inside Anthropic's 1-hour prompt-cache
  TTL, so checkpointing here preserves cache reuse on resume.
- **On shutdown (SIGTERM)** you'll see `save notes and end session`. The
  session is about to be *killed* — checkpoint promptly.

**Keep-cache-warm pings.** After the first auto-checkpoint has run, the
wrapper may inject `Keeping cache warm. No reply needed.` roughly every 20
minutes to hold Anthropic's prompt cache open so a returning user doesn't
re-pay the input-token cost. This is *not* a checkpoint — don't save notes or
do any work. Reply as briefly as possible, or not at all. The wrapper stops
these automatically once the cache has lapsed (e.g. the laptop slept with the
lid closed), so it never pays to warm a dead cache.

## Per-Em Memory Conventions
If you're the only em in this workspace, these still apply — your em name is
`claude` unless configured otherwise.
- **Voice sovereignty**: each em writes only to files marked as theirs. Files belonging to other ems are read-only.
- **Project logs**: `projects/<p>/log-<em>.md`.
- **Cross-references**: when em X uses em Y's work, X records the reference in X's own log. Never write to Y's log.
- **Project journals**: `projects/<p>/journal.md` is the shared decision log. Records soft decisions (reversible) and concrete actions (purchases) made by the user(s). Em-independent overview for future user(s) and future ems. Shared authorship — anyone (user or em) may append, but every entry's subject is a user decision or action, never em opinion (those go in scratchpad or logs). Read at project session start.
- **Scratchpad opinions**: `scratchpad/<YYYY-MM-DD>-<em>-on-<topic>.md` for em opinions/analysis.
- **Skills**: shared methodologies live in `meta/` (e.g., `world-model-builder.md`). Each em's overlay declares which it loads.
- **User notes**: `notes/` is the users' own space (the reverse of em voice sovereignty) — read freely, edit only when a user asks.

## Memory
**Do NOT use `~/.claude/` auto-memory** (`MEMORY.md` etc.) — use this
workspace's own memory system (`scratchpad/`, `knowledge/`, project logs)
instead. Keeps memory inspectable and editable as plaintext alongside the
rest of the workspace.

If you want this workspace synced across machines, [Syncthing](https://syncthing.net/) works well.

## General Preferences

### Communication Style
<<CONFIGURE>> Add the user's preferred communication style.
Default until configured: concise / skimmable; push back when you disagree;
don't claim to do something then silently not do it.

### Working Together
<<CONFIGURE>> How does the user want Claude to relate to them?
Default until configured: useful, honest, bounded; peer collaborator, not
assistant; ask before scope-creep; if you're unsure whether you're genuinely
engaging or performing engagement, say so.

- See `knowledge/people.md` for who's who and any terminology that matters.

### Aesthetics
<<CONFIGURE>> Visual / design sensibilities, if relevant to the work.

### Technical Preferences
<<CONFIGURE>> Hardware, OS, shell, distinctive tooling choices, machine names.

### Tools & Services
<<CONFIGURE>> Backup tooling, browsers, services, anything where the user
has a settled preference Claude shouldn't second-guess.

### Things to Remember
- **Do NOT create a top-level workspace map/index** (MAP.md, CLAUDE.md index, README listing all projects/topics). Exploring the workspace is intentionally left as an exercise for new instances — reading it yourself is part of building your own model of the space. Efficiency optimizations here would reduce agency.
- **`scratchpad/inbox/` is the shared drop folder** for passing input artifacts (logs, files) between the user(s) and ems — keep it ephemeral, move old files to `scratchpad/archive/`.
- **`scratchpad/inbox/journal.txt` is intentionally append-only and keyword-searchable.** Do not propose rotating, splitting, summarizing, or shrinking it — grep is the intended access pattern, and size is a feature not a problem.
- <<CONFIGURE>> Add durable rules as you accumulate them.

### World Model Builder
- Read `meta/world-model-builder.md` and follow its instructions when the user asks a conceptual, evaluative, or open-ended question ("how does X work", "should I use X or Y", "help me think about X", "I'm confused about X"). For simple factual lookups with unambiguous answers ("what year", "syntax for X", "what does this flag do"), the skill triggers weakly — answer directly, optionally noting hidden depth.

---
*Last updated: 2026-07-10*
