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


