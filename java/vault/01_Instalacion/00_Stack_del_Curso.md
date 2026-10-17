# Stack del Curso — ¿Qué vamos a usar y para qué?

> Antes de instalar cualquier cosa, entiende el panorama completo.

---

## El mapa del curso

```
[Java] ──► [Maven] ──► [Spring Boot]
                              │
                      [Docker + PostgreSQL]
                              │
                         [VS Code / IntelliJ]
```

---

## Las herramientas, una a una

### Java (JDK 21)
**¿Qué es?** El lenguaje de programación principal. Con Java escribes la lógica de tu aplicación.
**¿Por qué Java?** Es el lenguaje más pedido en empleos de backend en México y LATAM. Muchos bancos, gobierno e instituciones lo usan.
**Instalación:** [[01_Java]]

---

### VS Code
**¿Qué es?** Tu editor de código. Aquí escribes, corriges y ejecutas tus programas Java.
**¿Por qué VS Code?** Gratuito, ligero, con extensiones para Java. Fácil para empezar.
**¿Hay alternativa?** IntelliJ IDEA (más potente para proyectos grandes — ver abajo).
**Instalación:** [[02_VSCode]]

---

### Git
**¿Qué es?** Sistema de control de versiones. Guarda el historial de cambios de tu código, como un "guardado automático" muy inteligente.
**¿Por qué?** Todos los equipos de desarrollo usan Git. Sin Git no hay trabajo.
**Instalación:** [[03_Git]]

---

### Maven
**¿Qué es?** Herramienta de construcción para proyectos Java. Gestiona las librerías externas que necesites y empaqueta tu aplicación.
**¿Cuándo lo usas?** A partir de la semana 12 y en Spring Boot.
**Instalación:** [[04_Maven]]

---

### Spring Boot
**¿Qué es?** El framework más popular para hacer APIs y aplicaciones web con Java. Es lo que realmente se usa en la industria.
**¿Cuándo lo usas?** En la Fase 2 del curso (después de los 90 días base).
**Instalación:** [[05_Spring_Framework]]

---

### Docker
**¿Qué es?** Plataforma que permite correr aplicaciones en "contenedores" aislados. Usarás Docker para levantar bases de datos PostgreSQL en segundos, sin instalaciones complicadas.
**¿Cuándo lo usas?** Desde la semana 11 (SQL) y en toda la Fase 2 con Spring.
**Instalación:** [[06_Docker]]

---

### PostgreSQL (dentro de Docker)
**¿Qué es?** Base de datos relacional. Donde guardarás los datos de tus aplicaciones.
**¿Por qué PostgreSQL y no MySQL?** PostgreSQL es más moderno y potente. Lo usarás en el Portal de Carlos también.
**Instalación:** Incluida en [[06_Docker]]

---

## IDE alternativo — IntelliJ IDEA

Cuando pases a proyectos Spring Boot medianos o grandes, considera IntelliJ IDEA:

| | VS Code | IntelliJ IDEA Community |
|---|---------|------------------------|
| Precio | Gratis | Gratis (edición Community) |
| Peso | Ligero | Más pesado |
| Ideal para | Empezar, proyectos pequeños | Spring Boot, proyectos reales |
| Autocompletado Java | Bueno | Excelente |
| Refactorización | Básica | Avanzada |

**Instalación IntelliJ:**
1. Ve a: https://www.jetbrains.com/idea/download/
2. Descarga **Community Edition** (gratuita)
3. Instala y abre → "New Project" → Java → JDK 21

Por ahora usa VS Code. Cuando empieces Spring Boot te diremos si conviene cambiar.

---

## Orden de instalación recomendado

1. **Java JDK 21** → [[01_Java]]
2. **VS Code** → [[02_VSCode]]
3. **Git** → [[03_Git]]
4. **Docker** → [[06_Docker]]
5. **Maven** → [[04_Maven]] (cuando llegues a semana 12)
6. **Spring** → [[05_Spring_Framework]] (después de los 90 días)

---

## Checklist de instalación

- [ ] `java -version` muestra 21.x
- [ ] VS Code abre y ejecuta un archivo `.java`
- [ ] `git --version` funciona
- [ ] `docker --version` funciona
- [ ] `docker run hello-world` corre sin errores (prueba de Docker)
- [ ] `mvn -version` funciona (solo cuando llegues a semana 12)

Cuando tengas los primeros 4 listos, ¡empieza el curso!
