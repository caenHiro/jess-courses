---
semana: 2
tema: Entrada de datos y Operadores
estado: pendiente
---

# Semana 2 — Entrada de datos y Operadores

> Tiempo estimado: 3–4 horas
> Al terminar: `bash scripts/push.sh "semana-02 entrada-operadores"`

---

## Hacer programas interactivos

Hasta ahora los datos estaban escritos directamente en el código. Pero los programas reales preguntan cosas al usuario. Para eso usamos `Scanner`.

```java
import java.util.Scanner;   // esto va al INICIO del archivo, antes de "public class"

public class Saludo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("¿Cómo te llamas? ");
        String nombre = scanner.nextLine();

        System.out.println("Hola " + nombre + "!");
        scanner.close();
    }
}
```

### Tipos de lectura con Scanner

| Método         | Lee                        | Ejemplo de uso    |
| -------------- | -------------------------- | ----------------- |
| `nextLine()`   | Texto completo (una línea) | Nombres, mensajes |
| `nextInt()`    | Número entero              | Edad, cantidad    |
| `nextDouble()` | Número con decimales       | Precio, peso      |

**Importante:** `import java.util.Scanner;` siempre va en la primera línea (antes de `public class`).

---

## Operadores aritméticos

```java
double a = 10.0;
double b = 4.0;

System.out.println(a + b);   // 14.0
System.out.println(a - b);   // 6.0
System.out.println(a * b);   // 40.0
System.out.println(a / b);   // 2.5
System.out.println(a % b);   // 2.0  (el "sobrante" de dividir)
```

El `%` (módulo) da el residuo. Por ejemplo: `10 % 3 = 1` porque `10 = 3×3 + 1`.

---

## Operadores de comparación

Estos no hacen cálculos — solo preguntan si algo es cierto o falso:

```java
int edad = 20;

System.out.println(edad == 20);   // true  — ¿es igual a 20?
System.out.println(edad != 18);   // true  — ¿es diferente de 18?
System.out.println(edad > 18);    // true  — ¿es mayor que 18?
System.out.println(edad < 18);    // false — ¿es menor que 18?
System.out.println(edad >= 20);   // true  — ¿mayor o igual a 20?
System.out.println(edad <= 20);   // true  — ¿menor o igual a 20?
```

Los usarás mucho la semana que viene con los `if`.

---

## Operadores lógicos (combinar condiciones)

| Operador | Símbolo | Ejemplo                  | Cuándo es true              |
| -------- | ------- | ------------------------ | --------------------------- |
| Y        | `&&`    | `edad >= 18 && tieneID`  | Cuando AMBAS son true       |
| O        | `\|\|`  | `dia == 6 \|\| dia == 7` | Cuando AL MENOS UNA es true |
| No       | `!`     | `!activo`                | Cuando la original es false |

---

## Ejemplo completo

```java
import java.util.Scanner;

public class InformacionPersonal {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("¿Cuál es tu nombre? ");
        String nombre = sc.nextLine();

        System.out.print("¿Cuántos años tienes? ");
        int edad = sc.nextInt();

        System.out.print("¿Cuánto pesas en kg? ");
        double peso = sc.nextDouble();

        System.out.println("--- Resumen ---");
        System.out.println("Nombre: " + nombre);
        System.out.println("Edad: " + edad);
        System.out.println("Peso: " + peso + " kg");

        sc.close();
    }
}
```

---

## Cuidados con Scanner

- Llama a `sc.close()` al final para liberar recursos
- Si mezclas `nextLine()` con `nextInt()`, a veces hay que agregar un `sc.nextLine()` extra (se llama "consumir el salto de línea" — te lo explicaré si lo encuentras)

---

## A recordar

- `Scanner` permite al usuario escribir datos cuando corre el programa
- `import java.util.Scanner;` siempre va al inicio
- Los operadores `==`, `>`, `<` devuelven `true` o `false`
- `&&` es "y", `||` es "o", `!` es "no"

---

## Siguiente paso

[[03_Practicas/semana-02]]
