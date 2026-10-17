---
semana: 2
tema: Funciones y modulos
estado: pendiente
---

# Practica Semana 2 — Funciones y modulos

> Lee la teoria en `02_Teoria/semana-02.md` antes de empezar.
> Guarda tu codigo en: `codigo/semana-02/`

---

## Ejercicio 1 — Calculadora de propinas (obligatorio)

Crea un archivo `propinas.py`.

El programa pregunta al usuario:
- El monto de la cuenta
- El porcentaje de propina (10, 15 o 20%)

Calcula y muestra cuanto es la propina y el total a pagar.

Ejemplo de salida:
```
Monto de la cuenta: 350
Porcentaje de propina (10/15/20): 15
Propina: $52.50
Total a pagar: $402.50
```

**Requisito:** crear una funcion `calcular_propina(monto, porcentaje)` que haga el calculo.

---

## Ejercicio 2 — Generador de mensajes (obligatorio)

Crea un archivo `mensajes.py`.

Crea 3 funciones:
- `saludo(nombre)` — regresa "Buenos dias, [nombre]!"
- `despedida(nombre)` — regresa "Hasta luego, [nombre]! Que te vaya bien."
- `felicitacion(nombre, razon)` — regresa "Felicidades, [nombre]! [razon]"

Luego en el programa principal, pide el nombre al usuario y muestra los 3 mensajes.

---

## Ejercicio 3 — Modulo de matematicas (reto)

Crea un archivo `mi_matematica.py` con estas funciones:
- `area_circulo(radio)` — usa `math.pi`
- `area_rectangulo(base, altura)`
- `hipotenusa(a, b)` — usa `math.sqrt`
- `es_par(numero)` — regresa True o False

Luego crea `main.py` que importe esas funciones y muestre los resultados para valores de ejemplo.

---

## Reflexion

Escribe tus respuestas aqui despues de terminar los ejercicios:

**¿Cuando conviene crear una funcion en lugar de repetir el codigo?**

_Tu respuesta:_

**¿Que diferencia hay entre `return` e `print` dentro de una funcion?**

_Tu respuesta:_

**¿Para que sirve `import math` en lugar de recalcular pi manualmente?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-02 funciones-modulos"`
