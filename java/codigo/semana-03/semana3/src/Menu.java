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
