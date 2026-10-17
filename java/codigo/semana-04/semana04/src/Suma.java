import java.util.Scanner;

public class Suma {
    public static void main(String[] args) throws Exception {
       Scanner sc = new Scanner(System.in);
    
    // Pedir al usuario un número
    System.out.print(" Ingresa un número: ");
    int num = sc.nextInt();
    int sum = 0;

    System.out.println("Ingresaste el nuúmero:  " + num);
    for (int i = 1; i <= num; i++) {
    sum = sum + i;   
}
System.out.println("La suma del numero 1 al  " + num + " es = "+ sum);

sc.close();
    }

}
