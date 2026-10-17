# Instalación de Git y uso básico

---

## 1. Instalar Git

### Windows
1. Ve a: https://git-scm.com/download/win
2. Descarga e instala → "Next" en todo (las opciones por defecto están bien)
3. Abre "Git Bash" (se instala con Git) y escribe: `git --version`

### macOS
Git ya viene preinstalado. Verifica con:
```bash
git --version
```
Si no está: `brew install git`

### Linux (Ubuntu)
```bash
sudo apt install git
git --version
```

---

## 2. Configurar tu identidad (solo una vez)

Abre una terminal y escribe:
```bash
git config --global user.name "Jessica Escalona"
git config --global user.email "tu-email@email.com"
```

Esto aparecerá en cada commit que hagas (como una firma).

---

## 3. Clonar tu repositorio

Tu repositorio del curso está en GitHub. Para descargarlo:
```bash
git clone https://github.com/caenHiro/jess-java-course.git
cd jess-java-course
```

Esto crea una carpeta local con todos los archivos del curso.

---

## 4. Subir tus avances (lo harás cada semana)

El curso incluye un script que lo hace fácil. Solo escribe:
```bash
bash scripts/push.sh "semana-01 primer programa"
```

Ese script hace automáticamente:
1. `git add .` — marca todos tus archivos como listos para subir
2. `git commit -m "mensaje"` — guarda un punto de control con tu mensaje
3. `git push` — sube los cambios a GitHub

---

## 5. Actualizar cuando Carlos suba nueva semana

```bash
git pull
```

Este comando descarga los nuevos ejercicios que Carlos haya publicado.

---

## 6. Ver tu historial

```bash
git log --oneline
```

Muestra todos tus commits anteriores. Así puedes ver tu progreso a lo largo del tiempo.

---

## Conceptos básicos de Git

| Concepto | Qué es |
|----------|--------|
| **Repositorio** | Carpeta que git "vigila" |
| **Commit** | Punto de control guardado (como un "save" en un videojuego) |
| **Push** | Subir tus commits a GitHub |
| **Pull** | Descargar los cambios de GitHub |
| **Branch** | Versión paralela del código (lo veremos después) |

---

## ¿Qué sigue?

Cuando tengas todo instalado, lee la [[../00_Guia_Uso]] para entender cómo funciona el curso.
