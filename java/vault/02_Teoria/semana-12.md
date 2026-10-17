# Semana 12 — SQL avanzado + Proyecto Final

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-12 sql avanzado + preparedstatement"`

---

---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Crear tablas relacionadas con `FOREIGN KEY`
- Unir datos de múltiples tablas con `INNER JOIN` y `LEFT JOIN`
- Agrupar resultados con `GROUP BY` y filtrar grupos con `HAVING`
- Diseñar una base de datos completa desde cero con relaciones
- Conectar Java a MySQL con JDBC y hacer operaciones INSERT/SELECT desde código
- Completar el proyecto integrador del curso

**Cierre del curso:** esta semana termina el ciclo de 12 semanas.

---

## Analogía clave 

> "Hasta ahora trabajamos con una sola hoja de Excel (una tabla). Hoy vamos a trabajar con un libro completo de varias hojas relacionadas. JOIN es como decirle a Excel: 'toma la hoja de productos y combínala con la hoja de categorías, unidas por el id de categoría'. El resultado es una tabla nueva con información de ambas."

> "FOREIGN KEY es como una referencia cruzada en Word: cuando pones un número de página, ese número debe existir en el documento. En la BD, cuando un producto tiene `categoria_id = 3`, esa categoría con id=3 debe existir en la tabla categorías. Si no existe, MySQL rechaza el dato."

> "GROUP BY es como sacar el total de la lista del mercado por tipo de producto: todos los lácteos juntos, todas las frutas juntas. Agrupa las filas que tienen algo en común y puedes calcular totales, promedios, etc. por grupo."

Conectar con lo que ya sabe: "La semana pasada aprendiste a trabajar con una tabla. Hoy vas a trabajar con 5 tablas relacionadas al mismo tiempo — igual que un sistema real de tienda."

---

## Contenido teórico

### 12.1 FOREIGN KEY — relaciones entre tablas

Una `FOREIGN KEY` crea una relación entre dos tablas. Garantiza que el valor en una columna exista en la tabla referenciada.

```sql
-- Tabla padre: categorias
CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,   -- id único de la categoría
    nombre VARCHAR(100) NOT NULL         -- nombre de la categoría
);

-- Tabla hijo: productos (referencia a categorias)
CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,             -- por defecto 0 unidades
    categoria_id INT,                -- columna que guarda el id de la categoría
    -- FOREIGN KEY indica que categoria_id debe existir en categorias.id
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
    -- Si intentas insertar un producto con categoria_id=99 y esa categoría no existe,
    -- MySQL rechaza el INSERT con error
);
```

**Regla:** siempre crear la tabla padre PRIMERO, antes que la tabla hijo. No puedes referenciar una tabla que no existe.

### 12.2 INNER JOIN — combinar tablas

`INNER JOIN` combina filas de dos tablas cuando hay coincidencia en la columna relacionada. Si una fila no tiene coincidencia en la otra tabla, NO aparece en el resultado.

```sql
-- Sin JOIN: solo vemos categoria_id (número), no el nombre de la categoría
SELECT * FROM productos;
-- resultado: id=1, nombre="Leche", precio=25.00, stock=50, categoria_id=1
-- ¿Qué categoría es la 1? No sabemos sin consultar la otra tabla

-- CON INNER JOIN: vemos el nombre de la categoría directamente
SELECT p.nombre, p.precio, c.nombre AS categoria
-- p. = alias para productos, c. = alias para categorias
-- AS categoria: le ponemos el nombre "categoria" a la columna c.nombre
FROM productos p
INNER JOIN categorias c ON p.categoria_id = c.id;
-- ON: la condición que une las tablas
-- p.categoria_id = c.id: la columna de la tabla hijo = columna de la tabla padre

-- Resultado: Leche | 25.00 | Lácteos
--            Manzana | 18.00 | Frutas
-- (solo productos que tienen categoría asignada)
```

### 12.3 LEFT JOIN — incluir todos aunque no haya coincidencia

`LEFT JOIN` trae TODAS las filas de la tabla de la izquierda, aunque no tengan coincidencia en la tabla de la derecha. Los campos sin coincidencia aparecen como `NULL`.

```sql
-- LEFT JOIN: mostrar TODAS las categorías, aunque no tengan productos
SELECT c.nombre AS categoria, COUNT(p.id) AS total_productos
FROM categorias c
LEFT JOIN productos p ON c.id = p.categoria_id
-- "categorias" es la tabla izquierda (LEFT)
-- Incluye categorías aunque no tengan ningún producto (total = 0)
GROUP BY c.id, c.nombre;

-- Resultado:
-- Lácteos    | 5
-- Frutas     | 3
-- Verduras   | 0  <-- categoría sin productos, con LEFT JOIN aparece con 0
-- (con INNER JOIN, Verduras no aparecería)
```

### 12.4 GROUP BY — agrupar resultados

`GROUP BY` agrupa filas con el mismo valor en una columna, permitiendo calcular totales, promedios, etc. por grupo.

```sql
-- Cuántos productos hay por categoría
SELECT categoria_id, COUNT(*) AS total
FROM productos
GROUP BY categoria_id;
-- Agrupa todas las filas con el mismo categoria_id y cuenta cuántas hay

-- Con JOIN para ver el nombre de la categoría en lugar del id
SELECT c.nombre, COUNT(p.id) AS total_productos, AVG(p.precio) AS precio_promedio
FROM categorias c
LEFT JOIN productos p ON c.id = p.categoria_id
GROUP BY c.id, c.nombre;
-- GROUP BY c.id, c.nombre: agrupamos por id Y nombre de categoría
-- (ponemos todas las columnas que no son funciones de agregación)
```

### 12.5 HAVING — filtrar grupos

`WHERE` filtra filas individuales. `HAVING` filtra grupos (después de `GROUP BY`).

```sql
-- Categorías con más de 3 productos
SELECT c.nombre, COUNT(p.id) AS total
FROM categorias c
LEFT JOIN productos p ON c.id = p.categoria_id
GROUP BY c.id, c.nombre
HAVING total > 3;
-- HAVING filtra GRUPOS, no filas individuales
-- WHERE total > 3 no funciona aquí porque "total" es resultado de COUNT()
-- que se calcula después de agrupar

-- Orden de evaluación en SQL:
-- FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
```

### 12.6 JDBC avanzado — INSERT y SELECT con PreparedStatement

`PreparedStatement` es más seguro que `Statement` porque previene inyección SQL y permite parámetros:

```java
import java.sql.*;

public class ProductoDAO {
    private static final String URL  = "jdbc:mysql://localhost:3306/mi_tienda";
    private static final String USER = "root";
    private static final String PASS = "";

    // Método para insertar un producto nuevo
    public static void insertarProducto(String nombre, double precio, int stock, int categoriaId) {
        String sql = "INSERT INTO productos (nombre, precio, stock, categoria_id) VALUES (?, ?, ?, ?)";
        // Los ? son marcadores de posición — se llenan de forma segura con setX()
        // Esto evita inyección SQL (alguien que ponga código SQL como nombre de producto)

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            // try-with-resources: cierra conn y ps automáticamente al terminar

            ps.setString(1, nombre);       // reemplaza el primer ? con el nombre
            ps.setDouble(2, precio);       // reemplaza el segundo ? con el precio
            ps.setInt(3, stock);           // tercer ? con el stock
            ps.setInt(4, categoriaId);     // cuarto ? con el id de categoría

            int filasAfectadas = ps.executeUpdate();   // executeUpdate() para INSERT/UPDATE/DELETE
            System.out.println("Producto insertado. Filas afectadas: " + filasAfectadas);

        } catch (SQLException e) {
            System.out.println("Error al insertar: " + e.getMessage());
        }
        // conn y ps se cierran automáticamente por try-with-resources
    }

    // Método para consultar todos los productos con su categoría
    public static void listarProductos() {
        String sql = "SELECT p.nombre, p.precio, p.stock, c.nombre AS categoria " +
                     "FROM productos p " +
                     "INNER JOIN categorias c ON p.categoria_id = c.id " +
                     "ORDER BY c.nombre, p.nombre";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            // try-with-resources con múltiples recursos separados por ;

            System.out.printf("%-25s %10s %8s %-20s%n", "Producto", "Precio", "Stock", "Categoría");
            System.out.println("-".repeat(65));

            while (rs.next()) {
                // rs.next() avanza a la siguiente fila — false cuando no hay más
                String nombre    = rs.getString("nombre");
                double precio    = rs.getDouble("precio");
                int stock        = rs.getInt("stock");
                String categoria = rs.getString("categoria");

                System.out.printf("%-25s %10.2f %8d %-20s%n", nombre, precio, stock, categoria);
            }

        } catch (SQLException e) {
            System.out.println("Error al consultar: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        // Insertar algunos productos de prueba
        insertarProducto("Leche entera 1L", 25.50, 100, 1);
        insertarProducto("Manzana roja kg", 38.00, 50, 2);

        System.out.println();

        // Listar todos los productos
        listarProductos();
    }
}
```

---

## Errores comunes

1. **Crear la tabla hijo antes que la tabla padre** — MySQL lanza error de FK porque intenta referenciar una tabla que no existe. El orden importa: primero las tablas sin FK, luego las que tienen FK.

2. **Confundir `WHERE` y `HAVING`** — `WHERE` filtra filas individuales (antes de agrupar), `HAVING` filtra grupos (después de `GROUP BY`). No se pueden intercambiar. El error más común: usar `WHERE COUNT(*) > 3` — no funciona, debe ser `HAVING COUNT(*) > 3`.

3. **Olvidar el alias en JOIN** — `SELECT nombre FROM productos INNER JOIN categorias...` es ambiguo si ambas tablas tienen una columna llamada "nombre". Siempre usar aliases: `p.nombre` y `c.nombre`.

4. **`ON` vs `WHERE` en JOIN** — la condición del JOIN va en `ON p.categoria_id = c.id`, no en `WHERE`. Poner la condición en WHERE convierte el `LEFT JOIN` en `INNER JOIN` implícitamente.

5. **`executeUpdate()` vs `executeQuery()`** — `executeQuery()` para SELECT (devuelve ResultSet), `executeUpdate()` para INSERT/UPDATE/DELETE (devuelve número de filas afectadas). Confundirlos da error en tiempo de ejecución.

6. **Perder el ResultSet antes de usarlo** — si cierra el Statement o Connection antes de iterar el ResultSet, ya no puede leer los datos. Con try-with-resources, cuidar el orden de cierre.

---

## Solución SQL completa del proyecto

**01_tienda_ddl.sql** — estructura de la base de datos
```sql
CREATE DATABASE IF NOT EXISTS mi_tienda;
USE mi_tienda;

-- 1. Tabla sin dependencias: categorias
CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL    -- nombre de la categoría (Lácteos, Frutas, etc.)
);

-- 2. Tabla que depende de categorias
CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,           -- precio con 2 decimales
    stock INT DEFAULT 0,                     -- unidades disponibles, por defecto 0
    categoria_id INT,                        -- referencia a categorias.id
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
    -- Si intentas insertar un producto con categoria_id inexistente, MySQL lo rechaza
);

-- 3. Tabla sin dependencias: clientes
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(200) UNIQUE    -- UNIQUE: no puede repetirse el email
);

-- 4. Tabla que depende de clientes
CREATE TABLE ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,                          -- referencia a clientes.id
    fecha DATETIME DEFAULT NOW(),            -- fecha y hora actual por defecto
    total DECIMAL(10,2),                     -- total de la venta
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- 5. Tabla que depende de ventas Y productos (tabla de relación many-to-many)
CREATE TABLE detalle_venta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT,                            -- referencia a ventas.id
    producto_id INT,                         -- referencia a productos.id
    cantidad INT,                            -- cuántas unidades de este producto
    precio_unitario DECIMAL(10,2),           -- precio al momento de la venta (puede cambiar)
    FOREIGN KEY (venta_id) REFERENCES ventas(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);
```

**02_tienda_datos.sql** — datos de prueba
```sql
USE mi_tienda;

-- Insertar categorías (primero, porque productos las referencia)
INSERT INTO categorias (nombre) VALUES
('Lácteos'),       -- id=1
('Frutas'),        -- id=2
('Verduras'),      -- id=3
('Botanas');       -- id=4

-- Insertar 12 productos (3 por categoría)
INSERT INTO productos (nombre, precio, stock, categoria_id) VALUES
-- Lácteos (categoria_id=1)
('Leche entera 1L', 25.50, 100, 1),
('Yogur natural 500g', 32.00, 60, 1),
('Queso manchego 250g', 78.00, 30, 1),
-- Frutas (categoria_id=2)
('Manzana roja kg', 38.00, 50, 2),
('Plátano tabasco kg', 22.00, 80, 2),
('Naranja kg', 18.00, 120, 2),
-- Verduras (categoria_id=3)
('Tomate bola kg', 28.00, 70, 3),
('Cebolla blanca kg', 15.00, 90, 3),
('Aguacate pieza', 22.00, 40, 3),
-- Botanas (categoria_id=4)
('Papas fritas 45g', 18.00, 200, 4),
('Chicharrón 30g', 12.00, 150, 4),
('Galletas saladas 200g', 24.00, 80, 4);

-- Insertar 5 clientes
INSERT INTO clientes (nombre, email) VALUES
('Ana Torres', 'ana.torres@email.com'),
('Roberto Méndez', 'roberto@email.com'),
('Lucía Pérez', 'lucia.perez@email.com'),
('Fernando Ríos', 'fer.rios@email.com'),
('Carmen Salinas', 'carmen@email.com');

-- Insertar 3 ventas
INSERT INTO ventas (cliente_id, fecha, total) VALUES
(1, '2024-01-15 10:30:00', 105.50),   -- Ana compró el 15 de enero
(2, '2024-01-15 14:00:00', 234.00),   -- Roberto el mismo día por la tarde
(1, '2024-01-16 09:15:00', 56.00);    -- Ana volvió al día siguiente

-- Insertar detalles de cada venta
-- Venta 1 (Ana): leche + manzanas
INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 2, 25.50),    -- 2 leches a $25.50 c/u = $51.00
(1, 4, 1, 38.00),    -- 1 kg manzanas = $38.00
(1, 12, 1, 24.00);   -- 1 galletas = $24.00 (subtotal: $51+38+24 ≠ total por redondeo de ejemplo)

-- Venta 2 (Roberto): queso + aguacate + papas + yogur
INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario) VALUES
(2, 3, 2, 78.00),    -- 2 quesos manchego
(2, 9, 2, 22.00),    -- 2 aguacates
(2, 2, 1, 32.00),    -- 1 yogur
(2, 10, 3, 18.00);   -- 3 papas fritas

-- Venta 3 (Ana de nuevo): plátanos + tomate
INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario) VALUES
(3, 5, 1, 22.00),    -- 1 kg plátano
(3, 7, 1, 28.00),    -- 1 kg tomate
(3, 11, 1, 12.00);   -- 1 chicharrón
```

**03_tienda_consultas.sql** — las 7 consultas requeridas
```sql
USE mi_tienda;

-- CONSULTA 1: Todos los productos con el nombre de su categoría
SELECT p.nombre AS producto, p.precio, p.stock, c.nombre AS categoria
FROM productos p
INNER JOIN categorias c ON p.categoria_id = c.id
ORDER BY c.nombre, p.nombre;
-- INNER JOIN: solo productos que tienen categoría asignada
-- ON: la columna que une las tablas

-- CONSULTA 2: Productos con stock menor a 5 (alerta de inventario)
SELECT p.nombre, p.stock, c.nombre AS categoria
FROM productos p
INNER JOIN categorias c ON p.categoria_id = c.id
WHERE p.stock < 5
ORDER BY p.stock ASC;
-- Con los datos de prueba no hay productos con stock < 5
-- Puedes actualizar un producto para probar: UPDATE productos SET stock=2 WHERE id=3;

-- CONSULTA 3: Ventas con nombre del cliente y total
SELECT v.id AS venta_id, cl.nombre AS cliente, v.fecha, v.total
FROM ventas v
INNER JOIN clientes cl ON v.cliente_id = cl.id
ORDER BY v.fecha DESC;
-- Unimos ventas con clientes para ver el nombre en lugar del cliente_id

-- CONSULTA 4: Detalle de la venta 1 (producto, cantidad, precio, subtotal)
SELECT p.nombre AS producto,
       dv.cantidad,
       dv.precio_unitario,
       (dv.cantidad * dv.precio_unitario) AS subtotal   -- calculamos el subtotal
FROM detalle_venta dv
INNER JOIN productos p ON dv.producto_id = p.id
WHERE dv.venta_id = 1;   -- solo los detalles de la venta con id=1

-- CONSULTA 5: Cuántos productos hay por categoría
SELECT c.nombre AS categoria, COUNT(p.id) AS total_productos
FROM categorias c
LEFT JOIN productos p ON c.id = p.categoria_id
-- LEFT JOIN: incluye categorías aunque no tengan productos (aparecen con 0)
GROUP BY c.id, c.nombre
ORDER BY total_productos DESC;

-- CONSULTA 6: El cliente que más ha gastado (suma de todas sus ventas)
SELECT cl.nombre, SUM(v.total) AS total_gastado
FROM clientes cl
INNER JOIN ventas v ON cl.id = v.cliente_id
GROUP BY cl.id, cl.nombre   -- agrupamos por cliente para sumar sus ventas
ORDER BY total_gastado DESC  -- de mayor a menor gasto
LIMIT 1;                     -- solo el primero (el que más gastó)

-- CONSULTA 7: Los 5 productos más vendidos por cantidad total vendida
SELECT p.nombre AS producto, SUM(dv.cantidad) AS total_vendido
FROM detalle_venta dv
INNER JOIN productos p ON dv.producto_id = p.id
GROUP BY p.id, p.nombre         -- agrupamos por producto
ORDER BY total_vendido DESC      -- de más vendido a menos vendido
LIMIT 5;                         -- solo los 5 primeros
```

---

## JDBC avanzado — solución ProductoDAO.java

```java
import java.sql.*;

public class ProductoDAO {
    // Datos de conexión — ajustar contraseña según el entorno
    private static final String URL  = "jdbc:mysql://localhost:3306/mi_tienda";
    private static final String USER = "root";
    private static final String PASS = "";   // contraseña de MySQL local

    // Método para listar todos los productos con su categoría
    public static void listarProductos() {
        // SQL con JOIN para traer el nombre de categoría
        String sql = "SELECT p.nombre, p.precio, p.stock, c.nombre AS categoria " +
                     "FROM productos p " +
                     "INNER JOIN categorias c ON p.categoria_id = c.id " +
                     "ORDER BY c.nombre, p.nombre";

        // try-with-resources: cierra conn, stmt y rs automáticamente
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\n=== Catálogo de Productos ===");
            System.out.printf("%-25s %10s %8s %-15s%n", "Producto", "Precio", "Stock", "Categoría");
            System.out.println("-".repeat(60));

            while (rs.next()) {
                // getString, getDouble, getInt: obtener valor de la columna por nombre
                System.out.printf("%-25s %10.2f %8d %-15s%n",
                    rs.getString("nombre"),
                    rs.getDouble("precio"),
                    rs.getInt("stock"),
                    rs.getString("categoria"));
            }

        } catch (SQLException e) {
            System.out.println("Error al listar productos: " + e.getMessage());
        }
    }

    // Método para agregar un producto nuevo
    public static void agregarProducto(String nombre, double precio, int stock, int categoriaId) {
        // PreparedStatement con ? para los parámetros — más seguro que concatenar strings
        String sql = "INSERT INTO productos (nombre, precio, stock, categoria_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Llenar los ? en orden (1-indexed)
            ps.setString(1, nombre);       // primer ? = nombre del producto
            ps.setDouble(2, precio);       // segundo ? = precio
            ps.setInt(3, stock);           // tercer ? = stock inicial
            ps.setInt(4, categoriaId);     // cuarto ? = id de categoría

            // executeUpdate() para INSERT, UPDATE, DELETE — devuelve filas afectadas
            int filas = ps.executeUpdate();
            System.out.println("Producto '" + nombre + "' agregado. Filas: " + filas);

        } catch (SQLException e) {
            System.out.println("Error al agregar producto: " + e.getMessage());
        }
    }

    // Método para actualizar el stock de un producto
    public static void actualizarStock(int productoId, int nuevoStock) {
        String sql = "UPDATE productos SET stock = ? WHERE id = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, nuevoStock);   // primer ? = nuevo valor del stock
            ps.setInt(2, productoId);   // segundo ? = id del producto a actualizar

            int filas = ps.executeUpdate();
            if (filas > 0) {
                System.out.println("Stock actualizado para producto id=" + productoId);
            } else {
                System.out.println("No se encontró producto con id=" + productoId);
            }

        } catch (SQLException e) {
            System.out.println("Error al actualizar stock: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        System.out.println("=== Sistema de Tienda ===");

        // Listar productos actuales
        listarProductos();

        // Agregar un producto nuevo
        System.out.println("\nAgregando nuevo producto...");
        agregarProducto("Chocolate amargo 80g", 35.00, 75, 4);   // categoría 4 = Botanas

        // Actualizar stock de un producto (id=1 = Leche)
        System.out.println("\nActualizando stock de Leche...");
        actualizarStock(1, 120);

        // Volver a listar para ver los cambios
        listarProductos();
    }
}
```

---

## Criterios de calificación — Semana 12 (Proyecto Final)

| Criterio | Puntos |
|----------|--------|
| Las 5 tablas creadas con estructura correcta y FK donde corresponde | 2 pts |
| Datos de prueba: al menos 4 categorías, 12 productos, 5 clientes, 3 ventas | 1 pt |
| Las 7 consultas SQL con JOIN funcionan y devuelven resultados correctos | 5 pts |
| Reflexión final completada con respuestas personales y reflexivas | 2 pts |
| **Total** | **10 pts** |

**Puntos extra (no restan si no los tiene):**
- Si conectó Java a MySQL con JDBC y al menos un método funciona: mencionar positivamente
- Si el código Java está comentado: excelente señal de madurez como programadora

---
