#!/usr/bin/env bash
# Inicia o ArmorPaint sempre a partir da pasta do programa,
# pois o data/ (texturas, temas, idiomas) fica ao lado do executavel.
set -e
DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
cd "$DIR"
exec ./ArmorPaint "$@"
