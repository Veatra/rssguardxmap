# Instructions for agents working on this fork

## Repository and automatic pushes

This is the user's fork: https://github.com/Veatra/rssguard.git.
The upstream project is a reference, not a write destination.

The user explicitly authorizes agents to commit completed task changes and
push every commit they create directly to this fork without asking for an
additional confirmation. After appropriate validation, commit task changes
and push the current branch to the fork before finishing. Unless the user
requests another branch, work on and push `master`.

Before pushing, verify the destination resolves to `github.com/Veatra/rssguard`.
Never push to martinrotter/rssguard or any other upstream repository. Do not
force-push, rewrite published history, merge unrelated changes, commit secrets,
or include unrelated user edits. Preserve existing work. If access fails or a
push is rejected, report the precise blocker; do not bypass protections.
Explicit instructions from the user for the current task take precedence.

## Windows 8.1 XMPP work

Preserve both text (QTextBrowser) and web (Qt WebEngine) Windows 8.1 x64 variants.
The pipeline is `.github/workflows/windows81.yml`; build, compatibility patches,
and target-machine validation instructions are in `resources/scripts/windows81/`.
Keep dependency source pins, matching Qt modules and plugins, QXmpp, OpenSSL,
and the patched Go runtime coherent. Never mix Qt 5 and Qt 6 DLLs or overlay
unrelated compatibility binaries into a deployed application.

Read `resources/scripts/windows81/README.md` and `PATCHES.md` before changing
these builds. Run appropriate checks, including the PubSub TLS/fetch/push tests
and viewer smoke tests where available. Compilation or Linux tests alone do
not establish Windows 8.1 compatibility. Report native build and Windows 8.1
runtime results separately, and retain candidate labeling until supported by
target-machine evidence.

## Workspace

Use the existing checkout. Cloud tasks are already isolated; do not create a
Git worktree unless the user explicitly requests one.
