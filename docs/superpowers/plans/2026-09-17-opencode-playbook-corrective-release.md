# OpenCode Playbook Corrective Release Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Publish OpenCode Playbook 0.1.0 as the faithful, modular,
OpenCode-native distribution of Michel's complete 49-rule doctrine, with safe
installation and restoration, isolated OpenCode 1.18.31 runtime proof, a
distinct accessible visual site, and verified GitHub publication.

**Architecture:** A lean global `AGENTS.md` owns authority and routes triggers
to sixteen native `.opencode/skills/opencode-playbook-*/SKILL.md` modules. Two
manifests lock rule ownership and installed inventory; POSIX shell transactions
manage one XDG-aware configuration root with format-2 checkpoints, strict path
validation, concurrency control, and rollback. Dependency-free public docs and
a static Pages site explain the same contract.

**Tech Stack:** Markdown, POSIX shell, standard Unix utilities, OpenCode
1.18.31, dependency-free HTML/CSS/JavaScript, Git, GitHub CLI, ImageGen, and
browser automation for visual quality assurance.

---

## Execution Protocol

- Work only on the isolated `feature/modular-opencode-release` worktree until
  Task 8 performs the approved final merge.
- A coordinator dispatches a fresh implementer for each task. The implementer
  receives this plan, the corrective specification, the applicable repository
  instructions, and only that task's scope.
- Every task follows RED, GREEN, documentation, version allocation, and a
  candidate commit. A fresh specification review and then a fresh quality
  review run against that candidate. Confirmed findings return to an
  implementation agent as focused review-fix commits, and both reviews repeat.
  Final verification runs on the approved tip; only then may the annotated
  checkpoint tag be created and the branch and tag pushed.
- Every subagent brief includes: `If you are stuck after a real attempt,
  looping, or would have to guess, stop and report ESCALATE: followed by the
  evidence and attempts.`
- Planning, architecture, trust-boundary work, transaction work, release
  review, and publication review use the strongest available reasoning model.
  Mechanical document or visual implementation may use the lowest model that
  can satisfy the task, but review never uses the fast tier.
- Each task updates `CHANGELOG.md`, `PROGRESS.md`, `PLAN.md`, and any affected
  current guide. It updates `BACKLOG.md` whenever an out-of-scope observation
  or authorized deferment occurs; if none occurs, the close-out says so rather
  than adding noise. Allocate the exact checkpoint version named below only
  after confirming no local or remote `checkpoint/<VERSION>` exists.
- Each task starts with one logical candidate commit. Review-fix commits are
  allowed and remain one logical change each. The immutable
  `checkpoint/<VERSION>` tag points only to the final reviewed tip. The public
  repository and `origin` exist before Task 1, so every implementation task
  pushes its approved branch tip and checkpoint immediately.
- Every candidate and review-fix commit stages only a literal task-owned file
  allowlist. Before each commit, print `git diff --cached --name-status`,
  compare the cached path set with the exact expected set for that commit, run
  `git diff --cached --check`, and prove no allowed change remains unstaged.
  If a finding requires a path outside the task allowlist, update and re-review
  the plan rather than widening a staging command implicitly.
- The 0.0.1 planning checkpoint has one documented whitespace-check exception:
  `docs/handoffs/2026-09-16-prototype-handoff.md` preserves the prototype
  handoff's intentional blank EOF line byte-for-byte. Planning working-tree,
  cached, and committed-range `git diff --check` calls exclude only that path
  with a Git pathspec. The planning verifier still inventories and scans it and
  proves byte identity with `cmp`; all twenty current artifacts remain under
  the ordinary whitespace checks.
- Use `apply_patch` for hand edits. Formatting or purpose-built generation
  tools may rewrite their own outputs.
- Dates embedded in evidence filenames, including `2026-09-17`, identify this
  plan lineage; they are not execution-date claims. Every evidence file records
  actual `started_at_utc` and `finished_at_utc` values from
  `date -u +%Y-%m-%dT%H:%M:%SZ`. Changelog and release dates use
  `release_date=$(date -u +%F)` at execution rather than a hard-coded date.
- The canonical sources are:
  - Claude doctrine Git object database:
    `/Users/Michel.Abboud/projects/claude-code-playbook`, exact commit
    `5db68e347a65e511cc378b0598a6aac6655845bd`, `VERSION` `0.1.12`
  - mature Codex modular Git object database:
    `/Users/Michel.Abboud/.config/superpowers/worktrees/codex-playbook/fix-modular-rule-parity`,
    exact commit `b79080ad6f3f9605b60d4722265a5d271ea2e540`, `VERSION` `0.1.3`
  These paths supply Git objects only. Never read source checkout files or rely
  on either source repository's branch, `HEAD`, index, or working-tree state.

After every Task 1–8 push, deliver the required five-section close-out before
starting the next task:

1. **What was built** — outcome, not narration.
2. **Verification evidence** — exact commands, decisive counts and exit status,
   plus a one-line subagent model ledger naming implementer and reviewers.
3. **Assumptions made** — every judgment call.
4. **Concerns and observations** — including each new `BACKLOG.md` entry or an
   explicit statement that none was added.
5. **Close-out confirmation** — current docs, version, candidate/review-fix
   commits, approved-tip checkpoint, branch push, and tag push.

## Planning Checkpoint Publication — Required Before Task 1

The planning checkpoint is itself subject to the exact-tip rule. Complete this
sequence before dispatching the Task 1 implementer:

- [ ] Run the executable planning verifier against the complete working-tree
  inventory, including untracked files:

```sh
chmod +x scripts/verify_planning.sh
sh -n scripts/verify_planning.sh
dash -n scripts/verify_planning.sh
./scripts/verify_planning.sh --working-tree
```

  Expected: the explicit 0.0.1 allowlist, required/non-empty files, bare
  version, eight-task header, placeholders, trailing whitespace, local links,
  byte-identical historical handoff, source pins, and both unstaged and staged
  whitespace checks pass. The Git whitespace checks exclude only the immutable
  historical handoff described above; its byte-identity check remains mandatory.
- [ ] Run the complete planning-document verification again, then create the
  complete candidate commit. The commit includes all planning-stage root
  records, current and historical handoffs, source-pin evidence, status docs,
  the corrective design, and this executable plan:

```sh
planning_base=$(git rev-parse HEAD)
git add .env.example BACKLOG.md CONTRIBUTING.md SECURITY.md HANDOFF.md \
  README.md ARCHITECTURE.md PROGRESS.md CHANGELOG.md PLAN.md VERSION \
  docs/adr/0002-native-progressive-disclosure.md docs/adr/README.md \
  docs/handoffs/2026-09-16-prototype-handoff.md docs/handoffs/README.md \
  docs/plans/README.md docs/reports/2026-09-17-canonical-source-pin.md \
  docs/reports/README.md scripts/verify_planning.sh \
  docs/superpowers/specs/2026-09-17-opencode-playbook-corrective-design.md \
  docs/superpowers/plans/2026-09-17-opencode-playbook-corrective-release.md
git diff --cached --name-status
expected_staged_paths='.env.example
ARCHITECTURE.md
BACKLOG.md
CHANGELOG.md
CONTRIBUTING.md
HANDOFF.md
PLAN.md
PROGRESS.md
README.md
SECURITY.md
VERSION
docs/adr/0002-native-progressive-disclosure.md
docs/adr/README.md
docs/handoffs/2026-09-16-prototype-handoff.md
docs/handoffs/README.md
docs/plans/README.md
docs/reports/2026-09-17-canonical-source-pin.md
docs/reports/README.md
docs/superpowers/plans/2026-09-17-opencode-playbook-corrective-release.md
docs/superpowers/specs/2026-09-17-opencode-playbook-corrective-design.md
scripts/verify_planning.sh'
test "$(git diff --cached --name-only | LC_ALL=C sort)" = \
  "$(printf '%s\n' "$expected_staged_paths" | LC_ALL=C sort)"
git diff --cached --check -- . \
  ':(exclude)docs/handoffs/2026-09-16-prototype-handoff.md'
git commit -m "docs: approve OpenCode corrective release plan"
./scripts/verify_planning.sh --committed "$planning_base"
```

- [ ] Dispatch a fresh specification reviewer against the exact candidate
  commit, the user-authorized goal, corrective design, implementation plan,
  ADR 0002, and current status docs. Then dispatch a separate fresh quality
  reviewer against that same commit without the first reviewer's conclusions.
  Resolve findings through focused review-fix commits and repeat both reviews
  against each new tip until no Critical or Important finding remains. Do not
  change a tracked file after the finally approved exact-tip review.
- [ ] Re-run the complete planning-document verification on the clean approved
  tip. Only then create the annotated planning checkpoint:

```sh
planning_base=$(git merge-base HEAD main)
./scripts/verify_planning.sh --committed "$planning_base"
test "$(gh api user --jq .login)" = nice-michel
test -z "$(git tag -l checkpoint/0.0.1)"
set +e
repo_absence=$(gh api repos/nice-michel/opencode-playbook 2>&1)
repo_absence_status=$?
set -e
test "$repo_absence_status" -ne 0
printf '%s\n' "$repo_absence" | grep -Eq 'Not Found|HTTP 404'
approved_planning_tip=$(git rev-parse HEAD)
git tag -a checkpoint/0.0.1 -m "OpenCode Playbook checkpoint 0.0.1"
test "$(git rev-parse 'checkpoint/0.0.1^{}')" = "$approved_planning_tip"
```

- [ ] Verify GitHub authentication remains `nice-michel`, create the approved
  public repository, verify the exact `origin`, then push local `main`, the
  feature branch, and only the reviewed planning tag:

```sh
approved_planning_tip=$(git rev-parse 'checkpoint/0.0.1^{}')
gh repo create nice-michel/opencode-playbook --public --source=. --remote=origin
test "$(git remote get-url origin)" = https://github.com/nice-michel/opencode-playbook.git
test "$(gh repo view nice-michel/opencode-playbook --json visibility --jq .visibility)" = PUBLIC
gh api --method PUT repos/nice-michel/opencode-playbook/private-vulnerability-reporting
test "$(gh api repos/nice-michel/opencode-playbook/private-vulnerability-reporting --jq .enabled)" = true
git push -u origin main
git push -u origin feature/modular-opencode-release
git push origin checkpoint/0.0.1
test "$(git ls-remote origin refs/heads/feature/modular-opencode-release | awk '{print $1}')" = "$approved_planning_tip"
test "$(git ls-remote origin 'refs/tags/checkpoint/0.0.1^{}' | awk '{print $1}')" = "$approved_planning_tip"
```

Expected: the public repository exists before implementation, local `main` is
the remote base, the feature branch is the reviewed 0.0.1 planning tip, and the
peeled remote planning tag identifies that same tip. Private vulnerability
reporting is enabled and verified before Task 1, so the channel documented in
`SECURITY.md` is live when the planning checkpoint becomes public.

### Task 1: Lock and implement the complete modular rule contract

**Checkpoint version:** `0.0.2`

**Required skills:** test-driven development, then verification before
completion.

**Files:**
- Create: `config/managed-skills.txt`
- Create: `config/rule-manifest.tsv`
- Create: `tests/rulebook_test.sh`
- Modify: `AGENTS.md`
- Create: `.opencode/skills/opencode-playbook-code/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-collaboration/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-destructive/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-documentation/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-environment/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-platform-linux/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-platform-macos/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-platform-windows/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-quarantine/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-repository/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-reviews/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-self-update/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-subagents/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-testing/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-workflow/SKILL.md`
- Create: `.opencode/skills/opencode-playbook-writing/SKILL.md`
- Create: `docs/reports/2026-09-17-rule-parity-matrix.md`
- Modify: `ARCHITECTURE.md`
- Modify: `README.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`
- Modify: `PLAN.md`
- Modify: `VERSION`

- [ ] **Step 1: Verify and enumerate the pinned Git objects**

Run:

```sh
git branch --show-current
git status --short
test "$(cat VERSION)" = 0.0.1
test -f docs/superpowers/specs/2026-09-17-opencode-playbook-corrective-design.md
test -f docs/adr/0002-native-progressive-disclosure.md
claude_repo=${CLAUDE_PLAYBOOK_SOURCE_REPO:-/Users/Michel.Abboud/projects/claude-code-playbook}
claude_sha=5db68e347a65e511cc378b0598a6aac6655845bd
codex_repo=${CODEX_PLAYBOOK_SOURCE_REPO:-/Users/Michel.Abboud/.config/superpowers/worktrees/codex-playbook/fix-modular-rule-parity}
codex_sha=b79080ad6f3f9605b60d4722265a5d271ea2e540

test "$(git -C "$claude_repo" rev-parse "${claude_sha}^{commit}")" = "$claude_sha"
test "$(git -C "$codex_repo" rev-parse "${codex_sha}^{commit}")" = "$codex_sha"
test "$(git -C "$claude_repo" show "${claude_sha}:VERSION")" = 0.1.12
test "$(git -C "$codex_repo" show "${codex_sha}:VERSION")" = 0.1.3

test "$(git -C "$claude_repo" rev-parse "${claude_sha}^{tree}")" = \
  aad7b85f22c437081805f594d80ff60ce9fa0860
test "$(git -C "$claude_repo" rev-parse "${claude_sha}:CLAUDE.md")" = \
  8c17cb76c2e0121085d88acb76ff45e47c5db37b
test "$(git -C "$claude_repo" rev-parse "${claude_sha}:rules")" = \
  72a3805790450adc97404a3cd898e97752391e9e
test "$(git -C "$claude_repo" ls-tree -r --name-only "$claude_sha" -- \
  VERSION CLAUDE.md rules | wc -l | tr -d ' ')" -eq 18
test "$(git -C "$claude_repo" ls-tree -r --name-only "$claude_sha" -- rules | \
  grep -Ec '^rules(/platform)?/[A-Z-]+\.md$')" -eq 16

test "$(git -C "$codex_repo" rev-parse "${codex_sha}^{tree}")" = \
  0e44f7d1df977c3ece1b9c3b11719d082e0ae0fc
test "$(git -C "$codex_repo" rev-parse "${codex_sha}:AGENTS.md")" = \
  9d721dacb6dbf53d87416dfe0ed5056758dd0da4
test "$(git -C "$codex_repo" rev-parse "${codex_sha}:.agents/skills")" = \
  30154c9b5e11b9ce4e63ac2a6ddeef7fd37ad51d
test "$(git -C "$codex_repo" rev-parse \
  "${codex_sha}:config/rule-manifest.tsv")" = \
  c3dfc92048cf80bef4dce44df894ff70ab5b0cad
test "$(git -C "$codex_repo" ls-tree -r --name-only "$codex_sha" -- \
  VERSION AGENTS.md config/managed-skills.txt config/rule-manifest.tsv \
  .agents/skills | wc -l | tr -d ' ')" -eq 20
test "$(git -C "$codex_repo" ls-tree -r --name-only "$codex_sha" -- \
  .agents/skills | grep -Ec '^\.agents/skills/codex-playbook-[a-z-]+/SKILL\.md$')" -eq 16
test "$(git -C "$codex_repo" show \
  "${codex_sha}:config/managed-skills.txt" | wc -l | tr -d ' ')" -eq 16
test "$(git -C "$codex_repo" show \
  "${codex_sha}:config/rule-manifest.tsv" | cut -f1 | \
  LC_ALL=C sort -u | wc -l | tr -d ' ')" -eq 49
```

Expected: the branch is `feature/modular-opencode-release`, the worktree is
clean after the planning commit, `VERSION` is `0.0.1`, and both approved design
records exist. Both pinned identifiers resolve to the expected commits,
versions, root trees, key blobs, subject trees, and inventory counts. Every
subsequent source read uses `git -C "$repo" show "${sha}:<path>"`; every source
inventory uses `git -C "$repo" ls-tree -r --name-only "$sha" -- <path>`.
Never inspect checkout files or require either source checkout to be clean, and
never run a mutating command in either source repository.

- [ ] **Step 2: Add the exact installed-skill inventory**

Create `config/managed-skills.txt` with exactly these sorted lines:

```text
opencode-playbook-code
opencode-playbook-collaboration
opencode-playbook-destructive
opencode-playbook-documentation
opencode-playbook-environment
opencode-playbook-platform-linux
opencode-playbook-platform-macos
opencode-playbook-platform-windows
opencode-playbook-quarantine
opencode-playbook-repository
opencode-playbook-reviews
opencode-playbook-self-update
opencode-playbook-subagents
opencode-playbook-testing
opencode-playbook-workflow
opencode-playbook-writing
```

Create `config/rule-manifest.tsv` with literal tab separators and exactly this
ownership map:

```text
0.1	AGENTS.md
0.2	AGENTS.md
0.3	AGENTS.md
0.4	AGENTS.md
1.1	.opencode/skills/opencode-playbook-code/SKILL.md
1.2	.opencode/skills/opencode-playbook-code/SKILL.md
1.3	.opencode/skills/opencode-playbook-code/SKILL.md
1.4	.opencode/skills/opencode-playbook-code/SKILL.md
1.5	.opencode/skills/opencode-playbook-code/SKILL.md
1.6	.opencode/skills/opencode-playbook-code/SKILL.md
2.1	.opencode/skills/opencode-playbook-testing/SKILL.md
2.2	.opencode/skills/opencode-playbook-testing/SKILL.md
2.3	.opencode/skills/opencode-playbook-testing/SKILL.md
3.1	.opencode/skills/opencode-playbook-reviews/SKILL.md
3.2	.opencode/skills/opencode-playbook-reviews/SKILL.md
3.3	.opencode/skills/opencode-playbook-reviews/SKILL.md
3.4	.opencode/skills/opencode-playbook-reviews/SKILL.md
4.1	.opencode/skills/opencode-playbook-documentation/SKILL.md
4.2	.opencode/skills/opencode-playbook-documentation/SKILL.md
4.3	.opencode/skills/opencode-playbook-documentation/SKILL.md
5.1	.opencode/skills/opencode-playbook-repository/SKILL.md
5.2	.opencode/skills/opencode-playbook-repository/SKILL.md
5.3	.opencode/skills/opencode-playbook-repository/SKILL.md
6.1	.opencode/skills/opencode-playbook-workflow/SKILL.md
6.2	.opencode/skills/opencode-playbook-workflow/SKILL.md
6.3	.opencode/skills/opencode-playbook-workflow/SKILL.md
6.4	.opencode/skills/opencode-playbook-workflow/SKILL.md
7.1	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.2	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.3	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.4	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.5	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.6	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.7	.opencode/skills/opencode-playbook-collaboration/SKILL.md
8.1	.opencode/skills/opencode-playbook-subagents/SKILL.md
9.1	.opencode/skills/opencode-playbook-environment/SKILL.md
9.2	.opencode/skills/opencode-playbook-environment/SKILL.md
9.3	.opencode/skills/opencode-playbook-environment/SKILL.md
9.4	.opencode/skills/opencode-playbook-environment/SKILL.md
9.5	.opencode/skills/opencode-playbook-environment/SKILL.md
9.6	.opencode/skills/opencode-playbook-environment/SKILL.md
10.1	.opencode/skills/opencode-playbook-destructive/SKILL.md
10.2	.opencode/skills/opencode-playbook-destructive/SKILL.md
10.3	.opencode/skills/opencode-playbook-quarantine/SKILL.md
11.1	.opencode/skills/opencode-playbook-platform-*/SKILL.md
12.1	.opencode/skills/opencode-playbook-writing/SKILL.md
12.2	.opencode/skills/opencode-playbook-writing/SKILL.md
12.3	.opencode/skills/opencode-playbook-writing/SKILL.md
12.4	.opencode/skills/opencode-playbook-writing/SKILL.md
```

- [ ] **Step 3: Write the failing rulebook contract**

Create `tests/rulebook_test.sh` as an executable POSIX shell suite. Its failure
helper must exit non-zero, and its pass counter must print one final summary.
Define these independent literal expected sets inside the test; do not read
either expected set from `config/managed-skills.txt` or
`config/rule-manifest.tsv`:

```sh
expected_skill_names='opencode-playbook-code
opencode-playbook-collaboration
opencode-playbook-destructive
opencode-playbook-documentation
opencode-playbook-environment
opencode-playbook-platform-linux
opencode-playbook-platform-macos
opencode-playbook-platform-windows
opencode-playbook-quarantine
opencode-playbook-repository
opencode-playbook-reviews
opencode-playbook-self-update
opencode-playbook-subagents
opencode-playbook-testing
opencode-playbook-workflow
opencode-playbook-writing'

expected_rule_ids='0.1
0.2
0.3
0.4
1.1
1.2
1.3
1.4
1.5
1.6
2.1
2.2
2.3
3.1
3.2
3.3
3.4
4.1
4.2
4.3
5.1
5.2
5.3
6.1
6.2
6.3
6.4
7.1
7.2
7.3
7.4
7.5
7.6
7.7
8.1
9.1
9.2
9.3
9.4
9.5
9.6
10.1
10.2
10.3
11.1
12.1
12.2
12.3
12.4'
```

Compare each literal set bidirectionally with its production manifest, then
implement these exact assertions:

```sh
test "$(wc -l < config/managed-skills.txt | tr -d ' ')" -eq 16
test "$(LC_ALL=C sort -u config/managed-skills.txt | wc -l | tr -d ' ')" -eq 16
test "$(cut -f1 config/rule-manifest.tsv | LC_ALL=C sort -u | wc -l | tr -d ' ')" -eq 49
test "$(grep -Ec '^11\.1[[:space:]]' config/rule-manifest.tsv)" -eq 1
test "$(wc -c < AGENTS.md | tr -d ' ')" -le 12288
```

For every inventory name, assert one real directory, one regular non-symlinked
`SKILL.md`, folder/frontmatter name equality, and one non-empty single-line
description. For every manifest row except the wildcard, require the exact rule
ID at the start of a line in exactly its declared owner. For the wildcard,
require `11.1` in all three platform skills and nowhere else. Reject any rule ID
matching `^[0-9]+\.[0-9]+` that is absent from the manifest or occurs in an
undeclared owner.

Read the canonical mantra directly from the pinned Git object with this
self-contained, override-aware command:

```sh
claude_repo=${CLAUDE_PLAYBOOK_SOURCE_REPO:-/Users/Michel.Abboud/projects/claude-code-playbook}
claude_sha=5db68e347a65e511cc378b0598a6aac6655845bd
git -C "$claude_repo" show "${claude_sha}:CLAUDE.md"
```

Embed the normalized complete text of all five pinned Claude mantra principles
and the coda as six literal here-document fixtures in the test. Normalize only
line endings, Markdown emphasis markers, and runs of layout whitespace; compare
the complete normalized text, not headings or keywords. Require all six exact
fixtures in `AGENTS.md`. When `docs/index.html` exists, extract the visible
single-paragraph `data-mantra="1"` through `data-mantra="5"` and
`data-mantra="coda"` values and require the same normalized fixtures there.

Also assert the source/version contract, request classification, every
approval-table row, rules 0.1–0.4, all sixteen literal routed skill names, the
native `skill` instruction, and the OpenCode loading model. Assert that subject
rules 1.1–12.4 do not appear in `AGENTS.md`.

Assert that each of these source files is represented in the parity report:

```text
rules/AUTHORITY.md
rules/CODE.md
rules/TESTING.md
rules/REVIEWS.md
rules/DOCS.md
rules/REPO.md
rules/WORKFLOW.md
rules/COLLABORATION.md
rules/SUBAGENTS.md
rules/ENVIRONMENT.md
rules/DESTRUCTIVE.md
rules/QUARANTINE.md
rules/WRITING.md
rules/platform/LINUX.md
rules/platform/MACOS.md
rules/platform/WINDOWS.md
```

Run:

```sh
chmod +x tests/rulebook_test.sh
sh -n tests/rulebook_test.sh
dash -n tests/rulebook_test.sh
./tests/rulebook_test.sh
```

Expected RED result: both syntax checks pass, then the suite fails because the
lean router, sixteen skills, and parity matrix do not exist yet. It must not
fail because of shell syntax or a malformed manifest.

- [ ] **Step 4: Replace the historical monolith with the lean OpenCode router**

Inspect the two pinned router sources directly:

```sh
claude_repo=${CLAUDE_PLAYBOOK_SOURCE_REPO:-/Users/Michel.Abboud/projects/claude-code-playbook}
claude_sha=5db68e347a65e511cc378b0598a6aac6655845bd
codex_repo=${CODEX_PLAYBOOK_SOURCE_REPO:-/Users/Michel.Abboud/.config/superpowers/worktrees/codex-playbook/fix-modular-rule-parity}
codex_sha=b79080ad6f3f9605b60d4722265a5d271ea2e540
git -C "$codex_repo" show "${codex_sha}:AGENTS.md"
git -C "$claude_repo" show "${claude_sha}:CLAUDE.md"
```

Adapt the approved always-loaded core only from that Codex object output while
preserving the five Claude mantra principles and coda only from that Claude
object output. Write the OpenCode `AGENTS.md` with `apply_patch`; do not copy or
redirect a source object into the target. Use the title
`My Global Rules — OpenCode`, source `github.com/nice-michel/opencode-playbook`,
version `0.0.2`, and self-update skill `opencode-playbook-self-update`.

Encode OpenCode precedence exactly:

```text
direct conversation instruction
→ applicable project AGENTS.md instructions
→ global AGENTS.md at the resolved OpenCode configuration root
→ loaded OpenCode Playbook skills
```

State separately that global and project instructions are combined, global
first; within a discovery scope, native `AGENTS.md` is selected before the
compatible `CLAUDE.md` fallback. Include the complete closed approval table,
rules 0.1–0.4, and a sixteen-row mandatory router. The router uses the native
`skill` tool and says that seeing metadata is not the same as loading the body.
The finished file must be at most 12,288 bytes. Do not shorten or omit any
required authority, mantra, coda, approval, routing, or loading semantic to fit
the bound; if the complete contract does not fit, stop and revise the design.

- [ ] **Step 5: Build all sixteen native skills with complete rule bodies**

Enumerate each source inventory directly from its pinned tree, then inspect
each listed file with `git show`:

```sh
claude_repo=${CLAUDE_PLAYBOOK_SOURCE_REPO:-/Users/Michel.Abboud/projects/claude-code-playbook}
claude_sha=5db68e347a65e511cc378b0598a6aac6655845bd
codex_repo=${CODEX_PLAYBOOK_SOURCE_REPO:-/Users/Michel.Abboud/.config/superpowers/worktrees/codex-playbook/fix-modular-rule-parity}
codex_sha=b79080ad6f3f9605b60d4722265a5d271ea2e540
git -C "$claude_repo" ls-tree -r --name-only "$claude_sha" -- rules
git -C "$codex_repo" ls-tree -r --name-only "$codex_sha" -- .agents/skills
git -C "$claude_repo" show "${claude_sha}:rules/CODE.md"
git -C "$codex_repo" show \
  "${codex_sha}:.agents/skills/codex-playbook-code/SKILL.md"
```

Repeat the pinned `git show` form for every path returned by the two pinned
`ls-tree` inventories. Use the Codex skill objects as the delivery baseline and
the Claude rule objects as the canonical doctrine. Write every OpenCode skill
with `apply_patch`; never `cp`, redirect, or read from a source checkout path.
Make only these mechanical adaptations:

```text
codex-playbook-*                 -> opencode-playbook-*
.agents/skills/                  -> .opencode/skills/ in the repository
$HOME/.agents/skills/           -> <resolved OpenCode root>/skills/ when installed
Codex product/self-update source -> OpenCode and nice-michel/opencode-playbook
Codex-specific tool wording      -> OpenCode native skill/task/tool wording
fixed model product names        -> available OpenCode capability tiers
```

Do not shorten the rule bodies. Preserve the review ladder, version allocation,
five-part close-out, dependency vetting, quarantine manifest, destructive
command separation, environment safeguards, subagent escalation, platform
commands, and writing pre-send check. Each skill begins with exactly this
frontmatter shape, using its own folder name and a specific trigger sentence:

```yaml
---
name: opencode-playbook-code
description: Apply OpenCode Playbook code rules 1.1-1.6 before writing or changing code, and perform mandatory live dependency vetting before adding or major-updating a direct dependency.
---
```

All other descriptions are the mature Codex descriptions with only the product
name changed and with OpenCode-native trigger wording where the client action
differs. Keep each description on one line and each name under 64 characters.

- [ ] **Step 6: Write the human parity matrix**

Create `docs/reports/2026-09-17-rule-parity-matrix.md` with one row per unique
rule ID. Each row records Claude owner, OpenCode owner, disposition
`preserved` or `mechanically adapted`, and the exact adaptation reason. Include
all five mantra principles and the coda in a separate table because they are
governing doctrine but not numbered rule IDs. State that rule 11.1 has three
platform implementations and no other rule has multiple owners. Derive source
wording and ownership only through the pinned `git show` and `git ls-tree`
commands from Steps 1 and 5.

- [ ] **Step 7: Run the contract to GREEN and update current architecture docs**

Run:

```sh
./tests/rulebook_test.sh
git diff --check
```

Expected GREEN result: the suite reports all rulebook assertions passed, all 49
unique IDs are owned, the exact sixteen skills validate, and `git diff --check`
prints nothing.

Update `README.md` and `ARCHITECTURE.md` to describe the implemented lean router
and sixteen skills without claiming installer or runtime completion. Record the
task in `PROGRESS.md`, `CHANGELOG.md`, and `PLAN.md`. Change `VERSION` to the
bare line `0.0.2` and update the router's version carrier to match.

- [ ] **Step 8: Commit the candidate, complete two-stage review, then tag and push the approved tip**

Run:

```sh
test "$(cat VERSION)" = 0.0.2
git diff --check
./tests/rulebook_test.sh
task1_allowed_paths='.opencode/skills/opencode-playbook-code/SKILL.md
.opencode/skills/opencode-playbook-collaboration/SKILL.md
.opencode/skills/opencode-playbook-destructive/SKILL.md
.opencode/skills/opencode-playbook-documentation/SKILL.md
.opencode/skills/opencode-playbook-environment/SKILL.md
.opencode/skills/opencode-playbook-platform-linux/SKILL.md
.opencode/skills/opencode-playbook-platform-macos/SKILL.md
.opencode/skills/opencode-playbook-platform-windows/SKILL.md
.opencode/skills/opencode-playbook-quarantine/SKILL.md
.opencode/skills/opencode-playbook-repository/SKILL.md
.opencode/skills/opencode-playbook-reviews/SKILL.md
.opencode/skills/opencode-playbook-self-update/SKILL.md
.opencode/skills/opencode-playbook-subagents/SKILL.md
.opencode/skills/opencode-playbook-testing/SKILL.md
.opencode/skills/opencode-playbook-workflow/SKILL.md
.opencode/skills/opencode-playbook-writing/SKILL.md
AGENTS.md
ARCHITECTURE.md
BACKLOG.md
CHANGELOG.md
PLAN.md
PROGRESS.md
README.md
VERSION
config/managed-skills.txt
config/rule-manifest.tsv
docs/reports/2026-09-17-rule-parity-matrix.md
tests/rulebook_test.sh'
expected_task1_paths=$(git status --porcelain=v1 -uall | awk '
  index($0, " -> ") { exit 2 }
  { print substr($0, 4) }
' | LC_ALL=C sort -u)
test -n "$expected_task1_paths"
for path in $expected_task1_paths
do
  printf '%s\n' "$task1_allowed_paths" | grep -Fqx "$path"
done
git add -- $expected_task1_paths
git diff --cached --name-status
test "$(git diff --cached --name-only | LC_ALL=C sort -u)" = "$expected_task1_paths"
git diff --cached --check
test -z "$(git diff --name-only)"
test -z "$(git ls-files --others --exclude-standard)"
git commit -m "feat: establish complete OpenCode rule parity"
```

Dispatch a fresh specification reviewer against Task 1 and the corrective
design, then a separate quality reviewer against the exact candidate commit.
Give both reviewers the pinned commit, tree, and key-blob identifiers. Any
source comparison must use the same direct `git show` and `git ls-tree` forms,
never either source checkout.
Resolve each confirmed finding in a focused review-fix commit and repeat both
reviews until the tip is approved.

Run final verification and create the immutable checkpoint only afterward:

```sh
./tests/rulebook_test.sh
git diff --check
test -z "$(git status --short)"
test -z "$(git tag -l checkpoint/0.0.2)"
test -z "$(git ls-remote --tags origin refs/tags/checkpoint/0.0.2 'refs/tags/checkpoint/0.0.2^{}')"
approved_tip=$(git rev-parse HEAD)
git tag -a checkpoint/0.0.2 -m "OpenCode Playbook checkpoint 0.0.2"
test "$(git rev-parse 'checkpoint/0.0.2^{}')" = "$approved_tip"
git push origin feature/modular-opencode-release
git push origin checkpoint/0.0.2
```

Expected: the candidate and any logical review-fix commits are preserved, the
annotated checkpoint points to the reviewed tip, and both branch and tag are
remote before Task 2. No temporary source copy exists and neither source
repository was modified.

### Task 2: Implement safe install and restore transactions test-first

**Checkpoint version:** `0.0.3`

**Required skills:** test-driven development, systematic debugging for any
failure, and verification before completion.

**Files:**
- Create: `scripts/lib.sh`
- Create: `scripts/install.sh`
- Create: `scripts/restore.sh`
- Create: `tests/install_test.sh`
- Create: `INSTALL.md`
- Modify: `tests/rulebook_test.sh`
- Modify: `ARCHITECTURE.md`
- Modify: `README.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`
- Modify: `PLAN.md`
- Modify: `VERSION`
- Modify: `AGENTS.md`

- [ ] **Step 1: Write the lifecycle harness before transaction code**

Port the behavioral structure of the mature Codex `tests/install_test.sh`, but
do not perform blind name substitution. Use a new private directory from
`mktemp -d` for every case, an explicit cleanup trap limited to that root, and
assertion helpers that print `PASS` or `FAIL` plus a final count.

The selected raw root in every assertion follows this precedence before the
shared helper physically normalizes it:

```sh
repo_root=$(pwd -P)
. "$repo_root/scripts/lib.sh"
input_home=${HOME:?HOME must be set}
input_xdg_config_home=${XDG_CONFIG_HOME-}
input_opencode_config_dir=${OPENCODE_CONFIG_DIR-}
if test -n "$input_opencode_config_dir"
then
  raw_opencode_root=$input_opencode_config_dir
elif test -n "$input_xdg_config_home"
then
  raw_opencode_root=$input_xdg_config_home/opencode
else
  raw_opencode_root=$input_home/.config/opencode
fi
opencode_config_dir=$(physical_normalize_root "$raw_opencode_root")
skills_root=$opencode_config_dir/skills
```

Cover the complete matrix below:

```text
first install and exact restore
reinstall and unique immutable checkpoints
HOME/.config fallback
XDG_CONFIG_HOME relocation
non-empty OPENCODE_CONFIG_DIR relocation
empty OPENCODE_CONFIG_DIR treated as unset
different AGENTS.md refusal
explicit --replace-agents replacement
all sixteen skills installed exactly
unrelated global skill preserved
opencode.json and opencode.jsonc preserved byte-for-byte
unrelated auth/provider/plugin/session fixtures preserved
incomplete source checkout refusal
invalid, duplicate, or unsorted inventory refusal
relative active HOME, XDG_CONFIG_HOME, and OPENCODE_CONFIG_DIR refusal
inactive relative XDG_CONFIG_HOME ignored with active absolute OPENCODE_CONFIG_DIR
`.` or `..` traversal component refusal
OS-managed ancestor alias accepted and physically canonicalized
selected configuration-root symlink refusal
symlinked skills root refusal
symlinked backup root refusal
symlinked transaction root or lock refusal
symlinked AGENTS.md refusal
symlinked managed skill refusal
symlinked source or nested source resource refusal
special-file source or managed target refusal
exact format-2 manifest and COMPLETE marker
unknown, duplicate, missing, malformed, or out-of-order manifest line refusal
present state without payload refusal
absent state with payload refusal
unknown checkpoint payload refusal
checkpoint, manifest, marker, or nested resource symlink refusal
checkpoint outside the resolved backup root refusal
checkpoint name refusal
concurrent install refusal
concurrent restore refusal
two lexical aliases to one physical root share one lock and backup namespace
stale-lock safe diagnosis without automatic theft
cleanup warning without state corruption
exact selected root propagated into automatic restore
```

Add named failure or signal cases for these exact events:

```text
install.backup.agents
install.backup.skill
install.complete
install.stage.agents
install.stage.skill
install.allocate.previous
install.preserve.agents
install.activate.agents
install.preserve.skill
install.activate.skill
install.verify
install.rollback
install.cleanup
restore.backup.agents
restore.backup.skill
restore.complete
restore.stage.agents
restore.stage.skill
restore.allocate.previous
restore.preserve.agents
restore.activate.agents
restore.preserve.skill
restore.activate.skill
restore.verify
restore.rollback
restore.cleanup
```

For every pre-move failure, assert the original state is byte-identical. For
every post-move failure or `HUP`, `INT`, and `TERM`, assert either verified
automatic recovery or an explicit non-zero incomplete-recovery message naming
the durable checkpoint. Synchronization events must pause one transaction long
enough for a second process to prove the lock refusal, then release it without
a timing race.

- [ ] **Step 2: Run the lifecycle suite and prove RED for the intended reason**

Run:

```sh
chmod +x tests/install_test.sh
sh -n tests/install_test.sh
dash -n tests/install_test.sh
./tests/install_test.sh
```

Expected RED result: both syntax checks pass and the first implementation case
fails because `scripts/install.sh` and `scripts/restore.sh` are absent. No test
may reach a path outside its private case root.

- [ ] **Step 3: Implement shared validation and exact checkpoint parsing**

Create `scripts/lib.sh` with POSIX functions for fatal errors, lexical active
root selection, portable physical normalization, real-directory and
regular-file validation, nested resource walks, inventory parsing, exact
format-2 manifest generation and validation, checkpoint validation, lock
acquisition/handoff, owned-lock release, test events, and verified copy
comparison.

Validate the active raw root as absolute with no `.` or `..` components before
filesystem access. Reject a symlink at that selected root. Walk upward to the
longest existing ancestor, resolve that ancestor with `cd -P`, append only the
validated missing suffix, create the root, and require `cd -P` on the result to
equal the computed physical root. Permit OS-managed aliases only above the
selected root. Use the resulting physical root for every control path, lock
record, checkpoint parent comparison, restore comparison, and emitted root.
Inactive configuration variables do not participate in validation.

The checkpoint manifest grammar is exactly:

```text
format=2
agents=<present|absent>
managed_skill=<sorted-name-1>
skill_<sorted_name_1_with_hyphens_as_underscores>=<present|absent>
...
managed_skill=<sorted-name-16>
skill_<sorted_name_16_with_hyphens_as_underscores>=<present|absent>
```

The completion file contains exactly `complete\n` and has nine bytes. Require
mode 0600 for both metadata files. Reject any top-level checkpoint entry not
implied by the schema and every nested symlink or special file.

The test seam is disabled unless
`OPENCODE_PLAYBOOK_TEST_MODE=1`. It accepts only the named events above through
`OPENCODE_PLAYBOOK_TEST_FAIL_AT`, `OPENCODE_PLAYBOOK_TEST_SIGNAL_AT`, or
`OPENCODE_PLAYBOOK_TEST_BLOCK_AT`; production calls with any hook variable but
without test mode fail closed rather than silently enabling fault behavior.

- [ ] **Step 4: Implement the installer transaction**

Create `scripts/install.sh` with `--replace-agents` as its only mutating option.
It must:

1. resolve and validate the exact root;
2. acquire the atomic private lock;
3. validate `AGENTS.md`, `VERSION`, the inventory, restore command, and every
   nested skill source;
4. refuse a differing global agreement by default;
5. create and verify a unique pre-install format-2 checkpoint;
6. stage all seventeen replacements beneath
   `<root>/.opencode-playbook-transactions/`, never beneath `skills/`;
7. allocate all previous-state storage before a live move;
8. set a target's touched state before its first possible `mv`;
9. activate and compare every managed destination;
10. recover once through `restore.sh` on failure or handled signal; and
11. print installed version, resolved root, skill count, and checkpoint.

The rollback guard disables `HUP`, `INT`, and `TERM` while recovery is active
and rejects re-entry. Automatic restore receives the exact caller selection:

```sh
invoke_automatic_restore() {
  selected_home=$1
  selected_xdg_config_home=$2
  selected_opencode_root=$3
  caller_lock_token=$4
  caller_repo_root=$5
  caller_backup_dir=$6
  HOME="$selected_home" \
  XDG_CONFIG_HOME="$selected_xdg_config_home" \
  OPENCODE_CONFIG_DIR="$selected_opencode_root" \
  OPENCODE_PLAYBOOK_INTERNAL_LOCK_TOKEN="$caller_lock_token" \
    "$caller_repo_root/scripts/restore.sh" "$caller_backup_dir"
}
```

The internal token is accepted only when it exactly matches the private lock
owner record and the recorded root and operation are valid.

- [ ] **Step 5: Implement reversible restoration**

Create `scripts/restore.sh` accepting exactly one checkpoint argument. It must
validate the checkpoint before any managed write, create and verify a new
pre-restore checkpoint of current state, stage desired present payloads outside
`skills/`, preallocate previous-state storage, set touched markers before each
move, apply all present and absent postconditions, and compare the result.

On failure or handled signal, reinstate the pre-restore state once and verify
it. Retain both checkpoints. Cleanup removes only redundant transaction copies;
failure to remove one is a warning and never changes the verified outcome.
Restore must never infer a root from the checkpoint path or fall back to another
environment root.

- [ ] **Step 6: Run narrow syntax and lifecycle checks to GREEN**

Run:

```sh
chmod +x scripts/install.sh scripts/restore.sh
sh -n scripts/lib.sh scripts/install.sh scripts/restore.sh tests/install_test.sh
dash -n scripts/lib.sh scripts/install.sh scripts/restore.sh tests/install_test.sh
./tests/install_test.sh
./tests/rulebook_test.sh
git diff --check
```

Expected GREEN result: both shells accept every script, every lifecycle case
passes, the rulebook contract remains green, and the whitespace check is empty.
For any failure, use systematic debugging, add or strengthen the reproducing
assertion first, then fix the root cause.

- [ ] **Step 7: Document the exact install and recovery contract**

Write `INSTALL.md` with root resolution, preflight inspection, safe install,
explicit replacement, output interpretation, checkpoint schema, manual restore
using the same environment, update procedure, WSL boundary, unsupported native
Windows script boundary, and exact managed/non-managed sets. Document stale-lock
diagnosis without prescribing automatic deletion. Update `README.md` and
`ARCHITECTURE.md` only with behavior proven by the suite.

Record completion in `PROGRESS.md`, `CHANGELOG.md`, and `PLAN.md`. Change
`VERSION` and the router version carrier to `0.0.3`.

- [ ] **Step 8: Commit the candidate, complete two-stage review, then tag and push the approved tip**

Run:

```sh
test "$(cat VERSION)" = 0.0.3
./tests/install_test.sh
./tests/rulebook_test.sh
git diff --check
task2_allowed_paths='AGENTS.md
ARCHITECTURE.md
BACKLOG.md
CHANGELOG.md
INSTALL.md
PLAN.md
PROGRESS.md
README.md
VERSION
scripts/install.sh
scripts/lib.sh
scripts/restore.sh
tests/install_test.sh
tests/rulebook_test.sh'
expected_task2_paths=$(git status --porcelain=v1 -uall | awk '
  index($0, " -> ") { exit 2 }
  { print substr($0, 4) }
' | LC_ALL=C sort -u)
test -n "$expected_task2_paths"
for path in $expected_task2_paths
do
  printf '%s\n' "$task2_allowed_paths" | grep -Fqx "$path"
done
git add -- $expected_task2_paths
git diff --cached --name-status
test "$(git diff --cached --name-only | LC_ALL=C sort -u)" = "$expected_task2_paths"
git diff --cached --check
test -z "$(git diff --name-only)"
test -z "$(git ls-files --others --exclude-standard)"
git commit -m "feat: add lossless OpenCode installation"
```

A fresh specification reviewer challenges every Task 2 requirement. A separate
quality reviewer focuses on path canonicalization, schema ambiguity, lock
ownership, touched-before-move ordering, signal races, rollback re-entry,
failure hooks, and unrelated-state preservation. Resolve each confirmed finding
in a focused review-fix commit and re-run both reviews until approved.

Run final verification and publish only the approved tip:

```sh
./tests/install_test.sh
./tests/rulebook_test.sh
git diff --check
test -z "$(git status --short)"
test -z "$(git tag -l checkpoint/0.0.3)"
test -z "$(git ls-remote --tags origin refs/tags/checkpoint/0.0.3 'refs/tags/checkpoint/0.0.3^{}')"
approved_tip=$(git rev-parse HEAD)
git tag -a checkpoint/0.0.3 -m "OpenCode Playbook checkpoint 0.0.3"
test "$(git rev-parse 'checkpoint/0.0.3^{}')" = "$approved_tip"
git push origin feature/modular-opencode-release
git push origin checkpoint/0.0.3
```

Expected: the annotated checkpoint and remote feature branch both identify the
reviewed transaction tip before Task 3.

### Task 3: Prove isolated OpenCode discovery and add the repository verifier

**Checkpoint version:** `0.0.4`

**Required skills:** test-driven development, systematic debugging, and
verification before completion.

**Files:**
- Create: `tests/runtime_test.sh`
- Create: `scripts/parse_debug_skill.awk`
- Create: `tests/fixtures/debug-skill-valid.pretty.json`
- Create: `tests/fixtures/debug-skill-malformed.pretty.json`
- Create: `tests/fixtures/debug-skill-truncated.pretty.json`
- Create: `tests/fixtures/debug-skill-duplicate.pretty.json`
- Create: `tests/fixtures/debug-skill-escaped.pretty.json`
- Create: `tests/fixtures/debug-skill-nested.pretty.json`
- Create: `scripts/verify.sh`
- Create: `docs/reports/2026-09-17-opencode-1.18.31-compatibility.md`
- Modify: `tests/rulebook_test.sh`
- Modify: `INSTALL.md`
- Modify: `ARCHITECTURE.md`
- Modify: `README.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`
- Modify: `PLAN.md`
- Modify: `VERSION`
- Modify: `AGENTS.md`

- [ ] **Step 1: Write isolated runtime tests before the verifier**

Create executable `tests/runtime_test.sh` with modes `--discovery` and `--live`.
Reject unknown or combined modes. Capture the absolute OpenCode executable
before changing environment variables and require version `1.18.31`.

Each case creates and records one owned runtime root containing separate empty
`home`, `xdg-config`, `xdg-data`, `xdg-cache`, `xdg-state`, custom OpenCode
configuration, and workspace directories. Run every command from the case's
empty workspace. Every test-owned installer and OpenCode subprocess uses
`env -i` with only the case-specific allowlist; it never inherits the caller's
full environment. Maintain a creation ledger. Cleanup first performs a
separate read-only pass proving every ledger entry is beneath the owned root,
is not a symlink, and has the expected type; only then remove files one by one
and directories deepest-first with `rmdir`. Never use recursive deletion. If
validation or ordinary cleanup fails, leave the owned runtime root and report
its exact path.

The mode assignment is closed:

```text
--discovery: exact CLI version; sixteen exact skill tuples; additive XDG and
             explicit-root skills; XDG byte preservation; debug paths behavior
--live:      exact CLI version; custom-root global replacement; global and
             project participation plus project-over-global conflict result;
             local AGENTS over local CLAUDE fallback; installed mantra/coda and
             all sixteen advertised skills from an empty workspace
```

A probe may not be silently moved from `--live` to `--discovery` merely to
avoid provider access.

Use one `case_home` name consistently. Each global-only discovery case invokes
an implementation helper equivalent to this; all variables used by the block
are defined from its arguments:

```sh
run_discovery_probe() {
  case_home=$1
  opencode_bin=$2
  safe_path=$3
  case_xdg_config=$case_home/xdg-config
  case_xdg_data=$case_home/xdg-data
  case_xdg_cache=$case_home/xdg-cache
  case_xdg_state=$case_home/xdg-state
  case_custom=$case_home/opencode-config
  case_workspace=$case_home/workspace
  (
    cd "$case_workspace"
    env -i \
      PATH="$safe_path" LC_ALL=C LANG=C HOME="$case_home" \
      XDG_CONFIG_HOME="$case_xdg_config" \
      XDG_DATA_HOME="$case_xdg_data" \
      XDG_CACHE_HOME="$case_xdg_cache" \
      XDG_STATE_HOME="$case_xdg_state" \
      OPENCODE_CONFIG_DIR="$case_custom" \
      OPENCODE_DISABLE_PROJECT_CONFIG=1 \
      OPENCODE_DISABLE_EXTERNAL_SKILLS=1 \
      "$opencode_bin" debug skill --pure
  )
}
```

Never read or copy an auth file or provider configuration. The outer harness
may read only the one safely named credential from its environment as described
in Step 3, and only its piped value crosses into the clean child. Install into
`case_custom` with the same strict `env -i` roots used for every diagnostic.

Create `scripts/parse_debug_skill.awk` as a POSIX `awk` extractor for the stable
pretty JSON emitted by `opencode debug skill --pure`. It recognizes only
top-level `name`, `description`, and `location` string fields, emits exact TSV,
and fails closed on malformed/truncated objects, duplicate or missing relevant
fields, and any escape in a relevant value. It ignores unrelated well-formed
nested fields. Add valid, malformed, truncated, duplicate, escaped, and nested
fixtures and make `tests/runtime_test.sh --discovery` exercise every fixture
before invoking OpenCode. No `jq`, Python, Node, or new parser dependency is
allowed. For each inventory name, require one adjacent TSV tuple with exact
name, exact repository-frontmatter description, and exact location
`$case_custom/skills/$skill_name/SKILL.md`. Tolerate unrelated built-ins and
unrelated native XDG skills. Reject an extra namespaced playbook skill.

- [ ] **Step 2: Add the non-model discovery diagnostics**

Implement these independent cases:

1. Put a valid unrelated native skill in
   `$case_xdg/opencode/skills/xdg-additive-probe/SKILL.md`, then require debug
   output to contain that skill plus all sixteen custom-root playbook skills.
   Compare the XDG probe bytes before and after install to prove the installer
   did not manage it.
2. Run `opencode debug paths` with isolated XDG and custom roots. Require the
   reported `config` line to equal `$case_xdg/opencode`, not `$case_custom`,
   then require `debug skill --pure` in the same environment to find the custom
   skill paths. This proves `debug paths` is diagnostic context rather than
   discovery proof.

- [ ] **Step 3: Add all model-backed live instruction probes**

In `--live` mode, require
`OPENCODE_PLAYBOOK_TEST_MODEL=provider/model` and
`OPENCODE_PLAYBOOK_TEST_CREDENTIAL_VAR` naming the provider credential
environment variable. Require the credential name to match
`^[A-Za-z_][A-Za-z0-9_]*$`. Resolve it indirectly only after validation,
require a non-empty single-line value, never print it, and record only variable
name, `present=yes`, and length. Never read or copy any authentication file.

Implement the live launcher with the following data flow. Every variable used
inside the block is defined by the function arguments or locally. The secret is
piped to a clean child shell, never placed in process arguments. The child
exports exactly the validated dynamic credential, unsets the secret carrier,
and executes the captured absolute OpenCode binary. `env -i` omits
`OPENCODE_CONFIG`, `OPENCODE_CONFIG_CONTENT`, plugin/provider extras, and every
other inherited variable by construction:

```sh
run_live_probe() {
  case_home=$1
  opencode_bin=$2
  safe_path=$3
  selected_model=$4
  credential_name=$5
  project_config_mode=$6
  prompt=$7
  case "$credential_name" in
    ''|[!A-Za-z_]*|*[!A-Za-z0-9_]*) return 2 ;;
  esac
  case "$selected_model" in
    ''|/*|*/|*/*/*) return 2 ;;
    */*) ;;
  esac
  case "$project_config_mode" in
    global-only|project-aware) ;;
    *) return 2 ;;
  esac
  eval 'credential_value=${'"$credential_name"'-}'
  test -n "$credential_value" || return 2
  case "$credential_value" in
    *'
'*) unset credential_value; return 2 ;;
  esac
  credential_length=${#credential_value}
  printf 'credential name=%s present=yes length=%s\n' \
    "$credential_name" "$credential_length"
  case_xdg_config=$case_home/xdg-config
  case_xdg_data=$case_home/xdg-data
  case_xdg_cache=$case_home/xdg-cache
  case_xdg_state=$case_home/xdg-state
  case_custom=$case_home/opencode-config
  case_workspace=$case_home/workspace
  set -- env -i \
    PATH="$safe_path" LC_ALL=C LANG=C HOME="$case_home" \
    XDG_CONFIG_HOME="$case_xdg_config" \
    XDG_DATA_HOME="$case_xdg_data" \
    XDG_CACHE_HOME="$case_xdg_cache" \
    XDG_STATE_HOME="$case_xdg_state" \
    OPENCODE_CONFIG_DIR="$case_custom"
  if test "$project_config_mode" = global-only
  then
    set -- "$@" OPENCODE_DISABLE_PROJECT_CONFIG=1
  fi
  set -- "$@" \
    OPENCODE_DISABLE_EXTERNAL_SKILLS=1 \
    OPENCODE_PLAYBOOK_TEST_MODEL="$selected_model" \
    sh -c '
      credential_name=$1
      opencode_bin=$2
      case_workspace=$3
      prompt=$4
      IFS= read -r credential_value || exit 2
      test -n "$credential_value" || exit 2
      export "$credential_name=$credential_value"
      unset credential_value credential_name
      cd "$case_workspace" || exit 2
      exec "$opencode_bin" run --pure \
        --model "$OPENCODE_PLAYBOOK_TEST_MODEL" \
        --dir "$case_workspace" "$prompt"
    ' sh "$credential_name" "$opencode_bin" "$case_workspace" "$prompt"
  if printf '%s\n' "$credential_value" |
    "$@"
  then
    probe_status=0
  else
    probe_status=$?
  fi
  unset credential_value
  return "$probe_status"
}
```

Preflight the exact model through this helper with a unique
`MODEL_PREFLIGHT_6C2D` response contract before recording evidence; unavailable
model or credentials exit non-zero as `LIVE RUNTIME UNAVAILABLE`. Pass
`global-only` for that preflight so the clean child includes
`OPENCODE_DISABLE_PROJECT_CONFIG=1`.

Implement three isolated instruction cases before the final empty-workspace
inventory prompt. Every invocation includes
`--model "$OPENCODE_PLAYBOOK_TEST_MODEL"` and uses default text output with
unique markers rather than JSON:

1. Put marker `XDG_GLOBAL_MUST_NOT_LOAD_2A7C` in the XDG global
   `AGENTS.md`. Append `CUSTOM_GLOBAL_ACTIVE_5E9D` to the installed temporary
   custom-root agreement. Require the response to contain the custom marker and
   omit the XDG marker. The response tokens are directly observed; replacement
   of the XDG global instruction root is the documented inference.
2. Append a global contract requiring marker `GLOBAL_PARTICIPATED_7F3A` and
   conflict token `GLOBAL_CHOICE_91C2`. Create project `AGENTS.md` requiring
   marker `PROJECT_PARTICIPATED_4D8E` and overriding the conflict token with
   `PROJECT_CHOICE_B6A1`. Prompt for both participation markers and exactly one
   choice. Require both markers and the project choice, and reject the global
   choice. The tokens are directly observed; combined participation and project
   precedence are explicitly reported as inferences.
3. In a separate workspace, create local `AGENTS.md` with
   `NATIVE_LOCAL_SELECTED_83B4` and local `CLAUDE.md` with
   `FALLBACK_LOCAL_SELECTED_C19E`. Require the native marker and global custom
   marker, and reject the fallback marker. The response is directly observed;
   fallback selection is the documented inference.

The live-call matrix is closed:

| Probe | `project_config_mode` | Project-config environment |
|---|---|---|
| Model preflight | `global-only` | Set `OPENCODE_DISABLE_PROJECT_CONFIG=1` |
| Custom-root global replacement | `global-only` | Set `OPENCODE_DISABLE_PROJECT_CONFIG=1` |
| Global plus project conflict | `project-aware` | Omit `OPENCODE_DISABLE_PROJECT_CONFIG` entirely |
| Local `AGENTS.md` versus `CLAUDE.md` | `project-aware` | Omit `OPENCODE_DISABLE_PROJECT_CONFIG` entirely |
| Empty-workspace mantra and skill inventory | `global-only` | Set `OPENCODE_DISABLE_PROJECT_CONFIG=1` |

Then have `tests/runtime_test.sh` invoke its locally defined `run_live_probe`
with `global-only` from a fresh empty case home with the final prompt: “State
the active five-principle mantra and coda, then list every available
opencode-playbook skill by exact name. Do not modify files.”

Require successful exit, default text output, the motto phrase, all five
principle headings or faithful descriptions, the coda's independent-partner
meaning, and all sixteen exact skill names. If provider access is unavailable,
exit non-zero with `LIVE RUNTIME UNAVAILABLE`; never convert an unavailable
probe into a pass. Save sanitized output for the compatibility report without
capturing credentials, provider configuration, or unrelated session content.

- [ ] **Step 4: Run runtime tests and prove the first RED result**

Run:

```sh
chmod +x tests/runtime_test.sh
sh -n tests/runtime_test.sh
dash -n tests/runtime_test.sh
set +e
test -x scripts/verify.sh
red_status=$?
set -e
test "$red_status" -ne 0
printf 'expected RED: scripts/verify.sh is not executable (status=%s)\n' "$red_status"
```

Expected RED result: shell syntax checks pass and the captured executable check
is non-zero because `scripts/verify.sh` does not exist. Only after recording
that isolated RED result, run `./tests/runtime_test.sh --discovery` as a
separate command. It must either pass against the Task 2 installer or identify
a concrete runtime-contract defect to fix before the verifier is written. It
must never pass by loading project-local skills from the source checkout.

- [ ] **Step 5: Implement the repository verifier**

Create executable `scripts/verify.sh` with default and `--release` modes. The
default mode must check:

```text
required root and docs files are non-empty
VERSION is one bare semantic version
router version equals VERSION
exact sixteen-skill inventory and 49-rule manifest
rulebook suite passes
all shell files are executable where appropriate
sh -n and dash -n pass
lifecycle suite passes
OpenCode 1.18.31 discovery suite passes
all current relative Markdown links resolve
all visual local asset links resolve when the site exists
current public docs contain no Codex install path
current public docs contain no singular OpenCode skill destination
current public docs contain no 42-rule or three-skill product claim
tracked current text has no unfinished marker or trailing whitespace
```

`--release` runs every default check plus `tests/runtime_test.sh --live`, exact
release version checks, and site checks. Historical
2026-09-16 plans, specifications, reports, and changelog records are allowed to
describe the retired model only when clearly marked historical; the verifier
must not erase history to make a search pass.

- [ ] **Step 6: Run discovery and repository verification to GREEN**

Run:

```sh
chmod +x scripts/verify.sh
sh -n scripts/verify.sh tests/runtime_test.sh
dash -n scripts/verify.sh tests/runtime_test.sh
awk -f scripts/parse_debug_skill.awk tests/fixtures/debug-skill-valid.pretty.json
./tests/runtime_test.sh --discovery
./tests/runtime_test.sh --live
./scripts/verify.sh
git diff --check
```

Expected GREEN result: exact OpenCode 1.18.31 skill discovery, every model-backed
instruction probe, and all local repository checks pass. The explicit live run
occurs before any model-backed result is written to the compatibility report;
the release verifier repeats it later on the final candidate.

- [ ] **Step 7: Record compatibility evidence, review the candidate, then tag and push the approved tip**

Write `docs/reports/2026-09-17-opencode-1.18.31-compatibility.md` only after the
preceding `--live` command passes. Record exact CLI version, environment
isolation, selected model, provider credential variable name/presence/length
without its value, parser fixture results, parsed skill evidence, custom-global
replacement, additive skills, the conflicting global/project result, local
fallback, and `debug paths` results. For each row, distinguish directly
observed command/output tokens from the resulting replacement, composition, or
precedence inference. State
OpenCode v2 and all versions other than 1.18.31 are untested and unsupported
for 0.1.0.

Update current docs and set `VERSION` plus the router carrier to `0.0.4`. Run:

```sh
./scripts/verify.sh
test "$(cat VERSION)" = 0.0.4
git diff --check
task3_allowed_paths='AGENTS.md
ARCHITECTURE.md
BACKLOG.md
CHANGELOG.md
INSTALL.md
PLAN.md
PROGRESS.md
README.md
VERSION
docs/reports/2026-09-17-opencode-1.18.31-compatibility.md
scripts/parse_debug_skill.awk
scripts/verify.sh
tests/fixtures/debug-skill-duplicate.pretty.json
tests/fixtures/debug-skill-escaped.pretty.json
tests/fixtures/debug-skill-malformed.pretty.json
tests/fixtures/debug-skill-nested.pretty.json
tests/fixtures/debug-skill-truncated.pretty.json
tests/fixtures/debug-skill-valid.pretty.json
tests/rulebook_test.sh
tests/runtime_test.sh'
expected_task3_paths=$(git status --porcelain=v1 -uall | awk '
  index($0, " -> ") { exit 2 }
  { print substr($0, 4) }
' | LC_ALL=C sort -u)
test -n "$expected_task3_paths"
for path in $expected_task3_paths
do
  printf '%s\n' "$task3_allowed_paths" | grep -Fqx "$path"
done
git add -- $expected_task3_paths
git diff --cached --name-status
test "$(git diff --cached --name-only | LC_ALL=C sort -u)" = "$expected_task3_paths"
git diff --cached --check
test -z "$(git diff --name-only)"
test -z "$(git ls-files --others --exclude-standard)"
git commit -m "test: verify the OpenCode runtime contract"
```

A fresh specification reviewer checks every runtime requirement; a separate
quality reviewer challenges isolation leaks, permissive JSON matching,
unrelated-skill tolerance, false precedence conclusions, and support
overclaims. Resolve confirmed findings in focused review-fix commits and repeat
both reviews until approved.

Run final verification and publish the exact reviewed tip:

```sh
./tests/runtime_test.sh --discovery
./tests/runtime_test.sh --live
./scripts/verify.sh
git diff --check
test -z "$(git status --short)"
test -z "$(git tag -l checkpoint/0.0.4)"
test -z "$(git ls-remote --tags origin refs/tags/checkpoint/0.0.4 'refs/tags/checkpoint/0.0.4^{}')"
approved_tip=$(git rev-parse HEAD)
git tag -a checkpoint/0.0.4 -m "OpenCode Playbook checkpoint 0.0.4"
test "$(git rev-parse 'checkpoint/0.0.4^{}')" = "$approved_tip"
git push origin feature/modular-opencode-release
git push origin checkpoint/0.0.4
```

Expected: the remote branch and peeled checkpoint tag identify the reviewed
runtime-contract tip before Task 4.

### Task 4: Complete public, contributor, security, and operator documentation

**Checkpoint version:** `0.0.5`

**Required skills:** documentation and verification before completion.

**Files:**
- Modify: `BACKLOG.md`
- Modify: `CONTRIBUTING.md`
- Modify: `SECURITY.md`
- Modify: `HANDOFF.md`
- Modify: `README.md`
- Modify: `INSTALL.md`
- Modify: `ARCHITECTURE.md`
- Modify: `docs/guides/README.md`
- Modify: `docs/reports/README.md`
- Modify: `docs/handoffs/README.md`
- Preserve unchanged: `docs/handoffs/2026-09-16-prototype-handoff.md`
- Create: `docs/ideas/README.md`
- Create: `docs/reviews/README.md`
- Create: `docs/runbooks/README.md`
- Create: `docs/runbooks/github-pages.md`
- Create: `docs/guides/open-code-1.18.31-runtime-verification.md`
- Annotate as historical: `docs/superpowers/specs/2026-09-16-opencode-playbook-initial-release-design.md`
- Annotate as historical: `docs/superpowers/plans/2026-09-16-opencode-playbook-initial-release.md`
- Annotate as historical: `docs/reports/2026-09-16-source-adaptation.md`
- Modify: `tests/rulebook_test.sh`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`
- Modify: `PLAN.md`
- Modify: `VERSION`
- Modify: `AGENTS.md`

- [ ] **Step 1: Extend documentation checks and prove RED**

Add required-file, required-directory-index, current-link, support-boundary,
managed-write-set, and current-architecture assertions to
`tests/rulebook_test.sh`. Require `README.md`, `PROGRESS.md`, `CHANGELOG.md`,
`ARCHITECTURE.md`, `LICENSE`, `VERSION`, `PLAN.md`, `BACKLOG.md`, `INSTALL.md`,
`CONTRIBUTING.md`, and `SECURITY.md`. Require indexed `docs/guides`,
`docs/reports`, `docs/plans`, `docs/adr`, `docs/handoffs`, `docs/reviews`,
`docs/ideas`, and `docs/runbooks`.

Run:

```sh
./tests/rulebook_test.sh
```

Expected RED result: the contract fails on the missing required root records
and directory indexes, not on the already-green rule corpus.

- [ ] **Step 2: Write the public product and installation narrative**

Make `README.md` lead with the motto and explain first-person language, all 49
rules, the five principles and coda, lean router, sixteen native skills,
supported OpenCode version, safe install command, managed boundary, visual site,
version, and license. Do not say the Pages site or public release exists until
Tasks 5 and 8 make those statements true.

Keep `INSTALL.md` executable by a new operator. Include exact preflight,
install, replacement, verification, restore, update, environment, checkpoint,
stale-lock, WSL, and support-limit commands. Make the custom-root examples pass
the same `HOME`, `XDG_CONFIG_HOME`, and `OPENCODE_CONFIG_DIR` to install,
diagnostics, runtime, and restore.

- [ ] **Step 3: Complete contributor, security, handoff, and backlog records**

Write `CONTRIBUTING.md` with branch, TDD, two-stage review, docs, version,
checkpoint, and no-history-rewrite rules. Write `SECURITY.md` with supported
version, private vulnerability reporting path, no public issue for an
unpatched vulnerability, expected report content, and response scope.

Keep `BACKLOG.md` limited to genuine post-0.1.0 ideas and no deferred release
requirement. Before changing root `HANDOFF.md`, verify that the prototype text
already preserved at `docs/handoffs/2026-09-16-prototype-handoff.md` is
byte-for-byte unchanged from the reviewed 0.0.1 checkpoint. Then update root
`HANDOFF.md` as a durable resumption document: label dated observations as
historical snapshots, give exact read-only commands for branch, version,
checkpoint, remote, PR, release, Pages, worktree, and process discovery, and
define the invariant that selects the next unsatisfied plan gate. Do not encode
guaranteed-stale “next task”, “not yet”, or mutable remote-state assertions.
Never rewrite or delete the dated historical handoff.

- [ ] **Step 4: Build the documentation indexes and runbooks**

Index every current and historical artifact accurately. The GitHub Pages
runbook covers service, publish, REST verification, rollback through a new
commit, incident diagnosis, and health checks. The OpenCode runtime guide gives
the exact isolated environment and explains why `debug paths` cannot prove the
effective custom global instruction root.

Add one explicit `Status: Superseded historical input` notice to each listed
2026-09-16 artifact without rewriting its historical body. Point each notice
to the corrective specification and plan.

- [ ] **Step 5: Run documentation contracts to GREEN**

Run:

```sh
./tests/rulebook_test.sh
./scripts/verify.sh
git diff --check
git diff --exit-code checkpoint/0.0.1 -- docs/handoffs/2026-09-16-prototype-handoff.md
```

Expected GREEN result: all required current docs exist and link correctly,
historical files remain present and clearly labeled, and no current document
claims the retired 42-rule or three-skill architecture.

- [ ] **Step 6: Version and commit the candidate, then review, tag, and push the approved tip**

Set `VERSION` and the router carrier to `0.0.5`; update `PROGRESS.md`,
`CHANGELOG.md`, and `PLAN.md`. Run:

```sh
./scripts/verify.sh
test "$(cat VERSION)" = 0.0.5
git diff --check
task4_allowed_paths='AGENTS.md
ARCHITECTURE.md
BACKLOG.md
CHANGELOG.md
CONTRIBUTING.md
HANDOFF.md
INSTALL.md
PLAN.md
PROGRESS.md
README.md
SECURITY.md
VERSION
docs/guides/README.md
docs/guides/open-code-1.18.31-runtime-verification.md
docs/handoffs/README.md
docs/ideas/README.md
docs/reports/2026-09-16-source-adaptation.md
docs/reports/README.md
docs/reviews/README.md
docs/runbooks/README.md
docs/runbooks/github-pages.md
docs/superpowers/plans/2026-09-16-opencode-playbook-initial-release.md
docs/superpowers/specs/2026-09-16-opencode-playbook-initial-release-design.md
tests/rulebook_test.sh'
expected_task4_paths=$(git status --porcelain=v1 -uall | awk '
  index($0, " -> ") { exit 2 }
  { print substr($0, 4) }
' | LC_ALL=C sort -u)
test -n "$expected_task4_paths"
for path in $expected_task4_paths
do
  printf '%s\n' "$task4_allowed_paths" | grep -Fqx "$path"
done
git add -- $expected_task4_paths
git diff --cached --name-status
test "$(git diff --cached --name-only | LC_ALL=C sort -u)" = "$expected_task4_paths"
git diff --cached --check
test -z "$(git diff --name-only)"
test -z "$(git ls-files --others --exclude-standard)"
git commit -m "docs: complete OpenCode Playbook guidance"
```

A fresh specification reviewer verifies coverage and historical labeling; a
separate quality reviewer checks commands, links, support claims, security
reporting, terminology, and contradictions. Resolve confirmed findings in
focused review-fix commits and repeat both reviews until approved.

Run final verification and publish the reviewed documentation tip:

```sh
./tests/rulebook_test.sh
./scripts/verify.sh
git diff --check
test -z "$(git status --short)"
test -z "$(git tag -l checkpoint/0.0.5)"
test -z "$(git ls-remote --tags origin refs/tags/checkpoint/0.0.5 'refs/tags/checkpoint/0.0.5^{}')"
approved_tip=$(git rev-parse HEAD)
git tag -a checkpoint/0.0.5 -m "OpenCode Playbook checkpoint 0.0.5"
test "$(git rev-parse 'checkpoint/0.0.5^{}')" = "$approved_tip"
git push origin feature/modular-opencode-release
git push origin checkpoint/0.0.5
```

Expected: the remote branch and annotated checkpoint identify the approved
documentation tip before Task 5.

### Task 5: Build the distinct accessible visual playbook

**Checkpoint version:** `0.0.6`

**Required skills in order:** imagegen, frontend-skill, playwright, then
verification before completion.

**Files:**
- Create: `docs/.nojekyll`
- Create: `docs/assets/opencode-playbook-hero.png`
- Create: `docs/index.html`
- Create: `docs/reviews/2026-09-17-visual-browser-qa.md`
- Modify: `tests/rulebook_test.sh`
- Modify: `scripts/verify.sh`
- Modify: `README.md`
- Modify: `docs/runbooks/github-pages.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`
- Modify: `PLAN.md`
- Modify: `VERSION`
- Modify: `AGENTS.md`

- [ ] **Step 1: Add visual contract checks and prove RED**

Extend `tests/rulebook_test.sh` and `scripts/verify.sh` to require a non-empty
hero PNG, empty regular `docs/.nojekyll`, one `docs/index.html` entry point with
inline CSS/JavaScript and local assets,
the normalized complete literal text of all five mantra principles and coda,
all 49 unique rule IDs, all thirteen section labels, all sixteen skill names,
semantic landmarks, a skip link, visible-focus CSS,
`prefers-reduced-motion`, useful hero alternative text, static rule content
without JavaScript, no remote font/script/style URL, and no analytics or
cookies. Put each complete visible mantra paragraph in a plain element marked
`data-mantra="1"` through `data-mantra="5"` and `data-mantra="coda"`; the test
extracts and compares those values to the independent literal fixtures already
used for `AGENTS.md`. A matching heading with shortened body text must fail.

Run:

```sh
./tests/rulebook_test.sh
```

Expected RED result: the new visual assertions fail because the site and hero
are not present.

- [ ] **Step 2: Generate and inspect the original hero**

Use the image generation skill with this art direction:

```text
Editorial screen-print and gouache illustration for an OpenCode engineering
playbook. An open, transparent workbench exposes instruction sheets moving
through an understandable mechanical process into a precise stack of completed
work. A calm human collaborator inspects the mechanism. No readable text, no
logos, no robot, no neon, no generic futuristic dashboard. Matte ivory, deep
ink, one distinctive green-teal accent, subtle brass details, generous negative
space, landscape composition for a refined documentation hero. Original visual
identity, clearly distinct from the Claude and Codex playbook heroes.
```

Save only the accepted raster to
`docs/assets/opencode-playbook-hero.png`. Inspect it at original resolution and
reject unreadable pseudo-text, malformed hands or machinery, unwanted logos,
compression defects, and copied visual motifs.

- [ ] **Step 3: Build the semantic dependency-free site**

Use the frontend skill to create one `docs/index.html` with inline CSS and
progressive-enhancement JavaScript. Core HTML contains the hero, full visible
mantra and coda, approval model, searchable 49-rule map, thirteen sections,
sixteen-skill architecture, configuration-root behavior, install/restore flow,
support boundary, and repository links.

Implement keyboard-operable filtering, useful zero-results messaging, sticky
section navigation, active-section state, restrained entrance motion, and a
complete reduced-motion override. Use local assets only. At 200% zoom and
390-pixel width, content must not overlap or require horizontal page scrolling.

- [ ] **Step 4: Run structural checks to GREEN**

Run:

```sh
./tests/rulebook_test.sh
./scripts/verify.sh
git diff --check
```

Expected GREEN result: the visual contract finds every governing principle,
coda, rule, section, skill, accessibility hook, and local asset.

- [ ] **Step 5: Perform desktop, mobile, keyboard, and reduced-motion QA**

Use the Playwright skill against the local file URL so no server or port remains
running:

```sh
site_url="file://$(pwd)/docs/index.html"
```

Inspect at least 1440×1100 and 390×844. Exercise skip navigation, section links,
one exact rule search, one multi-result search, zero-result state, clear search,
Tab and Shift+Tab order, visible focus, reduced-motion emulation, image loading,
and mobile overflow. Require zero console errors and zero unexpected warnings.
Save evidence and exact observations in
`docs/reviews/2026-09-17-visual-browser-qa.md`; screenshots may remain
task-owned temporary evidence unless the report needs one to explain a defect.

- [ ] **Step 6: Version and commit the candidate, then review, tag, and push the approved tip**

Update README visual-site wording without claiming publication, record the
browser result, set `VERSION` and router carrier to `0.0.6`, and update current
status docs. Run:

```sh
./scripts/verify.sh
test "$(cat VERSION)" = 0.0.6
git diff --check
task5_allowed_paths='AGENTS.md
BACKLOG.md
CHANGELOG.md
PLAN.md
PROGRESS.md
README.md
VERSION
docs/.nojekyll
docs/assets/opencode-playbook-hero.png
docs/index.html
docs/reviews/2026-09-17-visual-browser-qa.md
docs/runbooks/github-pages.md
scripts/verify.sh
tests/rulebook_test.sh'
expected_task5_paths=$(git status --porcelain=v1 -uall | awk '
  index($0, " -> ") { exit 2 }
  { print substr($0, 4) }
' | LC_ALL=C sort -u)
test -n "$expected_task5_paths"
for path in $expected_task5_paths
do
  printf '%s\n' "$task5_allowed_paths" | grep -Fqx "$path"
done
git add -- $expected_task5_paths
git diff --cached --name-status
test "$(git diff --cached --name-only | LC_ALL=C sort -u)" = "$expected_task5_paths"
git diff --cached --check
test -z "$(git diff --name-only)"
test -z "$(git ls-files --others --exclude-standard)"
git commit -m "feat: add the OpenCode visual playbook"
```

A fresh specification reviewer checks content completeness; a separate quality
reviewer checks visual identity, semantics, accessibility, responsive behavior,
progressive enhancement, browser evidence, and public-link truthfulness.
Resolve confirmed findings in focused review-fix commits and repeat both reviews
until approved.

Run the structural and browser evidence checks again, then tag and push only the
approved tip:

```sh
./tests/rulebook_test.sh
./scripts/verify.sh
git diff --check
test -z "$(git status --short)"
test -z "$(git tag -l checkpoint/0.0.6)"
test -z "$(git ls-remote --tags origin refs/tags/checkpoint/0.0.6 'refs/tags/checkpoint/0.0.6^{}')"
approved_tip=$(git rev-parse HEAD)
git tag -a checkpoint/0.0.6 -m "OpenCode Playbook checkpoint 0.0.6"
test "$(git rev-parse 'checkpoint/0.0.6^{}')" = "$approved_tip"
git push origin feature/modular-opencode-release
git push origin checkpoint/0.0.6
```

Expected: the original art and tested site are preserved in the reviewed remote
tip and its immutable checkpoint before Task 6.

### Task 6: Run independent release-candidate reviews and close every finding

**Checkpoint version:** `0.0.7`

**Required skills:** requesting-code-review, systematic debugging for confirmed
defects, and verification before completion.

**Files:**
- Create: `docs/reviews/2026-09-17-corrective-release-specification.md`
- Create: `docs/reviews/2026-09-17-corrective-release-quality.md`
- Modify as findings require: rulebook, skills, manifests, scripts, tests,
  current docs, or site
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`
- Modify: `PLAN.md`
- Modify: `HANDOFF.md`
- Modify: `VERSION`
- Modify: `AGENTS.md`

- [ ] **Step 1: Establish a verified review baseline**

Run:

```sh
./tests/rulebook_test.sh
./tests/install_test.sh
./tests/runtime_test.sh --discovery
./scripts/verify.sh
sh -n scripts/*.sh tests/*.sh
dash -n scripts/*.sh tests/*.sh
git diff --check
git status --short
```

Expected: every implemented local check passes and the worktree is clean before
review dispatch.

- [ ] **Step 2: Dispatch a fresh specification review**

Give the reviewer the corrective specification, this plan, ADRs 0001 and 0002,
the pinned source commit/tree/blob identifiers, and the complete diff from the
planning checkpoint. If the reviewer needs source text or inventories, it uses
the exact Task 1 `git show` and `git ls-tree` forms against the pinned commits.
It never reads source checkout files. Do not provide implementation rationale
or prior review conclusions.

Require a requirement-by-requirement matrix covering all 49 rules, five
principles and coda, sixteen skills, exact OpenCode paths and precedence,
transaction invariants, runtime isolation, support boundary, current docs,
visual requirements, and publication readiness. Findings include severity,
confidence, file and line, violated requirement, and concrete failure.

- [ ] **Step 3: Dispatch an independent quality and trust-boundary review**

Use a separate strongest-capable reviewer that has not seen the specification
review. Ask it to assume the release fails on a real user machine and find how.
Focus on symlink or path escape, manifest ambiguity, lock races, signal timing,
rollback re-entry, touched ordering, root mismatch, unrelated-data loss,
permissive runtime parsing, false support claims, inaccessible content, and
publication command errors.

- [ ] **Step 4: Fix findings with regression-first evidence**

For every confirmed Critical or Important finding, add or strengthen the
failing assertion before the fix, run it to RED, implement the root-cause fix,
run the narrow check to GREEN, then rerun the full baseline. Commit each
confirmed product fix and its regression evidence as one focused review-fix
commit using an explicit path list and cached-diff inspection. Record confirmed,
rejected-with-evidence, and resolved findings in the two review files. Repeat
fresh review of substantive fixes until neither review has unresolved Critical
or Important findings.

- [ ] **Step 5: Commit the complete release-review candidate**

Set `VERSION` and router carrier to `0.0.7`; update status, changelog, plan, and
handoff with exact review evidence and durable state-discovery gates. Include the
two review records and every confirmed fix in the complete candidate. Run:

```sh
./scripts/verify.sh
test "$(cat VERSION)" = 0.0.7
git diff --check
task6_allowed_paths='AGENTS.md
BACKLOG.md
CHANGELOG.md
HANDOFF.md
PLAN.md
PROGRESS.md
VERSION
docs/reviews/2026-09-17-corrective-release-quality.md
docs/reviews/2026-09-17-corrective-release-specification.md'
expected_task6_paths=$(git status --porcelain=v1 -uall | awk '
  index($0, " -> ") { exit 2 }
  { print substr($0, 4) }
' | LC_ALL=C sort -u)
test -n "$expected_task6_paths"
for path in $expected_task6_paths
do
  printf '%s\n' "$task6_allowed_paths" | grep -Fqx "$path"
done
git add -- $expected_task6_paths
git diff --cached --name-status
test "$(git diff --cached --name-only | LC_ALL=C sort -u)" = "$expected_task6_paths"
git diff --cached --check
test -z "$(git diff --name-only)"
test -z "$(git ls-files --others --exclude-standard)"
git commit -m "fix: close OpenCode release review findings"
```

If the reviews require no product change, the commit contains the review
records and truthful status updates and uses message
`docs: record OpenCode release candidate reviews`.

- [ ] **Step 6: Review the exact candidate tip, verify it, then tag and push**

Dispatch a fresh specification reviewer against the exact complete candidate
commit, then a separate fresh quality and trust-boundary reviewer against that
same commit without seeing the first reviewer's conclusions. If either finds a
confirmed issue, add regression-first evidence, make focused product or record
fix commits, and repeat both reviews against the new exact tip. Status,
`VERSION`, handoff, and the review records are part of the reviewed tip; never
commit another tracked change after the final exact-tip approval.

Run the complete local baseline on that approved committed tip before making
it immutable:

```sh
./tests/rulebook_test.sh
./tests/install_test.sh
./tests/runtime_test.sh --discovery
./scripts/verify.sh
git diff --check
test -z "$(git status --short)"
test -z "$(git tag -l checkpoint/0.0.7)"
test -z "$(git ls-remote --tags origin refs/tags/checkpoint/0.0.7 'refs/tags/checkpoint/0.0.7^{}')"
approved_tip=$(git rev-parse HEAD)
git tag -a checkpoint/0.0.7 -m "OpenCode Playbook checkpoint 0.0.7"
test "$(git rev-parse 'checkpoint/0.0.7^{}')" = "$approved_tip"
git push origin feature/modular-opencode-release
git push origin checkpoint/0.0.7
```

Expected: the release-candidate review evidence, approved product tip, remote
branch, and peeled checkpoint tag all agree before Task 7.

### Task 7: Configure repository metadata, security, Pages, and the release pull request

**Checkpoint version:** `0.0.8`

**Required skills:** GitHub/publication workflow and verification before
completion.

**Files:**
- Create: `docs/reviews/2026-09-17-publication-configuration.md`
- Modify: `README.md`
- Modify: `SECURITY.md`
- Modify: `docs/runbooks/github-pages.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`
- Modify: `PLAN.md`
- Modify: `HANDOFF.md`
- Modify: `VERSION`
- Modify: `AGENTS.md`

- [ ] **Step 1: Verify the existing public repository, origin, and identity without exposing credentials**

Run:

```sh
gh auth status --hostname github.com
test "$(gh api user --jq .login)" = nice-michel
test "$(git remote get-url origin)" = https://github.com/nice-michel/opencode-playbook.git
test "$(gh repo view nice-michel/opencode-playbook --json visibility --jq .visibility)" = PUBLIC
test "$(gh repo view nice-michel/opencode-playbook --json defaultBranchRef --jq .defaultBranchRef.name)" = main
local_tip=$(git rev-parse HEAD)
remote_tip=$(git ls-remote origin refs/heads/feature/modular-opencode-release | awk '{print $1}')
test "$local_tip" = "$remote_tip"
```

Expected: GitHub authentication remains `nice-michel`, the approved public
repository and exact HTTPS `origin` already exist from the reviewed planning
checkpoint, and the feature branch is current through checkpoint 0.0.7. Never
print a token.

- [ ] **Step 2: Verify every earlier checkpoint was pushed at its own task closeout**

Run:

```sh
for checkpoint_version in 0.0.1 0.0.2 0.0.3 0.0.4 0.0.5 0.0.6 0.0.7
do
  local_checkpoint=$(git rev-parse "checkpoint/$checkpoint_version^{}")
  remote_checkpoint=$(git ls-remote origin "refs/tags/checkpoint/$checkpoint_version^{}" | awk '{print $1}')
  test -n "$remote_checkpoint"
  test "$local_checkpoint" = "$remote_checkpoint"
done
```

Expected: each immutable local checkpoint already has an equal peeled remote
tag. Task 7 does not collect or backfill tags from earlier tasks.

- [ ] **Step 3: Draft the publication record before repository-setting changes**

Create `docs/reviews/2026-09-17-publication-configuration.md` with the verified
GitHub identity and the intended owner, visibility, default branch, Pages
source, homepage, topics, vulnerability-reporting state, branch topology, and
pull-request target. The filename is a plan-lineage identifier; record the
actual UTC start and finish timestamps in its contents. Label every
not-yet-observed value `intended` rather than claiming it is live. This file
becomes the pull-request body after returned state replaces the intended
entries.

- [ ] **Step 4: Configure repository metadata and security through returned state**

Run:

```sh
gh repo edit nice-michel/opencode-playbook \
  --description "A production-grade OpenCode-native working agreement with 49 rules, safe installation, and progressive disclosure." \
  --homepage "https://nice-michel.github.io/opencode-playbook/" \
  --add-topic opencode \
  --add-topic ai-agents \
  --add-topic developer-tools \
  --add-topic agentic-coding
gh api --method PUT repos/nice-michel/opencode-playbook/private-vulnerability-reporting
test "$(gh api repos/nice-michel/opencode-playbook/private-vulnerability-reporting --jq .enabled)" = true
test "$(gh repo view nice-michel/opencode-playbook --json description --jq .description)" = "A production-grade OpenCode-native working agreement with 49 rules, safe installation, and progressive disclosure."
test "$(gh repo view nice-michel/opencode-playbook --json homepageUrl --jq .homepageUrl)" = https://nice-michel.github.io/opencode-playbook/
test "$(gh repo view nice-michel/opencode-playbook --json visibility --jq .visibility)" = PUBLIC
test "$(gh repo view nice-michel/opencode-playbook --json defaultBranchRef --jq .defaultBranchRef.name)" = main
```

Read `repositoryTopics` and require all four requested topics as a set, without
rejecting an unrelated owner-added topic. Expected: metadata and private
vulnerability reporting are verified from returned state rather than command
success alone.

- [ ] **Step 5: Configure and verify the Pages source**

Run:

```sh
gh api --method POST repos/nice-michel/opencode-playbook/pages \
  -f 'source[branch]=main' \
  -f 'source[path]=/docs'
test "$(gh api repos/nice-michel/opencode-playbook/pages --jq .source.branch)" = main
test "$(gh api repos/nice-michel/opencode-playbook/pages --jq .source.path)" = /docs
test "$(gh api repos/nice-michel/opencode-playbook/pages --jq .html_url)" = https://nice-michel.github.io/opencode-playbook/
```

Require the returned page object to report expected URL
`https://nice-michel.github.io/opencode-playbook/`. The old `main` may not yet
contain the finished site; health is a Task 8 gate after merge.

- [ ] **Step 6: Open the release pull request**

Run:

```sh
gh pr create \
  --repo nice-michel/opencode-playbook \
  --base main \
  --head feature/modular-opencode-release \
  --title "feat: publish OpenCode Playbook 0.1.0" \
  --body-file docs/reviews/2026-09-17-publication-configuration.md
gh pr view --repo nice-michel/opencode-playbook --json state,baseRefName,headRefName,url
```

Expected: one OPEN pull request from the exact feature branch to `main`.

- [ ] **Step 7: Record returned state and commit the publication candidate**

Update the publication record, README, security guide, runbook, progress,
changelog, plan, and handoff with returned GitHub and pull-request state. Set
`VERSION` and the router carrier to `0.0.8`; distinguish configured Pages from
post-merge site health.

Run:

```sh
./scripts/verify.sh
test "$(cat VERSION)" = 0.0.8
git diff --check
task7_allowed_paths='AGENTS.md
BACKLOG.md
CHANGELOG.md
HANDOFF.md
PLAN.md
PROGRESS.md
README.md
SECURITY.md
VERSION
docs/reviews/2026-09-17-publication-configuration.md
docs/runbooks/github-pages.md'
expected_task7_paths=$(git status --porcelain=v1 -uall | awk '
  index($0, " -> ") { exit 2 }
  { print substr($0, 4) }
' | LC_ALL=C sort -u)
test -n "$expected_task7_paths"
for path in $expected_task7_paths
do
  printf '%s\n' "$task7_allowed_paths" | grep -Fqx "$path"
done
git add -- $expected_task7_paths
git diff --cached --name-status
test "$(git diff --cached --name-only | LC_ALL=C sort -u)" = "$expected_task7_paths"
git diff --cached --check
test -z "$(git diff --name-only)"
test -z "$(git ls-files --others --exclude-standard)"
git commit -m "docs: configure OpenCode Playbook publication"
```

Dispatch a fresh specification review of Task 7 and a separate quality review
of ownership, visibility, remotes, branch topology, Pages source, private
vulnerability reporting, and PR metadata. Resolve and re-review every confirmed
finding in focused review-fix commits until the tip is approved.

- [ ] **Step 8: Verify, tag, and push the exact approved publication tip**

Run:

```sh
./scripts/verify.sh
test "$(cat VERSION)" = 0.0.8
git diff --check
test -z "$(git status --short)"
test -z "$(git tag -l checkpoint/0.0.8)"
test -z "$(git ls-remote --tags origin refs/tags/checkpoint/0.0.8 'refs/tags/checkpoint/0.0.8^{}')"
approved_tip=$(git rev-parse HEAD)
git tag -a checkpoint/0.0.8 -m "OpenCode Playbook checkpoint 0.0.8"
test "$(git rev-parse 'checkpoint/0.0.8^{}')" = "$approved_tip"
git push origin feature/modular-opencode-release
git push origin checkpoint/0.0.8
pr_number=$(gh pr view --repo nice-michel/opencode-playbook --json number --jq .number)
gh pr edit "$pr_number" --repo nice-michel/opencode-playbook \
  --body-file docs/reviews/2026-09-17-publication-configuration.md
expected_pr_body=$(cat docs/reviews/2026-09-17-publication-configuration.md)
expected_pr_url="https://github.com/nice-michel/opencode-playbook/pull/$pr_number"
test "$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook --json state --jq .state)" = OPEN
test "$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook --json baseRefName --jq .baseRefName)" = main
test "$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook --json headRefName --jq .headRefName)" = feature/modular-opencode-release
test "$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook --json headRefOid --jq .headRefOid)" = "$approved_tip"
test "$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook --json url --jq .url)" = "$expected_pr_url"
test "$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook --json body --jq .body)" = "$expected_pr_body"
```

Expected: the reviewed evidence is the Task 7 tip, its annotated checkpoint is
remote, and the open pull request has advanced to that exact branch commit with
the reviewed returned-state record as its exact body.

### Task 8: Run final release review, merge, audit, tag, release, and verify Pages

**Release version:** `0.1.0`

**Required skills:** requesting-code-review, verification before completion,
and finishing-a-development-branch.

**Files:**
- Create: `docs/reviews/2026-09-17-v0.1.0-release-evidence.md`
- Create: `docs/reviews/2026-09-17-v0.1.0-final-review.md`
- Modify as findings require: any release file
- Modify: `README.md`
- Modify: `PROGRESS.md`
- Modify: `CHANGELOG.md`
- Modify: `PLAN.md`
- Modify: `HANDOFF.md`
- Modify: `VERSION`
- Modify: `AGENTS.md`

- [ ] **Step 1: Allocate 0.1.0 and write browsable release evidence**

Capture execution time rather than treating the filename date as current time:

```sh
release_started_at_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)
release_date=$(date -u +%F)
```

Set `VERSION` and router carrier to exactly `0.1.0`. Move the Unreleased
changelog entries under `0.1.0 — $release_date`, where
`release_date` is the captured UTC date, mark the corrective plan complete
only where implementation evidence exists, and write release notes covering
behavior, installation, restore, supported OpenCode version, verification,
dependency surface, migration from the unpublished prototype, and known limits.

- [ ] **Step 2: Run the exact release suite including the live runtime**

Run:

```sh
./tests/rulebook_test.sh
./tests/install_test.sh
./tests/runtime_test.sh --discovery
./scripts/verify.sh --release
sh -n scripts/*.sh tests/*.sh
dash -n scripts/*.sh tests/*.sh
git diff --check
```

Expected: every command exits zero. `verify.sh --release` proves a live
OpenCode 1.18.31 empty-workspace session loaded the global mantra and all
sixteen exact skills. Record decisive assertion counts and exit statuses in the
release-evidence document.

- [ ] **Step 3: Record the no-dependency audit honestly**

Run:

```sh
tracked_dependency_files=$(git ls-files | awk '
  /(^|\/)(package\.json|package-lock\.json|npm-shrinkwrap\.json|yarn\.lock|pnpm-lock\.yaml|bun\.lock|bun\.lockb|deno\.json|deno\.jsonc|deno\.lock)$/ ||
  /(^|\/)(Cargo\.toml|Cargo\.lock)$/ ||
  /(^|\/)(pyproject\.toml|poetry\.lock|Pipfile|Pipfile\.lock|uv\.lock|setup\.py|setup\.cfg)$/ ||
  /(^|\/)requirements[^\/]*\.txt$/ ||
  /(^|\/)(go\.mod|go\.sum|vendor\/modules\.txt)$/ ||
  /(^|\/)(Gemfile|Gemfile\.lock)$/ || /\.gemspec$/ ||
  /(^|\/)(composer\.json|composer\.lock)$/ ||
  /(^|\/)(pom\.xml|build\.gradle|build\.gradle\.kts|settings\.gradle|settings\.gradle\.kts|gradle\.properties)$/ ||
  /(^|\/)(global\.json|nuget\.config|packages\.lock\.json)$/ ||
  /\.(csproj|fsproj|vbproj)$/ { print }
')
tracked_vendor_indicators=$(git ls-files | awk '
  /^\.gitmodules$/ || /(^|\/)(vendor|vendors|vendored|third_party|third-party|external|node_modules|deps)\// { print }
')
tracked_runtime_scripts=$(git ls-files |
  while IFS= read -r tracked_path
  do
    case "$tracked_path" in
      scripts/*|tests/*|*.sh|*.bash|*.zsh|*.fish|*.awk|*.py|*.rb|*.pl|*.php|*.ps1|*.psm1|*.psd1|*.js|*.mjs|*.cjs|*.jsx|*.ts|*.tsx|*.lua)
        printf '%s\n' "$tracked_path"
        continue
        ;;
    esac
    first_line=
    IFS= read -r first_line < "$tracked_path" || true
    case "$first_line" in
      '#!'*) printf '%s\n' "$tracked_path" ;;
    esac
  done | LC_ALL=C sort -u)
runtime_hook_matches=$(printf '%s\n' "$tracked_runtime_scripts" |
  while IFS= read -r runtime_script
  do
    test -n "$runtime_script" || continue
    grep -EnH '(^|[^A-Za-z])(curl|wget)([^A-Za-z]|$)|Invoke-WebRequest|Invoke-RestMethod|Start-BitsTransfer|(^|[[:space:]])(npm|pnpm|yarn|bun|pip|pip3|pipx|uv|poetry|cargo|gem|bundle|composer|go|nuget)[[:space:]]+(install|add|get)([[:space:]]|$)|python[0-9.]*[[:space:]]+-m[[:space:]]+pip[[:space:]]+install|dotnet[[:space:]]+(add[[:space:]].*[[:space:]]package|tool[[:space:]]+install)|(^|[[:space:]])(apt|apt-get|apk|dnf|yum|pacman|brew|port|choco|winget|scoop)[[:space:]]+(install|add)([[:space:]]|$)|(^|[[:space:]])(npx|bunx|corepack)([[:space:]]|$)|pnpm[[:space:]]+dlx|yarn[[:space:]]+dlx|deno[[:space:]]+run[[:space:]]+https?://|mvn[[:space:]].*dependency:get|https?://[^[:space:]]+[[:space:]]*\|[[:space:]]*(sh|bash|zsh|pwsh|powershell)' "$runtime_script" || true
  done)
printf 'dependency manifests/locks (%s):\n%s\n' \
  "$(printf '%s\n' "$tracked_dependency_files" | awk 'NF { count++ } END { print count + 0 }')" \
  "$tracked_dependency_files"
printf 'vendor/submodule indicators (%s):\n%s\n' \
  "$(printf '%s\n' "$tracked_vendor_indicators" | awk 'NF { count++ } END { print count + 0 }')" \
  "$tracked_vendor_indicators"
printf 'tracked runtime-consumed scripts (%s):\n%s\n' \
  "$(printf '%s\n' "$tracked_runtime_scripts" | awk 'NF { count++ } END { print count + 0 }')" \
  "$tracked_runtime_scripts"
printf 'unclassified network/install hooks (%s):\n%s\n' \
  "$(printf '%s\n' "$runtime_hook_matches" | awk 'NF { count++ } END { print count + 0 }')" \
  "$runtime_hook_matches"
test -z "$tracked_dependency_files"
test -z "$tracked_vendor_indicators"
test -z "$runtime_hook_matches"
```

Expected: manifest/lock, vendor/submodule, and unclassified hook counts are
zero; the runtime-script count records the complete inspected set, including
non-executable sourced helpers such as `scripts/lib.sh`. Record the commands,
counts, and exact path sets. Every hook match requires an explicit documented
classification and reviewer approval; an unclassified match blocks release.
If any dependency or vendor result appears, stop the zero-dependency path, identify
its ecosystem, run the real applicable audit (`npm audit`, `cargo audit`,
`pip-audit`, `govulncheck`, `bundle audit`, `composer audit`, Gradle/Maven
dependency or OWASP audit, or `dotnet list package --vulnerable`), investigate
vendored/submodule provenance and download hooks, and block release on a known
fixable CVE. OpenCode 1.18.31 is an externally installed supported client, not
a vendored repository dependency.

- [ ] **Step 4: Commit a bounded preliminary candidate, then run final reviews**

Create both evidence records with actual UTC start timestamps and current
observations, then commit the bounded preliminary release candidate before
dispatching reviewers:

```sh
preliminary_allowed_paths='AGENTS.md
BACKLOG.md
CHANGELOG.md
HANDOFF.md
PLAN.md
PROGRESS.md
README.md
VERSION
docs/reviews/2026-09-17-v0.1.0-final-review.md
docs/reviews/2026-09-17-v0.1.0-release-evidence.md'
expected_preliminary_paths=$(git status --porcelain=v1 -uall | awk '
  index($0, " -> ") { exit 2 }
  { print substr($0, 4) }
' | LC_ALL=C sort -u)
test -n "$expected_preliminary_paths"
for path in $expected_preliminary_paths
do
  printf '%s\n' "$preliminary_allowed_paths" | grep -Fqx "$path"
done
git add -- $expected_preliminary_paths
git diff --cached --name-status
test "$(git diff --cached --name-only | LC_ALL=C sort -u)" = \
  "$expected_preliminary_paths"
git diff --cached --check
test -z "$(git diff --name-only)"
test -z "$(git ls-files --others --exclude-standard)"
git commit -m "feat: prepare preliminary OpenCode Playbook v0.1.0 candidate"
```

Dispatch two fresh read-only reviewers that have not authored Task 8. One checks
the complete release against the corrective specification and plan. The other
performs an adversarial trust-boundary and publication review. Neither sees the
other's findings. Require file/line evidence, severity, confidence, and failure
scenario. Add regression coverage before every confirmed fix and rerun the full
release suite. Record all confirmed, rejected-with-evidence, and resolved
findings in `docs/reviews/2026-09-17-v0.1.0-final-review.md`; it has no unresolved
Critical or Important finding. Commit each confirmed product fix and regression
as a focused review-fix commit with an explicit reviewed path list, printed
`git diff --cached --name-status`, an exact cached-name comparison, and
`git diff --cached --check`. Repeat preliminary review of substantive fixes.

- [ ] **Step 5: Commit the complete release candidate**

Finalize the release evidence, review record, current status, and a durable
handoff that records actual UTC evidence timestamps and read-only commands for
rediscovering PR, merge, release, Pages, tag, worktree, and process state,
`BACKLOG.md`, version, and every product fix before committing. Run:

```sh
release_finished_at_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)
test "$(cat VERSION)" = 0.1.0
task8_final_allowed_paths='AGENTS.md
BACKLOG.md
CHANGELOG.md
HANDOFF.md
PLAN.md
PROGRESS.md
README.md
VERSION
docs/reviews/2026-09-17-v0.1.0-final-review.md
docs/reviews/2026-09-17-v0.1.0-release-evidence.md'
expected_task8_final_paths=$(git status --porcelain=v1 -uall | awk '
  index($0, " -> ") { exit 2 }
  { print substr($0, 4) }
' | LC_ALL=C sort -u)
test -n "$expected_task8_final_paths"
for path in $expected_task8_final_paths
do
  printf '%s\n' "$task8_final_allowed_paths" | grep -Fqx "$path"
done
git add -- $expected_task8_final_paths
git diff --cached --name-status
test "$(git diff --cached --name-only | LC_ALL=C sort -u)" = \
  "$expected_task8_final_paths"
git diff --cached --check
test -z "$(git diff --name-only)"
test -z "$(git ls-files --others --exclude-standard)"
git commit -m "feat: prepare OpenCode Playbook v0.1.0"
```

Expected: exact-tip reviewers receive a complete candidate commit rather than
an uncommitted author workspace or a tip missing its review/status records.

- [ ] **Step 6: Review the exact candidate tip, verify it, then tag and push it**

Dispatch a fresh specification reviewer against that exact complete candidate
commit, then a separate fresh adversarial quality reviewer against the same
commit without seeing the first reviewer's conclusions. If either finds a
confirmed issue, add regression-first evidence, make focused product or record
fix commits, and repeat both reviews against the new exact tip. The evidence,
review record, status, handoff, `BACKLOG.md`, and `VERSION` are all part of the
reviewed tip. Do not commit any tracked change after final exact-tip approval.

Run the release suite once more on that approved committed tip before creating
the checkpoint:

```sh
./tests/rulebook_test.sh
./tests/install_test.sh
./tests/runtime_test.sh --discovery
./scripts/verify.sh --release
sh -n scripts/*.sh tests/*.sh
dash -n scripts/*.sh tests/*.sh
git diff --check
test -z "$(git status --short)"
test "$(cat VERSION)" = 0.1.0
test -z "$(git tag -l checkpoint/0.1.0)"
test -z "$(git ls-remote --tags origin refs/tags/checkpoint/0.1.0 'refs/tags/checkpoint/0.1.0^{}')"
approved_tip=$(git rev-parse HEAD)
git tag -a checkpoint/0.1.0 -m "OpenCode Playbook release candidate 0.1.0"
test "$(git rev-parse 'checkpoint/0.1.0^{}')" = "$approved_tip"
git push origin feature/modular-opencode-release
git push origin checkpoint/0.1.0
```

Expected: the worktree is clean, the pull request contains the exact reviewed
tip, and the immutable release-candidate checkpoint is remote at that tip.

- [ ] **Step 7: Merge the approved pull request without rewriting history**

Run:

```sh
pr_number=$(gh pr view --repo nice-michel/opencode-playbook --json number --jq .number)
check_attempts=40
check_interval_seconds=15
check_attempt=1
while test "$check_attempt" -le "$check_attempts"
do
  check_count=$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook \
    --json statusCheckRollup --jq '.statusCheckRollup | length')
  test "$check_count" -ge 0
  if test "$check_count" -eq 0
  then
    printf 'verified zero configured PR checks\n'
    break
  fi
  failing_checks=$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook \
    --json statusCheckRollup --jq \
    '[.statusCheckRollup[] | select(((.conclusion // .state // "") == "FAILURE") or ((.conclusion // .state // "") == "ERROR") or ((.conclusion // .state // "") == "CANCELLED") or ((.conclusion // .state // "") == "TIMED_OUT") or ((.conclusion // .state // "") == "ACTION_REQUIRED"))] | length')
  test "$failing_checks" -eq 0
  pending_checks=$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook \
    --json statusCheckRollup --jq \
    '[.statusCheckRollup[] | select(((.status // .state // "") == "QUEUED") or ((.status // .state // "") == "IN_PROGRESS") or ((.status // .state // "") == "PENDING") or ((.status // .state // "") == "WAITING") or ((.status // .state // "") == "REQUESTED") or ((.status // .state // "") == "EXPECTED"))] | length')
  if test "$pending_checks" -eq 0
  then
    passing_checks=$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook \
      --json statusCheckRollup --jq \
      '[.statusCheckRollup[] | select(((.conclusion // .state // "") == "SUCCESS") or ((.conclusion // .state // "") == "NEUTRAL") or ((.conclusion // .state // "") == "SKIPPED"))] | length')
    test "$passing_checks" -eq "$check_count"
    break
  fi
  test "$check_attempt" -lt "$check_attempts"
  sleep "$check_interval_seconds"
  check_attempt=$((check_attempt + 1))
done
gh pr merge "$pr_number" --repo nice-michel/opencode-playbook --merge --delete-branch=false
git fetch origin main --tags
```

Expected: returned `statusCheckRollup` proves exactly zero checks or all checks
are completed with accepted passing conclusions. Pending checks wait for at
most 40 attempts at 15 seconds; any failure, unknown terminal conclusion, or
timeout blocks the merge. The PR then becomes MERGED and `origin/main` points
at a merge commit containing the reviewed release candidate.

- [ ] **Step 8: Synchronize the primary main worktree and create the annotated release tag**

Locate the existing main worktree without guessing its path:

```sh
primary_checkout=$(git worktree list --porcelain | awk '
  /^worktree / { path = substr($0, 10) }
  /^branch refs\/heads\/main$/ { print path; exit }
')
test -n "$primary_checkout"
test -z "$(git -C "$primary_checkout" status --short)"
git -C "$primary_checkout" pull --ff-only origin main
test "$(git -C "$primary_checkout" cat-file -t HEAD)" = commit
```

Create the tag on that exact merged commit:

```sh
primary_checkout=$(git worktree list --porcelain | awk '
  /^worktree / { path = substr($0, 10) }
  /^branch refs\/heads\/main$/ { print path; exit }
')
test -n "$primary_checkout"
release_version=$(cat "$primary_checkout/VERSION")
test "$release_version" = 0.1.0
test -z "$(git -C "$primary_checkout" tag -l "v$release_version")"
test -z "$(git -C "$primary_checkout" ls-remote --tags origin \
  "refs/tags/v$release_version" "refs/tags/v$release_version^{}")"
git -C "$primary_checkout" tag -a "v$release_version" -m "OpenCode Playbook v$release_version"
git -C "$primary_checkout" push origin "v$release_version"
```

Expected: annotated `v0.1.0` points to the local merged `main` commit and is
published once.

- [ ] **Step 9: Create the verified GitHub release**

Run from the primary main checkout:

```sh
primary_checkout=$(git worktree list --porcelain | awk '
  /^worktree / { path = substr($0, 10) }
  /^branch refs\/heads\/main$/ { print path; exit }
')
test -n "$primary_checkout"
gh release create v0.1.0 \
  --repo nice-michel/opencode-playbook \
  --verify-tag \
  --title "OpenCode Playbook v0.1.0" \
  --notes-file "$primary_checkout/docs/reviews/2026-09-17-v0.1.0-release-evidence.md"
test "$(gh release view v0.1.0 --repo nice-michel/opencode-playbook --json isDraft --jq .isDraft)" = false
test "$(gh release view v0.1.0 --repo nice-michel/opencode-playbook --json isPrerelease --jq .isPrerelease)" = false
test "$(gh release view v0.1.0 --repo nice-michel/opencode-playbook --json tagName --jq .tagName)" = v0.1.0
test "$(gh release view v0.1.0 --repo nice-michel/opencode-playbook --json targetCommitish --jq .targetCommitish)" = main
test "$(gh release view v0.1.0 --repo nice-michel/opencode-playbook --json url --jq .url)" = https://github.com/nice-michel/opencode-playbook/releases/tag/v0.1.0
```

Expected: a non-draft, non-prerelease GitHub release exists for exact tag
`v0.1.0`; `--verify-tag` confirms the tag was already remote.

- [ ] **Step 10: Verify SHA identity, repository security, and Pages health**

Run:

```sh
primary_checkout=$(git worktree list --porcelain | awk '
  /^worktree / { path = substr($0, 10) }
  /^branch refs\/heads\/main$/ { print path; exit }
')
test -n "$primary_checkout"
local_head=$(git -C "$primary_checkout" rev-parse HEAD)
remote_main=$(git -C "$primary_checkout" ls-remote origin refs/heads/main | awk '{print $1}')
peeled_tag=$(git -C "$primary_checkout" rev-parse 'v0.1.0^{}')
test "$local_head" = "$remote_main"
test "$local_head" = "$peeled_tag"
test "$(gh api user --jq .login)" = nice-michel
test "$(gh repo view nice-michel/opencode-playbook --json visibility --jq .visibility)" = PUBLIC
test "$(gh repo view nice-michel/opencode-playbook --json defaultBranchRef --jq .defaultBranchRef.name)" = main
test "$(gh repo view nice-michel/opencode-playbook --json homepageUrl --jq .homepageUrl)" = https://nice-michel.github.io/opencode-playbook/
test "$(gh repo view nice-michel/opencode-playbook --json description --jq .description)" = "A production-grade OpenCode-native working agreement with 49 rules, safe installation, and progressive disclosure."
for topic in opencode ai-agents developer-tools agentic-coding
do
  gh repo view nice-michel/opencode-playbook --json repositoryTopics \
    --jq '.repositoryTopics[].name' | grep -Fqx "$topic"
done
test "$(gh api repos/nice-michel/opencode-playbook/private-vulnerability-reporting --jq .enabled)" = true
test "$(gh api repos/nice-michel/opencode-playbook/pages --jq .source.branch)" = main
test "$(gh api repos/nice-michel/opencode-playbook/pages --jq .source.path)" = /docs
test "$(gh api repos/nice-michel/opencode-playbook/pages --jq .html_url)" = https://nice-michel.github.io/opencode-playbook/

pr_number=$(gh pr list --repo nice-michel/opencode-playbook --state merged \
  --head feature/modular-opencode-release --base main --json number --jq '.[0].number')
test -n "$pr_number"
test "$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook --json state --jq .state)" = MERGED
test "$(gh pr view "$pr_number" --repo nice-michel/opencode-playbook --json mergeCommit --jq .mergeCommit.oid)" = "$local_head"

test "$(gh release view v0.1.0 --repo nice-michel/opencode-playbook --json isDraft --jq .isDraft)" = false
test "$(gh release view v0.1.0 --repo nice-michel/opencode-playbook --json isPrerelease --jq .isPrerelease)" = false
test "$(gh release view v0.1.0 --repo nice-michel/opencode-playbook --json tagName --jq .tagName)" = v0.1.0
test "$(gh release view v0.1.0 --repo nice-michel/opencode-playbook --json targetCommitish --jq .targetCommitish)" = main

pages_attempts=30
pages_interval_seconds=10
pages_attempt=1
pages_status=
while test "$pages_attempt" -le "$pages_attempts"
do
  pages_status=$(gh api repos/nice-michel/opencode-playbook/pages/builds/latest --jq .status)
  case "$pages_status" in
    built) break ;;
    queued|building)
      test "$pages_attempt" -lt "$pages_attempts"
      sleep "$pages_interval_seconds"
      pages_attempt=$((pages_attempt + 1))
      ;;
    errored|cancelled) exit 1 ;;
    *) exit 1 ;;
  esac
done
test "$pages_status" = built

site_url=https://nice-michel.github.io/opencode-playbook/
hero_url=https://nice-michel.github.io/opencode-playbook/assets/opencode-playbook-hero.png
site_meta=$(curl --silent --show-error --location --max-redirs 5 \
  --connect-timeout 10 --max-time 30 --output /dev/null \
  --write-out '%{http_code}\t%{url_effective}\t%{num_redirects}' "$site_url")
test "$(printf '%s\n' "$site_meta" | cut -f1)" = 200
test "$(printf '%s\n' "$site_meta" | cut -f2)" = "$site_url"
test "$(printf '%s\n' "$site_meta" | cut -f3)" -le 5
site_body=$(curl --silent --show-error --fail --location --max-redirs 5 \
  --connect-timeout 10 --max-time 30 "$site_url")
printf '%s\n' "$site_body" | grep -Fq 'Do the right thing, not the lazy or easy thing.'
printf '%s\n' "$site_body" | grep -Fq 'data-mantra="coda"'
printf '%s\n' "$site_body" | grep -Fq 'opencode-playbook-writing'
printf '%s\n' "$site_body" | grep -Fq '12.4'

hero_meta=$(curl --silent --show-error --location --max-redirs 5 \
  --connect-timeout 10 --max-time 30 --output /dev/null \
  --write-out '%{http_code}\t%{url_effective}\t%{num_redirects}\t%{content_type}' "$hero_url")
test "$(printf '%s\n' "$hero_meta" | cut -f1)" = 200
test "$(printf '%s\n' "$hero_meta" | cut -f2)" = "$hero_url"
test "$(printf '%s\n' "$hero_meta" | cut -f3)" -le 5
test "$(printf '%s\n' "$hero_meta" | cut -f4)" = image/png

test -z "$(git -C "$primary_checkout" status --porcelain=v1 -uall)"
test -z "$(git status --porcelain=v1 -uall)"
```

Expected: Pages reaches the sole successful terminal state `built` within 30
attempts at 10 seconds; `errored`, `cancelled`, an unknown state, or timeout
fails. Both URLs follow at most five redirects to their exact final URL and
return HTTP 200, the hero is PNG, and the HTML contains the motto, coda, skill,
and final-rule markers. Repository, security, PR merge SHA, release fields,
SHA identity, and both clean worktrees are asserted from returned state. Also
verify and report that no project-owned long-running process remains.

- [ ] **Step 11: Deliver the five-part close-out report**

Report:

1. what was built;
2. verification evidence with exact counts, commands, SHA identity, Pages HTTP
   status, dependency audit result, and reviewer model ledger;
3. every assumption made;
4. concerns and observations, including unsupported OpenCode versions and any
   genuinely deferred post-release ideas; and
5. confirmation that current docs, `VERSION`, commits, checkpoint tags, merge,
   annotated release tag, push, GitHub release, Pages, security setting, and
   cleanup are complete.

Expected final state: `nice-michel/opencode-playbook` publicly serves the
verified 49-rule OpenCode Playbook 0.1.0, and local `HEAD`, remote `main`, and
peeled `v0.1.0` are the same commit.
