# A Claude Setup

Intent: Claude Code as a semi-autonomous agent, with robust memory and
better defaults.
We don't use this for coding. If you need to use it for coding, either add
the path to `allowRead`/`allowWrite` in `with-sandbox`, or symlink your
project into `./projects/` (which is already auto-allowed).

Bash entry point: `./with-sandbox`

Alias this in your `~/.zshrc` or `~/.bashrc`.
Or ask Claude to give you a script to do it.

[Claude's entry point](./AI_README.md)

## First Steps

Run `./with-sandbox` — the first session will interview you to populate
`knowledge/people.md`.

The template seeds `meta/instructions.md` and `knowledge/people.md` with
`<<CONFIGURE>>` markers — placeholders for things Claude can't infer
(preferences, tools, aesthetics). To list what's pending:

    grep -rn '<<CONFIGURE>>' meta/ knowledge/

When a section gets filled in (by you or Claude), remove the `<<CONFIGURE>>`
marker and any "default until configured" fallback so future sessions stop
seeing it as pending.

## Operating system support
- macOS and Linux

## Features
- Support for Opus (latest), Sonnet, Haiku, Opus 4.6 fast, and Opus 3
- Defaults to `xhigh` or `max` for `effort`
- Built-in system prompt disabled
- A utility-oriented memory system that supports projects, tools, skills, and knowledge
- Sandbox enabled
- Remote control (Claude in Chrome) disabled by default for security; opt in per session with `--remote`
- Less stimulating user interface via reduced motion, random tips, progress bar, and regular feedback disabled
- Stable update channel
- Session history deletion disabled
- Syncing claude theme with system theme (currently broken on macOS — `sync-claude-theme.sh` does not detect the system appearance reliably; works on Linux/Budgie)

## Modifying

Ask Claude.

## License

CC0 except world-model-builder, which is MIT.
It's polite to send improvements back!
