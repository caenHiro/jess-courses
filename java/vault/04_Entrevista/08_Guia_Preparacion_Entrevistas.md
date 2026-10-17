---
tags: [entrevista, preparacion, java, sql, ine, data-engineer, guia]
estado: activo
updated: 2026-07-02
---

# Guía de Preparación — Por Tipo de Entrevista

> Tu hoja de ruta para llegar lista a cada entrevista.
> Cada sección tiene: qué estudiar, en qué orden, y cómo preparar las respuestas.

---

## Tipo 1 — Desarrolladora Java Backend (INE)
**Nivel:** Junior a Semi-Senior  
**Documentos de entrega:** 7 y 8 de julio 2026, Viaducto Tlalpan 100 Edificio C

### Plan de los días previos

| Día | Qué hacer |
|-----|-----------|
| **-5 días** | Leer `05_Examen_SQL_Lideres.md` completo — resolver todas las preguntas |
| **-4 días** | Repasar semanas 7-10 del curso (POO, herencia, interfaces, colecciones) |
| **-3 días** | Leer `06_Examen_Java_JBoss_Microservicios.md` — resolver todas las preguntas |
| **-2 días** | Leer `07_Historia_INE.md` — memorizar fechas y estructura |
| **-1 día** | Simulacro completo: responder en voz alta las preguntas de los tres exámenes |
| **Día del examen** | Descansar, llegar 30 min antes, llevar credencial y documentos |

### Documentos que llevar
- Curriculum actualizado (impreso y digital)
- Credencial INE vigente
- Comprobante de estudios / título / cédula profesional
- Los documentos que te indicaron en la convocatoria

### Preguntas que casi siempre hacen en entrevista Java INE

**De conocimiento técnico:**
1. "Explícame la diferencia entre clase abstracta e interface" → Semana 9
2. "¿Qué es encapsulamiento? Dame un ejemplo" → Semana 7
3. "¿Qué hace el `this` en Java?" → Semana 7
4. "¿Diferencia entre `==` y `equals()`?" → Respuesta en archivo 06
5. "¿Qué es una excepción? ¿Cuándo usas try-catch?" → Semana 10

**De experiencia / conducta (responde con ejemplos reales):**
1. "Cuéntame de un problema que hayas resuelto con código"
2. "¿Has trabajado en equipo en proyectos de programación?"
3. "¿Por qué quieres trabajar en el INE?"
4. "¿Qué has aprendido de programación por tu cuenta?"

**De SQL:**
- Pueden darte un problema para resolver en papel o en computadora
- Lo más común: JOINs, GROUP BY + HAVING, subconsultas

### Respuesta preparada para "¿Por qué el INE?"
> "El INE es una institución fundamental para la democracia de México. Me interesa contribuir desde la tecnología — los sistemas que desarrollan aquí tienen impacto real en millones de ciudadanos. Además, quiero seguir desarrollando mis habilidades en Java y bases de datos en un entorno profesional y de alto impacto."

---

## Tipo 2 — Desarrolladora Java Backend (Empresa privada)
**Nivel:** Junior  
**Diferencia vs INE:** más énfasis en Spring Boot y APIs REST; menos en historia institucional

### Lo que cambia respecto a la entrevista INE

| Tema | INE | Empresa privada |
|------|-----|-----------------|
| Historia institucional | Importante | No aplica |
| JBoss / WildFly | Relevante | Raro — más Tomcat |
| Spring Boot | Básico | Muy importante |
| MySQL / PostgreSQL | Indistinto | Más PostgreSQL |
| Git workflow | Básico | Importante (branches, PR) |
| Pruebas unitarias | Básico | Pueden preguntar JUnit |

### Plan de preparación (2-3 semanas)

```
Semana 1:
  Repasar POO completa (semanas 7-10)
  Spring Boot: crear un proyecto simple en start.spring.io
  Crear un endpoint GET y POST básico

Semana 2:
  Conectar Spring Boot a PostgreSQL
  Crear una tabla y hacer CRUD completo
  Practicar Postman para probar tus endpoints

Semana 3:
  Git: practica crear un branch, hacer commits limpios, merge
  Repasar SQL (JOINs, GROUP BY)
  Simulacro de entrevista: explica tu proyecto en voz alta
```

### Preguntas típicas empresa privada

1. "¿Has trabajado con Spring Boot?" → Menciona lo que has aprendido aunque sea básico
2. "¿Qué es una API REST?" → Protocolo HTTP, endpoints, JSON, métodos GET/POST/PUT/DELETE
3. "¿Cómo manejarías un error en una API?" → try-catch + respuesta con código HTTP apropiado
4. "¿Qué es un ORM?" → Herramienta que mapea objetos Java a tablas BD (Hibernate, JPA)
5. "¿Conoces Git?" → Sí, lo uso en mi curso — commits, pull, push

---

## Tipo 3 — Data Engineer (Perfil avanzado — futuro)
**Prerequisito:** Dominar Java + Python básico primero  
**Horizonte:** 1-2 años después de este curso

Este perfil es para cuando termines el curso de Python y tengas experiencia con datos.

### Lo que necesitas ANTES de buscar esta posición

- [ ] Python sólido (pandas, manejo de archivos grandes)
- [ ] SQL avanzado (window functions, CTEs, particiones)
- [ ] Haber trabajado con datos reales (aunque sea en proyectos personales)
- [ ] Conocimiento básico de Spark (al menos haber corrido código PySpark)
- [ ] Entender qué es un Data Lake vs un DWH (ver archivo 04)

### Preguntas típicas de entrevista Data Engineer

1. "¿Cuál es la diferencia entre batch y streaming?" → Batch: proceso datos del pasado en lotes · Streaming: proceso datos en tiempo real
2. "¿Qué es un esquema estrella?" → Tabla de hechos central rodeada de dimensiones
3. "¿Qué es un pipeline de datos?" → Secuencia de pasos que transforman datos de origen a destino
4. "¿Has trabajado con Spark?" → Si no: "Conozco el concepto y tengo experiencia con pandas/SQL"
5. "¿Qué es ETL?" → Extract, Transform, Load — extraer datos, limpiarlos, cargarlos a un DWH

---

## Reglas de oro para cualquier entrevista

### Antes de la entrevista
- [ ] Investiga qué hace la empresa/institución (10 min de búsqueda)
- [ ] Lee la descripción de la vacante 2-3 veces
- [ ] Prepara 3 ejemplos de cosas que has construido o aprendido
- [ ] Descansa bien la noche anterior

### Durante la entrevista
- **Si no sabes algo:** di "No lo he trabajado directamente, pero entiendo el concepto..." o "Eso lo aprendería rápido dado que..."
- **Si te dan un problema:** piensa en voz alta — el entrevistador quiere ver cómo razonas
- **Si es en papel:** escribe código limpio aunque no sea perfecto — lo que importa es la lógica
- **Preguntas al final:** pregunta "¿Cómo es un día típico en este rol?" o "¿Cuál es el mayor reto técnico del equipo?"

### Después de la entrevista
- Envía un email de agradecimiento esa misma tarde (si tienes el contacto)
- Anota qué preguntas no supiste responder — estúdialas para la próxima

---

## Archivos de estudio en este repositorio

| Archivo | Para qué entrevista | Prioridad |
|---------|---------------------|-----------|
| `01_Preguntas_Java.md` | Tipo 1 y 2 | 🔴 Alta |
| `02_Vacante_INE_Ing_Desarrollo.md` | Tipo 1 | 🔴 Alta |
| `03_Competencias_Tecnicas_Vacantes.md` | Tipo 1 y 2 | 🟡 Media |
| `05_Examen_SQL_Lideres.md` | Tipo 1 | 🔴 Alta |
| `06_Examen_Java_JBoss_Microservicios.md` | Tipo 1 | 🔴 Alta |
| `07_Historia_INE.md` | Tipo 1 | 🔴 Alta |
| `04_Perfil_Data_Engineer.md` | Tipo 3 (futuro) | 🟢 Baja ahora |

**Orden de estudio para entrevista INE (esta semana):**
1. `07_Historia_INE.md` (30 min)
2. `05_Examen_SQL_Lideres.md` (45 min)
3. `06_Examen_Java_JBoss_Microservicios.md` (45 min)
4. `01_Preguntas_Java.md` (30 min)
5. Simulacro en voz alta (30 min)
