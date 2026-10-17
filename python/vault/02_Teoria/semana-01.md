# Semana 1 — Python basico: mismo concepto, diferente sintaxis

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-01 variables y tipos"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Correr su primer programa Python sin errores
- Declarar variables sin declarar el tipo
- Usar `print()` con f-strings
- Identificar las diferencias clave de sintaxis entre Java y Python
- Hacer calculos aritmeticos basicos, incluyendo la diferencia entre `/` y `//`

**No se espera que use funciones, clases, ni imports todavia.**

---

## Analogia clave 

> "En Java para hacer tamales necesitas moldes especiales, papel, hoja de maiz, y que alguien supervise todo el proceso. En Python haces el mismo tamal pero en cazuela directa — menos pasos, mismo resultado."

> "Las variables en Python son como cajas sin etiqueta de tipo. En Java la caja decia 'solo numeros enteros'. En Python la caja acepta lo que le pongas — tu decides que guarda."

> "Los f-strings son como los carteles del OXXO: 'Total a pagar: $[cantidad]'. Tu ya defines el molde del mensaje y Python pone el valor donde va el corchete."

---

## Equivalente Java → Python

| Java | Python | Nota importante |
|------|--------|-----------------|
| `int edad = 25;` | `edad = 25` | Sin tipo, sin punto y coma |
| `double precio = 99.50;` | `precio = 99.50` | Python infiere que es float |
| `String nombre = "Jess";` | `nombre = "Jess"` | Sin tipo |
| `boolean activo = true;` | `activo = True` | **T mayuscula en Python** |
| `System.out.println("hola")` | `print("hola")` | Mucho mas corto |
| `"Hola " + nombre` | `f"Hola {nombre}"` | f-string es la forma Python |
| `// comentario` | `# comentario` | Almohadilla en lugar de // |
| `5 / 2 = 2` (entero) | `5 / 2 = 2.5` (siempre decimal!) | **Division diferente** |
| `5 / 2.0 = 2.5` | `5 // 2 = 2` | `//` es la division entera en Python |

---

## Contenido teorico

### 1.1 El programa minimo

En Java el programa minimo era:
```java
public class HolaMundo {
    public static void main(String[] args) {
        System.out.println("Hola Mundo");
    }
}
```

En Python el mismo programa es:
```python
# hola_mundo.py
print("Hola Mundo")   # eso es todo — sin clase, sin main, sin ;
```

**Punto clave para Jess:** en Python el archivo ya ES el programa. No hay que envolver nada en una clase. No hay `main`. El codigo corre de arriba hacia abajo directamente.

### 1.2 Variables — tipado dinamico

Python deduce el tipo automaticamente. A esto se le llama **tipado dinamico**:

```python
nombre = "Jess"        # Python infiere: esto es str (texto)
edad = 22              # Python infiere: esto es int (entero)
estatura = 1.65        # Python infiere: esto es float (decimal)
activo = True          # Python infiere: esto es bool — OJO: T mayuscula
```

Para verificar el tipo (equivalente a ver el tipo en Java):
```python
print(type(nombre))    # <class 'str'>
print(type(edad))      # <class 'int'>
print(type(estatura))  # <class 'float'>
print(type(activo))    # <class 'bool'>
```

### 1.3 Imprimir con print() — los 3 estilos

```python
nombre = "Jess"
edad = 22

# Estilo 1: concatenacion con + (como en Java)
print("Me llamo " + nombre + " y tengo " + str(edad) + " anos")
# OJO: si mezclas str con int con +, Python falla — necesitas str(edad)

# Estilo 2: f-string (la forma moderna y recomendada en Python)
print(f"Me llamo {nombre} y tengo {edad} anos")
# Las {} ponen el valor de la variable directamente

# Estilo 3: comas en print (agrega espacio automaticamente)
print("Me llamo", nombre, "y tengo", edad, "anos")
# Cada coma agrega un espacio entre los valores
```

**Recomendacion para Jess:** usar siempre el estilo 2 (f-string). Es el mas limpio y el que se usa en el trabajo real.

### 1.4 Tipos de datos principales

| Tipo Python | Equivalente Java | Para que | Ejemplo |
|-------------|-----------------|----------|---------|
| `int` | `int` / `long` | Numeros enteros | `edad = 25` |
| `float` | `double` | Numeros decimales | `precio = 99.50` |
| `str` | `String` | Texto | `nombre = "Jess"` |
| `bool` | `boolean` | Verdadero o falso | `activo = True` |

### 1.5 Aritmetica — la diferencia critica

```python
a = 10
b = 3

print(a + b)    # 13   — suma, igual que Java
print(a - b)    # 7    — resta, igual que Java
print(a * b)    # 30   — multiplicacion, igual que Java
print(a / b)    # 3.333...  — OJO! siempre decimal en Python
print(a // b)   # 3    — division entera (necesitas // dos diagonales)
print(a % b)    # 1    — modulo/residuo, igual que Java
print(a ** b)   # 1000 — potencia (en Java era Math.pow(a, b))
```

**La trampa mas comun:** en Java `10 / 3` da `3` (division entera). En Python `10 / 3` da `3.333...`. Para division entera en Python usa `//`.

---

## Errores comunes

1. **`True` y `False` con minuscula:** escribir `true` o `false` (como en Java) causa `NameError` en Python. Siempre son `True` / `False` con T y F mayusculas.

2. **Concatenar str con int usando `+`:** `"Tengo " + 22 + " anos"` falla en Python. Necesitas `f"Tengo {22} anos"` o `"Tengo " + str(22) + " anos"`.

3. **Division entera:** esperar que `10 / 3` de `3` como en Java. En Python da `3.333...`. Para division entera usar `//`.

4. **Punto y coma al final:** escribir `nombre = "Jess";` no es error en Python (lo ignora), pero es incorrecto estilo Python. Nunca usar `;` al final.

5. **Indentacion con tabs mezclados con espacios:** Python es MUY estricto con la indentacion. Usar solo espacios (4 espacios por nivel es el estandar). VS Code lo hace automaticamente.

6. **Mayusculas en nombres de variables:** Python es case-sensitive igual que Java. `Nombre` y `nombre` son variables diferentes.

---

## Soluciones

### Ejercicio 1 — Datos de la jugadora

```python
# Variables con la informacion de la jugadora
nombre = "Jess"         # str: texto entre comillas
edad = 25               # int: numero entero sin decimales
altura = 1.65           # float: numero con punto decimal
peso = 58.5             # float: kilogramos
deporte = "futbol"      # str: texto
activo = True           # bool: True con T mayuscula

# Imprimir cada dato con f-string
# La f antes de las comillas activa los {}
print(f"Nombre: {nombre}")
print(f"Edad: {edad} anos")
print(f"Altura: {altura} m")
print(f"Peso: {peso} kg")
print(f"Deporte: {deporte}")
print(f"Activo: {activo}")
```

**Que evaluar:** que use f-strings (no concatenacion con +) y que no ponga `;` al final de cada linea.

### Ejercicio 2 — Bio multilingue

```python
# Pedir datos al usuario con input()
# input() siempre devuelve texto (str) — no hay que convertir aqui
nombre = input("Tu nombre: ")
ciudad = input("Tu ciudad: ")
hobby = input("Tu hobby favorito: ")

# Usar los datos en 3 idiomas diferentes
# El \n dentro del f-string agrega una linea en blanco antes
print(f"\nEspanol: Me llamo {nombre}, soy de {ciudad} y me gusta {hobby}.")
print(f"English: My name is {nombre}, I am from {ciudad} and I like {hobby}.")
print(f"Frances: Je m'appelle {nombre}, je suis de {ciudad} et j'aime {hobby}.")
```

### Ejercicio 3 (Reto) — Calculadora de IMC

```python
# Leer peso y altura como numeros decimales
# float() convierte el texto que devuelve input() a numero decimal
peso = float(input("Tu peso en kg: "))
altura = float(input("Tu altura en metros (ej. 1.65): "))

# Calcular IMC: peso dividido entre la altura al cuadrado
# ** es potencia en Python (en Java era Math.pow)
imc = peso / (altura ** 2)

# Clasificar el IMC con if/elif/else
if imc < 18.5:
    categoria = "Bajo peso"
elif imc < 25:              # elif = else if en Java
    categoria = "Peso normal"
elif imc < 30:
    categoria = "Sobrepeso"
else:
    categoria = "Obesidad"

# El :.2f dentro del {} formatea el numero a 2 decimales
print(f"\nTu IMC: {imc:.2f}")
print(f"Categoria: {categoria}")
```

**Nota para el docente:** el reto usa `if/elif/else` que es S3 del plan maestro original pero se ve en S1 de la teoria del alumno porque es "traduccion" directa de Java. Es aceptable que Jess lo use si ya lo vio en Java — no es concepto nuevo para ella, solo nueva sintaxis.

---
