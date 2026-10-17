public class MainFigura {
    public static void main(String[] args) {
        Circulo c = new  Circulo ( " Fiusha ", "circulo", 5.0);
        Rectangulo r = new Rectangulo("Amarillo" ,"rectangulo" ,4.0, 6.0);
        Triangulo t = new Triangulo ("Azul ", "triangulo",3.0, 8.0);

        c.mostrar();
        r.mostrar();
        t.mostrar();

        System.out.println("\n=== Con array polimórfico ===");
        Figura[] figuras = { c, r, t }; 
        for (Figura f : figuras){
            System.out.println("El area del "+ f.nombre + " es: "+  f.calcularArea());
        }
    }

}
