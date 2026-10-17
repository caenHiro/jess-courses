#!/usr/bin/env bash
if [ -z "$1" ]; then
    echo "Uso: bash scripts/push.sh \"semana-01 variables basicas\""
    exit 1
fi
cd "$(dirname "$0")/.." || exit 1
git add .
git commit -m "$1"
git push
echo "Avances subidos correctamente."
