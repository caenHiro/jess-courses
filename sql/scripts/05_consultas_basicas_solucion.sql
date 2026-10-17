-- =============================================================
-- Soluciones — 10 Consultas Básicas
-- Sistema de Recursos Humanos
-- Ejecutar DESPUÉS de 01_ddl.sql y 02_dml.sql
-- =============================================================

USE rrhh;

-- -------------------------------------------------------------
-- Consulta 1 — Ver todos los empleados
-- Conceptos: SELECT *, FROM
-- -------------------------------------------------------------
SELECT *
FROM empleados;

-- -------------------------------------------------------------
-- Consulta 2 — Solo los datos importantes, empleados activos
-- Conceptos: SELECT columnas, WHERE, ORDER BY DESC
-- -------------------------------------------------------------
SELECT
    nombre,
    apellido,
    email,
    salario
FROM empleados
WHERE activo = 1
ORDER BY salario DESC;

-- -------------------------------------------------------------
-- Consulta 3 — Los 5 empleados con mayor salario
-- Conceptos: ORDER BY DESC, LIMIT
-- -------------------------------------------------------------
SELECT
    nombre,
    apellido,
    salario
FROM empleados
ORDER BY salario DESC
LIMIT 5;

-- -------------------------------------------------------------
-- Consulta 4 — Buscar por apellido con LIKE
-- Conceptos: LIKE, %
-- Nota: usamos Lopez sin acento porque los datos en la BD
--       pueden variar según el collation (utf8mb4_unicode_ci
--       en este caso sí es case-insensitive y acento-insensitive)
-- -------------------------------------------------------------
SELECT
    nombre,
    apellido,
    email
FROM empleados
WHERE apellido LIKE '%L_pez%';

-- Alternativa más directa (funciona con el collation configurado):
SELECT
    nombre,
    apellido,
    email
FROM empleados
WHERE apellido LIKE '%Lopez%';

-- -------------------------------------------------------------
-- Consulta 5 — Rango de salario con BETWEEN
-- Conceptos: BETWEEN, ORDER BY ASC
-- -------------------------------------------------------------
SELECT
    nombre,
    apellido,
    salario
FROM empleados
WHERE activo = 1
  AND salario BETWEEN 22000 AND 45000
ORDER BY salario ASC;

-- -------------------------------------------------------------
-- Consulta 6 — Empleados contratados desde 2023
-- Conceptos: WHERE con fecha, operador >=
-- -------------------------------------------------------------
SELECT
    nombre,
    apellido,
    fecha_contratacion
FROM empleados
WHERE fecha_contratacion >= '2023-01-01'
ORDER BY fecha_contratacion ASC;

-- -------------------------------------------------------------
-- Consulta 7 — Filtrar por lista de puestos con IN
-- Conceptos: IN
-- -------------------------------------------------------------
SELECT
    nombre,
    apellido,
    salario,
    id_puesto
FROM empleados
WHERE activo  = 1
  AND id_puesto IN (3, 4)
ORDER BY id_puesto ASC, salario DESC;

-- -------------------------------------------------------------
-- Consulta 8 — Empleados sin jefe
-- Conceptos: IS NULL
-- -------------------------------------------------------------
SELECT
    nombre,
    apellido,
    id_departamento
FROM empleados
WHERE id_jefe IS NULL
  AND activo  = 1
ORDER BY id_departamento;

-- -------------------------------------------------------------
-- Consulta 9 — Ver todos los departamentos
-- Conceptos: SELECT de tabla diferente, ORDER BY
-- -------------------------------------------------------------
SELECT
    nombre,
    ubicacion,
    presupuesto
FROM departamentos
ORDER BY presupuesto DESC;

-- -------------------------------------------------------------
-- Consulta 10 — Primer JOIN: empleado con su departamento
-- Conceptos: INNER JOIN (2 tablas), alias de tabla (e, d)
-- -------------------------------------------------------------
SELECT
    e.nombre,
    e.apellido,
    d.nombre AS departamento
FROM empleados e
INNER JOIN departamentos d ON e.id_departamento = d.id_departamento
WHERE e.activo = 1
ORDER BY d.nombre ASC, e.apellido ASC;
