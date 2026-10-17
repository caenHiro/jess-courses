import java.util.HashMap; 
import java.util.Scanner;

public class Agenda {
    public static void main(String[] args) {
        HashMap<String, String> contactos = new HashMap<> ();
        Scanner sc = new  Scanner(System.in);
        int opcion;

        do{
            System.out.println("\n=== Agenda de Contactos ===");
            System.out.println("1. Agregar contacto");
            System.out.println("2. Buscar por nombre");
            System.out.println("3. Eliminar contacto");
            System.out.println("4. Ver todos los contactos");
            System.out.println("0. Salir");
            System.out.print("Opción: ");
            opcion = sc.nextInt();
            sc.nextLine();

            switch (opcion){
                case 1:
                    System.out.println("Nombre: ");
                    String nombre = sc.nextLine();
                    System.out.println("Telefono: ");
                    String telefono = sc.nextLine();
                    contactos.put(nombre, telefono);
                    System.out.println("Contacto guardado con exito.");
                    break;

                case 2:
                    System.out.println("Aquien buscas?");
                    String busqueda = sc.nextLine();
                    if(contactos.containsKey(busqueda)){
                        System.out.println("Busqueda: " + contactos.get(busqueda));
                    } else {
                        System.out.println(" Contacto no encontrado ");
                    }
                    break;

                case 3:
                    System.out.println("a quien quieres eliminar? ");
                    String eliminar = sc.nextLine();
                    if(contactos.containsKey(eliminar)){
                        contactos.remove(eliminar);
                        System.out.println("Contacto eliminado con exito ");
                    } else {
                        System.out.println("Contacto no encontrado. ");
                    }
                    break;

                    case 4:
                        if( contactos.isEmpty()){
                            System.out.println("La agenda esta vacia.");
                        } else {
                            System.out.println("Todos los contactos: ");
                            for (String n : contactos.keySet()){
                                System.out.println(" " + n + " : " + contactos.get(n));
                            }
                        }
                        break;
                    case 0:
                        System.out.println(" Hasta luego.");
                        break;
            }
        } while ( opcion  != 0 );
        sc.close();
    }

}
