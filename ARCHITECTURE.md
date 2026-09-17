# Architecture

OpenCode Playbook is designed as an installable documentation product with one
always-loaded authority layer, sixteen progressively disclosed subject layers,
and a narrow reversible write boundary.

## Selected architecture

The corrective release preserves Michel's complete Claude Code doctrine: five
partnership principles, the coda, 49 stable rule identifiers across thirteen
sections, the closed approval model, and the same production, review, workflow,
safety, and writing standards.

The planned global `AGENTS.md` contains only what must govern before another
file can load: identity and self-update, mantra and coda, goal and precedence,
request classification, the complete approval table, rules 0.1–0.4, and the
mandatory skill router. Sixteen namespaced
`.opencode/skills/opencode-playbook-*/SKILL.md` modules will carry the detailed
subject procedures. Skills may explain how to work; they cannot add authority
or approval gates.

The router has a measured 12 KiB ceiling: `wc -c < AGENTS.md` must not exceed
12,288 bytes. This is a loading budget, not permission to omit or weaken any
required authority, mantra, approval, routing, or rules 0.1–0.4 content.

This decision and its alternatives are recorded in
[`docs/adr/0002-native-progressive-disclosure.md`](docs/adr/0002-native-progressive-disclosure.md).

## OpenCode loading model

The resolved global configuration root is:

```sh
${OPENCODE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode}
```

For OpenCode 1.18.31, a non-empty `OPENCODE_CONFIG_DIR` replaces the normal XDG
root for global `AGENTS.md`. Global and project instructions are combined,
global first. Native `AGENTS.md` versus compatible `CLAUDE.md` is a fallback
choice within a discovery scope, not a replacement for the other instruction
scope.

Native skills use `.opencode/skills/<name>/SKILL.md` in a project and
`<resolved-config-root>/skills/<name>/SKILL.md` globally. Skill discovery can
also be additive across the normal XDG root, an explicit OpenCode root, and
compatibility paths. That read behavior does not expand the playbook's managed
write boundary.

Version 0.1.0 will support stable OpenCode 1.18.31 only. Other versions require
a new compatibility audit; OpenCode v2 is untested and unsupported.

## Planned managed boundary

The installer will manage one global `AGENTS.md` and exactly sixteen
`skills/opencode-playbook-*/` directories beneath the resolved root. It will
never mutate OpenCode JSON, authentication, providers, models, permissions,
plugins, agents, commands, sessions, compatible external skills, or unrelated
native skills.

Verified backups will live under `<resolved-root>/backups/`. Private staging,
previous-state storage, and the concurrency lock will live under
`<resolved-root>/.opencode-playbook-transactions/`, outside recursively
discovered `skills/`.

Format-2 checkpoints will record the exact managed inventory and every target's
present or absent state. Installation and restoration will validate paths and
types, reject symlinks and ambiguous metadata, back up and compare before the
first move, mark targets touched before moving them, and recover through a
signal-safe single-entry rollback path.

Root selection validates only the active environment path. The active raw root
must be absolute with no `.` or `..` components; the longest existing ancestor
is resolved with `cd -P`, and validated missing components are appended. This
accepts OS-managed aliases above the root while refusing a symlink at the root
or any managed/control descendant. The resulting physical root is the sole
lock, backup, checkpoint, and restore identity, so lexical aliases cannot open
parallel transaction namespaces.

Runtime validation isolates HOME and every XDG config/data/cache/state root.
Discovery uses a repository-owned tested POSIX `awk` extractor for OpenCode
1.18.31 pretty skill JSON. Live probes require an explicit provider/model and
environment-only credential, use default text markers, and never read or copy
authentication files.

## Repository separation

Claude Code, Codex, and OpenCode share doctrine but have different discovery,
configuration, permission, and runtime validation mechanics. The separate
OpenCode repository decision in
[`docs/adr/0001-separate-opencode-native-repository.md`](docs/adr/0001-separate-opencode-native-repository.md)
remains accepted. Machine-readable parity contracts will prevent the separate
delivery from becoming silent doctrinal drift.

The canonical Claude doctrine is pinned to commit
`5db68e347a65e511cc378b0598a6aac6655845bd`, whose `VERSION` is `0.1.12`.
The modular Codex reference is pinned to commit
`b79080ad6f3f9605b60d4722265a5d271ea2e540`, whose `VERSION` is `0.1.3`.
Both are consumed directly through pinned `git show` and `git ls-tree` object
reads with exact commit, tree, blob, version, and inventory verification;
mutable checkout files and temporary source copies are not inputs.

## Current state

This file describes the approved architecture, not completed implementation.
The worktree still contains the historical 42-rule prototype `AGENTS.md`; no
sixteen-skill corpus, installer, restore command, verifier, runtime suite, or
visual site is claimed at version 0.0.1. The executable work is defined in the
[`corrective release plan`](docs/superpowers/plans/2026-09-17-opencode-playbook-corrective-release.md).
