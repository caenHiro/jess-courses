# Spring Framework — Introducción e instalación

> Esto es para cuando termines los 90 días básicos. Spring es el framework más popular para desarrollar aplicaciones web con Java.

---

## ¿Qué es Spring Boot?

Spring Boot es una herramienta que te permite crear aplicaciones web (APIs, servicios) con Java de forma rápida. Es lo que usan empresas como Netflix, Amazon y muchos bancos.

Con Spring Boot puedes:
- Crear APIs REST (como las que conectan apps móviles con servidores)
- Conectar tu aplicación a bases de datos
- Manejar usuarios, sesiones, y seguridad

---

## Crear un proyecto Spring Boot

La forma más fácil es usar **Spring Initializr**:

1. Ve a: https://start.spring.io
2. Configura:
   - **Project:** Maven
   - **Language:** Java
   - **Spring Boot:** 3.x (la más reciente)
   - **Java:** 21
3. En "Dependencies" agrega:
   - `Spring Web`
   - `Spring Data JPA`
   - `MySQL Driver`
4. Clic en "Generate" → descarga el zip → ábrelo en VS Code

---

## Tu primera API con Spring Boot

Una vez que tengas el proyecto, crea este archivo:

```java
// src/main/java/com/ejemplo/HolaController.java
package com.ejemplo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HolaController {

    @GetMapping("/hola")
    public String hola() {
        return "Hola desde Spring Boot!";
    }
}
```

Ejecuta con: `mvn spring-boot:run`

Abre en el navegador: http://localhost:8080/hola

---

## Prerequisitos antes de usar Spring

Antes de llegar a Spring debes tener sólidos:
- [x] POO (clases, herencia, interfaces)
- [x] Manejo de excepciones
- [x] Colecciones (ArrayList, HashMap)
- [x] SQL básico y avanzado
- [ ] HTTP básico (GET, POST, PUT, DELETE)
- [ ] JSON (formato de datos web)

Spring es la Fase 2 del curso. Por ahora enfócate en los fundamentos Java.
