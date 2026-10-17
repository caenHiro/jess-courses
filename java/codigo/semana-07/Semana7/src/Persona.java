public class Persona {
    //atribitos
    private String nombre;
    private int  edad;
    private String ciudad;

    //Constructor
    public Persona (String nombre, int  edad,  String ciudad) {
        this.nombre = nombre;
        this.edad = edad;
        this.ciudad = ciudad;
    }

    public void saluda () {
        System.out.println("Hola mi nombre es " + nombre + " , tengo " + edad + " años y vivo en " + ciudad);
    }

    public boolean mayorDeEdad () {
        return edad >= 18;
    }

    public String getNombre() {
        return nombre;
    }
    public int getEdad() {
        return edad;
    }
    public String getCiudad(){
        return ciudad;
    }

}


