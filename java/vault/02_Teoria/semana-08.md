# Semana 8 — Herencia y Polimorfismo

---

## Objetivo de la semana

Al terminar, Jess debe poder:
- Explicar con sus palabras qué es la herencia y cuándo usarla
- Crear una clase hijo con `extends` que herede de una clase padre
- Usar `super(...)` en el constructor del hijo para llamar al padre
- Sobreescribir un método con `@Override`
- Explicar qué es polimorfismo con un ejemplo propio

**Ya sabe:** clases, objetos, atributos, métodos, constructores, `this`, encapsulamiento, `Scanner`, ciclos, condicionales.  
**No ha visto:** interfaces, clases abstractas, `ArrayList`, excepciones, SQL.

---

## Analogía clave (énfasis en clase)

> "Imagínate que en el mercado hay un puesto de 'Comida'. Todos los puestos de comida tienen cosas en común: un nombre, un precio, una forma de servir. Pero el puesto de tacos sirve diferente al de tortas, que sirve diferente al de quesadillas. Cada uno hereda las características básicas de 'puesto de comida', pero hace las cosas a su manera."

> "Polimorfismo es como pedir 'la comida' sin importar cuál es. Si pides 'sirve()' a cualquier puesto, cada uno te sirve lo suyo — tacos, tortas o quesadillas — aunque usaste la misma palabra."

Conectar con lo que ya sabe: "Ya sabes crear clases y objetos. Herencia es crear una clase nueva que ya trae todo lo de otra clase, y encima puede agregar o cambiar cosas."

---

## Contenido teórico

### 8.1 ¿Qué es herencia?

Herencia permite crear una clase nueva ("hijo" o "subclase") basada en una clase ya existente ("padre" o "superclase"). El hijo recibe todos los atributos y métodos del padre, sin tener que volver a escribirlos.

**Relación correcta para usar herencia: "ES UN"**
- Un Perro **es un** Animal → herencia correcta
- Un Gato **es un** Animal → herencia correcta
- Un auto **tiene un** motor → NO es herencia (es un atributo)

Si la frase "X ES UN Y" tiene sentido, se puede usar herencia.

### 8.2 Crear herencia con `extends`

```java
// Clase PADRE — la base
public class Animal {
    // protected: el hijo SÍ puede acceder, pero clases externas NO
    protected String nombre;   // atributo que TODOS los animales van a tener
    protected String especie;  // atributo que TODOS los animales van a tener

    // Constructor del padre: recibe nombre y especie
    public Animal(String nombre, String especie) {
        this.nombre = nombre;     // guarda el nombre en el objeto
        this.especie = especie;   // guarda la especie en el objeto
    }

    // Métodos que TODOS los animales heredan
    public void comer() {
        // cualquier hijo puede llamar este método sin redefinirlo
        System.out.println(nombre + " está comiendo.");
    }

    public void dormir() {
        // igual, disponible para todos los hijos
        System.out.println(nombre + " está durmiendo.");
    }

    // Este método lo va a sobreescribir cada hijo a su manera
    public void hacerSonido() {
        System.out.println("...");   // sonido genérico (el padre no sabe qué animal es)
    }
}
```

```java
// Clase HIJO — extiende (hereda de) Animal
public class Perro extends Animal {

    // Constructor del hijo — solo pide nombre, la especie ya la sabe
    public Perro(String nombre) {
        // PRIMERA línea OBLIGATORIA: llamar al constructor del padre con super()
        // "le decimos al padre: inicialízate con este nombre y esta especie"
        super(nombre, "Canis lupus familiaris");
        // si el Perro tuviera atributos propios, los inicializariamos aqui
    }

    // @Override: sobreescribimos el método del padre con comportamiento específico
    @Override
    public void hacerSonido() {
        // nombre viene del PADRE y es protected — el hijo puede usarlo directo
        System.out.println(nombre + ": ¡Guau!");
    }

    // Método PROPIO del Perro — Animal no lo tiene
    public void buscarPelota() {
        System.out.println(nombre + " busca la pelota!");
    }
}
```

**Punto clave — `protected` vs `private`:**

Nota que el padre declara sus atributos con `protected`, no `private`. Esta es la diferencia:

| Modificador | ¿Quien puede acceder? |
|---|---|
| `private` | Solo la propia clase (`Animal`) |
| `protected` | La propia clase + todos sus hijos (`Perro`, `Gato`, `Pajaro`) |
| `public` | Cualquier clase en cualquier archivo |

En herencia usamos `protected` en el padre para que los hijos puedan usar `nombre` y `especie` directamente, igual que en semana 7 usabas `nombre` dentro de los metodos de `Persona`.

**Los archivos para esta semana:**

```
semana-08/
├── Animal.java      ← clase padre
├── Perro.java       ← hijo (extends Animal)
├── Gato.java        ← hijo (extends Animal)
├── Pajaro.java      ← hijo (extends Animal)
└── Main.java        ← crea objetos y prueba todo
```

Cada clase en su propio archivo. El nombre del archivo = nombre de la clase exacto.

### 8.3 La palabra clave `super`

`super` sirve para dos cosas:

**1. Llamar al constructor del padre** — siempre debe ser la PRIMERA línea del constructor hijo:
```java
public Perro(String nombre, String raza) {
    super(nombre, "Canis lupus familiaris");   // llama al constructor de Animal
    this.raza = raza;                          // luego inicializa lo propio del Perro
}
```

**2. Llamar a un método del padre** (cuando el hijo lo sobreescribió pero aún quiere usarlo):
```java
@Override
public void hacerSonido() {
    super.hacerSonido();                     // primero llama al método original del padre
    System.out.println(nombre + ": ¡Guau!"); // luego agrega el comportamiento propio
}
```

### 8.4 Polimorfismo con `@Override`

Polimorfismo significa que el mismo método puede comportarse diferente según el objeto.

```java
// Tres hijos que sobreescriben hacerSonido()
public class Gato extends Animal {
    public Gato(String nombre) {
        super(nombre, "Felis catus");   // llama constructor del padre
    }

    @Override
    public void hacerSonido() {
        System.out.println(nombre + ": ¡Miau!");   // comportamiento específico del Gato
    }

    public void ronronear() {
        System.out.println(nombre + " ronronea...");   // método propio del Gato
    }
}

public class Pajaro extends Animal {
    public Pajaro(String nombre) {
        super(nombre, "Aves");   // llama constructor del padre
    }

    @Override
    public void hacerSonido() {
        System.out.println(nombre + ": ¡Pío!");   // comportamiento específico del Pájaro
    }

    public void volar() {
        System.out.println(nombre + " vuela!");   // método propio del Pájaro
    }
}
```

```java
// En Main — esto ES el polimorfismo en acción
public class Main {
    public static void main(String[] args) {
        // Creamos un array de tipo Animal (el padre)
        // pero cada elemento puede ser cualquier hijo
        Animal[] animales = {
            new Perro("Rex"),    // un Perro guardado como Animal
            new Gato("Luna"),    // un Gato guardado como Animal
            new Pajaro("Piolín") // un Pájaro guardado como Animal
        };

        // El ciclo llama hacerSonido() en TODOS — cada uno hace el SUYO
        for (Animal a : animales) {
            // Java sabe en tiempo de ejecución qué tipo de Animal es
            // y llama al método correcto — ESTO es polimorfismo
            a.hacerSonido();
        }
        // Salida:
        // Rex: ¡Guau!
        // Luna: ¡Miau!
        // Piolín: ¡Pío!
    }
}
```

**Punto clave:** el array es de tipo `Animal`, pero Java detecta en tiempo de ejecución si es Perro, Gato o Pájaro y ejecuta el método correcto. Eso es polimorfismo.

### 8.5 ¿Cuándo usar herencia?

| Situación                       | ¿Herencia?                       |
| ------------------------------- | -------------------------------- |
| Perro **es un** Animal          | Si — `extends Animal`            |
| Círculo **es una** Figura       | Si — `extends Figura`            |
| Auto **tiene un** motor         | No — Motor debe ser atributo     |
| Persona **tiene una** dirección | No — Direccion debe ser atributo |

**Regla:** si tienes que copiar código de una clase a otra, pregúntate si hay una relación "ES UN". Si sí, usa herencia.

---

## Errores comunes

1. **Olvidar `super()` en el constructor hijo** — Java lanza error de compilación porque el padre no se inicializa. Explicar: el hijo SIEMPRE necesita que el padre se construya primero.

2. **`super()` no está en la primera línea** — también es error. Recordar: "el padre va primero, siempre".

3. **Atributo del padre declarado `private` en vez de `protected`** — el hijo no puede acceder. Si la alumna ve `nombre` no funciona en el hijo, revisar que sea `protected`.

4. **Confundir herencia con composición** — si Jess hace un `Carro extends Motor`, detener y preguntar: "¿Un carro ES un motor, o TIENE un motor?" La respuesta guía al diseño correcto.

5. **Olvidar `@Override`** — el código compila pero si hay un typo en el nombre del método, Java no avisa y simplemente crea un método nuevo en lugar de sobreescribir. `@Override` protege de este error.

6. **Intentar acceder a métodos del hijo desde referencia del padre** — si declara `Animal a = new Perro("Rex")`, no puede llamar `a.buscarPelota()` porque Animal no lo tiene. Debe hacer cast: `((Perro)a).buscarPelota()`. Mencionar brevemente si pregunta, no entrar en detalle.

---

## Soluciones

### Ejercicio 1 — Zoológico virtual

**Animal.java**
```java
public class Animal {
    protected String nombre;    // protected: los hijos pueden acceder
    protected String especie;   // protected: los hijos pueden acceder

    // Constructor: recibe los datos básicos de cualquier animal
    public Animal(String nombre, String especie) {
        this.nombre = nombre;     // asignamos el nombre al objeto
        this.especie = especie;   // asignamos la especie al objeto
    }

    // Método que todos los animales pueden usar sin cambios
    public void comer() {
        System.out.println(nombre + " está comiendo.");
    }

    // Método que todos los animales pueden usar sin cambios
    public void dormir() {
        System.out.println(nombre + " está durmiendo.");
    }

    // Este método SERÁ sobreescrito por cada hijo
    public void hacerSonido() {
        System.out.println("...");   // el padre no sabe qué sonido hace
    }
}
```

**Perro.java**
```java
public class Perro extends Animal {
    // extends Animal: Perro hereda nombre, especie, comer(), dormir(), hacerSonido()

    // Constructor del Perro — solo pide nombre, la especie ya la sabe
    public Perro(String nombre) {
        // super() llama al constructor del padre Animal
        // forzamos la especie correcta para todos los perros
        super(nombre, "Canis lupus familiaris");
    }

    // @Override: sobreescribimos hacerSonido() con el sonido del perro
    @Override
    public void hacerSonido() {
        // nombre viene del padre (protected), podemos usarlo aquí
        System.out.println(nombre + ": ¡Guau!");
    }

    // Método propio del Perro — Animal no lo tiene
    public void buscarPelota() {
        System.out.println(nombre + " busca la pelota!");
    }
}
```

**Gato.java**
```java
public class Gato extends Animal {
    // Gato hereda todo de Animal, solo necesita definir lo propio

    public Gato(String nombre) {
        super(nombre, "Felis catus");   // inicializamos al padre con especie de gato
    }

    @Override
    public void hacerSonido() {
        System.out.println(nombre + ": ¡Miau!");   // sonido específico del Gato
    }

    // Método propio del Gato
    public void ronronear() {
        System.out.println(nombre + " ronronea...");
    }
}
```

**Pajaro.java**
```java
public class Pajaro extends Animal {
    // Pajaro hereda todo de Animal

    public Pajaro(String nombre) {
        super(nombre, "Aves");   // inicializamos al padre
    }

    @Override
    public void hacerSonido() {
        System.out.println(nombre + ": ¡Pío!");   // sonido específico del Pájaro
    }

    // Método propio del Pájaro
    public void volar() {
        System.out.println(nombre + " vuela!");
    }
}
```

**Main.java**
```java
public class Main {
    public static void main(String[] args) {
        // Crear un objeto de cada tipo
        Perro perro = new Perro("Rex");
        Gato gato = new Gato("Luna");
        Pajaro pajaro = new Pajaro("Piolín");

        // Demostrar que heredan métodos del padre
        System.out.println("=== Heredados del padre ===");
        perro.comer();    // viene de Animal, no lo escribimos en Perro
        gato.dormir();    // viene de Animal
        pajaro.comer();   // viene de Animal

        // Demostrar polimorfismo con array de tipo padre
        System.out.println("\n=== Polimorfismo ===");
        Animal[] animales = { perro, gato, pajaro };   // array del tipo PADRE
        for (Animal a : animales) {
            a.hacerSonido();   // cada uno ejecuta SU versión del método
        }

        // Métodos propios de cada hijo
        System.out.println("\n=== Métodos propios ===");
        perro.buscarPelota();   // solo el Perro tiene esto
        gato.ronronear();       // solo el Gato tiene esto
        pajaro.volar();         // solo el Pájaro tiene esto
    }
}
```

---

### Ejercicio 2 — Figuras geométricas

**Figura.java**
```java
public class Figura {
    protected String color;   // atributo que toda figura tiene

    // Constructor del padre
    public Figura(String color) {
        this.color = color;   // guardamos el color
    }

    // Este método será sobreescrito por cada figura hija
    public double calcularArea() {
        return 0.0;   // área genérica — no sabemos qué figura es
    }

    // Método que todas las figuras pueden usar tal cual
    public void mostrar() {
        // llama a calcularArea() — que será el del hijo gracias al polimorfismo
        System.out.println("Figura " + color + " — área: " + calcularArea());
    }
}
```

**Circulo.java**
```java
public class Circulo extends Figura {
    private double radio;   // atributo propio del Círculo

    public Circulo(String color, double radio) {
        super(color);         // le pasamos el color al padre
        this.radio = radio;   // guardamos el radio en este objeto
    }

    @Override
    public double calcularArea() {
        // Fórmula del área del círculo: PI × radio²
        // Math.PI es la constante π que Java ya tiene lista
        return Math.PI * radio * radio;
    }
}
```

**Rectangulo.java**
```java
public class Rectangulo extends Figura {
    private double base;    // ancho del rectángulo
    private double altura;  // alto del rectángulo

    public Rectangulo(String color, double base, double altura) {
        super(color);           // inicializamos el padre con el color
        this.base = base;       // guardamos base
        this.altura = altura;   // guardamos altura
    }

    @Override
    public double calcularArea() {
        return base * altura;   // fórmula del área del rectángulo
    }
}
```

**Triangulo.java**
```java
public class Triangulo extends Figura {
    private double base;    // base del triángulo
    private double altura;  // altura del triángulo

    public Triangulo(String color, double base, double altura) {
        super(color);           // inicializamos el padre
        this.base = base;
        this.altura = altura;
    }

    @Override
    public double calcularArea() {
        return base * altura / 2;   // fórmula del área del triángulo: base × altura ÷ 2
    }
}
```

**MainFiguras.java**
```java
public class MainFiguras {
    public static void main(String[] args) {
        // Creamos una figura de cada tipo
        Circulo c = new Circulo("rojo", 5.0);         // círculo rojo con radio 5
        Rectangulo r = new Rectangulo("azul", 4.0, 6.0);  // rectángulo azul 4×6
        Triangulo t = new Triangulo("verde", 3.0, 8.0);   // triángulo verde base 3, altura 8

        // mostrar() está en el padre, calcularArea() es del hijo — polimorfismo
        c.mostrar();   // Figura rojo — área: 78.53...
        r.mostrar();   // Figura azul — área: 24.0
        t.mostrar();   // Figura verde — área: 12.0

        // También podemos crear un array de tipo Figura
        System.out.println("\n=== Con array polimórfico ===");
        Figura[] figuras = { c, r, t };
        for (Figura f : figuras) {
            // Java sabe cuál es Círculo, cuál Rectángulo, cuál Triángulo
            System.out.printf("Área: %.2f%n", f.calcularArea());
        }
    }
}
```

---

## Criterios de calificación — Semana 8

| Criterio | Puntos |
|----------|--------|
| Ejercicio 1: las 4 clases existen y compilan sin error | 2 pts |
| Ejercicio 1: `@Override` en `hacerSonido()` y el polimorfismo funciona correctamente | 2 pts |
| Ejercicio 2: las 4 figuras calculan su área correctamente | 2 pts |
| `super()` usado correctamente en todos los constructores hijos | 1 pt |
| Reflexión completada con respuestas propias y con sentido | 2 pts |
| Uso de `protected` (no `private`) en atributos del padre | 1 pt |
| **Total** | **10 pts** |

---

## Señales de alerta

- Si el código no compila porque "no hay constructor por defecto": el hijo no llama a `super()` o lo llama mal. Revisar que la primera línea del constructor hijo sea `super(...)` con los parámetros correctos.
- Si `nombre` no está accesible en el hijo: el padre lo declaró `private` en lugar de `protected`. Cambiar a `protected`.
- Si `@Override` da error: el nombre del método no coincide exactamente con el del padre. Revisar mayúsculas y parámetros.
- Si Jess dice "para qué sirve el array de tipo Animal": explicar que esto es polimorfismo — se pueden guardar diferentes tipos de animales en una sola lista y tratarlos de la misma forma.
- Si se frustra con cuántos archivos son: recordarle que cada archivo es una clase, y que esto es exactamente lo que hacen los proyectos reales en empresas.
