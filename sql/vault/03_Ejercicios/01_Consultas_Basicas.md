---
tema: 10 Consultas básicas de práctica
estado: en-progreso
nivel: basico
---

# 10 Consultas Básicas — Sistema RRHH

> Antes de ver las soluciones, intenta escribir cada consulta tú sola.
> Soluciones en `scripts/05_consultas_basicas_solucion.sql`.
> Cuando termines estas, continúa con `02_Consultas_Intermedias.md`.

---

## Consulta 1 — Ver todos los empleados

Selecciona todos los campos de la tabla `empleados`. ¿Cuántos registros hay en total?
SELECT count(*) from empleados
**Conceptos:** `SELECT *`, `FROM`

---

## Consulta 2 — Solo los datos importantes

Muestra únicamente el nombre, apellido, email y salario de los empleados **activos**. Ordénalos por salario de mayor a menor.

**Conceptos:** `SELECT columnas`, `WHERE`, `ORDER BY DESC`
SELECT nombre, apellido, email, salario FROM empleados where activo = 1 order by salario DESC
**Columnas esperadas:**
```
nombre | apellido | email | salario
```

---

## Consulta 3 — Los 5 mejores salarios

Lista los 5 empleados con el salario más alto. Muestra nombre, apellido y salario.

**Conceptos:** `ORDER BY DESC`, `LIMIT`
select nombre, apellido, salario from empleados order BY salario desc limit 5

**Columnas esperadas:**
```
nombre | apellido | salario
```

---

## Consulta 4 — Buscar por apellido

Encuentra todos los empleados cuyo apellido contiene la palabra **"López"** (con o sin acento). Muestra nombre, apellido y email.

**Conceptos:** `LIKE`, `%`
select nombre, apellido, email FROM empleados WHERE apellido like '%lopez%'
> Tip: `LIKE '%Lopez%'` busca cualquier apellido que contenga "Lopez" en cualquier posición.

**Columnas esperadas:**
```
nombre | apellido | email
```

---

## Consulta 5 — Rango de salario

Lista los empleados activos con salario entre **$22,000 y $45,000**. Muestra nombre, apellido y salario, ordenados por salario ascendente.

**Conceptos:** `BETWEEN`, `AND`, `ORDER BY ASC`
SELECT nombre, apellido, salario from empleados where activo = 1 and salario BETWEEN 22000 and 45000 order by salario asc

**Columnas esperadas:**
```
nombre | apellido | salario
```

---

## Consulta 6 — Empleados recientes

Muestra los empleados contratados a partir del **1 de enero de 2023**. Incluye nombre, apellido y fecha de contratación.

**Conceptos:** `WHERE` con fecha, comparador `>=`
select nombre, apellido, fecha_contratacion from empleados where fecha_contratacion >= '2023-01-01'
**Columnas esperadas:**
```
nombre | apellido | fecha_contratacion
```

---

## Consulta 7 — Filtrar por lista de puestos

Lista los empleados activos que tienen el puesto `id_puesto` igual a **3 (Desarrollador)** o **4 (Gerente)**. Muestra nombre, apellido, salario e id_puesto.

**Conceptos:** `IN`
SELECT nombre, apellido, salario, id_puesto from empleados where activo = 1 and id_puesto in (3, 4)

**Columnas esperadas:**
```
nombre | apellido | salario | id_puesto
```

---

## Consulta 8 — Empleados sin jefe

Obtén los empleados que **no tienen jefe asignado** (campo `id_jefe` es nulo). Muestra nombre, apellido e id_departamento.

**Conceptos:** `IS NULL`
select nombre,apellido, id_departamento from empleados where id_jefe is NULL

**Columnas esperadas:**
```
nombre | apellido | id_departamento
```

---

## Consulta 9 — Ver todos los departamentos

Selecciona todos los departamentos disponibles. Muestra nombre, ubicación y presupuesto, ordenados por presupuesto de mayor a menor.

**Conceptos:** `SELECT` de tabla diferente, `ORDER BY`
select d.nombre, d.ubicacion, d.presupuesto FROM departamentos d order by d.presupuesto desc
**Columnas esperadas:**
```
nombre | ubicacion | presupuesto
```

---

## Consulta 10 — Primer JOIN: empleado con su departamento

Muestra el nombre, apellido y **nombre del departamento** de cada empleado activo. Ordena por nombre de departamento y luego por apellido.

**Conceptos:** `INNER JOIN` (2 tablas), alias de tabla

> Tip:
> ```sql
> SELECT e.nombre, e.apellido, d.nombre AS departamento
> FROM empleados e
> INNER JOIN departamentos d ON e.id_departamento = d.id_departamento
> ```
select e.nombre, e.apellido, d.nombre as departamento from empleados e join departamentos d on d.id_departamento = e.id_departamento where e.activo = 1 order by d.nombre , apellido
**Columnas esperadas:**
```
nombre | apellido | departamento
```

---

## Siguiente paso

Cuando todas estas consultas funcionen correctamente, abre `02_Consultas_Intermedias.md` para practicar `GROUP BY`, `HAVING` y funciones de agregación.
