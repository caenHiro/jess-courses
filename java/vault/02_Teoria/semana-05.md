# Semana 5 — Arrays y Strings

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-05 arrays y strings"`

---

---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Crear un array de cualquier tipo (`int[]`, `String[]`, `double[]`)
- Acceder a elementos individuales usando su índice
- Recorrer un array completo con un ciclo `for`
- Usar el for-each para leer arrays
- Usar los métodos más comunes de String: `length()`, `charAt()`, `toUpperCase()`, `contains()`, `equals()`, `substring()`
- Comparar Strings correctamente con `.equals()` en lugar de `==`

**No se espera aún que Jess sepa ArrayList, colecciones, ni generics. Solo arrays primitivos y Strings.**

---

## Analogia clave 

> "Un array es como una charola de huevos del tianguis. La charola tiene espacios numerados: espacio 0, espacio 1, espacio 2... hasta el ultimo. No puedes meter un huevo en el espacio 30 si la charola solo tiene 12 espacios. Y siempre empiezas a contar desde el espacio 0, no el 1."

> "Un String es como un collar de chaquiras. Cada chaquira es una letra. Puedes preguntar: ¿cual es la chaquira numero 3? (charAt(3)). ¿Cuantas chaquiras tiene? (length()). ¿Tiene una chaquira roja? (contains('a'))."

Usar estas analogias cuando Jess pregunte por que el indice empieza en 0. Es una convencion de casi todos los lenguajes — no hay que memorizarla, solo aceptarla y practicarla.

---

## Contenido teorico

### 5.1 ¿Que es un array?

Un array guarda VARIOS valores del mismo tipo en UNA sola variable. En lugar de crear 5 variables separadas para 5 calificaciones, creas un array de 5 posiciones.

Sin arrays (molesto):
```java
int cal1 = 85;
int cal2 = 92;
int cal3 = 78;
int cal4 = 95;
int cal5 = 88;
// Para sumarlas tendrias que escribir cal1 + cal2 + cal3 + cal4 + cal5
```

Con array (mucho mejor):
```java
// Declarar e inicializar el array de una vez
// int[]  = tipo de dato seguido de corchetes
// calificaciones = nombre de la variable
// {85, 92, 78, 95, 88} = los valores iniciales, separados por coma
int[] calificaciones = {85, 92, 78, 95, 88};
```

### 5.2 Indices: como acceder a cada elemento

Los elementos de un array se numeran empezando desde 0, no desde 1.

```java
int[] calificaciones = {85, 92, 78, 95, 88};
//                       ^0  ^1  ^2  ^3  ^4
// El primer elemento esta en el indice 0
// El ultimo elemento esta en el indice 4 (que es length - 1)

System.out.println(calificaciones[0]);   // imprime 85  (el primero)
System.out.println(calificaciones[2]);   // imprime 78  (el tercero)
System.out.println(calificaciones[4]);   // imprime 88  (el ultimo)

// Cuantos elementos tiene el array:
System.out.println(calificaciones.length);   // imprime 5
```

**Punto clave para enfatizar:** si el array tiene 5 elementos, el ultimo indice es 4 (no 5). El error mas comun es intentar acceder al indice 5 en un array de 5 elementos — eso causa ArrayIndexOutOfBoundsException.

### 5.3 Crear array sin valores iniciales

A veces no sabes los valores al principio. Puedes crear el array vacio y llenarlo despues:

```java
// Crear un array de 5 posiciones, todas en 0 (valor por defecto de int)
int[] numeros = new int[5];

// Luego llenar cada posicion una por una
numeros[0] = 10;   // poner 10 en la posicion 0
numeros[1] = 20;   // poner 20 en la posicion 1
numeros[2] = 30;   // poner 30 en la posicion 2
// Las posiciones 3 y 4 siguen en 0

System.out.println(numeros[0]);   // 10
System.out.println(numeros[3]);   // 0 (no le pusimos nada, quedo en cero)
```

Para arrays de String, el valor por defecto es `null` (nada), no una cadena vacia.

### 5.4 Recorrer un array con for clasico

El ciclo for que Jess ya conoce es perfecto para recorrer arrays:

```java
String[] frutas = {"manzana", "naranja", "uva", "mango"};

// i empieza en 0 (primer indice)
// i < frutas.length significa: mientras i sea menor que 4 (el tamano del array)
// i++ aumenta i en 1 cada vuelta
for (int i = 0; i < frutas.length; i++) {
    // frutas[i] accede al elemento en la posicion i
    System.out.println(frutas[i]);
}
// Salida:
// manzana
// naranja
// uva
// mango
```

Por que `i < frutas.length` y no `i <= frutas.length`? Porque si el array tiene 4 elementos (indices 0, 1, 2, 3), cuando i llega a 4 ya no hay elemento — causaria error. Con `<` nos detenemos antes.

### 5.5 For-each: la forma mas limpia para leer arrays

Cuando solo quieres leer (no modificar) los elementos, el for-each es mas sencillo:

```java
String[] frutas = {"manzana", "naranja", "uva", "mango"};

// Para cada fruta (de tipo String) en el array frutas:
for (String fruta : frutas) {
    System.out.println(fruta);   // fruta toma automaticamente el valor de cada elemento
}
```

La diferencia: con el for clasico tienes acceso al indice `i` (util para recorrer al reves, o modificar elementos). Con el for-each no tienes el indice, pero el codigo es mas legible.

### 5.6 Strings: texto con super poderes

Un String no es solo texto — tiene metodos que nos permiten trabajar con el:

```java
String nombre = "jessica escalona";

// .length() — cuantos caracteres tiene (incluyendo espacios)
System.out.println(nombre.length());           // 16

// .toUpperCase() — convierte TODO a mayusculas
System.out.println(nombre.toUpperCase());      // JESSICA ESCALONA

// .toLowerCase() — convierte TODO a minusculas
System.out.println(nombre.toLowerCase());      // jessica escalona

// .contains("texto") — pregunta si contiene ese texto (true o false)
System.out.println(nombre.contains("jessica")); // true
System.out.println(nombre.contains("carlos"));  // false

// .replace("original", "nuevo") — reemplaza texto
System.out.println(nombre.replace("jessica", "Jess")); // Jess escalona

// .trim() — quita espacios en blanco al inicio y al final
String conEspacios = "  hola  ";
System.out.println(conEspacios.trim());        // "hola" (sin espacios)

// .charAt(posicion) — obtiene el caracter en esa posicion (empieza en 0)
System.out.println(nombre.charAt(0));          // 'j' (la primera letra)
System.out.println(nombre.charAt(7));          // 'e' (la letra en posicion 7)

// .substring(inicio, fin) — obtiene una parte del texto
// Toma desde "inicio" hasta ANTES de "fin"
System.out.println(nombre.substring(0, 7));    // "jessica" (posiciones 0 a 6)
System.out.println(nombre.substring(8));       // "escalona" (desde posicion 8 hasta el final)
```

### 5.7 Comparar Strings: el error mas comun

```java
String a = "hola";
String b = "hola";

// MAL — el == compara si son el mismo objeto en memoria, no si tienen el mismo texto
if (a == b) {   // Esto puede fallar aunque parezcan iguales
    System.out.println("Son iguales");
}

// BIEN — .equals() compara el contenido del texto
if (a.equals(b)) {
    System.out.println("Son iguales");   // Esto siempre funciona correctamente
}

// Para ignorar si son mayusculas o minusculas:
if (a.equalsIgnoreCase("HOLA")) {
    System.out.println("Son iguales sin importar mayusculas");   // true
}
```

Cuando Jess use `==` con Strings y le "funcione" en algunos casos: explicar que funciona solo por coincidencia. Siempre usar `.equals()`.

### 5.8 Metodo indexOf para buscar caracteres

```java
String vocales = "aeiouAEIOU";
String texto = "hola";

// .indexOf(caracter) devuelve la posicion donde encontro el caracter
// Si NO lo encuentra, devuelve -1
System.out.println(vocales.indexOf('a'));   // 0  (encontro la 'a' en posicion 0)
System.out.println(vocales.indexOf('h'));   // -1 (no encontro la 'h')

// Esto sirve para saber si un caracter es vocal:
char letra = 'e';
if (vocales.indexOf(letra) >= 0) {
    System.out.println(letra + " es vocal");   // imprime: e es vocal
}
```

---

## Errores comunes

1. **ArrayIndexOutOfBoundsException** — acceder a un indice que no existe.
   - Ejemplo: array de 5 elementos, intentar `calificaciones[5]`.
   - Como detectarlo: la consola muestra "ArrayIndexOutOfBoundsException: Index 5 out of bounds for length 5".
   - Como corregirlo: el ultimo indice valido siempre es `length - 1`. Revisar el for: usar `i < array.length`, no `i <= array.length`.

2. **Comparar Strings con `==`** — parece funcionar a veces, falla otras.
   - Ejemplo: `if (respuesta == "si")` — puede dar `false` aunque la respuesta sea "si".
   - Como detectarlo: el if nunca entra aunque los textos se vean iguales.
   - Como corregirlo: cambiar a `respuesta.equals("si")`.

3. **Confundir `charAt()` con `substring()`** — `charAt` devuelve un caracter (`char`), `substring` devuelve un String.
   - Ejemplo de error: `String primera = nombre.charAt(0)` — no compila porque `charAt` devuelve `char`, no `String`.
   - Como corregirlo: `char primera = nombre.charAt(0)` o `String primera = nombre.substring(0, 1)`.

4. **Olvidar que los indices empiezan en 0** — intentar acceder al elemento "1" cuando quiere el primero.
   - Ejemplo: `frutas[1]` creyendo que es la primera fruta, pero en realidad es la segunda.
   - Como corregirlo: recordar la analogia de la charola de huevos. El primer huevo esta en el espacio 0.

5. **NullPointerException al llamar metodos en String no inicializado** — crear un array de Strings sin asignar valores y llamar metodos.
   - Ejemplo: `String[] nombres = new String[3]; System.out.println(nombres[0].length());`
   - Como detectarlo: la consola muestra "NullPointerException".
   - Como corregirlo: asignar un valor antes de llamar metodos: `nombres[0] = "Jess";`

---

## Soluciones

### Ejercicio 1 — Frutas al reves

```java
public class FrutasReversa {
    public static void main(String[] args) {

        // Crear array con 5 frutas
        String[] frutas = {"manzana", "pera", "uva", "mango", "fresa"};

        System.out.println("Lista al reves:");

        // Para recorrer al reves: empezamos en el ultimo indice (frutas.length - 1)
        // y vamos bajando hasta el indice 0
        // i-- significa que restamos 1 a i en cada vuelta (lo opuesto a i++)
        for (int i = frutas.length - 1; i >= 0; i--) {
            System.out.println(frutas[i]);   // imprime el elemento en posicion i
        }
        // Salida:
        // fresa
        // mango
        // uva
        // pera
        // manzana
    }
}
```

### Ejercicio 2 — Contar vocales

```java
public class ContarVocales {
    public static void main(String[] args) {

        String nombre = "Jessica Escalona";

        // Ponemos todas las vocales en un String auxiliar
        // Incluimos mayusculas y minusculas
        String vocales = "aeiouAEIOU";

        int contador = 0;   // aqui vamos a acumular cuantas vocales encontramos

        // Recorremos cada caracter del nombre, de izquierda a derecha
        for (int i = 0; i < nombre.length(); i++) {

            // charAt(i) obtiene el caracter en la posicion i
            char letra = nombre.charAt(i);

            // indexOf(letra) busca la letra en el String de vocales
            // Si devuelve >= 0, significa que SI la encontro (es vocal)
            // Si devuelve -1, significa que NO la encontro (no es vocal)
            if (vocales.indexOf(letra) >= 0) {
                contador++;   // es vocal, sumamos 1
            }
        }

        System.out.println("Vocales en '" + nombre + "': " + contador);
        // Salida: Vocales en 'Jessica Escalona': 6
    }
}
```

### Ejercicio 3 — Promedio, max, min

```java
public class Promedio {
    public static void main(String[] args) {

        // Array con 6 calificaciones
        double[] calificaciones = {8.5, 9.0, 7.5, 10.0, 6.0, 8.0};

        // Iniciamos la suma en 0 para ir acumulando
        double suma = 0;

        // Para el maximo, empezamos asumiendo que el primero es el mayor
        // Luego lo comparamos contra todos los demas
        double max = calificaciones[0];

        // Para el minimo, igual: asumimos que el primero es el menor
        double min = calificaciones[0];

        // For-each: para cada calificacion en el array
        for (double c : calificaciones) {
            suma += c;          // acumular la suma

            if (c > max) {
                max = c;        // si encontramos uno mayor, actualizamos max
            }
            if (c < min) {
                min = c;        // si encontramos uno menor, actualizamos min
            }
        }

        // Dividir la suma entre el total de elementos para obtener el promedio
        double promedio = suma / calificaciones.length;

        System.out.println("Promedio: " + promedio);     // 8.166...
        System.out.println("Mas alta: " + max);          // 10.0
        System.out.println("Mas baja: " + min);          // 6.0
    }
}
```

---
