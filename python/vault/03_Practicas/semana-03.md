---
semana: 3
tema: Listas, diccionarios y tuplas
estado: pendiente
---

# Practica Semana 3 — Listas, diccionarios y tuplas

> Lee la teoria en `02_Teoria/semana-03.md` antes de empezar.
> Guarda tu codigo en: `codigo/semana-03/`

---

## Ejercicio 1 — Lista de compras (obligatorio)

Crea `lista_compras.py`.

El programa hace lo siguiente en orden:
1. Muestra una lista de compras inicial: `["leche", "pan", "huevos"]`
2. Pide al usuario que agregue 2 productos (con `input`)
3. Elimina el primer producto de la lista
4. Muestra la lista final ordenada alfabeticamente

Usa `append`, `pop(0)` y `sort()`.

---

## Ejercicio 2 — Directorio de contactos (obligatorio)

Crea `contactos.py`.

Crea un diccionario con al menos 3 contactos:
```python
contactos = {
    "mama": "555-1234",
    "trabajo": "555-5678",
    "pizza": "555-9012"
}
```

El programa pregunta el nombre del contacto y muestra el numero. Si no existe, muestra "Contacto no encontrado".

Luego agrega un contacto nuevo pedido al usuario.

---

## Ejercicio 3 — Estadisticas de calificaciones (reto)

Crea `calificaciones.py`.

Tienes una lista de calificaciones:
```python
notas = [85, 92, 78, 96, 61, 74, 88, 95, 70, 83]
```

Con list comprehension calcula y muestra:
- Promedio del grupo
- Calificaciones aprobatorias (>= 70)
- Calificaciones reprobadas (< 70)
- La nota maxima y la minima

---

## Reflexion

**¿Cuando usarias una lista vs un diccionario?**

_Tu respuesta:_

**¿Que ventaja tiene usar list comprehension en lugar de un for normal?**

_Tu respuesta:_

**¿Para que sirven las tuplas si ya existen las listas?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-03 listas-diccionarios"`
