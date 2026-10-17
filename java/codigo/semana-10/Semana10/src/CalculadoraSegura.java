import java.util.Scanner;

public class CalculadoraSegura {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        try{
            System.out.print("Ingresa tu primer numero: ");
            double a = Double.parseDouble(sc.nextLine());

            System.out.print("Ingresa tu primer numero: ");
            double b = Double.parseDouble(sc.nextLine());

            System.out.print("Que operación quieres realizar +, -, * o / ");
            String op = sc.nextLine().trim();

            double resultado;

            switch (op){
                case "+":
                    resultado = a + b;
                    break;
                case "-":
                    resultado = a - b;
                    break;
                case "*":
                    resultado = a * b;
                    break;
                case "/":
                    if( b == 0){
                        throw new ArithmeticException("No se permite la división entre 0");
                    }
                    resultado = a / b;
                    break;
                default:
                    throw new IllegalArgumentException("Operación no valida " + op);
            }
            System.out.println("El resultado de tu operación es: " + resultado);
        } catch (NumberFormatException e) {
            System.out.println("Error, solo puedes ingresar numero y sin espacios ni caracteres especiales ");
        } catch (ArithmeticException | IllegalArgumentException e) {
           System.out.println("Error: " + e.getMessage());
        } finally {
            System.out.println("Calculadora cerrada.");
            sc.close();
        }
    }
}