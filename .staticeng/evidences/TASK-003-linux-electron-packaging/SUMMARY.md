# TASK-003 Linux Electron Packaging Evidence

## Reopen 1 Result

QA reported that electron-builder 26.8.1 rejects root `build.desktopName`. The unsupported root key was removed. Linux identity is preserved through supported config/runtime settings: `linux.executableName=openchamber`, generated AppImage desktop entry `openchamber.desktop`, `Icon=openchamber`, `StartupWMClass=openchamber`, and `app.setDesktopName('openchamber.desktop')` on Linux.

## Acceptance Criteria

- AC-1: PASS. Linux packaging config uses supported electron-builder 26.8.1 options for this task and avoids known unsupported keys: no root `build.desktopName`, no `linux.syncDesktopName`, and no `linux.packageName`. `bun run electron:build` now reaches and completes AppImage packaging. See `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-linux-packaging-identity-check.txt` and `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-bun-electron-build.txt`.
- AC-2: PASS. Linux identity is aligned around `linux.executableName=openchamber`, AppImage desktop file `openchamber.desktop`, desktop entry `Icon=openchamber`, `StartupWMClass=openchamber`, Linux PNG window icon handling, and runtime `app.setDesktopName('openchamber.desktop')`. Extracted AppImage desktop entry confirms `squashfs-root/openchamber.desktop`. See `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-appimage-desktop-entry.txt`.
- AC-3: PASS. `packages/electron/scripts/install-linux-appimage.sh` installs/updates a current-user AppImage launcher. Real artifact install completed after the successful AppImage build. See `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-install-linux-appimage-real-artifact.txt` and `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-installed-paths-verify.txt`.
- AC-4: PASS. Existing docs were updated in `packages/electron/README.md`, `packages/docs/content/docs/desktop-browser.mdx`, and `CONTRIBUTING.md` with Linux AppImage build/install notes and current-user limitations.
- AC-5: PASS. Reopen validation evidence is recorded: Bun availability, JSON parse, Node syntax checks, shell syntax check, static identity checks, Electron type-check/lint, full Electron build/AppImage packaging, AppImage desktop extraction, real AppImage install, and installed-path verification.
- AC-6: PASS. AppImage `packages/electron/dist/OpenChamber-1.13.7-linux-x86_64.AppImage` was produced and installed locally for the current user at `~/.local/opt/openchamber/OpenChamber.AppImage`, with wrapper, desktop entry, and icon present.

## Final PMA Review Updates

- Addressed critic feedback by keeping the task file in `done` state with checked acceptance criteria, moving it to `.staticeng/tasks/done/`, clearing the active task registry, selecting the newest AppImage by mtime in the install script, and quoting the generated desktop `Exec` path.
- Re-ran focused validation after those changes: `bash -n`, Electron type-check, Electron lint script, real AppImage install, `desktop-file-validate`, and installed-path checks all passed.
- Launched the installed AppImage through `~/.local/bin/openchamber-desktop`; OpenChamber AppImage and renderer processes were observed after startup.
- Evidence logs are force-added because the repository ignores generic `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/` directories.

## Reopen Validation Logs

- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-bun-version.txt` - Bun 1.3.14 available from user-local install.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-json-parse-package-json.txt` - root and Electron package JSON parse passed.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-node-check-main.txt` - Electron main syntax check passed.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-node-check-preload.txt` - Electron preload syntax check passed.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-bash-n-install-linux-appimage.txt` - install script shell syntax check passed.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-linux-packaging-identity-check.txt` - unsupported key guard and Linux identity assertions passed.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-bun-type-check-electron.txt` - `bun run --cwd packages/electron type-check` passed.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-bun-lint-electron.txt` - `bun run --cwd packages/electron lint` passed.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-bun-electron-build.txt` - `bun run electron:build` passed and produced the Linux AppImage.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-appimage-desktop-entry.txt` - extracted AppImage desktop entry is `openchamber.desktop` with `Icon=openchamber` and `StartupWMClass=openchamber`.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-install-linux-appimage-real-artifact.txt` - real AppImage install script completed successfully.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/reopen-installed-paths-verify.txt` - current-user AppImage, wrapper, desktop entry, and icon are present.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/pma-final-validation.txt` - final PMA validation after critic fixes passed.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/pma-launch-smoke.txt` - installed AppImage launch smoke observed running processes.

## Prior QA Failure Logs Retained

- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/bun-electron-build.txt` - prior QA build failed because electron-builder 26.8.1 rejected unsupported root `desktopName`.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/install-linux-appimage-real-artifact.txt` - prior real install path was blocked because no AppImage existed before the reopen fix.
- `.staticeng/evidences/TASK-003-linux-electron-packaging/logs/installed-paths-verify.txt` - prior installed-path verification before reopen fix.
