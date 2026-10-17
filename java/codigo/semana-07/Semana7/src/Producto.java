public class Producto {
    //atribitos
    private  String nombre;
    private double precio;
    private String categoria;

    //Constructor
    public Producto(String nombre, double precio,  String categoria) {
        this.nombre = nombre;
        this.precio = precio > 0 ? precio : 0;
        this.categoria = categoria;
    }

    //Getter
    public String getNombre(){
        return nombre;
    }
    public double  getPrecio (){
        return precio;
    }
    public String getCategoria() {
        return categoria;
    }

    //Setter
    public void setPrecio(double  precio){
        if(precio > 0){
            this.precio = precio;
        }
    }
    //poner precio mas iva 
    public double  precioConIva (double  precio){
        return precio * 1.16;
    }

    public  void mostrarInfo() {
        System.out.println("[ " + getCategoria() + " ]" + getNombre() + " - $" + getPrecio() + " precio con IVA " + precioConIva(getPrecio()) );
    }


}


