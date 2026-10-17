---
tags: [guia, bienvenida, instrucciones]
---

# Bienvenida al Curso de Java

Hola Jess! Este es tu espacio de aprendizaje. Aquí encontrarás todo lo que necesitas para aprender a programar en Java en 90 días.

---

## ¿Cómo está organizado esto?

```
jess-java-course/
├── vault/                  ← tus notas en Obsidian
│   ├── 01_Instalacion/    ← guías para instalar las herramientas
│   ├── 02_Teoria/         ← una nota por semana con la teoría
│   ├── 03_Practicas/      ← ejercicios de cada semana (tú los resuelves)
│   └── 04_Notas_Personales/ ← tus reflexiones, dudas, lo que quieras
└── codigo/                 ← tus archivos .java
    ├── semana-01/
    ├── semana-02/
    └── ...
```

---

## Tu rutina semanal

Cada semana el proceso es el mismo:

### Paso 1 — Lee la teoría (30–45 min)
Abre `02_Teoria/semana-XX.md` en Obsidian y léela completa.
Si no entiendes algo, anótalo en `04_Notas_Personales/`.

### Paso 2 — Escribe el código (1–2 horas)
Abre VS Code. Ve a la carpeta `codigo/semana-XX/`.
Crea los archivos `.java` de los ejercicios.

Empieza por el ejercicio 1 (obligatorio). El ejercicio 3 es reto — si puedes, genial. Si no, no hay problema.

### Paso 3 — Anota tu práctica (15–20 min)
Abre `03_Practicas/semana-XX.md`.
Pega o escribe el nombre de los archivos que creaste.
**Responde las preguntas de reflexión** — esto es importante.

### Paso 4 — Sube tus avances (5 min)
Abre una terminal en la carpeta del proyecto y escribe:
```bash
bash scripts/push.sh "semana-01 primer programa"
```

Carlos revisará tu código y te dará retroalimentación.

---

## Reglas del juego

1. **No te compares** con nadie ni con "lo que deberías saber". Cada quien aprende a su ritmo.
2. **Los errores son parte del proceso.** Si algo no funciona, escríbelo en la práctica. Así aprenderás más que si todo saliera perfecto.
3. **Haz preguntas.** Si algo no quedó claro después de leer la teoría, manda mensaje. No avances con dudas acumuladas.
4. **Una semana a la vez.** No saltes semanas. Cada tema construye sobre el anterior.
5. **Entrega algo, aunque esté incompleto.** Es mejor entregar el ejercicio 1 resuelto que no entregar nada por querer hacer los 3 perfectos.

---

## Herramientas que vas a usar

| Herramienta | Para qué | Guía |
|------------|----------|------|
| Obsidian | Leer teoría, escribir notas | Abrir la carpeta `vault/` en Obsidian |
| VS Code | Escribir y ejecutar código Java | [[01_Instalacion/02_VSCode]] |
| Git | Subir tu código | [[01_Instalacion/03_Git]] |
| JDK 21 | Compilar y ejecutar Java | [[01_Instalacion/01_Java]] |

---

## Antes de empezar la semana 1

- [ ] Java instalado — ver [[01_Instalacion/01_Java]]
- [ ] VS Code instalado con la extensión de Java — ver [[01_Instalacion/02_VSCode]]
- [ ] Git instalado y configurado — ver [[01_Instalacion/03_Git]]
- [ ] Este repositorio clonado: `git clone https://github.com/caenHiro/jess-java-course.git`

Cuando tengas todo listo, empieza con: [[02_Teoria/semana-01]]

---

## ¿Cómo ver tu progreso?

Carlos lleva un registro de tus calificaciones. Cada semana revisará tu código y tus notas y te dará feedback.

Tú puedes ver tu avance personal en: [[04_Notas_Personales/_Progreso]]
