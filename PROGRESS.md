# Progress

## 2026-09-16

- Confirmed that the OpenCode edition will remain a separate repository.
- Approved exact parity with the Codex Playbook's 42-rule `AGENTS.md`.
- Approved OpenCode-native skills, global configuration paths, and a
  checkpoint-first installer and restore workflow.
- Approved a distinct visual identity within the existing playbook family.
- Recorded the initial-release design for owner review.
- Approved the written specification and prepared the test-first implementation
  plan for owner review.
- Established the governing `AGENTS.md` with verified byte-for-byte parity to
  the Codex Playbook: 42 numbered rules and 13,126 matching bytes.
- Accepted ADR 0001 for a separate OpenCode-native repository and documented
  the source-to-client adaptation boundary with current official references.
- Defined the always-loaded authority, progressive-disclosure skill layer,
  four-target managed write set, backup root, and one resolved trust boundary.
- Corrected the configuration model to reflect OpenCode 1.18.31 artifact
  behavior: `OPENCODE_CONFIG_DIR` is effective for global instructions and
  skill discovery, with an XDG-aware default when it is absent.
- Initial-release implementation remains in progress: native skills,
  installation and restore tooling, lifecycle tests, public documentation,
  visual QA, and publication are later planned slices.
