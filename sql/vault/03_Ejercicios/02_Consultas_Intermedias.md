---
tema: 10 Consultas intermedias de práctica
estado: en-progreso
nivel: intermedio
---

# 10 Consultas Intermedias — Sistema RRHH

> Completa primero `01_Consultas_Basicas.md` antes de iniciar estas.
> Soluciones en `scripts/06_consultas_intermedias_solucion.sql`.

---

## Consulta 1 — Lista completa con departamento y puesto

Obtén el nombre completo de cada empleado activo, el nombre de su departamento y el nombre de su puesto. Ordena por departamento y luego por apellido.

**Conceptos:** `INNER JOIN` de 3 tablas, `CONCAT()`, `ORDER BY`
SELECT CONCAT(e.nombre , '' , e.apellido ) as nombre_completo, d.nombre, p.nombre_puesto FROM empleados e join departamentos d on e.id_departamento = d.id_departamento join puestos p ON e.id_puesto = p.id_puesto where e.activo = 1 order by d.nombre, e.apellido
**Columnas esperadas:**
```
nombre_completo | departamento | puesto | salario
```

---

## Consulta 2 — Empleados que ganan más que el promedio

Lista los empleados activos que ganan más que el promedio de salario general. Muestra nombre, apellido, salario y el promedio general como columna adicional.

**Conceptos:** subconsulta en `WHERE`, `AVG()`
select nombre, apellido, salario, (select AVG(salario) as promedio from empleados ) from empleados where activo = 1 and salario > (select AVG(salario) as promedio from empleados )

**Columnas esperadas:**
```
nombre | apellido | salario | promedio_general
```

---

## Consulta 3 — Conteo de empleados por departamento

Muestra cuántos empleados activos hay en cada departamento. Usa el nombre del departamento, no el ID.

**Conceptos:** `GROUP BY`, `COUNT()`, `INNER JOIN`
select d.nombre, COUNT(*) from empleados e join departamentos d on e.id_departamento = d.id_departamento GROUP by d.nombre
**Columnas esperadas:**
```
departamento | total_empleados
```

---

## Consulta 4 — Departamentos con más de 3 empleados

Filtra los departamentos que tienen más de 3 empleados activos.

**Conceptos:** `GROUP BY`, `HAVING`, `COUNT()`

> Diferencia clave: `WHERE` filtra filas individuales, `HAVING` filtra grupos ya calculados.
select d.nombre, COUNT(*) from empleados e join departamentos d on e.id_departamento = d.id_departamento GROUP by d.nombre HAVING COUNT(*) > 3
**Columnas esperadas:**
```
departamento | total_empleados
```

---

## Consulta 5 — Empleados sin jefe con puesto y departamento

Obtén los empleados que no tienen jefe asignado. Esta vez muestra también el nombre del puesto y del departamento (no los IDs).

**Conceptos:** `IS NULL`, `INNER JOIN` de 3 tablas
SELECT e.nombre, e.apellido, p.nombre_puesto, d.nombre from empleados e join puestos p on e.id_puesto = p.id_puesto join departamentos d on e.id_departamento = d.id_departamento WHERE e.id_jefe is null
**Columnas esperadas:**
```
nombre | apellido | puesto | departamento
```

---

## Consulta 6 — Empleados recientes con días en la empresa

Lista los empleados contratados a partir del 1 de junio de 2023. Muestra nombre, apellido, fecha de contratación y cuántos días llevan en la empresa.

**Conceptos:** `WHERE` con fechas, `DATEDIFF()`, `CURDATE()`
select nombre, apellido, fecha_contratacion, DATEDIFF(CURDATE() , fecha_contratacion ) from empleados where fecha_contratacion > '2023-06-01'
**Columnas esperadas:**
```
nombre | apellido | fecha_contratacion | dias_en_empresa
```

---

## Consulta 7 — Top 3 departamentos con mayor salario promedio

Muestra los 3 departamentos con el salario promedio más alto. Incluye el nombre del departamento y el promedio formateado con 2 decimales.

**Conceptos:** `GROUP BY`, `AVG()`, `ROUND(AVG(e.salario))`, `ORDER BY DESC`, `LIMIT`
SELECT d.nombre , ROUND(AVG(e.salario),2 ) salario from empleados e join departamentos d on e.id_departamento = d.id_departamento GROUP by d.nombre order by salario desc limit 3
**Columnas esperadas:**
```
departamento | salario_promedio
```

---

## Consulta 8 — Empleados en más de un proyecto

Encuentra los empleados que están asignados a 2 o más proyectos. Muestra nombre completo y cuántos proyectos tienen.

**Conceptos:** `JOIN`, `GROUP BY`, `HAVING COUNT() >= 2`

**Columnas esperadas:**
```
nombre | apellido | total_proyectos
```

---

## Consulta 9 — Departamentos sin proyectos activos

Lista los departamentos que **no tienen ningún proyecto** con estado `activo` asignado.

**Conceptos:** `LEFT JOIN`, `WHERE IS NULL`

> Tip: usa `LEFT JOIN` entre `departamentos` y `proyectos` con condición de estado `activo`. Los que no tengan proyecto quedarán con `NULL` en el id del proyecto.

**Columnas esperadas:**
```
departamento | ubicacion
```

---

## Consulta 10 — Resumen completo por departamento

Genera un resumen por departamento con:
- Cantidad de empleados activos
- Salario mínimo
- Salario máximo
- Salario promedio (2 decimales)
- Total de la nómina (suma de todos los salarios)

Ordena por total de nómina de mayor a menor.

**Conceptos:** `GROUP BY`, `COUNT()`, `MIN()`, `MAX()`, `AVG()`, `SUM()`, `ROUND()`, `ORDER BY`

**Columnas esperadas:**
```
departamento | empleados | salario_min | salario_max | salario_promedio | nomina_total
```
