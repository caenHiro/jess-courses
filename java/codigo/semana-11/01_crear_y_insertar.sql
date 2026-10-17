-- ============================================================
-- Semana 11 — Ejercicio 1: Crear tabla e insertar datos
-- Base de datos: mi_escuela
-- ============================================================

USE mi_escuela;

-- Eliminar tabla si ya existe (para poder correr este script varias veces)
DROP TABLE IF EXISTS estudiantes;

-- Crear tabla estudiantes
CREATE TABLE estudiantes (
    id            INT           PRIMARY KEY AUTO_INCREMENT,
    nombre        VARCHAR(100)  NOT NULL,
    edad          INT,
    carrera       VARCHAR(100),
    promedio      DECIMAL(4,2),
    fecha_ingreso DATE
);

-- Insertar 10 estudiantes con datos variados
INSERT INTO estudiantes (nombre, edad, carrera, promedio, fecha_ingreso) VALUES
('Ana Torres',        22, 'Ingeniería en Sistemas',    9.5,  '2023-08-15'),
('Carlos Mendoza',    25, 'Contabilidad',              7.8,  '2022-01-10'),
('Jessica Ramírez',   21, 'Ingeniería en Sistemas',    9.1,  '2023-08-15'),
('Luis Pérez',        23, 'Administración',            6.5,  '2021-08-20'),
('María Gutiérrez',   20, 'Ingeniería en Sistemas',    8.4,  '2024-01-17'),
('Roberto Salinas',   24, 'Contabilidad',              9.8,  '2022-08-10'),
('Diana Flores',      22, 'Administración',            7.2,  '2023-01-15'),
('Ernesto Vázquez',   26, 'Ingeniería en Sistemas',    6.0,  '2020-08-18'),
('Sofía Herrera',     21, 'Derecho',                   8.9,  '2023-08-15'),
('Miguel Ángel Ruiz', 23, 'Derecho',                   7.5,  '2022-01-12');

-- Verificar que los datos quedaron bien
SELECT * FROM estudiantes;
