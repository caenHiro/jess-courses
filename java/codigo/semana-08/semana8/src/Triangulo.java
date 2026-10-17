public class Triangulo extends Figura{
    private double base;
    private double altura;

    public Triangulo(  String color,String nombre, double base, double  altura){
        super(color, nombre);
        this.base = base;
        this.altura = altura;
    }
    @Override
    public double  calcularArea() {
        return base * altura / 2;
    }

}
