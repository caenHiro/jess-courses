---
tema: Procedimientos Almacenados
estado: en-progreso
---

# Procedimientos Almacenados

> Un **procedimiento almacenado** es un bloque de código SQL guardado en la base de datos con un nombre, que puedes ejecutar cuando lo necesites, igual que una función en Java o Python.

---

## ¿Por qué usar procedimientos almacenados?

- **Reutilización:** escribes la lógica una vez y la llamas muchas veces
- **Seguridad:** el usuario puede ejecutar el procedimiento sin tener acceso directo a las tablas
- **Rendimiento:** MySQL compila el procedimiento la primera vez — las siguientes llamadas son más rápidas
- **Mantenimiento:** si la lógica cambia, solo editas el procedimiento, no el código de la aplicación

---

## Sintaxis básica

```sql
DELIMITER //

CREATE PROCEDURE nombre_procedimiento(
    -- parámetros (opcional)
    IN  param_entrada  TIPO,
    OUT param_salida   TIPO,
    INOUT param_ambos  TIPO
)
BEGIN
    -- código SQL aquí
END //

DELIMITER ;
```

**¿Qué es `DELIMITER`?**
MySQL usa `;` para terminar cada instrucción. Dentro del procedimiento hay varios `;`, pero MySQL no debe terminar ahí. `DELIMITER //` le dice a MySQL: "ahora termina las instrucciones con `//`, no con `;`". Al final lo regresamos a `;`.

**Tipos de parámetros:**
- `IN` — el llamador pasa un valor al procedimiento (entrada)
- `OUT` — el procedimiento devuelve un valor al llamador (salida)
- `INOUT` — entra y puede modificarse (bidireccional)

---

## Ejemplo 1 — Procedimiento simple sin parámetros

```sql
DELIMITER //

CREATE PROCEDURE listar_departamentos()
BEGIN
    SELECT id_departamento, nombre, ubicacion
    FROM departamentos
    ORDER BY nombre;
END //

DELIMITER ;

-- Llamar el procedimiento:
CALL listar_departamentos();
```

---

## Ejemplo 2 — Procedimiento con parámetro IN

```sql
DELIMITER //

CREATE PROCEDURE obtener_empleados_por_depto(IN p_id_departamento INT)
BEGIN
    SELECT e.nombre, e.apellido, e.salario, p.nombre_puesto
    FROM empleados e
    INNER JOIN puestos p ON e.id_puesto = p.id_puesto
    WHERE e.id_departamento = p_id_departamento
      AND e.activo = 1
    ORDER BY e.salario DESC;
END //

DELIMITER ;

-- Llamar el procedimiento para el departamento 1 (Sistemas):
CALL obtener_empleados_por_depto(1);
```

---

## Ejemplo 3 — Procedimiento con parámetro OUT

```sql
DELIMITER //

CREATE PROCEDURE contar_empleados_depto(
    IN  p_id_departamento INT,
    OUT p_total           INT
)
BEGIN
    SELECT COUNT(*) INTO p_total
    FROM empleados
    WHERE id_departamento = p_id_departamento AND activo = 1;
END //

DELIMITER ;

-- Llamar y recuperar el valor OUT:
CALL contar_empleados_depto(1, @total);
SELECT @total AS empleados_en_sistemas;
```

---

## Ejemplo 4 — Procedimiento con lógica condicional

```sql
DELIMITER //

CREATE PROCEDURE dar_alta_empleado(
    IN p_nombre            VARCHAR(100),
    IN p_apellido          VARCHAR(100),
    IN p_email             VARCHAR(150),
    IN p_fecha_contratacion DATE,
    IN p_salario           DECIMAL(10,2),
    IN p_id_departamento   INT,
    IN p_id_puesto         INT
)
BEGIN
    DECLARE v_salario_min DECIMAL(10,2);
    DECLARE v_salario_max DECIMAL(10,2);

    -- Verificar rango de salario para el puesto
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

        SELECT 'Empleado dado de alta correctamente' AS mensaje,
               LAST_INSERT_ID() AS id_empleado_nuevo;
    END IF;
END //

DELIMITER ;

-- Uso:
CALL dar_alta_empleado(
    'Jessica', 'Chino García',
    'j.chino@empresa.com',
    '2025-01-15',
    17000.00,
    1,           -- id_departamento: Sistemas
    1            -- id_puesto: Analista Junior (rango $15k-$20k)
);
```

---

## Gestión de procedimientos

```sql
-- Ver todos los procedimientos de la base de datos
SHOW PROCEDURE STATUS WHERE Db = 'rrhh';

-- Ver el código de un procedimiento
SHOW CREATE PROCEDURE dar_alta_empleado;

-- Eliminar un procedimiento
DROP PROCEDURE IF EXISTS dar_alta_empleado;
```

---

## Variables locales en procedimientos

```sql
DELIMITER //
CREATE PROCEDURE ejemplo_variables()
BEGIN
    DECLARE v_total INT DEFAULT 0;
    DECLARE v_promedio DECIMAL(10,2);

    SELECT COUNT(*), AVG(salario)
    INTO   v_total, v_promedio
    FROM   empleados
    WHERE  activo = 1;

    SELECT v_total AS total_empleados, v_promedio AS salario_promedio;
END //
DELIMITER ;
```

`DECLARE` crea variables locales (solo existen dentro del procedimiento).

---

> Siguiente: [[05_Disparadores]]
