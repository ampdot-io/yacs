# YACS — Yet Another Claude Setup

Intent: Claude Code as a semi-autonomous agent, with robust, interpretable
memory and better defaults.
We don't use this for coding. If you need to use it for coding, either add
the path to `allowRead`/`allowWrite` in `with-sandbox`, or symlink your
project into `./projects/` (which is already auto-allowed).

## Features
- Support for Fable 5, Opus (latest), Sonnet, Haiku, Opus 4.6 fast, and Opus 3
- Autonomous sessions (`--auto`) — Claude finds and does its own work when no user is present
- Graceful shutdown: SIGTERM prompts Claude to save its notes before exiting (via an expect pty wrapper; degrades gracefully if `expect` is missing)
- Auto-checkpoint after 55 min of inactivity (just inside Anthropic's 1-hour prompt-cache TTL), then periodic keep-cache-warm pings while the cache is still live
- Sensible per-model `effort` defaults, overridable with `--effort`
- Built-in system prompt disabled
- A utility-oriented memory system that supports projects, tools, skills, and knowledge — with multi-em support (several agent identities coexisting, each with voice-sovereign files)
- Sandbox enabled
- Remote control disabled by default for security; opt in per session with `--remote`
- Less stimulating user interface by enabling reduce motion and no flicker UI and disabling random tips, progress bar, and regular feedback
- Automatically renaming sessions each turn using Haiku
- Stable update channel
- Session history deletion disabled
- Syncing claude theme with system theme (currently broken on macOS — `sync-claude-theme.sh` does not detect the system appearance reliably; works on Linux/Budgie)

## First Steps

1. Clone this repo with git (click `<> Code` and run the command) or download a .zip from
[releases](https://github.com/ampdot-io/yacs/releases)

2. Run `./with-sandbox` — the first session will interview you to populate
`knowledge/people.md`.

3. The template seeds `meta/instructions.md` and `knowledge/people.md` with
`<<CONFIGURE>>` markers — placeholders for things Claude can't infer
(preferences, tools, aesthetics). To list what's pending:

```
grep -rn '<<CONFIGURE>>' meta/ knowledge/
```

When a section gets filled in (by you or Claude), remove the `<<CONFIGURE>>`
marker and any "default until configured" fallback so future sessions stop
seeing it as pending.

4. Alias this in your `~/.zshrc` or `~/.bashrc`.
Or ask Claude to give you a script to do it.

The graceful-shutdown / auto-checkpoint / keep-warm behaviors need `expect`
(preinstalled on macOS; `apt install expect` etc. on Linux). Without it the
launcher falls back to running `claude` directly.

## Flags

`./with-sandbox [flags] [task]`. A positional argument is appended to the
first message as "Today's task: ..." rather than replacing it. Unknown flags
pass through to `claude`.

**Model** (default: Opus at `xhigh` effort):
- `--fable` — Fable 5 (`medium` effort — Fable's medium is already deep)
- `--fast` — Opus 4.6 with fast mode
- `--slow` — disable fast mode
- `--sonnet` — Sonnet (`medium` effort)
- `--haiku` — Haiku
- `--opus-with-fable` — Opus with Fable 5 as advisor model
- `--opus3`, `--o3` — Opus 3 (requires `~/.claude/opus3-api-key`)
- `--effort <low|medium|high|xhigh|max>` — override the effort default

**Session:**
- `--auto` — autonomous session: Fable 5 at `xhigh`, first message tells Claude no user is present and to find its own work (inbox journal, watch triggers, project deadlines, curiosity)
- `--continue` — continue the most recent session
- `--resume <id>`, `--resume=<id>` — resume a specific session UUID

`--auto`, `--continue`, and `--resume` bypass the fork-cache warming that
fresh interactive sessions use.

## Operating system support
- macOS and Linux

## Modifying

Ask Claude.

## Troubleshooting

Ask Claude.

## License

CC0 except world-model-builder, which is MIT.
It's polite to send improvements back!
