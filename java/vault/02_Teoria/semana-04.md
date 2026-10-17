---
semana: 4
tema: Ciclos
estado: pendiente
---

# Semana 4 — Ciclos: for / while / do-while

> Tiempo estimado: 3–4 horas
> Al terminar: `bash scripts/push.sh "semana-04 ciclos"`

---

## Primero: ¿qué es una variable?

Una variable es una caja donde guardas un número (o texto) para usarlo después.

Para crear una variable necesitas tres cosas:
1. El **tipo** — qué guarda (`int` para números enteros, `String` para texto)
2. El **nombre** — cómo la vas a llamar (tú eliges el nombre)
3. El **valor inicial** — el número con el que empieza

```java
int edad = 25;         // tipo: int  |  nombre: edad  |  valor: 25
int suma = 0;          // tipo: int  |  nombre: suma  |  valor: 0
String nombre = "Ana"; // tipo: String | nombre: nombre | valor: "Ana"
```

Puedes cambiar el valor de una variable en cualquier momento:

```java
int suma = 0;    // empieza en 0
suma = suma + 5; // ahora suma vale 5
suma = suma + 3; // ahora suma vale 8
```

---

## El operador `+=`

`suma = suma + 5` y `suma += 5` hacen exactamente lo mismo.
`+=` es una forma corta de escribir "suma esto a lo que ya tengo":

```java
int suma = 0;
suma += 1;   // suma vale 1   (es igual a: suma = suma + 1)
suma += 2;   // suma vale 3   (es igual a: suma = suma + 2)
suma += 10;  // suma vale 13  (es igual a: suma = suma + 10)
```

De igual forma:
- `i++` es lo mismo que `i = i + 1` (suma 1)
- `i += 2` es lo mismo que `i = i + 2` (suma 2)

---

## ¿Para qué sirven los ciclos?

Imagina que tienes que imprimir los números del 1 al 5. Sin ciclos:

```java
System.out.println(1);
System.out.println(2);
System.out.println(3);
System.out.println(4);
System.out.println(5);
```

Con un ciclo, escribes el `println` UNA sola vez:

```java
for (int i = 1; i <= 5; i++) {
    System.out.println(i);
}
```

El resultado es exactamente el mismo. El ciclo hace el trabajo repetitivo por ti.

---

## Dónde puedes poner el `System.out.println`

Puedes poner el `println` en TRES lugares: **antes** del ciclo, **dentro** del ciclo, y **después** del ciclo. Cada lugar imprime en un momento diferente.

**Ejemplo completo — ver los tres lugares:**

```java
int numero = 7;
int suma = 0;

System.out.println("Empiezo a sumar");    // ANTES: imprime UNA VEZ al inicio

for (int i = 1; i <= 5; i++) {
    suma = suma + i;
    System.out.println("i=" + i + "  suma=" + suma);  // DENTRO: imprime EN CADA VUELTA
}

System.out.println("La suma total es: " + suma);      // DESPUÉS: imprime UNA VEZ al final
```

Salida del programa:
```
Empiezo a sumar
i=1  suma=1
i=2  suma=3
i=3  suma=6
i=4  suma=10
i=5  suma=15
La suma total es: 15
```

Regla para recordar:
- **Antes del ciclo**: se imprime una sola vez, antes de que empiece
- **Dentro del ciclo**: se imprime en cada vuelta (si el ciclo da 10 vueltas, imprime 10 veces)
- **Después del ciclo**: se imprime una sola vez, cuando el ciclo ya terminó

---

## El ciclo `for` — cuando sabes cuántas veces repetir

Úsalo cuando sabes exactamente cuántas repeticiones necesitas.

**Estructura:**

```java
for (int i = 1; i <= 10; i++) {
    // código que se repite
}
```

¿Qué hace cada parte?
- `int i = 1` → el contador empieza en 1
- `i <= 10` → mientras i sea menor o igual a 10, sigue repitiendo
- `i++` → al terminar cada vuelta, suma 1 al contador

**Ejemplo 1 — imprimir del 1 al 5:**

```java
for (int i = 1; i <= 5; i++) {
    System.out.println("Número: " + i);
}
```

Salida:
```
Número: 1
Número: 2
Número: 3
Número: 4
Número: 5
```

**Ejemplo 2 — tabla de multiplicar del 3:**

Aquí usamos `i` en el cálculo del resultado:

```java
for (int i = 1; i <= 10; i++) {
    System.out.println("3 x " + i + " = " + (3 * i));
}
```

Salida:
```
3 x 1 = 3
3 x 2 = 6
3 x 3 = 9
3 x 4 = 12
3 x 5 = 15
3 x 6 = 18
3 x 7 = 21
3 x 8 = 24
3 x 9 = 27
3 x 10 = 30
```

**Ejercicio de práctica en teoría 1 — tabla del 5:**

Es igual al ejemplo anterior. Solo cambia el `3` por `5`:

```java
for (int i = 1; i <= 10; i++) {
    System.out.println("5 x " + i + " = " + (5 * i));
}
```

Salida esperada:
```
5 x 1 = 5
5 x 2 = 10
...
5 x 10 = 50
```

---

## Usar variables para acumular resultados

Un acumulador es una variable que empieza en 0 y va sumando vuelta por vuelta.

**Ejemplo 3 — sumar los números del 1 al 5:**

```java
int suma = 0;   // ANTES del ciclo: la variable empieza en 0

for (int i = 1; i <= 5; i++) {
    suma = suma + i;   // DENTRO del ciclo: suma acumula
    System.out.println("Vuelta " + i + ": suma = " + suma);
}

System.out.println("Resultado final: " + suma);   // DESPUÉS del ciclo
```

Qué pasa vuelta por vuelta:

| Vuelta | i | suma antes | operación | suma después |
|--------|---|-----------|-----------|-------------|
| 1ª     | 1 | 0         | 0 + 1     | 1           |
| 2ª     | 2 | 1         | 1 + 2     | 3           |
| 3ª     | 3 | 3         | 3 + 3     | 6           |
| 4ª     | 4 | 6         | 6 + 4     | 10          |
| 5ª     | 5 | 10        | 10 + 5    | 15          |

Salida:
```
Vuelta 1: suma = 1
Vuelta 2: suma = 3
Vuelta 3: suma = 6
Vuelta 4: suma = 10
Vuelta 5: suma = 15
Resultado final: 15
```

Con `+=` se escribe más corto y hace lo mismo:

```java
int suma = 0;

for (int i = 1; i <= 5; i++) {
    suma += i;   // es lo mismo que: suma = suma + i
}

System.out.println("Resultado final: " + suma);
```

**Ejercicio de práctica en teoría 2 — sumar del 1 al 10:**

Solo cambia el `5` por `10` en la condición:

```java
int suma = 0;

for (int i = 1; i <= 10; i++) {
    suma += i;
    System.out.println("i=" + i + "  suma=" + suma);
}

System.out.println("Total: " + suma);
```

El resultado final será `55`.

---

## El ciclo `while` — mientras se cumpla una condición

Úsalo cuando no sabes exactamente cuántas veces vas a repetir.

**Estructura:**

```java
while (condición) {
    // código que se repite
}
```

**Ejemplo 4 — imprimir del 1 al 5 con while:**

```java
int numero = 1;   // ANTES del ciclo: la variable empieza en 1

while (numero <= 5) {       // mientras número sea menor o igual a 5
    System.out.println(numero);
    numero++;               // MUY IMPORTANTE: si no incrementas, el ciclo nunca termina
}
```

Salida:
```
1
2
3
4
5
```

`while` y `for` pueden hacer lo mismo. La diferencia es solo cómo se escribe:

```java
// Con for:
for (int i = 1; i <= 5; i++) {
    System.out.println(i);
}

// Con while — hace exactamente lo mismo:
int i = 1;
while (i <= 5) {
    System.out.println(i);
    i++;
}
```

**Ejercicio de práctica en teoría 3 — imprimir del 1 al 8 con while:**

```java
int numero = 1;

while (numero <= 8) {
    System.out.println(numero);
    numero++;
}
```

Salida esperada: imprime los números del 1 al 8.

---

## El ciclo `do-while` — ejecuta al menos una vez

La diferencia con `while` es que el `do-while` **primero ejecuta**, **luego revisa la condición**. Siempre se ejecuta al menos una vez.

**Estructura:**

```java
do {
    // código que se ejecuta al menos una vez
} while (condición);
```

**Ejemplo 5 — pedir un número mayor que 0:**

```java
import java.util.Scanner;

public class PedirNumero {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int numero;

        do {
            System.out.print("Ingresa un número mayor que 0: ");
            numero = sc.nextInt();
        } while (numero <= 0);   // si el número no es válido, vuelve a preguntar

        System.out.println("Perfecto, ingresaste: " + numero);
        sc.close();
    }
}
```

¿Qué pasa si el usuario pone -5?
1. Entra al `do` → pregunta → usuario pone -5
2. Revisa: `-5 <= 0` → verdadero → vuelve a preguntar
3. Usuario pone 3
4. Revisa: `3 <= 0` → falso → sale del ciclo
5. Imprime "Perfecto, ingresaste: 3"

**Ejercicio de práctica en teoría 4 — pedir un número entre 1 y 10:**

Es igual. Solo cambia la condición:

```java
int numero;

do {
    System.out.print("Ingresa un número entre 1 y 10: ");
    numero = sc.nextInt();
} while (numero  > 1 || numero  < 10);

System.out.println("Ingresaste: " + numero);
```

---

## `break` y `continue`

### `break` — salir del ciclo

```java
for (int i = 1; i <= 10; i++) {
    if (i == 5) {
        break;   // cuando i llega a 5, sale del ciclo
    }
    System.out.println(i);
}
```

Salida: `1  2  3  4` (el 5 nunca se imprime porque `break` sale antes)

### `continue` — saltar una vuelta

```java
for (int i = 1; i <= 5; i++) {
    if (i == 3) {
        continue;   // cuando i es 3, salta esta vuelta
    }
    System.out.println(i);
}
```

Salida: `1  2  4  5` (el 3 no se imprime)

---

## ¿Cuándo uso cada ciclo?

| Situación | Ciclo | Ejemplo |
|-----------|-------|---------|
| Sé exactamente cuántas veces | `for` | tabla del 7 × 10 |
| No sé cuántas veces, depende de condición | `while` | contar intentos |
| Quiero que ejecute al menos una vez | `do-while` | pedir dato al usuario |

---

## Regla de oro para no hacer ciclos infinitos

Siempre asegúrate de que ALGO cambia dentro del ciclo para que la condición pueda volverse falsa:

```java
// CORRECTO — numero++ hace que eventualmente numero > 5
int numero = 1;
while (numero <= 5) {
    System.out.println(numero);
    numero++;   // SIN ESTO el ciclo nunca termina
}

// CICLO INFINITO — numero nunca cambia
int numero = 1;
while (numero <= 5) {
    System.out.println(numero);
    // ¡Falta numero++!
}
```

---

## Siguiente paso

[[03_Practicas/semana-04]]
