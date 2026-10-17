---
tema: DDD, Bounded Context, Microservicios y MVC
estado: completo
---

# DDD, Microservicios y Arquitectura

> Estos temas vinieron en la entrevista como preguntas conceptuales. No necesitas ser experta en esto — solo entender qué es cada cosa y cómo se relacionan.

---

## MVC — Model View Controller

Es el patrón más conocido. Separa una aplicación en tres partes:

```
Usuario ──→ Controller ──→ Model ──→ Base de datos
                 │
                 └──→ View ──→ Pantalla del usuario
```

| Parte | Qué hace | Ejemplo |
|---|---|---|
| **Model** | Maneja los datos y la lógica de negocio | Clase `Empleado`, conexión a BD, consultas SQL |
| **View** | Lo que ve el usuario | HTML, pantalla, JSON que devuelve la API |
| **Controller** | Recibe el request, llama al Model, devuelve la View | `EmpleadoController.java` que recibe un GET y devuelve la lista |

**MVC responde la pregunta:** ¿cómo organizo el código de mi aplicación?

---

## DDD — Domain-Driven Design

DDD es una **forma de pensar y modelar** el software. En lugar de empezar por la base de datos o por las pantallas, empiezas por entender el **dominio del negocio**.

**Dominio** = el problema del negocio que tu software resuelve. Para un sistema de RRHH, el dominio son los empleados, departamentos, puestos, contratos, nóminas.

### Conceptos clave de DDD

**Entidad (Entity):**
Un objeto con identidad única que persiste en el tiempo.
- `Empleado` con su `id_empleado` es una entidad — aunque cambie de departamento, sigue siendo el mismo empleado.

**Value Object:**
Un objeto que se define por sus atributos, no por su identidad.
- `Direccion` (calle, ciudad, código postal) — si dos direcciones tienen los mismos datos, son iguales.

**Aggregate:**
Un grupo de entidades que se tratan como una unidad.
- `Empleado` con su `HistorialSalarios` — siempre los tratas juntos, no por separado.

**Repository:**
La capa que se encarga de buscar y guardar entidades (esconde los detalles de la BD).
- `EmpleadoRepository` tiene métodos como `buscarPorId(id)`, `guardar(empleado)`.

**Service:**
Lógica de negocio que no pertenece naturalmente a ninguna entidad.
- `CalculadoraNomina.calcular(empleado, periodo)` — calcula el pago, pero no es responsabilidad del Empleado ni del Periodo solos.

---

## ¿DDD reemplaza MVC?

**No.** Son cosas diferentes:

| | MVC | DDD |
|---|---|---|
| ¿Qué es? | Patrón de arquitectura de UI/capas | Enfoque de diseño del dominio de negocio |
| ¿Qué responde? | ¿Cómo organizo el código? | ¿Cómo modelo el problema del negocio? |
| Se aplica en... | La estructura del proyecto | El diseño de las clases y sus relaciones |

Pueden coexistir: puedes tener una aplicación MVC donde el **Model** está diseñado siguiendo principios de DDD.

> [!tip] Para la entrevista
> "DDD y MVC no se reemplazan. MVC organiza las capas de la aplicación (vista, controlador, modelo). DDD guía cómo diseñar el modelo de negocio dentro de esas capas."

---

## Bounded Context — Contexto Delimitado

Es uno de los conceptos más importantes de DDD.

**Problema:** en una empresa grande, la palabra "Cliente" puede significar cosas distintas según el área:
- Para Ventas: un cliente es alguien con nombre, email y historial de compras.
- Para Facturación: un cliente es un RFC, razón social y dirección fiscal.
- Para Soporte: un cliente es un número de ticket y nivel de servicio.

Cada área tiene su **contexto delimitado (Bounded Context)**: su propio modelo del concepto "Cliente", con sus propias reglas y su propia base de datos o tablas.

```
┌─────────────────────┐     ┌──────────────────────┐
│  Contexto Ventas    │     │ Contexto Facturación  │
│                     │     │                       │
│  Cliente:           │     │  Cliente:             │
│  - nombre           │     │  - rfc                │
│  - email            │     │  - razon_social       │
│  - historial_compras│     │  - direccion_fiscal   │
└─────────────────────┘     └──────────────────────┘
```

**En la BD:** cada contexto puede tener sus propias tablas, aunque representen el mismo concepto del mundo real.

---

## Microservicios

Los **microservicios** son una arquitectura donde la aplicación se divide en **servicios pequeños e independientes**, cada uno con su propia responsabilidad y su propia base de datos.

```
Aplicación Monolítica:                  Microservicios:
┌──────────────────────────┐            ┌──────────┐  ┌───────────┐
│  Todo en un solo sistema │            │ Empleados│  │  Nómina   │
│  - Empleados             │     vs     │  + BD    │  │   + BD    │
│  - Nómina                │            └──────────┘  └───────────┘
│  - Proyectos             │            ┌──────────┐  ┌───────────┐
│  - Reportes              │            │Proyectos │  │ Reportes  │
│  Una sola BD             │            │  + BD    │  │   + BD    │
└──────────────────────────┘            └──────────┘  └───────────┘
```

### Ventajas de Microservicios

- Cada servicio se puede escalar de forma independiente (si Nómina necesita más CPU, solo escala Nómina)
- Equipos diferentes pueden trabajar en servicios diferentes sin interferirse
- Si un servicio falla, los demás siguen funcionando
- Puedes usar diferentes tecnologías en cada servicio (un servicio en Java, otro en Python)

### Desventajas

- Más complejo de operar (necesitas gestionar múltiples servicios, contenedores, redes)
- La comunicación entre servicios (APIs REST, mensajería) agrega latencia y complejidad
- Las transacciones entre servicios son difíciles (no puedes usar un `START TRANSACTION` que abarque dos BDs diferentes)
- No tiene sentido para equipos pequeños o proyectos simples

### Relación con Bounded Context

Cada microservicio suele corresponder a un Bounded Context: el servicio de Empleados tiene su propio contexto y su propia BD, el servicio de Nómina tiene el suyo.

---

## Resumen para la entrevista

**MVC:** patrón de 3 capas (Model, View, Controller) para organizar el código de una aplicación.

**DDD:** enfoque de diseño donde el código refleja el lenguaje y los conceptos del negocio (entidades, repositorios, servicios de dominio).

**¿DDD reemplaza MVC?** No. Se complementan — MVC organiza las capas, DDD organiza el modelo de negocio dentro de esas capas.

**Bounded Context:** cada área del negocio tiene su propio modelo del dominio. El concepto "Cliente" en Ventas es diferente al "Cliente" en Facturación — son contextos separados.

**Microservicios:** arquitectura donde cada funcionalidad es un servicio independiente con su propia BD. Ventaja: escalabilidad y autonomía. Desventaja: complejidad operativa.
