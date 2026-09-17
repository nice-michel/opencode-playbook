#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$repo_root"
test_root=$(mktemp -d /tmp/opencode-rulebook-test.XXXXXX)
trap 'rm -R "$test_root"' EXIT HUP INT TERM
failures=0
passes=0
pass() { passes=$((passes + 1)); printf 'PASS  %s\n' "$1"; }
fail() { failures=$((failures + 1)); printf 'FAIL  %s\n' "$1" >&2; }

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

for path in AGENTS.md VERSION config/managed-skills.txt config/rule-manifest.tsv docs/reports/2026-09-17-rule-parity-matrix.md
do
  if [ -f "$path" ]; then pass "$path exists"; else fail "$path is missing"; fi
done
bytes=$(wc -c < AGENTS.md | tr -d ' ')
if [ "$bytes" -le 12288 ]; then pass "AGENTS.md byte budget: $bytes"; else fail "AGENTS.md is $bytes bytes; max 12288"; fi
awk '/^1\. \*\*We are partners\./ { capture=1 } /^\*\*This rulebook is version/ { exit } capture { print }' AGENTS.md | sed '${/^$/d;}' > "$test_root/actual-mantra"
if cmp -s "$test_root/mantra" "$test_root/actual-mantra"; then pass 'exact complete normalized Claude mantra and coda'; else fail 'complete normalized mantra and coda differs from the canonical literal'; fi
if [ "$(cat VERSION)" = 0.0.2 ] && grep -Fq '**This rulebook is version 0.0.2**' AGENTS.md; then pass 'version carriers match'; else fail 'VERSION and AGENTS must match 0.0.2'; fi

for section in '## Authority' '## Classify the Request Before Acting' '## Approval Table — the Complete List' '## Mandatory Skill Router' '## OpenCode Loading Model' 'github.com/nice-michel/opencode-playbook' 'stable OpenCode 1.18.31 exactly'
do
  if grep -Fq "$section" AGENTS.md; then pass "router has $section"; else fail "router missing $section"; fi
done
rows=$(sed -n '/^## Approval Table — the Complete List$/,/^## Mandatory Skill Router$/p' AGENTS.md | grep -Ec '^\| ' || true)
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
sed -n '/^| Situation | Action |$/,/^## Mandatory Skill Router$/p' AGENTS.md | sed '/^## Mandatory Skill Router$/d; /^$/d' > "$test_root/actual-approval-rows"
if cmp -s "$test_root/approval-rows" "$test_root/actual-approval-rows"; then pass 'approval table matches all nine canonical authorization rows'; else fail 'approval table differs from the exact nine-row authorization contract'; fi
cat > "$test_root/loading-lines" <<'EOF'
- OpenCode combines global and project `AGENTS.md`: global instructions load first and project instructions win a conflict. A custom root replaces the default XDG global `AGENTS.md`.
- Native skill discovery retains the static XDG config skill directory and adds the selected custom config root; compatibility `.agents/skills` and `.claude/skills` may add more. A future installer will manage only the selected resolved root after Task 2.
EOF
while IFS= read -r loading_line
do
  if grep -Fq -- "$loading_line" AGENTS.md; then pass 'exact OpenCode loading semantics'; else fail "missing OpenCode loading semantic: $loading_line"; fi
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
sed -n '/^## OpenCode Loading Model$/,$p' AGENTS.md > "$test_root/actual-loading-section"
if cmp -s "$test_root/loading-section" "$test_root/actual-loading-section"; then pass 'complete OpenCode loading contract matches literal fixture'; else fail 'complete OpenCode loading contract differs from literal fixture'; fi
grep -Eho '^[0-9]+\.[0-9]+ \*\*' AGENTS.md | sed 's/ \*\*$//' > "$test_root/router-ids" || true
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
  if [ -d ".opencode/skills/$skill" ] && [ ! -L ".opencode/skills/$skill" ] && [ -f "$file" ] && [ ! -L "$file" ] && grep -Fxq "name: $skill" "$file" && [ "$(grep -Ec '^description: .+' "$file")" -eq 1 ]; then pass "$skill metadata and native file type"; else fail "$skill metadata, directory, or file type"; fi
  matches=$(sed -n '/^## Mandatory Skill Router$/,/^## OpenCode Loading Model$/p' AGENTS.md | grep -Foc "$skill" || true)
  if [ "$matches" -eq 1 ]; then pass "$skill router mention"; else fail "$skill router mention count $matches"; fi
done < "$test_root/skills"
count=$(find .opencode/skills -mindepth 2 -maxdepth 2 -name SKILL.md -path '*/opencode-playbook-*/*' 2>/dev/null | wc -l | tr -d ' ')
if [ "$count" -eq 16 ]; then pass 'all and only 16 managed native skills'; else fail "managed native skills: $count"; fi
extra_managed=$(find .opencode/skills -mindepth 1 -maxdepth 1 -type d -name 'opencode-playbook-*' | wc -l | tr -d ' ')
if [ "$extra_managed" -eq 16 ]; then pass 'no extra managed skill directories exist'; else fail "managed skill directory count: $extra_managed"; fi

: > "$test_root/occurrences"
for file in AGENTS.md .opencode/skills/opencode-playbook-*/SKILL.md
do
  [ -f "$file" ] || continue
  grep -Eho '^[0-9]+\.[0-9]+ \*\*' "$file" | sed 's/ \*\*$//' | while IFS= read -r id
  do printf '%s\t%s\n' "$id" "$file"; done >> "$test_root/occurrences"
done
cut -f1 "$test_root/occurrences" | LC_ALL=C sort -V -u > "$test_root/actual-ids"
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
LC_ALL=C sort "$test_root/occurrences" > "$test_root/sorted-occurrences"
LC_ALL=C sort "$test_root/expected-occurrences" > "$test_root/sorted-expected-occurrences"
if cmp -s "$test_root/sorted-expected-occurrences" "$test_root/sorted-occurrences"; then pass 'all rule heading occurrences exactly match the literal ownership fixture'; else fail 'rule heading occurrence is missing, duplicated, or undeclared'; fi

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
grep -E '^\| [0-9]+\.[0-9]+ \|' docs/reports/2026-09-17-rule-parity-matrix.md 2>/dev/null | sed -E 's/^\| ([0-9]+\.[0-9]+) \|.*$/\1/' > "$test_root/report-ids" || true
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
if [ "$(grep -Ec '^\| Doctrine \|' docs/reports/2026-09-17-rule-parity-matrix.md || true)" -eq 6 ] && grep -Fq '| Claude owner/source | OpenCode owner/path | Disposition | Specific adaptation reason |' docs/reports/2026-09-17-rule-parity-matrix.md; then pass 'parity matrix has six doctrine rows and ownership evidence columns'; else fail 'parity matrix lacks doctrine rows or ownership evidence columns'; fi
if grep -RInE '(^|[^A-Za-z])Codex([^A-Za-z]|$)|\.agents/skills|\$CODEX_HOME|Claude Code|\.claude/skills|42-rule|3-skill|TBD|placeholder' AGENTS.md .opencode config docs/reports/2026-09-17-rule-parity-matrix.md 2>/dev/null | grep -vi compatibility >/dev/null; then fail 'stale client wording or placeholder found'; else pass 'no stale client wording or placeholders'; fi
if grep -Fq 'implemented native OpenCode progressive-disclosure rulebook' README.md && grep -Fq '16 native repository skills' ARCHITECTURE.md && ! grep -Eiq '(installer|runtime).*(is complete|has been completed|implemented and ready)' README.md ARCHITECTURE.md; then pass 'current docs do not overclaim installer/runtime'; else fail 'README or ARCHITECTURE current-state claim invalid'; fi

if [ "$failures" -ne 0 ]; then printf '\n%s rulebook verification check(s) failed; %s passed.\n' "$failures" "$passes" >&2; exit 1; fi
printf '\nAll %s rulebook verification checks passed.\n' "$passes"
