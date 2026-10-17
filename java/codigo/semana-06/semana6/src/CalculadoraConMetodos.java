import java.util.Scanner;

public class CalculadoraConMetodos {

//metodos suma, resta, multiplicar y dividir
    public static double sumar(double a, double b) {
        return a + b;
    }

    public static double resta(double a, double b) {
        return a - b;
    }

    public static double multiplicion(double a, double b) {
        return a * b;
    }

    public static double division(double a, double b) {
        if (b == 0) {
            System.out.println("Error: no se puede dividir entre cero");
            return 0;   
        }
        return a / b;   
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

// Solicita el primer numero
        System.out.print("Ingresa el primer numero: ");
        double a = sc.nextDouble();   

//solicita el segundo numero
        System.out.println("Ingresa el segundo numero: ");
        double b = sc.nextDouble(); 

// Llama cada metodo e imprime el resultado
        System.out.println("El resultado de la suma es: " + sumar(a, b));
        System.out.println("El resultado de la resta es: " + resta (a,b));
        System.out.println("El resultado de la multiplicación es: " + multiplicion(a, b));
        System.out.println("El resultado de la division es: " + division(a, b));

        sc.close();
    }

}
