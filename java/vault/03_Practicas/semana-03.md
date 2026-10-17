---
semana: 3
tema: Condicionales
estado: pendiente
---

# Práctica — Semana 3: Condicionales

> Guarda tu código en: `codigo/semana-03/`
> Al terminar: `bash scripts/push.sh "semana-03 condicionales"`

---

## Ejercicio 1 — Sistema de calificaciones (obligatorio)

Archivo: `codigo/semana-03/Calificaciones.java`

El programa debe:
1. Pedir al usuario una calificación del 0 al 100
2. Mostrar la letra correspondiente según esta tabla:

| Rango  | Letra          |
| ------ | -------------- |
| 90–100 | A — Excelente  |
| 80–89  | B — Muy bien   |
| 70–79  | C — Bien       |
| 60–69  | D — Suficiente |
| 0–59   | F — Reprobado  |

_Tu código:_
import java.util.Scanner;
public class SistemaCalificaciones {
     public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
    // Pedir al usuario una calificación del 0 al 100
    System.out.print(" Ingresa una calificacion del 0 al 100: ");
    double calificacion = sc.nextDouble();
    if (calificacion >= 90) {
    System.out.println("A");
} else if (calificacion >= 80) {
    System.out.println("B");
} else if (calificacion >= 70) {
    System.out.println("C");
} else if (calificacion >= 60){
    System.out.println("D");
} else {
    System.out.println("F");
}
    }
}

---

## Ejercicio 2 — Descuento por monto (obligatorio)

Archivo: `codigo/semana-03/Descuento.java`

Una tienda aplica descuentos según el monto de compra:

| Monto mínimo  | Descuento     |
| ------------- | ------------- |
| $1000 o más   | 20%           |
| $500 a $999   | 10%           |
| $200 a $499   | 5%            |
| Menos de $200 | Sin descuento |

El programa debe:
1. Pedir el monto de la compra
2. Calcular e imprimir: el porcentaje de descuento, cuánto ahorra, y el total final

_Tu código:_
import java.util.Scanner;
public class DescuentoMonto {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
    System.out.print("Ingresa el monto de compra: ");
    double monto = sc.nextDouble();
      if (monto >= 1000) {
System.out.println("Tu descuento es del 20% \n"  + "Tu ahorro es de: $"
    + monto * .20 + "\nEl total a pagar es : $" + (monto - (monto * .20)));
} else if (monto >= 500) {
    System.out.println("Tu descuento es del 10% \n"  + "Tu ahorro es de: $"
    + monto * .10 + "\nEl total a pagar es : $" + (monto - (monto * .10)));
} else if (monto >= 200) {
    System.out.println("Tu descuento es del 5% \n"  + "Tu ahorro es de: $"
    + monto * .05 + "\nEl total a pagar es : $" + (monto - (monto * .05)));
} else {
    System.out.println("No tiene descuento");
}
    }
}

---

## Ejercicio 3 — Menú del día (reto)

Archivo: `codigo/semana-03/MenuDia.java`

El programa debe:
1. Pedir un número del 1 al 7 (1=Lunes, 7=Domingo)
2. Usar `switch` para mostrar un mensaje diferente para cada día
3. Si el número no está entre 1 y 7, mostrar: "Número no válido"

_Tu código:_
import java.util.Scanner;
public class Menu {
     public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
    System.out.print(" Ingresa un numero del 1 al 7: ");
    int numero = sc.nextInt();
    switch (numero) {
    case 1:
        System.out.println("Ensalada");
        break;
    case 2:
        System.out.println("Tacos");
        break;
    case 3:
        System.out.println("Hamburguesa");
        break;
    case 4:
        System.out.println("Hot Dog");
        break;
    case 5:
        System.out.println("Chilaquiles");
        break;
    case 6:
        System.out.println("Pozole");
        break;
    case 7:
        System.out.println("Barbacoa");
        break;
    default:
        System.out.println("Numero no válido");
}
    }
}

---

## Reflexión

**¿Cuál fue la diferencia entre if/else y switch? ¿Cuándo usarías cada uno?**

_Tu respuesta:_

**¿Qué es lo que más te costó trabajo?**

_Tu respuesta:_

**¿Lograste cubrir todos los casos en el ejercicio 1? (¿qué pasa si alguien pone 110?)**

_Tu respuesta:_
