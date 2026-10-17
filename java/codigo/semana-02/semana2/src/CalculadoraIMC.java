import java.util.Scanner;

public class CalculadoraIMC {
     public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
    //Solicita subtotal de la cuenta del restaurante 
        System.out.print(" Ingresa tu peso  en Kg: ");
        double peso = sc.nextDouble();
        System.out.print(" Ingresa tu estatura en metros: ");
        double estatura = sc.nextDouble();

    //IMC = peso (kg) / estatura² (metros)

        double imc = peso / (estatura * estatura) ;

        System.out.println("Tu IMC es: " + imc);

     }
}
