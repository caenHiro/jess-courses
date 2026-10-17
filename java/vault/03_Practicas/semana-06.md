---
semana: 6
tema: Métodos
estado: pendiente
---

# Práctica — Semana 6: Métodos

> Guarda tu código en: `codigo/semana-06/`
> Al terminar: `bash scripts/push.sh "semana-06 metodos"`

---

## Ejercicio 1 — Calculadora con métodos (obligatorio)

Archivo: `codigo/semana-06/CalculadoraMetodos.java`

Toma tu calculadora de la semana 2 y refactorízala: en lugar de hacer los cálculos dentro del `main`, crea métodos separados para cada operación:
- `sumar(double a, double b)`
- `restar(double a, double b)`
- `multiplicar(double a, double b)`
- `dividir(double a, double b)` — con manejo de división entre 0

_Tu código:_

```java
import java.util.Scanner;
public class CalculadoraConMetodos {
//metodos suma, resta, multiplicar y dividir
    public static double sumar(double a, double b) {
        return a + b;
    }
    public static double resta(double a, double b) {
        return a - b;
    }
    public static double multiplicion(double a, double b) {
        return a * b;

    }
    public static double division(double a, double b) {
        if (b == 0) {
            System.out.println("Error: no se puede dividir entre cero");
            return 0;  
        }
        return a / b;  
    }
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
// Solicita el primer numero
        System.out.print("Ingresa el primer numero: ");
        double a = sc.nextDouble();  
//solicita el segundo numero
        System.out.println("Ingresa el segundo numero: ");
        double b = sc.nextDouble();
// Llama cada metodo e imprime el resultado
        System.out.println("El resultado de la suma es: " + sumar(a, b));
        System.out.println("El resultado de la resta es: " + resta (a,b));
        System.out.println("El resultado de la multiplicación es: " + multiplicion(a, b));
        System.out.println("El resultado de la division es: " + division(a, b));
        sc.close();
    }
}
```

---

## Ejercicio 2 — Validador de contraseña (obligatorio)

Archivo: `codigo/semana-06/ValidadorContrasena.java`

Crea un método `boolean esContrasenaValida(String contrasena)` que devuelva `true` si:
- Tiene al menos 8 caracteres
- Tiene al menos una letra mayúscula

Pista: `contrasena.length()` y un ciclo con `Character.isUpperCase(c)`.

_Tu código:_

```java

import java.util.Scanner;
public class ValidadorContrasenas {
    public static boolean contrasenaValida(String contrasena) {
        if (contrasena.length() < 8) {
            System.out.println("La contraseña no cuenta con los caracteres requeridos, vuelve a intentarlo");
            return false;  
         }
        for (char c : contrasena.toCharArray()) {
            if (Character.isUpperCase(c)) {
               System.out.println("La contraseña se genero correctamente");
                return true;  
            }
        }

        System.out.println("La contraseña no cuenta con ninguna mayuscula, vuelve a intentarlo ");
        return false; 
    }
    public static void main(String[] args) {
         Scanner sc = new Scanner(System.in);
         System.out.print("Genera una contraseña mayor a 8 digitos y con almenos una mayuscula: ");
         String contrasena = sc.nextLine();
         System.out.println(contrasenaValida(contrasena));
        //System.out.println(contrasenaValida("Contrasena"));
        //System.out.println(contrasenaValida("contrasena"));
        //System.out.println(contrasenaValida("Casena"));
        //System.out.println(contrasenaValida("C123456789"));

    }

}
```

---

## Ejercicio 3 — Número primo (reto)

Archivo: `codigo/semana-06/EsPrimo.java`

Crea un método `boolean esPrimo(int n)` que devuelva `true` si el número es primo.

Luego en `main`, imprime todos los números primos del 1 al 50.

Pista: un número primo solo es divisible entre 1 y él mismo.

_Tu código:_

```java
public class NumeroPrimo {
    // numeros primos
    //2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 
    public static boolean esPrimo( int numero) {
        if(numero < 2){
            return false;
        }
        for ( int n = 2; n <= Math.sqrt(numero); n++){
                if (numero % n == 0) {
                    return false;
                }
            }
            return true;
    }
    public static void main(String[] args) {
        int contador = 0;
        System.err.println("Los numeros primos del 1 al 50 son:  " );
        for (int n = 1; n <= 50 ; n++) {
            if (esPrimo(n)){
                contador++;
                 System.out.println(n + ", ");
            }
        }
        System.err.println("Los numeros primos que contiene del 1 al 50 son: " + contador);
    }
}
```

---

## Reflexión

**¿Qué ventaja tiene usar métodos en lugar de escribir todo en el main?**

_Tu respuesta:_

**¿Cuál es la diferencia entre un método void y uno que devuelve int?**

_Tu respuesta:_

**¿Pudiste hacer el validador de contraseña? ¿Cómo lo resolviste?**

_Tu respuesta:_
