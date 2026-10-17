---
tema: MySQL vs PostgreSQL — diferencias clave
estado: completo
---

# MySQL vs PostgreSQL

> Esta comparación salió en la entrevista. No necesitas saber todo PostgreSQL — solo las diferencias principales y cuándo se elige uno u otro.

---

## Origen y filosofía

| | MySQL | PostgreSQL |
|---|---|---|
| Creado por | MySQL AB (ahora Oracle) | Universidad de Berkeley |
| Licencia | Dual: GPL + comercial (Oracle) | BSD — completamente libre |
| Filosofía | **Velocidad** en lecturas simples | **Estándares SQL** y funcionalidades avanzadas |
| Uso común | Aplicaciones web, CMS, e-commerce | Sistemas complejos, análisis de datos, GIS |

---

## Diferencias en tipos de datos

### Autoincremento

```sql
-- MySQL
id INT AUTO_INCREMENT PRIMARY KEY

-- PostgreSQL
id SERIAL PRIMARY KEY
-- o la forma moderna:
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
```

### ENUM

```sql
-- MySQL: tipo de dato nativo
estado ENUM('activo', 'finalizado', 'cancelado')

-- PostgreSQL: no tiene ENUM nativo sencillo — se usa CHECK o se crea un TYPE
estado VARCHAR(20) CHECK (estado IN ('activo', 'finalizado', 'cancelado'))
-- o crear un tipo:
CREATE TYPE estado_proyecto AS ENUM ('activo', 'finalizado', 'cancelado');
estado estado_proyecto
```

### Booleanos

```sql
-- MySQL: no tiene BOOLEAN real — usa TINYINT(1)
activo TINYINT(1)  -- 0 = false, 1 = true

-- PostgreSQL: tiene BOOLEAN nativo
activo BOOLEAN DEFAULT TRUE
```

### Texto ilimitado

```sql
-- MySQL
descripcion TEXT

-- PostgreSQL
descripcion TEXT  -- igual, pero PostgreSQL también tiene VARCHAR sin límite
```

### JSON

```sql
-- MySQL: JSON (desde 5.7)
datos JSON

-- PostgreSQL: JSON y JSONB (JSONB es binario y más eficiente)
datos JSONB  -- siempre preferir JSONB
```

---

## Diferencias en funciones

### Concatenar texto

```sql
-- MySQL
SELECT CONCAT(nombre, ' ', apellido) FROM empleados;

-- PostgreSQL: también tiene CONCAT pero también el operador ||
SELECT nombre || ' ' || apellido FROM empleados;
```

### SUBSTRING — extraer parte de un texto

```sql
-- Ambos soportan SUBSTRING:
SELECT SUBSTRING(nombre, 1, 3) FROM empleados;
-- Resultado: los primeros 3 caracteres del nombre ('Car', 'Ana', etc.)

-- Alternativa: SUBSTR (funciona igual en ambos)
SELECT SUBSTR(nombre, 1, 3) FROM empleados;

-- Con FROM y FOR (sintaxis SQL estándar, funciona en ambos):
SELECT SUBSTRING(nombre FROM 1 FOR 3) FROM empleados;
```

### Funciones de texto frecuentes

```sql
-- Largo del texto
SELECT LENGTH(nombre) FROM empleados;         -- MySQL (bytes)
SELECT CHAR_LENGTH(nombre) FROM empleados;    -- MySQL (caracteres, mejor para UTF-8)
SELECT LENGTH(nombre) FROM empleados;         -- PostgreSQL (caracteres directamente)

-- Reemplazar texto
SELECT REPLACE(email, '@empresa.com', '') FROM empleados;  -- ambos

-- Posición de un texto dentro de otro
SELECT INSTR(email, '@') FROM empleados;       -- MySQL: retorna posición del @
SELECT POSITION('@' IN email) FROM empleados;  -- PostgreSQL

-- Convertir a mayúsculas / minúsculas
SELECT UPPER(nombre), LOWER(apellido) FROM empleados;  -- igual en ambos

-- Recortar espacios
SELECT TRIM(nombre) FROM empleados;   -- ambos
```

### Fecha actual

```sql
-- MySQL
SELECT CURDATE();    -- fecha sin hora
SELECT NOW();        -- fecha con hora

-- PostgreSQL
SELECT CURRENT_DATE;    -- fecha sin hora
SELECT NOW();           -- fecha con hora (ambos tienen NOW())
SELECT CURRENT_TIMESTAMP;  -- equivalente a NOW()
```

---

## Diferencias en comportamiento

### Modo estricto (STRICT MODE)

- **MySQL**: por default es más permisivo — puede insertar valores inválidos truncándolos (en versiones antiguas). Con `STRICT_TRANS_TABLES` activo es más estricto.
- **PostgreSQL**: siempre estricto — rechaza datos inválidos sin excepción.

### Transacciones por default

- **MySQL** (InnoDB): tiene soporte ACID completo. El autocommit está activado por default.
- **PostgreSQL**: cada instrucción está implícitamente en una transacción. Soporta más operaciones dentro de transacciones (como `CREATE INDEX CONCURRENTLY`).

### Case sensitivity en búsquedas

```sql
-- MySQL con collation utf8mb4_unicode_ci:
-- Insensible a mayúsculas Y acentos
WHERE nombre = 'laura'  -- encuentra 'Laura', 'LAURA', 'Láura'

-- PostgreSQL:
-- Sensible a mayúsculas por default
WHERE nombre = 'laura'    -- NO encuentra 'Laura'
WHERE LOWER(nombre) = 'laura'  -- sí encuentra 'Laura'
-- o usar ILIKE:
WHERE nombre ILIKE 'laura'  -- insensible a mayúsculas
```

---

## WHERE vs HAVING — diferencia clave

Esto salió en la entrevista. La diferencia es cuándo se ejecuta cada filtro:

```
WHERE  → filtra filas ANTES de agrupar
HAVING → filtra grupos DESPUÉS de agrupar
```

```sql
-- WHERE: filtra empleados individuales (antes del GROUP BY)
SELECT id_departamento, COUNT(*) AS total
FROM empleados
WHERE activo = 1          -- <-- aplica fila por fila
GROUP BY id_departamento;

-- HAVING: filtra el resultado del GROUP BY (grupos ya formados)
SELECT id_departamento, COUNT(*) AS total
FROM empleados
WHERE activo = 1
GROUP BY id_departamento
HAVING total > 3;         -- <-- aplica sobre el resultado del COUNT

-- NO puedes hacer esto (WHERE no conoce el alias del COUNT):
WHERE total > 3           -- ERROR: total no existe en ese momento
```

**Regla para recordar:** si el filtro usa una función de agregación (`COUNT`, `SUM`, `AVG`...) → `HAVING`. Si no, → `WHERE`.

---

## ¿Cuándo elegir MySQL o PostgreSQL?

| Elige MySQL si... | Elige PostgreSQL si... |
|---|---|
| El proyecto es una app web simple (WordPress, Laravel, etc.) | Necesitas consultas complejas o analítica |
| El equipo ya tiene experiencia con MySQL | Necesitas JSONB con índices eficientes |
| Prioridad: velocidad en lecturas simples | Necesitas cumplimiento estricto del estándar SQL |
| Hosting compartido (la mayoría lo soporta) | Trabajas con datos geoespaciales (PostGIS) |
| | El equipo valora la licencia completamente libre |

---

## Resumen para la entrevista

- **Principal diferencia**: MySQL es más popular en web, PostgreSQL es más completo en funcionalidades SQL.
- **JSON**: MySQL tiene JSON, PostgreSQL tiene JSONB (más eficiente, con índices).
- **BOOLEAN**: PostgreSQL tiene tipo nativo, MySQL usa TINYINT(1).
- **Autoincremento**: `AUTO_INCREMENT` en MySQL, `SERIAL` o `GENERATED ALWAYS` en PostgreSQL.
- **WHERE vs HAVING**: WHERE filtra filas (antes del GROUP BY), HAVING filtra grupos (después del GROUP BY).
