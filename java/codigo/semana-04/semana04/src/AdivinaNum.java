import java.util.Scanner;

public class AdivinaNum {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);

        int numero = 11;
        int intentos = 0;    
        int intento;
        System.out.println("Adivina el número (entre 1 y 100)");

        do {
            System.out.print("Ingresa un numero entre el 1 y el 100: ");
            intento = sc.nextInt();
            intentos++;   

            if (intento < numero) {
                System.out.println("El número secreto es mayor al que ingresaste, intenta con uno más grande");
            } else if (intento > numero) {
                System.out.println("El número secreto es menor al que ingresaste, intenta con uno más pequeño");
            }
        } while (intento != numero);   

        System.out.println("Lo lograste en " + intentos + " intentos!");  
        sc.close();
    }
    
    
    }


