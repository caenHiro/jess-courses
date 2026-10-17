# Semana 3 — Listas, Diccionarios y Tuplas

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-03 ciclos"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Crear y manipular listas (equivalente a ArrayList de Java)
- Crear y manipular diccionarios (equivalente a HashMap de Java)
- Entender cuando usar tupla vs lista
- Usar slicing para obtener partes de una lista
- Escribir al menos una list comprehension basica

**No se espera que use clases, archivos, ni modulos externos todavia.**

---

## Analogia clave 

> "Una lista en Python es como una lista del super: puedes agregar cosas, tachar (borrar), reordenar y ver cuantos productos hay. La diferencia con Java es que no necesitas decir de antemano 'esta lista es solo de String'."

> "Un diccionario en Python es como el directorio telefonico de tu colonia: cada persona (clave) tiene un telefono (valor). Buscas por nombre y te da el numero. En Java esto era el HashMap."

> "Una tupla es como la CURP de alguien: tiene nombre, fecha de nacimiento, estado y sexo en orden fijo. Nadie la puede cambiar una vez asignada — es inmutable."

> "El slicing es como rebanar un pan Bimbo: si el pan completo es la lista, puedes pedir 'dame del tercero al sexto rebanada' con `lista[2:6]`."

---

## Equivalente Java → Python

| Java | Python | Diferencia clave |
|------|--------|-----------------|
| `new ArrayList<String>()` | `["manzana", "pera"]` | Sin tipo, literal directo |
| `lista.add("uva")` | `lista.append("uva")` | `.append()` en lugar de `.add()` |
| `lista.get(0)` | `lista[0]` | Acceso directo con `[]` |
| `lista.size()` | `len(lista)` | Funcion `len()` en lugar de `.size()` |
| `lista.remove(0)` | `lista.pop(0)` | `.pop()` devuelve el elemento borrado |
| `new HashMap<String,Integer>()` | `{"nombre": "Jess"}` | Literal directo `{}` |
| `map.put("edad", 22)` | `d["edad"] = 22` | Asignacion directa |
| `map.get("edad")` | `d["edad"]` o `d.get("edad")` | `.get()` es mas seguro |
| `map.containsKey("x")` | `"x" in d` | Operador `in` muy limpio |
| No existe nativo | `(19.4, -99.1)` | Tupla: como lista pero inmutable |

---

## Contenido teorico

### 3.1 Listas — el ArrayList de Python

```python
# Crear una lista (no hay que declarar el tipo)
frutas = ["manzana", "pera", "uva", "mango"]

# Acceder por indice — igual que en Java con ArrayList.get()
print(frutas[0])     # manzana — el primero (indice 0)
print(frutas[3])     # mango   — el cuarto (indice 3)
print(frutas[-1])    # mango   — el ULTIMO (truco Python: indice negativo)
print(frutas[-2])    # uva     — el penultimo

# Modificar un elemento
frutas[1] = "kiwi"   # reemplaza "pera" por "kiwi"
print(frutas)        # ['manzana', 'kiwi', 'uva', 'mango']

# Agregar elementos
frutas.append("fresa")       # agrega al FINAL — mas comun
frutas.insert(1, "melon")    # inserta en posicion especifica

# Eliminar elementos
frutas.remove("uva")         # elimina por VALOR (busca y borra el primero que encuentre)
ultimo = frutas.pop()        # elimina y DEVUELVE el ultimo elemento
primero = frutas.pop(0)      # elimina y DEVUELVE el elemento en indice 0

# Informacion sobre la lista
print(len(frutas))           # cuantos elementos — en Java era .size()
print("manzana" in frutas)   # True si "manzana" esta en la lista
print("papaya" in frutas)    # False

# Ordenar
frutas.sort()               # ordena en su lugar (modifica la lista original)
frutas_sorted = sorted(frutas)  # devuelve una lista nueva ordenada
```

### 3.2 Recorrer listas — for en Python es mas limpio

```python
colores = ["rojo", "verde", "azul", "amarillo"]

# Forma 1: for directo (la mas comun y pythonica)
for color in colores:
    print(color)

# Forma 2: con indice (cuando necesitas el numero de posicion)
for i, color in enumerate(colores):
    print(f"{i}: {color}")     # 0: rojo, 1: verde, etc.

# Forma 3: rango (cuando solo necesitas el indice)
for i in range(len(colores)):
    print(colores[i])          # menos pythonica, pero funciona
```

### 3.3 Slicing — cortar partes de una lista

```python
numeros = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
#          0  1  2  3  4  5  6  7  8  9   <-- indices

# Sintaxis: lista[inicio:fin]  (inicio incluido, fin EXCLUIDO)
print(numeros[2:5])    # [2, 3, 4]    — del 2 al 4 (el 5 no se incluye)
print(numeros[:3])     # [0, 1, 2]    — desde el inicio hasta el 2
print(numeros[7:])     # [7, 8, 9]    — del 7 hasta el final
print(numeros[::2])    # [0, 2, 4, 6, 8]  — cada 2 elementos (paso de 2)
print(numeros[::-1])   # [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]  — al reves
```

### 3.4 List comprehension — Python idiomatico

La list comprehension es una forma compacta de crear listas. No existe en Java.

```python
numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Sin comprehension (forma Java):
cuadrados = []
for n in numeros:
    cuadrados.append(n ** 2)

# Con comprehension (forma Python):
cuadrados = [n ** 2 for n in numeros]
print(cuadrados)    # [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

# Con filtro:
pares = [n for n in numeros if n % 2 == 0]
print(pares)        # [2, 4, 6, 8, 10]

# Combinado: cuadrados de los pares
cuadrados_de_pares = [n ** 2 for n in numeros if n % 2 == 0]
print(cuadrados_de_pares)   # [4, 16, 36, 64, 100]
```

**Lectura en voz alta:** `[n**2 for n in numeros if n % 2 == 0]` = "dame el cuadrado de n, para cada n en numeros, si n es par".

### 3.5 Diccionarios — el HashMap de Python

```python
# Crear un diccionario con datos de una persona
persona = {
    "nombre": "Jess",
    "edad": 22,
    "ciudad": "CDMX",
    "activa": True
}

# Acceder a un valor por su clave
print(persona["nombre"])              # Jess
print(persona["edad"])                # 22

# .get() es mas seguro: si la clave no existe devuelve None (no falla)
print(persona.get("email"))           # None (no genera error)
print(persona.get("email", "N/A"))    # N/A (valor por defecto si no existe)

# Agregar o modificar
persona["email"] = "jess@email.com"  # agregar nueva clave
persona["edad"] = 23                  # modificar valor existente

# Eliminar
del persona["ciudad"]                 # elimina la clave y su valor

# Verificar si existe una clave
if "nombre" in persona:
    print("Si tiene nombre")

# Recorrer todas las claves y valores
for clave, valor in persona.items():
    print(f"{clave}: {valor}")

# Solo claves o solo valores
print(list(persona.keys()))     # ['nombre', 'edad', 'activa', 'email']
print(list(persona.values()))   # ['Jess', 23, True, 'jess@email.com']
```

### 3.6 Tuplas — datos que no cambian

```python
# Una tupla es como una lista pero INMUTABLE (no se puede modificar)
coordenadas = (19.4326, -99.1332)   # latitud y longitud de CDMX

print(coordenadas[0])    # 19.4326
print(coordenadas[1])    # -99.1332

# Intentar modificar da error:
# coordenadas[0] = 0    # TypeError: 'tuple' object does not support item assignment

# Desempacar la tupla (muy util)
latitud, longitud = coordenadas
print(f"Lat: {latitud}, Long: {longitud}")

# Las funciones que devuelven multiples valores usan tuplas internamente
def obtener_coordenadas():
    return 19.4326, -99.1332    # esto es una tupla

lat, lon = obtener_coordenadas()

# Cuando usar tupla vs lista:
# - Tupla: datos que NO deben cambiar (coordenadas, colores RGB, CURP)
# - Lista: datos que SI pueden cambiar (carrito de compras, lista de tareas)
```

---

## Errores comunes

1. **Usar `.add()` en lugar de `.append()`:** habito de Java. En Python las listas usan `.append()` para agregar al final.

2. **Usar `.size()` en lugar de `len()`:** en Java era `lista.size()`. En Python es `len(lista)` — funcion en lugar de metodo.

3. **Acceder a clave inexistente en diccionario con `[]`:** `persona["email"]` cuando `"email"` no existe lanza `KeyError`. Usar siempre `.get("email")` si no se esta seguro de que la clave existe.

4. **Confundir `()` de tupla con `()` de funcion:** `(5)` es solo el numero `5` con parentesis. Para crear una tupla de un solo elemento: `(5,)` — nota la coma.

5. **Intentar modificar una tupla:** las tuplas son inmutables. Si necesitas modificar datos, usa una lista.

6. **Slicing: creer que el ultimo indice se incluye:** `lista[2:5]` incluye indices 2, 3, 4 — el 5 NO se incluye. El indice final siempre queda excluido.

---

## Soluciones

### Ejercicio 1 — Lista de compras del mercado

```python
# Lista inicial de productos del mercado
compras = ["tomate", "cebolla", "chile", "aguacate", "limon"]

print("=== Lista de compras ===")
# Recorrer con enumerate para ver numero y producto
for i, producto in enumerate(compras, start=1):   # start=1 empieza el contador en 1
    print(f"{i}. {producto}")

# Agregar un producto al final
compras.append("cilantro")
print(f"\nAgregamos: cilantro")

# Insertar en una posicion especifica
compras.insert(0, "tortillas")   # las tortillas van primero!
print(f"Insertamos tortillas al inicio")

# Eliminar un producto
compras.remove("limon")
print(f"Eliminamos: limon")

# Cuantos productos quedan
print(f"\nTotal de productos: {len(compras)}")

# Lista final ordenada
compras.sort()
print(f"\nLista ordenada: {compras}")
```

### Ejercicio 2 — Directorio de contactos

```python
# Diccionario de contactos: nombre -> numero de telefono
contactos = {
    "Mama": "55-1234-5678",
    "Papa": "55-8765-4321",
    "Jess": "55-9999-0000",
    "Carlos": "55-1111-2222"
}

# Mostrar todos los contactos
print("=== Directorio ===")
for nombre, telefono in contactos.items():
    print(f"{nombre}: {telefono}")

# Buscar un contacto de forma segura
busqueda = input("\n¿A quien buscas? ")
numero = contactos.get(busqueda)    # .get() no falla si no existe

if numero is not None:
    print(f"Telefono de {busqueda}: {numero}")
else:
    print(f"{busqueda} no esta en el directorio")

# Agregar un contacto nuevo
contactos["Abuela"] = "55-0000-9999"
print(f"\nAgregamos a Abuela")

# Total de contactos
print(f"Total de contactos: {len(contactos)}")
```

### Ejercicio 3 (Reto) — List comprehension con calificaciones

```python
# Calificaciones del semestre
calificaciones = [6.5, 8.0, 9.5, 5.0, 7.5, 10.0, 4.5, 8.5, 9.0, 7.0]

# List comprehension: filtrar las calificaciones aprobadas (>= 6)
aprobadas = [cal for cal in calificaciones if cal >= 6.0]
print(f"Aprobadas: {aprobadas}")

# List comprehension: las calificaciones al cuadrado (para practica)
cuadrados = [round(cal ** 2, 2) for cal in calificaciones]
# round() redondea a 2 decimales
print(f"Al cuadrado: {cuadrados}")

# Calificaciones reprobadas
reprobadas = [cal for cal in calificaciones if cal < 6.0]
print(f"Reprobadas: {reprobadas}")

# Estadisticas sin importar modulos
promedio = sum(calificaciones) / len(calificaciones)
print(f"\nTotal de examenes: {len(calificaciones)}")
print(f"Aprobados: {len(aprobadas)}")
print(f"Reprobados: {len(reprobadas)}")
print(f"Promedio: {promedio:.2f}")
print(f"Mayor calificacion: {max(calificaciones)}")
print(f"Menor calificacion: {min(calificaciones)}")
```

---
