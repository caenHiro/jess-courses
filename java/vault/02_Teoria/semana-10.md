# Semana 10 — Excepciones y Colecciones (ArrayList, HashMap)

---

## Objetivo de la semana

Al terminar, Jess debe poder:
- Usar `try/catch/finally` para manejar errores sin que el programa explote
- Distinguir los tipos de excepción más comunes
- Lanzar una excepción propia con `throw new`
- Usar `ArrayList<T>` para guardar listas de tamaño variable
- Usar `HashMap<K, V>` para guardar pares clave-valor
- Saber cuándo usar cada colección

**Ya sabe:** clases, objetos, herencia, interfaces, clases abstractas, `@Override`, ciclos, `switch`, `Scanner`, arrays.  
**No ha visto:** SQL, JDBC, genéricos avanzados, `Iterator`, `Stream`.

---

## Analogía clave (énfasis en clase)

> "Una excepción es como un accidente en la cocina: puedes estar cocinando tranquilamente y de repente derramar la olla. Si no tienes un plan, el desastre arruina todo (el programa se detiene). Con `try/catch` es como tener una toalla lista: si algo se derrama, la usas, limpias y sigues cocinando."

> "Un `ArrayList` es como una lista del mercado en papel: puedes agregar cosas al final, tachar cosas, y la lista puede crecer o achicarse. Un array normal es como una charola fija de 10 espacios — pones lo que cabe y ya."

> "Un `HashMap` es como tu lista de contactos en el celular: buscas por nombre y encuentras el teléfono. Tienes clave (nombre) → valor (teléfono). Es rapidísimo para buscar por clave."

---

## Nota sobre `static` en los ejemplos de esta semana

Los ejemplos de excepciones y colecciones son programas de practica rapida donde TODO vive en el `main`. Por eso los metodos auxiliares (como `dividir`) son `static` — para que el `main` (que es `static`) los pueda llamar sin crear un objeto.

Esto es diferente a las semanas 7-9 donde las clases tenian atributos y metodos de instancia (sin static). Ambos estilos son validos para contextos distintos:

| Estilo                            | Cuando usarlo                                            |
| --------------------------------- | -------------------------------------------------------- |
| Metodos `static`                  | Utilidades que no necesitan datos propios de un objeto   |
| Metodos de instancia (sin static) | Cuando el metodo necesita acceder a atributos del objeto |

No confundir — esta semana los ejemplos son de utilerías y colecciones, no de modelado de objetos.

---

## Contenido teórico

### 10.1 ¿Qué es una excepción?

Una excepción es un error que ocurre mientras el programa está corriendo (no al compilar). Sin manejo, el programa termina con un mensaje de error feo. Con `try/catch`, el programa puede sobrevivir al error y continuar.

```
Flujo normal:     try → código funciona → finally → continúa
Flujo con error:  try → lanza excepción → catch → finally → continúa
```

### 10.2 try / catch / finally

```java
try {
    // AQUÍ va el código que podría fallar
    // Si algo falla, Java salta inmediatamente al catch
    int resultado = 10 / 0;              // esto lanza ArithmeticException
    System.out.println("nunca llega aquí si hay error");
} catch (ArithmeticException e) {
    // AQUÍ manejamos el error específico
    // e.getMessage() nos dice qué salió mal
    System.out.println("Error matemático: " + e.getMessage());
} finally {
    // ESTE BLOQUE SIEMPRE SE EJECUTA — falle o no falle
    // Útil para cerrar archivos, cerrar el Scanner, liberar recursos
    System.out.println("Fin del intento (siempre se imprime esto)");
}
// El programa CONTINÚA aquí después del try/catch/finally
System.out.println("El programa sigue funcionando normalmente");
```

**¿Para qué sirve `finally`?** — Para hacer limpieza que debe pasar siempre, sin importar si hubo error. Ejemplo: cerrar el `Scanner` después de leer entrada.

### 10.3 Tipos de excepciones comunes

| Excepción | Cuándo ocurre | Ejemplo |
|-----------|--------------|---------|
| `ArithmeticException` | División entre cero | `10 / 0` |
| `NumberFormatException` | Convertir texto no numérico a número | `Integer.parseInt("hola")` |
| `NullPointerException` | Usar un objeto que es null | `String s = null; s.length()` |
| `ArrayIndexOutOfBoundsException` | Índice fuera de rango en array | `arr[10]` cuando arr tiene 5 |
| `IllegalArgumentException` | Argumento inválido pasado a un método | División entre 0 en método propio |

### 10.4 Capturar múltiples excepciones

```java
try {
    // código que puede fallar de varias formas
    String texto = "hola";
    int numero = Integer.parseInt(texto);   // NumberFormatException si texto no es número
    int resultado = 10 / numero;            // ArithmeticException si numero es 0
} catch (NumberFormatException e) {
    // solo captura errores de conversión de texto a número
    System.out.println("Escribe un número válido: " + e.getMessage());
} catch (ArithmeticException e) {
    // solo captura errores matemáticos
    System.out.println("Error matemático: " + e.getMessage());
} catch (Exception e) {
    // captura CUALQUIER excepción que no fue capturada arriba
    // es como una red de seguridad general
    System.out.println("Error inesperado: " + e.getMessage());
}
```

También se pueden combinar en un solo catch con `|`:
```java
catch (NumberFormatException | ArithmeticException e) {
    System.out.println("Error: " + e.getMessage());
}
```

### 10.5 Lanzar tu propia excepción con `throw`

```java
// Método que valida antes de dividir
public static double dividir(double a, double b) {
    if (b == 0) {
        // "throw" lanza una excepción y detiene el método aquí
        // IllegalArgumentException es para argumentos inválidos
        throw new IllegalArgumentException("El divisor no puede ser cero");
    }
    return a / b;   // solo llega aquí si b != 0
}

// En main:
try {
    double resultado = dividir(10, 0);   // llama al método con b=0
    System.out.println(resultado);       // nunca llega aquí
} catch (IllegalArgumentException e) {
    // capturamos la excepción que lanzamos nosotros
    System.out.println("Error: " + e.getMessage());   // imprime el mensaje que pusimos
}
```

### 10.6 ArrayList — listas dinámicas

Un `ArrayList` crece y se achica automáticamente. A diferencia de un array, no hay que definir el tamaño al crearlo.

```java
import java.util.ArrayList;   // hay que importarlo

// Crear un ArrayList que guarda Strings
// <String> entre < > indica el tipo de dato que va a guardar
ArrayList<String> nombres = new ArrayList<>();

// Agregar elementos al final
nombres.add("Jess");     // la lista ahora tiene [Jess]
nombres.add("Carlos");   // [Jess, Carlos]
nombres.add("María");    // [Jess, Carlos, María]

// Obtener por índice (igual que array, empieza en 0)
String primero = nombres.get(0);   // devuelve "Jess"

// Cuántos elementos tiene
int total = nombres.size();        // devuelve 3

// Verificar si está vacío
boolean vacio = nombres.isEmpty(); // devuelve false

// Eliminar por índice
nombres.remove(1);   // elimina "Carlos" (índice 1), queda [Jess, María]

// Eliminar por valor
nombres.remove("María");   // elimina "María", queda [Jess]

// Recorrer con for-each (más limpio)
for (String nombre : nombres) {
    System.out.println(nombre);
}

// Recorrer con índice (cuando necesitas el número)
for (int i = 0; i < nombres.size(); i++) {
    System.out.println(i + ": " + nombres.get(i));
}
```

### 10.7 HashMap — pares clave-valor

Un `HashMap` guarda datos como pares: una clave única apunta a un valor. Ideal cuando quieres buscar por un identificador.

```java
import java.util.HashMap;   // hay que importarlo

// Crear un HashMap: clave=String (nombre), valor=String (teléfono)
HashMap<String, String> agenda = new HashMap<>();

// Agregar pares clave→valor con put()
agenda.put("Jess", "555-1234");     // clave="Jess", valor="555-1234"
agenda.put("Carlos", "555-5678");
agenda.put("María", "555-9012");

// Obtener el valor de una clave con get()
String telJess = agenda.get("Jess");   // devuelve "555-1234"

// Verificar si existe una clave
boolean existe = agenda.containsKey("Carlos");   // devuelve true

// Eliminar un par clave-valor
agenda.remove("María");   // elimina el par cuya clave es "María"

// Cuántos pares hay
int cuantos = agenda.size();   // devuelve 2 (Jess y Carlos)

// Recorrer todas las claves
for (String nombre : agenda.keySet()) {
    // .keySet() devuelve todas las claves
    // .get(nombre) obtiene el valor de esa clave
    System.out.println(nombre + ": " + agenda.get(nombre));
}
```

### 10.8 ¿ArrayList o HashMap?

| Necesito... | Usar |
|-------------|------|
| Guardar una lista de cosas en orden | `ArrayList` |
| Buscar rápido por nombre/id | `HashMap` |
| Acceder por posición (índice 0, 1, 2...) | `ArrayList` |
| Asociar información (nombre→teléfono, id→objeto) | `HashMap` |

---

## Errores comunes

1. **No importar `ArrayList` o `HashMap`** — Java no los encuentra sin el `import`. Error: "cannot find symbol". Solución: agregar `import java.util.ArrayList;` al inicio del archivo.

2. **`remove()` en ArrayList** — `remove(1)` elimina por ÍNDICE, `remove("texto")` elimina por VALOR. Si la lista es `ArrayList<Integer>` y hace `remove(5)`, Java elimina por índice, no por valor. Confunde mucho — explicar con cuidado.

3. **`get()` en HashMap devuelve `null` si la clave no existe** — si hace `agenda.get("Pedro")` y Pedro no está, devuelve `null` (no lanza error). Siempre verificar con `containsKey()` antes de usar el valor.

4. **El `finally` se ejecuta aunque haya `return` en el `catch`** — comportamiento especial de Java. No profundizar, pero mencionarlo si pregunta.

5. **`catch (Exception e)` captura TODO** — si pone solo este catch, captura cualquier error incluyendo errores de programación que debería corregir. Preferir ser específico.

6. **`sc.nextInt()` deja un `\n` en el buffer** — cuando mezcla `nextInt()` con `nextLine()`, el `nextLine()` siguiente consume el salto de línea vacío. Solución: agregar `sc.nextLine()` después del `nextInt()` para limpiar el buffer.

---

## Soluciones

### Ejercicio 1 — Calculadora segura

```java
import java.util.Scanner;   // para leer la entrada del usuario

public class CalculadoraSegura {
    public static void main(String[] args) {
        // Declaramos el Scanner FUERA del try para poder cerrarlo en finally
        Scanner sc = new Scanner(System.in);

        try {
            // Pedimos los números como texto y convertimos a double
            // parseDouble lanza NumberFormatException si el texto no es número
            System.out.print("Número 1: ");
            double a = Double.parseDouble(sc.nextLine());   // nextLine lee texto completo

            System.out.print("Número 2: ");
            double b = Double.parseDouble(sc.nextLine());

            // Pedimos la operación
            System.out.print("Operación (+, -, *, /): ");
            String op = sc.nextLine().trim();   // trim() elimina espacios al inicio y fin

            double resultado;   // variable donde guardaremos el resultado

            // switch para elegir la operación
            switch (op) {
                case "+":
                    resultado = a + b;
                    break;
                case "-":
                    resultado = a - b;
                    break;
                case "*":
                    resultado = a * b;
                    break;
                case "/":
                    // Validamos manualmente antes de dividir
                    if (b == 0) {
                        // throw detiene el método y lanza la excepción
                        throw new ArithmeticException("División entre 0 no permitida");
                    }
                    resultado = a / b;
                    break;
                default:
                    // Si la operación no es ninguna de las válidas
                    throw new IllegalArgumentException("Operación no válida: " + op);
            }

            // Solo llega aquí si no hubo excepción
            System.out.println("Resultado: " + resultado);

        } catch (NumberFormatException e) {
            // Captura si el usuario escribió algo que no es número
            System.out.println("Error: escribe solo números (sin letras ni caracteres especiales)");
        } catch (ArithmeticException | IllegalArgumentException e) {
            // Captura errores matemáticos o de operación inválida (con |)
            System.out.println("Error: " + e.getMessage());
        } finally {
            // Siempre cerramos el Scanner — falle o no el try
            sc.close();
            System.out.println("Calculadora cerrada.");
        }
    }
}
```

---

### Ejercicio 2 — Lista de tareas con ArrayList

```java
import java.util.ArrayList;   // para usar ArrayList
import java.util.Scanner;     // para leer la entrada del usuario

public class ListaTareas {
    public static void main(String[] args) {
        ArrayList<String> tareas = new ArrayList<>();   // lista vacía de tareas
        Scanner sc = new Scanner(System.in);
        int opcion;   // variable para guardar la opción del menú

        // do-while: siempre ejecuta al menos una vez
        do {
            // Mostramos el menú
            System.out.println("\n=== Lista de Tareas ===");
            System.out.println("1. Agregar tarea");
            System.out.println("2. Ver tareas");
            System.out.println("3. Eliminar tarea");
            System.out.println("0. Salir");
            System.out.print("Opción: ");
            opcion = sc.nextInt();   // leemos la opción
            sc.nextLine();           // limpiamos el buffer después de nextInt

            switch (opcion) {
                case 1:
                    // Agregar una nueva tarea al final de la lista
                    System.out.print("Escribe la tarea: ");
                    String nuevaTarea = sc.nextLine();   // leemos el texto de la tarea
                    tareas.add(nuevaTarea);              // la agregamos al ArrayList
                    System.out.println("Tarea agregada.");
                    break;

                case 2:
                    // Mostrar todas las tareas con su número
                    if (tareas.isEmpty()) {
                        // .isEmpty() regresa true si el ArrayList no tiene elementos
                        System.out.println("No hay tareas pendientes.");
                    } else {
                        System.out.println("\nTus tareas:");
                        for (int i = 0; i < tareas.size(); i++) {
                            // i+1 porque para el usuario los números empiezan en 1
                            System.out.println((i + 1) + ". " + tareas.get(i));
                        }
                    }
                    break;

                case 3:
                    // Eliminar una tarea por número
                    if (tareas.isEmpty()) {
                        System.out.println("No hay tareas para eliminar.");
                    } else {
                        System.out.print("¿Cuál número eliminar? ");
                        int num = sc.nextInt();   // número que eligió el usuario
                        sc.nextLine();            // limpiar buffer
                        int indice = num - 1;     // convertimos a índice (el usuario contó desde 1)

                        // Validamos que el número sea válido
                        if (indice >= 0 && indice < tareas.size()) {
                            String eliminada = tareas.get(indice);   // guardamos el texto para confirmación
                            tareas.remove(indice);                   // eliminamos por índice
                            System.out.println("Eliminada: " + eliminada);
                        } else {
                            System.out.println("Número inválido. Elige entre 1 y " + tareas.size());
                        }
                    }
                    break;

                case 0:
                    System.out.println("¡Hasta luego!");
                    break;

                default:
                    System.out.println("Opción no válida. Elige 0, 1, 2 o 3.");
            }

        } while (opcion != 0);   // seguimos mientras el usuario no elija 0

        sc.close();   // cerramos el Scanner al salir
    }
}
```

---

### Ejercicio 3 — Agenda con HashMap (reto)

```java
import java.util.HashMap;   // para usar HashMap
import java.util.Scanner;   // para leer la entrada

public class Agenda {
    public static void main(String[] args) {
        // HashMap<String, String>: clave=nombre, valor=teléfono
        HashMap<String, String> contactos = new HashMap<>();
        Scanner sc = new Scanner(System.in);
        int opcion;

        do {
            System.out.println("\n=== Agenda de Contactos ===");
            System.out.println("1. Agregar contacto");
            System.out.println("2. Buscar por nombre");
            System.out.println("3. Eliminar contacto");
            System.out.println("4. Ver todos los contactos");
            System.out.println("0. Salir");
            System.out.print("Opción: ");
            opcion = sc.nextInt();
            sc.nextLine();   // limpiar buffer

            switch (opcion) {
                case 1:
                    // Agregar nuevo contacto
                    System.out.print("Nombre: ");
                    String nombre = sc.nextLine();     // la clave del HashMap
                    System.out.print("Teléfono: ");
                    String telefono = sc.nextLine();   // el valor del HashMap
                    contactos.put(nombre, telefono);   // put() agrega o actualiza el par
                    System.out.println("Contacto guardado.");
                    break;

                case 2:
                    // Buscar un contacto por nombre
                    System.out.print("¿A quién buscas? ");
                    String busqueda = sc.nextLine();

                    // containsKey() verifica si la clave existe ANTES de buscar
                    if (contactos.containsKey(busqueda)) {
                        // get() devuelve el valor asociado a esa clave
                        System.out.println(busqueda + ": " + contactos.get(busqueda));
                    1System.out.println("Contacto no encontrado.");
                    }
                    break;

                case 3:
                    // Eliminar un contacto por nombre
                    System.out.print("¿A quién eliminar? ");
                    String eliminar = sc.nextLine();

                    if (contactos.containsKey(eliminar)) {
                        contactos.remove(eliminar);   // remove() elimina el par por clave
                        System.out.println("Contacto eliminado.");
                    } else {
                        System.out.println("Contacto no encontrado.");
                    }
                    break;

                case 4:
                    // Mostrar todos los contactos
                    if (contactos.isEmpty()) {
                        System.out.println("La agenda está vacía.");
                    } else {
                        System.out.println("\nTodos los contactos:");
                        // keySet() devuelve todas las claves del HashMap
                        for (String n : contactos.keySet()) {
                            System.out.println("  " + n + ": " + contactos.get(n));
                        }
                    }
                    break;

                case 0:
                    System.out.println("Hasta luego.");
                    break;
            }

        } while (opcion != 0);

        sc.close();   // siempre cerrar el Scanner al terminar
    }
}
```

---

## Criterios de calificación — Semana 10

| Criterio | Puntos |
|----------|--------|
| Calculadora: maneja `NumberFormatException` correctamente | 2 pts |
| Calculadora: maneja división entre cero con mensaje claro | 1 pt |
| Calculadora: `finally` cierra el Scanner | 1 pt |
| Lista de tareas: agregar, ver y eliminar funcionan correctamente | 3 pts |
| Lista de tareas: valida índice al eliminar (no explota con número inválido) | 1 pt |
| Reflexión completada con respuestas propias y con sentido | 2 pts |
| **Total** | **10 pts** |

**Reto (no penalizar si no lo hace, pero sí dar retroalimentación):** si entregó Agenda con HashMap, revisar que use `containsKey()` antes de `get()`.

---

## Señales de alerta

- Si el programa explota con `NumberFormatException` aunque tiene `try/catch`: verificar que el `Double.parseDouble()` esté DENTRO del bloque `try`, no antes.
- Si `remove()` del ArrayList elimina el elemento equivocado: revisar si está usando `remove(int)` (por índice) o `remove(Object)` (por valor). Para listas de String, `remove("texto")` funciona por valor.
- Si el `nextLine()` después de `nextInt()` se salta: explicar el bug del buffer — `nextInt()` no consume el `\n` al final, entonces el siguiente `nextLine()` lo recoge vacío. Solución: `sc.nextLine()` extra después de cada `nextInt()`.
- Si se frustra con los genéricos `<String>`: explicar que es solo para decirle al ArrayList qué tipo de dato va a guardar. "El ArrayList de String solo acepta Strings, igual que una caja etiquetada."
- Si Jess pregunta para qué sirve `finally` si puede poner el código después del catch: explicar con el caso de excepción no capturada — si hay un error que el catch no captura, el código después del catch NO se ejecuta, pero el finally SÍ. Es la única garantía.
