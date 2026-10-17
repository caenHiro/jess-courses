---
titulo: JSON en Bases de Datos (MySQL)
tema: sql
tipo: ejercicios
nivel: intermedio-avanzado
actualizado: 2026-06-28
---

# JSON en Bases de Datos (MySQL)

> Ejercicios practicos sobre **JSON en Bases de Datos (MySQL)**.
> Base de datos: Sistema de Biblioteca (ver `00_Descripcion_BD.md`).

---

### Ejercicio 1 — Extraer Información del Autor

**Enunciado:**  
Extrae el nombre y la nacionalidad de todos los autores que nacieron después del año 1980.

**Pista:**  
Utiliza `JSON_EXTRACT` para obtener información desde una columna JSON.

```sql
-- Solucion
SELECT 
    JSON_UNQUOTE(JSON_EXTRACT(autores.nacionalidad, '$')) AS nacionalidad,
    autores.nombre
FROM 
    autores
WHERE 
    YEAR(autores.fecha_nacimiento) > 1980;
```

### Ejercicio 2 — Formato de Fecha de Publicación

**Enunciado:**  
Obtén el título y la fecha de publicación en formato "DD/MM/YYYY" para todos los libros que fueron publicados después del año 2000.

**Pista:**  
Usa `DATE_FORMAT` junto con operadores JSON (`->>`).

```sql
-- Solucion
SELECT 
    libros.titulo,
    DATE_FORMAT(libros.fecha_publicacion, '%d/%m/%Y') AS fecha_publicacion_formateada
FROM 
    libros
WHERE 
    YEAR(libros.fecha_publicacion) > 2000;
```

### Ejercicio 3 — Crear un Objeto JSON para Libro

**Enunciado:**  
Crea un objeto JSON que contenga el título, ISBN y precio de todos los libros.

**Pista:**  
Utiliza `JSON_OBJECT` para crear objetos JSON a partir de columnas.

```sql
-- Solucion
SELECT 
    JSON_OBJECT(
        'titulo', libros.titulo,
        'isbn', libros.isbn,
        'precio', libros.precio
    ) AS libro_json
FROM 
    libros;
```

### Ejercicio 4 — Filtrar Libros por Genero

**Enunciado:**  
Encuentra todos los libros cuyo género contiene la palabra "Fantasía" en su descripción.

**Pista:**  
Usa `JSON_CONTAINS` para verificar si una cadena está dentro de un JSON.

```sql
-- Solucion
SELECT 
    libros.titulo,
    generos.descripcion
FROM 
    libros
JOIN 
    generos ON libros.id_genero = generos.id
WHERE 
    JSON_CONTAINS(generos.descripcion, '"Fantasía"');
```

### Ejercicio 5 — Actualizar Stock de Libros

**Enunciado:**  
Incrementa en 10 unidades el stock de todos los libros cuyo precio es mayor a $50.

**Pista:**  
Utiliza `JSON_SET` para modificar un valor dentro de una columna JSON.

```sql
-- Solucion
UPDATE 
    libros
SET 
    stock = stock + 10
WHERE 
    libros.precio > 50;
```

### Ejercicio 6 — Crear Índice sobre Campo JSON

**Enunciado:**  
Crea un índice generado sobre el campo `nacionalidad` de la tabla `autores`, que está almacenada como JSON.

**Pista:**  
Usa `CREATE INDEX ... USING GIN`.

```sql
-- Solucion
ALTER TABLE autores
ADD FULLTEXT idx_nacionalidad (JSON_UNQUOTE(JSON_EXTRACT(nacionalidad, '$')));
```

### Ejercicio 7 — Filtrar Prestamos Pendientes

**Enunciado:**  
Encuentra todos los préstamos que aún no han sido devueltos y cuyo estado es "activo".

**Pista:**  
Combina condiciones SQL con operadores JSON.

```sql
-- Solucion
SELECT 
    prestamos.id,
    usuarios.nombre AS usuario_nombre,
    libros.titulo AS libro_titulo,
    prestamos.fecha_prestamo
FROM 
    prestamos
JOIN 
    usuarios ON prestamos.id_usuario = usuarios.id
JOIN 
    libros ON prestamos.id_libro = libros.id
WHERE 
    prestamos.estado = 'activo'
AND 
    prestamos.fecha_devolucion IS NULL;
```

### Ejercicio 8 — Crear Reporte Completo de Multas

**Enunciado:**  
Genera un reporte que incluya el ID del préstamo, monto de la multa y nombre del usuario para todas las multas pendientes de pago.

**Pista:**  
Combina varias tablas y filtra por el estado de la multa usando operadores JSON.

```sql
-- Solucion
SELECT 
    multas.id AS id_multa,
    multas.monto,
    usuarios.nombre AS nombre_usuario
FROM 
    multas
JOIN 
    prestamos ON multas.id_prestamo = prestamos.id
JOIN 
    usuarios ON prestamos.id_usuario = usuarios.id
WHERE 
    multas.pagada = 0;
```

---

*Generado con Ollama (phi4:14b) · 2026-06-28*
