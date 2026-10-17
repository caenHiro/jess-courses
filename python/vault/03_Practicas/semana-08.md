---
semana: 8
tema: FastAPI + PostgreSQL
estado: pendiente
---

# Practica Semana 8 — FastAPI + PostgreSQL: guardando en la BD real

> Lee la teoria en `02_Teoria/semana-08.md` antes de empezar.
> Prerequisito: Docker corriendo con PostgreSQL
> Guarda tu codigo en: `codigo/semana-08/`

---

## Configuracion inicial

```bash
cd codigo/semana-08
python -m venv venv
source venv/bin/activate
pip install fastapi uvicorn sqlalchemy psycopg2-binary

# Iniciar contenedor PostgreSQL (si no esta corriendo)
docker start jess-postgres
```

---

## Ejercicio 1 — API de Estudiantes con BD (obligatorio)

Convierte la API de tareas de la semana 7 para guardar en PostgreSQL.

Crea estos archivos:
- `database.py` — conexion a PostgreSQL
- `models.py` — tabla `Estudiante` (id, nombre, edad, carrera)
- `schemas.py` — clases Pydantic para entrada/salida
- `main.py` — app FastAPI con endpoints CRUD

Endpoints:
- `GET /estudiantes` — listar todos
- `POST /estudiantes` — crear uno
- `GET /estudiantes/{id}` — obtener uno (404 si no existe)
- `DELETE /estudiantes/{id}` — eliminar (404 si no existe)

---

## Ejercicio 2 — Prueba desde /docs (obligatorio)

1. Abre `http://localhost:8000/docs`
2. Crea 5 estudiantes con diferentes carreras
3. Consulta la lista completa
4. Obtiene uno por ID
5. Elimina uno
6. Verifica que ya no aparece en la lista

Escribe aqui que hiciste y que resultado obtuviste:

_Tu respuesta:_

---

## Ejercicio 3 — Endpoint de busqueda (reto)

Agrega un endpoint de busqueda:
- `GET /estudiantes/buscar?carrera=Sistemas`

Que filtre los estudiantes por carrera usando SQLAlchemy:
```python
db.query(Estudiante).filter(Estudiante.carrera == carrera).all()
```

---

## Reflexion

**¿Que ventaja tiene SQLAlchemy sobre escribir SQL directo en el codigo?**

_Tu respuesta:_

**¿Que hace `Depends(get_db)` y por que es importante cerrar la sesion al terminar?**

_Tu respuesta:_

**¿Como sabrias si tu BD esta guardando los datos correctamente entre reinicios?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-08 fastapi-postgresql"`
