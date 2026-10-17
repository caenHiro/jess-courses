---
semana: 12
tema: Proyecto Final — Sistema de Tienda
estado: pendiente
---

# Práctica — Semana 12: Proyecto Final

> Guarda todo en: `codigo/semana-12/`
> Al terminar: `bash scripts/push.sh "semana-12 proyecto-final COMPLETADO"`

---

## Proyecto: Sistema de Tienda

Este es tu proyecto de cierre. Vas a crear desde cero la base de datos de una tienda pequeña con todo lo que aprendiste.

---

## Parte 1 — Base de datos (SQL)

Archivo: `codigo/semana-12/01_tienda_ddl.sql`

Crea las siguientes tablas con sus relaciones:
- `categorias` (id, nombre)
- `productos` (id, nombre, precio, stock, categoria_id → FK a categorias)
- `clientes` (id, nombre, email)
- `ventas` (id, cliente_id → FK, fecha, total)
- `detalle_venta` (id, venta_id → FK, producto_id → FK, cantidad, precio_unitario)

Archivo: `codigo/semana-12/02_tienda_datos.sql`

Inserta datos de prueba:
- Al menos 4 categorías
- Al menos 12 productos (3 por categoría)
- Al menos 5 clientes
- Al menos 3 ventas con sus detalles

```java
CREATE TABLE categorias (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL );

CREATE TABLE productos (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL ,
precio DECIMAL(10,2) NOT NULL,
stock INT DEFAULT 0 ,
categoria_id INT,
FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);


CREATE TABLE clientes (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL ,
email VARCHAR(50) UNIQUE
);

CREATE TABLE ventas (
id INT PRIMARY KEY AUTO_INCREMENT ,
cliente_id INT,
fecha DATETIME DEFAULT NOW(),
total DECIMAL(10,2),
FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);


CREATE TABLE detalle_venta (
id INT PRIMARY KEY AUTO_INCREMENT ,
venta_id INT ,
producto_id INT,
cantidad INT,
precio_unitario DECIMAL(10,2),
FOREIGN KEY (venta_id) REFERENCES ventas(id),
FOREIGN KEY (producto_id) REFERENCES productos(id)

);

  

USE mi_tienda;


INSERT INTO categorias (nombre) values

('Semillas'),
('Lacteos'),
('Verduras'),
('Frutas');


INSERT INTO productos (nombre, precio, stock, categoria_id ) VALUES

('Leche entera 1L', 25.50, 100, 2),
('Yogur natural 500g', 32.00, 60, 2),
('Queso manchego 250g', 78.00, 30, 2),

('Ajonjoli kg', 38.00, 50, 1),

('Pepita kg', 22.00, 80, 1),

('Semilla de girasol Kg', 18.00, 120, 1),

  

('Tomate bola kg', 28.00, 70, 3),

('Cebolla blanca kg', 15.00, 90, 3),

('Papas kg', 22.00, 40, 3),

  

('Papaya kg', 18.00, 200, 4),

('Fresa kg', 12.00, 150, 4),

('Manzana kg', 24.00, 80, 4);

  

  

INSERT INTO clientes (nombre, email) VALUES

('Ana Torres', 'ana.torres@email.com'),

('Roberto Méndez', 'roberto@email.com'),

('Lucía Pérez', 'lucia.perez@email.com'),

('Fernando Ríos', 'fer.rios@email.com'),

('Carmen Salinas', 'carmen@email.com');

  

INSERT INTO ventas (cliente_id, fecha, total) VALUES

(1, '2024-01-15 10:30:00', 105.50),

(2, '2024-01-15 14:00:00', 234.00),

(1, '2024-01-16 09:15:00', 56.00);

  

  

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario) VALUES

(1, 1, 2, 25.50),

(1, 4, 1, 38.00),

(1, 12, 1, 24.00);

  

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario) VALUES

(2, 3, 2, 78.00),

(2, 9, 2, 22.00),

(2, 2, 1, 32.00),

(2, 10, 3, 18.00);

  

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario) VALUES

(3, 5, 1, 22.00),

(3, 7, 1, 28.00),

(3, 11, 1, 12.00);
```

---

## Parte 2 — Consultas con JOIN (SQL)

Archivo: `codigo/semana-12/03_tienda_consultas.sql`

Escribe las siguientes consultas:

1. Listar todos los productos con el nombre de su categoría
2. Ver los productos con stock menor a 5 (alerta de inventario)
3. Ver las ventas con el nombre del cliente y el total
4. Ver el detalle de una venta específica (producto, cantidad, precio, subtotal)
5. Ver cuántos productos hay por categoría
6. Ver el cliente que más ha gastado (total acumulado de sus ventas)
7. Ver los 5 productos más vendidos (por cantidad total)

---

## Parte 3 — Clase Java conectada a MySQL (opcional/reto)

Archivo: `codigo/semana-12/ProductoDAO.java`

Si quieres conectar Java con la BD:

```java
import java.sql.*;

public class ProductoDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/mi_tienda";
    private static final String USER = "root";
    private static final String PASS = "tu_password";

    public static void main(String[] args) throws Exception {
        Connection conn = DriverManager.getConnection(URL, USER, PASS);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM productos");

        while (rs.next()) {
            System.out.println(rs.getString("nombre") + " - $" + rs.getDouble("precio"));
        }
        conn.close();
    }
}
```

---

## Reflexión final del curso

**¿Qué fue lo que más te gustó aprender en estos 90 días?**

_Tu respuesta:_

**¿Qué fue lo más difícil y cómo lo superaste?**

_Tu respuesta:_

**¿Qué quieres aprender después?**

_Tu respuesta:_

**¿Sientes que puedes leer código Java de alguien más y entender qué hace?**

_Tu respuesta:_

---

> Felicidades por completar el curso. Este es solo el comienzo.
