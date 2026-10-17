public class Camion extends Vehiculo{

    public Camion(String marca, String modelo) {
        super(marca, modelo, 120);
    }

    @Override
    public double calcularConsumo(double km) {
        return km * 0.25;
    }

}
