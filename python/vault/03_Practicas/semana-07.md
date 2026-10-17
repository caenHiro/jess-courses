---
semana: 7
tema: FastAPI — tu primera API
estado: pendiente
---

# Practica Semana 7 — FastAPI: construye tu primera API

> Lee la teoria en `02_Teoria/semana-07.md` antes de empezar.
> Guarda tu codigo en: `codigo/semana-07/`

---

## Configuracion inicial

```bash
cd codigo/semana-07
python -m venv venv
source venv/bin/activate    # Mac/Linux
pip install fastapi uvicorn
```

---

## Ejercicio 1 — API de tareas (obligatorio)

Crea `main.py` con una API que gestione tareas (to-do list) EN MEMORIA (sin BD):

Endpoints:
- `GET /tareas` — lista todas las tareas
- `GET /tareas/{id}` — obtiene una tarea por ID (404 si no existe)
- `POST /tareas` — crea una nueva tarea (campos: titulo, descripcion)
- `DELETE /tareas/{id}` — elimina una tarea (404 si no existe)

Usa una lista de Python como "base de datos" temporal.

Prueba desde el navegador en `http://localhost:8000/docs`.

---

## Ejercicio 2 — Validacion con Pydantic (obligatorio)

Agrega validacion a tu API del ejercicio 1:

```python
from pydantic import BaseModel, Field

class TareaIn(BaseModel):
    titulo: str = Field(min_length=3, max_length=100)
    descripcion: str = Field(default="", max_length=500)
    prioridad: int = Field(ge=1, le=5)   # entre 1 y 5
```

Si el usuario manda datos invalidos, FastAPI debe responder con error 422.

Prueba mandando datos incorrectos desde `/docs`.

---

## Ejercicio 3 — API de recetas (reto)

Crea una API separada `recetas.py` para gestionar recetas de cocina:
- Campos: id, nombre, ingredientes (lista de strings), tiempo_minutos, dificultad (facil/media/dificil)
- `GET /recetas` con filtro opcional: `?dificultad=facil`
- `POST /recetas`
- `GET /recetas/{id}`

---

## Reflexion

**¿Que ventaja tiene que FastAPI genere el `/docs` automaticamente?**

_Tu respuesta:_

**¿Que hace Pydantic que no hace una clase Python normal?**

_Tu respuesta:_

**¿Como se compara FastAPI con Spring Boot que viste en el Curso 1?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-07 fastapi"`
