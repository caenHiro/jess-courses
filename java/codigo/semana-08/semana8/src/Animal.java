public class Animal {
    protected String nombre;
    protected String especie;

    public Animal( String nombre, String especie) {
        this.nombre = nombre;
        this.especie = especie;
    }

    public void comer(){
        System.out.println("El " +  nombre + " esta comiendo.");
    }
    public void dormir() {
        System.out.println("El " +  nombre + " esta durmiendo.");
    }
    public void tomarAgua(){
        System.out.println("El " + nombre + " esta tomando agua.");
    }
    public void hacerSonido() {
        System.out.println( " ...");
    }

}
