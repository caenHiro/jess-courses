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
        double total  = subtotal + propina;
        System.out.println("Total: $" + total);
        }
}
