public class MainVehiculos {
    public static void main(String[] args) {
        Vehiculo auto = new Auto ("Toyota", "Camry");
        Vehiculo camion = new Camion("Kenworth", "T680");
        Vehiculo moto = new  Moto("Daytona", "GT1");

        double distancia = 100.0;
        Vehiculo[] flota = { auto, camion, moto };
        for(Vehiculo v : flota){
            v.mostrarInfo();
            double litros = v.calcularConsumo(distancia);
            System.out.println("El consum de su  vehiculo es: " + distancia + litros );
        }
    }

}
