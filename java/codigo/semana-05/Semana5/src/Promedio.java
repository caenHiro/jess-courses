public class Promedio {
    public static void main(String[] args) throws Exception {
        double[] calificaciones = {55, 77, 95, 100, 88, 67};
        double sum = 0;

        double max = calificaciones[0];
        double min = calificaciones[0];

        for (double c : calificaciones) {
            sum += c;          

            if (c > max) {
                max = c;        
            }
            if (c < min) {
                min = c;        
            }
        }

        double promedio = sum / calificaciones.length;

        System.out.println("El promedio es: " + promedio);     
        System.out.println("Calificación mas alta: " + max);          
        System.out.println("Calificación mas baja: " + min);

    }

}
