# OpenCode Playbook Corrective Release Design

**Status:** Approved for implementation on 2026-09-17

**Target release:** 0.1.0

**Supported client:** OpenCode 1.18.31 stable

## Context

The first OpenCode Playbook design copied the earlier Codex Playbook's
42-rule monolith and planned three procedural skills. That model was useful as
an investigation, but it was not the requested product. Michel's mature source
doctrine is the Claude Code Playbook's 49 stable rule identifiers, five
partnership principles, coda, thirteen sections, closed approval model, review
ladder, workflow, safety procedures, and writing rules. The corrected OpenCode
edition must preserve that doctrine and adapt only the client mechanics.

The canonical Claude doctrine is pinned reproducibly to commit
`5db68e347a65e511cc378b0598a6aac6655845bd`, whose `VERSION` file is exactly
`0.1.12`. The mature Codex Playbook is pinned to commit
`b79080ad6f3f9605b60d4722265a5d271ea2e540`, whose `VERSION` is exactly
`0.1.3`; it proves the progressive-disclosure shape: keep authority and routing
always loaded, put full subject procedures in skills, and verify rule ownership
with manifests. OpenCode has its own native skill discovery, configuration
roots, instruction behavior, command-line diagnostics, and runtime. This
repository therefore uses the proven modular model without copying Codex paths
or assuming identical client behavior.

Both repository paths are used only as Git object databases. Adaptation never
reads their checkout files or depends on their branches, `HEAD`, index, or
working-tree cleanliness. Task 1 verifies each exact commit, expected version,
root tree, subject tree, key blobs, and inventory count. It enumerates required
paths only with `git ls-tree -r --name-only <sha> -- <path>` and reads each file
only with `git show <sha>:<path>`. Adapted OpenCode files are written separately
with `apply_patch`; there is no source extraction, temporary copy, or source
repository mutation. `scripts/verify_planning.sh` accepts
`CLAUDE_PLAYBOOK_SOURCE_REPO` and `CODEX_PLAYBOOK_SOURCE_REPO` overrides for
clean no-checkout object-database clones and otherwise uses Michel's recorded
local defaults; the same object and inventory checks apply to either path.

Existing 2026-09-16 OpenCode documents remain historical evidence. They are
not deleted or silently rewritten into current truth. This specification, its
paired corrective implementation plan, and ADR 0002 supersede their 42-rule,
three-skill architecture.

## Goal

Publish `nice-michel/opencode-playbook` as a production-grade, reversible, and
visually distinct OpenCode-native distribution of Michel's complete doctrine.
Version 0.1.0 must install one lean global authority file and sixteen
namespaced skills without changing any unrelated OpenCode state, prove the
installation through a truly isolated OpenCode 1.18.31 runtime, and ship a
public GitHub Pages guide and immutable GitHub release.

## Support Boundary

Version 0.1.0 supports and is release-tested against stable OpenCode 1.18.31
only. Any other OpenCode version requires a release-time compatibility audit
before support can be claimed. OpenCode v2 is explicitly untested and
unsupported by this release.

The implementation uses POSIX shell, standard Unix utilities already required
by the scripts, Markdown, and dependency-free HTML, CSS, and JavaScript. It
adds no package-manager, runtime, build, or browser dependency to the
repository. Native Windows installation is documented as unsupported for the
POSIX scripts; Windows Subsystem for Linux executes the Linux path. The
doctrine still includes native Windows platform commands for an OpenCode agent
running in that environment.

## Approaches Considered

### One complete global `AGENTS.md`

This is simple to copy and impossible to partially discover, but it loads the
entire rule corpus in every session. It also repeats the mistake in the first
OpenCode design: treating reliable loading as more important than preserving
the source's subject boundaries and progressive disclosure.

### One lean `AGENTS.md` plus plain split Markdown files

Plain files make the repository readable, but OpenCode does not select them by
subject trigger. The router would have to rely on ad hoc file reads rather than
the client's skill discovery and native `skill` tool. That makes activation
less inspectable and gives runtime verification no first-class inventory.

### One lean `AGENTS.md` plus native OpenCode skills — selected

OpenCode discovers skill metadata and loads a full `SKILL.md` through its
native `skill` tool only when the task matches or the agent explicitly selects
it. This preserves always-loaded authority while keeping detailed procedures
on demand. It also gives `opencode debug skill --pure` an auditable runtime
surface. The repository therefore uses `.opencode/skills/<name>/SKILL.md` and
installs to `<resolved-config-root>/skills/<name>/SKILL.md`.

## Authority Architecture

### Always-loaded global router

The installed `AGENTS.md` is lean but sufficient to govern an action before
any skill body is loaded. It contains:

- the OpenCode title, playbook version, public source, and self-update contract;
- the five partnership principles and the full coda;
- the project goal and precedence model;
- request classification for review, implementation, local configuration, and
  pause requests;
- the complete closed approval table, with an explicit statement that a skill
  or harness cannot add another gate;
- rules 0.1 through 0.4 in full; and
- a mandatory routing table mapping every remaining rule range to one of the
  sixteen namespaced skills and stating when it must be loaded.

Skills carry procedure and detail. They cannot weaken `AGENTS.md`, change
precedence, or create approval requirements.

The global router must be no more than 12 KiB: `wc -c < AGENTS.md` must be at
most 12,288 bytes. This is a load-budget guard, not permission to abbreviate
authority. The complete five principles, coda, source/update contract, goal,
precedence, request classification, closed approval table, rules 0.1–0.4, all
sixteen routes, and OpenCode loading semantics remain mandatory. If those exact
requirements cannot fit, implementation stops and the design is revisited
rather than deleting semantic content to make the byte check green.

### OpenCode instruction behavior

The global root resolves as:

```sh
${OPENCODE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode}
```

When `OPENCODE_CONFIG_DIR` is non-empty, the global `AGENTS.md` beneath that
root replaces the normal XDG global `AGENTS.md`; it is not an additional
global instruction file. Without the override, the XDG-aware root is used.

OpenCode combines global and project instructions, with global instructions
first and project instructions after them. Native `AGENTS.md` versus compatible
`CLAUDE.md` is a fallback choice within the same discovery scope. It is not a
general claim that one project file erases the global instruction layer.

### Sixteen native skills

The repository and installed inventory is exactly:

1. `opencode-playbook-code`
2. `opencode-playbook-collaboration`
3. `opencode-playbook-destructive`
4. `opencode-playbook-documentation`
5. `opencode-playbook-environment`
6. `opencode-playbook-platform-linux`
7. `opencode-playbook-platform-macos`
8. `opencode-playbook-platform-windows`
9. `opencode-playbook-quarantine`
10. `opencode-playbook-repository`
11. `opencode-playbook-reviews`
12. `opencode-playbook-self-update`
13. `opencode-playbook-subagents`
14. `opencode-playbook-testing`
15. `opencode-playbook-workflow`
16. `opencode-playbook-writing`

Project sources use the documented plural path
`.opencode/skills/<name>/SKILL.md`; global copies use
`<resolved-config-root>/skills/<name>/SKILL.md`. The product does not author
singular `skill/` paths. OpenCode may also discover compatible
`.agents/skills` and `.claude/skills`, and skill discovery can be additive
across configuration roots. Those read paths do not widen the playbook's
managed write boundary.

All three platform skills install for portability. Their descriptions and the
router permit only the platform matching the current execution environment to
load. Rule 11.1 is consequently the sole declared multi-owner rule.

## Rule Fidelity and Manifests

The canonical identifiers are `0.1` through `12.4`, totaling 49 unique rules.
The OpenCode edition preserves each rule's intent, constraints, and stable
identifier. Adaptations are limited to client mechanics:

- OpenCode-native instruction and skill paths;
- the native `skill` and subagent mechanisms;
- capability-tier language that remains valid across configured OpenCode model
  providers instead of hard-coding a stale product roster;
- OpenCode runtime and diagnostic commands; and
- the update source `nice-michel/opencode-playbook`.

`config/managed-skills.txt` is the sorted sixteen-name installation inventory.
`config/rule-manifest.tsv` maps each canonical rule ID to its repository owner.
Every rule must have exactly one owner except rule 11.1, whose wildcard owner
requires all three platform skill implementations. Verification rejects a
missing, unknown, duplicate, misplaced, or extra identifier.

Tests do not trust either production manifest to define its own expected
answer. `tests/rulebook_test.sh` carries an independent literal list of all
sixteen expected skill names and an independent literal list of all 49 expected
rule IDs. It compares the production inventories and actual files against those
canonical test fixtures in both directions.

The five mantra principles and coda are also literal fixtures. Verification
normalizes only line endings and Markdown whitespace that does not change text,
then compares their complete text in `AGENTS.md` and the static visual-site
content. A heading-only or keyword-only match is insufficient.

The full parity report records source wording, OpenCode wording, the reason for
every mechanical adaptation, and evidence that there are no silent omissions.
It reads the pinned Claude Git objects as the canonical rule source and the
pinned Codex Git objects as the primary reusable delivery model.

## Component Map and Data Flow

The product has six bounded components:

1. `AGENTS.md` establishes authority and routes a trigger before subject work.
2. Sixteen native skills provide complete procedures when the router selects
   them through OpenCode's `skill` tool.
3. The skill inventory and rule manifest give tests and transactions one
   machine-readable source for membership and ownership.
4. Install and restore scripts move repository sources through verified
   checkpoints and private staging into the resolved global root.
5. Rulebook, lifecycle, runtime, and repository verification suites prove the
   source, transaction, installed, and live-client contracts independently.
6. Current documentation and the static visual site explain the same verified
   product to operators, contributors, and prospective users.

The normal flow is: conversation request → combined global/project instruction
context → mandatory router → selected skill body → work and verification. The
installation flow is: repository source → validated format-2 checkpoint →
verified private staging → seventeen managed destinations → isolated OpenCode
discovery and live-session proof. No component communicates through rewritten
OpenCode JSON or an undeclared mutable store.

## Managed Boundary

The installer manages only these live destinations beneath one resolved
configuration root:

```text
AGENTS.md
skills/opencode-playbook-code/
skills/opencode-playbook-collaboration/
skills/opencode-playbook-destructive/
skills/opencode-playbook-documentation/
skills/opencode-playbook-environment/
skills/opencode-playbook-platform-linux/
skills/opencode-playbook-platform-macos/
skills/opencode-playbook-platform-windows/
skills/opencode-playbook-quarantine/
skills/opencode-playbook-repository/
skills/opencode-playbook-reviews/
skills/opencode-playbook-self-update/
skills/opencode-playbook-subagents/
skills/opencode-playbook-testing/
skills/opencode-playbook-workflow/
skills/opencode-playbook-writing/
```

Operational checkpoints live under `<resolved-config-root>/backups/` and
ephemeral staging, previous-state storage, and the concurrency lock live under
`<resolved-config-root>/.opencode-playbook-transactions/`. Transaction material
never appears beneath `skills/`, because OpenCode recursively discovers skill
definitions there.

The installer and restore command never create, merge, edit, move, or delete
`opencode.json`, `opencode.jsonc`, authentication, providers, models,
permissions, plugins, agents, commands, sessions, unrelated skills, compatible
external skills, or any other user configuration.

## Transaction Design

### Path and type safety

Root selection and root canonicalization are separate operations. A non-empty
`OPENCODE_CONFIG_DIR` selects the active raw root and makes
`XDG_CONFIG_HOME` inactive for root validation. Otherwise a non-empty
`XDG_CONFIG_HOME` selects `<XDG_CONFIG_HOME>/opencode`; if neither override is
active, absolute `HOME` selects `$HOME/.config/opencode`. The active raw root
must be absolute and every lexical component is validated before filesystem
lookup; `.` and `..` components are rejected. Thus an inactive relative
`XDG_CONFIG_HOME` is ignored when an absolute `OPENCODE_CONFIG_DIR` is active.

Portable physical normalization rejects a symlink at the selected raw root,
walks upward lexically to the longest existing ancestor, requires that ancestor
to be a directory, resolves that ancestor with `cd -P`, and appends the already
validated missing suffix component by component. OS-managed ancestor aliases
above the selected root, such as macOS `/var` to `/private/var`, are accepted
and collapse to one physical root. The selected root itself, `skills/`,
`backups/`, transaction root, lock, checkpoints, manifests, completion markers,
managed targets, and every nested source or checkpoint resource must never be a
symlink and must be a real directory or regular file of the expected type.
Special files are refused before a managed write.

After creation, `cd -P` must reproduce the computed physical root. That one
physical normalized root is used in lock-owner records, backup paths,
checkpoint parent comparisons, automatic restore environment, and diagnostics.
Consequently two lexical aliases for the same physical directory share one
lock and backup namespace rather than permitting concurrent transactions.

The scripts use `umask 077`. Existing unrelated files are never traversed as
managed payload and never moved. A different global `AGENTS.md` is refused
unless the operator passes `--replace-agents` after review.

### Concurrency guard

Install and restore acquire one atomic lock directory under the transaction
root before creating a checkpoint. The lock records process ID, operation,
resolved root, and start time. An existing lock causes a safe refusal; it is
never stolen automatically. Automatic install recovery may hand the lock to
`restore.sh` only through an internal token that exactly matches the private
owner record. Normal callers cannot bypass the guard.

Every exit path removes only the lock owned by the current token. A stale lock
is diagnosed with read-only inspection and removed manually only after its
recorded process is proven absent.

### Format-2 checkpoint schema

Format 2 is the only release schema; there is no format-1 compatibility burden
because 0.1.0 is the first public OpenCode release. Each checkpoint name is
either `opencode-playbook-preinstall-<UTC>-<random>` or
`opencode-playbook-prerestore-<UTC>-<random>` and is a direct child of the
resolved `backups/` directory.

The `manifest` is a mode-0600 regular file with exactly this ordered grammar:

```text
format=2
agents=<present|absent>
managed_skill=<sorted-name-1>
skill_<sorted_name_1_with_hyphens_as_underscores>=<present|absent>
...
managed_skill=<sorted-name-16>
skill_<sorted_name_16_with_hyphens_as_underscores>=<present|absent>
```

There is exactly one `agents` entry, sixteen sorted `managed_skill` entries,
and one adjacent state entry for each inventory name. Unknown, duplicate,
missing, out-of-order, or malformed lines are rejected. A `present` state
requires a corresponding safe payload; an `absent` state forbids one. The
checkpoint root may contain only `manifest`, `COMPLETE`, optional `AGENTS.md`,
and the sixteen declared skill directories required by `present` states.

`COMPLETE` is a mode-0600 regular file containing exactly the nine bytes
`complete\n`. It is written only after every payload copy has been read back
and compared and the exact manifest has been revalidated. A checkpoint without
that exact marker is never used for recovery.

### Installation data flow

1. Resolve the exact configuration root and validate every source, parent, and
   existing managed destination.
2. Acquire the concurrency lock.
3. Create a unique pre-install checkpoint and exact manifest.
4. Copy each present managed target into the checkpoint and verify it against
   the live source.
5. Revalidate the checkpoint and write the exact completion marker.
6. Stage `AGENTS.md` and all sixteen skills beneath the private transaction
   root, then compare every staged item with its repository source.
7. Allocate all previous-state storage before the first live move.
8. Mark each target as touched before its first possible move, move any current
   target to previous-state storage, and activate the staged replacement.
9. Compare all seventeen live destinations with repository sources.
10. Mark the transaction complete, retain the immutable checkpoint, remove
    redundant transaction copies, release the lock, and print the exact root,
    installed count, and checkpoint path.

### Restore data flow

1. Resolve the root from the caller's exact `HOME`, `XDG_CONFIG_HOME`, and
   `OPENCODE_CONFIG_DIR` selection.
2. Acquire the lock or validate an internal lock handoff token.
3. Canonicalize the requested checkpoint and require it to be a direct child
   of that root's `backups/` directory with an accepted name.
4. Validate the exact manifest, completion marker, payload set, and every nested
   resource before changing live state.
5. Create and verify a new format-2 pre-restore checkpoint of the current live
   state.
6. Stage the requested state and allocate all previous-state storage outside
   `skills/`.
7. Mark touched state before every possible move, activate present payloads,
   remove only declared absent managed targets by moving them into private
   previous-state storage, and verify every postcondition.
8. On success, retain both checkpoints and clean only redundant transaction
   material.

Manual restore examples always pass the same explicit environment selection
used for installation. Automatic recovery invokes `restore.sh` with the exact
resolved root exported as `OPENCODE_CONFIG_DIR`, the chosen `XDG_CONFIG_HOME`
and `HOME`, and the validated internal lock token. A fallback to a different
root is forbidden.

### Failure and signal handling

Tests use named, opt-in failure events rather than ordinal fake commands. The
scripts recognize the hooks only when the test-mode switch is set and support
fail, signal, and synchronization events for backup copy, manifest completion,
staging copy, previous-state allocation, live preservation, activation,
post-write verification, rollback, and cleanup.

Rollback is guarded against re-entry. It disables handled signals while
recovery is active, restores only targets whose touched markers were set before
their first move, verifies the recovered state, and returns one explicit
success or incomplete-recovery result. `HUP`, `INT`, and `TERM` before the first
move leave live state untouched; the same signals after a move trigger the
single guarded recovery path. Cleanup failure is a visible warning after the
verified state is known and cannot suppress a primary failure.

### Error handling contract

Every refusal and failure exits non-zero with the operation, failed invariant,
and recovery state. Errors never claim rollback succeeded until the restored
bytes and absence postconditions have been verified. Before the first move, an
error names the incomplete or complete checkpoint and confirms that live state
was not changed. After a move, it distinguishes verified automatic recovery
from incomplete recovery and prints the exact durable checkpoint needed for a
manual restore. A cleanup warning cannot replace, hide, or change the primary
result.

## Runtime Validation

`scripts/verify.sh` orchestrates structural, lifecycle, and OpenCode discovery
checks. A release mode additionally performs the live model-backed probe.

Every runtime probe uses:

- a task-created empty workspace as the current directory, with no project
  instruction or configuration file unless that specific test creates one;
- an isolated `HOME`, `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_CACHE_HOME`, and
  `XDG_STATE_HOME`;
- the same explicit `OPENCODE_CONFIG_DIR` used by the installer;
- `OPENCODE_DISABLE_PROJECT_CONFIG=1` where the test is global-only;
- `OPENCODE_DISABLE_EXTERNAL_SKILLS=1` to exclude compatible external skill
  roots; and
- `--pure` to exclude external plugins.

The discovery test parses the stable pretty JSON from
`opencode debug skill --pure` with a repository-owned POSIX `awk` extractor.
The extractor accepts only top-level `name`, `description`, and `location`
string fields, emits one tab-separated tuple per object, and fails closed on a
malformed or truncated object, missing or duplicate relevant field, or escape
sequence in a relevant value. Parser fixtures cover valid, malformed,
truncated, duplicate, escaped, and irrelevant nested data. No new JSON parser
dependency is introduced. Each of the sixteen namespaced skills must appear
exactly once with the exact name, frontmatter description, and installed
`SKILL.md` location. Unrelated built-in or XDG-native global skills are
tolerated; an extra `opencode-playbook-*` skill is not.

Live mode requires non-secret
`OPENCODE_PLAYBOOK_TEST_MODEL=provider/model` and a separately named provider
credential environment variable. It validates the credential name as a safe
shell identifier and its value as present, non-empty, and single-line without
printing the value; it never reads or copies OpenCode authentication files. The
parent shell pipes the credential to an `env -i` child shell, which reads it,
exports exactly the validated dynamic credential name, unsets carrier values,
and `exec`s the captured absolute OpenCode binary. The clean environment
allowlists only `PATH`, `LC_ALL`, `LANG`, isolated HOME and XDG
config/data/cache/state roots, `OPENCODE_CONFIG_DIR`, the selected model, and
that one provider credential. It always sets
`OPENCODE_DISABLE_EXTERNAL_SKILLS=1`; a validated closed launcher mode sets
`OPENCODE_DISABLE_PROJECT_CONFIG=1` only for global-only and empty-workspace
probes, while project/global composition and local fallback probes omit that
variable entirely. Consequently
`OPENCODE_CONFIG`, `OPENCODE_CONFIG_CONTENT`, plugin/provider extras, and all
other caller variables are absent by construction. A minimal isolated model
preflight must pass before evidence probes. Every live invocation uses
`opencode run --model "$OPENCODE_PLAYBOOK_TEST_MODEL"` with default text output
and deterministic unique markers; JSON event parsing is deliberately out of
the live seam.

The runtime modes have a closed responsibility split:

| Probe | Mode | Evidence |
|---|---|---|
| Exact OpenCode 1.18.31 version | `--discovery` and `--live` preflight | Direct CLI output |
| Sixteen exact name/description/location tuples | `--discovery` | Parsed `debug skill --pure` JSON |
| Additive XDG plus explicit-root native skills | `--discovery` | Parsed skill locations and preserved XDG bytes |
| Static-XDG behavior of `debug paths` | `--discovery` | Direct diagnostic output |
| Explicit-root global `AGENTS.md` replaces XDG global instructions | `--live` | Model response to unique conflicting markers; replacement is an inference from the observed response |
| Global and project `AGENTS.md` both participate, with project instructions winning conflicts | `--live` | Model response contains both unique participation markers and the project-selected conflict token; composition and precedence are inferences from those observations |
| Local `AGENTS.md` wins over local `CLAUDE.md` fallback | `--live` | Model response contains the native local marker and omits the conflicting fallback marker; selection is an inference |
| Installed mantra and sixteen advertised skills are usable from an empty workspace | `--live` | Default text response with deterministic markers |

No report may record model-backed custom-root, composition, precedence, or
fallback evidence until `tests/runtime_test.sh --live` has succeeded in that
same evidence run.

The precedence probe appends unique test-only contracts to the installed
temporary global agreement and creates a project agreement in the temporary
workspace. The global contract requires output marker
`GLOBAL_PARTICIPATED_7F3A` and chooses conflict token `GLOBAL_CHOICE_91C2`; the
project contract requires marker `PROJECT_PARTICIPATED_4D8E` and overrides the
token with `PROJECT_CHOICE_B6A1`. The prompt asks for both participation markers
and exactly one conflict token. A passing response contains both markers and
`PROJECT_CHOICE_B6A1`, and omits `GLOBAL_CHOICE_91C2`. Directly observed facts
are the response tokens and environment; combined loading and precedence are
explicitly labeled inferences consistent with OpenCode's documented model.

Additional contract tests prove:

- a custom-root global `AGENTS.md` replaces, rather than supplements, the XDG
  global `AGENTS.md`;
- native skills remain additive across the XDG and explicit configuration
  roots without widening the installer's write boundary;
- global and project `AGENTS.md` content is combined, global first;
- local native `AGENTS.md` versus `CLAUDE.md` is a within-scope fallback;
- `opencode debug paths` continues to report the static XDG configuration path
  and therefore is diagnostic context, not proof of the effective custom
  global instruction root; and
- a live `opencode run --pure --model "$OPENCODE_PLAYBOOK_TEST_MODEL"` from the
  empty workspace can state the installed mantra and enumerate all sixteen
  skills.

Runtime cleanup uses a ledger of paths created by the test. Before each
destructive action, a separate read-only validation proves the path is beneath
the exact task-created runtime root, is not a symlink, and is present in the
ledger. Files are removed individually and directories are removed deepest
first with `rmdir`; recursive deletion is forbidden. If safe cleanup cannot be
proved, the suite leaves the owned directory intact and reports its exact path
instead of attempting an unapproved destructive shortcut.

Release checks require `opencode --version` to equal `1.18.31`. A mismatch is a
compatibility-audit failure, not a warning or a claim of broader support.

## Public Documentation and Visual Site

The release has current root documentation for installation, architecture,
contribution, security, status, change history, plan, backlog, handoff,
environment example, license, and version. The truthful `.env.example`,
`BACKLOG.md`, `CONTRIBUTING.md`, and `SECURITY.md` exist in the public 0.0.1
planning checkpoint, before implementation. `docs/` contains indexed guides,
plans, reports, reviews, runbooks, handoffs, ideas, and immutable architectural
decisions. The original prototype `HANDOFF.md` is preserved verbatim as a dated
historical record before root `HANDOFF.md` is repointed to the corrective seam.
Historical documents remain labeled as historical inputs so repository search
results do not make them look current.

Planning status is durable rather than predictive. `HANDOFF.md`, `PROGRESS.md`,
and `PLAN.md` label the pre-publication snapshot explicitly and express mutable
state as read-only discovery commands plus invariant gates. Later handoffs and
release evidence record actual UTC observation timestamps and enough commands
to rediscover branch, checkpoint, PR, merge, release, Pages, worktree, and
process state after external actions change.

GitHub Pages serves `main:/docs`. `docs/.nojekyll` is committed so the static
site is served without Jekyll processing. The page is one dependency-free
`docs/index.html` with local assets, no analytics, cookies, remote fonts,
framework, build step, or application server.

The site has a distinct OpenCode identity rather than a recolored Claude or
Codex page. An original generated raster hero presents an open, inspectable
mechanism or workbench in a matte editorial style. The full five-principle
mantra and coda are visible in the rendered page, not hidden in metadata. The
page also presents the closed approval model, all 49 rule identifiers, the
thirteen sections, sixteen-skill architecture, configuration-root behavior,
and backup-first lifecycle.

Core content is static semantic HTML. JavaScript progressively enhances rule
filtering, navigation, and active state. The page includes a skip link,
landmarks, logical heading order, keyboard-operable controls, visible focus,
useful alternative text, sufficient contrast, responsive layouts, a useful
zero-result state, and a complete reduced-motion override. Browser quality
assurance covers desktop and mobile rendering, search, keyboard navigation,
overflow, image loading, reduced motion, and a clean console.

## Security Model

The repository never stores credentials and the scripts never print secret
values. GitHub authentication is checked by account name only and must remain
`nice-michel`. The installer does not parse or rewrite user OpenCode JSON,
which avoids exposing provider secrets or silently changing permissions.

The trust boundary is the resolved configuration root and the checked-out
repository sources. Symlinks, special files, untrusted checkpoint parents,
schema ambiguity, transaction overlap, and incomplete checkpoints fail closed.
Backups are private, verified, immutable recovery evidence; the tools never
delete them.

The public repository enables private vulnerability reporting and documents
that channel in `SECURITY.md`. Release evidence contains advisory results but
never authentication material or personally identifiable information.

## Publication and Release

The canonical public repository is `nice-michel/opencode-playbook`. Work occurs
on the isolated `feature/modular-opencode-release` branch. Before implementation,
the complete 0.0.1 planning candidate is committed with its root records,
handoff preservation, source pin, design, plan, ADR, and current status. Fresh
specification and quality reviews then inspect that exact commit. Confirmed
findings land as focused review-fix commits and both reviews repeat against the
new exact tip. Only the finally approved clean tip is tagged. GitHub
authentication is verified as `nice-michel`; the public repository is then
created and local `main`, the feature branch, and annotated
`checkpoint/0.0.1` are pushed. The peeled planning tag and remote feature
branch must equal the reviewed tip.
Immediately after repository creation, private vulnerability reporting is
enabled and verified through the GitHub REST API before any implementation
task begins, making the channel documented in `SECURITY.md` live at first
publication.

Every implementation task updates current docs, allocates the next unused
semantic checkpoint version, and creates one logical candidate commit. Fresh
specification and quality reviews run before tagging. Confirmed findings land
as focused review-fix commits and are re-reviewed. Final verification runs on
the approved tip; only then is `checkpoint/<VERSION>` created and the feature
branch and tag pushed immediately. No later task backfills accumulated tags.

The publication-configuration task verifies the existing repository and
`origin`; it does not create or seed them. It configures GitHub Pages through
the REST API with `main` and `/docs`, reads the setting back, enables private
vulnerability reporting through the REST API, verifies it independently, and
opens the release pull request. After the reviewed Task 7 tip is pushed, the PR
body is replaced with the reviewed returned-state record and the state, base,
head, head SHA, URL, and exact body are read back and asserted.

After final independent specification and quality reviews pass, the feature
branch is merged into `main` without rewriting history. The exact merged commit
receives annotated tag `v0.1.0`. The release is created with
`gh release create --verify-tag`, and verification proves that local `HEAD`,
remote `main`, and the peeled annotated tag resolve to the same commit. Pages
polling is bounded to explicit attempts and intervals, accepts only `built` as
success, and fails on terminal `errored`, `cancelled`, unknown, or timeout
states. Redirect-bounded `curl` checks require final HTTP 200, exact effective
URLs, PNG hero content type, and defining site content markers.

Merge readiness reads `statusCheckRollup` instead of invoking a check command
that treats no checks as an error. Exactly zero checks is an explicitly
verified acceptable state for this workflow-free repository; pending checks
wait within a bound, failing or unknown terminal checks block, and only zero or
fully passing checks allow merge.

The dependency audit scans the complete tracked tree from `git ls-files` for
common Node/Bun/Deno, Rust, Python, Go, Ruby, PHP, Java/Gradle/Maven, and .NET
manifests and locks plus vendored/submodule indicators. It separately inspects
every runtime-consumed script regardless of executable mode: all `scripts/`
and `tests/` files, common script extensions, and every tracked shebang file,
including sourced helpers such as `scripts/lib.sh`. Ordinary download tools,
package-manager install/add/get commands, remote runners, PowerShell web
requests, and URL-to-shell forms are hook findings. The expected zero surface
is recorded with exact counts and path sets. Every non-zero match requires an
explicit evidence-file classification and reviewer approval; an unclassified
network/install hook blocks release. Any dependency finding switches to the
ecosystem's real audit and blocks a known fixable CVE. External OpenCode itself
is not misrepresented as a vendored repository dependency.

## Testing Strategy

### Rule and metadata contracts

`scripts/verify_planning.sh` has exact `--working-tree` and
`--committed <base>` modes. It owns the explicit 0.0.1 planning-file inventory,
including files that begin untracked, and checks required/non-empty files,
`VERSION`, plan header and task count, unfinished markers, trailing whitespace,
local links, historical-handoff byte identity, canonical source pins, and diff
whitespace. Working-tree mode runs both `git diff --check` and
`git diff --cached --check`; committed mode requires a clean state, checks
`git diff --check <base>..HEAD`, and requires the committed diff inventory to
equal the reviewed allowlist.

`tests/rulebook_test.sh` validates the exact skill inventory, frontmatter,
49-rule ownership map, 12,288-byte router boundary, platform exclusivity,
source adaptation report, public rule map, required files, local links, version
carriers, and absence of unfinished markers in current product documents. Its
independent literal fixtures contain all sixteen skill names, all 49 rule IDs,
and the normalized complete text of the five principles and coda; production
manifests and headings cannot satisfy those checks by defining expectations.

### Lifecycle contracts

`tests/install_test.sh` creates a private temporary root per case and covers
first install, reinstall, explicit replacement, unique checkpoints, XDG and
custom roots, unrelated-file preservation, strict schemas, all unsafe file
types, every named failure point, signal recovery, concurrency refusal, stale
lock diagnosis, exact root propagation, restore reversibility, and visible
cleanup warnings. Every destructive test action is confined to that case's
owned temporary directory.

### OpenCode contracts

`tests/runtime_test.sh` covers exact CLI version, isolated discovery, custom
global replacement, additive skill discovery, global-plus-project instruction
composition, local fallback behavior, `debug paths`, and the live empty-workspace
probe. Model-backed tests are explicit release checks and never reported as
passing when provider access is unavailable.

### Site and publication contracts

Structural checks prove static presence of all mantra principles, the coda,
all 49 rule IDs, local asset references, reduced-motion CSS, and semantic
navigation. Browser quality assurance and GitHub REST verification supply the
behavioral and publication evidence that shell text checks cannot.

## Acceptance Criteria

Version 0.1.0 is acceptable only when all of the following are true:

1. `AGENTS.md` contains the complete always-loaded authority contract, is no
   larger than 12,288 bytes, and has no subject rule body beyond 0.1–0.4; no
   required semantic content was removed to meet the byte limit.
2. Sixteen native `.opencode/skills/opencode-playbook-*/SKILL.md` directories
   preserve all remaining canonical rules and only rule 11.1 has three owners.
3. Machine-readable manifests and the human parity report account for all 49
   unique identifiers with no silent doctrinal omission.
4. Install and restore mutate only the seventeen managed live destinations and
   private operational metadata beneath the one resolved root.
5. Format-2 checkpoints, concurrency, path validation, signal handling,
   rollback, failure injection, exact-root propagation, and unrelated-state
   preservation pass the full lifecycle suite. Physical normalization accepts
   ancestor aliases but rejects traversal and selected-root or descendant
   symlinks; aliases share one lock and backup identity.
6. OpenCode 1.18.31 discovers every installed skill at its exact path and a live
   empty-workspace session proves the installed global authority is active.
7. Discovery tests directly prove skill and diagnostic behavior; live tests
   directly observe deterministic markers for custom-root replacement,
   combined global/project participation, project-over-global conflict
   resolution, and local fallback. Reports distinguish observations from the
   resulting loading and precedence inferences. The repository-owned POSIX
   extractor passes every valid and invalid pretty-JSON fixture; live tests use
   an explicit provider/model and environment-only credential seam.
8. Current README, installation, architecture, contributor, security, runbook,
   progress, change, plan, backlog, handoff, ADR, report, and version records
   describe the implemented product without support overclaims.
9. The accessible responsive Pages site visibly contains the full mantra and
   coda, all 49 rules, a distinct OpenCode design, and an original inspected
   raster hero, with clean desktop and mobile browser evidence.
10. The complete candidate tip, including current review records, status,
    version, backlog, and handoff, receives fresh specification and quality
    reviews with no unresolved Critical or Important findings before its
    immutable checkpoint tag is created.
11. The public repository is owned by `nice-michel`; Pages, private
    vulnerability reporting, default branch, metadata, release, and site health
    are verified from returned state.
12. Local `HEAD`, remote `main`, and peeled annotated `v0.1.0` identify the same
   commit; `gh release create --verify-tag` succeeds; Git state is clean; and
   no project process remains running.
13. The 0.0.1 planning verifier passes in working-tree mode before its commit
    and committed mode afterward, with exact inventory equality and no
    untracked omission.

## Consequences

The corrected product is larger on disk than the first design but smaller in
every session because detailed subjects load only when relevant. Installation
and restoration are more complex because they protect seventeen destinations
and two configuration-root semantics, but that complexity is isolated in
tested transaction code rather than imposed on users. Rule evolution now has a
clear synchronization cost: owner skill, rule manifest, parity report, public
site, and tests must change together. That cost is intentional because it makes
silent drift visible before release.
