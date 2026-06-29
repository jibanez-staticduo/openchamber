---
id: TASK-005-sync-build-install-electron-linux
complexity: standard
track: implementation
slice: qa
status: done
scr: null
parent: null
assigned_to: developer
handoff_from: product_manager
reopened_count: 0
---

# Task: TASK-005 - Sync Upstream, Rebuild Linux Electron App, Install Locally and on Fedora

## Classification

- Complexity: standard
- Track: implementation
- Slice: qa

## Objective

Bring the current `jibanez-linux-electron-app` branch up to date with `upstream/main`, preserve the existing Linux Electron AppImage packaging/install work, rebuild the Linux Electron app, install the rebuilt AppImage on this host and on SSH host `fedora`, and record evidence.

## Context

- Current branch before task setup: `jibanez-linux-electron-app`.
- `upstream/main` fetched at `f9339968` / tag `v1.13.8`.
- Branch was observed `3` commits ahead and `23` commits behind `upstream/main`.
- Existing user/previous-agent StaticEng change is present in `.staticeng/evidences/TASK-004-install-fedora-appimage/SUMMARY.md`; do not revert it.
- Prior Fedora install paths from TASK-004:
  - AppImage: `/home/staticduo/.local/opt/openchamber/OpenChamber.AppImage`
  - Wrapper: `/home/staticduo/.local/bin/openchamber-desktop`
  - Desktop launcher: `/home/staticduo/.local/share/applications/openchamber.desktop`
  - Icon: `/home/staticduo/.local/share/icons/hicolor/256x256/apps/openchamber.png`
- Prior local build artifact pattern: `packages/electron/dist/OpenChamber-<version>-linux-x86_64.AppImage`.

## Required Work

1. Confirm worktree/task state is safe before mutating source:
   - Record `git status --short`, branch name, and recent commits.
   - Treat `.staticeng` closure/evidence edits as valid orchestrator state, not a blocker.
2. Merge latest `upstream/main` into `jibanez-linux-electron-app`.
   - Resolve conflicts minimally.
   - Preserve the Linux Electron packaging/install behavior from the branch unless upstream intentionally supersedes it.
3. Run appropriate install/build validation for the Electron Linux app.
   - Prefer repository scripts from `package.json`.
   - Build the Linux Electron AppImage artifact.
4. Install the rebuilt app on this host for the current user, using the same user-local pattern as the Fedora install where applicable.
5. Install the rebuilt app on SSH host `fedora` for the current user, using the TASK-004 paths and launcher/icon behavior.
6. Validate both installs without requiring sudo:
   - AppImage exists and is executable.
   - Wrapper exists and is executable.
   - Desktop launcher exists and references the wrapper/AppImage correctly.
   - Icon exists.
   - `desktop-file-validate` passes where available.
   - Checksums match the newly built local artifact where copied.
7. Update StaticEng evidence and task artifacts only after verification.

## Acceptance Criteria

- [ ] AC-1: `jibanez-linux-electron-app` contains the latest `upstream/main` changes merged in, with conflicts resolved and no unintended source reverts.
- [ ] AC-2: Linux Electron AppImage build completes successfully and the artifact path/version is recorded.
- [ ] AC-3: Rebuilt AppImage is installed on this host in user-local paths and validated executable with launcher/icon metadata.
- [ ] AC-4: Rebuilt AppImage is installed on SSH host `fedora` in user-local paths and validated executable with launcher/icon metadata.
- [ ] AC-5: Evidence logs include merge status, build output, local install validation, Fedora install validation, and checksum comparison.
- [ ] AC-6: Documentation closure is addressed: either update relevant docs if behavior changed, or explicitly state no product docs were required.

## Expected Evidence

Create `.staticeng/evidences/TASK-005-sync-build-install-electron-linux/` with:

- `SUMMARY.md` mapping AC-1 through AC-6 to verification results.
- `logs/` containing non-secret command output for fetch/merge/status, build, local install, remote install, validation, and checksums.
- `screenshots/` only if a UI screenshot is taken; not required for this install/build task.

## Acceptance Criteria Verification Map

- [ ] AC-1
  - Method: git status/log/diff review after merge
  - Evidence: `.staticeng/evidences/TASK-005-sync-build-install-electron-linux/logs/`
- [ ] AC-2
  - Method: Electron build command result and artifact inspection
  - Evidence: `.staticeng/evidences/TASK-005-sync-build-install-electron-linux/logs/`
- [ ] AC-3
  - Method: local filesystem validation and desktop file validation where available
  - Evidence: `.staticeng/evidences/TASK-005-sync-build-install-electron-linux/logs/`
- [ ] AC-4
  - Method: SSH validation on `fedora`
  - Evidence: `.staticeng/evidences/TASK-005-sync-build-install-electron-linux/logs/`
- [ ] AC-5
  - Method: evidence packet review
  - Evidence: `.staticeng/evidences/TASK-005-sync-build-install-electron-linux/SUMMARY.md`
- [ ] AC-6
  - Method: doc impact statement
  - Evidence: `.staticeng/evidences/TASK-005-sync-build-install-electron-linux/SUMMARY.md`

## Handoff

[Agent Message] From: product_manager To: developer

Please execute TASK-005 exactly as scoped. You may run git merge/build/install commands because the user requested upstream merge, rebuild, and installation. Do not commit unless explicitly asked later by PMA/user. Preserve existing user work and StaticEng evidence edits. If merge conflicts or install blockers require product/technical decisions, stop and report the blocker with a recommended next step.

# Post Implementation Task Updates

## Developer: Post Implementation Expectations

- Status: review.
- Artifact built: `packages/electron/dist/OpenChamber-1.13.8-linux-x86_64.AppImage`.
- Local install completed at `/home/staticduo/.local/opt/openchamber/OpenChamber.AppImage` with wrapper `/home/staticduo/.local/bin/openchamber-desktop`.
- Fedora install completed at `/home/staticduo/.local/opt/openchamber/OpenChamber.AppImage` with wrapper `/home/staticduo/.local/bin/openchamber-desktop`.
- Verification completed: `bun run electron:build`, `bun run type-check:electron`, `bun run lint:electron`, checksum/path validation for local and Fedora installs, and StaticEng validation.
- Evidence packet: `.staticeng/evidences/TASK-005-sync-build-install-electron-linux/SUMMARY.md` and `.staticeng/evidences/TASK-005-sync-build-install-electron-linux/logs/`.
- Documentation closure: no product docs required; StaticEng CodeMap metadata repaired for validation.
