# Handoff

## Planning checkpoint contract

Version 0.0.1 records the approved corrective design and execution plan. It is
not evidence that implementation, publication, Pages, or release is currently
pending or complete. Resume by evaluating the gates below against local and
returned remote state; take the first unsatisfied authorized step.

The superseded prototype handoff is preserved byte-for-byte at
[`docs/handoffs/2026-09-16-prototype-handoff.md`](docs/handoffs/2026-09-16-prototype-handoff.md).

## Recorded before external publication

This historical snapshot was recorded on 2026-09-17 before the 0.0.1 planning
commit, tag, public repository, or GitHub settings were created:

- Worktree path:
  `/Users/Michel.Abboud/projects/opencode-playbook/.worktrees/modular-opencode-release`
- Intended branch: `feature/modular-opencode-release`
- Planning base commit: `7e145c5`
- Planned checkpoint version: `0.0.1`
- No GitHub mutation was performed while authoring this snapshot.

Those statements describe the recording seam only. They must not be read as
claims about present external state.

## Durable resumption gates

Run these read-only discovery commands before deciding what remains:

```sh
git branch --show-current
git status --short
cat VERSION
git log -1 --oneline
git tag -l 'checkpoint/*' --sort=version:refname
git remote -v
git worktree list --porcelain

gh auth status --hostname github.com
gh api user --jq .login
gh repo view nice-michel/opencode-playbook \
  --json visibility,defaultBranchRef,homepageUrl,url
git ls-remote --heads --tags origin
gh pr list --repo nice-michel/opencode-playbook --state all \
  --json number,state,baseRefName,headRefName,headRefOid,mergeCommit,url
gh release list --repo nice-michel/opencode-playbook
gh api repos/nice-michel/opencode-playbook/pages
gh api repos/nice-michel/opencode-playbook/private-vulnerability-reporting
```

Interpret them through these state-invariant gates:

1. The planning checkpoint is complete only if `VERSION` is at least 0.0.1,
   the exact planning inventory is committed, both planning reviews approve the
   same clean tip, and peeled `checkpoint/0.0.1` identifies that tip.
2. Planning publication is complete only if returned GitHub state proves the
   public `nice-michel/opencode-playbook` repository exists, authentication is
   `nice-michel`, private vulnerability reporting is enabled, and remote
   `main`, the feature branch, and the peeled planning tag match their approved
   local commits.
3. Implementation progress is derived from `VERSION`, current plan checkboxes,
   committed evidence, local and remote checkpoint refs, and the branch tip;
   prose in this handoff never overrides those sources.
4. Release is complete only if returned state proves the PR is merged, local
   `main` equals remote `main` and peeled `v0.1.0`, the GitHub release fields are
   correct, Pages is built from `main:/docs`, both public assets return final
   HTTP 200, and both worktrees are clean.

## Canonical source seam

Claude commit `5db68e347a65e511cc378b0598a6aac6655845bd`
(`VERSION` 0.1.12) and Codex commit
`b79080ad6f3f9605b60d4722265a5d271ea2e540` (`VERSION` 0.1.3) are read only
through pinned `git show` and `git ls-tree` operations. Exact tree and blob
evidence is recorded in
[`docs/reports/2026-09-17-canonical-source-pin.md`](docs/reports/2026-09-17-canonical-source-pin.md).

## Process-state rule

The 2026-09-17 authoring snapshot left no project-owned long-running process.
At every later resumption and closeout, discover process state afresh and report
any project-owned process with its exact teardown command. Never infer current
process state from this historical record.
