#!/usr/bin/env bash
# push.sh — sube tus avances al repositorio
# Uso: bash scripts/push.sh "semana-01 primer programa"

if [ -z "$1" ]; then
    echo "Falta el mensaje del commit."
    echo "Uso: bash scripts/push.sh \"semana-01 primer programa\""
    exit 1
fi

cd "$(dirname "$0")/.." || exit 1

git add .
git commit -m "$1"
git push

echo ""
echo "Avances subidos correctamente."
