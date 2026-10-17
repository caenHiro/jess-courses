---
tema: Consultas SELECT, Funciones y Agrupaciones
estado: completo
---

# Consultas SELECT, Funciones de Agregación, GROUP BY y HAVING

---

## 1. SELECT básico — la estructura

```sql
SELECT columna1, columna2
FROM tabla
WHERE condicion
ORDER BY columna ASC|DESC
LIMIT numero;
```

| Cláusula | Para qué sirve |
|---|---|
| `SELECT` | Qué columnas quieres ver |
| `FROM` | De qué tabla |
| `WHERE` | Filtrar filas (condición) |
| `ORDER BY` | Ordenar el resultado |
| `LIMIT` | Cuántas filas mostrar |

---

## 2. Filtros en WHERE

```sql
-- Igual
WHERE salario = 35000

-- Diferente
WHERE activo != 0

-- Mayor / menor
WHERE salario > 20000
WHERE fecha_contratacion < '2022-01-01'

-- Rango (equivale a >= Y <=)
WHERE salario BETWEEN 20000 AND 50000

-- Lista de valores
WHERE id_puesto IN (1, 2, 3)

-- Texto parcial
WHERE nombre LIKE 'C%'       -- empieza con C
WHERE apellido LIKE '%López%' -- contiene López

-- Nulo / no nulo
WHERE id_jefe IS NULL
WHERE id_jefe IS NOT NULL

-- Combinar condiciones
WHERE activo = 1 AND id_departamento = 1
WHERE id_puesto = 3 OR id_puesto = 4
```

---

## 3. Funciones de texto

```sql
-- Concatenar nombre completo
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM empleados;

-- Convertir a mayúsculas / minúsculas
SELECT UPPER(nombre), LOWER(apellido) FROM empleados;

-- Longitud del texto
SELECT nombre, LENGTH(nombre) AS caracteres FROM empleados;

-- Quitar espacios al inicio y fin
SELECT TRIM('  hola  ');  -- resultado: 'hola'
```

---

## 4. Funciones de fecha

```sql
-- Fecha y hora actual
SELECT CURDATE();    -- fecha: 2026-06-18
SELECT NOW();        -- fecha y hora: 2026-06-18 14:30:00

-- Extraer partes de una fecha
SELECT YEAR(fecha_contratacion)  AS anio  FROM empleados;
SELECT MONTH(fecha_contratacion) AS mes   FROM empleados;
SELECT DAY(fecha_contratacion)   AS dia   FROM empleados;

-- Diferencia en días entre dos fechas
SELECT DATEDIFF(CURDATE(), fecha_contratacion) AS dias_en_empresa
FROM empleados;
```

---

## 5. JOINs — combinar tablas

### INNER JOIN — solo registros que tienen coincidencia en AMBAS tablas

```sql
SELECT e.nombre, d.nombre AS departamento
FROM empleados e
INNER JOIN departamentos d ON e.id_departamento = d.id_departamento;
```

### LEFT JOIN — TODOS los de la tabla izquierda, aunque no tengan coincidencia

```sql
SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamentos d
LEFT JOIN empleados e ON d.id_departamento = e.id_departamento;
-- Si un departamento no tiene empleados, aparece con empleado = NULL
```

> [!tip] Cuándo usar cada uno
> - `INNER JOIN`: cuando solo quieres registros que tienen pareja en las dos tablas.
> - `LEFT JOIN`: cuando quieres ver TODOS los registros de la tabla principal, incluyendo los que no tienen pareja (aparecen como NULL).

---

## 6. Funciones de agregación

Las funciones de agregación **calculan un valor a partir de un conjunto de filas**.

| Función | Qué hace |
|---|---|
| `COUNT(*)` | Cuenta todas las filas |
| `COUNT(columna)` | Cuenta filas donde la columna no es NULL |
| `SUM(columna)` | Suma los valores |
| `AVG(columna)` | Calcula el promedio |
| `MIN(columna)` | Valor mínimo |
| `MAX(columna)` | Valor máximo |
| `ROUND(valor, decimales)` | Redondea a N decimales |

```sql
-- Contar empleados activos
SELECT COUNT(*) AS total_empleados
FROM empleados
WHERE activo = 1;

-- Salario promedio
SELECT ROUND(AVG(salario), 2) AS salario_promedio
FROM empleados
WHERE activo = 1;

-- Salario total pagado (nómina)
SELECT SUM(salario) AS nomina_total
FROM empleados
WHERE activo = 1;

-- El salario más alto y el más bajo
SELECT MAX(salario) AS maximo, MIN(salario) AS minimo
FROM empleados;
```

---

## 7. GROUP BY — agrupar resultados

`GROUP BY` divide el resultado en **grupos** y aplica la función de agregación a cada grupo.

```sql
-- Contar empleados POR departamento
SELECT id_departamento, COUNT(*) AS total
FROM empleados
WHERE activo = 1
GROUP BY id_departamento;
```

> [!important] Regla de oro del GROUP BY
> En el `SELECT` solo puedes poner:
> - Las columnas que están en el `GROUP BY`
> - Funciones de agregación (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)
>
> Si pones cualquier otra columna, MySQL devuelve un error o un resultado impredecible.

```sql
-- Con JOIN para ver el nombre del departamento
SELECT
    d.nombre        AS departamento,
    COUNT(e.id_empleado) AS total_empleados,
    ROUND(AVG(e.salario), 2) AS salario_promedio
FROM departamentos d
INNER JOIN empleados e ON d.id_departamento = e.id_departamento
WHERE e.activo = 1
GROUP BY d.id_departamento, d.nombre
ORDER BY total_empleados DESC;
```

---

## 8. HAVING — filtrar grupos

`HAVING` es como un `WHERE`, pero para **grupos** (no para filas individuales).

```
WHERE  → filtra filas ANTES de agrupar
HAVING → filtra grupos DESPUÉS de agrupar
```

```sql
-- Departamentos con MÁS de 3 empleados activos
SELECT
    d.nombre AS departamento,
    COUNT(e.id_empleado) AS total
FROM departamentos d
INNER JOIN empleados e ON d.id_departamento = e.id_departamento
WHERE e.activo = 1          -- filtra filas: solo empleados activos
GROUP BY d.id_departamento, d.nombre
HAVING total > 3            -- filtra grupos: solo deptos con más de 3
ORDER BY total DESC;
```

> [!warning] WHERE vs HAVING — diferencia clave
> ```sql
> -- Esto es CORRECTO: WHERE filtra filas antes de agrupar
> SELECT id_departamento, COUNT(*) AS total
> FROM empleados
> WHERE activo = 1        -- primero filtra los activos
> GROUP BY id_departamento
> HAVING total > 2;       -- luego filtra los grupos
>
> -- Esto es INCORRECTO: no puedes usar alias de agregación en WHERE
> SELECT id_departamento, COUNT(*) AS total
> FROM empleados
> WHERE total > 2         -- ERROR: total no existe aún
> GROUP BY id_departamento;
> ```

---

## Orden de ejecución de una consulta SQL

MySQL procesa las cláusulas en este orden (no el orden en que las escribes):

```
1. FROM       → de qué tabla
2. JOIN       → unir tablas
3. WHERE      → filtrar filas
4. GROUP BY   → agrupar
5. HAVING     → filtrar grupos
6. SELECT     → qué columnas mostrar
7. ORDER BY   → ordenar
8. LIMIT      → cuántas filas
```

Entender este orden explica por qué no puedes usar un alias del `SELECT` en el `WHERE` (el `WHERE` se ejecuta antes que el `SELECT`).
