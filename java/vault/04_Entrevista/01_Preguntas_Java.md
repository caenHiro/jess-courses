---
tema: Preguntas de entrevista — Java
estado: completo
---

# Preguntas de Entrevista — Java

> Lee la pregunta, intenta responder en voz alta, luego lee la respuesta. No memorices — entiende el concepto.

---

## Fundamentos del lenguaje

**¿Cuál es la diferencia entre Java y Python en términos de tipado?**

- **Java**: tipado **estático** — debes declarar el tipo de cada variable antes de usarla. El compilador detecta errores de tipo antes de ejecutar.
- **Python**: tipado **dinámico** — el tipo se determina en tiempo de ejecución. Más flexible pero los errores se detectan al ejecutar.

```java
// Java: tipo declarado explícitamente
int edad = 25;
String nombre = "Laura";

// Si intentas: String nombre = 25; → error en compilación
```

---

**¿Qué es la JVM (Java Virtual Machine)?**

Es el motor que ejecuta el código Java. Cuando compilas Java, no obtienes código máquina directamente — obtienes **bytecode** (archivo `.class`). La JVM interpreta ese bytecode. Por eso Java es "write once, run anywhere" — el mismo `.class` corre en Windows, Mac o Linux siempre que tengan JVM.

---

**¿Cuál es la diferencia entre `==` e `equals()` en Java?**

- `==`: compara si dos variables apuntan al **mismo objeto en memoria** (referencia).
- `equals()`: compara el **contenido** del objeto.

```java
String a = new String("Laura");
String b = new String("Laura");

System.out.println(a == b);          // false — objetos distintos en memoria
System.out.println(a.equals(b));     // true  — mismo contenido
```

> Siempre usa `equals()` para comparar Strings y objetos. Usa `==` solo para primitivos (`int`, `boolean`, etc.).

---

**¿Qué es `null` y cómo evitar `NullPointerException`?**

`null` significa que una variable de referencia no apunta a ningún objeto. Si intentas llamar un método sobre `null`, obtienes `NullPointerException` — el error más común en Java.

```java
// Problema:
String nombre = null;
System.out.println(nombre.length()); // NullPointerException

// Solución 1: verificar antes
if (nombre != null) {
    System.out.println(nombre.length());
}

// Solución 2: Optional (Java 8+)
Optional<String> opt = Optional.ofNullable(nombre);
opt.ifPresent(n -> System.out.println(n.length()));
```

---

## Programación orientada a objetos

**¿Cuáles son los 4 pilares de la POO?**

1. **Encapsulamiento**: ocultar los detalles internos. Los atributos son `private` y se acceden mediante getters/setters.
2. **Herencia**: una clase hija hereda atributos y métodos de la clase padre con `extends`.
3. **Polimorfismo**: un método puede comportarse diferente según el objeto. Una clase hija puede sobreescribir métodos del padre.
4. **Abstracción**: mostrar solo lo necesario al exterior. Se logra con clases abstractas e interfaces.

---

**¿Cuál es la diferencia entre una clase abstracta y una interfaz?**

| | Clase Abstracta | Interfaz |
|---|---|---|
| Métodos | Puede tener métodos con implementación | Solo métodos abstractos (sin implementación) — hasta Java 7. Desde Java 8 puede tener `default` methods. |
| Atributos | Puede tener atributos con estado | Solo constantes (`public static final`) |
| Herencia | Una clase solo puede extender UNA clase abstracta | Una clase puede implementar MÚLTIPLES interfaces |
| Cuándo usar | Cuando hay comportamiento común entre clases relacionadas | Cuando defines un contrato que varias clases sin relación deben cumplir |

```java
// Clase abstracta
abstract class Empleado {
    String nombre;
    abstract double calcularSalario(); // sin implementación
    void imprimirNombre() { System.out.println(nombre); } // con implementación
}

// Interfaz
interface Exportable {
    void exportarCSV();  // sin implementación
    void exportarPDF();
}
```

---

**¿Qué es el principio SOLID?**

Son 5 principios de diseño orientado a objetos:

- **S** — Single Responsibility: una clase debe tener una sola razón para cambiar.
- **O** — Open/Closed: abierta para extensión, cerrada para modificación.
- **L** — Liskov Substitution: una clase hija debe poder reemplazar a su padre sin romper el programa.
- **I** — Interface Segregation: mejor varias interfaces específicas que una grande.
- **D** — Dependency Inversion: depender de abstracciones (interfaces), no de implementaciones concretas.

---

## Java moderno (Java 8+)

**¿Qué es un Stream?**

Una secuencia de elementos sobre la que puedes aplicar operaciones encadenadas (filter, map, reduce) de forma funcional y legible.

```java
List<Integer> salarios = Arrays.asList(35000, 58000, 28000, 92000, 22000);

// Sin streams:
int total = 0;
for (int s : salarios) {
    if (s > 30000) total += s;
}

// Con streams:
int total = salarios.stream()
    .filter(s -> s > 30000)
    .mapToInt(Integer::intValue)
    .sum();
```

---

**¿Qué es una expresión lambda en Java?**

Una función anónima que implementa una interfaz funcional (con un solo método abstracto).

```java
// Antes (Java 7): clase anónima
Comparator<String> comp = new Comparator<String>() {
    public int compare(String a, String b) {
        return a.compareTo(b);
    }
};

// Con lambda (Java 8+):
Comparator<String> comp = (a, b) -> a.compareTo(b);
```

---

## Arquitectura y buenas prácticas

**¿Qué es MVC?**

Model-View-Controller. Patrón de arquitectura que separa:
- **Model**: datos y lógica de negocio (clases, servicios, repositorios)
- **View**: lo que ve el usuario (HTML, JSON de la API)
- **Controller**: recibe el request, llama al Model, devuelve la View

En Spring Boot: `@Controller` / `@RestController`, `@Service`, `@Repository`.

---

**¿Qué es una API REST?**

Una API que sigue el estilo REST: usa HTTP, tiene URLs que representan recursos, y usa los verbos HTTP correctamente:

```
GET    /empleados          → listar todos
GET    /empleados/7        → obtener el empleado 7
POST   /empleados          → crear nuevo empleado
PUT    /empleados/7        → reemplazar el empleado 7
PATCH  /empleados/7        → actualizar parcialmente
DELETE /empleados/7        → eliminar
```

---

**¿Qué es la inyección de dependencias?**

En lugar de que una clase cree sus propias dependencias con `new`, las recibe desde afuera. Esto facilita los tests y el desacoplamiento.

```java
// Sin inyección — acoplado:
class EmpleadoService {
    EmpleadoRepository repo = new EmpleadoRepository(); // crea su propio repo
}

// Con inyección (Spring Boot):
@Service
class EmpleadoService {
    private final EmpleadoRepository repo;

    @Autowired
    EmpleadoService(EmpleadoRepository repo) {
        this.repo = repo; // Spring lo inyecta
    }
}
```
