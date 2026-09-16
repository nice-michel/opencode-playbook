# OpenCode Playbook Initial Release Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use
> superpowers:subagent-driven-development (recommended) or
> superpowers:executing-plans to implement this plan task-by-task. Steps use
> checkbox (`- [ ]`) syntax for tracking.

**Goal:** Publish `nice-michel/opencode-playbook` v0.1.0 as a safe,
OpenCode-native edition of Michel's exact 42-rule working agreement.

**Architecture:** Keep authority in one byte-identical `AGENTS.md`, expose three
procedural skills through `.opencode/skills`, and install only those managed
artifacts beneath the resolved OpenCode configuration directory. Adapt the
proven Codex Playbook transaction engine to OpenCode paths and verify every
backup, stage, activation, rollback, restore, document, and publication claim.

**Tech Stack:** Markdown, portable POSIX shell, dependency-free HTML/CSS/JS,
OpenCode CLI 1.18.31 or later-compatible behavior, GitHub CLI, GitHub Pages.

---

## File Map

| Path | Responsibility |
|---|---|
| `AGENTS.md` | Exact 42-rule governing agreement copied from `codex-playbook`. |
| `.opencode/skills/opencode-playbook-dependency-review/SKILL.md` | Current-source dependency-vetting procedure. |
| `.opencode/skills/opencode-playbook-quarantine/SKILL.md` | Recoverable alternative to uncertain deletion. |
| `.opencode/skills/opencode-playbook-release/SKILL.md` | Task checkpoint and phase-release procedure. |
| `scripts/install.sh` | Validate, checkpoint, stage, activate, verify, and recover installation. |
| `scripts/restore.sh` | Validate a checkpoint, preserve current state, restore transactionally, and roll back failures. |
| `tests/install_test.sh` | Isolated lifecycle and injected-failure coverage. |
| `scripts/verify.sh` | Repository structure, parity, metadata, syntax, lifecycle, links, rule-map, and placeholder checks. |
| `INSTALL.md` | Operator contract for install, update, verification, and restore. |
| `README.md` | Public product overview and shortest safe installation path. |
| `ARCHITECTURE.md` | Authority, discovery, managed-write boundary, and transaction design. |
| `docs/index.html` | Dependency-free visual playbook and searchable 42-rule map. |
| `docs/assets/opencode-playbook-hero.png` | Original OpenCode hero illustration. |
| `docs/adr/0001-separate-opencode-native-repository.md` | Durable repository-boundary decision. |
| `docs/reports/2026-09-16-source-adaptation.md` | Claude/Codex/OpenCode doctrine and delivery mapping. |
| `docs/reviews/2026-09-16-release-candidate.md` | Independent review findings, fixes, and final verdict. |

## Task 1: Establish Governing Rules and Architectural Records

**Files:**

- Create: `AGENTS.md`
- Create: `docs/adr/0001-separate-opencode-native-repository.md`
- Modify: `docs/adr/README.md`
- Create: `docs/reports/2026-09-16-source-adaptation.md`
- Modify: `ARCHITECTURE.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`

- [x] **Step 1: Add the parity assertions before copying the rulebook**

Run the following one-off failing check from the OpenCode repository:

```sh
test -f AGENTS.md
cmp AGENTS.md ../codex-playbook/AGENTS.md
test "$(grep -Ec '^[0-9]+\. \*\*' AGENTS.md)" -eq 42
```

Expected: failure because `AGENTS.md` does not exist yet.

- [x] **Step 2: Add the exact governing agreement**

Create `AGENTS.md` with the complete bytes from
`../codex-playbook/AGENTS.md`. Do not replace “Codex” inside the agreement: the
owner explicitly approved exact parity. Use `apply_patch` to add the file, then
run:

```sh
cmp AGENTS.md ../codex-playbook/AGENTS.md
test "$(grep -Ec '^[0-9]+\. \*\*' AGENTS.md)" -eq 42
wc -c AGENTS.md ../codex-playbook/AGENTS.md
```

Expected: `cmp` exits zero, the rule count is 42, and both byte counts match.

- [x] **Step 3: Record the separate-repository decision**

Write ADR 0001 with these exact decisions:

```markdown
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
```

Index the ADR in `docs/adr/README.md`.

- [x] **Step 4: Write the source-adaptation report**

Document the exact rulebook parity, OpenCode global and project instruction
locations, `.opencode/skills` discovery, `OPENCODE_CONFIG_DIR`, the deliberate
decision not to write `opencode.json`, and rejected Claude/Codex-only mechanics.
Link only current official OpenCode documentation for client behavior.

- [x] **Step 5: Update architecture and status documents**

Describe the always-loaded rulebook, progressive-disclosure skills, managed
write set, backup root, and trust boundary. Record the completed slice in
`PROGRESS.md` and `CHANGELOG.md` without marking the release complete.

- [x] **Step 6: Verify and commit the slice**

```sh
cmp AGENTS.md ../codex-playbook/AGENTS.md
git diff --check
git status --short
git add AGENTS.md ARCHITECTURE.md CHANGELOG.md PROGRESS.md docs/adr docs/reports
git commit -m "feat: establish OpenCode Playbook rules"
```

Expected: parity checks pass and one focused commit is created.

## Task 2: Add OpenCode-Native Procedural Skills

**Files:**

- Create: `.opencode/skills/opencode-playbook-dependency-review/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-quarantine/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-release/SKILL.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Run a failing metadata check**

```sh
for skill_name in \
  opencode-playbook-dependency-review \
  opencode-playbook-quarantine \
  opencode-playbook-release
do
  skill_file=".opencode/skills/$skill_name/SKILL.md"
  test -f "$skill_file"
  grep -Fxq "name: $skill_name" "$skill_file"
  grep -Eq '^description: .+' "$skill_file"
done
```

Expected: failure because the skills are not present.

- [ ] **Step 2: Add the dependency-review skill**

Use the Codex skill's procedure unchanged except for the identifier and product
name. Its frontmatter must be:

```yaml
---
name: opencode-playbook-dependency-review
description: Vet a new or major-updated direct dependency before adding it, including current version, security, maintenance, adoption, alternatives, license, and a durable report.
---
```

The body must require current primary sources, a zero-dependency comparison,
durable evidence under `docs/reports/`, lockfile updates, narrow tests, full
checks, and a release block for unresolved known vulnerabilities.

- [ ] **Step 3: Add the quarantine skill**

Use this frontmatter:

```yaml
---
name: opencode-playbook-quarantine
description: Set aside a file or local asset safely when deletion or overwrite is uncertain, preserving bytes, provenance, restoration instructions, and owner visibility.
---
```

Preserve the verified `~/.quarantine/` layout, SHA-256 manifest, literal-path
move rule, secret-handling rule, and explicit restore/retain/delete outcomes.

- [ ] **Step 4: Add the release skill**

Use this frontmatter:

```yaml
---
name: opencode-playbook-release
description: Close a completed task or phase with verification, documentation, version allocation, commit, immutable tag, push, dependency audit, and GitHub release evidence.
---
```

Preserve the task checkpoint, phase release, five-part close-out, immutable tag,
shared-repository PR, dependency-audit, and exact-release-commit verification
requirements.

- [ ] **Step 5: Verify and commit the slice**

```sh
for skill_name in opencode-playbook-dependency-review opencode-playbook-quarantine opencode-playbook-release
do
  skill_file=".opencode/skills/$skill_name/SKILL.md"
  grep -Fxq "name: $skill_name" "$skill_file"
  grep -Eq '^description: .+' "$skill_file"
done
git diff --check
git add .opencode PROGRESS.md CHANGELOG.md
git commit -m "feat: add OpenCode Playbook skills"
```

Expected: all three metadata checks pass and the skills commit succeeds.

## Task 3: Write Installer Lifecycle Tests First

**Files:**

- Create: `tests/install_test.sh`

- [ ] **Step 1: Port the proven isolated test harness**

Create `tests/install_test.sh` from the current Codex lifecycle suite using
these exact semantic substitutions:

| Codex suite | OpenCode suite |
|---|---|
| `CODEX_HOME` | `OPENCODE_CONFIG_DIR` |
| `$HOME/.agents/skills` | `$opencode_config_dir/skills` |
| `.agents/skills` | `.opencode/skills` |
| `codex-playbook-*` | `opencode-playbook-*` |
| `codex-playbook-preinstall-*` | `opencode-playbook-preinstall-*` |
| `codex-playbook-prerestore-*` | `opencode-playbook-prerestore-*` |
| `Codex Playbook` | `OpenCode Playbook` |

Default-path cases must resolve
`${OPENCODE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode}`. Cover both
the `$HOME/.config/opencode` fallback and `XDG_CONFIG_HOME` relocation. Custom-
root cases must use an absolute isolated `OPENCODE_CONFIG_DIR` and assert that
the default XDG-derived OpenCode directory remains untouched.

- [ ] **Step 2: Preserve the complete failure matrix**

The suite must retain injected failures for backup copy, staging copy, rollback
allocation, activation, immediate rollback, restore staging, restore swap,
cleanup, and signals. It must also assert:

```text
first install and restore
different AGENTS.md refusal
explicit --replace-agents
unique immutable checkpoints
unrelated config and skill preservation
incomplete checkout refusal
symlink and non-directory refusal
install TERM recovery
restore TERM recovery after a real move
untrusted and incomplete checkpoint refusal
```

Every case runs in a new private temporary home and cleans only its own test
root.

- [ ] **Step 3: Run the test and prove it fails for the intended reason**

```sh
chmod +x tests/install_test.sh
./tests/install_test.sh
```

Expected: failure because `scripts/install.sh` and `scripts/restore.sh` do not
exist, not because of a syntax error in the test harness.

- [ ] **Step 4: Syntax-check the test**

```sh
sh -n tests/install_test.sh
dash -n tests/install_test.sh
```

Expected: both commands exit zero.

## Task 4: Implement Lossless Install and Restore Transactions

**Files:**

- Create: `scripts/install.sh`
- Create: `scripts/restore.sh`
- Modify: `tests/install_test.sh`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Implement the OpenCode installer**

Port the verified Codex installer transaction with these OpenCode definitions:

```sh
xdg_config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
opencode_config_dir=${OPENCODE_CONFIG_DIR:-"$xdg_config_home/opencode"}
skills_root="$opencode_config_dir/skills"
agents_source="$repo_root/AGENTS.md"
agents_target="$opencode_config_dir/AGENTS.md"
skill_names='opencode-playbook-dependency-review opencode-playbook-quarantine opencode-playbook-release'
backup_root="$opencode_config_dir/backups"
```

Validate that `HOME` is set and absolute, and that explicit
`XDG_CONFIG_HOME` and `OPENCODE_CONFIG_DIR` values are absolute. Validate
regular-file and real-directory types for sources and managed targets. Refuse
a different global agreement without `--replace-agents`.

Use `umask 077`, create a unique
`opencode-playbook-preinstall-<UTC>-XXXXXX` checkpoint, record `present` or
`absent` for all four managed targets, verify every copied item, and write
`COMPLETE` only after all verification succeeds. Stage all four new targets and
allocate rollback storage before the first destination move.

After activation, compare every installed item to its repository source. On
failure or `HUP`, `INT`, or `TERM`, invoke the restore transaction against the
verified checkpoint and exit non-zero. Cleanup failures must print warnings and
must not stop later managed items from being installed.

- [ ] **Step 2: Implement checkpoint restoration**

Accept exactly one checkpoint argument. Canonicalize it and require its direct
parent to equal the resolved `$opencode_config_dir/backups`. Accept only:

```text
opencode-playbook-preinstall-*
opencode-playbook-prerestore-*
```

Require a real manifest, a real `COMPLETE` marker, exactly one valid state entry
per managed target, and safe checkpoint payload types. Before any restore write,
create and verify a new `opencode-playbook-prerestore-*` checkpoint of the
current state.

Stage the requested state, allocate previous-state storage, then activate it as
one rollback-protected transaction. Track each target touched so a signal or
failure reinstates exactly the pre-restore state. Verify both present and absent
postconditions before reporting success.

- [ ] **Step 3: Make scripts executable and run narrow syntax checks**

```sh
chmod +x scripts/install.sh scripts/restore.sh
sh -n scripts/install.sh scripts/restore.sh tests/install_test.sh
dash -n scripts/install.sh scripts/restore.sh tests/install_test.sh
```

Expected: all syntax checks exit zero.

- [ ] **Step 4: Run the lifecycle suite and fix root causes**

```sh
./tests/install_test.sh
```

Expected: every lifecycle assertion passes. If a case fails, use the systematic
debugging workflow and add or strengthen a regression assertion before changing
the transaction code.

- [ ] **Step 5: Commit the working transaction slice**

```sh
git diff --check
git add scripts tests PROGRESS.md CHANGELOG.md
git commit -m "feat: add lossless OpenCode installation"
```

Expected: one commit containing tests and their passing implementation.

## Task 5: Write Complete Public and Operator Documentation

**Files:**

- Create: `INSTALL.md`
- Create: `CONTRIBUTING.md`
- Create: `SECURITY.md`
- Create: `BACKLOG.md`
- Create: `HANDOFF.md`
- Create: `PLAN.md`
- Modify: `README.md`
- Modify: `ARCHITECTURE.md`
- Modify: `docs/guides/README.md`
- Create: `docs/handoffs/README.md`
- Create: `docs/ideas/README.md`
- Create: `docs/reviews/README.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Write the installation contract**

Document the exact source-to-destination table:

```text
AGENTS.md -> ${OPENCODE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode}/AGENTS.md
.opencode/skills/opencode-playbook-* -> ${OPENCODE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode}/skills/opencode-playbook-*
```

Explain preflight inspection, default refusal, explicit replacement,
checkpoint ordering, verification, updates, restores, Windows/WSL boundaries,
and that the installer does not touch credentials, providers, sessions,
plugins, themes, or `opencode.json`.

- [ ] **Step 2: Write README and architecture guidance**

The README must open with the motto, explain first-person language, link to the
visual map, show the safe clone/install path, inventory the four managed
artifacts, explain the OpenCode-native architecture, and show version/license.

Architecture must document instruction precedence, skill discovery, the
managed-write boundary, the checkpoint transaction, and why OpenCode owns a
separate repository.

- [ ] **Step 3: Complete contributor and repository operations docs**

Write the contribution flow, private security-reporting path, backlog policy,
current handoff, phase plan, and directory indexes. Keep all claims aligned
with implemented behavior and link every local target correctly.

- [ ] **Step 4: Verify links and commit documentation**

```sh
git diff --check
git add README.md INSTALL.md ARCHITECTURE.md CONTRIBUTING.md SECURITY.md BACKLOG.md HANDOFF.md PLAN.md PROGRESS.md CHANGELOG.md docs
git commit -m "docs: complete OpenCode Playbook guidance"
```

Expected: focused documentation commit with no broken relative links.

## Task 6: Build the Visual Playbook

**Required skills:** `imagegen`, then `frontend-skill`, then `playwright` for QA.

**Files:**

- Create: `docs/assets/opencode-playbook-hero.png`
- Create: `docs/index.html`
- Modify: `README.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Generate the original hero asset**

Use ImageGen with this art direction:

```text
Editorial screen-print and gouache illustration for an OpenCode engineering
playbook. A transparent open workbench reveals clear instruction sheets moving
through an understandable mechanical process into a precise stack of completed
work. Calm human collaborator, no readable text, no logos, no neon, no generic
futuristic dashboard. Matte ivory, deep ink, one distinctive green-teal accent,
subtle brass detail, generous negative space, landscape composition suitable
for a refined documentation hero.
```

Inspect the generated image at original resolution and retain only a polished,
artifact-free result.

- [ ] **Step 2: Build semantic page structure**

Create one self-contained `docs/index.html` with local image assets and these
sections: hero, authority gates, searchable 42-rule map, native architecture,
installation lifecycle, and repository links. Use semantic landmarks, a skip
link, keyboard-operable controls, visible focus, and useful image alternative
text.

- [ ] **Step 3: Implement restrained interaction**

Implement a sticky section index, active-section state, direct rule filtering,
zero-result messaging, short entrance motion, and a complete
`prefers-reduced-motion` override. JavaScript must progressively enhance the
document; all core content remains readable without it.

- [ ] **Step 4: Verify all rule identifiers in the page**

```sh
test "$(grep -Ec '^      \[\"([1-9]|[1-3][0-9]|4[0-2])\",' docs/index.html)" -eq 42
```

Expected: exit zero.

- [ ] **Step 5: Perform desktop and mobile browser QA**

Serve the repository through an available, verified local port, record that
temporary port only if the server must outlive the immediate QA action, and
inspect at least 1200×1200 and 390×844. Exercise navigation, filtering, keyboard
focus, reduced motion, image loading, and a zero-result search. Require zero
console errors and warnings. Stop the local server at the end.

- [ ] **Step 6: Commit the visual slice**

```sh
git diff --check
git add docs/index.html docs/assets/opencode-playbook-hero.png README.md PROGRESS.md CHANGELOG.md
git commit -m "feat: add the OpenCode visual playbook"
```

Expected: the site and original asset are committed together.

## Task 7: Add Repository-Wide Verification

**Files:**

- Create: `scripts/verify.sh`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Write the verifier before final release metadata**

The verifier must assert:

```text
all required root, source, test, and visual files are non-empty
VERSION is a bare semantic version
AGENTS.md is byte-identical to ../codex-playbook/AGENTS.md when that sibling exists
AGENTS.md contains exactly 42 numbered rules
exactly three valid opencode-playbook skills exist
all shell files are executable and pass sh -n
the lifecycle suite passes
public docs contain no Codex install paths or deprecated OpenCode paths
all local Markdown links resolve
the visual map contains all 42 rule identifiers
tracked text has no unresolved placeholders or trailing whitespace
```

External sibling parity must produce a clear skip rather than a false failure
when the sibling checkout is absent; release review must still record an
explicit parity comparison.

- [ ] **Step 2: Run the verifier in the development state**

```sh
chmod +x scripts/verify.sh
./scripts/verify.sh
```

Expected: every implemented structural and lifecycle check passes. Publication
checks remain outside this local verifier until Task 9 sets v0.1.0.

- [ ] **Step 3: Commit the verifier**

```sh
git diff --check
git add scripts/verify.sh PROGRESS.md CHANGELOG.md
git commit -m "test: add repository verification"
```

Expected: the verifier becomes part of the release contract.

## Task 8: Run Independent Release-Candidate Review

**Required skill:** `requesting-code-review`.

**Files:**

- Create: `docs/reviews/2026-09-16-release-candidate.md`
- Modify as findings require: installer, restore, tests, site, or documentation
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Run all local checks before review**

```sh
./tests/install_test.sh
./scripts/verify.sh
sh -n scripts/*.sh tests/*.sh
dash -n scripts/*.sh tests/*.sh
git diff --check
```

Expected: every command exits zero before review begins.

- [ ] **Step 2: Request a correctness-first independent review**

Review the complete diff and specifically challenge transaction ordering,
signal races, incomplete rollback, unsafe path handling, checkpoint trust,
unrelated-file preservation, documentation truthfulness, accessibility, and
OpenCode-native discovery claims. Findings must include severity and precise
file/line evidence.

- [ ] **Step 3: Fix every Critical or Important finding with regression coverage**

For each finding, reproduce it, add or strengthen the failing assertion, fix
the root cause, rerun narrow checks, then rerun the complete suite. Record the
finding and resolution in the review document and changelog.

- [ ] **Step 4: Record the final verdict and commit review fixes**

```sh
./tests/install_test.sh
./scripts/verify.sh
git diff --check
git add .
git commit -m "fix: resolve OpenCode release review findings"
```

If no code or documentation findings require changes, commit only the review
record with `docs: record OpenCode release review`.

## Task 9: Prepare and Publish v0.1.0

**Files:**

- Modify: `VERSION`
- Modify: `README.md`
- Modify: `CHANGELOG.md`
- Modify: `PROGRESS.md`
- Modify: `PLAN.md`
- Modify: `HANDOFF.md`
- Create: `docs/reviews/2026-09-16-release-evidence.md`

- [ ] **Step 1: Allocate the release version everywhere**

Set `VERSION` to exactly:

```text
0.1.0
```

Update every current version carrier, mark planned work complete, and write
browsable release notes covering behavior, verification, dependencies,
migration, and known limits.

- [ ] **Step 2: Run the exact release verification**

```sh
./tests/install_test.sh
./scripts/verify.sh
sh -n scripts/*.sh tests/*.sh
dash -n scripts/*.sh tests/*.sh
git diff --check
git status --short
```

Expected: all checks pass. Record exact output counts and the no-dependency
audit result in the release-evidence report.

- [ ] **Step 3: Verify fresh OpenCode discovery in an isolated config root**

Install into a private temporary `OPENCODE_CONFIG_DIR`, verify all four managed
destinations byte-for-byte, then run a new OpenCode session from the repository:

```sh
OPENCODE_CONFIG_DIR="$isolated_config" ./scripts/install.sh
OPENCODE_CONFIG_DIR="$isolated_config" opencode debug skill --pure
OPENCODE_CONFIG_DIR="$isolated_config" opencode run --pure --format json \
  "State the active motto and list every OpenCode Playbook skill available to you. Do not modify files."
```

Expected: the new session identifies the motto and all three skill names. Do
not print provider credentials or secret values. Remove only the task-owned
temporary root after verification.

- [ ] **Step 4: Create the public GitHub repository and push main**

```sh
gh repo create nice-michel/opencode-playbook --public --source=. --remote=origin
git add .
git commit -m "feat: publish OpenCode Playbook v0.1.0"
git push -u origin main
```

Expected: the public repository exists, `origin` is exact, and `main` resolves
to the release candidate commit.

- [ ] **Step 5: Configure repository presentation and security**

Set the description, homepage, and topics; enable Pages from `main/docs`; enable
private vulnerability reporting. Verify each setting through GitHub rather than
assuming the command succeeded.

- [ ] **Step 6: Tag and release the immutable checkpoint**

```sh
release_version=$(cat VERSION)
git tag -a "v$release_version" -m "OpenCode Playbook v$release_version"
git push origin "v$release_version"
gh release create "v$release_version" --title "OpenCode Playbook v$release_version" --notes-file docs/reviews/2026-09-16-release-evidence.md
```

Expected: tag, release, and remote `main` resolve to the same commit.

- [ ] **Step 7: Verify GitHub Pages and final repository state**

Require successful Pages deployment and HTTP 200 responses for the site and
hero asset. Confirm repository visibility, default branch, homepage, topics,
vulnerability reporting, release metadata, clean Git state, and no remaining
local server or long-running task process.

- [ ] **Step 8: Deliver the required close-out report**

Report: what was built; exact verification evidence; assumptions; concerns and
observations; and confirmation of docs, `VERSION`, commit, tag, push, Pages, and
release. Include the independent reviewer model ledger if a reviewer was used.
