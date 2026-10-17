

public abstract class  Vehiculo {
    protected String marca;
    protected String modelo;
    protected  int velocudadMaxima;

    public Vehiculo(String marca, String modelo, int  velocudadMaxima){
        this.marca = marca;
        this.modelo = modelo;
        this.velocudadMaxima = velocudadMaxima;
    }

    public void  mostrarInfo(){
        System.out.println( marca  + " " + modelo + " - velocidad maxima: " + velocudadMaxima + "km/h");
    }
    public abstract double calcularConsumo(double  km);
}
