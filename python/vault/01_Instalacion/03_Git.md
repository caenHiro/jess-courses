# Git — control de versiones

## Configuracion inicial (una sola vez)

```bash
git config --global user.name "Jess"
git config --global user.email "tu@email.com"
```

## Clonar este repositorio

```bash
git clone https://github.com/caenhiro/jess-python-course.git
cd jess-python-course
```

## Rutina de trabajo

```bash
# Al inicio de cada sesion — descargar lo nuevo
git pull

# Cuando terminas algo — subir tu trabajo
bash scripts/push.sh "semana-01 variables completadas"
```

El script `push.sh` hace automaticamente:
1. `git add .` — agregar todos los cambios
2. `git commit -m "tu mensaje"` — guardar con descripcion
3. `git push` — subir a GitHub

## Ver el historial

```bash
git log --oneline
```

## Si algo sale mal

```bash
# Ver que archivos cambiaron
git status

# Ver las diferencias
git diff
```
