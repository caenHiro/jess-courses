---
semana: 1
tema: Variables y tipos de datos
estado: pendiente
---

# Práctica — Semana 1: Variables y tipos de datos

> Guarda tu código en: `codigo/semana-01/`
> Al terminar, sube con: `bash scripts/push.sh "semana-01 variables"`

---

## Ejercicio 1 — Mi presentación (obligatorio)

Crea el archivo `codigo/semana-01/MiPresentacion.java`.

El programa debe imprimir en pantalla:
- Tu nombre
- Tu edad
- Tu ciudad
- Tu estatura (en metros)

Usa una variable para **cada dato**. No escribas todo en un solo `println`.

Ejemplo de lo que debe verse al correrlo:
```
=== Mi presentacion ===
Nombre: Jessica
Edad: 22 años
Ciudad: Ciudad de Mexico
Estatura: 1.63 m
```

**Escribe aquí tu código (o pega el nombre del archivo que creaste):**

_Tu respuesta:_

public class MiPresentacion {

     public static void main(String[] args) throws Exception {

  

        //Imprime resultado

        String nombre = "Jessica";

        int edad = 35;

        String ciudad =  "CDMX";

        double estatuta = 1.60 ;

  

        // Imprime resultado

        System.out.println(" === Mi presentación ===");

        System.out.println("Nombre: " + nombre + ".");

        System.out.println("Edad: " + edad + ".");

        System.out.println("Ciudad: " + ciudad + ".");

        System.out.println("Estatura: " + estatuta + "m.");

  

    }

  

}

---

## Ejercicio 2 — Precio de manzanas (obligatorio)

Crea el archivo `codigo/semana-01/PrecioManzanas.java`.

Tienes estas condiciones:
- El precio por kilogramo de manzanas es $35
- Quieres comprar 3 kilogramos

El programa debe calcular e imprimir el total a pagar.

Usa variables para el precio por kg, los kilogramos y el total.

**Escribe aquí tu código:**

_Tu respuesta:_
public class PrecioManzanas {

    public static void main(String[] args) throws Exception {

  

        //variables

        int precio = 35;

        int kg = 3;

        double total = precio * kg ;

  

        //Imprime resultado

        System.out.println("Total a pagar: $" + total);

    }

  

}
---

## Ejercicio 3 — Convertidor de temperatura (reto opcional)

Crea el archivo `codigo/semana-01/ConvertidorTemperatura.java`.

La fórmula para convertir Celsius a Fahrenheit es:
```
fahrenheit = (celsius × 9 / 5) + 32
```

Haz un programa que:
- Tenga una variable `celsius` con el valor 37.0
- Calcule los Fahrenheit equivalentes
- Imprima el resultado como: `37.0 °C = 98.6 °F`

**Escribe aquí tu código:**

_Tu respuesta:_
public class ConvertidorTemperatura {

    public static void main(String[] args) throws Exception {

        //fahrenheit = (celsius × 9 / 5) + 32

        //Variables

        double celcius = 37;

        double fahrenheit = ( (celcius * 9 ) / 5 ) + 32;

        //Imprime resultado - Imprima el resultado como: `37.0 °C = 98.6 °F`

        System.out.println(celcius + "°C = " + fahrenheit + "°F" );

    }

  

}
---

## Reflexión (importante — no saltes esta parte)

Después de terminar los ejercicios, responde aquí:

**¿Qué fue lo más fácil de esta semana?**

_Tu respuesta:_

**¿Qué fue lo más difícil o confuso?**

_Tu respuesta:_ Tener la incertidumbre de saber si estaba entendiendo bien lo que se me pedía 

**¿Tuviste algún error que no supiste resolver? ¿Cuál fue?**

_Tu respuesta:_ No

**¿Cómo te sentiste al ver que el programa corrió?**

_Tu respuesta:_ Sentí que me faltaba entender algo o los ejercicios aun no tiene complejidad

---

> Carlos revisará tu código y tus respuestas. Si algo no funcionó, no hay problema — escribe qué intentaste.
