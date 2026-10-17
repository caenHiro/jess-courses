---
title: Curso Express SQL — Inicio
tags:
  - sql
  - mysql
  - curso
date: 2026-06-19
---

# Curso Express SQL

Curso de preparación para entrevista técnica de desarrolladora de base de datos.

> No te preocupes si algo se siente difícil al principio — todos los temas tienen ejemplos paso a paso. Lee con calma y ejecuta cada consulta en DBeaver para que lo veas funcionar.

---

## Ruta de aprendizaje

### 1. Levanta el entorno
Antes de estudiar teoria, ten MySQL corriendo en Docker y DBeaver conectado.

- [[02_Setup/01_Docker_MySQL|Levantar MySQL con Docker]]
- [[02_Setup/02_DBeaver|Conectar DBeaver]]

### 2. Teoria — estudia en este orden

Cada nota tiene ejemplos que puedes ejecutar directamente en DBeaver.

| Nota | Tema | Por qué importa |
|---|---|---|
| [[01_Conceptos/01_Fundamentos_BD]] | SMBD, BD relacional, tablas, constraints | La base de todo |
| [[01_Conceptos/02_DDL]] | CREATE, ALTER, DROP | Crear y modificar tablas |
| [[01_Conceptos/03_DML]] | INSERT, UPDATE, DELETE | Manipular datos |
| [[01_Conceptos/04_Procedimientos_Almacenados]] | DELIMITER, CALL, IN/OUT | Lógica en la BD |
| [[01_Conceptos/05_Disparadores]] | BEFORE/AFTER, NEW/OLD | Automatizar acciones |
| [[01_Conceptos/06_Consultas_SELECT_y_Funciones]] | SELECT, WHERE, GROUP BY, HAVING, agregaciones | Para los ejercicios |
| [[01_Conceptos/07_Normalizacion_y_Formas_Normales]] | 1FN, 2FN, 3FN, desnormalizacion | Pregunta de entrevista frecuente |
| [[01_Conceptos/08_ACID_y_Transacciones]] | ACID, BEGIN, COMMIT, ROLLBACK | Pregunta de entrevista frecuente |
| [[01_Conceptos/09_JSON_en_BD]] | JSON en MySQL, JSONB en PostgreSQL | Tema moderno en entrevistas |
| [[01_Conceptos/10_MySQL_vs_PostgreSQL]] | Diferencias, WHERE vs HAVING, SUBSTRING | Salió en entrevista real |
| [[01_Conceptos/11_DDD_Microservicios_y_Arquitectura]] | DDD, Bounded Context, Microservicios, MVC | Salió en entrevista real |

### 3. Crea la base de datos

Ejecuta los scripts en DBeaver en este orden:

```
scripts/01_ddl.sql            -- crea las tablas
scripts/02_dml.sql            -- inserta los datos de prueba
scripts/03_procedimientos.sql
scripts/04_disparadores.sql
```

### 4. Resuelve los ejercicios

Lee primero [[03_Ejercicios/00_Descripcion_BD]] para entender el modelo de datos.

| Ejercicios | Nivel | Temas | Soluciones |
|---|---|---|---|
| [[03_Ejercicios/01_Consultas_Basicas]] | Basico | SELECT, WHERE, ORDER BY, LIKE, BETWEEN, IN, primer JOIN | `scripts/05_consultas_basicas_solucion.sql` |
| [[03_Ejercicios/02_Consultas_Intermedias]] | Intermedio | GROUP BY, HAVING, subconsultas, JOINs multiples | `scripts/06_consultas_intermedias_solucion.sql` |

> Intenta resolver cada consulta tú sola antes de ver la solución. Si no te sale, no hay problema — revisa la teoría del tema indicado y vuelve a intentarlo.

### 5. Prepara la entrevista

Repasa las preguntas que salieron en entrevistas reales:

| Archivo | Contenido |
|---|---|
| [[04_Entrevista/01_Preguntas_Teoria]] | Normalización, ACID, JSON, DDD, microservicios |
| [[04_Entrevista/02_Preguntas_SQL]] | JOINs, GROUP BY, subconsultas, SUBSTRING, diseño de tablas |

---

## Estructura del vault

```
vault/
├── 00_Inicio.md              <-- estas aqui
├── 01_Conceptos/             teoria completa (11 temas)
├── 02_Setup/                 como levantar Docker y conectar DBeaver
├── 03_Ejercicios/            ejercicios basicos e intermedios con soluciones
└── 04_Entrevista/            preguntas reales de entrevista con respuestas
```

---

## Conexion a la base de datos

| Campo | Valor |
|---|---|
| Host | `localhost` |
| Puerto | `3306` |
| Base de datos | `rrhh` |
| Usuario | `root` |
| Password | `rrhh2025` |
