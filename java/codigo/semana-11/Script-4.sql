CREATE DATABASE IF NOT EXISTS mi_escuela;
USE mi_escuela;

CREATE TABLE  if not EXISTS estudiantes ( 
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
edad INT,
carrera VARCHAR(100),
promedio DECIMAL(4,2),
fecha_ingreso DATE
);

INSERT INTO estudiantes (nombre, edad, carrera, promedio, fecha_ingreso) VALUES 
('Jessica Escalona', 22, 'Ingeniería en Sistemas', 9.2, '2022-08-15'),
('Carlos Pérez', 25, 'Ciencias de la Computación', 8.51, '2021-01-10'),
('María López', 20, 'Ingeniería en Sistemas', 9.2, '2023-08-20'),
('Pedro Ramírez', 23, 'Administración', 7.56, '2021-08-15'),
('Ana García', 21, 'Contaduría', 8.0, '2022-01-12'),
('Luis Torres', 24, 'Ingeniería en Sistemas', 6.58, '2020-08-18'),
('Sofia Mendoza', 22, 'Ciencias de la Computación', 9.5, '2022-08-15'),
('Miguel Sánchez', 26, 'Administración', 7.03, '2019-08-20');

SELECT * FROM estudiantes;
SELECT nombre, promedio FROM  estudiantes order BY  promedio desc; 
SELECT * FROM estudiantes WHERE promedio >= 9;   
SELECT * FROM estudiantes WHERE carrera = 'Ingeniería en Sistemas';
SELECT COUNT(*) AS total_estudiantes FROM  estudiantes ;
SELECT AVG(promedio) AS promedio_total FROM estudiantes;
SELECT nombre, promedio FROM estudiantes ORDER BY promedio DESC LIMIT 1;
SELECT * FROM estudiantes WHERE nombre LIKE '%a%'; 
