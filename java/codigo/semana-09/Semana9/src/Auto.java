public class Auto extends Vehiculo{

    public Auto(String marca, String modelo) {
        super(marca, modelo, 200);
    }

    @Override
    public double calcularConsumo(double km) {
       return km + 0.08;
    }

}
