# Security Policy

## Supported version

There is no installable release at planning version 0.0.1. The planned 0.1.0
release supports stable OpenCode 1.18.31 only. Other OpenCode versions,
including v2, require a new compatibility audit before support is claimed.

## Reporting a vulnerability

Use GitHub private vulnerability reporting for
`nice-michel/opencode-playbook`. The planning-checkpoint publication gate
creates the public repository, immediately enables private vulnerability
reporting through the GitHub REST API, and verifies the private endpoint before
implementation begins.

If the private reporting control is not visible, do not publish vulnerability
details in an issue, discussion, pull request, commit, or transcript. Stop and
report only that the private channel is unavailable so repository ownership and
security configuration can be corrected without disclosing the flaw.

A useful private report includes the affected version or commit, exact managed
path or runtime surface, reproduction steps, impact, recovery requirements, and
whether secrets or user configuration may have been exposed. Never include a
live credential.

## Release policy

A known fixable vulnerability blocks release until fixed. An advisory without
a safe resolution blocks release and is escalated with its identifier,
exposure, and available options. Release evidence distinguishes repository
dependencies from the externally installed OpenCode client.
