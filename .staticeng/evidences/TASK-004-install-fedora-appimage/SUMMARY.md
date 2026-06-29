# TASK-004 Install Fedora AppImage Evidence

## Result

OpenChamber AppImage was installed on SSH host `fedora` for the current `staticduo` user only. No sudo or system-wide paths were used.

## Installed Remote Paths

- AppImage: `/home/staticduo/.local/opt/openchamber/OpenChamber.AppImage`
- Wrapper: `/home/staticduo/.local/bin/openchamber-desktop`
- Desktop launcher: `/home/staticduo/.local/share/applications/openchamber.desktop`
- Icon: `/home/staticduo/.local/share/icons/hicolor/256x256/apps/openchamber.png`

## Acceptance Criteria

- AC-1: PASS. AppImage is present and executable at `/home/staticduo/.local/opt/openchamber/OpenChamber.AppImage`; final remote `ls -l` shows mode `-rwxr-xr-x`. See `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/09-remote-validation-final.log`.
- AC-2: PASS. Wrapper exists and is executable at `/home/staticduo/.local/bin/openchamber-desktop`; it execs `/home/staticduo/.local/opt/openchamber/OpenChamber.AppImage`. See `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/09-remote-validation-final.log`.
- AC-3: PASS. Desktop launcher exists at `/home/staticduo/.local/share/applications/openchamber.desktop` with `Exec="/home/staticduo/.local/bin/openchamber-desktop" %U`, `Icon=openchamber`, and `StartupWMClass=openchamber`; `desktop-file-validate` passed. See `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/09-remote-validation-final.log`.
- AC-4: PASS. Icon exists at `/home/staticduo/.local/share/icons/hicolor/256x256/apps/openchamber.png`; checksum matches local source icon. See `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/07-copy-integrity.log` and `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/09-remote-validation-final.log`.
- AC-5: PASS. Evidence logs capture SSH preflight, remote directory creation, SCP copies, install generation, copy integrity, final verification, and final assertions. See `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/01-ssh-preflight.log` through `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/10-final-assertions.log`.

## Evidence Logs

- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/01-ssh-preflight.log`: SSH host/user/home check and available validation tools.
- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/02-remote-create-dirs.log`: User-local target directory creation/verification.
- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/03-scp-appimage.log`: AppImage SCP command output.
- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/04-scp-icon.log`: Icon SCP command output.
- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/05-remote-install-wrapper-desktop.log`: Initial remote install path listing.
- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/06-remote-validation.log`: Initial remote validation before wrapper path normalization.
- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/07-copy-integrity.log`: Local and remote SHA-256 checksums for AppImage and icon.
- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/08-remote-wrapper-absolute-path.log`: Wrapper normalized to absolute AppImage path.
- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/09-remote-validation-final.log`: Final path listing, wrapper/desktop contents, desktop validation, desktop database update, and icon cache update.
- `.staticeng/evidences/TASK-004-install-fedora-appimage/logs/10-final-assertions.log`: Final exact assertions for executable paths, required desktop keys, and desktop validation.

## Validation Commands

- `ssh fedora 'set -euo pipefail; ... command -v desktop-file-validate ...'`
- `scp /home/staticduo/git/openchamber/packages/electron/dist/OpenChamber-1.13.7-linux-x86_64.AppImage fedora:/home/staticduo/.local/opt/openchamber/OpenChamber.AppImage`
- `scp /home/staticduo/git/openchamber/packages/electron/resources/icons/icon.png fedora:/home/staticduo/.local/share/icons/hicolor/256x256/apps/openchamber.png`
- `ssh fedora 'desktop-file-validate "$HOME/.local/share/applications/openchamber.desktop"'`
- `ssh fedora 'update-desktop-database "$HOME/.local/share/applications"'`
- `ssh fedora 'gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor"'`
- `ssh fedora 'test -x "$HOME/.local/opt/openchamber/OpenChamber.AppImage"; test -x "$HOME/.local/bin/openchamber-desktop"; ...; desktop-file-validate "$HOME/.local/share/applications/openchamber.desktop"'`
