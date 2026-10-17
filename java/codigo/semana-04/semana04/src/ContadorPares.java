import java.util.Scanner;

public class ContadorPares {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);

    int contador = 0 ;
    
    // Pedir al usuario un número
    System.out.print(" Ingresa un número: ");
    int num = sc.nextInt();
    

    System.out.println("Números pares del 1 al " + num + ":");

    // Dentro del ciclo: si `i % 2 == 0`, imprimes `i`

    for (int i = 1; i <= num; i++) {
        if (i % 2 == 0) {
            contador += 1;
                System.out.println(i); 
                    
            }
        
    }
    System.out.println("El numero " + num + " contiene " + contador + " numeros pares");
    sc.close();
    }

}
