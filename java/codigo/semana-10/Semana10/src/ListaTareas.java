import java.util.ArrayList;   
import java.util.Scanner;

public class ListaTareas  {
    public static void main(String[] args) {
    ArrayList<String> tareas = new ArrayList<>();   
        Scanner sc = new Scanner(System.in);
        int opcion;  
        do{
            System.out.println("\n=== Lista de Tareas ===");
            System.out.println("1. Agregar tarea");
            System.out.println("2. Ver tareas");
            System.out.println("3. Eliminar tarea");
            System.out.println("0. Salir");
            System.out.print("Elige una pción: ");
            opcion = sc.nextInt();   
            sc.nextLine();  
        
        switch(opcion) {
            case 1: 
            System.out.print("Escribe la tarea: ");
            String nuevaTarea = sc.nextLine();
            tareas.add(nuevaTarea); 
            System.out.println("Tarea agregada.");
            break;

            case 2  : 
            if(tareas.isEmpty()){
                System.out.println("No hay tareas pendientes.");
            } else {
                System.out.println("Tus tareas son: " );
                for (int i = 0 ; i < tareas.size(); i++){
                    System.out.println((i + 1 ) + " . " + tareas.get(i));
                }
            }
            break;
            
            case 3 :
                if (tareas.isEmpty()){
                    System.out.println("No hay tareas para eliminar");
                } else {
                    System.out.println("¿Que número deseas eliminar? ");
                    int num = sc.nextInt();
                    sc.nextLine();
                    int indice = num - 1;

                    if (indice >= 0 && indice < tareas.size()) {
                        String eliminada = tareas.get(indice);
                        tareas.remove(indice);
                        System.out.println(" Eliminada: " + eliminada);
                    } else {
                        System.out.println("Numero invalido. Elige un numero entre el 1 y el " + tareas.size());
                    }
                }
                break;

                case 0 :
                    System.out.println(" Regresa pronto, bye!");
                    break;

                    default:
                        System.out.println(" Opcion no valida. Elige un numero 0, 1, 2 o 3 ");
        }

         } while (opcion != 0); 
        sc.close();
    }

}
