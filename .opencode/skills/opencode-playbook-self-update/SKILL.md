---
name: opencode-playbook-self-update
description: Check and safely update an installed OpenCode Playbook when the owner asks, or when the installed rules look stale, incomplete, inconsistent, or corrupt; never replace tailored files without approval and a verified backup.
---

# Self-update procedure

Use this procedure only when the owner asks for an update check or when the
installed playbook looks wrong, missing, internally inconsistent, or older than
the public source. A routine task does not perform a network check merely
because this skill exists.

## Establish the installed and available versions

1. Read the installed version from the `This rulebook is version` line in the
   active global `AGENTS.md`. If that line is missing or malformed, report the
   copy as unverifiable rather than inventing a version.
2. Fetch the public source of truth without authentication:

   ```sh
   curl -fsS --proto =https --max-redirs 0 https://raw.githubusercontent.com/nice-michel/opencode-playbook/main/VERSION
   ```

3. Validate that the response is one bare semantic version. A failed fetch,
   redirect to an unexpected host, HTML response, or malformed value is a
   failed check; report it instead of guessing from tags or memory.
4. Compare semantic-version components numerically. Equal means current; a
   lower installed version means an update is available; a higher installed
   version means the local copy may be ahead or tailored and must not be
   replaced automatically.
5. When an update is available, read the public `CHANGELOG.md` for every version
   after the installed one and summarize the behavioral difference in plain
   language.

## Replacement gate

An update replaces a global instruction file and managed skills that may have
been tailored. It is therefore a protected wholesale replacement under the
approval table. **Stop and ask before replacement**, naming:

- installed and available versions;
- the important changes;
- active global file and skill destinations;
- whether local files differ from their last known installed source; and
- that replacement can proceed only if the future install and restore procedures exist and verify a recovery checkpoint.

Approval to check is not approval to replace. Do not interpret a general build
request as update approval.

## Approved update

1. Obtain and bind a clean checkout of the exact approved public release to
   an absolute `release_checkout` path. This checkout is task-owned evidence,
   not a modification of the current project and not replacement of the active
   installation. Retain and report its path at close-out; do not promise
   destructive cleanup.

2. Verify the checkout revision, VERSION, and repository verification before
   touching an installation. The checkout revision must be the approved public
   release and its `VERSION` must equal the version approved for replacement;
   run the checkout's documented repository verification from that bound path.

3. Test only the bound executable procedures:

   ```sh
   test -x "$release_checkout/scripts/install.sh" && \
     test -x "$release_checkout/scripts/restore.sh"
   ```

   If either path is absent, report that automated safe replacement is unavailable and stop before any installation write. Do not improvise a
   partial manual replacement.

4. Execute only the verified, bound installer:

   ```sh
   "$release_checkout/scripts/install.sh" --replace-agents
   ```

5. Confirm the installer reports its verified checkpoint, global rules target,
   skill root, and installed version.
6. Start a fresh OpenCode session; instruction discovery occurs at session start.
7. Run the installed-copy verification documented by that release.
8. Use only the bound restore path if recovery is required:

   ```sh
   "$release_checkout/scripts/restore.sh" <exact-checkpoint-path>
   ```

   Report the recovery command using the exact checkpoint path. Never print
   credentials, tokens, or the contents of tailored secret-bearing files while
   comparing installations.

If installation or verification fails, leave the previous installation in
place or restore the verified checkpoint. Never continue with a partial mix of
versions.
