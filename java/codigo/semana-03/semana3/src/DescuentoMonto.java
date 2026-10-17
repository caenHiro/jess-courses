import java.util.Scanner;

public class DescuentoMonto {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);

    System.out.print("Ingresa el monto de compra: ");
    double monto = sc.nextDouble();

      if (monto >= 1000) {
System.out.println("Tu descuento es del 20% \n"  + "Tu ahorro es de: $" 
    + monto * .20 + "\nEl total a pagar es : $" + (monto - (monto * .20)));
} else if (monto >= 500) {
    System.out.println("Tu descuento es del 10% \n"  + "Tu ahorro es de: $" 
    + monto * .10 + "\nEl total a pagar es : $" + (monto - (monto * .10)));
} else if (monto >= 200) {
    System.out.println("Tu descuento es del 5% \n"  + "Tu ahorro es de: $" 
    + monto * .05 + "\nEl total a pagar es : $" + (monto - (monto * .05)));
} else {
    System.out.println("No tiene descuento");
}
    }

}
