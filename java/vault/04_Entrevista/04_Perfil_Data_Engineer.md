---
tags: [entrevista, data-engineering, spark, snowflake, dwh, big-data, vacante]
estado: referencia
updated: 2026-07-02
---

# Perfil Data Engineer — Guía de Vacantes Big Data

> Este perfil es más avanzado que el de desarrollador Java.
> Requiere Java/Python sólido primero — estúdialo **después** de dominar el curso de Java.
> Objetivo: entender qué piden y tener respuestas básicas preparadas.

---

## ¿Qué hace un Data Engineer?

Un Data Engineer construye las tuberías (pipelines) que mueven y transforman datos masivos.

```
Fuentes de datos → [Pipeline Data Engineer] → Almacenamiento → Análisis
(Apps, sensores,      (limpiar, transformar,    (DWH, Data Lake)  (Data Scientists,
 APIs, logs)          mover millones de filas)                     reportes, BI)
```

No es lo mismo que:
- **Desarrollador Backend** (crea APIs y lógica de negocio)
- **Data Scientist** (analiza datos y crea modelos IA)
- **DBA** (administra bases de datos)

---

## Lenguajes — lo que piden

| Lenguaje | Por qué | Tu estado |
|---|---|---|
| **Java / Scala** | Spark está escrito en Scala — la API Java/Scala es la nativa | Java: en curso ✅ · Scala: similar a Java, aprender después |
| **Python** | Lenguaje más popular para data pipelines hoy | Curso 2 (siguiente a Java) |
| **SQL** | Siempre necesario — consultas sobre datos masivos | Semanas 11-12 + curso SQL ✅ |

---

## Herramientas clave — explicadas simple

### Apache Spark ⭐ (la más importante)
Motor para procesar millones de datos en paralelo (en muchas máquinas al mismo tiempo).

```
Analogía: en lugar de llenar un estadio de personas de una en una (SQL normal),
Spark llena 1,000 filas al mismo tiempo usando 100 máquinas en paralelo.

Casos reales:
- Netflix analiza millones de reproducciones cada noche
- Bancos detectan fraudes en tiempo real
- INE podría procesar millones de votos simultáneamente
```

**Modos:** Batch (procesa datos del pasado) y Streaming (procesa datos en tiempo real).

### Apache Flink
Similar a Spark pero especializado en **streaming** (flujo de datos en tiempo real, sin pausas).

```
Spark: "cada 5 minutos proceso todo lo que llegó"
Flink: "proceso cada dato exactamente cuando llega, sin esperar"
```

Casos: alertas de fraude bancario instantáneas, monitoreo de sensores IoT.

### Lambdas (en data engineering)
No son AWS Lambda — es la **Arquitectura Lambda** de datos: dos capas paralelas.
- **Batch layer:** procesa datos históricos (lento, completo)
- **Speed layer:** procesa datos recientes (rápido, aproximado)
- **Serving layer:** combina ambos para respuestas rápidas

---

## Modelado de datos — los esquemas

### Esquema Estrella (Star Schema) ⭐
El modelo más común para Data Warehouses. Una tabla central de hechos rodeada de tablas de dimensiones.

```
         [dim_tiempo]
              |
[dim_producto] — [fact_ventas] — [dim_cliente]
              |
         [dim_tienda]
```

`fact_ventas` tiene: cantidad, monto, fecha_id, producto_id, cliente_id, tienda_id
Las dimensiones tienen: los detalles (nombre del producto, dirección del cliente, etc.)

### OBT (One Big Table)
Alternativa moderna al estrella — todo en UNA tabla desnormalizada.
Más simple, funciona bien con columnar stores (Snowflake, BigQuery).

### Snowflake Schema
Variante del esquema estrella con dimensiones normalizadas (más tablas, más joins).

---

## Almacenamiento — Data Lakes, DWH y Lakehouse

### Data Warehouse (DWH) — almacén de datos estructurados
Datos limpios, organizados, listos para análisis. Como una bodega perfectamente ordenada.
Herramientas: **Snowflake**, Oracle DW, Redshift (AWS), BigQuery (Google)

### Data Lake — lago de datos crudos
Datos en su forma original, sin procesar. Cualquier formato: CSV, JSON, Parquet, imágenes.
Como un lago donde caen todos los ríos — datos de todas partes.
Herramientas: S3 (AWS), Azure Data Lake, HDFS

### Lakehouse — lo mejor de ambos
Combina la flexibilidad del Data Lake con la estructura del DWH.
Herramientas: **Databricks** (Delta Lake), **Clickhouse**, **Snowflake** (también actúa como Lakehouse)

---

## Plataformas — qué son y para qué

| Plataforma | Qué es | Usado para |
|---|---|---|
| **Snowflake** | Base de datos columnar en la nube — muy rápida para análisis | DWH, analytics, reportes |
| **Databricks** | Plataforma Spark en la nube — Spark sin instalar nada | ETL, ML, pipelines batch/streaming |
| **Clickhouse** | BD columnar open source — extremadamente rápida para lecturas | Analítica en tiempo real, logs |
| **BigQuery** | DWH de Google Cloud — pagar por query | Analytics masivo, integración Google |

---

## Preguntas de entrevista — Data Engineer junior

### Conceptos básicos
1. ¿Qué es un pipeline de datos? ¿Qué pasos tiene?
2. ¿Diferencia entre ETL y ELT?
3. ¿Qué es un Data Warehouse vs Data Lake?
4. ¿Qué es un esquema estrella? ¿Por qué se usa?
5. ¿Diferencia entre procesamiento batch y streaming?

### Spark
1. ¿Qué es un RDD? ¿Qué es un DataFrame en Spark?
2. ¿Qué hace `filter()`, `map()`, `groupBy()` en Spark?
3. ¿Por qué Spark es más rápido que MapReduce?

### SQL para data engineering
1. ¿Qué es una tabla particionada?
2. ¿Qué son las funciones de ventana (window functions)?
3. ¿Qué es una tabla materializada?
4. ¿Diferencia entre OLTP y OLAP?

---

## Plan de preparación para esta vacante

> **Prerequisito:** Terminar el curso de Java + Python básico primero.

```
Fase 1 — Fundamentos (4 semanas):
  Python sólido (pandas, manejo de CSV/JSON)
  SQL avanzado (window functions, CTE, particiones)

Fase 2 — Herramientas (4 semanas):
  Apache Spark con PySpark (Python API de Spark)
  Un proyecto pequeño: leer CSV masivo → limpiar → guardar en Parquet

Fase 3 — Cloud (2 semanas):
  Snowflake free trial (14 días)
  Crear un esquema estrella simple y hacer queries analíticos

Fase 4 — Entrevista (1 semana):
  Repasar preguntas de arriba
  Practica explicar un pipeline de datos de principio a fin
```

**Tiempo total estimado:** ~4-6 meses después de dominar Python.

---

## Recursos para empezar

- PySpark: `https://spark.apache.org/docs/latest/api/python/` (documentación oficial)
- Snowflake free trial: `https://www.snowflake.com/try-snowflake/`
- Databricks Community Edition (gratis): `https://community.cloud.databricks.com/`
- Libro recomendado: *Fundamentals of Data Engineering* (Joe Reis & Matt Housley)
