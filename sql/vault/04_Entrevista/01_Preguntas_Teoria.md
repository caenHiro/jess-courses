---
tema: Preguntas de teoría para entrevista
estado: completo
---

# Preguntas de Entrevista — Teoría de Bases de Datos

> Estas preguntas salieron en entrevistas reales. Lee la pregunta, intenta responder en voz alta como si estuvieras en la entrevista, luego lee la respuesta.

---

## Fundamentos

**¿Qué es una base de datos relacional?**

Una base de datos relacional organiza los datos en **tablas** (también llamadas relaciones) que se conectan entre sí a través de claves. Cada tabla tiene filas (registros) y columnas (atributos). La ventaja principal es que evita la duplicación de datos y garantiza la integridad a través de constraints y llaves foráneas.

---

**¿Qué es una clave primaria (Primary Key)?**

Es una columna (o combinación de columnas) que identifica de forma **única** cada fila de una tabla. No puede tener valores nulos ni repetidos. Por ejemplo, `id_empleado` en la tabla `empleados`.

---

**¿Qué es una clave foránea (Foreign Key)?**

Es una columna que hace referencia a la clave primaria de **otra tabla**, creando una relación entre ellas. Por ejemplo, `id_departamento` en `empleados` es una FK que apunta a `id_departamento` en `departamentos`. Garantiza que no puedes asignar a un empleado un departamento que no existe.

---

**¿Qué es un índice?**

Un índice es una **estructura de búsqueda** que MySQL crea para encontrar filas más rápido, sin tener que revisar toda la tabla. Es como el índice de un libro: en vez de leer todo el libro para encontrar un tema, vas directo a la página.

```sql
-- Crear un índice en la columna email
CREATE INDEX idx_email ON empleados(email);
```

**Desventaja:** los índices ocupan espacio en disco y hacen las inserciones/updates un poco más lentos porque también hay que actualizar el índice.

---

## Normalización

**¿Qué es la normalización?**

Es el proceso de organizar las tablas para evitar la duplicación de datos y las inconsistencias. Se hace aplicando reglas llamadas Formas Normales.

---

**¿Cuáles son las formas normales que conoces?**

- **1FN:** cada celda tiene un solo valor (atómico)
- **2FN:** cada columna depende de TODA la clave primaria (no solo parte de ella)
- **3FN:** ninguna columna no-PK depende de otra columna no-PK (sin dependencias transitivas)

---

**¿Qué es la desnormalización y cuándo se usa?**

Es el proceso inverso a la normalización: agregas redundancia intencional para mejorar el rendimiento de las lecturas. Se usa cuando las consultas son tan frecuentes y el JOIN es tan costoso que es más eficiente guardar el dato calculado directamente.

Ejemplo: guardar el total de empleados en la tabla `departamentos` en lugar de calcularlo con `COUNT()` en cada consulta.

---

## Transacciones y ACID

**¿Qué es una transacción?**

Un conjunto de operaciones SQL que se ejecutan como una unidad: o todas tienen éxito, o ninguna se aplica.

---

**¿Qué significa ACID?**

- **A — Atomicidad:** todo o nada. Si una operación falla, todas las demás se revierten.
- **C — Consistencia:** la BD siempre pasa de un estado válido a otro. Las reglas siempre se respetan.
- **I — Aislamiento:** las transacciones concurrentes no se interfieren entre sí.
- **D — Durabilidad:** una vez confirmada (COMMIT), la transacción persiste aunque el servidor se apague.

---

**¿Cuál es la diferencia entre COMMIT y ROLLBACK?**

- `COMMIT`: confirma todos los cambios de la transacción de forma permanente.
- `ROLLBACK`: deshace todos los cambios desde el último `START TRANSACTION`, dejando la BD como estaba antes.

---

## JSON en bases de datos

**¿Qué diferencia hay entre JSON y JSONB en PostgreSQL?**

- `JSON`: guarda el texto tal cual. Debe parsearse cada vez que se lee.
- `JSONB`: guarda en formato binario optimizado. Más rápido para leer y permite crear índices GIN.

En la práctica, siempre se usa `JSONB`.

---

**¿Cuándo guardarías datos en formato JSON en lugar de normalizar?**

Cuando los datos tienen estructura variable entre registros y no necesitas hacer búsquedas frecuentes por esos campos. Ejemplo: configuraciones de usuario, metadatos opcionales de productos, respuestas de APIs externas. Si necesito buscar por esos campos constantemente, mejor normalizo.

---

## Arquitectura

**¿Qué es DDD (Domain-Driven Design)?**

Es un enfoque de diseño donde el modelo del software refleja el lenguaje y los conceptos del negocio. Los objetos del código (entidades, servicios, repositorios) representan conceptos reales del dominio del problema.

---

**¿Qué es un Bounded Context?**

Es un límite explícito dentro del cual un modelo de dominio tiene un significado consistente. Por ejemplo, el concepto "Cliente" puede tener atributos y reglas completamente diferentes en el contexto de Ventas que en el contexto de Facturación. Cada uno es un Bounded Context separado.

---

**¿DDD reemplaza MVC?**

No. Son conceptos en niveles diferentes. MVC organiza las **capas técnicas** de la aplicación (vista, controlador, modelo). DDD guía cómo **diseñar el modelo de negocio** dentro de esas capas. Pueden coexistir perfectamente.

---

**¿Qué son los microservicios?**

Una arquitectura donde la aplicación se divide en servicios pequeños, independientes, cada uno con su propia responsabilidad y su propia base de datos. Se comunican entre sí mediante APIs. Permiten escalar partes de la aplicación de forma independiente, pero aumentan la complejidad operativa.

---

## MySQL vs PostgreSQL

**¿Cuál es la principal diferencia entre MySQL y PostgreSQL?**

MySQL es más popular en aplicaciones web por su simplicidad y velocidad en operaciones básicas. PostgreSQL es más completo en funcionalidades SQL avanzadas, tiene mejor soporte para JSONB (con índices), cumple más estrictamente el estándar SQL y tiene licencia completamente libre.

---

**¿Cuál es la diferencia entre WHERE y HAVING?**

- `WHERE` filtra **filas individuales** antes de que se aplique el `GROUP BY`.
- `HAVING` filtra **grupos** después de que se aplica el `GROUP BY` y las funciones de agregación.

Regla práctica: si el filtro usa `COUNT`, `SUM`, `AVG`, `MIN` o `MAX`, es `HAVING`. Si no, es `WHERE`.
