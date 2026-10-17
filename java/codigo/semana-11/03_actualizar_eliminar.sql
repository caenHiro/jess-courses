-- ============================================================
-- Semana 11 — Ejercicio 3: UPDATE y DELETE
-- Base de datos: mi_escuela
-- ============================================================

USE mi_escuela;

-- Ver estado antes de los cambios
SELECT id, nombre, carrera, promedio FROM estudiantes;

-- 1. Actualizar el promedio de un estudiante específico
UPDATE estudiantes
SET promedio = 9.3
WHERE id = 4;

-- 2. Cambiar la carrera de dos estudiantes
UPDATE estudiantes
SET carrera = 'Ingeniería en Sistemas'
WHERE id = 7;

UPDATE estudiantes
SET carrera = 'Contabilidad'
WHERE id = 9;

-- 3. Eliminar un estudiante por su id
DELETE FROM estudiantes
WHERE id = 8;

-- Ver estado después de los cambios
SELECT id, nombre, carrera, promedio FROM estudiantes;
