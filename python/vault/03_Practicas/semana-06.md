---
semana: 6
tema: venv, pip y excepciones
estado: pendiente
---

# Practica Semana 6 — Entorno virtual, pip y manejo de errores

> Lee la teoria en `02_Teoria/semana-06.md` antes de empezar.
> Guarda tu codigo en: `codigo/semana-06/`

---

## Ejercicio 1 — Calculadora segura (obligatorio)

Crea `calculadora_segura.py`.

El programa pide dos numeros y una operacion (+, -, *, /). Maneja estos errores:
- Si el usuario escribe texto en lugar de numero → `ValueError`
- Si intenta dividir entre cero → `ZeroDivisionError`
- Si la operacion no es valida → muestra mensaje de error personalizado

El programa debe seguir corriendo hasta que el usuario escriba "salir".

---

## Ejercicio 2 — Buscador de archivos (obligatorio)

Crea `buscador.py` con una funcion `leer_archivo(ruta)` que:
- Intenta abrir y leer el archivo en esa ruta
- Si no existe → captura `FileNotFoundError` y muestra "Archivo no encontrado: [ruta]"
- Si no tiene permisos → captura `PermissionError` y muestra "Sin permisos"
- Si todo bien → regresa el contenido

Prueba con: un archivo que exista, uno que no exista, y una ruta inventada.

---

## Ejercicio 3 — Configurar un proyecto real (reto)

Configura correctamente un entorno para trabajar:

1. Crea un nuevo directorio `mi_proyecto/`
2. Crea un entorno virtual: `python -m venv venv`
3. Activalo y instala: `requests` y `rich`
4. Crea `main.py` que importe ambas librerias y haga algo simple:
   - `requests`: haz un GET a `https://httpbin.org/get` y muestra el status code
   - `rich`: imprime un mensaje con colores usando `from rich import print`
5. Crea `requirements.txt` con `pip freeze > requirements.txt`

Copia el `requirements.txt` a `codigo/semana-06/requirements.txt`.

---

## Reflexion

**¿Por que es importante usar un `venv` para cada proyecto en lugar de instalar todo global?**

_Tu respuesta:_

**¿Que diferencia hay entre `except Exception` y excepciones especificas como `ValueError`?**

_Tu respuesta:_

**¿Cuando usarias `try/except/finally`? ¿Para que sirve el `finally`?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-06 venv-excepciones"`
