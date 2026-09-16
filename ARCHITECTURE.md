# Architecture

OpenCode Playbook is an installable documentation product with one governing
agreement, progressively disclosed procedures, and a deliberately narrow
write boundary.

## Authority and progressive disclosure

The repository-root `AGENTS.md` is the always-loaded governing authority. Its
42 numbered rules are byte-for-byte identical to the Codex Playbook rulebook.
It defines policy, approval gates, quality standards, verification duties, and
safety boundaries.

Detailed procedures live under `.opencode/skills/`. OpenCode discovers skill
metadata and loads the full `SKILL.md` only when the procedure is relevant.
Skills may explain how to perform work, but they cannot add authority or
approval gates beyond `AGENTS.md`.

## Separate repository

Claude Code, Codex, and OpenCode share doctrine but differ in configuration
roots, discovery rules, permission models, and client UX. A separate
OpenCode-native repository keeps installation auditable and client guidance
unambiguous while explicit parity checks prevent unnoticed rulebook drift. The
decision is recorded in
[`docs/adr/0001-separate-opencode-native-repository.md`](docs/adr/0001-separate-opencode-native-repository.md).

## Installed layout and managed write set

The installer contract resolves its managed configuration directory as
`${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}`. `OPENCODE_CONFIG_DIR` is an
installer override; it is not treated as a runtime-discovery guarantee. The
current OpenCode runtime resolves its config path as
`${XDG_CONFIG_HOME:-$HOME/.config}/opencode`, so isolated verification will set
`XDG_CONFIG_HOME` and `OPENCODE_CONFIG_DIR` to matching parent and child paths
and confirm the result with `opencode debug paths`.

The supported installer will manage exactly four destinations beneath its
resolved directory:

```text
AGENTS.md
skills/opencode-playbook-dependency-review/
skills/opencode-playbook-quarantine/
skills/opencode-playbook-release/
```

Its trusted backup root is `<resolved-config-directory>/backups/`. The
installer will not write `opencode.json`, credentials, providers, models,
permissions, plugins, themes, sessions, unrelated skills, or any other user
configuration.

## Trust and recovery boundary

The installer-resolved configuration directory is the installation trust
boundary. The installer and restore tool will accept only validated regular
files, real directories, the four known managed destinations, and complete
checkpoints directly beneath the trusted backup root. Unsafe symlinks,
nonstandard target types, incomplete checkpoints, and restore paths outside
that root will be refused.

Before any destination write, installation and restoration will create and
verify a private checkpoint of the current managed state. Activation will be a
rollback-protected transaction, so failures or handled interruptions recover
from durable state instead of leaving a partial installation.

## Current implementation state

The governing rulebook and architectural records are present. Native skills,
the installer, restore tooling, and lifecycle verification belong to later
implementation slices and are not yet claimed complete.

The complete approved design is in
[`docs/superpowers/specs/2026-09-16-opencode-playbook-initial-release-design.md`](docs/superpowers/specs/2026-09-16-opencode-playbook-initial-release-design.md).
