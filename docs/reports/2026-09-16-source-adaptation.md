# Source Adaptation Report — 2026-09-16

## Scope

OpenCode Playbook preserves the governing agreement from the sibling Codex
Playbook while adapting only its delivery mechanics to OpenCode. This report
separates verified source parity from client-specific behavior; it does not
claim that different clients execute identical instructions identically.

## Verified rulebook parity

`AGENTS.md` is an exact byte-for-byte copy of
`../codex-playbook/AGENTS.md`, including the Codex-specific title and wording.
That language remains because the owner approved exact parity rather than a
semantic rewrite.

The following checks passed when the file was introduced:

```text
cmp AGENTS.md ../codex-playbook/AGENTS.md          exit 0
numbered rules matching ^[0-9]+\. \*\*            42
AGENTS.md bytes                                   13126
../codex-playbook/AGENTS.md bytes                 13126
SHA-256                                           7a2a0820d9f98818df5f315b4526a3e426f760a260ee18c2f162265d42962eaa
```

These checks establish content parity only. OpenCode behavior is documented
and tested separately.

## OpenCode instruction locations and precedence

The current [OpenCode rules documentation](https://opencode.ai/docs/rules/)
defines two native `AGENTS.md` locations:

- A project-root `AGENTS.md` supplies project-specific rules for that directory
  and its subdirectories. OpenCode traverses upward from the working directory
  to find local instruction files.
- `~/.config/opencode/AGENTS.md` supplies global rules across OpenCode sessions.

For local rules, `AGENTS.md` takes precedence over the Claude-compatible
`CLAUDE.md` fallback. For global rules,
`~/.config/opencode/AGENTS.md` takes precedence over
`~/.claude/CLAUDE.md`. OpenCode describes this as the first matching file
winning within each category. This repository therefore uses the native
project filename and plans to install the same agreement at the native global
location.

## Skills and progressive disclosure

The current [OpenCode Agent Skills documentation](https://opencode.ai/docs/skills/)
defines `.opencode/skills/<name>/SKILL.md` for project skills and
`~/.config/opencode/skills/<name>/SKILL.md` for global skills. OpenCode walks
up from the working directory to the Git worktree while discovering project
skills. It exposes skill names and descriptions to the agent, then loads a
skill's full instructions on demand through the native `skill` tool.

The playbook consequently keeps repository procedures under
`.opencode/skills/` and will install only its namespaced skills beneath the
resolved global skills directory. OpenCode also supports `.agents/skills` and
`.claude/skills` compatibility locations, but relying on those alone would make
the OpenCode edition less native and less self-explanatory.

## Configuration directory and managed boundary

The playbook installer contract resolves its managed global root as
`${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}`. When
`OPENCODE_CONFIG_DIR` is explicitly set, the installer will use that absolute
directory for the playbook's global `AGENTS.md`, namespaced skills, and recovery
checkpoints. This is a playbook-specific installer override, not a claim that
the current OpenCode runtime relocates native discovery with the same variable.

OpenCode's [configuration documentation](https://opencode.ai/docs/config/#custom-directory)
describes `OPENCODE_CONFIG_DIR` as a custom directory loaded in addition to
other configuration sources. A local probe against OpenCode 1.18.31 found that
`opencode debug paths` still reports `~/.config/opencode` as its runtime config
path when only `OPENCODE_CONFIG_DIR` is set. The same command reports
`$XDG_CONFIG_HOME/opencode` when `XDG_CONFIG_HOME` is set, consistent with the
XDG-aware user configuration path documented for OpenCode assets such as
[themes](https://opencode.ai/docs/themes/#custom-themes).

Isolated runtime verification must therefore set `XDG_CONFIG_HOME` and point
the installer at the matching child directory. For example,
`XDG_CONFIG_HOME=/tmp/profile` pairs with
`OPENCODE_CONFIG_DIR=/tmp/profile/opencode`. Release verification will confirm
the resolved path with `opencode debug paths` before asserting that OpenCode
detects the installed agreement or skills.

The playbook deliberately does not create, merge, or modify `opencode.json`.
OpenCode configuration files can contain user-controlled providers, models,
permissions, plugins, and extra instructions, and OpenCode merges multiple
configuration sources according to its documented precedence. Leaving these
files untouched keeps the installer out of unrelated user policy and avoids a
merge it cannot safely own.

## Mechanics not carried forward

The following source-client mechanics are rejected for OpenCode delivery:

- Claude Code-only `CLAUDE.md` and `.claude/skills` paths remain compatibility
  fallbacks, not the OpenCode Playbook's primary locations.
- Codex-specific configuration roots, installer paths, skill directories,
  model-selection conventions, and client UX are not copied into the OpenCode
  installer.
- A multi-client installer is not used; each playbook owns its client's
  discovery paths, backup boundary, permissions model, and release validation.
- Client-specific tools or harness behavior are not treated as shared
  semantics. Only the rulebook bytes are currently asserted identical.

## References

- [OpenCode rules](https://opencode.ai/docs/rules/)
- [OpenCode Agent Skills](https://opencode.ai/docs/skills/)
- [OpenCode configuration](https://opencode.ai/docs/config/)
- [OpenCode themes and XDG user configuration](https://opencode.ai/docs/themes/#custom-themes)
