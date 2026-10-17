---
titulo: DDL — CREATE, ALTER, DROP y Restricciones
tema: sql
tipo: ejercicios
nivel: intermedio-avanzado
actualizado: 2026-06-28
---

# DDL — CREATE, ALTER, DROP y Restricciones

> Ejercicios practicos sobre **DDL — CREATE, ALTER, DROP y Restricciones**.
> Base de datos: Sistema de Biblioteca (ver `00_Descripcion_BD.md`).

---

### Ejercicio 1 — Crear Tabla Autores
**Enunciado:** Crea la tabla `autores` con las columnas: `id` como clave primaria autoincremental, `nombre`, `nacionalidad`, y `fecha_nacimiento`. Asegúrate de que el nombre no sea nulo.
**Pista:** Usa PRIMARY KEY e INT para id.

```sql
-- Solucion
CREATE TABLE autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50),
    fecha_nacimiento DATE
);
```

### Ejercicio 2 — Crear Tabla Generos
**Enunciado:** Crea la tabla `generos` con las columnas: `id` como clave primaria autoincremental, `nombre`, y `descripcion`. El nombre debe ser único.
**Pista:** Usa UNIQUE para el campo nombre.

```sql
-- Solucion
CREATE TABLE generos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT
);
```

### Ejercicio 3 — Crear Tabla Usuarios
**Enunciado:** Crea la tabla `usuarios` con las columnas: `id` como clave primaria autoincremental, `nombre`, `email` único y no nulo, `telefono`, `fecha_registro` con un valor por defecto de hoy, y `activo` booleano por defecto a TRUE.
**Pista:** Usa DEFAULT para fecha_registro e inicialización booleana.

```sql
-- Solucion
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    fecha_registro DATE DEFAULT CURRENT_DATE,
    activo BOOLEAN DEFAULT TRUE
);
```

### Ejercicio 4 — Crear Tabla Libros
**Enunciado:** Crea la tabla `libros` con las columnas: `id` como clave primaria autoincremental, `titulo`, `isbn` único y no nulo, `precio`, `stock`, `id_autor` que es una clave foránea de `autores(id)`, `id_genero` que es una clave foránea de `generos(id)`, `fecha_publicacion`. Asegúrate de que el stock sea mayor o igual a cero.
**Pista:** Usa FOREIGN KEY y CHECK para restricciones.

```sql
-- Solucion
CREATE TABLE libros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    isbn VARCHAR(13) UNIQUE NOT NULL,
    precio DECIMAL(10, 2),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    id_autor INT,
    id_genero INT,
    fecha_publicacion DATE,
    FOREIGN KEY (id_autor) REFERENCES autores(id),
    FOREIGN KEY (id_genero) REFERENCES generos(id)
);
```

### Ejercicio 5 — Crear Tabla Prestamos
**Enunciado:** Crea la tabla `prestamos` con las columnas: `id` como clave primaria autoincremental, `id_libro`, `id_usuario`, `fecha_prestamo`, `fecha_devolucion`, y `estado`. Las fechas de préstamo deben ser anteriores a las de devolución.
**Pista:** Usa CHECK para la relación entre fechas.

```sql
-- Solucion
CREATE TABLE prestamos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT,
    id_usuario INT,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,
    estado VARCHAR(20) DEFAULT 'Pendiente',
    FOREIGN KEY (id_libro) REFERENCES libros(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    CHECK (fecha_prestamo <= COALESCE(fecha_devolucion, '9999-12-31'))
);
```

### Ejercicio 6 — Crear Tabla Multas
**Enunciado:** Crea la tabla `multas` con las columnas: `id` como clave primaria autoincremental, `id_prestamo`, `monto`, `pagada`, y `fecha`. El monto debe ser mayor que cero.
**Pista:** Usa CHECK para el campo monto.

```sql
-- Solucion
CREATE TABLE multas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_prestamo INT,
    monto DECIMAL(10, 2) CHECK (monto > 0),
    pagada BOOLEAN DEFAULT FALSE,
    fecha DATE,
    FOREIGN KEY (id_prestamo) REFERENCES prestamos(id)
);
```

### Ejercicio 7 — Añadir Columna en Libros
**Enunciado:** Modifica la tabla `libros` para añadir una columna `editorial` que sea de tipo VARCHAR(100).
**Pista:** Usa ALTER TABLE para añadir columnas.

```sql
-- Solucion
ALTER TABLE libros ADD COLUMN editorial VARCHAR(100);
```

### Ejercicio 8 — Eliminar Columna en Usuarios
**Enunciado:** Modifica la tabla `usuarios` eliminando la columna `telefono`.
**Pista:** Usa DROP COLUMN con ALTER TABLE.

```sql
-- Solucion
ALTER TABLE usuarios DROP COLUMN telefono;
```

### Ejercicio 9 — Cambiar Tipo de Datos en Autores
**Enunciado:** Cambia el tipo de datos de `nacionalidad` en la tabla `autores` a VARCHAR(100).
**Pista:** Usa MODIFY COLUMN con ALTER TABLE.

```sql
-- Solucion
ALTER TABLE autores MODIFY COLUMN nacionalidad VARCHAR(100);
```

### Ejercicio 10 — Agregar Restricción UNIQUE en Generos
**Enunciado:** Añade una restricción UNIQUE a la columna `descripcion` de la tabla `generos`.
**Pista:** Usa ALTER TABLE para agregar restricciones.

```sql
-- Solucion
ALTER TABLE generos ADD CONSTRAINT unique_descripcion UNIQUE (descripcion);
```

### Ejercicio 11 — Cambiar Clave Foránea en Prestamos
**Enunciado:** Modifica la clave foránea `id_libro` en la tabla `prestamos` para que también incluya una restricción NOT NULL.
**Pista:** Primero elimina y luego re-crea la clave foránea.

```sql
-- Solucion
ALTER TABLE prestamos DROP FOREIGN KEY prestamos_ibfk_1;
ALTER TABLE prestamos MODIFY COLUMN id_libro INT NOT NULL,
ADD CONSTRAINT fk_prestamos_id_libro FOREIGN KEY (id_libro) REFERENCES libros(id);
```

### Ejercicio 12 — Eliminar Restricción UNIQUE en Libros
**Enunciado:** Elimina la restricción UNIQUE de `isbn` en la tabla `libros`.
**Pista:** Usa ALTER TABLE para eliminar restricciones.

```sql
-- Solucion
ALTER TABLE libros DROP INDEX isbn;
```

### Ejercicio 13 — Crear Tabla Temporal
**Enunciado:** Crea una tabla temporal llamada `temp_autores` con las mismas columnas que la tabla `autores`.
**Pista:** Usa CREATE TEMPORARY TABLE.

```sql
-- Solucion
CREATE TEMPORARY TABLE temp_autores LIKE autores;
```

### Ejercicio 14 — Eliminar Tabla Multas
**Enunciado:** Elimina la tabla `multas` de la base de datos.
**Pista:** Usa DROP TABLE para eliminar tablas.

```sql
-- Solucion
DROP TABLE multas;
```

### Ejercicio 15 — Modificar Clave Primaria en Generos
**Enunciado:** Cambia la clave primaria de la tabla `generos` a una combinación única de `nombre` y `descripcion`.
**Pista:** Elimina la PK actual e introduce una nueva.

```sql
-- Solucion
ALTER TABLE generos DROP PRIMARY KEY;
ALTER TABLE generos ADD PRIMARY KEY (nombre, descripcion);
```

---

*Generado con Ollama (phi4:14b) · 2026-06-28*
