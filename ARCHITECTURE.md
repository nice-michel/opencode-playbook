# Architecture

OpenCode Playbook is an installable documentation product with one governing
agreement, progressively disclosed procedures, and a deliberately narrow
write boundary.

## Authority and progressive disclosure

The repository-root `AGENTS.md` is the always-loaded governing authority. Its
42 numbered rules are byte-for-byte identical to the Codex Playbook rulebook.
It defines policy, approval gates, quality standards, verification duties, and
safety boundaries.

The planned detailed procedures will live under `.opencode/skills/`. Once
implemented, OpenCode will discover their metadata and load each full
`SKILL.md` only when the procedure is relevant. Skills may explain how to
perform work, but they cannot add authority or approval gates beyond
`AGENTS.md`.

## Separate repository

Claude Code, Codex, and OpenCode share doctrine but differ in configuration
roots, discovery rules, permission models, and client UX. A separate
OpenCode-native repository keeps installation auditable and client guidance
unambiguous while explicit parity checks prevent unnoticed rulebook drift. The
decision is recorded in
[`docs/adr/0001-separate-opencode-native-repository.md`](docs/adr/0001-separate-opencode-native-repository.md).

## Installed layout and managed write set

The installer and restore tool resolve one managed configuration directory as:

```sh
${OPENCODE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode}
```

An explicit `OPENCODE_CONFIG_DIR` is also an OpenCode custom configuration
source. The same explicit value must therefore be present during installation
and runtime verification. Without that override, the installer follows
OpenCode's XDG-aware default.

OpenCode 1.18.31 treats the artifacts differently:

- The global instruction service resolves `AGENTS.md` beneath the effective
  custom configuration directory, replacing the default root when
  `OPENCODE_CONFIG_DIR` is set.
- Skill discovery keeps the default XDG configuration directory and adds an
  explicit `OPENCODE_CONFIG_DIR` to its scanned configuration sources.

That additive read behavior does not widen the playbook's managed write or
backup boundary; both remain confined to the one resolved directory.

`opencode debug paths` reports static XDG paths, not the effective custom
configuration service, so it cannot prove whether either artifact is
discoverable. Verification will inspect `opencode debug skill` for skills and
use a fresh `opencode run` session for the global agreement. The source and
runtime evidence are recorded in
[`docs/reports/2026-09-16-source-adaptation.md`](docs/reports/2026-09-16-source-adaptation.md).

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
