---
semana: 8
tema: React práctico — formularios, listas y patrones
estado: pendiente
---

# Practica — Semana 8: React práctico

> Al terminar: `bash scripts/push.sh "semana-08 react practico"`

---

## Ejercicio 1 — CRUD completo de tareas (obligatorio)

Crea `src/pages/GestorTareas.tsx`.

App de tareas con:
- Agregar nueva tarea (texto + prioridad: alta/media/baja)
- Marcar como completada (checkbox)
- Editar en línea (clic en el texto para editar, Enter o blur para guardar)
- Eliminar con confirmación (pide confirmar antes de borrar)
- Filtros: Todas / Pendientes / Completadas / por prioridad
- Contador: "3 pendientes · 2 completadas"
- Botón "Eliminar todas las completadas"

El estado es solo un array de tareas con `useState`. Sin backend.

**Tu solucion:**

---

## Ejercicio 2 — Tabla de empleados con búsqueda (obligatorio)

Crea `src/pages/TablaEmpleados.tsx`.

Define 12 empleados con: id, nombre, departamento ("Frontend"/"Backend"/"QA"/"Diseño"), puesto, salario, activo.

La tabla debe tener:
- Búsqueda por nombre en tiempo real
- Filtro por departamento (select)
- Filtro "Solo activos" (checkbox)
- Ordenar por columna al hacer clic en el encabezado (nombre, salario)
- Flechas en el encabezado indicando dirección del orden (↑ ↓)
- Resaltar el texto buscado dentro del nombre (busca `dangerouslySetInnerHTML` — ojo, solo para texto plano)

Todos los filtros y el orden funcionan juntos.

**Tu solucion:**

---

## Ejercicio 3 — Formulario multi-step (obligatorio)

Crea `src/pages/FormularioMultiStep.tsx`.

Un formulario dividido en 3 pasos:
- **Paso 1**: Datos personales (nombre, apellido, fecha nacimiento, género)
- **Paso 2**: Datos de contacto (email, teléfono, dirección)
- **Paso 3**: Resumen — muestra todo lo que capturó, con botón "Editar" en cada sección y botón "Confirmar"

Navegación: botones "Anterior" y "Siguiente". "Siguiente" valida el paso actual antes de avanzar.
Barra de progreso visual que muestra en qué paso estás.

**Tu solucion:**

---

## Ejercicio 4 — Panel de notificaciones (obligatorio)

Crea `src/components/PanelNotificaciones.tsx`.

Un panel que:
- Muestra una lista de notificaciones: `{ id, tipo: "info"|"exito"|"error"|"advertencia", mensaje, leida: boolean, fecha }`
- Cada notificación tiene icono/color según su tipo
- Botón "Marcar como leída" en cada una
- Botón "Marcar todas como leídas"
- Botón "Eliminar leídas"
- Contador de no leídas en el título del panel
- Las leídas aparecen en opacidad reducida

Define 6-8 notificaciones de ejemplo con `useState`.

**Tu solucion:**

---

## Ejercicio 5 — Reto: Kanban board simple (opcional)

Crea `src/pages/KanbanBoard.tsx`.

Un tablero Kanban con 3 columnas: "Por hacer", "En progreso", "Hecho".

- Cada columna muestra sus tarjetas con título y descripción
- Botón "+" en cada columna para agregar una tarjeta (formulario inline)
- Botones → y ← en cada tarjeta para moverla a la columna siguiente o anterior
- Contador de tarjetas por columna

**Tu solucion:**

---

## Checklist

- [ ] Ejercicio 1: editar en línea funciona con Enter y con blur
- [ ] Ejercicio 2: búsqueda + filtro + orden funcionan al mismo tiempo
- [ ] Ejercicio 3: "Siguiente" valida el paso actual antes de avanzar
- [ ] Ejercicio 4: el contador de no leídas se actualiza correctamente
- [ ] Subi con `bash scripts/push.sh`
