---
tags: [java, examen, ine, sigetic, ads, jboss]
fecha: 2026-04-22
tipo: guia_examen
---

# Guía de Examen INE — Contenido Evaluado

> Plática del 22 de abril. Temas que entran en el examen de contratación INE.
> Ver también: [[06_Examen_Java_JBoss_Microservicios]] · [[05_Examen_SQL_Lideres]]

---

## SIGETIC

- Roles de SIGETIC
- Objetivos de SIGETIC
- Paquete de trabajo
- Historias de usuario
- Descripción de roles
- Pruebas unitarias

## ADS (Análisis y Diseño de Software)

- Etapa del ADS dentro del SIGETIC
- Etapas del proceso ADS del SIGETIC versión actual
- Estructura de diseño ADS: Diccionario de datos, Modelo Entidad Relación
- En la etapa de ADS se generan las **pruebas unitarias**

## Scrum

- Marco de trabajo ágil
- Relacionado con SIGETIC

## Java

- Java versión 7 — Tutoriales
- **Red Hat EAP 7.0** (servidor de aplicaciones)
- **Java EE 7**
- Datos primitivos de Java
- Sentencias de control de flujo
- Preguntas de ejecución (¿qué imprime este código?)
- Niveles de acceso a una clase: `public` / `protected` / `private` / (sin modificador)
- Anotaciones / Metadatos
- **Managed Bean**

## JBoss / Red Hat EAP

- Configuración de un servidor JBoss EAP
- `standalones` / `standalone-full-messages`
- Tipos de archivos para empaquetar aplicaciones empresariales:
  - `.jar` — Java Archive
  - `.war` — Web Archive
  - `.ear` — Enterprise Archive
- Enterprise bean
- Especificación de estructura de archivo Java EE, JSF

## Patrones / Diseño

- Patrones para la identificación de la lógica
- **Business Object** — patrón de objeto de negocio
- **Componente Entity**
- Se busca durante el diseño de las clases:
  - **Alta cohesión**
  - **Bajo acoplamiento**
  - **Clase thread safe**

## API / Protocolo / Arquitectura

- API
- **JAX-WS** — servicios web SOAP
- **JAX-RS** — servicios REST
- **JMS API** y async (mensajería)

## Base de Datos

- El manejo de DB — etapa del SIGETIC
- Generar un plano cartesiano
- **JOIN**: right, left, inner join, left join
- Subqueries para la selección
- Variables bind (`:variable`)
- Referencia de llave foránea
- Transacción
- **CLOB** — Character Large Object
- Tipos de datos
- Vistas: materializadas y no materializadas
- `GRANT READ` → permisos Grant
- `COUNT`, `SUM`
- `TO_CHAR`, `TO_DATE`

## UML

- Diagrama de Secuencia
- Flujo
- Diagrama de casos de uso

---

## Material de referencia

- `Platica_22_abril_examen.pdf` — grabación/notas de la plática original
- [[06_Examen_Java_JBoss_Microservicios]] — guía técnica detallada
- [[05_Examen_SQL_Lideres]] — SQL específico para líderes
- [[10_SIGETIC_HU]] — SIGETIC completo: roles, objetivos, paquetes de trabajo, HUs, ADS
- [[11_Pruebas_Unitarias_Java]] — pruebas unitarias con JUnit 5, contexto SIGETIC
