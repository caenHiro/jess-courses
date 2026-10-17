public class Main {
    public static void main(String[] args) {
        Perro perro = new Perro("Tifon");
        Gato gato = new Gato( "Garfiel");
        Pajaro pajaro = new Pajaro("Piolin");

        System.out.println("=== Heredados del padre ===");
        perro.comer();
        gato.dormir();
        pajaro.tomarAgua();

        System.out.println("\n=== Polimorfismo ===");
        Animal[] animales = {perro , gato , pajaro};
        for (Animal a : animales){
            a.hacerSonido();
        }

        System.out.println("\n=== Polimorfismo ===");
        perro.buscarPelota();
        gato.ronronear();
        pajaro.volar();
    }
    
}
