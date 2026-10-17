public class Main {
     public static void main(String[] args) throws Exception {
        Persona jess = new Persona( "Jess", 35, "Ciudad de Mexico");
        Persona carlos = new Persona( "Carlos", 34, "Ciudad de Mexico");

        jess.saluda();
        carlos.saluda();

        System.out.println(jess.getNombre() + " tiene " + jess.getEdad() + " años");

        if (jess.mayorDeEdad()) {
            System.out.println(jess.getNombre() + " es mayor de edad. ");
        }
    }
}
