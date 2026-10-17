---
semana: 4
tema: Ciclos
estado: en progreso
---

# Práctica — Semana 4: Ciclos

> Guarda tu código en: `codigo/semana-04/`
> Al terminar: `bash scripts/push.sh "semana-04 ciclos"`

---

## Ejercicio 1 — Tabla de multiplicar

Archivo: `codigo/semana-04/TablaMultiplicar.java`

**Lo que harás:** pedir un número al usuario e imprimir su tabla de multiplicar del 1 al 10.

**Cómo pensar este ejercicio paso a paso:**

1. Necesitas leer un número del usuario → usas `Scanner`
2. Necesitas repetir 10 veces → usas `for` del 1 al 10
3. Dentro del ciclo, imprimes: `numero x i = resultado`
4. El resultado es `numero * i`

**Recuerda:** el `System.out.println` que muestra "Tabla del..." va ANTES del ciclo (se imprime una sola vez). El que muestra cada línea de la tabla va DENTRO del ciclo (se imprime en cada vuelta).

**Modelo base (ya tienes la estructura, solo completa los huecos):**

```java
import java.util.Scanner;

public class TablaMultiplicar {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("¿De qué número quieres la tabla? ");
        int numero = sc.nextInt();

        System.out.println("Tabla del " + numero + ":");   // ANTES del ciclo — se imprime una vez
        for (int i = 1; i <= 10; i++) {
            System.out.println(numero + " x " + i + " = " + (numero * i));  // DENTRO — se imprime 10 veces
        }
        sc.close();
    }
}
```

**Salida esperada si el usuario ingresa 7:**
```
¿De qué número quieres la tabla? 7
Tabla del 7:
7 x 1 = 7
7 x 2 = 14
7 x 3 = 21
7 x 4 = 28
7 x 5 = 35
7 x 6 = 42
7 x 7 = 49
7 x 8 = 56
7 x 9 = 63
7 x 10 = 70
```

**Conexión con la teoría:** es el Ejemplo 2 de la teoría, pero en lugar de tener el número fijo (3), lo lees del usuario con `Scanner`.

_Tu código:_
```java
import java.util.Scanner;  
public class TablaMultiplicar {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
    // Pedir al usuario un número
    System.out.print(" Ingresa un número: ");
    int num = sc.nextInt();
    System.out.println("Tabla del " + num + ": ") ;
    for (int i = 1; i <= 10; i++) {
    System.out.println( num + " x " + i + " = " + i * num);
}
     }
}
```

✅ ¡Ejercicio 1 entregado! Tu solución funciona correctamente.

---

## Ejercicio 2 — Suma del 1 al N

Archivo: `codigo/semana-04/SumaN.java`

**Lo que harás:** pedir un número N y calcular la suma de todos los números del 1 hasta N.

**Cómo pensar este ejercicio paso a paso:**

1. Lees el número N del usuario
2. Creas una variable `suma = 0` — esto va ANTES del ciclo, fuera de él
3. Con un `for` vas del 1 hasta N
4. En cada vuelta: `suma = suma + i` (o `suma += i`)
5. Al terminar el ciclo (DESPUÉS), imprimes el resultado

**Importante sobre las variables:**
- `int suma = 0;` debe estar ANTES del `for` — si la pones dentro, se resetea a 0 en cada vuelta
- El `System.out.println` del resultado va DESPUÉS del ciclo — cuando `suma` ya acumuló todo

**Modelo base:**

```java
import java.util.Scanner;

  

public class Suma {

    public static void main(String[] args) throws Exception {

       Scanner sc = new Scanner(System.in);

    // Pedir al usuario un número

    System.out.print(" Ingresa un número: ");

    int num = sc.nextInt();

    int sum = 0;

  

    System.out.println("Ingresaste el nuúmero:  " + num);

    for (int i = 1; i <= num; i++) {

    sum = sum + i;  

}

System.out.println("La suma del numero 1 al  " + num + " es = "+ sum);

  

sc.close();

    }

  

}
```

**Salida esperada si el usuario ingresa 5:**
```
Ingresa N: 5
La suma del 1 al 5 es: 15
```

¿Por qué 15? Porque 1 + 2 + 3 + 4 + 5 = 15.

**Salida esperada si el usuario ingresa 10:**
```
Ingresa N: 10
La suma del 1 al 10 es: 55
```

**Conexión con la teoría:** es el Ejemplo 3 de la teoría, pero el límite lo pone el usuario.

_Tu código:_
```java
import java.util.Scanner;

  

public class Suma {

    public static void main(String[] args) throws Exception {

       Scanner sc = new Scanner(System.in);

    // Pedir al usuario un número

    System.out.print(" Ingresa un número: ");

    int num = sc.nextInt();

    int sum = 0;

  

    System.out.println("Ingresaste el nuúmero:  " + num);

    for (int i = 1; i <= num; i++) {

    sum = sum + i;  

}

System.out.println("La suma del numero 1 al  " + num + " es = "+ sum);

  

sc.close();

    }

  

}
```

✅ ¡Ejercicio 2 entregado! Tu solución funciona correctamente.

---

## Ejercicio 3 — Adivina el número

Archivo: `codigo/semana-04/AdivinaNumero.java`

**Lo que harás:** el programa tiene un número secreto. El usuario intenta adivinarlo. Si no lo adivina, el programa le dice si debe intentar con un número mayor o menor.

**Cómo pensar este ejercicio paso a paso:**

1. El programa define el número secreto (por ejemplo: `int secreto = 42;`)
2. Creas un contador de intentos: `int intentos = 0;` — va ANTES del do-while
3. Usas `do-while` porque quieres preguntar AL MENOS UNA VEZ
4. Dentro del `do`:
   - Pides el intento al usuario
   - Sumas 1 al contador: `intentos++`
   - Si el intento es menor que el secreto → imprimes "El número secreto es mayor"
   - Si el intento es mayor que el secreto → imprimes "El número secreto es menor"
5. La condición del `while`: repite mientras el intento sea diferente al secreto (`intento != secreto`)
6. DESPUÉS del ciclo: el usuario adivinó → imprimes cuántos intentos le tomó

**Modelo base:**

```java
import java.util.Scanner;

public class AdivinaNumero {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int secreto = 42;
        int intentos = 0;    // ANTES del ciclo
        int intento;

        System.out.println("Adivina el número (entre 1 y 100)");

        do {
            System.out.print("Tu intento: ");
            intento = sc.nextInt();
            intentos++;   // suma 1 al contador en cada vuelta

            if (intento < secreto) {
                System.out.println("El número secreto es mayor, intenta con uno más grande");
            } else if (intento > secreto) {
                System.out.println("El número secreto es menor, intenta con uno más pequeño");
            }
        } while (intento != secreto);   // repite mientras no adivine

        System.out.println("Lo lograste en " + intentos + " intentos!");  // DESPUÉS del ciclo
        sc.close();
    }
}
```

**Ejemplo de ejecución:**
```
Adivina el número (entre 1 y 100)
Tu intento: 50
El número secreto es menor, intenta con uno más pequeño
Tu intento: 25
El número secreto es mayor, intenta con uno más grande
Tu intento: 42
Lo lograste en 3 intentos!
```

**Conexión con la teoría:** usa `do-while` igual que el Ejemplo 5. La condición de salida es `intento != secreto`.

_Tu código:_

```java
import java.util.Scanner;

  

public class AdivinaNum {

    public static void main(String[] args) throws Exception {

        Scanner sc = new Scanner(System.in);

  

        int numero = 11;

        int intentos = 0;    

        int intento;

        System.out.println("Adivina el número (entre 1 y 100)");

  

        do {

            System.out.print("Ingresa un numero entre el 1 y el 100: ");

            intento = sc.nextInt();

            intentos++;  

  

            if (intento < numero) {

                System.out.println("El número secreto es mayor al que ingresaste, intenta con uno más grande");

            } else if (intento > numero) {

                System.out.println("El número secreto es menor al que ingresaste, intenta con uno más pequeño");

            }

        } while (intento != numero);  

  

        System.out.println("Lo lograste en " + intentos + " intentos!");  

        sc.close();

    }

    }
```


---

## Ejercicio 4 — Contador de pares

Archivo: `codigo/semana-04/ContadorPares.java`

**Lo que harás:** pedir un número N e imprimir todos los números pares del 1 hasta N.

Un número es par cuando `numero % 2 == 0` (el residuo de dividirlo entre 2 es cero).

**Cómo pensar este ejercicio:**

1. Lees N del usuario
2. Recorres del 1 hasta N con un `for`
3. Dentro del ciclo: si `i % 2 == 0`, imprimes `i`

**Modelo base:**

```java
import java.util.Scanner;

public class ContadorPares {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Ingresa N: ");
        int n = sc.nextInt();

        System.out.println("Números pares del 1 al " + n + ":");  // ANTES del ciclo
        for (int i = 1; i <= n; i++) {
            if (i % 2 == 0) {
                System.out.println(i);    // DENTRO del ciclo, solo cuando es par
            }
        }
        sc.close();
    }
}
```

**Salida esperada si el usuario ingresa 10:**
```
Ingresa N: 10
Números pares del 1 al 10:
2
4
6
8
10
```

_Tu código:_

```java
import java.util.Scanner;
public class ContadorPares {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
    int contador = 0 ;
    // Pedir al usuario un número
    System.out.print(" Ingresa un número: ");
    int num = sc.nextInt();
    System.out.println("Números pares del 1 al " + num + ":");
    // Dentro del ciclo: si `i % 2 == 0`, imprimes `i`
    for (int i = 1; i <= num; i++) {
        if (i % 2 == 0) {
            contador += 1;
               System.out.println(i);
            }
    }
    System.out.println("El numero " + num + " contiene " + contador + " numeros pares");
    sc.close();

    }
}
```

---

## ¿Qué ciclo usé en cada ejercicio?

| Ejercicio | Ciclo que usé | ¿Por qué ese ciclo? |
|-----------|--------------|---------------------|
| Tabla de multiplicar | `for` | Porque sé que son exactamente 10 repeticiones |
| Suma del 1 al N | `for` | Porque recorro del 1 hasta N, cantidad conocida |
| Adivina el número | `do-while` | Porque quiero preguntar al menos una vez |
| Contador de pares | `for` | Porque recorro del 1 hasta N |
