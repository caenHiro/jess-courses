public class ListaFrutas {
   public static void main(String[] args) {

        // Lista de frutas
        String[] frutas = {"platano", "cereza", "kiwi", "pera", "piña"};

        System.out.println("Lista al reves:");

        for (int i = frutas.length - 1; i >= 0; i--) {
            System.out.println(frutas[i]);   // imprime el elemento en posicion i
        }
        
    }
}
