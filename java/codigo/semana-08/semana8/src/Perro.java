public class Perro extends  Animal{
    public Perro (String nombre) {
        super(nombre, "Canino");
    }
    @Override
    public  void hacerSonido() {
        System.out.println("El " + nombre + " hace Guau!");
    }
    public void  buscarPelota() {
        System.out.println( "El " + nombre + " busca la pelota.");
    }
}
