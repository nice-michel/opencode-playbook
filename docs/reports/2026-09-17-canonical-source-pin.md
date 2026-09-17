# Canonical Source Pins — 2026-09-17

The corrective OpenCode adaptation uses these reproducible Git-object sources:

```text
Claude Git object database: /Users/Michel.Abboud/projects/claude-code-playbook
Claude public source: https://github.com/nice-michel/claude-code-playbook
Claude commit: 5db68e347a65e511cc378b0598a6aac6655845bd
Claude VERSION: 0.1.12

Codex Git object database: /Users/Michel.Abboud/.config/superpowers/worktrees/codex-playbook/fix-modular-rule-parity
Codex public source: https://github.com/nice-michel/codex-playbook
Codex commit: b79080ad6f3f9605b60d4722265a5d271ea2e540
Codex VERSION: 0.1.3
```

A clean object-only acquisition in a new operator-chosen directory is:

```sh
source_home=${HOME:?HOME must be set}
source_cache_home=${XDG_CACHE_HOME:-$source_home/.cache}
source_parent=$source_cache_home/opencode-playbook-source-objects
mkdir -p "$source_parent"
test ! -e "$source_parent/claude-code-playbook"
test ! -e "$source_parent/codex-playbook"
git clone --filter=blob:none --no-checkout \
  https://github.com/nice-michel/claude-code-playbook.git \
  "$source_parent/claude-code-playbook"
git -C "$source_parent/claude-code-playbook" fetch --no-tags origin \
  5db68e347a65e511cc378b0598a6aac6655845bd
git -C "$source_parent/claude-code-playbook" show \
  5db68e347a65e511cc378b0598a6aac6655845bd:VERSION

git clone --filter=blob:none --no-checkout \
  https://github.com/nice-michel/codex-playbook.git \
  "$source_parent/codex-playbook"
git -C "$source_parent/codex-playbook" fetch --no-tags origin \
  b79080ad6f3f9605b60d4722265a5d271ea2e540
git -C "$source_parent/codex-playbook" show \
  b79080ad6f3f9605b60d4722265a5d271ea2e540:VERSION

export CLAUDE_PLAYBOOK_SOURCE_REPO="$source_parent/claude-code-playbook"
export CODEX_PLAYBOOK_SOURCE_REPO="$source_parent/codex-playbook"
./scripts/verify_planning.sh --working-tree
```

No checkout command is needed; all later inspection uses the pinned object IDs.
The two optional environment variables override Michel's local default object
database paths without modifying the verifier.

Read-only verification on 2026-09-17 returned:

```text
git -C /Users/Michel.Abboud/projects/claude-code-playbook rev-parse 5db68e347a65e511cc378b0598a6aac6655845bd^{commit}
5db68e347a65e511cc378b0598a6aac6655845bd

git -C /Users/Michel.Abboud/projects/claude-code-playbook show 5db68e347a65e511cc378b0598a6aac6655845bd:VERSION
0.1.12

git -C /Users/Michel.Abboud/.config/superpowers/worktrees/codex-playbook/fix-modular-rule-parity rev-parse b79080ad6f3f9605b60d4722265a5d271ea2e540^{commit}
b79080ad6f3f9605b60d4722265a5d271ea2e540

git -C /Users/Michel.Abboud/.config/superpowers/worktrees/codex-playbook/fix-modular-rule-parity show b79080ad6f3f9605b60d4722265a5d271ea2e540:VERSION
0.1.3
```

The repository paths are object-database handles only. Their checked-out branch,
`HEAD`, index, files, and cleanliness are not adaptation inputs. Task 1 verifies
the exact commit and version, enumerates required paths only with
`git ls-tree -r --name-only <sha> -- <path>`, and reads canonical text only with
`git show <sha>:<path>`. It records or asserts stable tree and key-blob IDs where
they make drift immediately visible.

No source is extracted or copied. The implementer writes adapted OpenCode files
with `apply_patch`; no command writes to or removes anything from either source
repository.

Verified object identities include:

```text
Claude root tree: aad7b85f22c437081805f594d80ff60ce9fa0860
Claude rules tree: 72a3805790450adc97404a3cd898e97752391e9e
Claude CLAUDE.md blob: 8c17cb76c2e0121085d88acb76ff45e47c5db37b
Codex root tree: 0e44f7d1df977c3ece1b9c3b11719d082e0ae0fc
Codex skills tree: 30154c9b5e11b9ce4e63ac2a6ddeef7fd37ad51d
Codex AGENTS.md blob: 9d721dacb6dbf53d87416dfe0ed5056758dd0da4
Codex rule manifest blob: c3dfc92048cf80bef4dce44df894ff70ab5b0cad
```
