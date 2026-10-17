# Semana 11 — SQL: Bases de datos relacionales + JDBC básico

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-11 jdbc — mysql"`

---

---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Explicar qué es una base de datos y para qué sirve
- Crear una tabla con `CREATE TABLE` y definir sus columnas y tipos
- Insertar datos con `INSERT INTO`
- Consultar datos con `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- Usar funciones de agregación: `COUNT`, `AVG`, `MAX`, `MIN`
- Actualizar datos con `UPDATE ... SET ... WHERE`
- Eliminar datos con `DELETE FROM ... WHERE`
- Conectar Java a MySQL con JDBC y ejecutar una consulta básica

---

## Analogía clave 

> "Una base de datos es como el archivo del IMSS: hay una carpeta por cada persona, con su nombre, número de seguridad social, historial médico. Puedes buscar a alguien rápido, agregar información nueva, corregir datos, o dar de baja a alguien. SQL es el lenguaje para hacer todo eso."

> "Una tabla es exactamente como una hoja de Excel: columnas son los campos (nombre, edad, carrera), filas son los registros (cada estudiante). La diferencia es que SQL puede buscar, filtrar y ordenar millones de filas en milisegundos."

> "El `WHERE` en SQL es como el filtro de Excel. En vez de buscar a mano, le dices: 'muéstrame solo los estudiantes con promedio mayor a 9' y SQL los encuentra al instante."

Conectar con lo que ya sabe: "Lo que hacíamos con `ArrayList` — agregar, buscar, eliminar datos — SQL lo hace pero de forma permanente y mucho más poderosa. Los datos quedan guardados aunque cierres el programa."

---

## Contenido teórico

### 11.1 ¿Qué es una base de datos?

Una base de datos guarda información de forma organizada, persistente y eficiente. A diferencia de guardar en variables o ArrayList (que se pierden al cerrar el programa), los datos en una base de datos persisten indefinidamente.

**MySQL** es un sistema gestor de bases de datos (SGBD) — el programa que administra los datos. **SQL** es el lenguaje para comunicarse con él.

**Herramienta:** DBeaver Community (gratuito, descarga en dbeaver.io) — interfaz visual para escribir y ejecutar SQL.

### 11.2 Tablas, columnas y tipos de datos

Una **tabla** organiza datos en filas y columnas, igual que una hoja de Excel.

```sql
-- CREATE TABLE crea una nueva tabla
-- Cada línea dentro define una columna
CREATE TABLE estudiantes (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- número único que identifica cada fila (se genera solo)
    nombre VARCHAR(100) NOT NULL,       -- texto de hasta 100 caracteres, obligatorio
    edad INT,                           -- número entero (edad)
    carrera VARCHAR(100),               -- texto, puede estar vacío
    promedio DECIMAL(4,2),              -- número con hasta 4 dígitos, 2 decimales (ej: 9.85)
    fecha_ingreso DATE                  -- solo fecha, sin hora (formato: YYYY-MM-DD)
);
```

**Tipos de datos más importantes:**

| Tipo SQL | Para qué | Ejemplo |
|----------|----------|---------|
| `INT` | Número entero | `edad INT` |
| `DECIMAL(n,d)` | Número con decimales | `DECIMAL(4,2)` → 9.85 |
| `VARCHAR(n)` | Texto de hasta n caracteres | `VARCHAR(100)` |
| `DATE` | Solo fecha | `2024-01-15` |
| `DATETIME` | Fecha y hora | `2024-01-15 14:30:00` |
| `BOOLEAN` | Verdadero/falso | `activo BOOLEAN` |

**Restricciones de columna:**

| Restricción | Qué hace |
|------------|---------|
| `PRIMARY KEY` | Identifica la fila de forma única — no se puede repetir |
| `AUTO_INCREMENT` | MySQL asigna el número automáticamente (1, 2, 3...) |
| `NOT NULL` | El campo es obligatorio — no puede quedar vacío |
| `UNIQUE` | No pueden repetirse valores en esa columna |
| `DEFAULT valor` | Valor por defecto si no se especifica uno |

### 11.3 INSERT — agregar datos

```sql
-- INSERT INTO agrega una fila nueva a la tabla
-- (columnas) indica cuáles columnas vamos a llenar
-- VALUES indica los valores, en el mismo orden
INSERT INTO estudiantes (nombre, edad, carrera, promedio, fecha_ingreso)
VALUES ('Jessica Escalona', 22, 'Ingeniería en Sistemas', 9.2, '2022-08-15');
-- Nota: el id lo genera MySQL solo (AUTO_INCREMENT), no lo ponemos
```

Insertar varios a la vez (más eficiente):
```sql
INSERT INTO estudiantes (nombre, edad, carrera, promedio, fecha_ingreso) VALUES
('Jessica Escalona', 22, 'Ingeniería en Sistemas', 9.2, '2022-08-15'),
('Carlos Pérez', 25, 'Ciencias de la Computación', 8.5, '2021-01-10'),
('María López', 20, 'Ingeniería en Sistemas', 9.8, '2023-08-20'),
('Pedro Ramírez', 23, 'Administración', 7.5, '2021-08-15');
-- Cada fila es un par de paréntesis separados por coma
```

### 11.4 SELECT — consultar datos

```sql
-- * significa "todas las columnas"
SELECT * FROM estudiantes;

-- Solo algunas columnas (más eficiente para tablas grandes)
SELECT nombre, promedio FROM estudiantes;

-- Con condición: WHERE filtra las filas que cumplen la condición
SELECT * FROM estudiantes WHERE promedio >= 9.0;

-- Múltiples condiciones con AND / OR
SELECT * FROM estudiantes WHERE carrera = 'Ingeniería en Sistemas' AND promedio >= 8.0;

-- Ordenar resultados
SELECT * FROM estudiantes ORDER BY promedio DESC;   -- de mayor a menor
SELECT * FROM estudiantes ORDER BY nombre ASC;      -- de A a Z (ASC es por defecto)

-- Limitar resultados (los primeros N)
SELECT * FROM estudiantes LIMIT 5;   -- solo los 5 primeros
```

### 11.5 WHERE — filtros avanzados

```sql
-- Igual a un valor exacto
SELECT * FROM estudiantes WHERE carrera = 'Administración';

-- Mayor, menor, mayor o igual, menor o igual, diferente
SELECT * FROM estudiantes WHERE promedio > 8.0;
SELECT * FROM estudiantes WHERE edad <= 22;
SELECT * FROM estudiantes WHERE carrera != 'Administración';

-- BETWEEN: entre dos valores (inclusive)
SELECT * FROM estudiantes WHERE edad BETWEEN 20 AND 25;
-- equivalente a: WHERE edad >= 20 AND edad <= 25

-- LIKE: busca patrones en texto
-- % significa "cualquier texto" (cero o más caracteres)
SELECT * FROM estudiantes WHERE nombre LIKE 'Jes%';      -- empieza con "Jes"
SELECT * FROM estudiantes WHERE nombre LIKE '%Escalona'; -- termina con "Escalona"
SELECT * FROM estudiantes WHERE nombre LIKE '%a%';       -- contiene la letra "a"

-- IN: varios valores posibles (más limpio que muchos OR)
SELECT * FROM estudiantes WHERE carrera IN ('Administración', 'Contaduría');
```

### 11.6 Funciones de agregación

```sql
-- COUNT: cuenta cuántas filas hay
SELECT COUNT(*) AS total FROM estudiantes;   -- cuántos estudiantes en total
SELECT COUNT(*) AS total FROM estudiantes WHERE promedio >= 9.0;  -- cuántos con promedio alto

-- AVG: promedio de una columna numérica
SELECT AVG(promedio) AS promedio_general FROM estudiantes;

-- MAX y MIN: valor máximo y mínimo
SELECT MAX(promedio) AS mejor_promedio FROM estudiantes;
SELECT MIN(promedio) AS menor_promedio FROM estudiantes;

-- SUM: suma de todos los valores de una columna
SELECT SUM(promedio) AS suma_total FROM estudiantes;

-- AS: pone un nombre descriptivo a la columna en el resultado
-- Sin AS la columna se llama "AVG(promedio)" que es feo
SELECT AVG(promedio) AS promedio_general FROM estudiantes;
```

### 11.7 UPDATE — actualizar datos

```sql
-- UPDATE modifica datos existentes
-- SET indica qué columna y qué nuevo valor
-- WHERE indica cuáles filas modificar

UPDATE estudiantes
SET promedio = 9.5
WHERE id = 1;   -- solo actualiza la fila con id=1

-- REGLA CRÍTICA: SIEMPRE usar WHERE en UPDATE
-- Sin WHERE, actualiza TODOS los registros de la tabla
-- Error muy común y peligroso en producción:
-- UPDATE estudiantes SET promedio = 9.5;  <-- esto cambia TODOS los promedios
```

### 11.8 DELETE — eliminar datos

```sql
-- DELETE elimina filas de una tabla
DELETE FROM estudiantes WHERE id = 6;   -- elimina solo la fila con id=6

-- REGLA CRÍTICA: SIEMPRE usar WHERE en DELETE
-- Sin WHERE, elimina TODOS los registros de la tabla
-- DELETE FROM estudiantes;  <-- ¡elimina todo! muy peligroso

-- IMPORTANTE: DELETE elimina filas, no tablas
-- Para eliminar una tabla completa se usa DROP TABLE (no lo usaremos ahora)
```

### 11.9 JDBC — conectar Java a MySQL

JDBC (Java Database Connectivity) es la forma de conectar Java con MySQL desde código. Requiere el conector JDBC de MySQL (archivo `.jar`) en el classpath del proyecto.

```java
import java.sql.Connection;       // representa la conexión a la base de datos
import java.sql.DriverManager;    // ayuda a crear la conexión
import java.sql.ResultSet;        // contiene los resultados de un SELECT
import java.sql.Statement;        // ejecuta comandos SQL

public class ConexionBasica {
    // Datos de conexión — en un proyecto real irían en un archivo de configuración
    private static final String URL  = "jdbc:mysql://localhost:3306/mi_escuela";
    // jdbc:mysql:// es el protocolo
    // localhost es la dirección del servidor (la misma máquina)
    // 3306 es el puerto por defecto de MySQL
    // mi_escuela es el nombre de la base de datos
    private static final String USER = "root";     // usuario de MySQL
    private static final String PASS = "tu_pass";  // contraseña de MySQL

    public static void main(String[] args) {
        Connection conn = null;   // declaramos fuera del try para poder cerrar en finally

        try {
            // DriverManager.getConnection() crea la conexión
            // Lanza SQLException si no puede conectar (servidor apagado, contraseña mal, etc.)
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Conexión exitosa a la base de datos.");

            // Statement es como un "ejecutador" de SQL
            Statement stmt = conn.createStatement();

            // executeQuery() ejecuta un SELECT y devuelve un ResultSet
            ResultSet rs = stmt.executeQuery("SELECT * FROM estudiantes ORDER BY promedio DESC");

            System.out.println("\n=== Estudiantes ===");
            // rs.next() avanza al siguiente registro — similar a iterar una lista
            // devuelve true mientras haya más filas, false cuando se acaban
            while (rs.next()) {
                // getString("columna") obtiene el valor de la columna como String
                String nombre = rs.getString("nombre");
                // getDouble("columna") obtiene el valor como número con decimales
                double promedio = rs.getDouble("promedio");
                // getInt("columna") obtiene el valor como entero
                int edad = rs.getInt("edad");

                System.out.println(nombre + " | " + edad + " años | Promedio: " + promedio);
            }

        } catch (Exception e) {
            // Cualquier error de conexión o SQL se captura aquí
            System.out.println("Error de base de datos: " + e.getMessage());
        } finally {
            // SIEMPRE cerrar la conexión, falle o no
            try {
                if (conn != null) conn.close();   // liberamos la conexión
            } catch (Exception e) {
                System.out.println("Error al cerrar: " + e.getMessage());
            }
        }
    }
}
```

---

## Errores comunes

1. **`UPDATE` o `DELETE` sin `WHERE`** — el error más peligroso y más común. Insistir MUCHO en esto. En entornos reales puede borrar o modificar miles de registros. Hacer que Jess lo repita: "siempre WHERE en UPDATE y DELETE".

2. **`=` vs `LIKE` en WHERE** — `=` es igualdad exacta, `LIKE` es búsqueda de patrón. `WHERE nombre = 'Jes%'` no encuentra nada (busca literalmente el texto "Jes%"). Debe ser `WHERE nombre LIKE 'Jes%'`.

3. **Olvidar las comillas simples en texto** — SQL usa comillas simples para texto: `'Jessica'`, no `"Jessica"` (las dobles son para nombres de objetos en algunos motores).

4. **`AUTO_INCREMENT` y el `id`** — no hay que poner el `id` en el `INSERT` porque MySQL lo genera solo. Si lo pone como 0 o NULL, MySQL lo ignora y asigna el siguiente.

5. **`DECIMAL(4,2)` mal entendido** — el primer número es el total de dígitos, el segundo son los decimales. `DECIMAL(4,2)` admite hasta 99.99. Si quiere guardar 100.00 necesita `DECIMAL(5,2)`.

6. **Mayúsculas en SQL** — las palabras reservadas (`SELECT`, `FROM`, `WHERE`) son case-insensitive en MySQL, pero por convención se escriben en mayúsculas. Los nombres de tablas y columnas dependen del sistema operativo (Linux es case-sensitive, Windows no).

---

## Solución SQL completa

**01_crear_y_insertar.sql**
```sql
-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS mi_escuela;

-- Seleccionar la base de datos para trabajar en ella
USE mi_escuela;

-- Crear la tabla de estudiantes
-- IF NOT EXISTS evita error si ya existe la tabla
CREATE TABLE IF NOT EXISTS estudiantes (
    id INT PRIMARY KEY AUTO_INCREMENT,          -- id único auto-generado
    nombre VARCHAR(100) NOT NULL,               -- nombre obligatorio
    edad INT,                                   -- edad (puede quedar vacío)
    carrera VARCHAR(100),                       -- carrera
    promedio DECIMAL(4,2),                      -- promedio con 2 decimales
    fecha_ingreso DATE                          -- fecha en formato YYYY-MM-DD
);

-- Insertar 8 estudiantes con datos variados
INSERT INTO estudiantes (nombre, edad, carrera, promedio, fecha_ingreso) VALUES
('Jessica Escalona', 22, 'Ingeniería en Sistemas', 9.2, '2022-08-15'),
('Carlos Pérez', 25, 'Ciencias de la Computación', 8.5, '2021-01-10'),
('María López', 20, 'Ingeniería en Sistemas', 9.8, '2023-08-20'),
('Pedro Ramírez', 23, 'Administración', 7.5, '2021-08-15'),
('Ana García', 21, 'Contaduría', 8.0, '2022-01-12'),
('Luis Torres', 24, 'Ingeniería en Sistemas', 6.5, '2020-08-18'),
('Sofia Mendoza', 22, 'Ciencias de la Computación', 9.5, '2022-08-15'),
('Miguel Sánchez', 26, 'Administración', 7.0, '2019-08-20');
-- El id se genera automáticamente: 1, 2, 3, ... 8
```

**02_consultas.sql**
```sql
-- 1. Ver todos los estudiantes con todas sus columnas
SELECT * FROM estudiantes;

-- 2. Solo nombre y promedio, ordenados de mayor a menor promedio
SELECT nombre, promedio
FROM estudiantes
ORDER BY promedio DESC;   -- DESC = descendente (de mayor a menor)

-- 3. Estudiantes con promedio mayor o igual a 9.0
SELECT * FROM estudiantes WHERE promedio >= 9.0;

-- 4. Estudiantes de una carrera específica
SELECT * FROM estudiantes WHERE carrera = 'Ingeniería en Sistemas';

-- 5. Cuántos estudiantes hay en total
SELECT COUNT(*) AS total_estudiantes FROM estudiantes;
-- AS total_estudiantes le da un nombre descriptivo a la columna resultado

-- 6. Promedio general de todos los estudiantes
SELECT AVG(promedio) AS promedio_general FROM estudiantes;

-- 7. El estudiante con el promedio más alto (nombre y promedio)
-- Ordenamos de mayor a menor y tomamos solo el primero con LIMIT 1
SELECT nombre, promedio
FROM estudiantes
ORDER BY promedio DESC
LIMIT 1;

-- 8. Estudiantes cuyo nombre contiene la letra "a" (mayúscula o minúscula)
SELECT * FROM estudiantes WHERE nombre LIKE '%a%';
-- LIKE '%a%' = contiene "a" en cualquier posición
```

**03_actualizar_eliminar.sql**
```sql
-- Actualizar el promedio de Jessica (id=1)
-- SIEMPRE usar WHERE para no afectar a todos
UPDATE estudiantes
SET promedio = 9.5
WHERE id = 1;

-- Cambiar la carrera de Pedro (id=4) a Ingeniería Industrial
UPDATE estudiantes
SET carrera = 'Ingeniería Industrial'
WHERE id = 4;

-- Cambiar la carrera de Miguel (id=8) también
UPDATE estudiantes
SET carrera = 'Ingeniería Industrial'
WHERE id = 8;

-- Eliminar a Luis Torres (id=6)
-- SIEMPRE usar WHERE para no eliminar todos
DELETE FROM estudiantes WHERE id = 6;

-- Verificar resultados después de los cambios
SELECT * FROM estudiantes ORDER BY id;
```

---

## JDBC — solución de conexión básica

```java
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class ConsultaEstudiantes {
    // URL de conexión: jdbc:mysql://servidor:puerto/base_de_datos
    private static final String URL  = "jdbc:mysql://localhost:3306/mi_escuela";
    private static final String USER = "root";
    private static final String PASS = "";   // poner la contraseña de MySQL aquí

    public static void main(String[] args) {
        Connection conn = null;   // null por defecto, se asignará si la conexión es exitosa

        try {
            // 1. Crear la conexión con la base de datos
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Conectado a MySQL correctamente.");

            // 2. Crear un Statement para ejecutar SQL
            Statement stmt = conn.createStatement();

            // 3. Ejecutar un SELECT — executeQuery devuelve los resultados
            String sql = "SELECT nombre, carrera, promedio FROM estudiantes ORDER BY promedio DESC";
            ResultSet rs = stmt.executeQuery(sql);

            // 4. Recorrer los resultados fila por fila
            System.out.println("\n=== Estudiantes por promedio ===");
            System.out.printf("%-25s %-35s %s%n", "Nombre", "Carrera", "Promedio");
            System.out.println("-".repeat(65));

            while (rs.next()) {
                // Obtener el valor de cada columna por su nombre
                String nombre   = rs.getString("nombre");
                String carrera  = rs.getString("carrera");
                double promedio = rs.getDouble("promedio");

                // Imprimir con formato tabular
                System.out.printf("%-25s %-35s %.2f%n", nombre, carrera, promedio);
            }

        } catch (Exception e) {
            // Captura errores de conexión (servidor apagado, contraseña incorrecta, etc.)
            System.out.println("Error: " + e.getMessage());
        } finally {
            // Siempre cerrar la conexión para liberar recursos
            try {
                if (conn != null) conn.close();
                System.out.println("\nConexión cerrada.");
            } catch (Exception e) {
                System.out.println("Error al cerrar conexión: " + e.getMessage());
            }
        }
    }
}
```

---

## Criterios de calificación — Semana 11

| Criterio | Puntos |
|----------|--------|
| Tabla creada con todos los campos y tipos correctos | 2 pts |
| 8 estudiantes insertados con datos variados y coherentes | 1 pt |
| Las 8 consultas `SELECT` devuelven los resultados correctos | 4 pts |
| `UPDATE` y `DELETE` usan `WHERE` correctamente | 2 pts |
| Reflexión completada con respuestas propias y con sentido | 1 pt |
| **Total** | **10 pts** |

**Punto extra (no penalizar si no lo tiene):** si intentó el código JDBC, mencionarlo positivamente.

---
