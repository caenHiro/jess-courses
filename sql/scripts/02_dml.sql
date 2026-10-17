-- =============================================================
-- DML — Datos de práctica: Sistema de Recursos Humanos
-- Ejecutar DESPUÉS de 01_ddl.sql
-- =============================================================

USE rrhh;

-- -------------------------------------------------------------
-- departamentos
-- -------------------------------------------------------------
INSERT INTO departamentos (nombre, ubicacion, presupuesto) VALUES
('Sistemas',          'CDMX - Edificio Central', 2500000.00),
('Recursos Humanos',  'CDMX - Edificio B',       800000.00),
('Logística',         'Estado de México',         1200000.00),
('Jurídico',          'CDMX - Edificio Central',  950000.00),
('Finanzas',          'CDMX - Edificio Central',  1800000.00);

-- -------------------------------------------------------------
-- puestos
-- -------------------------------------------------------------
INSERT INTO puestos (nombre_puesto, salario_min, salario_max) VALUES
('Analista Junior',          15000.00,  20000.00),
('Analista Senior',          22000.00,  35000.00),
('Desarrollador',            25000.00,  45000.00),
('Gerente',                  50000.00,  80000.00),
('Director',                 80000.00, 120000.00),
('Auxiliar Administrativo',  10000.00,  15000.00);

-- -------------------------------------------------------------
-- empleados
-- Los directores (id_jefe = NULL) se insertan primero
-- -------------------------------------------------------------
INSERT INTO empleados (nombre, apellido, email, fecha_contratacion, salario, id_departamento, id_puesto, id_jefe) VALUES
-- Directores (sin jefe)
('Carlos',   'Mendoza Ruiz',    'c.mendoza@empresa.com',  '2018-01-15', 95000.00, 1, 5, NULL),
('Ana',      'García López',    'a.garcia@empresa.com',   '2018-03-20', 88000.00, 2, 5, NULL),
('Roberto',  'Sánchez Torres',  'r.sanchez@empresa.com',  '2019-06-01', 92000.00, 3, 5, NULL),
-- Gerentes
('Laura',    'Martínez Díaz',   'l.martinez@empresa.com', '2020-02-10', 58000.00, 1, 4, 1),
('Miguel',   'Flores Jiménez',  'm.flores@empresa.com',   '2020-07-15', 55000.00, 2, 4, 2),
('Patricia', 'Ramírez Vega',    'p.ramirez@empresa.com',  '2021-01-05', 56000.00, 5, 4, NULL),
-- Desarrolladores y Analistas
('Javier',   'Hernández Cruz',  'j.hernandez@empresa.com','2021-03-22', 35000.00, 1, 3, 4),
('Sofía',    'Torres Morales',  's.torres@empresa.com',   '2021-08-10', 28000.00, 1, 2, 4),
('Diego',    'López Fuentes',   'd.lopez@empresa.com',    '2022-02-01', 32000.00, 1, 3, 4),
('Valeria',  'Castro Méndez',   'v.castro@empresa.com',   '2022-05-15', 24000.00, 2, 1, 5),
('Rodrigo',  'Vargas Estrada',  'r.vargas@empresa.com',   '2022-09-01', 22000.00, 3, 1, 3),
('Daniela',  'Moreno Reyes',    'd.moreno@empresa.com',   '2023-01-10', 18000.00, 4, 1, NULL),
('Felipe',   'Aguilar Suárez',  'f.aguilar@empresa.com',  '2023-04-20', 26000.00, 5, 2, 6),
('Carmen',   'Jiménez Ortiz',   'c.jimenez@empresa.com',  '2023-07-01', 12000.00, 2, 6, 5),
('Eduardo',  'Ríos Peña',       'e.rios@empresa.com',     '2024-01-15', 16000.00, 3, 6, 3);

-- -------------------------------------------------------------
-- proyectos
-- -------------------------------------------------------------
INSERT INTO proyectos (nombre, fecha_inicio, fecha_fin, estado, id_departamento_lider) VALUES
('Migración Sistema Electoral v2',   '2024-01-15', '2024-12-31', 'activo',     1),
('Auditoría de Nóminas Q1 2025',     '2025-01-01', '2025-03-31', 'activo',     5),
('Capacitación RRHH Nacional',       '2024-06-01', '2024-09-30', 'finalizado', 2),
('Análisis Legal Marco Normativo',   '2025-02-01', '2025-06-30', 'activo',     4),
('Sistema de Logística Digital',     '2023-09-01', '2024-03-31', 'finalizado', 3);

-- -------------------------------------------------------------
-- empleado_proyecto
-- -------------------------------------------------------------
INSERT INTO empleado_proyecto (id_empleado, id_proyecto, horas_asignadas, rol) VALUES
-- Proyecto 1: Migración Sistema Electoral v2
(1,  1, 80,  'Sponsor'),
(4,  1, 200, 'Líder Técnico'),
(7,  1, 320, 'Desarrollador Principal'),
(8,  1, 240, 'Analista'),
(9,  1, 280, 'Desarrollador'),
-- Proyecto 2: Auditoría de Nóminas
(6,  2, 100, 'Responsable'),
(13, 2, 200, 'Analista Financiero'),
-- Proyecto 3: Capacitación RRHH
(2,  3, 60,  'Sponsor'),
(5,  3, 180, 'Coordinador'),
(10, 3, 120, 'Facilitador'),
(14, 3, 100, 'Apoyo Administrativo'),
-- Proyecto 4: Análisis Legal
(12, 4, 150, 'Analista Legal'),
(7,  4, 40,  'Consultor Técnico'),    -- Javier en 2 proyectos
-- Proyecto 5: Logística Digital
(3,  5, 80,  'Sponsor'),
(11, 5, 200, 'Coordinador'),
(15, 5, 160, 'Apoyo Operativo');
