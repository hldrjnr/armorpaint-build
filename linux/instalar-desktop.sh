#!/usr/bin/env bash
# Cria o atalho "ArmorPaint" no menu do Linux Mint / Ubuntu.
# Sem sudo: o atalho fica so para este usuario (~/.local/share/applications).
set -e
DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
APPS="$HOME/.local/share/applications"

if [ ! -x "$DIR/ArmorPaint" ]; then
  echo "Executavel nao encontrado: $DIR/ArmorPaint"
  exit 1
fi

mkdir -p "$APPS"

ICON="$DIR/icon.png"
if [ ! -f "$ICON" ]; then
  ICON="$DIR/ArmorPaint.png"
fi

cat > "$APPS/armorpaint.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=ArmorPaint
Comment=Pintura de texturas PBR 3D
Exec=$DIR/ArmorPaint.sh
Icon=$ICON
Terminal=false
Categories=Graphics;3D;
StartupNotify=true
EOF

chmod +x "$APPS/armorpaint.desktop" 2>/dev/null || true

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$APPS" >/dev/null 2>&1 || true
fi

echo "Atalho criado: $APPS/armorpaint.desktop"
echo "Programa: $DIR"
echo ""
echo "Abra o menu e procure por ArmorPaint."
