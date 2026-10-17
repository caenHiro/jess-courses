---
tema: JSON en bases de datos relacionales
estado: completo
---

# JSON en Bases de Datos

> Cada vez más empresas guardan JSON en MySQL o PostgreSQL. Te pueden preguntar cuándo usarlo y cómo funciona.

---

## ¿Por qué guardar JSON en una BD relacional?

Las bases de datos relacionales son excelentes para datos estructurados (tablas con columnas fijas). Pero a veces necesitas guardar datos cuya estructura **varía de registro a registro**, como:

- Configuraciones de usuario (cada usuario puede tener opciones diferentes)
- Metadatos de un producto (una laptop tiene RAM, una camisa tiene talla — columnas completamente distintas)
- Respuestas de APIs externas (no controlas su estructura)
- Historial de eventos

En vez de crear una tabla con 50 columnas donde la mayoría siempre están vacías, puedes guardar esos datos variables en una columna JSON.

---

## JSON en MySQL

MySQL soporta el tipo de dato `JSON` desde la versión 5.7.

```sql
-- Tabla con columna JSON
CREATE TABLE configuraciones_usuario (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado INT NOT NULL,
    preferencias JSON,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Insertar un JSON
INSERT INTO configuraciones_usuario (id_empleado, preferencias) VALUES
(7, '{"tema": "oscuro", "idioma": "es", "notificaciones": true, "items_por_pagina": 25}');
```

### Leer valores de un JSON — JSON_EXTRACT

```sql
-- Leer un valor específico (con $. para navegar el JSON)
SELECT
    id_empleado,
    JSON_EXTRACT(preferencias, '$.tema')              AS tema,
    JSON_EXTRACT(preferencias, '$.idioma')            AS idioma,
    JSON_EXTRACT(preferencias, '$.items_por_pagina')  AS items
FROM configuraciones_usuario;

-- Forma corta con operador ->
SELECT preferencias->'$.tema' AS tema
FROM configuraciones_usuario;

-- Sin las comillas del resultado (operador ->>)
SELECT preferencias->>'$.tema' AS tema
FROM configuraciones_usuario;
-- Resultado: oscuro  (no "oscuro")
```

### Modificar un valor dentro del JSON — JSON_SET

```sql
-- Cambiar el tema a claro sin reemplazar todo el JSON
UPDATE configuraciones_usuario
SET preferencias = JSON_SET(preferencias, '$.tema', 'claro')
WHERE id_empleado = 7;
```

### Filtrar por valor dentro del JSON — WHERE con JSON_EXTRACT

```sql
-- Empleados que tienen tema oscuro
SELECT id_empleado
FROM configuraciones_usuario
WHERE JSON_EXTRACT(preferencias, '$.tema') = 'oscuro';
```

### Crear un JSON desde una consulta — JSON_OBJECT y JSON_ARRAYAGG

```sql
-- Crear un objeto JSON con columnas de la tabla
SELECT JSON_OBJECT(
    'nombre',   nombre,
    'apellido', apellido,
    'salario',  salario
) AS empleado_json
FROM empleados
WHERE id_empleado = 7;

-- Agrupar varios objetos en un array JSON
SELECT JSON_ARRAYAGG(
    JSON_OBJECT('id', id_empleado, 'nombre', nombre)
) AS empleados_array
FROM empleados
WHERE activo = 1;
```

---

## JSON en PostgreSQL: JSON vs JSONB

PostgreSQL tiene DOS tipos para JSON:

| Tipo | Almacenamiento | Búsqueda | Índices |
|---|---|---|---|
| `JSON` | Texto plano (guarda formato original) | Lenta (parsea cada vez) | No |
| `JSONB` | Formato binario (optimizado) | Rápida | Sí — GIN index |

**Siempre usa `JSONB` en PostgreSQL** salvo que necesites preservar el orden de las claves o los espacios exactos del JSON original (casos muy raros).

```sql
-- PostgreSQL: JSONB
CREATE TABLE configuraciones (
    id_empleado INT PRIMARY KEY,
    preferencias JSONB
);

-- Insertar
INSERT INTO configuraciones VALUES
(7, '{"tema": "oscuro", "idioma": "es"}');

-- Leer con operador ->
SELECT preferencias->'tema' AS tema FROM configuraciones;  -- "oscuro" (con comillas)
SELECT preferencias->>'tema' AS tema FROM configuraciones; -- oscuro (sin comillas)

-- Filtrar con @> (contiene)
SELECT * FROM configuraciones
WHERE preferencias @> '{"tema": "oscuro"}';
```

---

## ¿Cuándo usar JSON y cuándo usar tablas normalizadas?

| Situación | Recomendación |
|---|---|
| Estructura fija y conocida | Tabla normalizada siempre |
| Atributos variables por registro | JSON |
| Necesitas filtrar/indexar por esos campos frecuentemente | Tabla normalizada (o JSONB en PostgreSQL con índice GIN) |
| Guardar respuesta de una API externa sin parsear | JSON |
| Los datos son críticos y necesitan integridad fuerte | Tabla normalizada siempre |

> [!warning] JSON no reemplaza la normalización
> Guardar todo en JSON es tentador pero pierde las ventajas de las BD relacionales: integridad, constraints, joins eficientes. Úsalo solo para lo que realmente tiene estructura variable.

---

## Resumen para la entrevista

- **MySQL**: usa `JSON_EXTRACT()` o el operador `->` para leer. `JSON_SET()` para modificar.
- **PostgreSQL**: prefiere `JSONB` sobre `JSON` — es más rápido y permite índices.
- **Cuándo usarlo**: datos con estructura variable, configuraciones, metadatos opcionales.
- **Cuándo NO usarlo**: datos con estructura fija que necesitan integridad referencial.
