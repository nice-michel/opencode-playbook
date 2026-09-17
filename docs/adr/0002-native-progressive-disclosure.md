# 0002 — Native progressive disclosure with full doctrine parity

## Context

The 2026-09-16 prototype planned one complete 42-rule global `AGENTS.md` and
three procedural skills. Michel's canonical Claude Code doctrine instead has
49 stable rule identifiers, five partnership principles, a coda, thirteen
subject sections, and detailed procedures that should not consume every
session's context.

OpenCode 1.18.31 always combines global and project instructions but discovers
native skills by metadata and loads their bodies on demand through the `skill`
tool. Its native project path is `.opencode/skills/<name>/SKILL.md`; the native
global path is `<resolved-config-root>/skills/<name>/SKILL.md`.

## Decision

Keep only the authority required before any action in global `AGENTS.md`: title,
version, source and self-update contract; the five principles and coda; goal
and precedence; request classification; the complete closed approval table;
rules 0.1–0.4; and a mandatory routing table.

Place the remaining canonical rule bodies and self-update procedure in sixteen
namespaced OpenCode-native skills. Install all three platform skills and route
only the one matching the execution environment. Maintain a sorted installed
skill inventory and a 49-rule ownership manifest; rule 11.1 is the sole
multi-owner exception because it has Linux, macOS, and Windows implementations.

Use format-2 checkpoints from the first public release so each backup records
the exact managed inventory. No legacy OpenCode checkpoint format is supported
because no earlier public release exists.

## Alternatives rejected and why

- **Keep the complete monolith:** reliable loading does not justify loading
  every subject procedure in every session, and the 42-rule model omits the
  canonical source structure.
- **Use plain split Markdown files:** OpenCode cannot discover and select them
  through the native skill inventory, so activation and runtime proof become
  ad hoc.
- **Use compatibility `.agents/skills` or `.claude/skills` as the primary
  product path:** OpenCode can scan them, but using them as the authored source
  obscures the native delivery contract and makes installation less auditable.
- **Install only the current platform skill:** the small metadata saving does
  not justify platform-dependent inventories, backups, and restores.
- **Keep separate dependency and release helper skills:** their complete rules
  belong in the code and workflow subjects; duplicate procedural copies would
  drift.

## Consequences

The always-loaded file becomes smaller and more stable while the complete
doctrine remains available by subject. Rule changes must keep the owner skill,
rule manifest, parity report, visual map, and tests synchronized. Installation
and recovery must transact across one authority file and sixteen skill
directories, requiring strict manifests, concurrency control, and failure-path
coverage.

ADR 0001's separate OpenCode-native repository decision remains accepted. Its
prototype assumption that the governing agreement would be preserved as one
complete file is superseded by this decision.

## Status

Accepted — 2026-09-17. Supersedes the rule-delivery architecture implied by
ADR 0001; the separate-repository decision remains in force.
