#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PACKAGE_DIR=$(cd "$SCRIPT_DIR/.." && pwd)
DIST_DIR=${1:-"$PACKAGE_DIR/dist"}
APPIMAGE_PATH=${2:-}

if [[ -z "$APPIMAGE_PATH" ]]; then
  shopt -s nullglob
  candidates=("$DIST_DIR"/OpenChamber-*-linux-*.AppImage "$DIST_DIR"/*.AppImage)
  shopt -u nullglob
  if (( ${#candidates[@]} == 0 )); then
    echo "No AppImage found in $DIST_DIR" >&2
    echo "Build one first with: bun run electron:build" >&2
    exit 1
  fi

  newest=""
  newest_mtime=0
  for candidate in "${candidates[@]}"; do
    mtime=$(stat -c %Y "$candidate")
    if (( mtime > newest_mtime )); then
      newest=$candidate
      newest_mtime=$mtime
    fi
  done
  APPIMAGE_PATH=$newest
fi

if [[ ! -f "$APPIMAGE_PATH" ]]; then
  echo "AppImage not found: $APPIMAGE_PATH" >&2
  exit 1
fi

APP_DIR=${OPENCHAMBER_APPIMAGE_INSTALL_DIR:-"$HOME/.local/opt/openchamber"}
BIN_DIR=${OPENCHAMBER_APPIMAGE_BIN_DIR:-"$HOME/.local/bin"}
APPLICATIONS_DIR=${XDG_DATA_HOME:-"$HOME/.local/share"}/applications
ICONS_DIR=${XDG_DATA_HOME:-"$HOME/.local/share"}/icons/hicolor
APPIMAGE_DEST="$APP_DIR/OpenChamber.AppImage"
WRAPPER="$BIN_DIR/openchamber-desktop"
DESKTOP_FILE="$APPLICATIONS_DIR/openchamber.desktop"
ICON_SOURCE="$PACKAGE_DIR/resources/icons/icon.png"
EXEC_ESCAPED=$(printf '%s' "$WRAPPER" | sed 's/\\/\\\\/g; s/"/\\"/g')

mkdir -p "$APP_DIR" "$BIN_DIR" "$APPLICATIONS_DIR" "$ICONS_DIR/256x256/apps"
install -m 0755 "$APPIMAGE_PATH" "$APPIMAGE_DEST"

cat > "$WRAPPER" <<EOF_WRAPPER
#!/usr/bin/env bash
exec "$APPIMAGE_DEST" "\$@"
EOF_WRAPPER
chmod 0755 "$WRAPPER"

if [[ -f "$ICON_SOURCE" ]]; then
  install -m 0644 "$ICON_SOURCE" "$ICONS_DIR/256x256/apps/openchamber.png"
fi

cat > "$DESKTOP_FILE" <<EOF_DESKTOP
[Desktop Entry]
Type=Application
Name=OpenChamber
Comment=Desktop runtime for OpenChamber
Exec="$EXEC_ESCAPED" %U
Icon=openchamber
Terminal=false
Categories=Development;
StartupWMClass=openchamber
EOF_DESKTOP

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$APPLICATIONS_DIR" >/dev/null 2>&1 || true
fi
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
  gtk-update-icon-cache -f -t "$ICONS_DIR" >/dev/null 2>&1 || true
fi
if command -v desktop-file-validate >/dev/null 2>&1; then
  desktop-file-validate "$DESKTOP_FILE"
fi

echo "Installed OpenChamber AppImage to $APPIMAGE_DEST"
echo "Installed launcher to $DESKTOP_FILE"
echo "Run from terminal with: $WRAPPER"
