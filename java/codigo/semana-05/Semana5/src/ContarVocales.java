public class ContarVocales {
    public static void main(String[] args) throws Exception {
        String nombre = "Jessica Yadziry Chino Colin";
        int contador = 0;
        for (int i = 0 ; i < nombre.length(); i++ ) {
            if (nombre.charAt(i) == 'a' || nombre.charAt(i) == 'e' || nombre.charAt(i) == 'i' || nombre.charAt(i) == 'o' || nombre.charAt(i) == 'u'){
                contador++;
            }
}
    System.out.println(nombre + " tiene " + contador + " vocales");  
    }
}
