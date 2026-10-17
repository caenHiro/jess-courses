# Curso Express SQL — Preparación Entrevista

Curso intensivo de SQL con MySQL orientado a entrevista técnica para desarrolladora de base de datos.

## Contenido

- Fundamentos de base de datos relacional
- DDL y DML completo
- Procedimientos almacenados con IN/OUT/INOUT
- Disparadores BEFORE/AFTER con validacion y auditoría
- 10 consultas intermedias con modelo de empleados

## Requisitos previos

- Docker instalado
- DBeaver Community instalado

## Como empezar

1. Levanta MySQL: `docker start mysql-rrhh` (o crea el contenedor — ver `alumno/vault/02_Setup/01_Docker_MySQL.md`)
2. Abre DBeaver y conecta a `localhost:3306` con usuario `root` / contraseña `rrhh2025`
3. Ejecuta los scripts en orden:

```bash
# En DBeaver, ejecuta uno por uno:
scripts/01_ddl.sql
scripts/02_dml.sql
scripts/03_procedimientos.sql
scripts/04_disparadores.sql
```

4. Abre el vault en Obsidian apuntando a `alumno/vault/`
5. Empieza en `alumno/vault/00_Inicio.md`

## Estructura

```
curso-jess-sql/
├── README.md
├── alumno/
│   └── vault/
│       ├── 00_Inicio.md
│       ├── 01_Conceptos/
│       │   ├── 01_Fundamentos_BD.md
│       │   ├── 02_DDL.md
│       │   ├── 03_DML.md
│       │   ├── 04_Procedimientos_Almacenados.md
│       │   └── 05_Disparadores.md
│       ├── 02_Setup/
│       │   ├── 01_Docker_MySQL.md
│       │   └── 02_DBeaver.md
│       └── 03_Ejercicios/
│           ├── 00_Descripcion_BD.md
│           └── 01_Consultas.md
└── scripts/
    ├── 01_ddl.sql
    ├── 02_dml.sql
    ├── 03_procedimientos.sql
    ├── 04_disparadores.sql
    └── 05_consultas_solucion.sql
```

## Base de datos: rrhh

Modelo de Recursos Humanos con 6 tablas:

- `departamentos` — 5 registros
- `puestos` — 6 registros con rangos salariales
- `empleados` — 15 registros con jerarquía (autorreferencia)
- `proyectos` — 5 registros
- `empleado_proyecto` — relacion N:M con rol y horas
- `historial_salarios` — se llena automaticamente por trigger
