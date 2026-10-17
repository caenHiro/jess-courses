---
tags: [sigetic, ine, historias-usuario, scrum, ads, metodologia]
fecha: 2026-07-29
tipo: guia_examen
---

# SIGETIC — Sistema de Gestión de TIC del INE

> Tema del examen INE: **Roles · Objetivos · Paquetes de trabajo · Historias de usuario · ADS**
> Ver también: [[09_Examen_Contenido_22Abril]] · [[06_Examen_Java_JBoss_Microservicios]]

---

## ¿Qué es SIGETIC?

**SIGETIC** (Sistema de Gestión de Tecnologías de Información y Comunicaciones) es el **marco normativo interno del INE** que define cómo se planifican, desarrollan, entregan y mantienen los sistemas de software.

Piénsalo como el "reglamento oficial" que todo desarrollador INE debe seguir para que los proyectos sean trazables, auditables y de calidad.

---

## Objetivos del SIGETIC

1. Estandarizar el ciclo de vida del software en toda la organización
2. Asegurar que los entregables sean verificables y documentados
3. Alinear los proyectos de TI con las metas institucionales del INE
4. Establecer criterios claros de calidad antes de pasar a producción
5. Garantizar la trazabilidad: cada requerimiento → diseño → código → prueba

**Frase para la entrevista:**
> "SIGETIC me da el marco para asegurar que cada cambio que hago tiene documentación, pasa por revisión y queda trazable desde el requerimiento hasta la prueba."

---

## Ciclo de vida en SIGETIC

```
Inicio → Planeación → Análisis y Diseño (ADS) → Desarrollo → Pruebas → Despliegue → Mantenimiento
```

Cada etapa genera **entregables formales** (documentos, diagramas, código, resultados de prueba).

---

## Roles en SIGETIC

| Rol | Responsabilidad |
|---|---|
| **Líder de Proyecto** | Coordina el equipo, aprueba entregables, punto de contacto con el área usuaria |
| **Analista** | Levanta requerimientos, redacta Historias de Usuario, define criterios de aceptación |
| **Diseñador** | Define la arquitectura, Diccionario de datos, Modelo Entidad-Relación |
| **Desarrollador** | Implementa el código según el diseño y los estándares SIGETIC |
| **QA / Tester** | Ejecuta y documenta las pruebas unitarias, de integración y de aceptación |
| **Área Usuaria** | Define los requerimientos funcionales, acepta o rechaza los entregables |
| **Infraestructura** | Gestiona servidores JBoss, BD Oracle, accesos y despliegues |

---

## Paquete de Trabajo (Work Package)

Un **paquete de trabajo** es la unidad mínima de entrega dentro de SIGETIC. Agrupa las actividades de una fase o funcionalidad específica.

Cada paquete de trabajo incluye:
- **ID y nombre** del paquete
- **Alcance** — qué se entrega, qué queda fuera
- **Entregables** — documentos, código, resultados de prueba
- **Responsable** y fechas
- **Criterios de aceptación** — cómo sabe el área usuaria que está completo

**Ejemplo:**
```
Paquete de Trabajo: PQT-2026-003
Nombre: Módulo de captura de actas — MCAD
Entregables:
  - Análisis y Diseño (ADS) firmado
  - Código fuente en repositorio
  - Resultados de pruebas unitarias
  - Manual de usuario
Aceptado por: Subdirección de Sistemas Electorales
```

---

## Historias de Usuario (HU)

Las **Historias de Usuario** son la forma en que SIGETIC captura los requerimientos funcionales, usando el lenguaje del área usuaria (no técnico).

### Formato estándar

```
Como [rol del usuario],
quiero [acción o funcionalidad],
para que [beneficio o propósito].
```

### Ejemplo HU del INE

```
HU-001
Como operador del MCAD,
quiero poder capturar el número de votos de cada partido por casilla,
para que el sistema genere el acta digital y la almacene en la base de datos.

Criterios de aceptación:
- El sistema valida que la suma de votos no exceda el total de votantes
- Si hay error, muestra mensaje claro sin perder los datos ya capturados
- Al guardar, el registro queda firmado digitalmente con el usuario del operador
```

### Estructura de una HU en SIGETIC

| Campo | Descripción |
|---|---|
| **ID** | Identificador único (HU-001, HU-002...) |
| **Nombre** | Título breve |
| **Descripción** | Como [rol], quiero [acción], para que [beneficio] |
| **Criterios de aceptación** | Condiciones verificables para dar por completada |
| **Estimación** | Story points o días (Scrum) |
| **Prioridad** | Alta / Media / Baja |
| **Estado** | Pendiente / En desarrollo / En pruebas / Completada |

---

## ADS dentro de SIGETIC (Análisis y Diseño de Software)

La etapa de **ADS** es donde se formaliza el diseño antes de escribir código.

### Etapas del proceso ADS (versión actual SIGETIC)

1. **Levantamiento de requerimientos** — reuniones con el área usuaria, identificar HUs
2. **Análisis** — modelar procesos, identificar entidades, definir reglas de negocio
3. **Diseño** — Diccionario de datos + Modelo Entidad-Relación + arquitectura de componentes
4. **Generación de pruebas unitarias** — se definen los casos de prueba a partir de los criterios de aceptación de las HUs
5. **Revisión y firma** — el documento ADS debe ser aprobado antes de iniciar desarrollo

### Artefactos que genera el ADS

| Artefacto | Descripción |
|---|---|
| **Diccionario de datos** | Define cada campo/variable: nombre, tipo, longitud, descripción |
| **Modelo Entidad-Relación (MER)** | Diagrama de las tablas y sus relaciones |
| **Diagrama de casos de uso** | UML — qué hace el sistema y quién lo usa |
| **Diagrama de secuencia** | UML — cómo fluyen los mensajes entre componentes |
| **Casos de prueba unitaria** | Qué se probará y cuáles son los resultados esperados |

---

## SIGETIC y Scrum

El INE integra Scrum dentro del SIGETIC como marco de trabajo para los sprints de desarrollo:

| Concepto Scrum | En SIGETIC |
|---|---|
| **Sprint** | Ciclo de 2 semanas de desarrollo |
| **Product Backlog** | Lista priorizada de Historias de Usuario |
| **Sprint Backlog** | HUs del paquete de trabajo del sprint actual |
| **Retrospectiva** | Documentada en el paquete de trabajo |
| **Definition of Done** | Incluye: código revisado + pruebas unitarias pasadas + documentación actualizada |

---

## Preguntas frecuentes del examen

**¿En qué etapa del SIGETIC se generan las pruebas unitarias?**
> En la etapa de **ADS** — se definen los casos de prueba a partir de los criterios de aceptación de las Historias de Usuario, antes de comenzar a codificar.

**¿Qué diferencia hay entre un caso de uso y una Historia de Usuario?**
> Un caso de uso describe la interacción completa entre el sistema y el actor (UML formal). Una Historia de Usuario describe el mismo requerimiento desde la perspectiva del beneficio para el usuario, en lenguaje no técnico.

**¿Cómo se relaciona Scrum con SIGETIC?**
> SIGETIC es el marco normativo institucional; Scrum es el método ágil que se usa dentro de SIGETIC para organizar el trabajo en sprints con HUs del backlog.

**¿Qué es un paquete de trabajo y quién lo aprueba?**
> Es la unidad de entrega del proyecto, con alcance, entregables y criterios definidos. Lo aprueba el Líder de Proyecto junto con el área usuaria.
