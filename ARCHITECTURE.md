# Architecture

OpenCode Playbook has an implemented native OpenCode progressive-disclosure rulebook: one lean always-loaded authority router and 16 native repository skills.

## Rule delivery

`AGENTS.md` holds the complete mantra and coda, authority and precedence, request classification, the closed approval table, critical rules 0.1–0.4, and the mandatory skill router. Detailed doctrine lives in 16 native repository skills under `.opencode/skills/opencode-playbook-*/SKILL.md`. Skills carry procedure only; they do not add authority or approval gates.

`config/rule-manifest.tsv` is the canonical ownership map for all 49 rule IDs. Every ID has one owner except rule 11.1, which deliberately has Linux/WSL, macOS, and native Windows implementations under one wildcard manifest owner. `config/managed-skills.txt` is the exact sorted 16-name installation inventory.

## OpenCode loading model

The supported release target is stable OpenCode 1.18.31 exactly; v2 and all other versions are untested and unsupported. A non-empty `OPENCODE_CONFIG_DIR` selects the global root; otherwise it is `${XDG_CONFIG_HOME:-$HOME/.config}/opencode`. OpenCode combines global and project `AGENTS.md`, loading global first and letting project instructions win a conflict. A first matching `AGENTS.md` versus `CLAUDE.md` is only a within-scope fallback.

Repository skills use `.opencode/skills/`; installed skills use `<OpenCode config root>/skills/`. Native skill loading is on demand. Compatibility `.agents/skills` and `.claude/skills` remain additive and unmanaged.

## Managed boundary

The future installer is constrained to `AGENTS.md` and the 16 namespaced skills. It must not manage `opencode.json`, `opencode.jsonc`, authentication, providers, plugins, sessions, or unrelated skills. Installer, restoration, runtime validation, and site delivery are intentionally not claimed as implemented by this rulebook release.
