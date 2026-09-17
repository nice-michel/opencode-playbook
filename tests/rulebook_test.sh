#!/bin/sh
set -eu

umask 077
case $0 in
  /*) script_path=$0 ;;
  *) script_path=./$0 ;;
esac
repo_root=$(CDPATH= cd "$(dirname "$script_path")/.." && pwd)
cd "$repo_root"
test_root=${TMPDIR:-/tmp}/opencode-playbook-rulebook-test.$$
if ! mkdir "$test_root"
then
  printf 'FAIL  cannot create private test directory: %s\n' "$test_root" >&2
  exit 1
fi
cleanup_running=0
cleanup_failure=0
remove_test_file() {
  candidate=$1
  case $candidate in
    "$test_root"/*) ;;
    *)
      printf 'FAIL  refusing to clean path outside test directory: %s\n' "$candidate" >&2
      cleanup_failure=1
      return
      ;;
  esac
  if [ -L "$candidate" ]
  then
    printf 'FAIL  refusing to clean unexpected test symlink: %s\n' "$candidate" >&2
    cleanup_failure=1
  elif [ -f "$candidate" ]
  then
    if ! rm -f "$candidate"
    then
      printf 'FAIL  cannot clean test file: %s\n' "$candidate" >&2
      cleanup_failure=1
    fi
  fi
}
cleanup() {
  cleanup_status=$1
  if [ "$cleanup_running" -ne 0 ]
  then
    trap - 0 HUP INT TERM
    exit "$cleanup_status"
  fi
  cleanup_running=1
  trap - 0 HUP INT TERM
  for generated_name in \
    actual-approval-rows \
    actual-ids \
    actual-loading-section \
    actual-mantra \
    actual-report-owners \
    actual-report-quality \
    all-line-start-ids \
    all-line-start-occurrences \
    approval-rows \
    core-ids \
    expected-occurrences \
    expected-report-owners \
    expected-report-quality \
    expected-version \
    ids \
    injected-line-start-occurrences \
    loading-lines \
    loading-section \
    manifest-ids \
    mantra \
    normalized-agents \
    occurrences \
    report-ids \
    router-ids \
    skills \
    sorted-all-line-start-occurrences \
    sorted-expected-occurrences \
    sorted-injected-line-start-occurrences \
    sorted-occurrences \
    unknown-id-fixture
  do
    remove_test_file "$test_root/$generated_name"
  done
  if ! rmdir "$test_root" 2>/dev/null
  then
    printf 'FAIL  test directory is not empty or cannot be removed: %s\n' "$test_root" >&2
    cleanup_failure=1
  fi
  if [ "$cleanup_status" -eq 0 ] && [ "$cleanup_failure" -ne 0 ]
  then
    cleanup_status=1
  fi
  exit "$cleanup_status"
}
trap 'cleanup $?' 0
trap 'cleanup 129' HUP
trap 'cleanup 130' INT
trap 'cleanup 143' TERM
failures=0
passes=0
pass() { passes=$((passes + 1)); printf 'PASS  %s\n' "$1"; }
fail() { failures=$((failures + 1)); printf 'FAIL  %s\n' "$1" >&2; }
collect_line_start_numeric_occurrences() {
  output=$1
  shift
  : > "$output"
  for source_file
  do
    [ -f "$source_file" ] || continue
    awk -v source="$source_file" '
      /^[0-9]+\.[0-9]+/ {
        value=$0
        sub(/[^0-9.].*$/, "", value)
        print value "\t" source
      }
    ' "$source_file" >> "$output"
  done
}

cat > "$test_root/skills" <<'EOF'
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
EOF
cat > "$test_root/ids" <<'EOF'
0.1
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
12.4
EOF
cat > "$test_root/mantra" <<'EOF'
1. **We are partners.** I work with AI models as partners, not as tools that say yes. Meet me as one.
2. **Say what you actually think.** I want your honest best judgment, led with your recommendation and the reason for it. No pleasing, no flattery, no softening "this is worse" into "interesting idea". If you don't know, say that too. I do not want pleasers.
3. **Push back — on real things.** Healthy debate is the ingredient that makes this partnership work, and I ask for a lot of it. Debate substance: a wrong assumption, a cost I'm not seeing, a better route. Never debate for the sake of debate.
4. **Being overruled changes nothing.** Sometimes I listen to you, sometimes to me — that is how partners work. When I decide differently, your dissent stays on record and my decision is executed in full; re-open it only with something new (evidence, a cost I missed), never to win the point. And it never lowers your voice next time.
5. **The motto — do the right thing, not the lazy or easy thing.** No shortcuts, no looking for one. When the rules don't cover a case, optimize for what survives real production use by many users on different environments, and what survives time. Quality is not negotiable; *theater* about quality — code that looks done but isn't, or claims that aren't verified — is worthless.

I want an independent, opinionated model that is not afraid to say what it really thinks. That is the job. Agreeing with me is not.
EOF

sed 's/\r$//' AGENTS.md > "$test_root/normalized-agents"
for path in AGENTS.md VERSION config/managed-skills.txt config/rule-manifest.tsv docs/reports/2026-09-17-rule-parity-matrix.md
do
  if [ -f "$path" ]; then pass "$path exists"; else fail "$path is missing"; fi
done
bytes=$(wc -c < AGENTS.md | tr -d ' ')
if [ "$bytes" -le 12288 ]; then pass "AGENTS.md byte budget: $bytes"; else fail "AGENTS.md is $bytes bytes; max 12288"; fi
awk '/^1\. \*\*We are partners\./ { capture=1 } /^\*\*This rulebook is version/ { exit } capture { print }' "$test_root/normalized-agents" | sed '${/^$/d;}' > "$test_root/actual-mantra"
if cmp -s "$test_root/mantra" "$test_root/actual-mantra"; then pass 'exact complete normalized Claude mantra and coda'; else fail 'complete normalized mantra and coda differs from the canonical literal'; fi
if [ "$(cat VERSION)" = 0.0.2 ] && grep -Fq '**This rulebook is version 0.0.2**' AGENTS.md; then pass 'version carriers match'; else fail 'VERSION and AGENTS must match 0.0.2'; fi
printf '0.0.2\n' > "$test_root/expected-version"
if cmp -s "$test_root/expected-version" VERSION; then pass 'VERSION is exactly one bare version line'; else fail 'VERSION must be exact literal 0.0.2 plus one newline'; fi

for section in '## Authority' '## Classify the Request Before Acting' '## Approval Table — the Complete List' '## Mandatory Skill Router' '## OpenCode Loading Model' 'github.com/nice-michel/opencode-playbook' 'stable OpenCode 1.18.31 exactly'
do
  if grep -Fq -e "$section" "$test_root/normalized-agents"; then pass "router has $section"; else fail "router missing $section"; fi
done
rows=$(sed -n '/^## Approval Table — the Complete List$/,/^## Mandatory Skill Router$/p' "$test_root/normalized-agents" | awk '/^\| / { rows++ } END { print rows + 0 }')
if [ "$rows" -eq 10 ]; then pass 'approval table has header and nine closed rows'; else fail "approval table has $rows lines; expected 10"; fi
cat > "$test_root/approval-rows" <<'EOF'
| Situation | Action |
|---|---|
| Read-only work inside the request | Proceed. |
| Ordinary reversible implementation inside an approved task or plan | Proceed through the full close-out chain. |
| A new multi-task plan, or a change to architecture, a public API, a storage schema, a protocol, or a security/trust boundary | Ask with a concrete reviewable design. Do not ask again for an already approved design. |
| Routine commits, `checkpoint/` tags, source pushes, and an approved phase's GitHub release | Proceed after checks pass unless I said local-only. |
| The first action in a repository that publishes to a registry, deploys live, or emits release assets beyond source hosting | Ask once, naming destination and effect, unless the approved plan already named it. Source push approval is not package-publication approval. |
| A new native datastore or service; a system, security-sensitive, destructive, or production-performance configuration change | Ask unless that exact change is already authorized. Ordinary reversible repository configuration does not need approval. |
| Deleting, truncating, or wholesale replacing an `.env`, credential, secret, database, state file, log, backup, or user-created file; any mass or irreversible operation | Ask, naming exact targets. A broad build approval never covers this. |
| Proven regenerable and idle build output, or a disposable fixture created by this run | Proceed after validation. A matching name or ignore rule is not proof. |
| Ownership, scope, or recoverability remains uncertain after read-only inspection | Leave it alone or use `opencode-playbook-quarantine`. Ask only about the actual undecided action. |
EOF
sed -n '/^| Situation | Action |$/,/^## Mandatory Skill Router$/p' "$test_root/normalized-agents" | sed '/^## Mandatory Skill Router$/d; /^$/d' > "$test_root/actual-approval-rows"
if cmp -s "$test_root/approval-rows" "$test_root/actual-approval-rows"; then pass 'approval table matches all nine canonical authorization rows'; else fail 'approval table differs from the exact nine-row authorization contract'; fi
cat > "$test_root/loading-lines" <<'EOF'
- OpenCode combines global and project `AGENTS.md`: global instructions load first and project instructions win a conflict. A custom root replaces the default XDG global `AGENTS.md`.
- Native skill discovery retains the static XDG config skill directory and adds the selected custom config root; compatibility `.agents/skills` and `.claude/skills` may add more. A future installer will manage only the selected resolved root after Task 2.
EOF
while IFS= read -r loading_line
do
  if grep -Fq -e "$loading_line" "$test_root/normalized-agents"; then pass 'exact OpenCode loading semantics'; else fail "missing OpenCode loading semantic: $loading_line"; fi
done < "$test_root/loading-lines"
cat > "$test_root/loading-section" <<'EOF'
## OpenCode Loading Model

- Supported release target: stable OpenCode 1.18.31 exactly. OpenCode v2 and other versions are untested and unsupported.
- The global root is a non-empty `OPENCODE_CONFIG_DIR`; otherwise it is `${XDG_CONFIG_HOME:-$HOME/.config}/opencode`.
- OpenCode combines global and project `AGENTS.md`: global instructions load first and project instructions win a conflict. A custom root replaces the default XDG global `AGENTS.md`.
- The first matching `AGENTS.md` versus `CLAUDE.md` is a within-scope fallback, not a general global replacement.
- Native skill discovery retains the static XDG config skill directory and adds the selected custom config root; compatibility `.agents/skills` and `.claude/skills` may add more. A future installer will manage only the selected resolved root after Task 2.
- A future installer will manage only `AGENTS.md` and the 16 namespaced skills at its selected resolved root. It will never manage `opencode.json`, `opencode.jsonc`, auth, providers, plugins, sessions, or unrelated skills.
- Never treat a skill as loaded merely because its name appears above. Select it and read its full `SKILL.md` when its trigger fires.
EOF
sed -n '/^## OpenCode Loading Model$/,$p' "$test_root/normalized-agents" > "$test_root/actual-loading-section"
if cmp -s "$test_root/loading-section" "$test_root/actual-loading-section"; then pass 'complete OpenCode loading contract matches literal fixture'; else fail 'complete OpenCode loading contract differs from literal fixture'; fi
awk '/^[0-9]+\.[0-9]+ \*\*/ { id=$0; sub(/ .*/, "", id); print id }' "$test_root/normalized-agents" > "$test_root/router-ids"
printf '0.1\n0.2\n0.3\n0.4\n' > "$test_root/core-ids"
if cmp -s "$test_root/core-ids" "$test_root/router-ids"; then pass 'router carries only 0.1-0.4 bodies'; else fail 'router must carry exactly 0.1-0.4 bodies'; fi

if cmp -s "$test_root/skills" config/managed-skills.txt; then pass 'exact sorted 16-name inventory'; else fail 'managed skill inventory is not exact'; fi
cut -f1 config/rule-manifest.tsv > "$test_root/manifest-ids"
if [ "$(wc -l < "$test_root/manifest-ids" | tr -d ' ')" -eq 49 ] && cmp -s "$test_root/ids" "$test_root/manifest-ids"; then pass 'manifest has exact 49 IDs in order'; else fail 'manifest IDs are not exact'; fi
tab=$(printf '\t')
if [ "$(grep -Fxc "11.1${tab}.opencode/skills/opencode-playbook-platform-*/SKILL.md" config/rule-manifest.tsv || true)" -eq 1 ]; then pass 'manifest owns 11.1 through platform wildcard'; else fail 'manifest lacks valid 11.1 wildcard owner'; fi

while IFS= read -r skill
do
  file=".opencode/skills/$skill/SKILL.md"
  if [ -d ".opencode/skills/$skill" ] && [ ! -L ".opencode/skills/$skill" ] && [ -f "$file" ] && [ ! -L "$file" ] && sed -n '1p' "$file" | grep -Fxq -e '---' && sed -n '2p' "$file" | grep -Fxq -e "name: $skill" && sed -n '3p' "$file" | grep -Eq '^description: .{1,240}$' && sed -n '4p' "$file" | grep -Fxq -e '---'; then pass "$skill exact opening metadata and native file type"; else fail "$skill metadata must be the exact opening four-line block"; fi
  matches=$(awk -v skill="$skill" '
    /^## Mandatory Skill Router$/ { in_router=1; next }
    /^## OpenCode Loading Model$/ { in_router=0 }
    in_router && index($0, skill) { matches++ }
    END { print matches + 0 }
  ' "$test_root/normalized-agents")
  if [ "$matches" -eq 1 ]; then pass "$skill router mention"; else fail "$skill router mention count $matches"; fi
done < "$test_root/skills"
count=0
extra_managed=0
for skill_directory in .opencode/skills/opencode-playbook-*
do
  if [ -d "$skill_directory" ] && [ ! -L "$skill_directory" ]
  then
    extra_managed=$((extra_managed + 1))
    if [ -f "$skill_directory/SKILL.md" ] && [ ! -L "$skill_directory/SKILL.md" ]
    then
      count=$((count + 1))
    fi
  fi
done
if [ "$count" -eq 16 ]; then pass 'all and only 16 managed native skills'; else fail "managed native skills: $count"; fi
if [ "$extra_managed" -eq 16 ]; then pass 'no extra managed skill directories exist'; else fail "managed skill directory count: $extra_managed"; fi
self_update=.opencode/skills/opencode-playbook-self-update/SKILL.md
if ! grep -Fq './scripts/install.sh' "$self_update" && ! grep -Fq './scripts/restore.sh' "$self_update" && grep -Fq 'release_checkout' "$self_update" && grep -Fq '"$release_checkout/scripts/install.sh" --replace-agents' "$self_update" && grep -Fq '"$release_checkout/scripts/restore.sh"' "$self_update" && grep -Fq 'exact approved public release' "$self_update" && grep -Fiq 'verify the checkout revision, VERSION, and repository verification' "$self_update" && grep -Fq 'automated safe replacement is unavailable' "$self_update"; then pass 'self-update binds every procedure path to a verified release checkout'; else fail 'self-update has an unbound path or lacks the verified release-checkout procedure'; fi
if grep -Fq 'curl -fsS --proto =https --max-redirs 0' "$self_update"; then pass 'self-update fetch rejects redirects and non-HTTPS'; else fail 'self-update fetch must be HTTPS-only and reject redirects'; fi
if grep -Fq '"${env:USERNAME}:(OI)(CI)F"' .opencode/skills/opencode-playbook-platform-windows/SKILL.md && ! grep -Fq 'pkill -9 -f' .opencode/skills/opencode-playbook-platform-linux/SKILL.md && ! grep -Fq 'pkill -9 -f' .opencode/skills/opencode-playbook-platform-macos/SKILL.md; then pass 'platform emergency commands use safe ACL interpolation and exact PIDs'; else fail 'platform ACL or emergency kill command is unsafe'; fi

: > "$test_root/occurrences"
for file in AGENTS.md .opencode/skills/opencode-playbook-*/SKILL.md
do
  [ -f "$file" ] || continue
  awk -v source="$file" '/^[0-9]+\.[0-9]+ \*\*/ { id=$0; sub(/ .*/, "", id); print id "\t" source }' "$file" >> "$test_root/occurrences"
done
cut -f1 "$test_root/occurrences" | LC_ALL=C sort -t. -k1,1n -k2,2n -u > "$test_root/actual-ids"
cat > "$test_root/expected-occurrences" <<'EOF'
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
11.1	.opencode/skills/opencode-playbook-platform-linux/SKILL.md
11.1	.opencode/skills/opencode-playbook-platform-macos/SKILL.md
11.1	.opencode/skills/opencode-playbook-platform-windows/SKILL.md
12.1	.opencode/skills/opencode-playbook-writing/SKILL.md
12.2	.opencode/skills/opencode-playbook-writing/SKILL.md
12.3	.opencode/skills/opencode-playbook-writing/SKILL.md
12.4	.opencode/skills/opencode-playbook-writing/SKILL.md
EOF
LC_ALL=C sort -t. -k1,1n -k2,2n -k2,2 "$test_root/occurrences" > "$test_root/sorted-occurrences"
LC_ALL=C sort -t. -k1,1n -k2,2n -k2,2 "$test_root/expected-occurrences" > "$test_root/sorted-expected-occurrences"
if cmp -s "$test_root/sorted-expected-occurrences" "$test_root/sorted-occurrences"; then pass 'all rule heading occurrences exactly match the literal ownership fixture'; else fail 'rule heading occurrence is missing, duplicated, or undeclared'; fi

collect_line_start_numeric_occurrences "$test_root/all-line-start-occurrences" AGENTS.md .opencode/skills/opencode-playbook-*/SKILL.md
LC_ALL=C sort -t. -k1,1n -k2,2n -k2,2 "$test_root/all-line-start-occurrences" > "$test_root/sorted-all-line-start-occurrences"
cut -f1 "$test_root/sorted-all-line-start-occurrences" | LC_ALL=C sort -t. -k1,1n -k2,2n -u > "$test_root/all-line-start-ids"
if cmp -s "$test_root/ids" "$test_root/all-line-start-ids"; then pass 'all line-start numeric IDs are exactly canonical'; else fail 'unknown, malformed, or missing line-start numeric ID'; fi
if cmp -s "$test_root/sorted-expected-occurrences" "$test_root/sorted-all-line-start-occurrences"; then pass 'all line-start numeric occurrences match exact declared owners'; else fail 'line-start numeric occurrence is missing, duplicated, unknown, or undeclared'; fi
printf '13.1 text\n' > "$test_root/unknown-id-fixture"
collect_line_start_numeric_occurrences "$test_root/injected-line-start-occurrences" AGENTS.md .opencode/skills/opencode-playbook-*/SKILL.md "$test_root/unknown-id-fixture"
LC_ALL=C sort -t. -k1,1n -k2,2n -k2,2 "$test_root/injected-line-start-occurrences" > "$test_root/sorted-injected-line-start-occurrences"
if cmp -s "$test_root/sorted-expected-occurrences" "$test_root/sorted-injected-line-start-occurrences"; then fail 'line-start numeric validator accepted injected 13.1 text'; else pass 'line-start numeric validator rejects injected 13.1 text'; fi

if cmp -s "$test_root/ids" "$test_root/actual-ids"; then pass 'all 49 canonical rule headings exist'; else fail 'missing or unknown rule heading'; fi
ownership=0
while IFS="$(printf '\t')" read -r id owner
do
  matches=$(grep -Fxc "$id	$owner" "$test_root/occurrences" || true)
  if [ "$id" = 11.1 ]; then expected=0; for platform in linux macos windows; do grep -Fq "$id	.opencode/skills/opencode-playbook-platform-$platform/SKILL.md" "$test_root/occurrences" && expected=$((expected + 1)); done; [ "$expected" -eq 3 ] || ownership=$((ownership + 1))
  elif [ "$matches" -ne 1 ]; then ownership=$((ownership + 1))
  fi
done < config/rule-manifest.tsv
if [ "$ownership" -eq 0 ]; then pass 'every body appears in declared manifest owner'; else fail "$ownership rule ownership mismatch(es)"; fi

if grep -Fq 'Linux or WSL' .opencode/skills/opencode-playbook-platform-linux/SKILL.md 2>/dev/null && grep -Fq 'only when running on macOS' .opencode/skills/opencode-playbook-platform-macos/SKILL.md 2>/dev/null && grep -Fq 'only when running on native Windows' .opencode/skills/opencode-playbook-platform-windows/SKILL.md 2>/dev/null; then pass 'platform semantics are mutually exclusive'; else fail 'platform semantics are not exclusive'; fi
awk '/^\| [0-9]+\.[0-9]+ \|/ { id=$0; sub(/^\| /, "", id); sub(/ \|.*/, "", id); print id }' docs/reports/2026-09-17-rule-parity-matrix.md > "$test_root/report-ids"
if cmp -s "$test_root/ids" "$test_root/report-ids"; then pass 'parity matrix proves all 49 IDs'; else fail 'parity matrix omits or reorders IDs'; fi
cat > "$test_root/expected-report-owners" <<'EOF'
0.1	rules/AUTHORITY.md	AGENTS.md
0.2	rules/AUTHORITY.md	AGENTS.md
0.3	rules/AUTHORITY.md	AGENTS.md
0.4	rules/AUTHORITY.md	AGENTS.md
1.1	rules/CODE.md	.opencode/skills/opencode-playbook-code/SKILL.md
1.2	rules/CODE.md	.opencode/skills/opencode-playbook-code/SKILL.md
1.3	rules/CODE.md	.opencode/skills/opencode-playbook-code/SKILL.md
1.4	rules/CODE.md	.opencode/skills/opencode-playbook-code/SKILL.md
1.5	rules/CODE.md	.opencode/skills/opencode-playbook-code/SKILL.md
1.6	rules/CODE.md	.opencode/skills/opencode-playbook-code/SKILL.md
2.1	rules/TESTING.md	.opencode/skills/opencode-playbook-testing/SKILL.md
2.2	rules/TESTING.md	.opencode/skills/opencode-playbook-testing/SKILL.md
2.3	rules/TESTING.md	.opencode/skills/opencode-playbook-testing/SKILL.md
3.1	rules/REVIEWS.md	.opencode/skills/opencode-playbook-reviews/SKILL.md
3.2	rules/REVIEWS.md	.opencode/skills/opencode-playbook-reviews/SKILL.md
3.3	rules/REVIEWS.md	.opencode/skills/opencode-playbook-reviews/SKILL.md
3.4	rules/REVIEWS.md	.opencode/skills/opencode-playbook-reviews/SKILL.md
4.1	rules/DOCS.md	.opencode/skills/opencode-playbook-documentation/SKILL.md
4.2	rules/DOCS.md	.opencode/skills/opencode-playbook-documentation/SKILL.md
4.3	rules/DOCS.md	.opencode/skills/opencode-playbook-documentation/SKILL.md
5.1	rules/REPO.md	.opencode/skills/opencode-playbook-repository/SKILL.md
5.2	rules/REPO.md	.opencode/skills/opencode-playbook-repository/SKILL.md
5.3	rules/REPO.md	.opencode/skills/opencode-playbook-repository/SKILL.md
6.1	rules/WORKFLOW.md	.opencode/skills/opencode-playbook-workflow/SKILL.md
6.2	rules/WORKFLOW.md	.opencode/skills/opencode-playbook-workflow/SKILL.md
6.3	rules/WORKFLOW.md	.opencode/skills/opencode-playbook-workflow/SKILL.md
6.4	rules/WORKFLOW.md	.opencode/skills/opencode-playbook-workflow/SKILL.md
7.1	rules/COLLABORATION.md	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.2	rules/COLLABORATION.md	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.3	rules/COLLABORATION.md	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.4	rules/COLLABORATION.md	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.5	rules/COLLABORATION.md	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.6	rules/COLLABORATION.md	.opencode/skills/opencode-playbook-collaboration/SKILL.md
7.7	rules/COLLABORATION.md	.opencode/skills/opencode-playbook-collaboration/SKILL.md
8.1	rules/SUBAGENTS.md	.opencode/skills/opencode-playbook-subagents/SKILL.md
9.1	rules/ENVIRONMENT.md	.opencode/skills/opencode-playbook-environment/SKILL.md
9.2	rules/ENVIRONMENT.md	.opencode/skills/opencode-playbook-environment/SKILL.md
9.3	rules/ENVIRONMENT.md	.opencode/skills/opencode-playbook-environment/SKILL.md
9.4	rules/ENVIRONMENT.md	.opencode/skills/opencode-playbook-environment/SKILL.md
9.5	rules/ENVIRONMENT.md	.opencode/skills/opencode-playbook-environment/SKILL.md
9.6	rules/ENVIRONMENT.md	.opencode/skills/opencode-playbook-environment/SKILL.md
10.1	rules/DESTRUCTIVE.md	.opencode/skills/opencode-playbook-destructive/SKILL.md
10.2	rules/DESTRUCTIVE.md	.opencode/skills/opencode-playbook-destructive/SKILL.md
10.3	rules/QUARANTINE.md	.opencode/skills/opencode-playbook-quarantine/SKILL.md
11.1	rules/platform/LINUX.md; rules/platform/MACOS.md; rules/platform/WINDOWS.md	.opencode/skills/opencode-playbook-platform-linux/SKILL.md; .opencode/skills/opencode-playbook-platform-macos/SKILL.md; .opencode/skills/opencode-playbook-platform-windows/SKILL.md
12.1	rules/WRITING.md	.opencode/skills/opencode-playbook-writing/SKILL.md
12.2	rules/WRITING.md	.opencode/skills/opencode-playbook-writing/SKILL.md
12.3	rules/WRITING.md	.opencode/skills/opencode-playbook-writing/SKILL.md
12.4	rules/WRITING.md	.opencode/skills/opencode-playbook-writing/SKILL.md
EOF
awk -F ' [|] ' '/^\| [0-9]+\.[0-9]+ \|/ { sub(/^\| /, "", $1); print $1 "\t" $2 "\t" $3 }' docs/reports/2026-09-17-rule-parity-matrix.md > "$test_root/actual-report-owners"
if cmp -s "$test_root/expected-report-owners" "$test_root/actual-report-owners"; then pass 'parity report exact literal 49-row source and native ownership fixture'; else fail 'parity report source or native owner differs from literal fixture'; fi
cat > "$test_root/expected-report-quality" <<'EOF'
Principle 1	Mechanically adapted	Exact partnership doctrine is preserved without wording or behavior change; only the always-loaded source path changes from `CLAUDE.md` to OpenCode `AGENTS.md`.
Principle 2	Mechanically adapted	Exact honesty-and-best-judgment doctrine is preserved without wording or behavior change; only the always-loaded source path changes from `CLAUDE.md` to OpenCode `AGENTS.md`.
Principle 3	Mechanically adapted	Exact substantive-pushback doctrine is preserved without wording or behavior change; only the always-loaded source path changes from `CLAUDE.md` to OpenCode `AGENTS.md`.
Principle 4	Mechanically adapted	Exact overrule-and-reopen doctrine is preserved without wording or behavior change; only the always-loaded source path changes from `CLAUDE.md` to OpenCode `AGENTS.md`.
Principle 5	Mechanically adapted	Exact motto and quality doctrine is preserved without wording or behavior change; only the always-loaded source path changes from `CLAUDE.md` to OpenCode `AGENTS.md`.
Coda	Mechanically adapted	Exact independent-model coda is preserved without wording or behavior change; only the always-loaded source path changes from `CLAUDE.md` to OpenCode `AGENTS.md`.
0.1	Mechanically adapted	Stopping authority is unchanged; its source identity moves from `rules/AUTHORITY.md` to always-loaded OpenCode `AGENTS.md`.
0.2	Mechanically adapted	Scope-completion authority is unchanged; its source identity moves from `rules/AUTHORITY.md` to always-loaded OpenCode `AGENTS.md`.
0.3	Mechanically adapted	Production-grade ambiguity handling is unchanged; its source identity moves from `rules/AUTHORITY.md` to always-loaded OpenCode `AGENTS.md`.
0.4	Mechanically adapted	User-priority and implementation-autonomy behavior is unchanged; its source identity moves from `rules/AUTHORITY.md` to always-loaded OpenCode `AGENTS.md`.
1.1	Mechanically adapted	The no-fakes vertical-slice rule is unchanged; loading moves from `rules/CODE.md` to `.opencode/skills/opencode-playbook-code/SKILL.md`.
1.2	Mechanically adapted	The production-grade error-handling rule is unchanged; loading moves from `rules/CODE.md` to `.opencode/skills/opencode-playbook-code/SKILL.md`.
1.3	Mechanically adapted	The named-constant and configuration rule is unchanged; loading moves from `rules/CODE.md` to `.opencode/skills/opencode-playbook-code/SKILL.md`.
1.4	Mechanically adapted	The existing-pattern and focused-diff rule is unchanged; loading moves from `rules/CODE.md` to `.opencode/skills/opencode-playbook-code/SKILL.md`.
1.5	Mechanically adapted	The dependency-vetting rule is unchanged; loading moves from `rules/CODE.md` to `.opencode/skills/opencode-playbook-code/SKILL.md`.
1.6	Mechanically adapted	The vendored-code provenance rule is unchanged; loading moves from `rules/CODE.md` to `.opencode/skills/opencode-playbook-code/SKILL.md`.
2.1	Mechanically adapted	The happy-path, failure-path, and regression-test rule is unchanged; loading moves from `rules/TESTING.md` to `.opencode/skills/opencode-playbook-testing/SKILL.md`.
2.2	Mechanically adapted	The fresh verification-evidence rule is unchanged; loading moves from `rules/TESTING.md` to `.opencode/skills/opencode-playbook-testing/SKILL.md`.
2.3	Mechanically adapted	The measured-performance-claims rule is unchanged; loading moves from `rules/TESTING.md` to `.opencode/skills/opencode-playbook-testing/SKILL.md`.
3.1	Mechanically adapted	The review ladder is unchanged; `.opencode/skills/opencode-playbook-reviews/SKILL.md` replaces `rules/REVIEWS.md`, and OpenCode capability tiers replace fixed product-model identities.
3.2	Mechanically adapted	Batch boundaries and risk overrides are unchanged; loading moves from `rules/REVIEWS.md` to `.opencode/skills/opencode-playbook-reviews/SKILL.md`.
3.3	Mechanically adapted	Pipeline, tip re-check, and stop-the-line behavior is unchanged; loading moves from `rules/REVIEWS.md` to `.opencode/skills/opencode-playbook-reviews/SKILL.md`.
3.4	Mechanically adapted	The dual-blind release review is unchanged; `.opencode/skills/opencode-playbook-reviews/SKILL.md` replaces `rules/REVIEWS.md`, and OpenCode capability tiers replace fixed product-model identities.
4.1	Mechanically adapted	Contributor-facing feature documentation requirements are unchanged; loading moves from `rules/DOCS.md` to `.opencode/skills/opencode-playbook-documentation/SKILL.md`.
4.2	Mechanically adapted	Architecture decision record thresholds and format are unchanged; loading moves from `rules/DOCS.md` to `.opencode/skills/opencode-playbook-documentation/SKILL.md`.
4.3	Mechanically adapted	Per-task documentation updates are unchanged; loading moves from `rules/DOCS.md` to `.opencode/skills/opencode-playbook-documentation/SKILL.md`.
5.1	Mechanically adapted	Required repository records and version-source behavior are unchanged; loading moves from `rules/REPO.md` to `.opencode/skills/opencode-playbook-repository/SKILL.md`.
5.2	Mechanically adapted	Conditional public, contributor, runbook, and glossary records are unchanged; loading moves from `rules/REPO.md` to `.opencode/skills/opencode-playbook-repository/SKILL.md`.
5.3	Mechanically adapted	The structured `docs/` hierarchy is unchanged; loading moves from `rules/REPO.md` to `.opencode/skills/opencode-playbook-repository/SKILL.md`.
6.1	Mechanically adapted	Task close-out, version allocation, and checkpoint behavior are unchanged; `.opencode/skills/opencode-playbook-workflow/SKILL.md` replaces `rules/WORKFLOW.md`, with OpenCode client identity.
6.2	Mechanically adapted	The five-part close-out report is unchanged; `.opencode/skills/opencode-playbook-workflow/SKILL.md` replaces `rules/WORKFLOW.md`, with OpenCode capability-tier ledger wording.
6.3	Mechanically adapted	Phase merge, audit, release, and advisory gates are unchanged; loading moves from `rules/WORKFLOW.md` to `.opencode/skills/opencode-playbook-workflow/SKILL.md`.
6.4	Mechanically adapted	Published-history protection is unchanged; loading moves from `rules/WORKFLOW.md` to `.opencode/skills/opencode-playbook-workflow/SKILL.md`.
7.1	Mechanically adapted	The single plan-approval gate is unchanged; loading moves from `rules/COLLABORATION.md` to `.opencode/skills/opencode-playbook-collaboration/SKILL.md`.
7.2	Mechanically adapted	Default autonomy and escalation behavior is unchanged; `.opencode/skills/opencode-playbook-collaboration/SKILL.md` replaces `rules/COLLABORATION.md`, with OpenCode task-board terminology.
7.3	Mechanically adapted	The educate-before-asking behavior is unchanged; loading moves from `rules/COLLABORATION.md` to `.opencode/skills/opencode-playbook-collaboration/SKILL.md`.
7.4	Mechanically adapted	Fix-now-or-defer-loudly defect triage is unchanged; loading moves from `rules/COLLABORATION.md` to `.opencode/skills/opencode-playbook-collaboration/SKILL.md`.
7.5	Mechanically adapted	The no-silent-descope rule is unchanged; loading moves from `rules/COLLABORATION.md` to `.opencode/skills/opencode-playbook-collaboration/SKILL.md`.
7.6	Mechanically adapted	Post-completion context hygiene is unchanged; loading moves from `rules/COLLABORATION.md` to `.opencode/skills/opencode-playbook-collaboration/SKILL.md`.
7.7	Mechanically adapted	Mid-work handoff requirements are unchanged; loading moves from `rules/COLLABORATION.md` to `.opencode/skills/opencode-playbook-collaboration/SKILL.md`.
8.1	Mechanically adapted	Subagent delegation and escalation behavior is unchanged; `.opencode/skills/opencode-playbook-subagents/SKILL.md` replaces `rules/SUBAGENTS.md`, and OpenCode capability tiers and task tooling replace product-specific model and agent identities.
9.1	Mechanically adapted	Port conflict checking and claiming behavior is unchanged; `.opencode/skills/opencode-playbook-environment/SKILL.md` replaces `rules/ENVIRONMENT.md`, and the registry path changes to `~/.config/fleet/ports/`.
9.2	Mechanically adapted	Project-prefixed container ownership safeguards are unchanged; loading moves from `rules/ENVIRONMENT.md` to `.opencode/skills/opencode-playbook-environment/SKILL.md`.
9.3	Mechanically adapted	The embedded-datastore default is unchanged; loading moves from `rules/ENVIRONMENT.md` to `.opencode/skills/opencode-playbook-environment/SKILL.md`.
9.4	Mechanically adapted	Log retention and inactive-log compression safeguards are unchanged; loading moves from `rules/ENVIRONMENT.md` to `.opencode/skills/opencode-playbook-environment/SKILL.md`.
9.5	Mechanically adapted	Secret storage and transcript-redaction behavior is unchanged; loading moves from `rules/ENVIRONMENT.md` to `.opencode/skills/opencode-playbook-environment/SKILL.md`.
9.6	Mechanically adapted	Long-running-process reporting and teardown behavior is unchanged; loading moves from `rules/ENVIRONMENT.md` to `.opencode/skills/opencode-playbook-environment/SKILL.md`.
10.1	Mechanically adapted	Destructive-action approval authority is unchanged; loading moves from `rules/DESTRUCTIVE.md` to `.opencode/skills/opencode-playbook-destructive/SKILL.md`.
10.2	Mechanically adapted	Validation and command-separation safeguards are unchanged; loading moves from `rules/DESTRUCTIVE.md` to `.opencode/skills/opencode-playbook-destructive/SKILL.md`.
10.3	Mechanically adapted	Recoverable quarantine behavior is unchanged; loading moves from `rules/QUARANTINE.md` to `.opencode/skills/opencode-playbook-quarantine/SKILL.md`.
11.1	Mechanically adapted	Platform behavior remains mutually exclusive; the three `rules/platform/*.md` owners become three `.opencode/skills/opencode-playbook-platform-*/SKILL.md` owners selected through the OpenCode skill router.
12.1	Mechanically adapted	Answer-first and next-action reply shaping is unchanged; loading moves from `rules/WRITING.md` to `.opencode/skills/opencode-playbook-writing/SKILL.md`.
12.2	Mechanically adapted	Per-turn state restatement is unchanged; loading moves from `rules/WRITING.md` to `.opencode/skills/opencode-playbook-writing/SKILL.md`.
12.3	Mechanically adapted	Plain-language explanation behavior is unchanged; loading moves from `rules/WRITING.md` to `.opencode/skills/opencode-playbook-writing/SKILL.md`.
12.4	Mechanically adapted	The mechanical pre-send check is unchanged; loading moves from `rules/WRITING.md` to `.opencode/skills/opencode-playbook-writing/SKILL.md`.
EOF
if awk -F ' [|] ' '
  /^\| Doctrine \|/ {
    rows++
    reason=$6
    sub(/ \|$/, "", reason)
    if ($2 == "" || $3 == "" || $4 == "" || $5 == "" || reason == "") invalid=1
    if ($5 != "Preserved" && $5 != "Mechanically adapted") invalid=1
    print $2 "\t" $5 "\t" reason
  }
  /^\| [0-9]+\.[0-9]+ \|/ {
    rows++
    sub(/^\| /, "", $1)
    reason=$5
    sub(/ \|$/, "", reason)
    if ($1 == "" || $2 == "" || $3 == "" || $4 == "" || reason == "") invalid=1
    if ($4 != "Preserved" && $4 != "Mechanically adapted") invalid=1
    print $1 "\t" $4 "\t" reason
  }
  END { if (rows != 55 || invalid) exit 1 }
' docs/reports/2026-09-17-rule-parity-matrix.md > "$test_root/actual-report-quality"; then pass 'parity matrix has 55 complete rows with allowed dispositions'; else fail 'parity matrix row count, required field, or disposition is invalid'; fi
if cmp -s "$test_root/expected-report-quality" "$test_root/actual-report-quality"; then pass 'parity matrix exact disposition and concrete-reason fixture'; else fail 'parity matrix disposition or adaptation reason differs from literal fixture'; fi
if grep -Fq '`Preserved` means wording, behavior, and source identity are unchanged.' docs/reports/2026-09-17-rule-parity-matrix.md && grep -Fq 'a location-only change is mechanically adapted' docs/reports/2026-09-17-rule-parity-matrix.md; then pass 'parity disposition semantics are explicit'; else fail 'parity disposition semantics are incomplete'; fi
stale_wording=0
for inspected_file in AGENTS.md config/managed-skills.txt config/rule-manifest.tsv docs/reports/2026-09-17-rule-parity-matrix.md .opencode/skills/opencode-playbook-*/SKILL.md
do
  [ -f "$inspected_file" ] || continue
  if awk '
    tolower($0) ~ /compatibility/ { next }
    $0 ~ /(^|[^A-Za-z])Codex([^A-Za-z]|$)/ { found=1 }
    index($0, ".agents/skills") { found=1 }
    index($0, "$CODEX_HOME") { found=1 }
    index($0, "Claude Code") { found=1 }
    index($0, ".claude/skills") { found=1 }
    index($0, "42-rule") { found=1 }
    index($0, "3-skill") { found=1 }
    index($0, "TBD") { found=1 }
    index($0, "placeholder") { found=1 }
    END { exit found ? 0 : 1 }
  ' "$inspected_file"
  then
    stale_wording=1
    break
  else
    scan_status=$?
    if [ "$scan_status" -gt 1 ]
    then
      stale_wording=2
      fail "cannot scan stale wording in $inspected_file"
      break
    fi
  fi
done
if [ "$stale_wording" -eq 0 ]; then pass 'no stale client wording or placeholders'; elif [ "$stale_wording" -eq 1 ]; then fail 'stale client wording or placeholder found'; fi
if grep -Fq 'implemented native OpenCode progressive-disclosure rulebook' README.md && grep -Fq '16 native repository skills' ARCHITECTURE.md && ! grep -Eiq '(installer|runtime).*(is complete|has been completed|implemented and ready)' README.md ARCHITECTURE.md; then pass 'current docs do not overclaim installer/runtime'; else fail 'README or ARCHITECTURE current-state claim invalid'; fi

if [ "$failures" -ne 0 ]; then printf '\n%s rulebook verification check(s) failed; %s passed.\n' "$failures" "$passes" >&2; exit 1; fi
printf '\nAll %s rulebook verification checks passed.\n' "$passes"
