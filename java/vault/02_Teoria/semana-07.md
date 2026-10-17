# Semana 7 — Clases y Objetos (POO basico)

---

## Objetivo de la semana

Al terminar, Jess debe poder:
- Explicar con sus palabras la diferencia entre clase y objeto
- Crear una clase con atributos y un constructor
- Crear objetos usando `new`
- Agregar metodos a una clase
- Usar `this` para distinguir atributos de parametros
- Proteger atributos con `private` y crear getters/setters
- Tener dos archivos `.java` que trabajen juntos (la clase y el Main)

**No se espera aun que Jess entienda herencia, interfaces, polimorfismo ni clases abstractas. Solo el modelado basico de objetos.**

---

## Analogia clave (enfasis en clase)

> "Una clase es como el molde de un tamal. El molde define la forma: masa, relleno, hoja. Cuando haces un tamal CON ese molde, eso es un objeto. Puedes hacer 100 tamales con el mismo molde — todos tienen la misma estructura (mismos atributos), pero diferente contenido (distintos valores)."

> "El constructor es como llenar la ficha de inscripcion a la escuela. Cuando te inscribes (creas un objeto), tienes que llenar los datos iniciales: nombre, edad, CURP. Sin llenar la ficha, no puedes entrar (no puedes crear el objeto). El constructor define que datos necesita el objeto para existir."

> "Los atributos `private` son como el numero PIN de tu tarjeta. El banco sabe tu saldo (tiene el dato), pero no te lo dice directamente — tienes que ir al cajero (usar el metodo getter) para verlo. Y para cambiarlo, tienes que pasar por el cajero tambien (usar el setter), que puede validar que el nuevo valor sea correcto."

---

## Contenido teorico

### 7.1 El problema que resuelve POO

Hasta la semana 6, el codigo de Jess era una lista de instrucciones. Funciona bien para problemas simples. Pero imagina un sistema que maneja 100 empleados — con lo que sabe, tendria que crear 100 variables separadas para cada dato:

```java
// Sin POO — pesadilla para manejar muchos datos relacionados
String nombre1 = "Jess";
int edad1 = 22;
double salario1 = 15000.0;

String nombre2 = "Carlos";
int edad2 = 30;
double salario2 = 20000.0;

// Para imprimir el empleado 1:
System.out.println(nombre1 + ", " + edad1 + " anos, $" + salario1);
// Para imprimir el empleado 2:
System.out.println(nombre2 + ", " + edad2 + " anos, $" + salario2);
// Imagina hacer esto para 100 empleados...
```

Con POO, creamos una clase `Empleado` que agrupa todos esos datos y operaciones juntos:

```java
// Con POO — limpio, organizado, escalable
Empleado jess = new Empleado("Jess", 22, 15000.0);
Empleado carlos = new Empleado("Carlos", 30, 20000.0);

jess.mostrarInfo();    // el objeto sabe como imprimirse solo
carlos.mostrarInfo();  // mismo metodo, diferente objeto
```

### 7.2 Clase vs Objeto — la diferencia fundamental

| | Clase | Objeto |
|---|---|---|
| ¿Que es? | El MOLDE / PLANTILLA | La COSA REAL creada con el molde |
| ¿Cuantas hay? | UNA sola definicion | MUCHOS objetos del mismo tipo |
| En el codigo | `public class Persona {...}` | `Persona jess = new Persona(...)` |
| Analogia | Receta de tamales | El tamal que hiciste |

### 7.3 Crear una clase — paso a paso

Una clase tiene tres partes principales: atributos, constructor y metodos.

```java
// Archivo: Persona.java
// Convencion: el nombre del archivo DEBE ser igual al nombre de la clase
public class Persona {

    // ============ PARTE 1: ATRIBUTOS ============
    // Los atributos son las caracteristicas del objeto
    // Cada objeto tendra sus propios valores para estos atributos
    // private = solo esta clase puede acceder directamente a estos datos
    private String nombre;    // cada persona tiene un nombre
    private int edad;         // cada persona tiene una edad
    private String ciudad;    // cada persona tiene una ciudad

    // ============ PARTE 2: CONSTRUCTOR ============
    // El constructor se llama automaticamente cuando haces "new Persona(...)"
    // Siempre tiene el MISMO NOMBRE que la clase
    // Nunca tiene tipo de retorno (ni void ni int ni nada)
    public Persona(String nombre, int edad, String ciudad) {
        // this.nombre = el atributo del objeto (la variable de la clase)
        // nombre      = el parametro que recibimos (lo que nos paso quien creo el objeto)
        // Sin "this" Java no sabe cual es cual cuando tienen el mismo nombre
        this.nombre = nombre;
        this.edad = edad;
        this.ciudad = ciudad;
    }

    // ============ PARTE 3: METODOS ============
    // Los metodos definen lo que el objeto puede HACER

    // Metodo que imprime la presentacion de la persona
    // public (sin static) = metodo de instancia, pertenece a cada objeto
    public void saludar() {
        // Dentro de la clase, accedemos a los atributos directamente (sin this ni nada)
        System.out.println("Hola, soy " + nombre + ", tengo " + edad + " anios y vivo en " + ciudad);
    }

    // Metodo que devuelve true si la persona tiene 18 o mas anos
    public boolean esMayorDeEdad() {
        return edad >= 18;
    }
}
```

**Punto critico:** notar que NO hay `static` en los metodos de la clase (a diferencia de lo que hemos hecho hasta ahora). Los metodos de instancia pertenecen al objeto, no a la clase. Este es el cambio mas grande de la semana.

---

### REGLA DE ORO: atributos private — dentro vs fuera de la clase

Esta es la regla mas importante de encapsulamiento y la que mas confunde al principio:

| Desde donde quieres acceder | Atributo `private` | ¿Como? |
|---|---|---|
| Dentro de la MISMA clase | ✅ Acceso DIRECTO | `nombre`, `edad`, `precio` — sin getter |
| Desde OTRA clase (otro archivo) | ❌ Prohibido directo | Debes usar el getter: `getNombre()` |

**Los getters y setters existen para el EXTERIOR.** Dentro de la clase, los metodos usan los atributos directamente. Llamar a un getter dentro de la propia clase funciona, pero es redundante e innecesario.

```java
// Dentro de Persona.java — CORRECTO
public void saludar() {
    System.out.println("Hola, soy " + nombre);   // directo — estamos dentro de la clase
}

// Dentro de Persona.java — TAMBIEN funciona pero es redundante e innecesario
public void saludar() {
    System.out.println("Hola, soy " + getNombre());   // para que llamar al getter si ya tengo el atributo?
}

// Desde Main.java — OBLIGATORIO usar getter
public class Main {
    public static void main(String[] args) {
        Persona jess = new Persona("Jess", 22, "CDMX");
        System.out.println(jess.nombre);     // ERROR de compilacion: private access
        System.out.println(jess.getNombre()); // CORRECTO: el getter es la puerta publica
    }
}
```

---

### REGLA DE ORO: firma de metodo — con parametros vs sin parametros

Un metodo que opera sobre los datos del PROPIO objeto **no necesita parametros para esos datos** — ya los tiene como atributos:

```java
// CORRECTO — usa el atributo precio del objeto directamente
public double calcularPrecioConIVA() {
    return precio * 1.16;   // precio es el atributo de este objeto
}

// INCORRECTO — recibe precio como parametro cuando ya lo tiene como atributo
public double calcularPrecioConIVA(double precio) {
    return precio * 1.16;   // este precio es el parametro, no el atributo
                            // ademas oculta el atributo del objeto (mismo nombre)
}
```

**Cuándo SÍ usar parámetros:** cuando el metodo necesita informacion que el objeto NO tiene.

```java
// El porcentaje de descuento es informacion EXTERNA — no es un atributo del producto
public double calcularConDescuento(double porcentaje) {
    return precio * (1 - porcentaje / 100);   // precio = atributo; porcentaje = parametro externo
}
```

---

### 7.4 Usar la clase — dos archivos, dos responsabilidades

En Java cada clase publica va en su propio archivo `.java`. Para los ejercicios de esta semana siempre tendras DOS archivos en la misma carpeta:

```
semana-07/
├── Persona.java    ← aqui defines la clase (molde)
└── Main.java       ← aqui usas la clase (creas objetos y los pruebas)
```

**Regla importante:** el nombre del archivo debe ser EXACTAMENTE igual al nombre de la clase, con las mismas mayusculas.

| Clase | Nombre del archivo |
|---|---|
| `public class Persona` | `Persona.java` ✅ |
| `public class Persona` | `persona.java` ❌ error |
| `public class Main` | `Main.java` ✅ |

**¿Por que desde `main()` necesito el getter?**

`main()` vive en `Main.java`, que es una clase DIFERENTE a `Persona`. Desde ahí no puedes tocar los atributos `private` directamente:

```
Persona.java                    Main.java
────────────────────            ──────────────────────────────────────
private String nombre;          Persona jess = new Persona(...);
                                jess.nombre    ← ❌ ERROR: private
                                               "Persona.nombre has private access"
public String getNombre() {     jess.getNombre() ← ✅ el getter es la
    return nombre;                              puerta publica al atributo
}
```

El getter es la "ventanilla" que la clase abre al exterior. Adentro de `Persona.java`, tus metodos usan `nombre` directamente. Afuera (en `Main.java`), tienen que pasar por la ventanilla.

Para usar nuestra clase `Persona`, el archivo `Main.java` se ve asi:

```java
// Archivo: Main.java
public class Main {
    public static void main(String[] args) {

        // Crear el primer objeto Persona
        // "new Persona(...)" llama al constructor con esos valores
        // "jess" es la variable que guarda la referencia al objeto
        Persona jess = new Persona("Jess", 22, "Ciudad de Mexico");

        // Crear el segundo objeto Persona
        // Mismo molde (clase Persona), diferente contenido
        Persona carlos = new Persona("Carlos", 30, "Guadalajara");

        // Llamar metodos — la sintaxis es: objeto.metodo()
        jess.saludar();    // imprime la presentacion de jess
        carlos.saludar();  // imprime la presentacion de carlos

        // Acceder al resultado de un metodo
        System.out.println("¿Jess es mayor de edad? " + jess.esMayorDeEdad());   // true
        System.out.println("¿Carlos es mayor de edad? " + carlos.esMayorDeEdad()); // true
    }
}
```

### 7.5 ¿Que es `this`?

`this` es una palabra reservada que significa "este objeto, el que estamos construyendo o usando ahora mismo". Se usa principalmente en el constructor cuando el nombre del parametro es igual al nombre del atributo:

```java
public Persona(String nombre, int edad) {
    // Sin this, Java no sabe si "nombre" es el atributo o el parametro
    // Con this.nombre le decimos: "el nombre del OBJETO"
    this.nombre = nombre;   // this.nombre = atributo del objeto, nombre = parametro
    this.edad = edad;       // this.edad = atributo del objeto, edad = parametro
}
```

Una alternativa para evitar confusiones al principio es usar nombres diferentes:

```java
// Con nombres distintos no necesitas this (pero es menos convencional)
public Persona(String n, int e) {
    nombre = n;   // aqui Java sabe que "nombre" es el atributo porque no hay parametro con ese nombre
    edad = e;
}
```

Usar siempre la version con `this` — es el estandar y Jess lo verifcara en todos los codigos Java del mundo.

### 7.6 Encapsulamiento: private + getters + setters

Encapsulamiento significa "proteger los datos adentro de la clase". En lugar de dejar que cualquiera cambie los atributos directamente, los hacemos `private` y controlamos el acceso con metodos.

¿Por que? Para poder validar. Si el precio puede ser cualquier numero, alguien podria poner un precio negativo. Con un setter, validamos antes de cambiar.

```java
// Archivo: Producto.java
public class Producto {

    // private = nadie fuera de esta clase puede tocar estos atributos directamente
    private String nombre;
    private double precio;
    private String categoria;

    public Producto(String nombre, double precio, String categoria) {
        this.nombre = nombre;
        // En el constructor tambien podemos validar
        // Si el precio es negativo o cero, lo dejamos en 0
        this.precio = precio > 0 ? precio : 0;
        this.categoria = categoria;
    }

    // ---- GETTERS: metodos para OBTENER el valor de un atributo ----
    // Por convencion se llaman getNombreDelAtributo()
    // Son public para que cualquiera pueda leer el valor (pero no modificarlo directamente)

    public String getNombre() {
        return nombre;    // devuelve el valor del atributo nombre
    }

    public double getPrecio() {
        return precio;    // devuelve el valor del atributo precio
    }

    public String getCategoria() {
        return categoria;
    }

    // ---- SETTERS: metodos para CAMBIAR el valor de un atributo ----
    // Por convencion se llaman setNombreDelAtributo()
    // Aqui podemos agregar validaciones

    public void setPrecio(double precio) {
        // Solo cambiamos el precio si el nuevo valor es mayor que 0
        // Si alguien intenta poner un precio negativo, lo ignoramos
        if (precio > 0) {
            this.precio = precio;
        } else {
            System.out.println("Advertencia: el precio debe ser mayor que 0");
        }
    }

    // ---- METODOS DE NEGOCIO: lo que el objeto puede calcular o hacer ----

    public double calcularPrecioConIVA() {
        return precio * 1.16;   // IVA del 16%
    }

    public void mostrarInfo() {
        System.out.println("[" + categoria + "] " + nombre + 
                           " — $" + precio + 
                           " (con IVA: $" + calcularPrecioConIVA() + ")");
    }
}
```

Usando la clase Producto:

```java
public class Main2 {
    public static void main(String[] args) {

        Producto leche = new Producto("Leche entera", 28.50, "Lacteos");
        Producto pan = new Producto("Pan bimbo", 55.0, "Panaderia");

        // Para leer los datos, usamos getters
        System.out.println(leche.getNombre());   // Leche entera
        System.out.println(pan.getPrecio());     // 55.0

        // Para cambiar el precio, usamos el setter (que valida)
        leche.setPrecio(32.0);          // precio actualizado
        leche.setPrecio(-10.0);         // imprime advertencia, precio NO cambia

        // Llamar metodos que calculan cosas
        System.out.println(leche.calcularPrecioConIVA());   // 37.12

        // Llamar el metodo que muestra toda la info
        leche.mostrarInfo();
        pan.mostrarInfo();
    }
}
```

### 7.7 Dos archivos trabajando juntos

En Java, cada clase publica va en su propio archivo. Para la semana 7, Jess tendra archivos separados:

```
codigo/semana-07/
├── Persona.java       <- la clase
├── Main.java          <- el programa principal que usa Persona
├── Producto.java      <- otra clase
├── Main2.java         <- programa que usa Producto
├── CuentaBancaria.java <- otra clase
└── BancoMain.java     <- programa que usa CuentaBancaria
```

Ambos archivos deben estar en la misma carpeta para que Java pueda encontrarlos.

---

## Errores comunes

1. **Poner `static` en los metodos de la clase** — el error conceptual mas frecuente.
   - Ejemplo: `public static void saludar() {...}` dentro de `Persona`.
   - Consecuencia: el metodo no puede acceder a los atributos del objeto (nombre, edad), porque pertenece a la clase, no al objeto.
   - Como corregirlo: quitar `static`. Los metodos de instancia no llevan static.

2. **Olvidar el `this` en el constructor cuando los nombres son iguales** — el atributo no se inicializa.
   - Ejemplo: `public Persona(String nombre) { nombre = nombre; }` — esto no hace nada (asigna el parametro a si mismo).
   - Como detectarlo: despues de crear el objeto, `getNombre()` devuelve `null`.
   - Como corregirlo: `this.nombre = nombre;` para distinguir atributo de parametro.

3. **Intentar acceder a un atributo private desde afuera de la clase** — error de compilacion.
   - Ejemplo: en `Main.java` hacer `jess.nombre = "Carlos";` cuando `nombre` es private.
   - Como detectarlo: el compilador dice "nombre has private access in Persona".
   - Como corregirlo: usar el getter `jess.getNombre()` para leer, o crear un setter para modificar.

4. **Nombre del archivo diferente al nombre de la clase** — Java no compila.
   - Ejemplo: clase `Persona` guardada como `persona.java` (minuscula).
   - Como detectarlo: error "class Persona is public, should be declared in a file named Persona.java".
   - Como corregirlo: el nombre del archivo debe ser EXACTAMENTE igual al nombre de la clase, incluidas mayusculas.

5. **Crear el objeto sin `new`** — error de compilacion.
   - Ejemplo: `Persona jess = Persona("Jess", 22, "CDMX");` — falta el `new`.
   - Como detectarlo: el compilador dice algo sobre no poder convertir tipos.
   - Como corregirlo: `Persona jess = new Persona("Jess", 22, "CDMX");`

6. **Llamar metodo de instancia con la clase en lugar del objeto** — confusion comun.
   - Ejemplo: `Persona.saludar()` en lugar de `jess.saludar()`.
   - Como detectarlo: error "cannot make a static reference to non-static method".
   - Como corregirlo: siempre llamar el metodo sobre el objeto: `jess.saludar()`.

7. **Usar getters dentro de la propia clase** — no es un error de compilacion, pero indica que Jess no entendio la regla de acceso.
   - Ejemplo: dentro de `mostrarInfo()` en `Producto.java` hacer `getNombre()` en vez de `nombre`.
   - Por que pasa: Jess cree que `private` significa "siempre necesito getter", cuando significa "solo acceso directo desde dentro de la clase".
   - Como corregirlo: dentro de la clase usa los atributos directamente. Los getters son para cuando otro archivo quiere leer el dato.

8. **Metodo que usa atributo del objeto, pero lo recibe como parametro** — firma incorrecta.
   - Ejemplo: `public double precioConIva(double precio)` dentro de `Producto`, cuando `precio` ya es un atributo.
   - Consecuencia: al llamarlo desde `mostrarInfo()` hay que hacer `precioConIva(getPrecio())` — redundante y confuso.
   - Como corregirlo: `public double calcularPrecioConIVA()` sin parametros, usando directamente `precio` (el atributo).

9. **Dos clases `public` en el mismo archivo** — error de compilacion en Java.
   - Ejemplo: `Persona.java` con `public class Persona { }` y `public class Main { }` adentro.
   - Como detectarlo: el compilador dice "class Main is public, should be declared in a file named Main.java".
   - Como corregirlo: cada clase publica va en su propio archivo. `Persona.java` solo tiene `class Persona`. `Main.java` solo tiene `class Main`. Ambos archivos van en la misma carpeta.

---

## Soluciones

### Persona.java

```java
// Archivo: Persona.java
public class Persona {

    // Atributos privados — protegidos adentro de la clase
    private String nombre;
    private int edad;
    private String ciudad;

    // Constructor — se llama al hacer "new Persona(...)"
    // Recibe los datos iniciales del objeto
    public Persona(String nombre, int edad, String ciudad) {
        this.nombre = nombre;   // this.nombre = atributo del objeto
        this.edad = edad;
        this.ciudad = ciudad;
    }

    // Metodo de instancia — imprime presentacion
    // Sin static porque necesita acceder a los atributos del objeto
    public void saludar() {
        System.out.println("Hola, soy " + nombre + ", tengo " + edad + " anios y vivo en " + ciudad);
    }

    // Metodo que devuelve boolean
    public boolean esMayorDeEdad() {
        return edad >= 18;
    }

    // Getters — para que el Main pueda leer los atributos
    public String getNombre() { return nombre; }
    public int getEdad() { return edad; }
    public String getCiudad() { return ciudad; }
}
```

### Main.java (usa Persona)

```java
// Archivo: Main.java
public class Main {
    public static void main(String[] args) {

        // Crear dos objetos Persona con "new"
        Persona jess = new Persona("Jess", 22, "Ciudad de Mexico");
        Persona abuela = new Persona("Guadalupe", 68, "Oaxaca");

        // Llamar metodos sobre cada objeto
        jess.saludar();    // Hola, soy Jess, tengo 22 anios y vivo en Ciudad de Mexico
        abuela.saludar();  // Hola, soy Guadalupe, tengo 68 anios y vivo en Oaxaca

        // Usar los getters para acceder a datos especificos
        System.out.println(jess.getNombre() + " tiene " + jess.getEdad() + " anios");

        // Usar el resultado del metodo en un if
        if (jess.esMayorDeEdad()) {
            System.out.println(jess.getNombre() + " es mayor de edad");
        }
    }
}
```

### Producto.java

```java
// Archivo: Producto.java
public class Producto {

    // Atributos privados — nadie los toca directamente desde afuera
    private String nombre;
    private double precio;
    private String categoria;

    // Constructor con validacion del precio
    public Producto(String nombre, double precio, String categoria) {
        this.nombre = nombre;
        // Operador ternario: condicion ? valor_si_true : valor_si_false
        // Si precio > 0, usamos precio; si no, usamos 0
        this.precio = precio > 0 ? precio : 0;
        this.categoria = categoria;
    }

    // Getters
    public String getNombre() { return nombre; }
    public double getPrecio() { return precio; }
    public String getCategoria() { return categoria; }

    // Setter con validacion — solo cambia el precio si es valido
    public void setPrecio(double precio) {
        if (precio > 0) {
            this.precio = precio;
        }
    }

    // Calcula el precio incluyendo IVA del 16%
    public double calcularPrecioConIVA() {
        return precio * 1.16;
    }

    // Muestra toda la informacion del producto en una sola linea
    public void mostrarInfo() {
        System.out.println("[" + categoria + "] " + nombre + 
                           " — $" + precio + 
                           " (con IVA: $" + calcularPrecioConIVA() + ")");
    }
}
```

### Main2.java (usa Producto)

```java
// Archivo: Main2.java
public class Main2 {
    public static void main(String[] args) {

        // Crear productos como si fuera un tianguis
        Producto tortillas = new Producto("Tortillas 1kg", 25.0, "Basicos");
        Producto chile = new Producto("Chile serrano", 18.0, "Verduras");
        Producto refresco = new Producto("Coca-Cola 600ml", 22.0, "Bebidas");

        // Mostrar informacion de todos los productos
        System.out.println("=== Productos del tianguis ===");
        tortillas.mostrarInfo();
        chile.mostrarInfo();
        refresco.mostrarInfo();

        // Actualizar precio
        tortillas.setPrecio(28.0);
        System.out.println("\nDespues del aumento:");
        tortillas.mostrarInfo();

        // Intento de precio invalido (no cambia nada)
        refresco.setPrecio(-5.0);   // setter lo ignora silenciosamente
        System.out.println("Precio del refresco: $" + refresco.getPrecio()); // sigue en 22.0
    }
}
```

### CuentaBancaria.java (reto)

```java
// Archivo: CuentaBancaria.java
public class CuentaBancaria {

    // Atributos privados
    private String titular;
    private double saldo;
    private String numeroCuenta;

    // Constructor — valida que el saldo inicial no sea negativo
    public CuentaBancaria(String titular, double saldoInicial, String numeroCuenta) {
        this.titular = titular;
        // Si alguien intenta abrir una cuenta con saldo negativo, la dejamos en 0
        this.saldo = saldoInicial >= 0 ? saldoInicial : 0;
        this.numeroCuenta = numeroCuenta;
    }

    // Depositar dinero — suma al saldo si la cantidad es valida
    public void depositar(double cantidad) {
        if (cantidad > 0) {
            saldo += cantidad;   // equivale a: saldo = saldo + cantidad
            System.out.println("Deposito: $" + cantidad + " — Nuevo saldo: $" + saldo);
        } else {
            System.out.println("La cantidad a depositar debe ser mayor que cero");
        }
    }

    // Retirar dinero — solo si hay suficiente saldo
    public void retirar(double cantidad) {
        if (cantidad > saldo) {
            // No hay suficiente saldo — no se hace el retiro
            System.out.println("Fondos insuficientes. Saldo actual: $" + saldo);
        } else {
            saldo -= cantidad;   // equivale a: saldo = saldo - cantidad
            System.out.println("Retiro: $" + cantidad + " — Nuevo saldo: $" + saldo);
        }
    }

    // Getter del saldo
    public double getSaldo() {
        return saldo;
    }

    // Metodo que muestra el resumen de la cuenta
    public void mostrarResumen() {
        System.out.println("Cuenta: " + numeroCuenta + 
                           " | Titular: " + titular + 
                           " | Saldo: $" + saldo);
    }
}
```

### BancoMain.java (usa CuentaBancaria)

```java
// Archivo: BancoMain.java
public class BancoMain {
    public static void main(String[] args) {

        // Abrir dos cuentas
        CuentaBancaria cuentaJess = new CuentaBancaria("Jessica Escalona", 500.0, "MX-001");
        CuentaBancaria cuentaCarlos = new CuentaBancaria("Carlos Escalona", 1000.0, "MX-002");

        System.out.println("=== Estado inicial ===");
        cuentaJess.mostrarResumen();
        cuentaCarlos.mostrarResumen();

        System.out.println("\n=== Transacciones ===");
        cuentaJess.depositar(200.0);    // Jess recibe dinero
        cuentaCarlos.retirar(300.0);    // Carlos retira
        cuentaJess.retirar(1000.0);     // Jess intenta retirar mas de lo que tiene (falla)
        cuentaCarlos.depositar(50.0);

        System.out.println("\n=== Estado final ===");
        cuentaJess.mostrarResumen();
        cuentaCarlos.mostrarResumen();
    }
}
```

---

## Criterios de calificacion — Semana 7

| Criterio | Puntos |
|----------|--------|
| Las clases compilan y los objetos se crean correctamente con `new` | 2 pts |
| El constructor inicializa correctamente todos los atributos con `this` | 2 pts |
| Los atributos son `private` y tienen getters/setters donde corresponde | 2 pts |
| Los metodos funcionan correctamente (saludar, depositar, retirar, etc.) | 2 pts |
| Reflexion completada con respuestas propias | 2 pts |
| **Total** | **10 pts** |

---

## Senales de alerta

- Si Jess pone `static` en todos los metodos: es normal al principio (viene de las semanas anteriores donde todo era static). Explicar: "static = de la clase. Sin static = del objeto. Los metodos que usan atributos del objeto no pueden ser static."
- Si le cuesta entender `this`: usar el ejemplo del formulario. "Cuando el formulario pregunta 'nombre', se refiere al dato de ESTA persona especifica que se esta inscribiendo ahora. `this.nombre` es el nombre de ESTE objeto."
- Si se confunde con dos archivos `.java`: aclarar que ambos deben estar en la MISMA carpeta. Java los encuentra solos cuando estan en el mismo directorio.
- Si los getters se le olvidan y accede directamente a los atributos: recibira error de compilacion. Esto es BUENO — significa que el encapsulamiento funciona. Guiarle al getter correspondiente.
- Si el reto de CuentaBancaria le parece muy dificil: hacer Persona y Producto primero. La cuenta bancaria puede quedarse para la siguiente clase si es necesario.
- Si Jess pregunta "¿para que sirve todo esto?": mostrarle el ejemplo del inicio — 100 empleados sin POO vs 100 empleados con POO. La escala lo hace evidente.
- Si Jess llama getters dentro de la propia clase: preguntar "¿desde que archivo estas llamando esto?" Si la respuesta es "desde dentro de Producto.java", decirle "entonces tienes acceso directo a los atributos, no necesitas ir por la puerta de atras". Mostrar la REGLA DE ORO: dentro = directo, fuera = getter.
- Si Jess define un metodo con un parametro que ya es atributo del objeto: preguntarle "¿el objeto ya sabe su precio? ¿entonces para que se lo mandamos?". Que ella misma llegue a la conclusion de que el metodo debe usar el atributo directamente.
- Si Jess pega dos clases en el mismo archivo: mostrarle el error del compilador y explicar la regla: "un archivo .java = una clase publica. El nombre del archivo es el nombre de la clase."
