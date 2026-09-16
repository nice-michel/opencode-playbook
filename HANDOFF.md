# Handoff

**Paused:** 2026-09-16, during the Task 1 quality-review loop.

## Repository State

- Repository: `/Users/Michel.Abboud/projects/opencode-playbook`
- Branch: `main`
- HEAD before this handoff commit: `c340ee551b3c947469d6e2287897187cd8a8b677`
- Version: `0.0.0`
- Remote: none configured
- Tags: none
- GitHub repository, Pages site, and release: not created

## Verified Complete

- Product design approved and recorded in
  `docs/superpowers/specs/2026-09-16-opencode-playbook-initial-release-design.md`.
- Nine-task implementation plan approved and recorded in
  `docs/superpowers/plans/2026-09-16-opencode-playbook-initial-release.md`.
- Task 1 implementation committed as `214f736`.
- Task 1 specification review approved with no findings.
- `AGENTS.md` is byte-identical to `../codex-playbook/AGENTS.md`, contains 42
  numbered rules, and is 13,126 bytes.
- ADR 0001, source-adaptation report, architecture, changelog, and progress
  records exist.
- The first quality review found incorrect configuration-discovery wording.
  Commit `c340ee5` corrected it to use the XDG-aware default
  `${OPENCODE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode}` and to
  treat `OPENCODE_CONFIG_DIR` as the explicit effective custom root.
- An isolated `opencode debug skill --pure` probe confirmed that a skill in the
  explicit custom root is discovered only when `OPENCODE_CONFIG_DIR` is set.

## In Progress

- Task 1 is not fully closed because the required quality re-review of
  `c340ee5` was interrupted when this handoff was requested.
- Task 1 checkboxes in the implementation plan describe completed implementation
  steps; the external quality gate still remains pending.
- Tasks 2 through 9 have not been implemented.

## Next Steps

1. Run a fresh quality review of commits `214f736..c340ee5`, verifying that all
   previous configuration-discovery findings are resolved and no new
   contradiction was introduced.
2. If approved, close Task 1 and dispatch the Task 2 skills implementer,
   followed by specification and quality review.
3. Continue Tasks 3 and 4 test-first. Incorporate the completed read-only
   transaction analysis rather than performing a mechanical Codex rename.
4. Continue documentation, visual implementation, verification, release review,
   and publication in Tasks 5 through 9.

## Transaction Gotchas Already Identified

- Resolve the default root with `XDG_CONFIG_HOME`; do not hardcode
  `$HOME/.config/opencode` when XDG configuration is present.
- Keep installer staging and previous-state directories outside `skills/`.
  OpenCode recursively discovers skills, so transaction debris beneath that
  directory could become active configuration.
- Reject symlinked configuration, skills, backup, checkpoint, manifest, marker,
  and nested skill-resource paths.
- Require an exact manifest schema and exact `COMPLETE` marker content; reject
  duplicate, unknown, malformed, or payload/state-inconsistent entries.
- Mask signals during recovery, guard against re-entrant rollback, and set
  touched markers before the first possible move.
- Add a concurrency guard so two installs or restores cannot interleave.
- Replace ordinal fake-command failures in the Codex test model with path- or
  argument-matched injection and synchronization files.

## Visual and Release Gotchas Already Identified

- Render all 42 rules as static semantic HTML; JavaScript may filter them but
  must not be their only renderer.
- Keep the OpenCode hero and page visually distinct from the Codex cobalt robot
  composition. Use the approved open-mechanism/workbench concept and green-teal
  accent.
- Verify an isolated installation with `opencode debug skill` and a fresh
  `opencode run` from an empty workspace so repository-local instructions cannot
  mask a failed global install.
- Enable Pages and private vulnerability reporting through the GitHub REST API,
  then verify the returned state.
- Create the GitHub release with `--verify-tag` and prove local `HEAD`, remote
  `main`, and the peeled annotated tag resolve to the same commit.

## Process State

- No subagent remains active; the pending quality reviewer was interrupted.
- No process was started by this project and left running.
- PID 79786 is a pre-existing Python documentation server owned by
  `mtls-otel-admin-successor` on port 8999. It is unrelated and must not be
  stopped or modified by this project.

