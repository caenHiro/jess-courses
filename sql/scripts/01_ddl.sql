-- =============================================================
-- DDL — Sistema de Recursos Humanos
-- Base de datos: rrhh
-- MySQL 8.0
-- =============================================================

CREATE DATABASE IF NOT EXISTS rrhh
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE rrhh;

-- -------------------------------------------------------------
-- Tabla: departamentos
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS departamentos (
    id_departamento INT            NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(100)   NOT NULL,
    ubicacion       VARCHAR(100),
    presupuesto     DECIMAL(15,2),
    CONSTRAINT pk_departamentos PRIMARY KEY (id_departamento)
);

-- -------------------------------------------------------------
-- Tabla: puestos
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS puestos (
    id_puesto    INT            NOT NULL AUTO_INCREMENT,
    nombre_puesto VARCHAR(100)  NOT NULL,
    salario_min  DECIMAL(10,2),
    salario_max  DECIMAL(10,2),
    CONSTRAINT pk_puestos PRIMARY KEY (id_puesto)
);

-- -------------------------------------------------------------
-- Tabla: empleados
-- Referencia a sí misma en id_jefe (autoreferencia)
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS empleados (
    id_empleado        INT           NOT NULL AUTO_INCREMENT,
    nombre             VARCHAR(100)  NOT NULL,
    apellido           VARCHAR(100)  NOT NULL,
    email              VARCHAR(150)  NOT NULL,
    fecha_contratacion DATE          NOT NULL,
    salario            DECIMAL(10,2) NOT NULL,
    id_departamento    INT,
    id_puesto          INT,
    id_jefe            INT,
    activo             TINYINT(1)    NOT NULL DEFAULT 1,
    CONSTRAINT pk_empleados         PRIMARY KEY (id_empleado),
    CONSTRAINT uq_email             UNIQUE      (email),
    CONSTRAINT fk_emp_departamento  FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento),
    CONSTRAINT fk_emp_puesto        FOREIGN KEY (id_puesto)       REFERENCES puestos(id_puesto),
    CONSTRAINT fk_emp_jefe          FOREIGN KEY (id_jefe)         REFERENCES empleados(id_empleado)
);

-- -------------------------------------------------------------
-- Tabla: proyectos
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS proyectos (
    id_proyecto           INT          NOT NULL AUTO_INCREMENT,
    nombre                VARCHAR(200) NOT NULL,
    fecha_inicio          DATE,
    fecha_fin             DATE,
    estado                ENUM('activo','finalizado','cancelado') NOT NULL DEFAULT 'activo',
    id_departamento_lider INT,
    CONSTRAINT pk_proyectos    PRIMARY KEY (id_proyecto),
    CONSTRAINT fk_proy_depto   FOREIGN KEY (id_departamento_lider) REFERENCES departamentos(id_departamento)
);

-- -------------------------------------------------------------
-- Tabla: empleado_proyecto (relación N:M)
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS empleado_proyecto (
    id_empleado    INT          NOT NULL,
    id_proyecto    INT          NOT NULL,
    horas_asignadas INT,
    rol            VARCHAR(100),
    CONSTRAINT pk_emp_proyecto PRIMARY KEY (id_empleado, id_proyecto),
    CONSTRAINT fk_ep_empleado  FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    CONSTRAINT fk_ep_proyecto  FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto)
);

-- -------------------------------------------------------------
-- Tabla: historial_salarios
-- Se llena automáticamente con el trigger trg_historial_salario
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS historial_salarios (
    id_historial    INT           NOT NULL AUTO_INCREMENT,
    id_empleado     INT           NOT NULL,
    salario_anterior DECIMAL(10,2),
    salario_nuevo   DECIMAL(10,2),
    fecha_cambio    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_historial     PRIMARY KEY (id_historial),
    CONSTRAINT fk_hist_empleado FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);
