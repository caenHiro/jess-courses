# Semana 7 — FastAPI: tu primera API REST en Python

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-07 clases y poo"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Crear una API REST basica con FastAPI
- Definir endpoints GET, POST, PUT, DELETE con los decoradores `@app.get`, `@app.post`, etc.
- Validar datos de entrada con Pydantic `BaseModel`
- Correr el servidor con `uvicorn` y probar la API desde `/docs`
- Entender que los decoradores de FastAPI SON lo que vio en semana 6

**No se espera base de datos todavia — los datos viven en memoria (lista/diccionario).**

---

## Analogia clave 

> "FastAPI es como el mostrador del IMSS: tu llegas con tu peticion (request HTTP), el mostrador (FastAPI) revisa que traes los papeles correctos (Pydantic), te dirige al area correcta (la funcion endpoint), y te devuelve la respuesta. Cada ventanilla es un endpoint diferente."

> "Un endpoint GET es como preguntar en la farmacia '¿tienen ibuprofeno?' — solo estas pidiendo informacion. Un POST es como llenar la receta medica para que te den el medicamento — estas mandando datos para crear algo nuevo."

> "Pydantic BaseModel es como el formulario del banco: define exactamente que campos se necesitan y de que tipo. Si mandas el formulario incompleto o con datos incorrectos, te lo regresan antes de que llegue al cajero."

---

## Equivalente Java → Python/FastAPI

| Java (Spring Boot) | Python (FastAPI) | Nota |
|-------------------|-----------------|------|
| `@RestController` | `app = FastAPI()` | La app es el controlador |
| `@GetMapping("/ruta")` | `@app.get("/ruta")` | Mismo concepto |
| `@PostMapping("/ruta")` | `@app.post("/ruta")` | Mismo concepto |
| `@RequestBody TipoDto datos` | `datos: MiModelo` con `BaseModel` | Pydantic valida como DTO |
| `@PathVariable int id` | `def f(id: int)` en la URL | Parametro de ruta |
| `@RequestParam String q` | `def f(q: str = None)` | Query parameter |
| `ResponseEntity<List<...>>` | `return lista` directamente | FastAPI serializa solo |
| `spring-boot-starter-web` | `fastapi uvicorn` | Dependencias equivalentes |

---

## Contenido teorico

### 7.1 Setup del proyecto

```bash
# Crear entorno virtual e instalar FastAPI
mkdir semana-07
cd semana-07
python3 -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate

pip install fastapi uvicorn
pip freeze > requirements.txt
```

### 7.2 Tu primera API FastAPI

Crea `main.py` en la carpeta `semana-07/`:

```python
# main.py — API minima con FastAPI
from fastapi import FastAPI    # importar FastAPI

# La app es el objeto principal — equivale al @RestController en Spring
app = FastAPI(
    title="Mi primera API",
    description="API de practicas del Curso Python para Jess",
    version="1.0.0"
)

# @app.get("/") registra este endpoint para peticiones GET a la ruta "/"
# El decorador transforma la funcion en un endpoint HTTP
@app.get("/")
def inicio():
    # FastAPI convierte automaticamente el dict a JSON en la respuesta
    return {"mensaje": "¡Hola desde mi primera API con FastAPI!"}


# Endpoint con parametro en la ruta
# {nombre} en la ruta se convierte en parametro de la funcion
@app.get("/saludo/{nombre}")
def saludar(nombre: str):
    # nombre: str es un type hint — FastAPI lo valida automaticamente
    return {"mensaje": f"¡Hola, {nombre}! Bienvenido a la API"}


# Endpoint con query parameters (parametros opcionales en la URL)
# /buscar?q=python&limite=10
@app.get("/buscar")
def buscar(q: str = "", limite: int = 10):
    # q y limite tienen valores por defecto, son opcionales en la URL
    return {"buscando": q, "maximo_resultados": limite}
```

**Correr el servidor:**
```bash
uvicorn main:app --reload
# main = el archivo main.py
# app = la variable 'app = FastAPI()' dentro del archivo
# --reload = reinicia automaticamente cuando cambias el codigo
```

Probar en el navegador:
- `http://localhost:8000` — tu API corriendo
- `http://localhost:8000/docs` — documentacion interactiva (Swagger UI)
- `http://localhost:8000/saludo/Jess` — endpoint con parametro

### 7.3 Metodos HTTP y CRUD

Los 4 verbos HTTP principales:

| Metodo HTTP | Decorador FastAPI | Uso CRUD | Ejemplo |
|-------------|------------------|----------|---------|
| `GET` | `@app.get()` | Read | Listar o buscar datos |
| `POST` | `@app.post()` | Create | Crear un registro nuevo |
| `PUT` | `@app.put()` | Update (completo) | Actualizar todos los campos |
| `DELETE` | `@app.delete()` | Delete | Eliminar un registro |

### 7.4 Pydantic BaseModel — validacion de datos

```python
from fastapi import FastAPI
from pydantic import BaseModel    # para validar datos de entrada

app = FastAPI()

# BaseModel define la estructura y tipos de los datos que esperamos recibir
class Tarea(BaseModel):
    titulo: str              # campo obligatorio — string
    descripcion: str = ""    # campo opcional con valor por defecto
    completada: bool = False # campo opcional, default False
    prioridad: int = 1       # campo opcional, default 1

# Si mandan datos incorrectos (ej: prioridad="alta" en lugar de numero),
# FastAPI automaticamente devuelve error 422 con el detalle del problema
```

### 7.5 API CRUD completa en memoria

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional

app = FastAPI(title="API de Tareas")

# === MODELO DE DATOS ===
class Tarea(BaseModel):
    titulo: str
    descripcion: str = ""
    completada: bool = False

class TareaConId(Tarea):
    id: int    # hereda Tarea y agrega el id

# === BASE DE DATOS EN MEMORIA ===
# En semana 8 esto se reemplaza con PostgreSQL real
tareas_db = []    # lista que actua como "base de datos"
contador_id = 0   # simula el auto-increment de SQL

# === ENDPOINTS ===

@app.get("/tareas", response_model=list[TareaConId])
def listar_tareas():
    """Devuelve todas las tareas."""
    return tareas_db    # FastAPI serializa la lista a JSON automaticamente

@app.get("/tareas/{tarea_id}")
def obtener_tarea(tarea_id: int):
    """Devuelve una tarea especifica por su ID."""
    for tarea in tareas_db:
        if tarea["id"] == tarea_id:
            return tarea
    # HTTPException devuelve un error HTTP con codigo de estado
    raise HTTPException(status_code=404, detail=f"Tarea {tarea_id} no encontrada")

@app.post("/tareas", status_code=201)
def crear_tarea(tarea: Tarea):
    """Crea una nueva tarea. Devuelve 201 Created."""
    global contador_id
    contador_id += 1    # incrementar el ID
    nueva_tarea = {
        "id": contador_id,
        "titulo": tarea.titulo,
        "descripcion": tarea.descripcion,
        "completada": tarea.completada
    }
    tareas_db.append(nueva_tarea)
    return {"mensaje": "Tarea creada", "tarea": nueva_tarea}

@app.put("/tareas/{tarea_id}")
def actualizar_tarea(tarea_id: int, datos: Tarea):
    """Actualiza completamente una tarea existente."""
    for i, tarea in enumerate(tareas_db):
        if tarea["id"] == tarea_id:
            tareas_db[i] = {
                "id": tarea_id,
                "titulo": datos.titulo,
                "descripcion": datos.descripcion,
                "completada": datos.completada
            }
            return {"mensaje": "Tarea actualizada", "tarea": tareas_db[i]}
    raise HTTPException(status_code=404, detail=f"Tarea {tarea_id} no encontrada")

@app.delete("/tareas/{tarea_id}", status_code=204)
def eliminar_tarea(tarea_id: int):
    """Elimina una tarea. Devuelve 204 No Content."""
    for i, tarea in enumerate(tareas_db):
        if tarea["id"] == tarea_id:
            tareas_db.pop(i)
            return    # 204 no devuelve cuerpo
    raise HTTPException(status_code=404, detail=f"Tarea {tarea_id} no encontrada")
```

### 7.6 Probar la API desde /docs

FastAPI genera automaticamente documentacion interactiva en `http://localhost:8000/docs` (Swagger UI). Desde ahi puedes:

1. Ver todos los endpoints disponibles
2. Expandir cada uno para ver parametros y modelos
3. Hacer clic en "Try it out" para ejecutar peticiones de prueba
4. Ver la respuesta en tiempo real

No necesitas Postman para probar — `/docs` es suficiente para el curso.

---

## Errores comunes

1. **El servidor no inicia porque el puerto 8000 esta ocupado:** otro proceso usa el puerto. Usar `uvicorn main:app --reload --port 8001` para cambiar el puerto.

2. **`ImportError: No module named 'fastapi'`:** el entorno virtual no esta activado. Verificar que el prompt muestre `(.venv)` y activar con `source .venv/bin/activate`.

3. **Modificar la lista `tareas_db` desde fuera del endpoint:** las variables globales en FastAPI pueden tener comportamientos inesperados. Usar `global` cuando la modificas dentro de una funcion.

4. **`422 Unprocessable Entity` al crear un recurso:** el body del request no coincide con el BaseModel. Revisar que los campos requeridos esten presentes y con el tipo correcto.

5. **Devolver el objeto Pydantic en lugar del diccionario:** si el `BaseModel` tiene metodos que no son datos, puede haber problemas al serializar. Usar `.model_dump()` para convertir a dict si hay problemas.

6. **Confundir la ruta del endpoint con la funcion:** `@app.get("/tareas")` registra la ruta, pero el codigo esta en la funcion de abajo. Ambas partes son necesarias.

---

## Soluciones

### Ejercicio 1 — API de contactos

```python
# main.py — API de contactos con FastAPI
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI(title="Directorio de Contactos")

# Modelo de datos para un contacto
class Contacto(BaseModel):
    nombre: str
    telefono: str
    email: str = ""    # email es opcional

# Base de datos en memoria
contactos = {}    # dict: nombre -> datos del contacto

@app.get("/contactos")
def listar_contactos():
    """Devuelve todos los contactos."""
    return list(contactos.values())   # .values() da los valores del dict como lista

@app.get("/contactos/{nombre}")
def buscar_contacto(nombre: str):
    """Busca un contacto por nombre."""
    if nombre not in contactos:
        raise HTTPException(status_code=404, detail=f"Contacto '{nombre}' no encontrado")
    return contactos[nombre]

@app.post("/contactos", status_code=201)
def crear_contacto(contacto: Contacto):
    """Crea un nuevo contacto."""
    if contacto.nombre in contactos:
        raise HTTPException(status_code=409, detail=f"'{contacto.nombre}' ya existe")
    contactos[contacto.nombre] = contacto.model_dump()
    return {"mensaje": "Contacto creado", "contacto": contactos[contacto.nombre]}

@app.delete("/contactos/{nombre}", status_code=204)
def eliminar_contacto(nombre: str):
    """Elimina un contacto por nombre."""
    if nombre not in contactos:
        raise HTTPException(status_code=404, detail=f"Contacto '{nombre}' no encontrado")
    del contactos[nombre]
```

### Ejercicio 2 — API de productos (con filtros)

```python
from fastapi import FastAPI, HTTPException, Query
from pydantic import BaseModel

app = FastAPI(title="Catalogo de Productos")

class Producto(BaseModel):
    nombre: str
    precio: float
    categoria: str
    stock: int = 0

productos_db = []
siguiente_id = 1

@app.get("/productos")
def listar_productos(
    categoria: str = Query(default=None, description="Filtrar por categoria"),
    precio_max: float = Query(default=None, description="Precio maximo")
):
    """Lista productos con filtros opcionales."""
    resultado = productos_db

    if categoria:
        resultado = [p for p in resultado if p["categoria"].lower() == categoria.lower()]

    if precio_max:
        resultado = [p for p in resultado if p["precio"] <= precio_max]

    return {"total": len(resultado), "productos": resultado}

@app.post("/productos", status_code=201)
def crear_producto(producto: Producto):
    global siguiente_id
    nuevo = {"id": siguiente_id, **producto.model_dump()}
    # ** desempaca el dict del modelo y lo fusiona con el id
    productos_db.append(nuevo)
    siguiente_id += 1
    return nuevo

@app.get("/productos/{producto_id}")
def obtener_producto(producto_id: int):
    for p in productos_db:
        if p["id"] == producto_id:
            return p
    raise HTTPException(status_code=404, detail="Producto no encontrado")
```

### Ejercicio 3 (Reto) — API completa con estadisticas

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI(title="API de Notas Escolares")

class Nota(BaseModel):
    alumna: str
    materia: str
    calificacion: float

notas_db = []
siguiente_id = 1

@app.post("/notas", status_code=201)
def registrar_nota(nota: Nota):
    global siguiente_id
    if not (0 <= nota.calificacion <= 10):
        raise HTTPException(
            status_code=422,
            detail="La calificacion debe estar entre 0 y 10"
        )
    nueva = {"id": siguiente_id, **nota.model_dump()}
    notas_db.append(nueva)
    siguiente_id += 1
    return nueva

@app.get("/notas")
def listar_notas():
    return notas_db

@app.get("/estadisticas")
def estadisticas():
    if not notas_db:
        return {"mensaje": "No hay notas registradas"}

    calificaciones = [n["calificacion"] for n in notas_db]
    return {
        "total_notas": len(notas_db),
        "promedio": round(sum(calificaciones) / len(calificaciones), 2),
        "maxima": max(calificaciones),
        "minima": min(calificaciones),
        "aprobadas": len([c for c in calificaciones if c >= 6.0]),
        "reprobadas": len([c for c in calificaciones if c < 6.0])
    }

@app.delete("/notas/{nota_id}", status_code=204)
def eliminar_nota(nota_id: int):
    for i, n in enumerate(notas_db):
        if n["id"] == nota_id:
            notas_db.pop(i)
            return
    raise HTTPException(status_code=404, detail="Nota no encontrada")
```

---
