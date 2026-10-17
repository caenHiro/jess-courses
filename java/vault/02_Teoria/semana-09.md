# Semana 9 — Interfaces y Clases Abstractas

---

## Objetivo de la semana

Al terminar, Jess debe poder:
- Explicar con sus palabras qué es una interfaz y para qué sirve
- Crear una interfaz con `interface` e implementarla con `implements`
- Implementar múltiples interfaces en una misma clase
- Crear una clase abstracta con `abstract` y entender por qué no se puede instanciar
- Distinguir cuándo usar interfaz versus clase abstracta

**Ya sabe:** clases, objetos, herencia (`extends`), polimorfismo, `@Override`, `super()`, `protected`.  
**No ha visto:** `ArrayList`, excepciones, SQL, genéricos.

---

## Analogía clave (énfasis en clase)

> "Una interfaz es como un formulario de requisitos del trabajo. Dice: 'para trabajar aquí necesitas: hablar inglés, saber Excel, tener licencia de manejo'. No dice cómo aprendiste inglés ni cómo conseguiste la licencia — eso lo decides tú. Solo dice QUÉ debes poder hacer."

> "Una clase abstracta es como una receta base de cocina. La receta de 'pan dulce' tiene partes comunes escritas (mezcla la harina, agrega azúcar) pero deja en blanco el paso 'agrega el sabor' — porque cada panadero decide si pone cajeta, chocolate o vainilla."

Conectar con lo que ya sabe: "La semana pasada aprendiste herencia — una clase hijo que extiende una clase padre. Las interfaces son parecidas pero en lugar de heredar CÓDIGO, heredas una OBLIGACIÓN: si usas esta interfaz, TIENES que implementar estos métodos."

---

## Recordatorio — archivos de esta semana

Esta semana hay mas archivos que nunca porque cada interfaz, clase abstracta y clase concreta va en su propio `.java`:

```
semana-09/
├── MetodoPago.java        ← interfaz (solo firmas, sin cuerpo)
├── PagoTarjeta.java       ← implementa MetodoPago
├── PagoEfectivo.java      ← implementa MetodoPago
├── Vehiculo.java          ← clase abstracta (abstract class)
├── Auto.java              ← extends Vehiculo
├── Camion.java            ← extends Vehiculo
└── Main.java              ← crea objetos y prueba todo
```

Las reglas siguen siendo las mismas:
- Un archivo `.java` = una clase/interfaz publica
- Nombre del archivo = nombre exacto de la clase/interfaz
- Desde `Main.java` (clase diferente) → necesitas getters para atributos `private`
- Dentro de cada clase → accedes a tus propios atributos directamente

---

## Contenido teórico

### 9.1 ¿Qué es una interfaz?

Una interfaz define QUÉ debe hacer una clase, sin decir CÓMO lo hace. Es un contrato. Cualquier clase que implemente la interfaz debe proporcionar la implementación de todos sus métodos.

```java
// Definimos la interfaz con la palabra "interface"
// Una interfaz solo tiene FIRMAS de métodos (sin cuerpo)
public interface MetodoPago {
    // Solo la firma: qué recibe y qué devuelve
    // Sin llaves {}, sin código adentro
    boolean pagar(double cantidad);       // devuelve true si el pago fue exitoso
    String obtenerNombre();               // devuelve el nombre del método de pago
}
// IMPORTANTE: no hay constructor, no hay atributos normales,
// solo la declaración de qué métodos deben existir
```

Una clase que "firma el contrato" usa `implements`:

```java
// PagoTarjeta IMPLEMENTA (firma el contrato de) MetodoPago
public class PagoTarjeta implements MetodoPago {
    private String numeroTarjeta;   // atributo propio de esta clase

    public PagoTarjeta(String numero) {
        this.numeroTarjeta = numero;   // guardamos el número de tarjeta
    }

    // OBLIGATORIO: implementar TODOS los métodos de la interfaz
    @Override
    public boolean pagar(double cantidad) {
        // aquí decidimos CÓMO se paga con tarjeta
        System.out.println("Tarjeta " + numeroTarjeta + ": pagando $" + cantidad);
        return true;   // la tarjeta siempre acepta (simulamos éxito)
    }

    @Override
    public String obtenerNombre() {
        return "Tarjeta de crédito/débito";   // nombre descriptivo de este método de pago
    }
}
```

### 9.2 Implementar múltiples interfaces

Una clase puede implementar VARIAS interfaces al mismo tiempo (separadas por coma). Esto es algo que la herencia simple no permite.

```java
// Primera interfaz
public interface Vendible {
    double getPrecioVenta();   // debe poder decir cuánto cuesta
}

// Segunda interfaz
public interface Almacenable {
    int getStock();                  // debe poder decir cuántas unidades hay
    void reducirStock(int cantidad); // debe poder reducir el stock
}

// Producto implementa DOS interfaces al mismo tiempo
public class Producto implements Vendible, Almacenable {
    private String nombre;   // nombre del producto
    private double precio;   // precio de venta
    private int stock;       // cuántas unidades quedan

    public Producto(String nombre, double precio, int stock) {
        this.nombre = nombre;   // guardamos nombre
        this.precio = precio;   // guardamos precio
        this.stock = stock;     // guardamos stock inicial
    }

    // Implementación de Vendible
    @Override
    public double getPrecioVenta() {
        return precio;   // devolvemos el precio de este producto
    }

    // Implementación de Almacenable — método 1
    @Override
    public int getStock() {
        return stock;   // devolvemos cuántas unidades quedan
    }

    // Implementación de Almacenable — método 2
    @Override
    public void reducirStock(int cantidad) {
        // validamos que haya suficiente stock antes de reducir
        if (stock >= cantidad) {
            stock -= cantidad;   // reducimos el stock
        } else {
            System.out.println("Stock insuficiente");   // avisamos si no hay suficiente
        }
    }
}
```

### 9.3 Clases abstractas — a medio camino

Una **clase abstracta** no puede instanciarse directamente (no puedes hacer `new ClaseAbstracta()`). Puede tener:
- Métodos abstractos (sin implementación — los hijos DEBEN implementarlos)
- Métodos concretos (con implementación — los hijos los heredan tal cual)
- Atributos normales

```java
// abstract en la declaración indica que esta clase no se puede instanciar
public abstract class Vehiculo {
    protected String marca;          // atributo que todos los vehículos tienen
    protected String modelo;         // atributo que todos los vehículos tienen
    protected int velocidadMaxima;   // atributo que todos los vehículos tienen

    // Constructor de la clase abstracta — los hijos lo llaman con super()
    public Vehiculo(String marca, String modelo, int velocidadMaxima) {
        this.marca = marca;
        this.modelo = modelo;
        this.velocidadMaxima = velocidadMaxima;
    }

    // Método CONCRETO: tiene implementación, todos los hijos lo heredan igual
    public void mostrarInfo() {
        System.out.println(marca + " " + modelo + " — vel. max: " + velocidadMaxima + " km/h");
    }

    // Método ABSTRACTO: sin implementación, el hijo DEBE implementarlo
    // Cada vehículo consume diferente — no sabemos la cantidad aquí
    public abstract double calcularConsumo(double km);
    // Nota: sin llaves {}, termina en punto y coma
}
```

```java
// Auto extiende Vehiculo (igual que herencia normal con extends)
public class Auto extends Vehiculo {
    public Auto(String marca, String modelo) {
        // Llamamos al constructor del padre con super()
        super(marca, modelo, 200);   // velocidad máxima de un auto: 200 km/h
    }

    // OBLIGATORIO: implementar el método abstracto del padre
    @Override
    public double calcularConsumo(double km) {
        return km * 0.08;   // un auto consume 0.08 litros por km
    }
}

public class Camion extends Vehiculo {
    public Camion(String marca, String modelo) {
        super(marca, modelo, 120);   // velocidad máxima de camión: 120 km/h
    }

    @Override
    public double calcularConsumo(double km) {
        return km * 0.25;   // un camión consume más: 0.25 litros por km
    }
}

public class Moto extends Vehiculo {
    public Moto(String marca, String modelo) {
        super(marca, modelo, 180);   // velocidad máxima de moto: 180 km/h
    }

    @Override
    public double calcularConsumo(double km) {
        return km * 0.04;   // una moto es la más eficiente: 0.04 litros por km
    }
}
```

### 9.4 ¿Interfaz o clase abstracta? — Tabla comparativa

| Característica | Interfaz | Clase abstracta |
|---------------|----------|----------------|
| Palabra clave | `interface` / `implements` | `abstract class` / `extends` |
| Métodos con código | No (solo firmas, hasta Java 7) | Sí (puede mezclar) |
| Atributos normales | No | Sí |
| Cuántas puede usar una clase | Muchas (`implements A, B, C`) | Solo una (`extends A`) |
| Relación que expresa | "puede hacer X" | "es un tipo de X" |
| Constructor | No tiene | Sí tiene |

**Regla práctica:**
- Usa **interfaz** cuando quieres definir un CONTRATO de capacidades que clases muy diferentes pueden cumplir (un Auto y una Bicicleta pueden ambos implementar `Conducible`, aunque no se parecen).
- Usa **clase abstracta** cuando hay código COMÚN que todos los hijos comparten, más alguna parte que cada hijo personaliza.

---

## Errores comunes

1. **Olvidar implementar algún método de la interfaz** — Java lanza error "clase no abstracta no implementa el método X". Revisar que estén TODOS los métodos definidos en la interfaz.

2. **Intentar hacer `new MetodoPago()`** — las interfaces no tienen constructor y no se pueden instanciar. Solo se pueden instanciar las clases que las implementan.

3. **Intentar hacer `new Vehiculo("Toyota", "Camry", 200)`** — las clases abstractas tampoco se pueden instanciar directamente. El error del compilador lo dice claramente.

4. **Olvidar `@Override` en la implementación de la interfaz** — el código compila pero es mala práctica y si hay un typo no lo detecta. Insistir en siempre poner `@Override`.

5. **Confundir `implements` y `extends`** — interfaces se usan con `implements`, clases abstractas con `extends`. Ambas palabras son para cosas diferentes. Si ve un error "cannot extend interface", está usando la palabra equivocada.

6. **Creer que interfaz y clase abstracta son lo mismo** — señalar la diferencia clave: la interfaz SOLO define firmas (el qué), la clase abstracta puede tener código compartido (parte del cómo) más partes que el hijo debe implementar.

---

## Soluciones

### Ejercicio 1 — Sistema de pagos

**MetodoPago.java** (la interfaz — el contrato)
```java
// interface en lugar de class — esto define un contrato
public interface MetodoPago {
    // Solo firmas: qué debe poder hacer cualquier método de pago
    // Sin implementación, sin código, sin llaves {}
    boolean pagar(double cantidad);   // devuelve true=éxito, false=rechazado
    String obtenerNombre();           // nombre descriptivo del método
}
```

**PagoTarjeta.java**
```java
// implements MetodoPago: PagoTarjeta se compromete a cumplir el contrato
public class PagoTarjeta implements MetodoPago {
    private String numeroTarjeta;   // número de la tarjeta (solo últimos 4 dígitos p.ej.)

    public PagoTarjeta(String numero) {
        this.numeroTarjeta = numero;   // guardamos el número de tarjeta
    }

    // Implementamos pagar() — aquí decidimos CÓMO paga la tarjeta
    @Override
    public boolean pagar(double cantidad) {
        // Simulamos: la tarjeta siempre acepta (en la vida real habría validación)
        System.out.println("Tarjeta " + numeroTarjeta);
        return true;   // pago exitoso
    }

    // Implementamos obtenerNombre() — nombre descriptivo de este tipo de pago
    @Override
    public String obtenerNombre() {
        return "Tarjeta de crédito/débito";
    }
}
```

**PagoEfectivo.java**
```java
public class PagoEfectivo implements MetodoPago {
    private double efectivoDisponible;   // cuánto efectivo tiene el cliente

    public PagoEfectivo(double efectivo) {
        this.efectivoDisponible = efectivo;   // cuánto trae el cliente
    }

    @Override
    public boolean pagar(double cantidad) {
        // En efectivo SÍ puede fallar si no alcanza el dinero
        if (efectivoDisponible >= cantidad) {
            // Si alcanza: calculamos el cambio y descontamos del efectivo
            double cambio = efectivoDisponible - cantidad;    // lo que sobra
            efectivoDisponible -= cantidad;                   // descontamos del disponible
            System.out.println("Pago en efectivo: $" + cantidad);
            System.out.println("Cambio: $" + cambio);
            return true;   // pago exitoso
        } else {
            // Si no alcanza: avisamos y regresamos false
            System.out.println("Efectivo insuficiente. Tienes $" + efectivoDisponible
                               + " pero necesitas $" + cantidad);
            return false;   // pago fallido
        }
    }

    @Override
    public String obtenerNombre() {
        return "Efectivo";
    }
}
```

**PagoTransferencia.java**
```java
public class PagoTransferencia implements MetodoPago {
    // La transferencia no necesita atributos en esta versión simple

    @Override
    public boolean pagar(double cantidad) {
        // Simulamos el procesamiento de la transferencia
        System.out.println("Procesando transferencia de $" + cantidad + "...");
        System.out.println("Transferencia completada.");
        return true;   // siempre exitosa en esta simulación
    }

    @Override
    public String obtenerNombre() {
        return "Transferencia bancaria";
    }
}
```

**MainPagos.java**
```java
public class MainPagos {
    public static void main(String[] args) {
        // Creamos un array de tipo interfaz MetodoPago
        // Podemos mezclar cualquier clase que implemente la interfaz
        MetodoPago[] metodos = {
            new PagoTarjeta("4532"),       // tarjeta con últimos 4 dígitos
            new PagoEfectivo(600.0),       // cliente trae $600 en efectivo
            new PagoTransferencia()        // transferencia bancaria
        };

        double montoPago = 500.0;   // monto a pagar

        // Polimorfismo: llamamos pagar() en todos — cada uno lo hace a su manera
        for (MetodoPago metodo : metodos) {
            System.out.println("--- " + metodo.obtenerNombre() + " ---");
            boolean exito = metodo.pagar(montoPago);   // cada clase decide cómo paga
            if (exito) {
                System.out.println("Pago aprobado.");
            } else {
                System.out.println("Pago rechazado.");
            }
            System.out.println();   // línea en blanco para separar
        }
    }
}
```

---

### Ejercicio 2 — Clase abstracta Vehículo

**Vehiculo.java**
```java
// abstract: no se puede hacer new Vehiculo() directamente
public abstract class Vehiculo {
    protected String marca;          // marca del vehículo (Toyota, Honda...)
    protected String modelo;         // modelo (Camry, Civic...)
    protected int velocidadMaxima;   // velocidad máxima en km/h

    // El constructor SÍ existe pero los hijos lo llaman con super()
    public Vehiculo(String marca, String modelo, int velocidadMaxima) {
        this.marca = marca;
        this.modelo = modelo;
        this.velocidadMaxima = velocidadMaxima;
    }

    // Método CONCRETO: código compartido — todos los vehículos muestran la misma info
    public void mostrarInfo() {
        System.out.println(marca + " " + modelo + " — vel. max: " + velocidadMaxima + " km/h");
    }

    // Método ABSTRACTO: sin código, el hijo DEBE implementarlo
    // Cada vehículo tiene diferente consumo por km
    public abstract double calcularConsumo(double km);
}
```

**Auto.java**
```java
public class Auto extends Vehiculo {
    // Auto es un Vehiculo — usa extends (herencia de clase abstracta)

    public Auto(String marca, String modelo) {
        super(marca, modelo, 200);   // vel. max de auto: 200 km/h
    }

    // OBLIGATORIO implementar el método abstracto del padre
    @Override
    public double calcularConsumo(double km) {
        return km * 0.08;   // un auto consume 0.08 litros por cada kilómetro
    }
}
```

**Camion.java**
```java
public class Camion extends Vehiculo {
    public Camion(String marca, String modelo) {
        super(marca, modelo, 120);   // camiones van más lento, max 120 km/h
    }

    @Override
    public double calcularConsumo(double km) {
        return km * 0.25;   // camión consume mucho más: 0.25 litros por km
    }
}
```

**Moto.java**
```java
public class Moto extends Vehiculo {
    public Moto(String marca, String modelo) {
        super(marca, modelo, 180);   // motos pueden llegar a 180 km/h
    }

    @Override
    public double calcularConsumo(double km) {
        return km * 0.04;   // la moto es muy eficiente: 0.04 litros por km
    }
}
```

**MainVehiculos.java**
```java
public class MainVehiculos {
    public static void main(String[] args) {
        // Creamos vehículos de diferentes tipos
        Vehiculo auto = new Auto("Toyota", "Camry");
        Vehiculo camion = new Camion("Kenworth", "T680");
        Vehiculo moto = new Moto("Yamaha", "MT-07");

        double distancia = 100.0;   // vamos a calcular consumo para 100 km

        // mostrarInfo() viene del padre, calcularConsumo() es de cada hijo
        Vehiculo[] flota = { auto, camion, moto };
        for (Vehiculo v : flota) {
            v.mostrarInfo();   // método concreto del padre — igual para todos
            double litros = v.calcularConsumo(distancia);   // método del hijo — diferente
            System.out.printf("  Consumo en %.0f km: %.2f litros%n%n", distancia, litros);
        }
    }
}
```

---

## Criterios de calificación — Semana 9

| Criterio | Puntos |
|----------|--------|
| Interfaz `MetodoPago` definida correctamente (solo firmas, sin código) | 1 pt |
| Las 3 implementaciones de pago compilan y funcionan | 2 pts |
| `PagoEfectivo` valida correctamente si alcanza el dinero | 1 pt |
| Clase abstracta `Vehiculo` con método abstracto y método concreto | 2 pts |
| Las 3 clases hijas implementan `calcularConsumo()` con valores distintos | 2 pts |
| Reflexión completada con respuestas propias y con sentido | 2 pts |
| **Total** | **10 pts** |

---

## Señales de alerta

- Si intenta poner código en la interfaz (llaves `{}` en los métodos): recordar que la interfaz SOLO tiene firmas — el cómo lo decide cada clase que implemente.
- Si confunde `implements` y `extends`: interfaz usa `implements`, herencia/clase abstracta usa `extends`. Es común mezclarlos al principio.
- Si intenta instanciar la interfaz (`new MetodoPago()`): explicar con la analogía del formulario — el formulario en sí no hace nada, necesitas a alguien que lo llene.
- Si intenta instanciar la clase abstracta (`new Vehiculo(...)`): es intencional que no se pueda. Un "vehículo genérico" no existe — necesitas saber si es auto, camión o moto.
- Si pregunta "¿para qué sirve todo esto si puedo hacer clases normales?": mostrar el ejemplo del array `MetodoPago[]` — puedes agregar un nuevo método de pago en el futuro sin cambiar el código que procesa los pagos. Eso es flexibilidad.
