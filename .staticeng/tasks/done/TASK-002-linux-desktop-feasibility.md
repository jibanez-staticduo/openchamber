---
id: TASK-002-linux-desktop-feasibility
complexity: standard
track: investigation
slice: foundation
status: done
scr: null
parent: null
assigned_to: explorer
handoff_from: product_manager
reopened_count: 0
---

# Task: TASK-002-linux-desktop-feasibility - Linux Desktop Host Selector Feasibility

## Classification
- **complexity:** standard
- **track:** investigation
- **slice:** foundation

## Objective
Determine how OpenChamber's existing macOS/Windows Electron desktop app enables the host selector and what is required to ship the same capability on Linux.

## Context
The user can install the web UI as a Chrome PWA on Linux, but that installed web app does not show or support the host selector. They want to know what macOS/Windows desktop builds have that Linux currently lacks and how complicated it is to make a Linux version.

## Scope
- Inspect the existing Electron desktop architecture and host selector flow.
- Identify package/build configuration gaps for Linux.
- Identify platform-specific code that already supports Linux vs code that blocks Linux.
- Produce a feasibility estimate and implementation plan only; do not modify application code.

## Acceptance Criteria
- [ ] AC-1: Explain why Chrome/PWA install on Linux lacks host selector behavior.
- [ ] AC-2: Identify the desktop-specific components responsible for host selection and runtime switching.
- [ ] AC-3: Identify the minimum build/release changes needed for Linux packaging.
- [ ] AC-4: Estimate complexity, risks, and recommended implementation phases.

## Expected Evidence
For this investigation, return a concise handoff with file references and line-level evidence where useful. No implementation evidence packet is required because no product code changes are authorized.

## Discussion Record
- Active discussion: `DISCUSSION-002` - Plan Linux Desktop App For OpenChamber Host Selector

## Handoff
[Agent Message] From: product_manager To: explorer
Please inspect the repository and answer AC-1 through AC-4. Focus on `packages/electron`, `packages/ui/src/lib/desktop*.ts`, host switcher/onboarding UI, and Electron build config. Do not modify code. Return: Summary, Work Performed, Acceptance Criteria Coverage, Documentation Impact, Open Risks, Recommended Next Step.

## Explorer Findings
[Agent Message] From: explorer To: product_manager

Summary: Linux desktop host selector is feasible with low-to-medium application-code risk. The architecture is already Electron-based and largely platform-neutral; the main gap is Linux packaging/release configuration rather than host selector logic.

Acceptance criteria coverage:
- [x] AC-1: Chrome/PWA lacks host selector because the selector depends on Electron preload globals and IPC (`__OPENCHAMBER_ELECTRON__`, `__OPENCHAMBER_DESKTOP__`) that a browser-installed PWA cannot expose.
- [x] AC-2: Host selection is owned by Electron main/preload plus shared UI wrappers: `packages/electron/main.mjs`, `packages/electron/preload.mjs`, `packages/ui/src/lib/desktopHosts.ts`, `packages/ui/src/lib/desktop.ts`, and `packages/ui/src/components/desktop/DesktopHostSwitcher.tsx`.
- [x] AC-3: Minimum Linux work is adding Electron Builder Linux targets and CI/release jobs; current config defines macOS and Windows targets only.
- [x] AC-4: Recommended path is a Linux packaging spike followed by manual/CI smoke validation on Linux for first launch, local runtime, remote host add/probe/switch, restart, and reopen.

Key risks:
- Native module rebuilds on Ubuntu/Fedora must be proven (`node-pty`, `bun-pty`, and related native dependencies).
- Linux icon/app identity likely needs PNG/freedesktop cleanup; current window icon path includes Linux but points to `.ico`.
- Adjacent desktop features such as installed-app discovery and tray behavior are macOS/Windows-only, but they should not block host selector.
- Linux auto-update behavior depends on package target; AppImage is the lowest-friction first target.

## Product Manager Closure
- Investigation complete; no product code changes were authorized or made.
- Documentation update is recommended only if implementation proceeds.
- Recommended next task: standard / implementation / foundation for Linux Electron packaging spike.
