---
tags: [entrevista, java, competencias, vacante, spring, sql, aws]
estado: referencia
updated: 2026-07-02
---

# Competencias Técnicas — Guía de Vacantes Java Backend

> Mapa de las tecnologías que piden las vacantes de desarrollador Java.
> Úsalo para saber en qué enfocarte antes de una entrevista.

---

## Lenguajes — lo que piden y dónde lo ves en el curso

| Tecnología | Nivel que piden | En tu curso |
|---|---|---|
| **Java** | Intermedio-Avanzado | Semanas 1–12 completas |
| **SQL** | Intermedio | Semanas 11–12 + curso SQL express |
| **Python** | Básico-Intermedio | Curso 2 (siguiente) |
| **JavaScript / TypeScript** | Básico | Curso 3 (web) |
| **HTML / CSS** | Básico | Curso 3 (web) |
| **PHP** | Básico opcional | No crítico para backend Java |

**Prioridad real:** Java sólido + SQL = 80% de las entrevistas Java backend.

---

## Frameworks Java — qué son y para qué sirven

### Spring Boot ⭐ (el más importante)
Framework que hace fácil crear APIs REST con Java. Es la base de casi toda empresa que usa Java hoy.

```
Analogía: si Java es el motor, Spring Boot es el carro armado completo.
Ya no escribes todo desde cero — Spring Boot trae configuración lista.
```

**Lo que debes saber para entrevista:**
- ¿Qué es una anotación en Spring? (`@Controller`, `@Service`, `@Repository`, `@Autowired`)
- ¿Qué es inyección de dependencias?
- ¿Cómo se crea un endpoint REST? (`@GetMapping`, `@PostMapping`)
- ¿Qué es un `@RestController`?

### Spring Framework
La base de Spring Boot. Cuando digan "Spring" sin "Boot", se refieren a la versión más manual.

### Hibernate
ORM — Object Relational Mapping. Traduce objetos Java a tablas de base de datos sin escribir SQL manual.

```java
// Sin Hibernate: escribes SQL a mano
String sql = "INSERT INTO usuarios (nombre, email) VALUES (?, ?)";

// Con Hibernate: usas el objeto Java directamente
Usuario u = new Usuario("Ana", "ana@mail.com");
session.save(u);  // Hibernate genera el SQL
```

### JSF (JavaServer Faces)
Framework para interfaces web con Java. Ya está en declive — si lo piden es para sistemas legacy (viejos). No es prioridad aprender.

### React / AngularJS
Son frameworks de **JavaScript** para el frontend (lo que el usuario ve). Si solo buscas backend Java, solo necesitas entender qué son, no programarlos.

---

## Bases de Datos

| BD | Qué es | Para entrevista |
|---|---|---|
| **Oracle** | BD empresarial de pago, muy usada en gobierno/bancos | Saber que existe + SQL básico funciona igual |
| **PostgreSQL** | BD open source, muy popular ahora | Ya la usamos en el curso ✅ |
| **MySQL** | BD open source, común en empresas medianas | Misma sintaxis que PostgreSQL en lo básico ✅ |

**Tip:** Si sabes SQL en PostgreSQL, el 90% funciona igual en Oracle y MySQL. La diferencia son funciones avanzadas.

---

## Cloud — AWS

| Servicio | Qué hace | Nivel |
|---|---|---|
| **AWS Lambda** | Código que corre sin servidor — evento → respuesta | Ya lo viste conceptualmente |
| **API Gateway** | Puerta de entrada HTTP para tus Lambdas | Se usa junto con Lambda |

Para entrevista de desarrollador junior: saber qué son y para qué sirven. No necesitas haberlos configurado.

---

## Herramientas del día a día

| Herramienta | Para qué | Tu estado |
|---|---|---|
| **Git** | Control de versiones — ya lo usas en el curso | ✅ |
| **Maven** | Maneja dependencias en proyectos Java (como npm para JS) | Semana 12 del curso |
| **Postman** | Prueba APIs REST sin escribir código | Fácil de aprender en 1 hora |
| **VS Code** | Editor de código — ya lo usas | ✅ |
| **Eclipse / NetBeans / IntelliJ** | IDEs Java más tradicionales | Conocer de nombre, saber abrirlos |
| **PGAdmin** | Interfaz visual para PostgreSQL | Ya lo has visto ✅ |
| **Workbench** | Lo mismo pero para MySQL | Igual a PGAdmin |

---

## Metodologías

| Metodología | Qué es | Para entrevista |
|---|---|---|
| **Scrum** | Forma de organizar el trabajo en equipo (sprints, daily, retrospectiva) | Saber explicar qué es un sprint y cuál es tu rol |
| **API REST** | Estilo de diseño de APIs usando HTTP (GET, POST, PUT, DELETE) | Semanas 11-12 del curso ✅ |
| **Pruebas Unitarias** | Código que verifica que tu código funciona (JUnit) | Mención en semana 12 |

---

## Preguntas de entrevista más comunes — Java Backend

### POO (Programación Orientada a Objetos)
1. ¿Qué es herencia? ¿Para qué sirve? — Semana 8
2. ¿Qué es polimorfismo? — Semana 8
3. ¿Diferencia entre clase abstracta e interface? — Semana 9
4. ¿Qué es encapsulamiento? — Semanas 7-8

### Java específico
1. ¿Diferencia entre `==` y `.equals()`?
2. ¿Qué es una excepción? ¿Checked vs Unchecked? — Semana 10
3. ¿Qué es un ArrayList vs array normal? — Semana 10
4. ¿Qué son los genéricos (`<T>`)? — Semana 10
5. ¿Qué es el garbage collector?

### Spring Boot (si aplica)
1. ¿Qué es inyección de dependencias?
2. ¿Diferencia entre `@Component`, `@Service`, `@Repository`?
3. ¿Cómo crear un endpoint REST?

### SQL
1. ¿Diferencia entre INNER JOIN y LEFT JOIN?
2. ¿Qué hace GROUP BY?
3. ¿Qué es un índice en BD y para qué sirve?
4. ¿Diferencia entre WHERE y HAVING?

---

## Plan de preparación — 2 semanas antes de entrevista

```
Semana -2:
  Día 1-2: Repasar POO (herencia, polimorfismo, interfaces)
  Día 3-4: Repasar excepciones + colecciones (ArrayList, HashMap)
  Día 5-6: SQL — JOINs, GROUP BY, subconsultas
  Día 7:   Descanso

Semana -1:
  Día 1-2: Spring Boot básico — crear un proyecto simple con Spring Initializr
  Día 3-4: Prueba Postman con tu propio endpoint
  Día 5:   Repasar Git (commits, branches, merge)
  Día 6:   Simulacro de entrevista con preguntas de arriba
  Día 7:   Descanso mental
```

---

## Recursos rápidos

- Spring Initializr: `https://start.spring.io` — crea un proyecto Spring Boot en 1 minuto
- Documentación oficial Spring: `https://spring.io/guides`
- MySQL Workbench: lo mismo que PGAdmin pero para MySQL
