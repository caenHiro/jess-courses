public class Figura {
    protected  String color;
    protected String nombre;

    public Figura(String color, String nombre){
        this.color = color;
        this.nombre = nombre;
    }
    public double calcularArea() {
        return 0.0;
    }
    public void mostrar() {
        System.out.println("El  " + nombre + " es color " + color + " y su area es: " + calcularArea() );
    }
}
