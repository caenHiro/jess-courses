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
