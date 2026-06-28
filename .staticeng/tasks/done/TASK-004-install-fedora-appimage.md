---
id: TASK-004-install-fedora-appimage
complexity: tiny
track: implementation
slice: qa
status: done
scr: SCR-001-linux-electron-desktop
parent: TASK-003-linux-electron-packaging
assigned_to: qa_engineer
handoff_from: product_manager
reopened_count: 0
---

# Task: TASK-004-install-fedora-appimage - Install Linux AppImage On Fedora

## Classification
- **complexity:** tiny
- **track:** implementation
- **slice:** qa

## Objective
Install the built OpenChamber Linux AppImage on the remote Fedora host via SSH, using the same current-user desktop integration as the local install.

## Scope
- Copy the existing built AppImage and required icon/install assets to host `fedora` over SSH.
- Install for the remote `staticduo` user only; no sudo/system package changes.
- Verify remote AppImage, wrapper, desktop file, icon, and desktop-file validation when available.

## Acceptance Criteria
- [x] AC-1: AppImage is present and executable on `fedora` under `~/.local/opt/openchamber/OpenChamber.AppImage`.
- [x] AC-2: Wrapper exists at `~/.local/bin/openchamber-desktop`.
- [x] AC-3: Desktop launcher exists at `~/.local/share/applications/openchamber.desktop` with `Icon=openchamber` and `StartupWMClass=openchamber`.
- [x] AC-4: Icon exists under remote hicolor user icon path.
- [x] AC-5: Evidence logs capture copy/install/verification results.

## Expected Evidence
Create `.staticeng/evidences/TASK-004-install-fedora-appimage/` with:
- `SUMMARY.md` mapping AC-1 through AC-5 to verification results.
- `logs/` containing non-secret SSH/SCP command outputs.

## Handoff
[Agent Message] From: product_manager To: qa_engineer
Install the built AppImage from `/home/staticduo/git/openchamber/packages/electron/dist/OpenChamber-1.13.7-linux-x86_64.AppImage` on SSH host `fedora`. Use user-local paths only. Do not use sudo. Prefer copying only the AppImage plus `packages/electron/resources/icons/icon.png` and generating the same wrapper/desktop file remotely. Capture evidence and return the standard StaticEng handoff.
