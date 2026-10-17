-- ============================================================
-- Semana 11 — Ejercicio 2: Consultas con SELECT y WHERE
-- Base de datos: mi_escuela
-- ============================================================

USE mi_escuela;

-- 1. Ver todos los estudiantes
SELECT * FROM estudiantes;

-- 2. Ver solo nombre y promedio, ordenados de mayor a menor promedio
SELECT nombre, promedio
FROM estudiantes
ORDER BY promedio DESC;

-- 3. Ver estudiantes con promedio mayor o igual a 9.0
SELECT *
FROM estudiantes
WHERE promedio >= 9.0;

-- 4. Ver estudiantes de Ingeniería en Sistemas
SELECT *
FROM estudiantes
WHERE carrera = 'Ingeniería en Sistemas';

-- 5. Cuántos estudiantes hay en total
SELECT COUNT(*) AS total_estudiantes
FROM estudiantes;

-- 6. Promedio general de todos los estudiantes
SELECT AVG(promedio) AS promedio_general
FROM estudiantes;

-- 7. El estudiante con el promedio más alto
SELECT *
FROM estudiantes
ORDER BY promedio DESC
LIMIT 1;

-- 8. Estudiantes cuyo nombre contiene la letra "a"
SELECT *
FROM estudiantes
WHERE nombre LIKE '%a%';
