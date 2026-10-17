public class Pajaro extends Animal {
    public Pajaro(String nombre) {
        super(nombre, "Ave");
    }
    @Override
    public void hacerSonido(){
        System.out.println("El " + nombre + " hace Pio!");
    }
    public void volar(){
        System.out.println("El " + nombre + " vuela.");
    }

}
