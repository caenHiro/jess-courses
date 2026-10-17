public class Circulo extends Figura {
    private  double radio;
    public  Circulo(String color, String nombre, double  radio) {
        super(color, nombre);
        this.radio = radio;
    }
    @Override
    public  double calcularArea() {
        return  Math.PI * radio * radio;
    }
}
