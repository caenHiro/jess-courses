import java.util.Scanner;

public class ValidadorContrasenas {
    public static boolean contrasenaValida(String contrasena) {
        if (contrasena.length() < 8) {
            System.out.println("La contraseña no cuenta con los caracteres requeridos, vuelve a intentarlo");
            return false;  
         }

        for (char c : contrasena.toCharArray()) {
            if (Character.isUpperCase(c)) {
                System.out.println("La contraseña se genero correctamente");
                return true;   
            }
        }
        System.out.println("La contraseña no cuenta con ninguna mayuscula, vuelve a intentarlo ");
        return false;

    } 

    public static void main(String[] args) {
         Scanner sc = new Scanner(System.in);

         System.out.print("Genera una contraseña mayor a 8 digitos y con almenos una mayuscula: ");
         String contrasena = sc.nextLine();

         System.out.println(contrasenaValida(contrasena));
       //  System.out.println(contrasenaValida("Contrasena"));
        //System.out.println(contrasenaValida("contrasena"));
        //System.out.println(contrasenaValida("Casena"));
        //System.out.println(contrasenaValida("C123456789"));
    }
    
}
