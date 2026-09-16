# OpenCode Playbook Initial Release Design

## Goal

Create a polished public OpenCode edition of Michel's agentic working
agreement. The repository must preserve the Codex Playbook's exact 42-rule
`AGENTS.md`, express supporting procedures through OpenCode-native mechanisms,
and provide a safe installation lifecycle suitable for real user machines.

## Product Boundaries

The repository is both an installable configuration bundle and a public visual
guide. Version `0.1.0` will include:

- The exact 42-rule `AGENTS.md` currently published by `codex-playbook`.
- Three OpenCode-native skills for dependency review, recoverable quarantine,
  and release completion.
- A transactional installer and restore tool for the managed global files.
- Complete operating, contribution, architecture, security, provenance, and
  release documentation.
- A dependency-free GitHub Pages experience that visualizes the whole system.

The initial release will not install models, providers, credentials, themes,
plugins, or arbitrary OpenCode configuration. It will not merge or rewrite the
user's `opencode.json`. Optional configuration examples may be documented, but
they are never silently applied.

## Repository Strategy

OpenCode Playbook remains a separate repository alongside
`claude-code-playbook` and `codex-playbook`. A universal installer was rejected
because each client has different discovery, configuration, permissions, and
release semantics. Separate repositories keep installation auditable and make
client-specific guidance readable.

The repositories share doctrine rather than a runtime dependency. A source
adaptation report will identify preserved language, client-specific mechanics,
and every intentional difference. Automated verification will compare the
OpenCode and Codex `AGENTS.md` files byte-for-byte for the initial release.

## Instruction and Skill Architecture

`AGENTS.md` is the single source of governing authority. It contains the motto,
precedence, approval gates, production standards, verification requirements,
documentation discipline, Git workflow, autonomy policy, and safety
guardrails. Skills carry procedure only; they cannot create new authority or
approval gates.

Repository skills live under:

```text
.opencode/skills/
  opencode-playbook-dependency-review/SKILL.md
  opencode-playbook-quarantine/SKILL.md
  opencode-playbook-release/SKILL.md
```

The installer places user-scoped copies under:

```text
~/.config/opencode/skills/
```

The global agreement installs to:

```text
~/.config/opencode/AGENTS.md
```

An explicit `OPENCODE_CONFIG_DIR` will relocate both managed destinations and
the checkpoint root. The installer will treat the resolved configuration
directory as one trust boundary and refuse unsafe, symlinked, or nonstandard
managed paths.

## Installation Lifecycle

Before the first destination write, the installer will:

1. Resolve and validate the source checkout and configuration root.
2. Validate every source, destination parent, and existing managed target.
3. Refuse to replace a different global `AGENTS.md` unless the operator
   explicitly passes `--replace-agents`.
4. Create a unique private checkpoint beneath the OpenCode configuration root.
5. Copy every existing managed target into that checkpoint.
6. Read every backup copy back and verify it against its source.
7. Record the pre-install state of every managed target.
8. Write `COMPLETE` only after the entire checkpoint is verified.
9. Stage and verify the complete replacement payload.
10. Allocate rollback storage before starting the destination transaction.

Only then may it replace managed targets. Any activation, verification,
interruption, or immediate rollback failure triggers recovery from the verified
checkpoint and produces a non-zero exit. Cleanup failures remain visible
warnings and cannot interrupt installation of remaining managed targets.

Restore accepts only a complete checkpoint under the trusted backup root. It
first creates and verifies a new pre-restore checkpoint of the current state,
then stages and applies the requested state with the same rollback protections.
This ensures that restoring an older state never destroys later edits.

The installer and restore tool manage only `AGENTS.md` and the three
`opencode-playbook-*` skill directories. Unrelated skills and configuration are
outside their write set.

## Visual Experience

The site belongs to the same editorial family as the Claude and Codex
playbooks: matte ivory, deep ink, disciplined typography, restrained motion,
and one deliberate accent color. It must remain recognizably OpenCode rather
than a recolored Codex page.

The hero visual uses an open workbench or transparent system motif: visible
instructions flow through an understandable process into completed work. One
original raster illustration will be generated for this edition.

The page contains:

1. A concise hero and installation action.
2. The motto and the two normal approval gates.
3. A searchable, navigable map of all 42 rules.
4. A diagram of global instructions, project instructions, skills, agents,
   commands, and configuration boundaries.
5. A backup-first installation and restore explanation.
6. Direct links to the repository and full operating documentation.

The site is one static HTML document with local assets, no framework, build
step, analytics, cookies, remote fonts, or runtime dependency. It supports
keyboard navigation, semantic landmarks, visible focus, adequate contrast,
responsive desktop and mobile layouts, and `prefers-reduced-motion`.

## Documentation and Decisions

The release includes the required root documents and organized `docs/`
subdirectories. It records:

- An ADR for maintaining a separate OpenCode-native repository.
- A source-adaptation report comparing Claude, Codex, and OpenCode delivery.
- Installation, update, restore, and platform guidance.
- Security and contribution policies.
- The approved implementation plan and release review evidence.
- Current progress, changelog, handoff, and version state.

No claim of behavioral parity will be made without a specific mapping and
verification evidence.

## Verification Strategy

Structural verification will check required files, the bare semantic version,
exact `AGENTS.md` parity, OpenCode skill metadata, expected rule identifiers,
internal links, placeholder absence, and shell syntax.

Lifecycle tests will use isolated temporary homes and configuration roots. They
will cover:

- First installation and verified restore.
- Reinstallation and unique immutable checkpoints.
- `OPENCODE_CONFIG_DIR` relocation.
- Refusal of a different global agreement and explicit replacement.
- Preservation of unrelated configuration and skills.
- Incomplete or malformed source checkouts.
- Unsafe symlinks and nonstandard managed targets.
- Backup-copy and backup-verification failure before writes.
- Staging, allocation, activation, and post-write verification failures.
- Signal interruption before and during the destination transaction.
- Immediate rollback failure and recovery from the durable checkpoint.
- Restore staging, swap, interruption, and rollback failures.
- Refusal of incomplete or untrusted restore paths.

Release verification will additionally include a fresh OpenCode session that
detects the global agreement and all three skills, desktop and mobile browser
inspection, console review, GitHub Pages health, clean Git state, tag parity,
and published release metadata.

Because the repository intentionally has no third-party runtime or build
dependencies, the release dependency audit will record that package-manager
auditing is not applicable rather than manufacturing an irrelevant toolchain.

## Publication

The repository will be public at `nice-michel/opencode-playbook`, use `main` as
its default branch, publish GitHub Pages from `main/docs`, enable private
vulnerability reporting, and release `v0.1.0` only after all verification and
an independent release-candidate review pass.

The finished release must leave no long-running local process and both source
playbook repositories must remain clean.

