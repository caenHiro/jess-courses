---
semana: 11
tema: SQL básico
estado: pendiente
---

# Práctica — Semana 11: SQL básico

> Guarda tus scripts en: `codigo/semana-11/`
> Archivos: `01_crear_tablas.sql`, `02_insertar_datos.sql`, `03_consultas.sql`
> Al terminar: `bash scripts/push.sh "semana-11 sql-basico"`

---

## Setup

Instala DBeaver Community (gratuito en dbeaver.io) y conéctate a una base de datos MySQL local.

Crea primero la base de datos:
```sql
CREATE DATABASE mi_escuela;
USE mi_escuela;

--si no sabes si la tabla ya esta creada 
CREATE DATABASE IF NOT EXISTS mi_escuela;
USE mi_escuela;
```

---

## Ejercicio 1 — Crear tablas e insertar datos (obligatorio)

Archivo: `codigo/semana-11/01_crear_y_insertar.sql`

Crea la tabla `estudiantes` con los campos:
- `id` (clave primaria auto-incremental)
- `nombre` (texto, obligatorio)
- `edad` (entero)
- `carrera` (texto)
- `promedio` (número con 2 decimales)
- `fecha_ingreso` (fecha)

Luego inserta al menos 8 estudiantes con datos variados (diferentes carreras, promedios entre 6 y 10).

_Tu código:_
```sql
--crear la tabla
CREATE TABLE if not EXISTS estudiantes (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
edad INT,
carrera VARCHAR(100),
promedio DECIMAL(4,2),
fecha_ingreso DATE
);

  
--agregar registros
INSERT INTO estudiantes (nombre, edad, carrera, promedio, fecha_ingreso) VALUES
('Jessica Escalona', 22, 'Ingeniería en Sistemas', 9.2, '2022-08-15'),
('Carlos Pérez', 25, 'Ciencias de la Computación', 8.51, '2021-01-10'),
('María López', 20, 'Ingeniería en Sistemas', 9.2, '2023-08-20'),
('Pedro Ramírez', 23, 'Administración', 7.56, '2021-08-15'),
('Ana García', 21, 'Contaduría', 8.0, '2022-01-12'),
('Luis Torres', 24, 'Ingeniería en Sistemas', 6.58, '2020-08-18'),
('Sofia Mendoza', 22, 'Ciencias de la Computación', 9.5, '2022-08-15'),
('Miguel Sánchez', 26, 'Administración', 7.03, '2019-08-20');
```
---

## Ejercicio 2 — Consultas con SELECT y WHERE (obligatorio)

Archivo: `codigo/semana-11/02_consultas.sql`

Escribe una consulta para cada uno de estos casos:

1. Ver todos los estudiantes
2. Ver solo nombre y promedio, ordenados de mayor a menor promedio
3. Ver estudiantes con promedio mayor o igual a 9.0
4. Ver estudiantes de la carrera "Ingeniería en Sistemas" (o la que hayas creado)
5. Ver cuántos estudiantes hay en total (`COUNT`)
6. Ver el promedio general de todos los estudiantes (`AVG`)
7. Ver el estudiante con el promedio más alto
8. Ver estudiantes cuyo nombre contiene la letra "a" (usa `LIKE`)

_Tu código:_

```sql

--Consultas 

SELECT * FROM estudiantes;
SELECT nombre, promedio FROM estudiantes order BY promedio desc;
SELECT * FROM estudiantes WHERE promedio >= 9;
SELECT * FROM estudiantes WHERE carrera = 'Ingeniería en Sistemas';
SELECT COUNT(*) AS total_estudiantes FROM estudiantes ;
SELECT AVG(promedio) AS promedio_total FROM estudiantes;
SELECT nombre, promedio FROM estudiantes ORDER BY promedio DESC LIMIT 1;
SELECT * FROM estudiantes WHERE nombre LIKE '%a%';
```

---

## Ejercicio 3 — UPDATE y DELETE (obligatorio)

Archivo: `codigo/semana-11/03_actualizar_eliminar.sql`

1. Actualiza el promedio de UN estudiante específico
2. Cambia la carrera de dos estudiantes
3. Elimina un estudiante por su id

_Tu código:_

```sql
UPDATE estudiantes SET promedio = 9.99 WHERE id = 1;
UPDATE estudiantes e set carrera = 'Ingeniería Industrial' WHERE id = 14;
UPDATE estudiantes e set carrera = 'Ingeniería Industrial' WHERE id = 10;
DELETE FROM estudiantes WHERE id = 16;
SELECT * FROM estudiantes;
```

---

## Reflexión

**¿Por qué es importante el `WHERE` en UPDATE y DELETE?**

_Tu respuesta:_
Para especificar que registro quiere que se actualice o borre. 
**¿Qué hace `AUTO_INCREMENT`?**

_Tu respuesta:_
genera el numero consecutivo del ultimo que esta. 
**¿Cuál es la diferencia entre `=` y `LIKE` en el WHERE?**

_Tu respuesta:_
el = dice que sea exactamente igual a lo que pongas y el like dice que tenga lo que pongas.