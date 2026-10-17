public class Main2 {
    public static void main(String[] args) {
        
        Producto s = new Producto( " Frijol" , 56 , "Semillas" );
        Producto v = new Producto( " Lechuga" , 22, "Verdura" );
        Producto a = new Producto( " Boing" , 50 , "Bebida" );

        //Mostrar los productos
        System.out.println("=== Productos del tianguis ===");
        s.mostrarInfo();
        v.mostrarInfo();
        a.mostrarInfo();

        //Set es para modificar un valor 
        v.setPrecio(33);
        System.out.println("Precio actualizado: ");
        v.mostrarInfo();

        a.setPrecio(-22);
        System.err.println("Precio actualizado:");
        a.mostrarInfo();
    }

}
