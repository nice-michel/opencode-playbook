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
2. **Say what you actually think.** Give me your honest best judgment, led with your recommendation and its reason. No pleasing, flattery, or disguising “this is worse” as “interesting.” If you do not know, say so.
3. **Push back on real things.** Debate a wrong assumption, a hidden cost, or a better route. Never debate for theater.
4. **Being overruled changes nothing.** When I decide differently, keep your dissent on record and execute my decision fully. Reopen it only with new evidence or a newly discovered cost.
5. **Do the right thing, not the lazy or easy thing.** When these rules do not cover a case, optimize for production use by many users across environments and over time. Quality is non-negotiable; work that only looks finished or claims without evidence is worthless.

I want an independent, opinionated model that is not afraid to say what it really thinks. Agreeing with me is not the job.
EOF

for path in AGENTS.md VERSION config/managed-skills.txt config/rule-manifest.tsv docs/reports/2026-09-17-rule-parity-matrix.md
do
  if [ -f "$path" ]; then pass "$path exists"; else fail "$path is missing"; fi
done
bytes=$(wc -c < AGENTS.md | tr -d ' ')
if [ "$bytes" -le 12288 ]; then pass "AGENTS.md byte budget: $bytes"; else fail "AGENTS.md is $bytes bytes; max 12288"; fi
if grep -Fxf "$test_root/mantra" AGENTS.md >/dev/null 2>&1; then pass 'exact full mantra and coda'; else fail 'full mantra or coda differs'; fi
if [ "$(cat VERSION)" = 0.0.2 ] && grep -Fq '**This rulebook is version 0.0.2**' AGENTS.md; then pass 'version carriers match'; else fail 'VERSION and AGENTS must match 0.0.2'; fi

for section in '## Authority' '## Classify the Request Before Acting' '## Approval Table — the Complete List' '## Mandatory Skill Router' '## OpenCode Loading Model' 'github.com/nice-michel/opencode-playbook' 'stable OpenCode 1.18.31 exactly'
do
  if grep -Fq "$section" AGENTS.md; then pass "router has $section"; else fail "router missing $section"; fi
done
rows=$(sed -n '/^## Approval Table — the Complete List$/,/^## Mandatory Skill Router$/p' AGENTS.md | grep -Ec '^\| ' || true)
if [ "$rows" -eq 10 ]; then pass 'approval table has header and nine closed rows'; else fail "approval table has $rows lines; expected 10"; fi
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
  if [ -f "$file" ] && grep -Fxq "name: $skill" "$file" && [ "$(grep -Ec '^description: .+' "$file")" -eq 1 ]; then pass "$skill metadata"; else fail "$skill metadata or file"; fi
  matches=$(sed -n '/^## Mandatory Skill Router$/,/^## OpenCode Loading Model$/p' AGENTS.md | grep -Foc "$skill" || true)
  if [ "$matches" -eq 1 ]; then pass "$skill router mention"; else fail "$skill router mention count $matches"; fi
done < "$test_root/skills"
count=$(find .opencode/skills -mindepth 2 -maxdepth 2 -name SKILL.md -path '*/opencode-playbook-*/*' 2>/dev/null | wc -l | tr -d ' ')
if [ "$count" -eq 16 ]; then pass 'all and only 16 managed native skills'; else fail "managed native skills: $count"; fi

: > "$test_root/occurrences"
for file in AGENTS.md .opencode/skills/opencode-playbook-*/SKILL.md
do
  [ -f "$file" ] || continue
  grep -Eho '^[0-9]+\.[0-9]+ \*\*' "$file" | sed 's/ \*\*$//' | while IFS= read -r id
  do printf '%s\t%s\n' "$id" "$file"; done >> "$test_root/occurrences"
done
cut -f1 "$test_root/occurrences" | LC_ALL=C sort -V -u > "$test_root/actual-ids"
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
if grep -RInE '(^|[^A-Za-z])Codex([^A-Za-z]|$)|\.agents/skills|\$CODEX_HOME|Claude Code|\.claude/skills|42-rule|3-skill|TBD|placeholder' AGENTS.md .opencode config docs/reports/2026-09-17-rule-parity-matrix.md 2>/dev/null | grep -vi compatibility >/dev/null; then fail 'stale client wording or placeholder found'; else pass 'no stale client wording or placeholders'; fi
if grep -Fq 'implemented native OpenCode progressive-disclosure rulebook' README.md && grep -Fq '16 native repository skills' ARCHITECTURE.md && ! grep -Eiq '(installer|runtime).*(is complete|has been completed|implemented and ready)' README.md ARCHITECTURE.md; then pass 'current docs do not overclaim installer/runtime'; else fail 'README or ARCHITECTURE current-state claim invalid'; fi

if [ "$failures" -ne 0 ]; then printf '\n%s rulebook verification check(s) failed; %s passed.\n' "$failures" "$passes" >&2; exit 1; fi
printf '\nAll %s rulebook verification checks passed.\n' "$passes"
