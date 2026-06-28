# DISCUSSION-002 - Plan Linux Desktop App For OpenChamber Host Selector

## Summary
The user asked why OpenChamber's Chrome-installed Linux PWA lacks the host selector available in macOS/Windows apps, and how difficult it would be to build a Linux app with the same selector.

## Outcome
- Classified as `standard` / `investigation` / `foundation`.
- Created and completed `TASK-002-linux-desktop-feasibility`.
- Determined that the host selector depends on Electron preload globals and IPC, not normal browser/PWA APIs.
- Determined that Linux support is mainly a packaging/release gap; the desktop host selector architecture is already largely platform-neutral.

## Recommended Follow-Up
Create a standard implementation task for a Linux Electron packaging spike targeting AppImage first, then optional deb/rpm and release updater support.
