---
id: SCR-001-linux-electron-desktop
status: approved
owner: product_manager
created: 2026-06-28
---

# SCR-001 - Linux Electron Desktop Packaging

## Product Change
Ship a Linux Electron desktop build of OpenChamber so Linux users can access the same desktop-only host selector and runtime switching available in macOS and Windows builds.

## Rationale
The Chrome-installed PWA cannot expose Electron preload globals or IPC, so it cannot support desktop host switching. Linux needs the Electron shell, not a web-only install path.

## Scope
- Add Linux packaging support to the existing Electron desktop package.
- Preserve upstream mergeability by keeping changes small, localized, and aligned with existing Electron patterns.
- Install a local Linux desktop launcher for this machine after building.

## Acceptance Criteria
- AC-1: Electron Builder has a supported Linux target configuration, starting with AppImage.
- AC-2: Linux desktop identity is stable for GNOME/Wayland: executable name, desktop file, icon name, and runtime desktop name are aligned.
- AC-3: Documentation explains Linux packaging and local install/update expectations.
- AC-4: The build/package path is validated far enough to produce or identify a clear environment blocker.
- AC-5: A local desktop installation is performed when an AppImage is produced.

## Notes
A prior spike indicated unsupported Electron Builder keys should be avoided. Use supported `linux.executableName`, `desktop.StartupWMClass`, and AppImage-first packaging.
