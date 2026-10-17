---
tags: [entrevista, sql, ine, examen, practica]
estado: practica
updated: 2026-07-02
---

# Examen SQL para Líderes — INE

> Practica estas preguntas antes de la entrevista.
> Tiempo aproximado del examen real: 20-30 minutos.
> Para cada pregunta, elige la opción que consideres correcta y escribe POR QUÉ la elegiste.

---

## Instrucciones

- Lee cada pregunta con calma — algunas tienen opciones muy similares
- Si no estás segura, elimina las opciones claramente incorrectas primero
- Escribe tu respuesta y razón en `04_Notas_Personales/mis_respuestas_sql.md`

---

## Preguntas

### Pregunta 1 — Tabla base
Tienes esta tabla `empleados`:

| id | nombre | salario | departamento |
|----|--------|---------|--------------|
| 1  | Ana    | 8000    | Ventas       |
| 2  | Juan   | 12000   | IT           |
| 3  | María  | 9500    | Ventas       |
| 4  | Pedro  | 15000   | IT           |
| 5  | Laura  | 7000    | RRHH         |

---

### Pregunta 2 — Segundo salario más alto

¿Cuál consulta obtiene correctamente el **segundo salario más alto** de la tabla `empleados`?

**A)**
```sql
SELECT MAX(salario) FROM empleados
WHERE salario < (SELECT MAX(salario) FROM empleados);
```

**B)**
```sql
SELECT salario FROM empleados
ORDER BY salario DESC LIMIT 1 OFFSET 1;
```

**C)**
```sql
SELECT TOP 2 salario FROM empleados ORDER BY salario DESC;
```

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 3 — Promedio por grupo

¿Cuál consulta obtiene los vendedores cuya venta promedio supera los 5,000 pesos?

**A)**
```sql
SELECT vendedor, AVG(monto) as promedio
FROM ventas
GROUP BY vendedor
HAVING AVG(monto) > 5000;
```

**B)**
```sql
SELECT vendedor, AVG(monto) as promedio
FROM ventas
HAVING AVG(monto) > 5000;
```

**C)**
```sql
SELECT vendedor, AVG(monto) as promedio
FROM ventas
WHERE AVG(monto) > 5000
GROUP BY vendedor;
```

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 4 — JOIN tres tablas

Tienes: `clientes(id, nombre)`, `pedidos(id, cliente_id, producto_id, fecha)`, `productos(id, nombre, precio)`.

¿Cuál consulta obtiene el nombre del cliente, nombre del producto y precio de cada pedido?

**A)**
```sql
SELECT c.nombre, p.nombre, pr.precio
FROM clientes c
INNER JOIN pedidos pe ON c.id = pe.cliente_id
INNER JOIN productos pr ON pe.producto_id = pr.id;
```

**B)**
```sql
SELECT c.nombre, p.nombre, pr.precio
FROM clientes c, pedidos pe, productos pr
WHERE c.id = pe.cliente_id AND pe.producto_id = pr.id;
```

**C)**
```sql
SELECT c.nombre, p.nombre, pr.precio
FROM clientes c
LEFT JOIN pedidos pe ON c.id = pe.cliente_id
LEFT JOIN productos pr ON pe.producto_id = pr.id;
```

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 5 — Tercer registro más reciente

¿Cómo obtienes el **tercer** pedido más reciente de la tabla `pedidos`?

**A)**
```sql
SELECT * FROM pedidos
WHERE fecha = (
  SELECT fecha FROM pedidos
  ORDER BY fecha DESC
  LIMIT 1 OFFSET 2
);
```

**B)**
```sql
SELECT * FROM pedidos
ORDER BY fecha DESC
LIMIT 1 OFFSET 2;
```

**C)**
```sql
SELECT * FROM pedidos ORDER BY fecha DESC LIMIT 3;
```

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 6 — Conteo con condición

¿Cuántos empleados tienen un salario superior al promedio?

**A)**
```sql
SELECT COUNT(*) FROM empleados
WHERE salario > (SELECT AVG(salario) FROM empleados);
```

**B)**
```sql
SELECT COUNT(*) FROM empleados
WHERE salario > AVG(salario);
```

**C)**
```sql
SELECT COUNT(*) FROM empleados
HAVING salario > AVG(salario);
```

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 7 — Top 3 productos

¿Cuál consulta obtiene los 3 productos más vendidos (por cantidad total vendida)?

**A)**
```sql
SELECT producto_id, SUM(cantidad) as total
FROM ventas
GROUP BY producto_id
ORDER BY total DESC
LIMIT 3;
```

**B)**
```sql
SELECT producto_id, COUNT(*) as total
FROM ventas
GROUP BY producto_id
ORDER BY total DESC
LIMIT 3;
```

**C)**
```sql
SELECT producto_id, SUM(cantidad) as total
FROM ventas
GROUP BY producto_id
ORDER BY total DESC
LIMIT 5;
```

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 8 — Salario máximo por departamento

¿Cuál consulta obtiene el empleado con el salario más alto **en cada departamento**?

**A)**
```sql
SELECT departamento, nombre, salario FROM empleados e1
WHERE salario = (
  SELECT MAX(salario) FROM empleados e2
  WHERE e2.departamento = e1.departamento
);
```

**B)**
```sql
SELECT departamento, nombre, salario FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY departamento ORDER BY salario DESC) as rn
  FROM empleados
) t WHERE rn = 1;
```

**C)**
```sql
SELECT departamento, MAX(salario) FROM empleados
GROUP BY departamento;
```

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 9 — UPDATE con fecha

¿Cuál consulta actualiza el estado a 'inactivo' para registros de hace más de 30 días? (Motor: **MySQL**)

**A)**
```sql
UPDATE empleados SET estado = 'inactivo'
WHERE fecha_registro < NOW() - INTERVAL '30 DAY';
```

**B)**
```sql
UPDATE empleados SET estado = 'inactivo'
WHERE fecha_registro < DATEADD(DAY, -30, GETDATE());
```

**C)**
```sql
UPDATE empleados SET estado = 'inactivo'
WHERE fecha_registro < NOW() - INTERVAL 30 DAY;
```

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 10 — Eliminar duplicados

Tienes duplicados en la tabla `registros` (misma combinación de `nombre` y `email`). ¿Cuál consulta los elimina conservando solo el registro con el `id` más bajo?

**A)**
```sql
DELETE FROM registros
WHERE id NOT IN (
  SELECT MIN(id) FROM registros GROUP BY nombre, email
);
```

**B)**
```sql
DELETE r1 FROM registros r1
INNER JOIN registros r2 ON r1.nombre = r2.nombre AND r1.email = r2.email
WHERE r1.id > r2.id;
```

**C)**
```sql
DELETE FROM registros WHERE id IN (
  SELECT id FROM registros GROUP BY nombre, email HAVING COUNT(*) > 1
);
```

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 11 — TOP 10 por fecha (Motor: **MySQL**)

¿Cuál consulta obtiene los 10 registros más recientes?

**A)**
```sql
SELECT * FROM registros ORDER BY fecha DESC LIMIT 10;
```

**B)**
```sql
SELECT TOP 10 * FROM registros ORDER BY fecha DESC;
```

**C)**
```sql
SELECT * FROM registros ORDER BY fecha DESC ROWNUM <= 10;
```

Tu respuesta: _____  
Por qué: _____

---

## Conceptos clave a repasar antes del examen

| Concepto | Qué recordar |
|---|---|
| `WHERE` vs `HAVING` | WHERE filtra filas antes de agrupar · HAVING filtra grupos después de GROUP BY |
| `INNER JOIN` vs `LEFT JOIN` | INNER: solo coincidencias · LEFT: todos los de la tabla izquierda aunque no tengan pareja |
| Subconsultas | Una consulta dentro de otra — se ejecuta de adentro hacia afuera |
| `GROUP BY` | Agrupa filas con el mismo valor para usar funciones como SUM, COUNT, AVG |
| `ORDER BY DESC LIMIT N` | Ordenar de mayor a menor y tomar los primeros N |
| Funciones de agregación | `SUM()`, `COUNT()`, `AVG()`, `MAX()`, `MIN()` |
