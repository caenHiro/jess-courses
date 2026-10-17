#!/bin/bash
# push.sh — Sube tus avances al repositorio
# Uso: bash scripts/push.sh "semana-01 variables completada"

MSG=${1:-"avance del dia"}

git add .
git commit -m "$MSG"
git push

echo ""
echo "Listo! Tus avances estan en GitHub."
