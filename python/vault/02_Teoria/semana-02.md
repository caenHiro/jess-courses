# Semana 2 — Funciones y Modulos en Python

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-02 condicionales"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Definir funciones con `def` y entender por que es mas simple que en Java
- Usar parametros con valores por defecto
- Devolver multiples valores desde una funcion
- Importar modulos de la libreria estandar (`math`, `random`)
- Crear su propio modulo `.py` e importarlo

**No se espera que use clases ni POO todavia.**

---

## Analogia clave 

> "Una funcion en Python es como una receta recortada que guardas en tu refri. Le das el nombre y los ingredientes (parametros), y ella siempre te devuelve el platillo (return). No necesitas poner el tipo de cada ingrediente en la etiqueta — Python ya sabe."

> "Los modulos son como las secciones de una tienda Chedraui: hay seccion de matematicas (`math`), seccion de numeros aleatorios (`random`), seccion de fechas (`datetime`). Importas solo la seccion que necesitas."

> "Un valor por defecto en un parametro es como pedir una torta de jamon: si no dices que quieres otra cosa, siempre viene con jamon. Pero si pides 'con milanesa', cambia el relleno."

---

## Equivalente Java → Python

| Java | Python | Diferencia clave |
|------|--------|-----------------|
| `public static int sumar(int a, int b)` | `def sumar(a, b):` | Sin tipo, sin public static |
| `{ return a + b; }` | `    return a + b` | Indentacion en lugar de llaves |
| No existe valor por defecto en params | `def f(x, y=10):` | Python lo tiene nativo |
| No se pueden devolver 2 valores | `return a, b` | Python si puede |
| `import java.util.Random;` | `import random` | Mucho mas simple |
| `Math.sqrt(16)` | `math.sqrt(16)` | Igual logica, diferente sintaxis |
| Crear clase solo para agrupar metodos | `archivo.py` = modulo | Un .py es ya un modulo |

---

## Contenido teorico

### 2.1 Definir funciones con def

La forma mas simple de definir una funcion:

```python
# Java: public static int sumar(int a, int b) { return a + b; }
def sumar(a, b):          # def, nombre, parentesis con params, dos puntos
    return a + b          # cuerpo indentado 4 espacios

# Llamar la funcion — identico a Java
resultado = sumar(5, 3)
print(resultado)          # 8

# Funcion sin return (como void en Java)
def saludar(nombre):
    print(f"Hola, {nombre}!")    # no devuelve nada

saludar("Jess")   # Hola, Jess!
```

**Para Jess:** en Java tenias que declarar `public static` y el tipo de retorno. En Python solo escribes `def`. Python deduce el tipo de lo que devuelves automaticamente.

### 2.2 Parametros con valor por defecto

```python
# Si no mandas el parametro 'saludo', usa "Hola" por defecto
def saludar(nombre, saludo="Hola"):
    print(f"{saludo}, {nombre}!")

saludar("Jess")                   # Hola, Jess!  (usa el default)
saludar("Carlos", "Buenos dias")  # Buenos dias, Carlos!  (sobreescribe el default)
saludar("Ana", saludo="Que onda") # Que onda, Ana!  (usando nombre del param)
```

**Regla:** los parametros con default siempre van AL FINAL. Nunca antes de un parametro sin default:
```python
# CORRECTO
def f(a, b, c=10):
    pass

# INCORRECTO — Python da error
def f(a=10, b):   # SyntaxError
    pass
```

### 2.3 Devolver multiples valores

```python
# En Java necesitarias un objeto o array para devolver dos cosas
# En Python puedes devolver multiples valores con comas

def dividir_con_residuo(a, b):
    cociente = a // b      # division entera
    residuo = a % b        # residuo
    return cociente, residuo   # devuelve dos valores separados por coma

# Recibir los dos valores
c, r = dividir_con_residuo(10, 3)
print(f"Cociente: {c}, Residuo: {r}")   # Cociente: 3, Residuo: 1

# Tambien puedes ignorar uno si no lo necesitas
cociente, _ = dividir_con_residuo(10, 3)   # _ descarta el segundo valor
```

### 2.4 Importar modulos de la libreria estandar

Python viene con cientos de modulos listos para usar. No necesitas descargar nada:

```python
# Modulo math — funciones matematicas
import math

print(math.pi)           # 3.141592653589793
print(math.sqrt(16))     # 4.0   (raiz cuadrada)
print(math.pow(2, 10))   # 1024.0  (potencia — como Math.pow en Java)
print(math.floor(3.7))   # 3   (redondear hacia abajo)
print(math.ceil(3.2))    # 4   (redondear hacia arriba)
print(math.fabs(-5))     # 5.0 (valor absoluto como float)

# Modulo random — numeros aleatorios
import random

n = random.randint(1, 100)      # entero aleatorio entre 1 y 100 (incluye ambos)
print(n)

d = random.random()             # decimal aleatorio entre 0.0 y 1.0
print(d)

# Forma alternativa: importar solo lo que necesitas
from math import sqrt, pi

print(sqrt(25))    # 5.0   (ya no necesitas escribir math.sqrt)
print(pi)          # 3.141592...
```

### 2.5 Crear tu propio modulo

Cualquier archivo `.py` es automaticamente un modulo en Python:

```python
# calculadora.py  (archivo separado)
def sumar(a, b):
    return a + b

def restar(a, b):
    return a - b

def calcular_iva(precio, tasa=0.16):
    return precio * tasa

def calcular_total(precio):
    return precio + calcular_iva(precio)
```

```python
# main.py  (otro archivo en la misma carpeta)

# Opcion 1: importar el modulo completo
import calculadora

print(calculadora.sumar(5, 3))          # 8
print(calculadora.calcular_total(100))  # 116.0

# Opcion 2: importar funciones especificas
from calculadora import sumar, calcular_total

print(sumar(5, 3))          # 8  (ya sin escribir 'calculadora.')
print(calcular_total(200))  # 232.0
```

---

## Errores comunes

1. **Olvidar los dos puntos `:` despues de `def`:** escribir `def sumar(a, b)` sin `:` causa `SyntaxError`. Siempre va `:` al final de la linea de `def`.

2. **No indentar el cuerpo de la funcion:** el cuerpo de la funcion DEBE ir indentado 4 espacios. Si no se indenta, Python no sabe que ese codigo pertenece a la funcion.

3. **Parametros con default antes de parametros sin default:** `def f(x=10, y)` causa `SyntaxError`. Los parametros con default siempre van al final.

4. **Llamar a la funcion antes de definirla:** en Python el orden importa en archivos planos. Si llamas `sumar(5, 3)` antes de escribir `def sumar`, da `NameError`. Primero define, luego llama.

5. **Confundir `import math` con `from math import *`:** `import math` es la forma recomendada porque es explicito (`math.sqrt`). El `*` importa todo y puede causar conflictos de nombres.

6. **No usar `return` cuando la funcion debe devolver algo:** una funcion sin `return` devuelve `None`. Si haces `resultado = sumar(5, 3)` pero no hay `return` en `sumar`, resultado sera `None`.

---

## Soluciones

### Ejercicio 1 — Calculadora con funciones

```python
# Definir cada operacion como una funcion separada
# Cada funcion hace UNA sola cosa — principio de responsabilidad unica

def sumar(a, b):
    return a + b          # devuelve la suma

def restar(a, b):
    return a - b          # devuelve la resta

def multiplicar(a, b):
    return a * b          # devuelve el producto

def dividir(a, b):
    # Validar que no dividan entre cero antes de calcular
    if b == 0:
        return None       # None = "nada", no hay resultado valido
    return a / b          # devuelve el cociente (siempre decimal en Python)

# Leer los dos numeros del usuario
# float() convierte el texto de input() a numero decimal
a = float(input("Primer numero: "))
b = float(input("Segundo numero: "))

# Llamar cada funcion e imprimir el resultado
print(f"{a} + {b} = {sumar(a, b)}")
print(f"{a} - {b} = {restar(a, b)}")
print(f"{a} * {b} = {multiplicar(a, b)}")

# La division puede ser None si b es 0
resultado_div = dividir(a, b)
if resultado_div is None:          # is None verifica si es exactamente None
    print("No se puede dividir entre 0")
else:
    print(f"{a} / {b} = {resultado_div}")
```

### Ejercicio 2 — Modulo de conversor de unidades

```python
# conversor.py — modulo propio de conversiones

def km_a_millas(km):
    """Convierte kilometros a millas."""
    return km * 0.621371   # 1 km = 0.621371 millas

def celsius_a_fahrenheit(c):
    """Convierte grados Celsius a Fahrenheit."""
    return (c * 9 / 5) + 32   # formula estandar

def kg_a_libras(kg):
    """Convierte kilogramos a libras."""
    return kg * 2.20462   # 1 kg = 2.20462 libras

def pesos_a_dolares(pesos, tipo_cambio=17.5):
    """Convierte pesos mexicanos a dolares. Tipo de cambio ajustable."""
    return pesos / tipo_cambio
```

```python
# main.py — usar el modulo conversor

import conversor   # importar nuestro modulo

distancia = float(input("Distancia en km: "))
print(f"{distancia} km = {conversor.km_a_millas(distancia):.2f} millas")

temperatura = float(input("Temperatura en Celsius: "))
print(f"{temperatura}°C = {conversor.celsius_a_fahrenheit(temperatura):.1f}°F")

pesos = float(input("Cantidad en pesos: "))
print(f"${pesos} MXN = ${conversor.pesos_a_dolares(pesos):.2f} USD")
# Con tipo de cambio diferente:
print(f"${pesos} MXN = ${conversor.pesos_a_dolares(pesos, 18.0):.2f} USD (TC 18)")
```

### Ejercicio 3 (Reto) — Funciones con devolucion multiple

```python
# Funcion que devuelve estadisticas de una lista de calificaciones
def calcular_estadisticas(calificaciones):
    """Devuelve promedio, calificacion maxima y minima."""
    total = sum(calificaciones)            # sum() suma todos los elementos de la lista
    promedio = total / len(calificaciones) # len() cuenta cuantos hay
    maximo = max(calificaciones)           # max() encuentra el mayor
    minimo = min(calificaciones)           # min() encuentra el menor
    return promedio, maximo, minimo        # devuelve 3 valores a la vez

# Lista de calificaciones de Jess en el semestre
mis_calificaciones = [8.5, 9.0, 7.5, 10.0, 8.0, 9.5]

# Recibir los 3 valores que devuelve la funcion
prom, max_cal, min_cal = calcular_estadisticas(mis_calificaciones)

print(f"Promedio: {prom:.2f}")   # :.2f formatea a 2 decimales
print(f"Mejor calificacion: {max_cal}")
print(f"Peor calificacion: {min_cal}")
```

---
