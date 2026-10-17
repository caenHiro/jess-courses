---
tema: Preguntas de SQL para entrevista
estado: completo
---

# Preguntas de Entrevista — SQL Práctico

> Para cada pregunta, intenta escribir la consulta tú sola antes de ver la respuesta.
> La BD es la misma RRHH que ya conoces.

---

## Preguntas básicas

**¿Cuál es la diferencia entre `INNER JOIN` y `LEFT JOIN`?**

- `INNER JOIN`: devuelve solo las filas que tienen **coincidencia en ambas tablas**.
- `LEFT JOIN`: devuelve **todas las filas de la tabla izquierda**, aunque no tengan coincidencia en la derecha (las columnas de la derecha aparecen como NULL).

```sql
-- INNER JOIN: solo empleados que tienen departamento asignado
SELECT e.nombre, d.nombre AS departamento
FROM empleados e
INNER JOIN departamentos d ON e.id_departamento = d.id_departamento;

-- LEFT JOIN: todos los departamentos, incluso sin empleados
SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
LEFT JOIN empleados e ON d.id_departamento = e.id_departamento;
```

---

**¿Cuál es la diferencia entre `DELETE`, `TRUNCATE` y `DROP`?**

| Comando | Qué hace | ¿Puede revertirse con ROLLBACK? |
|---|---|---|
| `DELETE FROM tabla WHERE ...` | Borra filas específicas | Sí (dentro de una transacción) |
| `TRUNCATE TABLE tabla` | Borra TODAS las filas, resetea AUTO_INCREMENT | No (en MySQL) |
| `DROP TABLE tabla` | Elimina la tabla completa (estructura + datos) | No |

---

**¿Qué hace `GROUP BY`?**

Agrupa las filas que tienen el mismo valor en la(s) columna(s) indicadas, para luego aplicar funciones de agregación (`COUNT`, `SUM`, `AVG`, etc.) a cada grupo.

```sql
SELECT id_departamento, COUNT(*) AS total
FROM empleados
GROUP BY id_departamento;
```

---

**¿Cuál es la diferencia entre `COUNT(*)` y `COUNT(columna)`?**

- `COUNT(*)`: cuenta todas las filas, incluyendo las que tienen NULL.
- `COUNT(columna)`: cuenta solo las filas donde esa columna **no es NULL**.

```sql
-- Cuenta todos los empleados (incluyendo los sin jefe)
SELECT COUNT(*) FROM empleados;

-- Cuenta solo los que tienen jefe asignado
SELECT COUNT(id_jefe) FROM empleados;
```

---

## Preguntas intermedias

**Escribe una consulta para encontrar los empleados duplicados por email.**

```sql
SELECT email, COUNT(*) AS apariciones
FROM empleados
GROUP BY email
HAVING apariciones > 1;
```

---

**¿Cómo obtienes el segundo salario más alto?**

```sql
-- Opción 1: subconsulta
SELECT MAX(salario)
FROM empleados
WHERE salario < (SELECT MAX(salario) FROM empleados);

-- Opción 2: con LIMIT y OFFSET
SELECT DISTINCT salario
FROM empleados
ORDER BY salario DESC
LIMIT 1 OFFSET 1;
```

---

**¿Cómo calculas el salario promedio solo de los departamentos con más de 2 empleados?**

```sql
SELECT
    d.nombre AS departamento,
    ROUND(AVG(e.salario), 2) AS salario_promedio,
    COUNT(e.id_empleado) AS total_empleados
FROM departamentos d
INNER JOIN empleados e ON d.id_departamento = e.id_departamento
WHERE e.activo = 1
GROUP BY d.id_departamento, d.nombre
HAVING total_empleados > 2
ORDER BY salario_promedio DESC;
```

---

**¿Qué es una subconsulta? Da un ejemplo.**

Una subconsulta es una consulta dentro de otra consulta. Se ejecuta primero y su resultado se usa en la consulta exterior.

```sql
-- Empleados que ganan más que el promedio
SELECT nombre, apellido, salario
FROM empleados
WHERE salario > (
    SELECT AVG(salario)
    FROM empleados
    WHERE activo = 1
)
AND activo = 1;
```

---

**¿Para qué sirve `SUBSTRING`? Muestra un ejemplo.**

`SUBSTRING(texto, posicion_inicio, longitud)` extrae una parte de un texto.

```sql
-- Extraer el dominio del email (después del @)
SELECT
    email,
    SUBSTRING(email, INSTR(email, '@') + 1) AS dominio
FROM empleados;
-- Resultado: 'empresa.com'

-- Primeros 3 caracteres del nombre
SELECT nombre, SUBSTRING(nombre, 1, 3) AS abreviatura
FROM empleados;
-- Laura → Lau, Carlos → Car

-- Combinado con CONCAT para crear usuario del sistema
SELECT CONCAT(SUBSTRING(nombre, 1, 1), '.', apellido) AS usuario_sistema
FROM empleados;
-- Laura Martínez Díaz → L.Martínez Díaz
```

---

## Preguntas de diseño

**Si tuvieras que diseñar una tabla para un sistema de pedidos, ¿qué tablas crearías?**

Respuesta sugerida:

```
clientes (id_cliente, nombre, email, telefono)
productos (id_producto, nombre, precio, stock)
pedidos (id_pedido, id_cliente, fecha, total, estado)
detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario)
```

La tabla `detalle_pedido` es la relación N:M entre `pedidos` y `productos` — igual que `empleado_proyecto` en nuestra BD.

---

**¿Por qué guardamos `precio_unitario` en el detalle del pedido si ya está en la tabla productos?**

Porque el precio puede cambiar con el tiempo. Si un producto valía $100 cuando se hizo el pedido, y después subió a $120, el pedido histórico debe conservar el precio original de $100. Esto es **desnormalización intencional** — guardamos el dato en el momento de la transacción.

---

**¿Cuál es la diferencia entre una relación 1:1, 1:N y N:M?**

- **1:1**: un empleado tiene un solo expediente, un expediente pertenece a un solo empleado.
- **1:N**: un departamento tiene muchos empleados, cada empleado pertenece a un departamento.
- **N:M**: un empleado puede estar en varios proyectos y un proyecto puede tener varios empleados. Se resuelve con una tabla intermedia (`empleado_proyecto`).
