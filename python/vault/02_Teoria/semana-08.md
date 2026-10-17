# Semana 8 — FastAPI + PostgreSQL: el stack completo

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-08 archivos y excepciones"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Conectar FastAPI a PostgreSQL usando SQLAlchemy
- Definir tablas como clases Python (modelos ORM)
- Implementar un CRUD completo que persista datos en la base de datos
- Entender la diferencia entre modelo SQLAlchemy (tabla) y schema Pydantic (validacion)
- Correr PostgreSQL con Docker

**Prerequisito: Docker instalado y corriendo. La guia de instalacion va aparte.**

---

## Analogia clave 

> "SQLAlchemy es como un traductor entre Python y la base de datos. Tu hablas Python (clases, objetos, metodos), SQLAlchemy traduce al idioma SQL que entiende PostgreSQL. Es lo mismo que JPA/Hibernate en Java — le dices al ORM 'guarda este objeto' y el se encarga de escribir el INSERT."

> "El modelo SQLAlchemy (`class Estudiante(Base)`) es como la ficha de registro del ISSSTE: define los campos que tiene cada registro. El schema Pydantic (`class EstudianteIn(BaseModel)`) es el formulario que llena el usuario. Son parecidos pero tienen propositos diferentes."

> "La sesion de base de datos es como el cuaderno del tendero: abres el cuaderno (sesion), anotas lo que compro el cliente (operaciones), cobras al final (commit), y cierras el cuaderno (close). Si no cobras (commit), las anotaciones desaparecen."

---

## Equivalente Java → Python/SQLAlchemy

| Java (JPA/Hibernate) | Python (SQLAlchemy) | Diferencia |
|---------------------|--------------------|-|
| `@Entity public class Estudiante` | `class Estudiante(Base):` | Hereda de `Base` en lugar de anotacion |
| `@Id @GeneratedValue` | `Column(Integer, primary_key=True)` | Columna con primary_key=True |
| `@Column(nullable=false)` | `Column(String, nullable=False)` | Mismo concepto |
| `EntityManager.persist(obj)` | `db.add(obj)` | Mucho mas simple |
| `EntityManager.getTransaction().commit()` | `db.commit()` | Solo un metodo |
| `em.find(Clase, id)` | `db.query(Clase).filter(...).first()` | Query builder |
| `em.remove(obj)` | `db.delete(obj)` | Directo |
| `@Transactional` | Manejo manual de sesion con `try/finally` | Mas explicito |

---

## Contenido teorico

### 8.1 Correr PostgreSQL con Docker

```bash
# Levantar PostgreSQL en Docker (una sola vez)
docker run --name postgres-curso \
  -e POSTGRES_USER=alumno \
  -e POSTGRES_PASSWORD=alumno123 \
  -e POSTGRES_DB=mi_escuela \
  -p 5432:5432 \
  -d postgres:15

# Verificar que corre
docker ps

# Detener (cuando termines de estudiar)
docker stop postgres-curso

# Volver a iniciar el contenedor existente
docker start postgres-curso
```

### 8.2 Instalar dependencias

```bash
# Activar venv primero
source .venv/bin/activate

pip install fastapi uvicorn sqlalchemy psycopg2-binary
pip freeze > requirements.txt
```

### 8.3 Configurar la conexion — `database.py`

```python
# database.py — configuracion de la conexion a PostgreSQL
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# URL de conexion: postgresql://usuario:password@host:puerto/nombre_bd
DATABASE_URL = "postgresql://alumno:alumno123@localhost:5432/mi_escuela"

# create_engine crea el "motor" de conexion
engine = create_engine(DATABASE_URL)

# SessionLocal es la fabrica de sesiones — cada request tiene su propia sesion
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base es la clase padre de todos los modelos SQLAlchemy
Base = declarative_base()

# Funcion que FastAPI usara para inyectar la sesion en cada endpoint
def get_db():
    db = SessionLocal()    # abrir sesion nueva
    try:
        yield db           # entregar la sesion al endpoint
    finally:
        db.close()         # SIEMPRE cerrar la sesion al terminar
```

### 8.4 Definir tablas — `models.py`

```python
# models.py — definicion de tablas como clases Python
from sqlalchemy import Column, Integer, String, Float, Boolean, DateTime
from sqlalchemy.sql import func    # para el timestamp automatico
from database import Base          # importar la Base que creamos

class Estudiante(Base):
    # __tablename__ define como se llama la tabla en PostgreSQL
    __tablename__ = "estudiantes"

    # Columnas de la tabla
    id = Column(Integer, primary_key=True, index=True)
    # primary_key=True: es el ID unico autoincremental
    # index=True: crea un indice para busquedas rapidas por id

    nombre = Column(String(100), nullable=False)
    # nullable=False: el campo es obligatorio (no puede ser NULL)

    edad = Column(Integer)
    promedio = Column(Float, default=0.0)
    activo = Column(Boolean, default=True)

    # Timestamp automatico — se pone cuando se crea el registro
    creado_en = Column(DateTime, server_default=func.now())
```

### 8.5 Schemas Pydantic — `schemas.py`

```python
# schemas.py — schemas Pydantic para validacion de datos de la API
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# Schema para CREAR un estudiante (lo que manda el usuario en el POST)
class EstudianteCreate(BaseModel):
    nombre: str
    edad: int
    promedio: float = 0.0

# Schema para RESPUESTA (lo que devuelve la API)
# Incluye el id y creado_en que se generan automaticamente
class EstudianteResponse(EstudianteCreate):
    id: int
    activo: bool
    creado_en: Optional[datetime] = None

    class Config:
        from_attributes = True   # permite convertir objetos SQLAlchemy a Pydantic
```

### 8.6 CRUD completo — `main.py`

```python
# main.py — API con FastAPI + PostgreSQL
from fastapi import FastAPI, HTTPException, Depends
from sqlalchemy.orm import Session
from database import engine, get_db, Base
from models import Estudiante
from schemas import EstudianteCreate, EstudianteResponse

# Crear todas las tablas en la BD si no existen
Base.metadata.create_all(bind=engine)

app = FastAPI(title="API Escolar con PostgreSQL")


# === GET /estudiantes — listar todos ===
@app.get("/estudiantes", response_model=list[EstudianteResponse])
def listar_estudiantes(db: Session = Depends(get_db)):
    # Depends(get_db) inyecta la sesion de BD automaticamente
    # db.query(Estudiante) es el equivalente a "SELECT * FROM estudiantes"
    return db.query(Estudiante).all()


# === GET /estudiantes/{id} — buscar uno ===
@app.get("/estudiantes/{estudiante_id}", response_model=EstudianteResponse)
def obtener_estudiante(estudiante_id: int, db: Session = Depends(get_db)):
    # .filter() = WHERE en SQL
    # .first() = LIMIT 1 — devuelve el primero o None
    estudiante = db.query(Estudiante).filter(Estudiante.id == estudiante_id).first()

    if estudiante is None:
        raise HTTPException(status_code=404, detail="Estudiante no encontrado")

    return estudiante


# === POST /estudiantes — crear uno ===
@app.post("/estudiantes", response_model=EstudianteResponse, status_code=201)
def crear_estudiante(datos: EstudianteCreate, db: Session = Depends(get_db)):
    # Crear el objeto ORM a partir de los datos validados
    # **datos.model_dump() desempaca el dict del schema en los kwargs del constructor
    nuevo = Estudiante(**datos.model_dump())

    db.add(nuevo)       # agregar a la sesion (como hacer un INSERT pendiente)
    db.commit()         # ejecutar el INSERT en la BD
    db.refresh(nuevo)   # recargar el objeto (para obtener el id generado)

    return nuevo


# === PUT /estudiantes/{id} — actualizar ===
@app.put("/estudiantes/{estudiante_id}", response_model=EstudianteResponse)
def actualizar_estudiante(
    estudiante_id: int,
    datos: EstudianteCreate,
    db: Session = Depends(get_db)
):
    estudiante = db.query(Estudiante).filter(Estudiante.id == estudiante_id).first()

    if estudiante is None:
        raise HTTPException(status_code=404, detail="Estudiante no encontrado")

    # Actualizar los atributos del objeto ORM
    estudiante.nombre = datos.nombre
    estudiante.edad = datos.edad
    estudiante.promedio = datos.promedio

    db.commit()           # ejecutar el UPDATE
    db.refresh(estudiante)
    return estudiante


# === DELETE /estudiantes/{id} — eliminar ===
@app.delete("/estudiantes/{estudiante_id}", status_code=204)
def eliminar_estudiante(estudiante_id: int, db: Session = Depends(get_db)):
    estudiante = db.query(Estudiante).filter(Estudiante.id == estudiante_id).first()

    if estudiante is None:
        raise HTTPException(status_code=404, detail="Estudiante no encontrado")

    db.delete(estudiante)    # marcar para eliminar
    db.commit()              # ejecutar el DELETE
```

### 8.7 Estructura de archivos del proyecto

```
semana-08/
├── .venv/               # entorno virtual (en .gitignore)
├── main.py              # endpoints FastAPI
├── database.py          # configuracion de la conexion y get_db
├── models.py            # tablas SQLAlchemy
├── schemas.py           # validacion Pydantic
└── requirements.txt     # fastapi uvicorn sqlalchemy psycopg2-binary
```

---

## Errores comunes

1. **`OperationalError: could not connect to server`:** Docker no esta corriendo o el contenedor de PostgreSQL no fue iniciado. Verificar con `docker ps` y `docker start postgres-curso`.

2. **`ProgrammingError: table ... does not exist`:** `Base.metadata.create_all(bind=engine)` no fue llamado. Asegurarse de que esta linea este en `main.py` antes de cualquier request.

3. **Olvidar `db.commit()` despues de `db.add()`:** el objeto se agrega a la sesion pero nunca se guarda en la BD. La sesion se cierra sin commit y los datos se pierden.

4. **No llamar `db.refresh(objeto)`:** despues del commit, el objeto puede no tener los valores generados por la BD (como el `id` autoincremental). `db.refresh()` recarga el objeto desde la BD.

5. **Confundir modelo SQLAlchemy con schema Pydantic:** el modelo (`class Estudiante(Base)`) es la tabla. El schema (`class EstudianteCreate(BaseModel)`) es la validacion de la API. Son clases diferentes con propositos distintos.

6. **No cerrar la sesion:** sin `try/finally` en `get_db`, si hay un error la sesion queda abierta. PostgreSQL tiene limite de conexiones — las conexiones abiertas se agotan con el tiempo.

---

## Soluciones

### Ejercicio 1 — CRUD completo de productos

```python
# models.py — tabla de productos
from sqlalchemy import Column, Integer, String, Float
from database import Base

class Producto(Base):
    __tablename__ = "productos"
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(200), nullable=False)
    descripcion = Column(String(500), default="")
    precio = Column(Float, nullable=False)
    stock = Column(Integer, default=0)
    categoria = Column(String(100), default="General")
```

```python
# main.py — endpoints de productos
from fastapi import FastAPI, HTTPException, Depends
from sqlalchemy.orm import Session
from pydantic import BaseModel
from database import engine, get_db, Base
from models import Producto

Base.metadata.create_all(bind=engine)
app = FastAPI(title="Catalogo de Productos")

class ProductoCreate(BaseModel):
    nombre: str
    descripcion: str = ""
    precio: float
    stock: int = 0
    categoria: str = "General"

class ProductoResponse(ProductoCreate):
    id: int
    class Config:
        from_attributes = True

@app.get("/productos", response_model=list[ProductoResponse])
def listar(categoria: str = None, db: Session = Depends(get_db)):
    query = db.query(Producto)
    if categoria:
        query = query.filter(Producto.categoria == categoria)
    return query.all()

@app.post("/productos", response_model=ProductoResponse, status_code=201)
def crear(datos: ProductoCreate, db: Session = Depends(get_db)):
    nuevo = Producto(**datos.model_dump())
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return nuevo

@app.get("/productos/{pid}", response_model=ProductoResponse)
def obtener(pid: int, db: Session = Depends(get_db)):
    p = db.query(Producto).filter(Producto.id == pid).first()
    if not p:
        raise HTTPException(404, "Producto no encontrado")
    return p

@app.delete("/productos/{pid}", status_code=204)
def eliminar(pid: int, db: Session = Depends(get_db)):
    p = db.query(Producto).filter(Producto.id == pid).first()
    if not p:
        raise HTTPException(404, "Producto no encontrado")
    db.delete(p)
    db.commit()
```

### Ejercicio 2 — Agregar filtros y paginacion

```python
# En el endpoint GET /estudiantes, agregar paginacion
@app.get("/estudiantes", response_model=list[EstudianteResponse])
def listar_estudiantes(
    skip: int = 0,          # cuantos registros saltar (para paginar)
    limit: int = 10,        # cuantos registros devolver como maximo
    nombre: str = None,     # filtro opcional por nombre
    db: Session = Depends(get_db)
):
    query = db.query(Estudiante)

    if nombre:
        # ilike = like case-insensitive en SQLAlchemy
        query = query.filter(Estudiante.nombre.ilike(f"%{nombre}%"))

    return query.offset(skip).limit(limit).all()
    # .offset(skip) = OFFSET en SQL
    # .limit(limit) = LIMIT en SQL
```

### Ejercicio 3 (Reto) — Dos tablas con relacion

```python
# models.py — dos tablas relacionadas: Cursos y Estudiantes inscritos

from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class Curso(Base):
    __tablename__ = "cursos"
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(200), nullable=False)
    descripcion = Column(String(500), default="")
    # relationship define la relacion a nivel Python (no crea columna)
    inscripciones = relationship("Inscripcion", back_populates="curso")

class Inscripcion(Base):
    __tablename__ = "inscripciones"
    id = Column(Integer, primary_key=True, index=True)
    estudiante_nombre = Column(String(100), nullable=False)
    # ForeignKey referencia a la columna id de la tabla cursos
    curso_id = Column(Integer, ForeignKey("cursos.id"))
    calificacion = Column(Float, default=0.0)
    # back_populates conecta con el relationship del otro lado
    curso = relationship("Curso", back_populates="inscripciones")
```

---
