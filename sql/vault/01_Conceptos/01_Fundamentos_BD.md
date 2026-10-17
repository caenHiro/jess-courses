---
tema: Fundamentos de Bases de Datos
estado: en-progreso
---

# Fundamentos de Bases de Datos

> Este módulo cubre los conceptos teóricos que te preguntarán en una entrevista para desarrolladora de base de datos.

---

## ¿Qué es un Sistema Manejador de Bases de Datos (SMBD)?

Un **SMBD** (o DBMS en inglés) es el **software** que permite crear, organizar, consultar y proteger los datos de una base de datos.

El SMBD hace el trabajo pesado: tú le dices qué quieres y él se encarga de cómo guardarlo y recuperarlo eficientemente.

Ejemplos de SMBD:
- **MySQL** — el más popular en aplicaciones web (el que usaremos)
- **PostgreSQL** — más potente, preferido para sistemas complejos
- **Oracle** — el más usado en empresas grandes (bancos, gobierno)
- **SQL Server** — de Microsoft
- **SQLite** — embebido, para apps móviles o locales

**¿Por qué no guardar datos en archivos de texto?**

Imagina guardar 10 millones de registros en un archivo `.txt`. Para buscar uno solo tendrías que leer todo el archivo de arriba a abajo. El SMBD organiza los datos con índices y estructuras especiales para que las búsquedas sean instantáneas.

---

## ¿Qué es una Base de Datos?

Una **base de datos** es una colección organizada de datos relacionados entre sí, almacenados de forma estructurada para que puedan consultarse y administrarse de manera eficiente.

Analogía: una base de datos es como un archivo físico de una empresa — carpetas organizadas, con expedientes etiquetados, donde puedes encontrar cualquier documento rápidamente.

---

## ¿Qué es una Base de Datos Relacional?

Una **base de datos relacional** organiza los datos en **tablas** (también llamadas relaciones), y esas tablas pueden estar conectadas entre sí.

Por ejemplo, en un sistema de empleados:
- Una tabla `empleados` guarda los datos personales
- Una tabla `departamentos` guarda los departamentos
- Las dos tablas se **relacionan**: cada empleado pertenece a un departamento

Esto evita duplicar información. En lugar de escribir "Sistemas" en cada fila de empleado, solo guardas un número que apunta a la tabla de departamentos donde dice "Sistemas".

---

## ¿Qué es una Tabla?

Una **tabla** es la unidad básica de almacenamiento en una base de datos relacional.

- Cada **fila** (registro) representa un elemento (un empleado, un producto, un pedido)
- Cada **columna** (campo/atributo) representa una característica (nombre, edad, salario)

```
┌──────────────┬────────────┬───────────┬──────────┐
│ id_empleado  │  nombre    │ apellido  │ salario  │
├──────────────┼────────────┼───────────┼──────────┤
│      1       │ Carlos     │ Mendoza   │ 95000.00 │
│      2       │ Ana        │ García    │ 88000.00 │
│      3       │ Roberto    │ Sánchez   │ 92000.00 │
└──────────────┴────────────┴───────────┴──────────┘
```

---

## Tipos de Integridad

La **integridad** garantiza que los datos sean correctos, consistentes y válidos. Hay cuatro tipos:

### 1. Integridad de Entidad

Cada fila debe ser **única** e identificable. Esto se logra con la **Llave Primaria (Primary Key)**.

- No puede ser `NULL`
- No puede repetirse
- Identifica de forma única cada registro

```sql
id_empleado INT PRIMARY KEY AUTO_INCREMENT
```

### 2. Integridad Referencial

Las relaciones entre tablas deben ser **consistentes**. Si un empleado pertenece al departamento 5, ese departamento debe existir.

Esto se logra con las **Llaves Foráneas (Foreign Key)**.

```sql
FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
```

Si intentas insertar un empleado con `id_departamento = 99` pero ese departamento no existe, MySQL lo rechaza.

### 3. Integridad de Dominio

Los valores de una columna deben estar dentro del **rango o tipo correcto**.

- `salario DECIMAL(10,2)` — solo acepta números decimales
- `email VARCHAR(150)` — máximo 150 caracteres
- `activo TINYINT(1) DEFAULT 1` — solo 0 o 1
- `ENUM('activo','finalizado','cancelado')` — solo esos tres valores

### 4. Integridad de Usuario (Reglas de Negocio)

Restricciones específicas del negocio:
- El salario no puede ser negativo
- Un gerente no puede tener salario menor que sus subordinados
- Una fecha de fin no puede ser anterior a la fecha de inicio

---

## Constraints (Restricciones)

Los **constraints** son reglas que se aplican a las columnas para mantener la integridad de los datos.

| Constraint       | Qué hace                                        | Ejemplo                        |
| ---------------- | ----------------------------------------------- | ------------------------------ |
| `PRIMARY KEY`    | Identifica cada fila de forma única             | `id INT PRIMARY KEY`           |
| `FOREIGN KEY`    | Relaciona dos tablas                            | `REFERENCES departamentos(id)` |
| `NOT NULL`       | La columna no puede estar vacía                 | `nombre VARCHAR(100) NOT NULL` |
| `UNIQUE`         | No permite valores repetidos                    | `email VARCHAR(150) UNIQUE`    |
| `DEFAULT`        | Valor por defecto si no se especifica           | `activo TINYINT DEFAULT 1`     |
| `CHECK`          | Valida que el valor cumpla una condición        | `CHECK (salario > 0)`          |
| `AUTO_INCREMENT` | Genera un número automático incremental (MySQL) | `id INT AUTO_INCREMENT`        |

---

## Relaciones entre Tablas

### Uno a Muchos (1:N) — la más común

Un departamento tiene muchos empleados. Muchos empleados pertenecen a un departamento.

```
departamentos (1) ──── (N) empleados
```

Se implementa poniendo la FK en el lado "muchos": `empleados.id_departamento`.

### Muchos a Muchos (N:M)

Un empleado puede estar en varios proyectos. Un proyecto puede tener varios empleados.

Se implementa con una **tabla intermedia**:
```
empleados (N) ──── empleado_proyecto ──── (M) proyectos
```

### Uno a Uno (1:1)

Un empleado tiene exactamente un expediente. Poco común — normalmente se fusionan en una sola tabla.

---

## Resumen de conceptos

| Término       | Definición corta                                     |
| ------------- | ---------------------------------------------------- |
| SMBD          | Software que gestiona la base de datos               |
| Base de datos | Colección organizada de datos                        |
| BD Relacional | Datos en tablas que se pueden relacionar entre sí    |
| Tabla         | Filas y columnas que guardan un tipo de dato         |
| Integridad    | Reglas que garantizan datos correctos y consistentes |
| Primary Key   | Identificador único de cada fila                     |
| Foreign Key   | Referencia que conecta dos tablas                    |
| Constraint    | Restricción que define reglas sobre los datos        |

---

> Siguiente: [[02_DDL]] — crear tablas con SQL
