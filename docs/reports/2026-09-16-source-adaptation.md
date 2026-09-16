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

The playbook resolves its one managed configuration root as:

```sh
${OPENCODE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode}
```

This order gives an explicit OpenCode custom directory first priority, then
uses the XDG configuration home when present, and otherwise falls back to
`$HOME/.config/opencode`. The installer, restore tool, backup root, and runtime
verification must all use the same resolved root.

OpenCode's [configuration documentation](https://opencode.ai/docs/config/#custom-directory)
documents `OPENCODE_CONFIG_DIR` as a custom configuration directory. The
versioned OpenCode 1.18.31 source makes its effective behavior precise:

- [`Global.Service.config`](https://github.com/anomalyco/opencode/blob/v1.18.31/packages/core/src/global.ts#L59-L65)
  resolves to `OPENCODE_CONFIG_DIR` when the variable is set and otherwise uses
  the static XDG-derived OpenCode directory.
- The [global instruction loader](https://github.com/anomalyco/opencode/blob/v1.18.31/packages/opencode/src/session/instruction.ts#L55-L63)
  reads `AGENTS.md` beneath that effective service path. For this artifact, an
  explicit custom root replaces the default global instruction root.
- [`ConfigPaths.directories`](https://github.com/anomalyco/opencode/blob/v1.18.31/packages/opencode/src/config/paths.ts#L23-L40)
  retains the static XDG directory and adds `OPENCODE_CONFIG_DIR` to the
  configuration directories.
- The [skill service](https://github.com/anomalyco/opencode/blob/v1.18.31/packages/opencode/src/skill/index.ts#L205-L208)
  scans every one of those directories for OpenCode skill paths. For skills,
  the explicit root is an additional effective discovery source.

This additive skill read path does not expand the playbook's write authority.
The installer, backups, restore validation, and rollback remain confined to
the one resolved managed root.

`opencode debug paths` prints the static XDG-backed `Global.Path` values. It
does not expose `Global.Service.config` or the full skill discovery set, so its
output alone cannot prove effective `AGENTS.md` or skill discovery.

A local OpenCode 1.18.31 probe created a uniquely named valid skill beneath a
private temporary `OPENCODE_CONFIG_DIR`. `opencode debug skill --pure` did not
list the skill without the override and did list its exact temporary path with
the override. Release verification will use the same explicit root for the
installer, `opencode debug skill`, and a fresh `opencode run` session before
asserting that all managed artifacts are active.

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
- [OpenCode 1.18.31 global service source](https://github.com/anomalyco/opencode/blob/v1.18.31/packages/core/src/global.ts#L59-L65)
- [OpenCode 1.18.31 instruction source](https://github.com/anomalyco/opencode/blob/v1.18.31/packages/opencode/src/session/instruction.ts#L55-L63)
- [OpenCode 1.18.31 configuration-path source](https://github.com/anomalyco/opencode/blob/v1.18.31/packages/opencode/src/config/paths.ts#L23-L40)
- [OpenCode 1.18.31 skill source](https://github.com/anomalyco/opencode/blob/v1.18.31/packages/opencode/src/skill/index.ts#L205-L208)
