public class NumeroPrimo {
    // numeros primos 
    //2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97
    public static boolean esPrimo( int numero) {
        if(numero < 2){
            return false;
        }

        for ( int n = 2; n <= Math.sqrt(numero); n++){
                if (numero % n == 0) {
                    return false;
                }
            }

            return true;
    }

    public static void main(String[] args) {
        int contador = 0;
        System.err.println("Los numeros primos del 1 al 50 son:  " );
        

        for (int n = 1; n <= 50 ; n++) {
            if (esPrimo(n)){
                contador++;
                 System.out.println(n + ", ");
            }
        }

        System.err.println("Los numeros primos que contiene del 1 al 50 son: " + contador);
    } 
            

}
