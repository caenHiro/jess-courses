-- =============================================================
-- Procedimientos almacenados — Sistema RRHH
-- Ejecutar DESPUÉS de 01_ddl.sql y 02_dml.sql
-- =============================================================

USE rrhh;

DROP PROCEDURE IF EXISTS listar_departamentos;
DROP PROCEDURE IF EXISTS obtener_empleados_por_depto;
DROP PROCEDURE IF EXISTS contar_empleados_depto;
DROP PROCEDURE IF EXISTS dar_alta_empleado;

DELIMITER //

-- -------------------------------------------------------------
-- Procedimiento 1: listar_departamentos
-- Sin parámetros — lista todos los departamentos
-- -------------------------------------------------------------
CREATE PROCEDURE listar_departamentos()
BEGIN
    SELECT id_departamento, nombre, ubicacion, presupuesto
    FROM departamentos
    ORDER BY nombre;
END //

-- -------------------------------------------------------------
-- Procedimiento 2: obtener_empleados_por_depto
-- IN: id del departamento
-- Devuelve empleados activos con su puesto, ordenados por salario
-- -------------------------------------------------------------
CREATE PROCEDURE obtener_empleados_por_depto(IN p_id_departamento INT)
BEGIN
    SELECT
        CONCAT(e.nombre, ' ', e.apellido)  AS nombre_completo,
        p.nombre_puesto                    AS puesto,
        e.salario,
        e.fecha_contratacion
    FROM empleados e
    INNER JOIN puestos p ON e.id_puesto = p.id_puesto
    WHERE e.id_departamento = p_id_departamento
      AND e.activo = 1
    ORDER BY e.salario DESC;
END //

-- -------------------------------------------------------------
-- Procedimiento 3: contar_empleados_depto
-- IN: id del departamento
-- OUT: total de empleados activos en ese departamento
-- -------------------------------------------------------------
CREATE PROCEDURE contar_empleados_depto(
    IN  p_id_departamento INT,
    OUT p_total           INT
)
BEGIN
    SELECT COUNT(*)
    INTO   p_total
    FROM   empleados
    WHERE  id_departamento = p_id_departamento
      AND  activo = 1;
END //

-- -------------------------------------------------------------
-- Procedimiento 4: dar_alta_empleado
-- Valida que el salario esté en el rango del puesto
-- Si está fuera de rango, lanza error
-- Si es válido, inserta y devuelve el nuevo id
-- -------------------------------------------------------------
CREATE PROCEDURE dar_alta_empleado(
    IN p_nombre             VARCHAR(100),
    IN p_apellido           VARCHAR(100),
    IN p_email              VARCHAR(150),
    IN p_fecha_contratacion DATE,
    IN p_salario            DECIMAL(10,2),
    IN p_id_departamento    INT,
    IN p_id_puesto          INT
)
BEGIN
    DECLARE v_salario_min DECIMAL(10,2);
    DECLARE v_salario_max DECIMAL(10,2);

    SELECT salario_min, salario_max
    INTO   v_salario_min, v_salario_max
    FROM   puestos
    WHERE  id_puesto = p_id_puesto;

    IF p_salario < v_salario_min OR p_salario > v_salario_max THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El salario está fuera del rango permitido para el puesto';
    ELSE
        INSERT INTO empleados
            (nombre, apellido, email, fecha_contratacion, salario, id_departamento, id_puesto)
        VALUES
            (p_nombre, p_apellido, p_email, p_fecha_contratacion, p_salario, p_id_departamento, p_id_puesto);

        SELECT
            'Empleado dado de alta correctamente' AS mensaje,
            LAST_INSERT_ID()                      AS id_empleado_nuevo;
    END IF;
END //

DELIMITER ;

-- =============================================================
-- Pruebas rápidas (descomenta para probar)
-- =============================================================

-- CALL listar_departamentos();

-- CALL obtener_empleados_por_depto(1);   -- Sistemas
-- CALL obtener_empleados_por_depto(2);   -- Recursos Humanos

-- CALL contar_empleados_depto(1, @total);
-- SELECT @total AS empleados_en_sistemas;

-- Dar alta válida:
-- CALL dar_alta_empleado('Jessica', 'Chino', 'j.chino@empresa.com', '2025-06-01', 17000.00, 1, 1);

-- Dar alta inválida (salario fuera de rango):
-- CALL dar_alta_empleado('Error', 'Salario', 'error@empresa.com', '2025-06-01', 60000.00, 1, 1);
