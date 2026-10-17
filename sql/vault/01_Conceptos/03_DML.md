---
tema: DML — Lenguaje de Manipulación de Datos
estado: en-progreso
---

# DML — Lenguaje de Manipulación de Datos

> DML = Data Manipulation Language. Son los comandos que trabajan con los **datos** dentro de las tablas.

---

## Comandos DML principales

| Comando  | Para qué                   |
| -------- | -------------------------- |
| `INSERT` | Insertar nuevas filas      |
| `SELECT` | Consultar datos            |
| `UPDATE` | Modificar filas existentes |
| `DELETE` | Eliminar filas             |

---

## INSERT — insertar datos

```sql
-- Insertar una fila
INSERT INTO departamentos (nombre, ubicacion, presupuesto)
VALUES ('Sistemas', 'CDMX - Edificio Central', 2500000.00);

-- Insertar múltiples filas de una vez
INSERT INTO departamentos (nombre, ubicacion, presupuesto) VALUES
('Recursos Humanos', 'CDMX - Edificio B', 800000.00),
('Logística', 'Estado de México', 1200000.00),
('Finanzas', 'CDMX - Edificio Central', 1800000.00);
```

**Reglas importantes:**
- El orden de los valores debe coincidir con el orden de las columnas
- Los `VARCHAR`, `DATE` y `ENUM` van entre comillas simples `'`
- Los números (`INT`, `DECIMAL`) no llevan comillas
- Si una columna tiene `AUTO_INCREMENT`, no la incluyas — MySQL la llena solo

---

## SELECT — consultar datos

### Básico

```sql
-- Todos los campos, todos los registros
SELECT * FROM empleados;

-- Solo algunas columnas
SELECT nombre, apellido, salario FROM empleados;

-- Con alias (renombrar columnas en el resultado)
SELECT nombre AS 'Nombre', salario AS 'Sueldo Mensual' FROM empleados;
```

### WHERE — filtrar

```sql
-- Empleados con salario mayor a 30,000
SELECT * FROM empleados WHERE salario > 30000;

-- Empleados activos del departamento 1
SELECT * FROM empleados WHERE activo = 1 AND id_departamento = 1;

-- Empleados sin jefe
SELECT * FROM empleados WHERE id_jefe IS NULL;

-- Empleados cuyo nombre empieza con 'C'
SELECT * FROM empleados WHERE nombre LIKE 'C%';
```

### ORDER BY — ordenar

```sql
-- Ordenar por salario de mayor a menor
SELECT nombre, apellido, salario FROM empleados ORDER BY salario DESC;

-- Ordenar por departamento y luego por nombre
SELECT * FROM empleados ORDER BY id_departamento ASC, apellido ASC;
```

### LIMIT — limitar resultados

```sql
-- Solo los 5 primeros
SELECT * FROM empleados ORDER BY salario DESC LIMIT 5;

-- Del 11 al 20 (paginación)
SELECT * FROM empleados LIMIT 10 OFFSET 10;
```

### GROUP BY y funciones de agregado

Las funciones de agregado calculan valores sobre un conjunto de filas.

| Función    | Qué hace                  |
| ---------- | ------------------------- |
| `COUNT(*)` | Cuenta el número de filas |
| `SUM(col)` | Suma los valores          |
| `AVG(col)` | Calcula el promedio       |
| `MIN(col)` | Valor mínimo              |
| `MAX(col)` | Valor máximo              |

```sql
-- Número de empleados por departamento
SELECT id_departamento, COUNT(*) AS total_empleados
FROM empleados
GROUP BY id_departamento;

-- Salario promedio, mínimo y máximo por departamento
SELECT id_departamento,
       AVG(salario) AS salario_promedio,
       MIN(salario) AS salario_minimo,
       MAX(salario) AS salario_maximo
FROM empleados
GROUP BY id_departamento;
```

### HAVING — filtrar después de GROUP BY

`WHERE` filtra filas antes de agrupar. `HAVING` filtra grupos después de agrupar.

```sql
-- Departamentos con más de 3 empleados
SELECT id_departamento, COUNT(*) AS total
FROM empleados
GROUP BY id_departamento
HAVING total > 3;
```

### JOIN — combinar tablas

`JOIN` une dos tablas usando una columna en común (generalmente la FK).

```sql
-- INNER JOIN: solo trae filas que tienen coincidencia en ambas tablas
SELECT e.nombre, e.apellido, d.nombre AS departamento
FROM empleados e
INNER JOIN departamentos d ON e.id_departamento = d.id_departamento;

-- LEFT JOIN: trae TODOS los registros de la tabla izquierda,
--           y NULL en las columnas de la derecha si no hay coincidencia
SELECT d.nombre AS departamento, COUNT(e.id_empleado) AS total_empleados
FROM departamentos d
LEFT JOIN empleados e ON d.id_departamento = e.id_departamento
GROUP BY d.id_departamento, d.nombre;
```

### Subconsultas

Una subconsulta es un `SELECT` dentro de otro `SELECT`.

```sql
-- Empleados con salario mayor al promedio general
SELECT nombre, apellido, salario
FROM empleados
WHERE salario > (SELECT AVG(salario) FROM empleados);
```

---

## UPDATE — modificar datos

```sql
-- Actualizar el salario de un empleado
UPDATE empleados
SET salario = 40000.00
WHERE id_empleado = 7;

-- Actualizar múltiples columnas
UPDATE empleados
SET salario = 42000.00, activo = 1
WHERE id_empleado = 9;
```

**Advertencia:** Siempre usa `WHERE` en los UPDATE. Sin él, actualizas TODAS las filas.

---

## DELETE — eliminar filas

```sql
-- Eliminar un empleado por ID
DELETE FROM empleados WHERE id_empleado = 15;

-- Eliminar empleados inactivos
DELETE FROM empleados WHERE activo = 0;
```

**Advertencia:** Sin `WHERE`, el `DELETE` elimina TODAS las filas. Usa `TRUNCATE` si quieres vaciar toda la tabla.

---

## Resumen visual del flujo SQL

```
SELECT   -- qué columnas quieres ver
FROM     -- de qué tabla
JOIN     -- uniendo con otra tabla (si necesitas)
WHERE    -- filtrando filas (antes de agrupar)
GROUP BY -- agrupando por una o más columnas
HAVING   -- filtrando grupos (después de agrupar)
ORDER BY -- ordenando el resultado
LIMIT    -- limitando la cantidad de filas
```

---

> Siguiente: [[04_Procedimientos_Almacenados]]
