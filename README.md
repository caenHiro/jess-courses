# jess-courses

Monorepo de cursos CAEN para Jess.

## Estructura

```
jess-courses/
├── java/        Curso Java — vault + codigo
├── python/      Curso Python — vault + codigo
├── react/       Curso React — vault + scripts
├── sql/         Curso SQL — vault + ejercicios
└── seguridad/   Curso Seguridad — vault + codigo
```

## Sincronización

```bash
# Pull (GitHub → workspace-ai)
bash scripts/maquinas/jess/jess_sync.sh pull

# Push (workspace-ai → GitHub)
bash scripts/maquinas/jess/jess_sync.sh push java "docs: semana-06"
```
