---
tema: Descripción de la base de datos de práctica
estado: en-progreso
---

# Base de Datos de Práctica — Sistema de Recursos Humanos

> Antes de resolver las consultas, necesitas entender el esquema. Tómate 5 minutos para leer esto — te ahorrará mucho tiempo después.

---

## Tablas del sistema

### `departamentos`

Almacena los departamentos de la empresa.

| Columna           | Tipo    | Descripción             |
| ----------------- | ------- | ----------------------- |
| `id_departamento` | INT PK  | Identificador único     |
| `nombre`          | VARCHAR | Nombre del departamento |
| `ubicacion`       | VARCHAR | Dónde está físicamente  |
| `presupuesto`     | DECIMAL | Presupuesto anual       |

---

### `puestos`

Catálogo de puestos disponibles con sus rangos de salario.

| Columna         | Tipo    | Descripción                   |
| --------------- | ------- | ----------------------------- |
| `id_puesto`     | INT PK  | Identificador único           |
| `nombre_puesto` | VARCHAR | Nombre del puesto             |
| `salario_min`   | DECIMAL | Salario mínimo para el puesto |
| `salario_max`   | DECIMAL | Salario máximo para el puesto |

---

### `empleados`

El corazón del sistema. Cada fila es un empleado.

| Columna              | Tipo           | Descripción                                  |
| -------------------- | -------------- | -------------------------------------------- |
| `id_empleado`        | INT PK         | Identificador único                          |
| `nombre`             | VARCHAR        | Nombre                                       |
| `apellido`           | VARCHAR        | Apellido                                     |
| `email`              | VARCHAR UNIQUE | Correo (único)                               |
| `fecha_contratacion` | DATE           | Cuándo entró a la empresa                    |
| `salario`            | DECIMAL        | Salario mensual                              |
| `id_departamento`    | INT FK         | Qué departamento → `departamentos`           |
| `id_puesto`          | INT FK         | Qué puesto → `puestos`                       |
| `id_jefe`            | INT FK         | Quién es su jefe → `empleados` (mismo tabla) |
| `activo`             | TINYINT        | 1 = activo, 0 = dado de baja                 |

---

### `proyectos`

Proyectos activos o finalizados de la empresa.

| Columna                 | Tipo    | Descripción                         |
| ----------------------- | ------- | ----------------------------------- |
| `id_proyecto`           | INT PK  | Identificador único                 |
| `nombre`                | VARCHAR | Nombre del proyecto                 |
| `fecha_inicio`          | DATE    | Cuándo inició                       |
| `fecha_fin`             | DATE    | Cuándo termina/terminó              |
| `estado`                | ENUM    | `activo`, `finalizado`, `cancelado` |
| `id_departamento_lider` | INT FK  | Departamento responsable            |

---

### `empleado_proyecto`

Tabla de relación N:M — un empleado puede estar en varios proyectos, un proyecto puede tener varios empleados.

| Columna           | Tipo      | Descripción                                     |
| ----------------- | --------- | ----------------------------------------------- |
| `id_empleado`     | INT PK+FK | Empleado                                        |
| `id_proyecto`     | INT PK+FK | Proyecto                                        |
| `horas_asignadas` | INT       | Horas dedicadas al proyecto                     |
| `rol`             | VARCHAR   | Rol en el proyecto (Líder, Desarrollador, etc.) |

---

### `historial_salarios`

Se llena automáticamente con el trigger `trg_historial_salario` cuando un salario cambia.

| Columna            | Tipo     | Descripción            |
| ------------------ | -------- | ---------------------- |
| `id_historial`     | INT PK   | Identificador único    |
| `id_empleado`      | INT FK   | De quién fue el cambio |
| `salario_anterior` | DECIMAL  | Cuánto ganaba antes    |
| `salario_nuevo`    | DECIMAL  | Cuánto gana ahora      |
| `fecha_cambio`     | DATETIME | Cuándo fue el cambio   |

---

## Diagrama de relaciones

```
departamentos ──┬── empleados ──┬── empleado_proyecto ── proyectos
                │               └── empleados (jefe)
puestos ────────┘
                                empleados ── historial_salarios
```

---

## Datos de prueba incluidos

| Tabla                | Registros                         |
| -------------------- | --------------------------------- |
| `departamentos`      | 5                                 |
| `puestos`            | 6                                 |
| `empleados`          | 15                                |
| `proyectos`          | 5                                 |
| `empleado_proyecto`  | 16                                |
| `historial_salarios` | (vacía — se llena con el trigger) |

---

> Siguiente: [[01_Consultas]] — 10 consultas intermedias para practicar
