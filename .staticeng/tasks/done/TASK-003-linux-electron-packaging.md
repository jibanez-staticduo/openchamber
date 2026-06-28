---
id: TASK-003-linux-electron-packaging
complexity: standard
track: implementation
slice: foundation
status: done
scr: SCR-001-linux-electron-desktop
parent: null
assigned_to: developer
handoff_from: product_manager
reopened_count: 1
---

# Task: TASK-003-linux-electron-packaging - Linux Electron App Packaging

## Classification
- **complexity:** standard
- **track:** implementation
- **slice:** foundation

## Objective
Implement Linux Electron packaging for OpenChamber, preserving upstream mergeability and enabling the Linux desktop app to expose the host selector.

## Scope
- Add supported Electron Builder Linux package configuration, starting with AppImage.
- Align Linux desktop app identity for GNOME/Wayland.
- Add any minimal scripts needed for local installation of the produced AppImage.
- Update existing desktop docs with Linux-specific packaging/install notes.
- Validate with scoped Electron type-check/lint and package/build commands as far as environment allows.

## Non-Goals
- Do not rework host selector UI or runtime switching behavior unless required by Linux packaging.
- Do not add unrelated desktop features such as Linux tray support or installed-app discovery.
- Do not introduce speculative release workflows beyond a clean local packaging path unless clearly minimal.

## Acceptance Criteria
- [x] AC-1: Linux packaging config uses supported Electron Builder options and avoids known unsupported keys.
- [x] AC-2: Linux identity is aligned across executable name, desktop file, StartupWMClass, app desktop name, and icon naming.
- [x] AC-3: Local install/update path for the Linux AppImage is implemented or clearly documented with commands.
- [x] AC-4: Documentation in existing desktop docs covers Linux build/install notes and limitations.
- [x] AC-5: Validation evidence is recorded, including successful commands or exact blockers.
- [x] AC-6: If an AppImage is produced, it is installed locally for the current user.

## Expected Evidence
Create `.staticeng/evidences/TASK-003-linux-electron-packaging/` with:
- `SUMMARY.md` mapping AC-1 through AC-6 to verification results.
- `logs/` containing non-secret command outputs for validation/build/install.
- `screenshots/` only if a UI screenshot is captured.

## Reopen History

### Reopen 1 - 2026-06-28
- QA found a same-scope implementation defect: electron-builder 26.8.1 rejects root `build.desktopName` as an unsupported config key, so `bun run electron:build` fails before AppImage packaging.
- Required fix: remove/replace unsupported root `desktopName` while preserving Linux identity through supported settings: `linux.executableName=openchamber`, desktop entry `Icon=openchamber`, `StartupWMClass=openchamber`, and Linux runtime `app.setDesktopName('openchamber.desktop')`.
- Rerun scoped validation/build/install if possible now that Bun is available user-locally, and update evidence.

## Handoff
[Agent Message] From: product_manager To: developer
Implement TASK-003 in `/home/staticduo/git/openchamber`. Keep changes minimal and upstream-mergeable. Use existing Electron package patterns. Do not modify unrelated UI behavior. Prior memory says `linux.syncDesktopName` and `linux.packageName` are unsupported in installed Electron Builder, so avoid them. Prefer AppImage first, identity `openchamber`, desktop file `openchamber.desktop`, `StartupWMClass=openchamber`, and runtime `app.setDesktopName('openchamber.desktop')`. Produce evidence and return Summary, Work Performed, Acceptance Criteria Coverage, Documentation Impact, Open Risks, Recommended Next Step.

[Agent Message] From: product_manager To: developer
QA found root `build.desktopName` is also unsupported by electron-builder 26.8.1. Reopen TASK-003, remove the unsupported key, preserve Linux identity through supported Linux config/runtime settings, rerun validation/build/install as far as possible, and update evidence.
