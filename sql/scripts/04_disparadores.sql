-- =============================================================
-- Triggers (Disparadores) — Sistema RRHH
-- Ejecutar DESPUÉS de 01_ddl.sql y 02_dml.sql
-- =============================================================

USE rrhh;

DROP TRIGGER IF EXISTS trg_historial_salario;
DROP TRIGGER IF EXISTS trg_validar_salario_insert;
DROP TRIGGER IF EXISTS trg_validar_salario_update;

DELIMITER //

-- -------------------------------------------------------------
-- Trigger 1: trg_historial_salario
-- AFTER UPDATE en empleados
-- Registra automáticamente en historial_salarios cuando cambia el salario
-- -------------------------------------------------------------
CREATE TRIGGER trg_historial_salario
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    IF NEW.salario <> OLD.salario THEN
        INSERT INTO historial_salarios
            (id_empleado, salario_anterior, salario_nuevo, fecha_cambio)
        VALUES
            (NEW.id_empleado, OLD.salario, NEW.salario, NOW());
    END IF;
END //

-- -------------------------------------------------------------
-- Trigger 2: trg_validar_salario_insert
-- BEFORE INSERT en empleados
-- Cancela la inserción si el salario no está en el rango del puesto
-- -------------------------------------------------------------
CREATE TRIGGER trg_validar_salario_insert
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
    DECLARE v_min DECIMAL(10,2);
    DECLARE v_max DECIMAL(10,2);

    IF NEW.id_puesto IS NOT NULL THEN
        SELECT salario_min, salario_max
        INTO   v_min, v_max
        FROM   puestos
        WHERE  id_puesto = NEW.id_puesto;

        IF NEW.salario < v_min OR NEW.salario > v_max THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'El salario está fuera del rango permitido para este puesto';
        END IF;
    END IF;
END //

-- -------------------------------------------------------------
-- Trigger 3: trg_validar_salario_update
-- BEFORE UPDATE en empleados
-- Valida el rango si se intenta modificar el salario
-- -------------------------------------------------------------
CREATE TRIGGER trg_validar_salario_update
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
    DECLARE v_min DECIMAL(10,2);
    DECLARE v_max DECIMAL(10,2);

    IF NEW.salario <> OLD.salario AND NEW.id_puesto IS NOT NULL THEN
        SELECT salario_min, salario_max
        INTO   v_min, v_max
        FROM   puestos
        WHERE  id_puesto = NEW.id_puesto;

        IF NEW.salario < v_min OR NEW.salario > v_max THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'El nuevo salario está fuera del rango del puesto';
        END IF;
    END IF;
END //

DELIMITER ;

-- =============================================================
-- Pruebas (descomenta para probar)
-- =============================================================

-- Trigger 1 — cambiar salario y ver el historial automático:
-- UPDATE empleados SET salario = 38000.00 WHERE id_empleado = 7;
-- SELECT * FROM historial_salarios;

-- Trigger 2 — insertar con salario inválido (debe fallar):
-- INSERT INTO empleados (nombre, apellido, email, fecha_contratacion, salario, id_departamento, id_puesto)
-- VALUES ('Error', 'Trigger', 'error.trigger@empresa.com', '2025-01-01', 99000.00, 1, 1);
-- Analista Junior tiene rango $15k-$20k — el INSERT debe rechazarse

-- Trigger 2 — insertar con salario válido (debe funcionar):
-- INSERT INTO empleados (nombre, apellido, email, fecha_contratacion, salario, id_departamento, id_puesto)
-- VALUES ('Prueba', 'OK', 'prueba.ok@empresa.com', '2025-01-01', 17000.00, 1, 1);

-- Trigger 3 — modificar salario fuera de rango (debe fallar):
-- UPDATE empleados SET salario = 99000.00 WHERE id_empleado = 10;
-- Valeria es Analista Junior ($15k-$20k) — debe rechazarse

SHOW TRIGGERS FROM rrhh;
