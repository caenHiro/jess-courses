---
semana: 2
tema: Entrada de datos y Operadores
estado: pendiente
---

# Práctica — Semana 2: Entrada de datos y Operadores

> Guarda tu código en: `codigo/semana-02/`
> Al terminar: `bash scripts/push.sh "semana-02 calculadora"`

---

## Ejercicio 1 — Calculadora interactiva (obligatorio)

Archivo: `codigo/semana-02/Calculadora.java`

El programa debe:
1. Pedir al usuario dos números (pueden tener decimales)
2. Calcular e imprimir: suma, resta, multiplicación y división

> Dato curioso: si divides entre 0 con `double`, Java muestra `Infinity`. No hay error — simplemente ese es el resultado matemático.

Ejemplo de salida:
```
Ingresa el primer número: 10
Ingresa el segundo número: 3
Suma:           13.0
Resta:          7.0
Multiplicación: 30.0
División:       3.3333333333333335
```

_Tu código:_
import java.util.Scanner;

public class CalculadoraInteractiva {
  
     public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);

    //Solicita los numeros al usuario
        System.out.print(" Ingresa el primer número: ");
        double numero1 = sc.nextDouble();
        System.out.print(" Ingresa el segundo número: ");
        double numero2 = sc.nextDouble();


    //Calcular e imprimir: suma, resta, multiplicación y división
        System.out.println( numero1 + numero2);
        System.out.println( numero1 - numero2);
        System.out.println( numero1 * numero2);
        System.out.println( numero1 / numero2);
        sc.close();
    }
}
---

## Ejercicio 2 — Calculadora de propina (obligatorio)

Archivo: `codigo/semana-02/Propina.java`

El programa debe:
1. Pedir el subtotal de una cuenta de restaurante
2. Pedir el porcentaje de propina que quiere dejar (ej: 10, 15, 20)
3. Calcular e imprimir la propina y el total final

Ejemplo:
```
Subtotal: $350.0
Propina (15%): $52.5
Total: $402.5
```

_Tu código:_
import java.util.Scanner;
public class CalculadoraPropina {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
    //Solicita subtotal de la cuenta del restaurante
        System.out.print(" Ingresa el subtotal de tu cuenta : ");
        double subtotal = sc.nextDouble();
        System.out.print(" Ingresa el porcentaje de propina que desea dejar : ");
        double PorcentajeP = sc.nextDouble();
        System.out.println("Subtotal: $" + subtotal);
        double propina = ((subtotal * PorcentajeP) / 100);
         System.out.println( "Propina " + PorcentajeP + "% : $" + propina );
        double total  = subtotal + propina;
        System.out.println("Total: $" + total);
        }

}

---

## Ejercicio 3 — Calculadora de IMC (reto)

Archivo: `codigo/semana-02/CalculadoraIMC.java`

La fórmula del Índice de Masa Corporal es:
```
IMC = peso (kg) / estatura² (metros)
```

El programa debe:
1. Pedir peso y estatura al usuario
2. Calcular e imprimir el IMC

_Tu código:_
import java.util.Scanner;
public class CalculadoraIMC {
     public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
    //Solicita subtotal de la cuenta del restaurante
        System.out.print(" Ingresa tu peso  en Kg: ");
        double peso = sc.nextDouble();
        System.out.print(" Ingresa tu estatura en metros: ");
        double estatura = sc.nextDouble();
    //IMC = peso (kg) / estatura² (metros)
        double imc = peso / (estatura * estatura) ;
        System.out.println("Tu IMC es: " + imc);
     }
}

---

## Reflexión

**¿Qué fue lo más fácil?**

_Tu respuesta:_

**¿Qué fue lo más confuso?**

_Tu respuesta:_
Que no había visto el tema de los if y me pedían un ejercicio donde había que ocuparlo 
**¿Tuviste algún error? ¿Qué decía?**

_Tu respuesta:_
No
**¿Pudiste resolver el ejercicio 3 de reto?**

_Tu respuesta:_
Si