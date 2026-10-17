# Semana 5 — Archivos, JSON y manejo de datos

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-05 listas"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Leer y escribir archivos de texto con `open()` y `with`
- Leer y escribir archivos CSV con el modulo `csv`
- Convertir entre diccionarios Python y texto JSON con el modulo `json`
- Manejar errores de archivo con `try/except` basico
- Entender por que JSON es el formato universal de las APIs web

**No se espera que conecte a bases de datos ni use FastAPI todavia.**

---

## Analogia clave 

> "El `with` de Python para archivos es como el Oxxo: cuando entras (abres el archivo), el cajero te atiende. Cuando sales (`with` termina), el cajero cierra la caja automaticamente. No tienes que decirle 'cierra la caja' — lo hace solo."

> "JSON es como el idioma Nahuatl entre aztecas: todos lo entienden aunque sean de tribus diferentes. Python lo entiende, JavaScript lo entiende, Java lo entiende, AWS lo entiende. Es el idioma universal de los datos en internet."

> "Un archivo CSV es como una tabla de Excel guardada en texto. Cada fila es una linea, cada columna separada por coma. Muy util para exportar datos que cualquier programa puede abrir."

---

## Equivalente Java → Python

| Java | Python | Diferencia clave |
|------|--------|-----------------|
| `new FileWriter("archivo.txt")` | `open("archivo.txt", "w")` | Mucho mas simple |
| `FileWriter.close()` manual | `with open(...):` cierra solo | `with` maneja el cierre automatico |
| `BufferedReader.readLine()` | `f.read()` o `for linea in f:` | Mucho mas directo |
| `new JSONObject()` (libreria externa) | `import json` (incluido) | Viene incluido en Python |
| `JSONObject.put("key", value)` | `json.dumps(diccionario)` | Convierte dict completo |
| `JSONObject.getString("key")` | `datos["key"]` | Acceso como diccionario |
| Sin modulo nativo para CSV | `import csv` (incluido) | Viene incluido en Python |

---

## Contenido teorico

### 5.1 Leer y escribir archivos de texto

```python
# ====== ESCRIBIR UN ARCHIVO ======
# "w" = write (crear o sobreescribir)
# with garantiza que el archivo se cierre aunque haya error
with open("mi_diario.txt", "w", encoding="utf-8") as f:
    f.write("Lunes: Hoy aprendi Python\n")    # \n es el salto de linea
    f.write("Martes: Ya entiendo los archivos\n")
    f.write("Miercoles: CSV y JSON son faciles\n")

print("Archivo creado!")

# ====== LEER TODO EL CONTENIDO ======
with open("mi_diario.txt", "r", encoding="utf-8") as f:
    contenido = f.read()    # lee todo de una sola vez como un string largo
    print(contenido)

# ====== LEER LINEA POR LINEA ======
with open("mi_diario.txt", "r", encoding="utf-8") as f:
    for linea in f:
        print(linea.strip())    # .strip() quita el \n y espacios extra

# ====== AGREGAR AL FINAL (sin borrar lo que ya habia) ======
# "a" = append (agregar al final)
with open("mi_diario.txt", "a", encoding="utf-8") as f:
    f.write("Jueves: JSON y CSV dominados!\n")

# ====== LEER TODAS LAS LINEAS EN UNA LISTA ======
with open("mi_diario.txt", "r", encoding="utf-8") as f:
    lineas = f.readlines()    # devuelve una lista de strings, uno por linea
    print(f"Total de lineas: {len(lineas)}")
```

**Modos de apertura:**
- `"r"` — leer (read) — el archivo debe existir
- `"w"` — escribir (write) — crea el archivo o lo sobreescribe
- `"a"` — agregar (append) — agrega al final sin borrar lo anterior
- `"x"` — crear (exclusive) — crea pero falla si ya existe

### 5.2 CSV — datos en formato tabla

CSV = Comma Separated Values. Es texto plano donde cada fila es una linea y cada columna se separa por coma.

```python
import csv    # modulo incluido en Python, no hay que instalar nada

# ====== ESCRIBIR UN CSV ======
with open("jugadoras.csv", "w", newline="", encoding="utf-8") as f:
    # DictWriter usa nombres de columna como encabezados
    writer = csv.DictWriter(f, fieldnames=["nombre", "posicion", "goles"])

    writer.writeheader()    # escribe la primera fila con los nombres de columna
    writer.writerow({"nombre": "Jess", "posicion": "delantera", "goles": 15})
    writer.writerow({"nombre": "Ana", "posicion": "portera", "goles": 0})
    writer.writerow({"nombre": "Laura", "posicion": "media", "goles": 8})

print("CSV creado!")

# ====== LEER UN CSV ======
with open("jugadoras.csv", "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)    # DictReader hace que cada fila sea un diccionario
    for fila in reader:
        # fila es un dict: {"nombre": "Jess", "posicion": "delantera", "goles": "15"}
        print(f"{fila['nombre']} - {fila['posicion']}: {fila['goles']} goles")
```

**Nota importante:** los valores leidos de CSV son siempre `str` (texto). Si necesitas numeros, convierte con `int(fila["goles"])`.

### 5.3 JSON — el formato universal de las APIs

JSON es el formato que usan todas las APIs de internet para enviar y recibir datos. Veras JSON en FastAPI, AWS Lambda, y en absolutamente todo proyecto web.

```python
import json    # modulo incluido, no hay que instalar

# ====== PYTHON DICT → JSON STRING ======
persona = {
    "nombre": "Jess",
    "edad": 22,
    "activa": True,
    "hobbies": ["futbol", "programacion", "musica"]
}

# json.dumps = "dump to string" (dump a string)
json_texto = json.dumps(persona)
print(json_texto)
# Resultado: {"nombre": "Jess", "edad": 22, "activa": true, "hobbies": [...]}
# OJO: True de Python se convierte a true (minuscula) en JSON

# Con formato bonito (indent=2 agrega sangria para que sea legible)
json_bonito = json.dumps(persona, indent=2, ensure_ascii=False)
print(json_bonito)

# ====== JSON STRING → PYTHON DICT ======
texto_json = '{"nombre": "Carlos", "edad": 30, "lenguaje": "Python"}'
# json.loads = "load from string" (cargar desde string)
datos = json.loads(texto_json)
print(datos["nombre"])    # Carlos  — acceso como diccionario Python normal

# ====== GUARDAR EN ARCHIVO JSON ======
with open("persona.json", "w", encoding="utf-8") as f:
    json.dump(persona, f, indent=2, ensure_ascii=False)
    # json.dump = dump to file (guardar en archivo)

# ====== LEER DESDE ARCHIVO JSON ======
with open("persona.json", "r", encoding="utf-8") as f:
    datos_leidos = json.load(f)    # json.load = load from file
    print(datos_leidos["nombre"])  # Jess
    print(datos_leidos["hobbies"]) # ['futbol', 'programacion', 'musica']
```

**Tabla de conversion JSON ↔ Python:**

| Python | JSON |
|--------|------|
| `dict` | `object {}` |
| `list` | `array []` |
| `str` | `string ""` |
| `int`, `float` | `number` |
| `True` | `true` |
| `False` | `false` |
| `None` | `null` |

### 5.4 Manejo de errores con archivos

```python
# Siempre puede pasar que el archivo no exista, no haya permisos, etc.
try:
    with open("archivo_importante.txt", "r", encoding="utf-8") as f:
        contenido = f.read()
        print(contenido)

except FileNotFoundError:
    # El archivo no existe en la ruta indicada
    print("Error: el archivo no existe")

except PermissionError:
    # No tienes permisos de lectura
    print("Error: no tienes permisos para leer este archivo")

except Exception as e:
    # Cualquier otro error inesperado
    print(f"Error inesperado: {e}")
```

---

## Errores comunes

1. **Abrir archivo sin `with`:** si usas `f = open("archivo.txt")` y hay un error, el archivo queda abierto. Usar siempre `with open(...)` — cierra automaticamente.

2. **Olvidar `encoding="utf-8"`:** en Windows puede dar problemas con caracteres especiales (acentos, enies). Siempre especificar `encoding="utf-8"`.

3. **Leer numeros del CSV como string:** `csv.DictReader` devuelve todo como texto. Si haces `fila["goles"] + 1` da error porque es string. Convertir con `int(fila["goles"])`.

4. **Confundir `json.dumps` con `json.dump`:** `json.dumps` = a string (s de string). `json.dump` = a archivo (sin s). Lo mismo al leer: `json.loads` desde string, `json.load` desde archivo.

5. **`"w"` sobreescribe el archivo sin avisar:** si abres un archivo existente con `"w"`, borra todo y empieza de cero. Usar `"a"` si quieres agregar, o verificar que el archivo no exista antes.

6. **Caracteres mexicanos en JSON:** si el JSON tiene acentos o enies, agregar `ensure_ascii=False` al `json.dumps()` para que los guarde correctamente.

---

## Soluciones

### Ejercicio 1 — Diario personal

```python
import os    # para verificar si el archivo existe

ARCHIVO_DIARIO = "mi_diario.txt"

def agregar_entrada(texto):
    """Agrega una nueva entrada al diario."""
    # "a" = append — agrega sin borrar lo que ya habia
    with open(ARCHIVO_DIARIO, "a", encoding="utf-8") as f:
        f.write(texto + "\n")    # \n para que cada entrada este en su propia linea
    print("Entrada guardada!")

def leer_diario():
    """Lee y muestra todas las entradas del diario."""
    # Verificar si el archivo existe antes de intentar leerlo
    if not os.path.exists(ARCHIVO_DIARIO):
        print("El diario esta vacio — aun no has escrito nada")
        return

    print("=== Mi Diario ===")
    with open(ARCHIVO_DIARIO, "r", encoding="utf-8") as f:
        for i, linea in enumerate(f, start=1):
            print(f"{i}. {linea.strip()}")    # .strip() quita el \n del final

# Usar las funciones
agregar_entrada("Aprendi a leer archivos con Python")
agregar_entrada("El modulo json es muy facil de usar")
agregar_entrada("Los f-strings siguen siendo mis favoritos")
leer_diario()
```

### Ejercicio 2 — Exportar e importar datos en JSON

```python
import json

def guardar_contactos(contactos, archivo):
    """Guarda la lista de contactos en un archivo JSON."""
    with open(archivo, "w", encoding="utf-8") as f:
        # indent=2 hace el JSON legible para humanos
        # ensure_ascii=False permite acentos y enies
        json.dump(contactos, f, indent=2, ensure_ascii=False)
    print(f"Contactos guardados en {archivo}")

def cargar_contactos(archivo):
    """Carga los contactos desde un archivo JSON."""
    try:
        with open(archivo, "r", encoding="utf-8") as f:
            return json.load(f)    # devuelve la lista de diccionarios
    except FileNotFoundError:
        print(f"No existe el archivo {archivo}")
        return []    # devuelve lista vacia si no existe

# Lista de contactos (lista de diccionarios)
mis_contactos = [
    {"nombre": "Mama", "telefono": "55-1234-5678", "email": "mama@email.com"},
    {"nombre": "Carlos", "telefono": "55-9999-0000", "email": "carlos@ine.mx"},
    {"nombre": "Jess", "telefono": "55-8888-1111", "email": "jess@email.com"},
]

# Guardar en JSON
guardar_contactos(mis_contactos, "contactos.json")

# Cargar desde JSON
contactos_cargados = cargar_contactos("contactos.json")

print("\n=== Contactos cargados ===")
for c in contactos_cargados:
    print(f"{c['nombre']}: {c['telefono']}")
```

### Ejercicio 3 (Reto) — CSV de calificaciones

```python
import csv
import json

ARCHIVO_CSV = "calificaciones.csv"
ARCHIVO_JSON = "resumen_calificaciones.json"

def guardar_calificaciones_csv(calificaciones):
    """Guarda las calificaciones en formato CSV."""
    with open(ARCHIVO_CSV, "w", newline="", encoding="utf-8") as f:
        campos = ["alumna", "materia", "calificacion", "estatus"]
        writer = csv.DictWriter(f, fieldnames=campos)
        writer.writeheader()       # escribe la fila de encabezados
        writer.writerows(calificaciones)    # escribe todas las filas de una vez
    print(f"CSV guardado: {ARCHIVO_CSV}")

def generar_resumen_json():
    """Lee el CSV y genera un resumen en JSON."""
    with open(ARCHIVO_CSV, "r", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        registros = list(reader)    # convierte el reader a lista de dicts

    # Calcular estadisticas
    # int() para convertir el string del CSV a numero
    califs = [float(r["calificacion"]) for r in registros]
    promedio = sum(califs) / len(califs)
    aprobadas = [r for r in registros if float(r["calificacion"]) >= 6.0]

    resumen = {
        "total_materias": len(registros),
        "aprobadas": len(aprobadas),
        "reprobadas": len(registros) - len(aprobadas),
        "promedio_general": round(promedio, 2),
        "calificacion_maxima": max(califs),
        "calificacion_minima": min(califs)
    }

    with open(ARCHIVO_JSON, "w", encoding="utf-8") as f:
        json.dump(resumen, f, indent=2, ensure_ascii=False)

    print(f"Resumen JSON guardado: {ARCHIVO_JSON}")
    return resumen

# Datos de prueba
datos = [
    {"alumna": "Jess", "materia": "Matematicas", "calificacion": "9.5", "estatus": "Aprobada"},
    {"alumna": "Jess", "materia": "Historia", "calificacion": "8.0", "estatus": "Aprobada"},
    {"alumna": "Jess", "materia": "Quimica", "calificacion": "5.5", "estatus": "Reprobada"},
    {"alumna": "Jess", "materia": "Python", "calificacion": "10.0", "estatus": "Aprobada"},
    {"alumna": "Jess", "materia": "Ingles", "calificacion": "7.5", "estatus": "Aprobada"},
]

guardar_calificaciones_csv(datos)
resumen = generar_resumen_json()
print("\nResumen:")
print(json.dumps(resumen, indent=2))
```

---
