# Architecture

OpenCode Playbook is an installable documentation product. The governing
agreement will live in one always-loaded `AGENTS.md`; detailed procedures will
live in OpenCode-native skills and load only when relevant.

The supported installer will manage only the playbook's global instructions
and namespaced skills under `~/.config/opencode/`. It will not rewrite
`opencode.json` or unrelated user configuration. Every installation and restore
will be preceded by a verified recovery checkpoint.

The complete approved design is in
[`docs/superpowers/specs/2026-09-16-opencode-playbook-initial-release-design.md`](docs/superpowers/specs/2026-09-16-opencode-playbook-initial-release-design.md).

