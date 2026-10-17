import java.util.Scanner;

public class TablaMultiplicar {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
    
    // Pedir al usuario un número
    System.out.print(" Ingresa un número: ");
    int num = sc.nextInt();

    System.out.println("Tabla del " + num + ": ") ;

    for (int i = 1; i <= 10; i++) {
    System.out.println( num + " x " + i + " = " + i * num);
}
     }

}
