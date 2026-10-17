public class Moto extends  Vehiculo{

    public Moto(String marca, String modelo) {
        super(marca, modelo, 180);
    }

    @Override
    public double calcularConsumo(double km) {
        return  km * 0.04;
    }

}
