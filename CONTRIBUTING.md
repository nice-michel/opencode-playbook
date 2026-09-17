# Contributing

OpenCode Playbook is at the approved 0.0.1 planning checkpoint. Implementation
has not started, so the shell test commands described in the corrective plan do
not exist yet and must not be reported as current contributor checks.

## Current planning-stage checks

Before the planning checkpoint is committed, run:

```sh
sh -n scripts/verify_planning.sh
dash -n scripts/verify_planning.sh
./scripts/verify_planning.sh --working-tree
```

The verifier inventories tracked and untracked planning artifacts explicitly,
runs both diff whitespace checks, validates current links and source pins, and
proves the historical handoff is byte-identical. After committing, rerun
`./scripts/verify_planning.sh --committed <planning-base-commit>`. Fresh
specification and quality reviews approve that exact committed tip before its
checkpoint tag is created.

If the canonical source object databases are not at Michel's default local
paths, acquire the pinned objects with the commands in
[`docs/reports/2026-09-17-canonical-source-pin.md`](docs/reports/2026-09-17-canonical-source-pin.md)
and export `CLAUDE_PLAYBOOK_SOURCE_REPO` and
`CODEX_PLAYBOOK_SOURCE_REPO` to those no-checkout clones. The verifier validates
the exact commits, versions, trees, and inventories; no script edit is needed.

## Planned implementation workflow

Implementation follows the active
[`corrective release plan`](docs/superpowers/plans/2026-09-17-opencode-playbook-corrective-release.md).
Each task uses test-first development, one logical candidate commit, fresh
specification and quality reviews, focused review-fix commits when needed, and
final verification on the approved tip before its annotated checkpoint is
created and pushed.

Do not rewrite published history, move a checkpoint tag, weaken the 49-rule
parity contract, expand the managed write boundary, or claim support for an
OpenCode version without a new compatibility audit.

## Documentation and decisions

Update current README, architecture, plan, progress, changelog, backlog, and
handoff records when a task changes what they describe. Add an architectural
decision record when a choice has genuine alternatives or is expensive to
reverse. Preserve historical records and supersede them rather than rewriting
their original conclusion.
