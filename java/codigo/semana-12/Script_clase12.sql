CREATE TABLE categorias ( 
id INT PRIMARY KEY AUTO_INCREMENT, 
nombre VARCHAR(100) NOT NULL );

CREATE TABLE productos (
id INT PRIMARY KEY  AUTO_INCREMENT,
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
('Pepita  kg', 22.00, 80, 1),
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