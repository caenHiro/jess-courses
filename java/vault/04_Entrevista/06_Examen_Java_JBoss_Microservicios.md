---
tags: [entrevista, java, jboss, microservicios, examen, practica]
estado: practica
updated: 2026-07-02
---

# Examen Java, JBoss y Microservicios — INE

> Practica estas preguntas antes de la entrevista.
> Nivel: Desarrollador Sr. / Líder Técnico.
> Para cada pregunta, elige la opción y escribe POR QUÉ la elegiste.

---

## Contexto del examen

Este examen está orientado a un perfil de **Líder de Desarrollo Java** en INE. Las preguntas cubren:
- Java avanzado (concurrencia, colecciones, JVM)
- Patrones de diseño
- Conceptos de microservicios y JBoss

No te preocupes si no sabes todas — algunas son muy avanzadas. Lo importante es razonar bien.

---

## Preguntas

### Pregunta 1 — Fundamento
¿Qué es la programación orientada a objetos y cuáles son sus 4 pilares?

Tu respuesta (escríbela en tus palabras):
_____

> Pista: los 4 pilares son Encapsulamiento, Herencia, Polimorfismo y Abstracción — los viste en semanas 7, 8 y 9.

---

### Pregunta 2 — Singleton seguro

En Java, ¿cuál es la forma más segura de implementar el patrón Singleton considerando **acceso concurrente** (múltiples hilos)?

**A)** Usar una variable estática con `synchronized` en el constructor

**B)** Usar un `enum` con un único valor

**C)** Usar `static final` con inicialización directa

**D)** Usar `volatile` en la variable de instancia

Tu respuesta: _____  
Por qué: _____

> **Concepto nuevo:** Singleton es un patrón donde solo existe UNA instancia de una clase en toda la aplicación. Ejemplo: la conexión a la base de datos.

---

### Pregunta 3 — Colección para concurrencia

En un sistema donde **múltiples hilos** leen y escriben un mapa simultáneamente, ¿cuál es la mejor opción?

**A)** `HashMap`  
**B)** `Hashtable`  
**C)** `ConcurrentHashMap`  
**D)** `Collections.synchronizedMap(new HashMap<>())`

Tu respuesta: _____  
Por qué: _____

> **Concepto nuevo:** En sistemas con múltiples hilos (como un servidor web atendiendo muchos usuarios), el acceso simultáneo a datos compartidos puede causar errores si no se maneja correctamente.

---

### Pregunta 4 — Garbage Collector

¿Cuál Garbage Collector de Java está diseñado para **latencia ultrabaja** (pausas menores a 1ms), ideal para sistemas en tiempo real?

**A)** Serial GC  
**B)** G1GC (Garbage First)  
**C)** ZGC (Z Garbage Collector)  
**D)** Parallel GC

Tu respuesta: _____  
Por qué: _____

> **Concepto nuevo:** El Garbage Collector es la parte de Java que libera automáticamente la memoria que ya no se usa. Diferentes algoritmos tienen diferentes ventajas.

---

### Pregunta 5 — Error al modificar colección

¿Qué pasa si modificas una lista mientras la estás recorriendo con un `for-each`?

```java
List<String> lista = new ArrayList<>();
lista.add("Ana");
lista.add("Juan");
lista.add("María");

for (String nombre : lista) {
    if (nombre.equals("Juan")) {
        lista.remove(nombre);  // ← ¿qué pasa aquí?
    }
}
```

**A)** Elimina "Juan" correctamente  
**B)** Lanza `ConcurrentModificationException`  
**C)** No hace nada (ignora el remove)  
**D)** Elimina todos los elementos

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 6 — `==` vs `equals()`

```java
String a = new String("Hola");
String b = new String("Hola");

System.out.println(a == b);         // ¿qué imprime?
System.out.println(a.equals(b));    // ¿qué imprime?
```

**A)** `true` y `true`  
**B)** `false` y `true`  
**C)** `true` y `false`  
**D)** `false` y `false`

Tu respuesta: _____  
Por qué: _____

> Esta es la más básica — ya la viste en el curso. Recuerda: `==` compara referencias (dónde está en memoria), `equals()` compara el contenido.

---

### Pregunta 7 — Operaciones atómicas

¿Qué clase de Java permite incrementar un contador de forma **segura** desde múltiples hilos sin usar `synchronized`?

**A)** `Integer`  
**B)** `AtomicInteger`  
**C)** `volatile int`  
**D)** `Long`

Tu respuesta: _____  
Por qué: _____

---

### Pregunta 8 — `finalize()`

¿Para qué sirve el método `finalize()` en Java?

**A)** Libera recursos del objeto justo antes de que el Garbage Collector lo elimine  
**B)** Termina la ejecución del programa  
**C)** Cierra todos los hilos activos  
**D)** Guarda el estado del objeto en disco

Tu respuesta: _____  
Por qué: _____

> Dato importante: `finalize()` está **deprecado** desde Java 9. La forma moderna es usar `try-with-resources` para liberar recursos.

---

### Pregunta 9 — ClassLoader

¿Cuál es la función principal del `ClassLoader` en Java?

**A)** Compilar archivos `.java` a `.class`  
**B)** Cargar clases (archivos `.class`) en memoria en tiempo de ejecución  
**C)** Administrar la memoria del heap  
**D)** Ejecutar el método `main()`

Tu respuesta: _____  
Por qué: _____

> Relevante para JBoss: cada aplicación desplegada en JBoss tiene su propio ClassLoader, lo que les permite tener versiones diferentes de la misma librería sin conflictos.

---

### Pregunta 10 — Patrón Factory

```java
// ¿Qué patrón de diseño se aplica aquí?
Connection conn = DriverManager.getConnection(url, user, pass);
```

**A)** Singleton  
**B)** Observer  
**C)** Factory  
**D)** Decorator

Tu respuesta: _____  
Por qué: _____

> Pista: el cliente no sabe qué tipo exacto de `Connection` recibe — MySQL, Oracle, PostgreSQL — solo pide una conexión y `DriverManager` decide cuál crear.

---

### Pregunta 11 — Interfaces para hilos

¿Cuál(es) interface(s) de Java se pueden usar para crear un hilo que **retorne un valor** al terminar?

**A)** Solo `Runnable`  
**B)** Solo `Callable`  
**C)** Ambas: `Runnable` y `Callable`  
**D)** Ninguna — se usa `Thread` directamente

Tu respuesta: _____  
Por qué: _____

> Diferencia clave: `Runnable` tiene `void run()` (no retorna nada). `Callable<V>` tiene `V call()` (retorna un valor y puede lanzar excepciones).

---

## Conceptos que debes poder explicar en voz alta

Practica decir estas definiciones en voz alta — en la entrevista pueden pedirte que expliques:

| Concepto | Explicación en una oración |
|---|---|
| Polimorfismo | Un objeto puede comportarse de formas diferentes según el contexto |
| Encapsulamiento | Ocultar los datos internos y exponer solo lo necesario |
| Herencia | Una clase puede reutilizar el código de otra clase padre |
| Interfaz | Contrato que define qué métodos debe tener una clase, sin implementarlos |
| Excepción checked | Error que el compilador te obliga a manejar (`try-catch` o `throws`) |
| Excepción unchecked | Error en tiempo de ejecución que no es obligatorio manejar |
| Patrón Singleton | Solo existe una instancia de la clase en toda la aplicación |
| Patrón Factory | Una fábrica que crea objetos sin que el cliente sepa el tipo exacto |
| Microservicio | Aplicación pequeña e independiente que hace una sola cosa bien |
| JBoss/WildFly | Servidor de aplicaciones Java donde se despliegan aplicaciones enterprise |
