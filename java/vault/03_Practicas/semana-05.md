---
semana: 5
tema: Arrays y Strings
estado: pendiente
---

# Práctica — Semana 5: Arrays y Strings

> Guarda tu código en: `codigo/semana-05/`
> Al terminar: `bash scripts/push.sh "semana-05 arrays"`

---

## Ejercicio 1 — Lista de frutas al revés (obligatorio)

Archivo: `codigo/semana-05/FrutasReversa.java`

Crea un array con 5 frutas de tu elección. Luego imprime la lista en orden INVERSO (del último al primero).

_Tu código:_

```java
public class ListaFrutas {

   public static void main(String[] args) {
        // Lista de frutas
        String[] frutas = {"platano", "cereza", "kiwi", "pera", "piña"};
        System.out.println("Lista al reves:");
        for (int i = frutas.length - 1; i >= 0; i--) {
            System.out.println(frutas[i]);   // imprime el elemento en posicion i
        }
    }
}
```

---

## Ejercicio 2 — Contar vocales (obligatorio)

Archivo: `codigo/semana-05/ContarVocales.java`

El programa debe:
1. Tener una cadena de texto con tu nombre completo
2. Contar cuántas vocales (a, e, i, o, u) tiene
3. Imprimir el resultado

Pista: usa `charAt(i)` en un ciclo y compara cada caracter.

_Tu código:_
```java
public class ContarVocales {

    public static void main(String[] args) throws Exception {

        String nombre = "Jessica Yadziry Chino Colin";

        int contador = 0;

        for (int i = 0 ; i < nombre.length(); i++ ) {

            if (nombre.charAt(i) == 'a' || nombre.charAt(i) == 'e' || nombre.charAt(i) == 'i' || nombre.charAt(i) == 'o' || nombre.charAt(i) == 'u'){

                contador++;

            }

}

    System.out.println(nombre + " tiene " + contador + " vocales");  

    }

}
```
---

## Ejercicio 3 — Promedio de calificaciones (reto)

Archivo: `codigo/semana-05/Promedio.java`

El programa debe:
1. Tener un array con 6 calificaciones
2. Calcular el promedio
3. Encontrar la calificación más alta y la más baja
4. Imprimir todo

_Tu código:_
```java
public class Promedio {

    public static void main(String[] args) throws Exception {

        double[] calificaciones = {55, 77, 95, 100, 88, 67};
        double sum = 0;
        double max = calificaciones[0];
        double min = calificaciones[0];

  
        for (double c : calificaciones) {
            sum += c;          
            if (c > max) {
                max = c;        
            }

            if (c < min) {
                min = c;        
            }
        }
        double promedio = sum / calificaciones.length; 
        System.out.println("El promedio es: " + promedio);    
        System.out.println("Calificación mas alta: " + max);          
        System.out.println("Calificación mas baja: " + min);

  

    }

  

}
```
---

## Reflexión

**¿Por qué los índices empiezan en 0 y no en 1?**

_Tu respuesta:_

**¿Qué método de String te pareció más útil?**

_Tu respuesta:_

**¿Tuviste algún error de "ArrayIndexOutOfBoundsException"? ¿Qué significa?**

_Tu respuesta:_
