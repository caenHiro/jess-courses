---
tema: Disparadores (Triggers)
estado: en-progreso
---

# Disparadores (Triggers)

> Un **trigger** (disparador) es un bloque de código que MySQL ejecuta **automáticamente** cuando ocurre un evento en una tabla: INSERT, UPDATE o DELETE.

---

## ¿Para qué sirven los triggers?

- **Auditoría:** registrar automáticamente quién cambió qué y cuándo
- **Validación avanzada:** reglas de negocio más complejas que los constraints
- **Sincronización:** actualizar automáticamente otra tabla cuando cambia una
- **Historial:** guardar el valor anterior antes de modificarlo

---

## Sintaxis básica

```sql
CREATE TRIGGER nombre_trigger
    { BEFORE | AFTER }
    { INSERT | UPDATE | DELETE }
    ON nombre_tabla
    FOR EACH ROW
BEGIN
    -- código SQL aquí
    -- usa NEW.columna para acceder al valor nuevo
    -- usa OLD.columna para acceder al valor anterior
END;
```

**Momentos de ejecución:**
- `BEFORE` — se ejecuta ANTES de que el cambio se aplique
- `AFTER` — se ejecuta DESPUÉS de que el cambio se aplicó

**Referencias dentro del trigger:**
- `NEW.columna` — el valor nuevo (disponible en INSERT y UPDATE)
- `OLD.columna` — el valor anterior (disponible en UPDATE y DELETE)

---

## Ejemplo 1 — Registrar historial de cambios de salario (AFTER UPDATE)

Este trigger registra automáticamente en `historial_salarios` cada vez que el salario de un empleado cambia.

```sql
DELIMITER //

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

DELIMITER ;

-- Probarlo: actualizar el salario del empleado 7
UPDATE empleados SET salario = 38000.00 WHERE id_empleado = 7;

-- Ver el historial automáticamente guardado:
SELECT * FROM historial_salarios;
```

**El trigger actúa automáticamente** — el desarrollador que hace el UPDATE no tiene que preocuparse por registrar el cambio. MySQL lo hace solo.

---

## Ejemplo 2 — Validar salario antes de insertar (BEFORE INSERT)

Este trigger verifica que el salario esté dentro del rango del puesto antes de insertar al empleado. Si no está en rango, cancela la inserción.

```sql
DELIMITER //

CREATE TRIGGER trg_validar_salario_insert
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
    DECLARE v_min DECIMAL(10,2);
    DECLARE v_max DECIMAL(10,2);

    SELECT salario_min, salario_max
    INTO   v_min, v_max
    FROM   puestos
    WHERE  id_puesto = NEW.id_puesto;

    IF NEW.salario < v_min OR NEW.salario > v_max THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El salario no está dentro del rango del puesto';
    END IF;
END //

DELIMITER ;

-- Probar: intentar insertar con salario inválido
-- (Analista Junior tiene rango $15k-$20k)
INSERT INTO empleados (nombre, apellido, email, fecha_contratacion, salario, id_departamento, id_puesto)
VALUES ('Prueba', 'Error', 'prueba@test.com', '2025-01-01', 50000.00, 1, 1);
-- Error: El salario no está dentro del rango del puesto

-- Insertar con salario válido:
INSERT INTO empleados (nombre, apellido, email, fecha_contratacion, salario, id_departamento, id_puesto)
VALUES ('Prueba', 'Correcta', 'prueba2@test.com', '2025-01-01', 17000.00, 1, 1);
-- Funciona correctamente
```

---

## Ejemplo 3 — Log de eliminaciones (BEFORE DELETE)

```sql
CREATE TABLE log_bajas (
    id_log       INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado  INT,
    nombre       VARCHAR(100),
    apellido     VARCHAR(100),
    fecha_baja   DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_log_baja_empleado
BEFORE DELETE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO log_bajas (id_empleado, nombre, apellido)
    VALUES (OLD.id_empleado, OLD.nombre, OLD.apellido);
END //

DELIMITER ;
```

---

## Gestión de triggers

```sql
-- Ver todos los triggers de la base de datos
SHOW TRIGGERS FROM rrhh;

-- Ver triggers de una tabla específica
SHOW TRIGGERS FROM rrhh LIKE 'empleados';

-- Eliminar un trigger
DROP TRIGGER IF EXISTS trg_historial_salario;
```

---

## Diferencias entre triggers y procedimientos

|                           | Trigger                          | Procedimiento                  |
| ------------------------- | -------------------------------- | ------------------------------ |
| Se llama manualmente      | No — automático                  | Sí — con CALL                  |
| Se dispara por            | INSERT/UPDATE/DELETE en tabla    | Llamada explícita              |
| Puede recibir parámetros  | No                               | Sí                             |
| Puede devolver resultados | No                               | Sí (OUT)                       |
| Uso principal             | Auditoría, validación automática | Lógica de negocio reutilizable |

---

## Puntos de cuidado con triggers

- Los triggers se ejecutan **para cada fila** afectada — si haces `UPDATE empleados SET salario = salario * 1.1` (actualiza 15 filas), el trigger se ejecuta 15 veces
- No puedes modificar la misma tabla sobre la que dispara el trigger (ciclo infinito)
- Demasiados triggers pueden hacer que las operaciones sean lentas — úsalos con criterio

---

> Siguiente: [[../02_Setup/01_Docker_MySQL]] — configurar el ambiente
