#!/bin/sh

set -eu

fail() {
  printf 'planning verification failed: %s\n' "$1" >&2
  exit 1
}

usage() {
  printf 'usage: %s --working-tree | --committed <base>\n' "$0" >&2
  exit 2
}

mode=${1-}
case "$mode" in
  --working-tree)
    test "$#" -eq 1 || usage
    comparison_base=HEAD
    ;;
  --committed)
    test "$#" -eq 2 || usage
    comparison_base=$2
    ;;
  *)
    usage
    ;;
esac

repo_root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd -P)
cd "$repo_root"

planning_files='.env.example
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
historical_handoff=docs/handoffs/2026-09-16-prototype-handoff.md

current_planning_files=$(printf '%s\n' "$planning_files" |
  grep -Fvx "$historical_handoff")
test "$(printf '%s\n' "$current_planning_files" | wc -l | tr -d ' ')" -eq 20 ||
  fail 'current planning inventory must contain exactly 20 artifacts'

required_files="LICENSE
$planning_files"

expected_inventory=$(printf '%s\n' "$planning_files" | LC_ALL=C sort)

if test "$mode" = --working-tree
then
  # The immutable historical handoff preserves its source's intentional blank
  # EOF line. Exclude only that path from Git's whitespace heuristic; the
  # explicit inventory, content scans, and cmp identity check still cover it.
  git diff --check -- . ":(exclude)$historical_handoff"
  git diff --cached --check -- . ":(exclude)$historical_handoff"
  actual_inventory=$(git status --porcelain=v1 -uall | awk '
    index($0, " -> ") { exit 2 }
    { print substr($0, 4) }
  ' | LC_ALL=C sort -u) || fail 'renamed paths are not allowed in the planning checkpoint'
else
  git rev-parse --verify "${comparison_base}^{commit}" >/dev/null 2>&1 ||
    fail "committed comparison base is not a commit: $comparison_base"
  test -z "$(git status --porcelain=v1 -uall)" ||
    fail 'post-commit verification requires a clean worktree and index'
  git diff --check "${comparison_base}..HEAD" -- . \
    ":(exclude)$historical_handoff"
  actual_inventory=$(git diff --name-only "${comparison_base}..HEAD" | LC_ALL=C sort -u)
fi

test "$actual_inventory" = "$expected_inventory" || {
  printf '%s\n' 'expected planning inventory:' >&2
  printf '%s\n' "$expected_inventory" >&2
  printf '%s\n' 'actual planning inventory:' >&2
  printf '%s\n' "$actual_inventory" >&2
  fail 'planning inventory differs from the reviewed allowlist'
}

for path in $required_files
do
  test -f "$path" || fail "required regular file is missing: $path"
  test ! -L "$path" || fail "required file is a symlink: $path"
  test -s "$path" || fail "required file is empty: $path"
  if test "$mode" = --committed
  then
    git cat-file -e "HEAD:$path" 2>/dev/null ||
      fail "required file is absent from HEAD: $path"
  fi
done

test -x scripts/verify_planning.sh || fail 'scripts/verify_planning.sh is not executable'
test "$(wc -l < VERSION | tr -d ' ')" -eq 1 || fail 'VERSION must have one line'
test "$(cat VERSION)" = 0.0.1 || fail 'VERSION must be exactly 0.0.1'

plan=docs/superpowers/plans/2026-09-17-opencode-playbook-corrective-release.md
expected_header='> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.'
grep -Fqx "$expected_header" "$plan" || fail 'implementation plan header differs from the required writing-plans header'
test "$(grep -Ec '^### Task [1-8]:' "$plan")" -eq 8 || fail 'implementation plan must contain exactly eight tasks'
for task_number in 1 2 3 4 5 6 7 8
do
  test "$(grep -Ec "^### Task ${task_number}:" "$plan")" -eq 1 ||
    fail "implementation plan must contain Task $task_number exactly once"
done

unfinished_pattern='(TO''DO|TB''D|FIX''ME|X''XX)([^A-Za-z]|$)|\[in''sert[^]]*\]|<in''sert[^>]*>'

for path in $planning_files
do
  if grep -En "$unfinished_pattern" "$path" >/dev/null
  then
    grep -En "$unfinished_pattern" "$path" >&2
    fail "unfinished marker found in $path"
  fi
  if grep -En '[[:blank:]]$' "$path" >/dev/null
  then
    grep -En '[[:blank:]]$' "$path" >&2
    fail "trailing whitespace found in $path"
  fi
done

git show "${comparison_base}:HANDOFF.md" |
  cmp -s - "$historical_handoff" ||
  fail 'historical prototype handoff is not byte-identical to the base HANDOFF.md'

extract_markdown_links() {
  awk -v source="$1" '
    {
      rest = $0
      while (match(rest, /\[[^][]*\]\([^()]*\)/)) {
        token = substr(rest, RSTART, RLENGTH)
        separator = index(token, "](")
        target = substr(token, separator + 2, length(token) - separator - 2)
        print source "\t" target
        rest = substr(rest, RSTART + RLENGTH)
      }
    }
  ' "$1"
}

for path in $planning_files
do
  case "$path" in
    *.md)
      extract_markdown_links "$path" |
        while IFS="$(printf '\t')" read -r source target
        do
          case "$target" in
            ''|'#'*|http://*|https://*|mailto:*) continue ;;
          esac
          target=${target%%#*}
          source_dir=$(dirname "$source")
          test -e "$source_dir/$target" || fail "broken local Markdown link in $source: $target"
        done
      ;;
  esac
done

claude_repo=${CLAUDE_PLAYBOOK_SOURCE_REPO:-/Users/Michel.Abboud/projects/claude-code-playbook}
claude_sha=5db68e347a65e511cc378b0598a6aac6655845bd
codex_repo=${CODEX_PLAYBOOK_SOURCE_REPO:-/Users/Michel.Abboud/.config/superpowers/worktrees/codex-playbook/fix-modular-rule-parity}
codex_sha=b79080ad6f3f9605b60d4722265a5d271ea2e540

test -n "$claude_repo" && test -n "$codex_repo" || fail 'source repository override is empty'
git -C "$claude_repo" rev-parse --git-dir >/dev/null 2>&1 || fail 'Claude source is not a Git object database'
git -C "$codex_repo" rev-parse --git-dir >/dev/null 2>&1 || fail 'Codex source is not a Git object database'
test "$(git -C "$claude_repo" rev-parse "${claude_sha}^{commit}")" = "$claude_sha" || fail 'Claude commit pin does not resolve exactly'
test "$(git -C "$codex_repo" rev-parse "${codex_sha}^{commit}")" = "$codex_sha" || fail 'Codex commit pin does not resolve exactly'
test "$(git -C "$claude_repo" show "${claude_sha}:VERSION")" = 0.1.12 || fail 'Claude VERSION pin differs'
test "$(git -C "$codex_repo" show "${codex_sha}:VERSION")" = 0.1.3 || fail 'Codex VERSION pin differs'
test "$(git -C "$claude_repo" rev-parse "${claude_sha}^{tree}")" = aad7b85f22c437081805f594d80ff60ce9fa0860 || fail 'Claude root tree differs'
test "$(git -C "$claude_repo" rev-parse "${claude_sha}:rules")" = 72a3805790450adc97404a3cd898e97752391e9e || fail 'Claude rules tree differs'
test "$(git -C "$codex_repo" rev-parse "${codex_sha}^{tree}")" = 0e44f7d1df977c3ece1b9c3b11719d082e0ae0fc || fail 'Codex root tree differs'
test "$(git -C "$codex_repo" rev-parse "${codex_sha}:.agents/skills")" = 30154c9b5e11b9ce4e63ac2a6ddeef7fd37ad51d || fail 'Codex skills tree differs'
test "$(git -C "$claude_repo" ls-tree -r --name-only "$claude_sha" -- VERSION CLAUDE.md rules | wc -l | tr -d ' ')" -eq 18 || fail 'Claude source inventory differs'
test "$(git -C "$codex_repo" ls-tree -r --name-only "$codex_sha" -- VERSION AGENTS.md config/managed-skills.txt config/rule-manifest.tsv .agents/skills | wc -l | tr -d ' ')" -eq 20 || fail 'Codex source inventory differs'

for token in \
  "$claude_sha" 0.1.12 aad7b85f22c437081805f594d80ff60ce9fa0860 \
  72a3805790450adc97404a3cd898e97752391e9e \
  "$codex_sha" 0.1.3 0e44f7d1df977c3ece1b9c3b11719d082e0ae0fc \
  30154c9b5e11b9ce4e63ac2a6ddeef7fd37ad51d
do
  grep -Fq "$token" docs/reports/2026-09-17-canonical-source-pin.md ||
    fail "canonical source-pin report omits $token"
done

printf 'planning verification passed (%s; %s files)\n' "$mode" "$(printf '%s\n' "$planning_files" | wc -l | tr -d ' ')"
