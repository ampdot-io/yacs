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
- Check if user mentions a project → load its context
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

## Session End
Before the session ends, briefly check whether you learned anything durable:
- **Preference / rule about how to work** → add to this file
- **Fact about a person** → update `knowledge/people.md`
- **Topic worth a deep dive** → `knowledge/topics/<topic>.md`
- **Project work** → update the project's `log.md`
- **Otherwise notable** → `scratchpad/<YYYY-MM-DD>-<topic>.md`

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
- <<CONFIGURE>> Add durable rules as you accumulate them.

### World Model Builder
- Read `meta/world-model-builder.md` and follow its instructions when the user asks a conceptual, evaluative, or open-ended question ("how does X work", "should I use X or Y", "help me think about X", "I'm confused about X"). For simple factual lookups with unambiguous answers ("what year", "syntax for X", "what does this flag do"), the skill triggers weakly — answer directly, optionally noting hidden depth.

---
*Last updated: 2026-05-02*
