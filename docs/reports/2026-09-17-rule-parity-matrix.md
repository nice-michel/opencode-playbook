# Rule parity matrix

This matrix proves that the 49 canonical rule identifiers from Claude Playbook 0.1.12 and the mature pinned modular delivery reference at 0.1.3 have a present OpenCode-native owner. The manifest is the machine-readable authority; this table is the human review record.

## Mechanical adaptations

- Repository skills use `.opencode/skills/opencode-playbook-*/SKILL.md`; installed skills resolve under `<OpenCode config root>/skills/`.
- The supported release target is stable OpenCode 1.18.31 exactly. OpenCode v2 and other versions are untested and unsupported.
- The global root is non-empty `OPENCODE_CONFIG_DIR`, otherwise `${XDG_CONFIG_HOME:-$HOME/.config}/opencode`; global instructions load first and project instructions win conflicts.
- A first matching `AGENTS.md` versus `CLAUDE.md` is only a within-scope fallback. Compatibility `.agents/skills` and `.claude/skills` remain additive and unmanaged.
- The native skill tool loads the selected full body on demand. The installer scope is only `AGENTS.md` plus the 16 namespaced skills; OpenCode JSON, auth, providers, plugins, sessions, and unrelated skills are excluded.
- Model references use capability tiers (deep, standard, fast), not provider product names. The self-update source is `github.com/nice-michel/opencode-playbook`.

## Canonical coverage

| Rule ID | OpenCode owner | Parity disposition |
| --- | --- | --- |
| 0.1 | AGENTS.md | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 0.2 | AGENTS.md | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 0.3 | AGENTS.md | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 0.4 | AGENTS.md | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 1.1 | opencode-playbook-code | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 1.2 | opencode-playbook-code | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 1.3 | opencode-playbook-code | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 1.4 | opencode-playbook-code | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 1.5 | opencode-playbook-code | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 1.6 | opencode-playbook-code | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 2.1 | opencode-playbook-testing | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 2.2 | opencode-playbook-testing | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 2.3 | opencode-playbook-testing | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 3.1 | opencode-playbook-reviews | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 3.2 | opencode-playbook-reviews | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 3.3 | opencode-playbook-reviews | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 3.4 | opencode-playbook-reviews | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 4.1 | opencode-playbook-documentation | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 4.2 | opencode-playbook-documentation | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 4.3 | opencode-playbook-documentation | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 5.1 | opencode-playbook-repository | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 5.2 | opencode-playbook-repository | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 5.3 | opencode-playbook-repository | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 6.1 | opencode-playbook-workflow | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 6.2 | opencode-playbook-workflow | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 6.3 | opencode-playbook-workflow | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 6.4 | opencode-playbook-workflow | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 7.1 | opencode-playbook-collaboration | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 7.2 | opencode-playbook-collaboration | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 7.3 | opencode-playbook-collaboration | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 7.4 | opencode-playbook-collaboration | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 7.5 | opencode-playbook-collaboration | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 7.6 | opencode-playbook-collaboration | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 7.7 | opencode-playbook-collaboration | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 8.1 | opencode-playbook-subagents | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 9.1 | opencode-playbook-environment | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 9.2 | opencode-playbook-environment | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 9.3 | opencode-playbook-environment | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 9.4 | opencode-playbook-environment | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 9.5 | opencode-playbook-environment | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 9.6 | opencode-playbook-environment | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 10.1 | opencode-playbook-destructive / quarantine | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 10.2 | opencode-playbook-destructive / quarantine | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 10.3 | opencode-playbook-destructive / quarantine | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 11.1 | three platform skills | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 12.1 | opencode-playbook-writing | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 12.2 | opencode-playbook-writing | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 12.3 | opencode-playbook-writing | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |
| 12.4 | opencode-playbook-writing | Preserved doctrine; adapted only to native OpenCode loading and generic capability tiers. |

Rule 11.1 intentionally has three native platform bodies. Its wildcard manifest owner requires exactly Linux/WSL, macOS, and native Windows implementations; no other rule has more than one owner.
