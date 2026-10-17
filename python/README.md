# Curso Python + AWS — Jess

Curso de 90 dias (12 semanas) para aprender Python y AWS.

## Estructura

```
alumno/
├── vault/
│   ├── 00_Guia_Uso.md          # Empieza aqui
│   ├── 01_Instalacion/         # Guias de instalacion
│   ├── 02_Teoria/              # Notas de teoria por semana
│   ├── 03_Practicas/           # Ejercicios por semana
│   └── 04_Notas_Personales/    # Tu progreso y reflexiones
├── codigo/
│   ├── semana-01/              # Tu codigo de cada semana
│   ├── semana-02/
│   └── ...
└── scripts/
    └── push.sh                 # Subir tus avances
```

## Como empezar

1. Lee `vault/00_Guia_Uso.md`
2. Instala el stack: `vault/01_Instalacion/`
3. Lee la teoria de la semana en `vault/02_Teoria/semana-01.md`
4. Haz los ejercicios en `vault/03_Practicas/semana-01.md`
5. Guarda tu codigo en `codigo/semana-01/`
6. Sube tus avances:

```bash
bash scripts/push.sh "semana-01 completada"
```

## Actualizar tu repositorio

```bash
git pull
```
