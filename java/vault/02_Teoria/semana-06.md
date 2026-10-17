# Semana 6 — Metodos

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-06 métodos"`

---

---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Explicar con sus palabras para que sirve un metodo
- Crear un metodo que no devuelve nada (`void`)
- Crear un metodo que devuelve un valor (`int`, `double`, `boolean`, `String`)
- Pasar parametros a un metodo
- Llamar un metodo desde `main` o desde otro metodo
- Identificar cuando separar codigo en metodos para no repetirse

**No se espera aun que Jess entienda metodos de instancia, sobrecarga ni recursion.**

---

## Analogia clave 

> "Un metodo es como una receta guardada en un recetario. En lugar de escribir cada vez como hacer guacamole, guardas la receta con el nombre 'hacerGuacamole'. Cuando la necesitas, solo la llamas por su nombre. Puedes llamarla las veces que quieras sin volver a escribir todos los pasos."

> "Los parametros son los ingredientes que le das a la receta. 'hacerGuacamole(5 aguacates, sal al gusto)' — los numeros cambian cada vez, pero la receta es la misma. Los parametros son los datos que cambian cada vez que llamas el metodo."

Usar el ejemplo de la calculadora de la semana 2 (que Jess ya hizo): "imagina que tuvieras que escribir la formula de la suma en 5 lugares diferentes del programa. Si hay un error en la formula, tienes que corregirlo en 5 lugares. Con un metodo, lo corriges en un solo lugar."

---

## Contenido teorico

### 6.1 ¿Por que usar metodos?

Sin metodos (codigo repetido y dificil de mantener):
```java
public class SinMetodos {
    public static void main(String[] args) {
        // Mismo codigo de separador repetido 3 veces
        System.out.println("====================");
        System.out.println("Resultado 1: " + (10 + 5));
        System.out.println("====================");

        System.out.println("====================");
        System.out.println("Resultado 2: " + (20 * 3));
        System.out.println("====================");

        System.out.println("====================");
        System.out.println("Resultado 3: " + (100 - 45));
        System.out.println("====================");
    }
}
```

Con metodos (limpio y sin repeticion):
```java
public class ConMetodos {

    // Metodo para imprimir una linea separadora
    // Solo lo escribimos UNA vez aqui
    public static void imprimirSeparador() {
        System.out.println("====================");
    }

    public static void main(String[] args) {
        // Lo llamamos cuantas veces queramos
        imprimirSeparador();
        System.out.println("Resultado 1: " + (10 + 5));
        imprimirSeparador();

        imprimirSeparador();
        System.out.println("Resultado 2: " + (20 * 3));
        imprimirSeparador();

        imprimirSeparador();
        System.out.println("Resultado 3: " + (100 - 45));
        imprimirSeparador();
    }
}
```

### 6.2 Anatomia de un metodo

```java
//   [1]      [2]    [3]    [4]    [5]
public static double sumar(double a, double b) {
    return a + b;   // [6]
}
```

- `[1] public` — el metodo es visible desde cualquier parte del programa (por ahora siempre lo ponemos)
- `[2] static` — el metodo pertenece a la clase, no a un objeto (por ahora siempre lo ponemos)
- `[3] double` — el TIPO DE DATO que el metodo va a devolver. Si no devuelve nada, se pone `void`
- `[4] sumar` — el NOMBRE del metodo. Debe describir lo que hace. Usamos camelCase (primera palabra en minuscula, cada siguiente empieza con mayuscula)
- `[5] (double a, double b)` — los PARAMETROS: datos que el metodo necesita para trabajar. Cada parametro tiene tipo y nombre
- `[6] return a + b` — la instruccion `return` entrega el resultado y TERMINA el metodo. Solo se usa si el metodo no es `void`

### 6.3 Metodos void: hacer algo sin devolver nada

Un metodo `void` ejecuta acciones pero no regresa ningun valor. Se usa cuando solo quieres "hacer algo" (imprimir, modificar una variable global, etc.).

```java
public class Saludos {

    // Este metodo recibe un nombre y lo saluda
    // void = no devuelve nada, solo imprime
    public static void saludar(String nombre) {
        System.out.println("Hola, " + nombre + "!");
        System.out.println("Bienvenida al curso de Java.");
    }

    // Este metodo no recibe nada ni devuelve nada
    // Solo imprime una linea decorativa
    public static void imprimirLinea() {
        System.out.println("--------------------");
    }

    public static void main(String[] args) {
        imprimirLinea();            // llamamos el metodo sin parametros
        saludar("Jess");           // llamamos el metodo con el parametro "Jess"
        imprimirLinea();
        saludar("Carlos");         // reutilizamos el mismo metodo con otro parametro
        imprimirLinea();
    }
}
// Salida:
// --------------------
// Hola, Jess!
// Bienvenida al curso de Java.
// --------------------
// Hola, Carlos!
// Bienvenida al curso de Java.
// --------------------
```

### 6.4 Metodos que devuelven un valor

Cuando un metodo calcula algo y quieres usar ese resultado en otra parte del programa, usa `return`.

```java
public class Calculos {

    // Metodo que recibe dos numeros y devuelve su suma
    // El tipo de retorno es double (lo que dice antes del nombre del metodo)
    public static double sumar(double a, double b) {
        return a + b;   // devuelve el resultado de sumar a + b
    }

    // Metodo que calcula el IVA de un precio
    public static double calcularIVA(double precio) {
        return precio * 0.16;   // el IVA en Mexico es el 16%
    }

    // Metodo que devuelve true o false (boolean)
    public static boolean esMayorDeEdad(int edad) {
        return edad >= 18;   // devuelve true si edad es 18 o mas, false si no
    }

    public static void main(String[] args) {
        // Guardar el resultado del metodo en una variable
        double resultado = sumar(10.0, 5.0);
        System.out.println("Suma: " + resultado);    // Suma: 15.0

        // Usar el resultado directamente en un println
        System.out.println("IVA de $200: $" + calcularIVA(200.0));  // IVA de $200: $32.0

        // Usar el resultado en un if
        if (esMayorDeEdad(16)) {
            System.out.println("Es mayor de edad");
        } else {
            System.out.println("Es menor de edad");   // imprime esto
        }

        // Llamar un metodo dentro de otro metodo
        double precio = 100.0;
        double iva = calcularIVA(precio);
        double total = sumar(precio, iva);
        System.out.println("Total con IVA: $" + total);   // Total con IVA: $116.0
    }
}
```

### 6.5 El flujo de ejecucion con metodos

Esto es importante que Jess entienda: cuando el programa llega a una llamada de metodo, "pausa" el main, "salta" al metodo, ejecuta todo lo que hay dentro, y cuando termina (o llega a `return`), "vuelve" al main y continua desde donde se quedo.

```java
public class FlujoEjecucion {

    public static int doblar(int numero) {
        System.out.println("  [entrando a doblar con numero=" + numero + "]");
        int resultado = numero * 2;
        System.out.println("  [saliendo de doblar, resultado=" + resultado + "]");
        return resultado;    // aqui termina el metodo y devuelve el valor
    }

    public static void main(String[] args) {
        System.out.println("Linea 1 del main");
        int x = doblar(5);    // el main se pausa, salta al metodo
        System.out.println("Linea 2 del main, x=" + x);
        int y = doblar(10);   // vuelve a saltar al metodo
        System.out.println("Linea 3 del main, y=" + y);
    }
}
// Salida (muestra el orden de ejecucion):
// Linea 1 del main
//   [entrando a doblar con numero=5]
//   [saliendo de doblar, resultado=10]
// Linea 2 del main, x=10
//   [entrando a doblar con numero=10]
//   [saliendo de doblar, resultado=20]
// Linea 3 del main, y=20
```

### 6.6 Buenas practicas para nombrar metodos

- El nombre debe describir QUE HACE el metodo, no como lo hace.
- Usar verbos: `calcular`, `obtener`, `verificar`, `imprimir`, `es`, `tiene`.
- Ejemplos buenos: `calcularTotal`, `obtenerNombre`, `esValido`, `imprimirFactura`.
- Ejemplos malos: `metodo1`, `hacerCosa`, `x`, `proceso`.

```java
// MAL: no sabes que hace con solo leer el nombre
public static double calc(double a, double b) { return a * b; }

// BIEN: el nombre dice exactamente que hace
public static double calcularPrecioConDescuento(double precio, double descuento) {
    return precio - (precio * descuento);
}
```

---

## Errores comunes

1. **Olvidar el `return` en un metodo que no es void** — Java marca error de compilacion.
   - Ejemplo: `public static int sumar(int a, int b) { int resultado = a + b; }` — falta el `return resultado;`
   - Como detectarlo: el compilador dice "missing return statement".
   - Como corregirlo: agregar `return resultado;` al final del metodo.

2. **Llamar el metodo sin usar el resultado** — el metodo devuelve algo pero no lo guardamos.
   - Ejemplo: `sumar(5, 3);` en lugar de `int resultado = sumar(5, 3);`
   - Como detectarlo: el programa corre pero no pasa nada con el valor calculado.
   - Como corregirlo: guardar el resultado en una variable o usarlo directamente.

3. **Poner `return` en un metodo void** — Java marca error.
   - Ejemplo: `public static void saludar(String nombre) { return nombre.toUpperCase(); }`
   - Como detectarlo: el compilador dice "cannot return a value from method whose result type is void".
   - Como corregirlo: cambiar el tipo de retorno de `void` a `String`, o quitar el return.

4. **Confundir los tipos de los parametros** — pasar un `int` donde se espera un `String`, etc.
   - Ejemplo: `public static void saludar(String nombre) {...}` y llamar `saludar(123)`.
   - Como detectarlo: el compilador dice "method sumar cannot be applied to given types".
   - Como corregirlo: verificar que el tipo del valor que pasas coincide con el tipo del parametro.

5. **Pensar que los parametros y las variables del main son lo mismo** — los parametros son copias.
   - Ejemplo: `public static void duplicar(int n) { n = n * 2; }` — esto NO cambia la variable original en el main.
   - Como detectarlo: la variable en el main no cambia despues de llamar el metodo.
   - Como corregirlo: usar `return` para devolver el nuevo valor y asignarlo: `n = duplicar(n);`

---

## Soluciones

### Ejercicio 1 — Calculadora con metodos

```java
import java.util.Scanner;

public class CalculadoraMetodos {

    // Metodo para sumar — recibe dos doubles, devuelve un double
    public static double sumar(double a, double b) {
        return a + b;
    }

    // Metodo para restar — recibe dos doubles, devuelve un double
    public static double restar(double a, double b) {
        return a - b;
    }

    // Metodo para multiplicar — recibe dos doubles, devuelve un double
    public static double multiplicar(double a, double b) {
        return a * b;
    }

    // Metodo para dividir — incluye validacion para no dividir entre 0
    // Si b es 0, imprime un error y devuelve 0 para no romper el programa
    public static double dividir(double a, double b) {
        if (b == 0) {
            System.out.println("Error: no se puede dividir entre cero");
            return 0;   // return dentro de un if termina el metodo inmediatamente
        }
        return a / b;   // solo llega aqui si b no es 0
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Numero 1: ");
        double a = sc.nextDouble();   // leer el primer numero

        System.out.print("Numero 2: ");
        double b = sc.nextDouble();   // leer el segundo numero

        // Llamar cada metodo y mostrar el resultado
        System.out.println("Suma: " + sumar(a, b));
        System.out.println("Resta: " + restar(a, b));
        System.out.println("Multiplicacion: " + multiplicar(a, b));
        System.out.println("Division: " + dividir(a, b));

        sc.close();
    }
}
```

### Ejercicio 2 — Validador de contrasena

```java
public class ValidadorContrasena {

    // Metodo que verifica si una contrasena es valida
    // Devuelve true si cumple AMBAS condiciones:
    //   1) Tiene al menos 8 caracteres
    //   2) Tiene al menos una letra mayuscula
    public static boolean esContrasenaValida(String contrasena) {

        // Verificar longitud minima
        if (contrasena.length() < 8) {
            return false;   // demasiado corta, terminamos aqui
        }

        // Revisar cada caracter buscando al menos una mayuscula
        // toCharArray() convierte el String en un array de char
        for (char c : contrasena.toCharArray()) {
            if (Character.isUpperCase(c)) {
                return true;   // encontramos una mayuscula, es valida
            }
        }

        // Si llego hasta aqui, reviso todos los caracteres y no habia mayuscula
        return false;
    }

    public static void main(String[] args) {
        // Probar con diferentes contrasenas
        System.out.println(esContrasenaValida("hola"));        // false (menos de 8 chars)
        System.out.println(esContrasenaValida("holamundo"));   // false (sin mayuscula)
        System.out.println(esContrasenaValida("HolaMundo"));   // true
        System.out.println(esContrasenaValida("A1234567"));    // true
    }
}
```

### Ejercicio 3 — Numero primo (reto)

```java
public class EsPrimo {

    // Metodo que determina si un numero es primo
    // Un numero primo solo es divisible entre 1 y el mismo
    // Ejemplos: 2, 3, 5, 7, 11, 13...
    public static boolean esPrimo(int n) {

        // Los numeros menores a 2 no son primos (0, 1, negativos)
        if (n < 2) {
            return false;
        }

        // Intentamos dividir n entre todos los numeros desde 2 hasta Math.sqrt(n)
        // Si alguna division es exacta (residuo = 0), entonces NO es primo
        // Usamos Math.sqrt para ser mas eficientes (no necesitamos revisar mas alla)
        for (int i = 2; i <= Math.sqrt(n); i++) {
            if (n % i == 0) {
                return false;   // encontramos un divisor, no es primo
            }
        }

        // Si ninguna division fue exacta, es primo
        return true;
    }

    public static void main(String[] args) {
        System.out.print("Primos del 1 al 50: ");

        for (int i = 1; i <= 50; i++) {
            // Llamamos esPrimo(i) para cada numero
            // Si devuelve true, lo imprimimos
            if (esPrimo(i)) {
                System.out.print(i + " ");
            }
        }
        // Salida: 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47
    }
}
```

---
