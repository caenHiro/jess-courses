---
tema: Normalización y Formas Normales
estado: completo
---

# Normalización y Formas Normales

> Este tema salió directo en la entrevista. Es más conceptual que práctico — te van a preguntar qué es y dar un ejemplo.

---

## ¿Qué es la normalización?

Es el proceso de **organizar las tablas de una base de datos** para evitar que la misma información esté repetida en varios lugares y para que los datos no se puedan corromper fácilmente.

Imagina que tienes una tabla así:

| empleado | departamento | telefono_depto | jefe_depto |
|---|---|---|---|
| Laura    | Sistemas     | 5512345678     | Carlos     |
| Javier   | Sistemas     | 5512345678     | Carlos     |
| Ana      | RRHH         | 5598765432     | Patricia   |

**Problema:** si el teléfono de Sistemas cambia, tienes que actualizarlo en CADA fila de cada empleado de ese departamento. Si te olvidas de una, los datos quedan inconsistentes.

La normalización resuelve esto separando la información en tablas distintas.

---

## 1FN — Primera Forma Normal

**Regla:** Cada celda debe tener **un solo valor** (valores atómicos). No puede haber listas ni grupos dentro de una celda.

**Mal (viola 1FN):**

| empleado | telefonos                    |
|---|---|
| Laura    | 5512345678, 5598765432       |
| Javier   | 5587654321                   |

La columna `telefonos` tiene múltiples valores en una celda.

**Bien (cumple 1FN):**

| empleado | telefono    |
|---|---|
| Laura    | 5512345678  |
| Laura    | 5598765432  |
| Javier   | 5587654321  |

Un valor por celda. Si hay múltiples teléfonos, se crean múltiples filas.

---

## 2FN — Segunda Forma Normal

**Regla:** Cumplir 1FN + cada columna que no es PK debe depender de **toda** la clave primaria, no solo de una parte.

Esto aplica cuando la PK es **compuesta** (más de una columna).

**Ejemplo con la tabla `empleado_proyecto`:**

La PK es `(id_empleado, id_proyecto)`. Ahora imagina que agregas la columna `nombre_empleado`:

| id_empleado | id_proyecto | horas_asignadas | nombre_empleado |
|---|---|---|---|
| 7  | 1  | 320 | Javier |
| 7  | 4  | 40  | Javier |

`nombre_empleado` depende solo de `id_empleado`, no de la combinación `(id_empleado, id_proyecto)`. Eso viola 2FN.

**Solución:** el nombre del empleado ya está en la tabla `empleados`. No se repite en `empleado_proyecto`.

---

## 3FN — Tercera Forma Normal

**Regla:** Cumplir 2FN + ninguna columna no-PK debe depender de **otra columna no-PK** (no hay dependencias transitivas).

**Ejemplo:**

| id_empleado | id_departamento | nombre_depto |
|---|---|---|
| 7 | 1 | Sistemas |

`nombre_depto` depende de `id_departamento`, y `id_departamento` depende de `id_empleado`. Eso es una dependencia transitiva: `id_empleado → id_departamento → nombre_depto`.

**Solución:** Quitar `nombre_depto` de la tabla `empleados` y tenerla solo en `departamentos`. Cuando necesitas el nombre, haces un JOIN.

> [!important] La base de datos RRHH ya está en 3FN
> Por eso usamos JOINs: `empleados` tiene `id_departamento`, y el nombre del departamento está en `departamentos`. No repetimos información.

---

## BCNF — Forma Normal de Boyce-Codd

Es una versión más estricta de 3FN. En la práctica, si cumples 3FN casi siempre cumples BCNF también.

**Regla:** Para cada dependencia funcional `A → B`, `A` debe ser una **superclave** (un atributo o conjunto de atributos que identifica de forma única cada fila).

En la mayoría de entrevistas, con saber 1FN, 2FN y 3FN es suficiente.

---

## Desnormalización — el camino inverso

La desnormalización es **intencional**: agregas redundancia a una tabla para que las consultas sean más rápidas.

**¿Cuándo se hace?**

Cuando tienes una consulta que se ejecuta millones de veces y el JOIN entre muchas tablas la hace lenta. En lugar de hacer el JOIN cada vez, guardas el dato calculado directamente en la tabla.

**Ejemplo:**

En vez de calcular el total de empleados por departamento con un `COUNT()` cada vez que carga el dashboard, guardas `total_empleados` en la tabla `departamentos` y lo actualizas con un trigger cuando se contrata o baja a alguien.

**Ventaja:** lectura más rápida.
**Desventaja:** escritura más compleja (hay que mantener consistencia manualmente).

> [!warning] La desnormalización es una decisión consciente
> No es un error de diseño. Se hace después de normalizar, cuando hay un problema real de rendimiento. Primero normaliza, luego (si es necesario) desnormaliza.

---

## Resumen para la entrevista

| Forma Normal | Qué prohíbe |
|---|---|
| 1FN | Valores múltiples en una celda |
| 2FN | Dependencia parcial de la PK compuesta |
| 3FN | Dependencia transitiva entre columnas |
| BCNF | Cualquier dependencia donde el determinante no sea superclave |

**Pregunta típica:** *"¿Qué es la 3FN?"*
**Respuesta corta:** "Es cuando cada columna de la tabla depende únicamente de la clave primaria, y no de otras columnas que no son clave. Así evitamos que cambiar un dato requiera actualizar muchas filas."
