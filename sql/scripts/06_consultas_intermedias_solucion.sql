-- =============================================================
-- Soluciones — 10 Consultas Intermedias
-- Sistema de Recursos Humanos
-- Ejecutar DESPUÉS de 01_ddl.sql y 02_dml.sql
-- =============================================================

USE rrhh;

-- -------------------------------------------------------------
-- Consulta 1 — Lista completa con departamento y puesto
-- Conceptos: INNER JOIN de 3 tablas, CONCAT, ORDER BY
-- -------------------------------------------------------------
SELECT
    CONCAT(e.nombre, ' ', e.apellido)  AS nombre_completo,
    d.nombre                           AS departamento,
    p.nombre_puesto                    AS puesto,
    e.salario
FROM empleados e
INNER JOIN departamentos d ON e.id_departamento = d.id_departamento
INNER JOIN puestos p       ON e.id_puesto       = p.id_puesto
WHERE e.activo = 1
ORDER BY d.nombre ASC, e.apellido ASC;

-- -------------------------------------------------------------
-- Consulta 2 — Empleados con salario mayor al promedio general
-- Conceptos: subconsulta en WHERE, AVG()
-- -------------------------------------------------------------
SELECT
    e.nombre,
    e.apellido,
    e.salario,
    ROUND((SELECT AVG(salario) FROM empleados WHERE activo = 1), 2) AS promedio_general
FROM empleados e
WHERE e.salario > (SELECT AVG(salario) FROM empleados WHERE activo = 1)
  AND e.activo = 1
ORDER BY e.salario DESC;

-- -------------------------------------------------------------
-- Consulta 3 — Conteo de empleados activos por departamento
-- Conceptos: GROUP BY, COUNT(), INNER JOIN
-- -------------------------------------------------------------
SELECT
    d.nombre             AS departamento,
    COUNT(e.id_empleado) AS total_empleados
FROM departamentos d
INNER JOIN empleados e ON d.id_departamento = e.id_departamento
WHERE e.activo = 1
GROUP BY d.id_departamento, d.nombre
ORDER BY total_empleados DESC;

-- -------------------------------------------------------------
-- Consulta 4 — Departamentos con más de 3 empleados activos
-- Conceptos: GROUP BY, HAVING, COUNT()
-- -------------------------------------------------------------
SELECT
    d.nombre             AS departamento,
    COUNT(e.id_empleado) AS total_empleados
FROM departamentos d
INNER JOIN empleados e ON d.id_departamento = e.id_departamento
WHERE e.activo = 1
GROUP BY d.id_departamento, d.nombre
HAVING total_empleados > 3
ORDER BY total_empleados DESC;

-- -------------------------------------------------------------
-- Consulta 5 — Empleados sin jefe con puesto y departamento
-- Conceptos: IS NULL, INNER JOIN 3 tablas
-- -------------------------------------------------------------
SELECT
    CONCAT(e.nombre, ' ', e.apellido) AS nombre,
    p.nombre_puesto                   AS puesto,
    d.nombre                          AS departamento
FROM empleados e
INNER JOIN puestos       p ON e.id_puesto       = p.id_puesto
INNER JOIN departamentos d ON e.id_departamento = d.id_departamento
WHERE e.id_jefe IS NULL
  AND e.activo  = 1
ORDER BY d.nombre;

-- -------------------------------------------------------------
-- Consulta 6 — Empleados contratados desde junio 2023 con días
-- Conceptos: WHERE con fechas, DATEDIFF(), CURDATE()
-- -------------------------------------------------------------
SELECT
    e.nombre,
    e.apellido,
    e.fecha_contratacion,
    DATEDIFF(CURDATE(), e.fecha_contratacion) AS dias_en_empresa
FROM empleados e
WHERE e.fecha_contratacion >= '2023-06-01'
  AND e.activo = 1
ORDER BY e.fecha_contratacion ASC;

-- -------------------------------------------------------------
-- Consulta 7 — Top 3 departamentos con mayor salario promedio
-- Conceptos: GROUP BY, AVG(), ROUND(), ORDER BY DESC, LIMIT
-- -------------------------------------------------------------
SELECT
    d.nombre                     AS departamento,
    ROUND(AVG(e.salario), 2)     AS salario_promedio
FROM departamentos d
INNER JOIN empleados e ON d.id_departamento = e.id_departamento
WHERE e.activo = 1
GROUP BY d.id_departamento, d.nombre
ORDER BY salario_promedio DESC
LIMIT 3;

-- -------------------------------------------------------------
-- Consulta 8 — Empleados asignados a más de un proyecto
-- Conceptos: JOIN, GROUP BY, HAVING COUNT() >= 2
-- -------------------------------------------------------------
SELECT
    CONCAT(e.nombre, ' ', e.apellido) AS nombre,
    COUNT(ep.id_proyecto)             AS total_proyectos
FROM empleados e
INNER JOIN empleado_proyecto ep ON e.id_empleado = ep.id_empleado
GROUP BY e.id_empleado, e.nombre, e.apellido
HAVING total_proyectos >= 2
ORDER BY total_proyectos DESC;

-- -------------------------------------------------------------
-- Consulta 9 — Departamentos sin proyectos activos
-- Conceptos: LEFT JOIN, WHERE IS NULL
-- -------------------------------------------------------------
SELECT
    d.nombre    AS departamento,
    d.ubicacion
FROM departamentos d
LEFT JOIN proyectos p
    ON d.id_departamento = p.id_departamento_lider
    AND p.estado = 'activo'
WHERE p.id_proyecto IS NULL
ORDER BY d.nombre;

-- -------------------------------------------------------------
-- Consulta 10 — Resumen completo por departamento
-- Conceptos: GROUP BY, COUNT, MIN, MAX, AVG, SUM, ROUND, ORDER BY
-- -------------------------------------------------------------
SELECT
    d.nombre                         AS departamento,
    COUNT(e.id_empleado)             AS empleados,
    MIN(e.salario)                   AS salario_min,
    MAX(e.salario)                   AS salario_max,
    ROUND(AVG(e.salario), 2)         AS salario_promedio,
    SUM(e.salario)                   AS nomina_total
FROM departamentos d
INNER JOIN empleados e ON d.id_departamento = e.id_departamento
WHERE e.activo = 1
GROUP BY d.id_departamento, d.nombre
ORDER BY nomina_total DESC;
