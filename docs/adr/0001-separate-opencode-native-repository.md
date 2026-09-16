# 0001 — Separate OpenCode-native repository

## Context

Claude Code, Codex, and OpenCode can share doctrine but do not share global
configuration roots, skill precedence, permission models, or client UX.

## Decision

Publish a separate OpenCode repository. Preserve the approved rulebook exactly,
use `.opencode/skills` in the repository, install beneath the resolved OpenCode
configuration directory, and maintain an explicit source-adaptation report.

## Alternatives rejected and why

- One multi-client installer: it couples unrelated configuration and failure domains.
- Reusing only `.agents/skills`: compatible, but not OpenCode-native or self-explanatory.
- Generating all playbooks from a shared schema now: the schema and release train would cost more than the current controlled parity checks.

## Consequences

Each playbook can evolve at its client's pace. Shared rules require explicit
parity verification, while installation and documentation remain unambiguous.

## Status

Accepted — 2026-09-16.
