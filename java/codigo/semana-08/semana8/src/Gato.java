public class  Gato extends Animal {
    public Gato(String nombre) {
        super( nombre,  " Felino");
    }
    @Override
    public void  hacerSonido() {
        System.out.println("El " + nombre + " hace Miau!");
    }
    public void ronronear() {
        System.out.println("El " + nombre + " ronronea");
    }

}
