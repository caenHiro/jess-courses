---
semana: 5
tema: Archivos y JSON
estado: pendiente
---

# Practica Semana 5 — Archivos y JSON

> Lee la teoria en `02_Teoria/semana-05.md` antes de empezar.
> Guarda tu codigo en: `codigo/semana-05/`

---

## Ejercicio 1 — Diario personal (obligatorio)

Crea `diario.py`.

El programa hace lo siguiente:
1. Pide una entrada de diario al usuario (texto libre)
2. Guarda la entrada en un archivo `mi_diario.txt` con la fecha actual al inicio
3. Muestra todo el contenido del diario al terminar

Formato del archivo:
```
2026-06-14:
Hoy aprendi a escribir archivos con Python...

2026-06-15:
Fue un dia tranquilo...
```

---

## Ejercicio 2 — Base de datos de contactos en JSON (obligatorio)

Crea `contactos_json.py`.

El programa tiene un menu:
```
1. Agregar contacto
2. Ver todos los contactos
3. Salir
```

Los contactos se guardan en `contactos.json`. Cada contacto tiene: nombre, telefono, email.

Al iniciar, si `contactos.json` existe, lo carga. Si no, empieza vacio.

---

## Ejercicio 3 — Leer CSV de calificaciones (reto)

Crea un archivo `calificaciones.csv` con este contenido:
```
nombre,matematicas,historia,ciencias
Ana,90,85,92
Luis,70,88,75
Maria,95,91,89
Pedro,60,72,80
```

Crea `reporte.py` que lea el CSV y muestre:
- Promedio de cada estudiante
- El estudiante con el promedio mas alto
- El estudiante con el promedio mas bajo

---

## Reflexion

**¿Por que es importante usar `with open(...)` en lugar de `f = open(...)` sin `with`?**

_Tu respuesta:_

**¿Cuando usarias JSON vs CSV para guardar datos?**

_Tu respuesta:_

**¿Que pasaria si intentas leer un archivo que no existe? ¿Como lo manejas?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-05 archivos-json"`
