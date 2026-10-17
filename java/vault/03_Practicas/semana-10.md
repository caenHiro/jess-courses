---
semana: 10
tema: Excepciones y Colecciones
estado: pendiente
---

# Práctica — Semana 10: Excepciones y Colecciones

> Guarda tu código en: `codigo/semana-10/`
> Al terminar: `bash scripts/push.sh "semana-10 excepciones"`

---

## Ejercicio 1 — Calculadora segura (obligatorio)

Archivo: `codigo/semana-10/CalculadoraSegura.java`

Crea una calculadora que pida dos números y la operación (+, -, *, /). Usa `try/catch` para manejar:
- División entre 0
- Si el usuario escribe algo que no es número (`NumberFormatException`)
- Cualquier otro error inesperado

El programa no debe explotar aunque el usuario escriba basura.

_Tu código:_
```java
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
```
---

## Ejercicio 2 — Lista de tareas con ArrayList (obligatorio)

Archivo: `codigo/semana-10/ListaTareas.java`

Crea un programa con menú (do-while + switch) que permita:
1. Agregar tarea
2. Ver todas las tareas
3. Eliminar tarea por número
4. Salir

Usa un `ArrayList<String>` para guardar las tareas.

_Tu código:_
```java
import java.util.ArrayList;  

import java.util.Scanner;

  

public class ListaTareas  {

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

  

            case 2  :

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
```
---

## Ejercicio 3 — Agenda con HashMap (reto)

Archivo: `codigo/semana-10/Agenda.java`

Crea una agenda usando `HashMap<String, String>` donde la clave es el nombre de la persona y el valor es su teléfono.

El programa debe permitir:
- Agregar contacto
- Buscar por nombre
- Eliminar contacto
- Ver todos los contactos

_Tu código:_
```java
import java.util.HashMap;

import java.util.Scanner;

  

public class Agenda {

    public static void main(String[] args) {

        HashMap<String, String> contactos = new HashMap<> ();

        Scanner sc = new  Scanner(System.in);

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

        } while ( opcion  != 0 );

        sc.close();

    }

  

}
```
---

## Reflexión

**¿Qué pasa si no manejas una excepción?**

_Tu respuesta:_

**¿Cuál es la diferencia entre un array normal y un ArrayList?**

_Tu respuesta:_

**¿En qué situación usarías HashMap en lugar de ArrayList?**

_Tu respuesta:_
