public class PagoEfectivo implements MetodoPago {
    private double efectivoDisponible;

    public PagoEfectivo(double  efectivo) {
        this.efectivoDisponible = efectivo;
    }
    @Override
    public  boolean pagar(double cantidad){
        if(efectivoDisponible >= cantidad) {
            double cambio = efectivoDisponible - cantidad;
            efectivoDisponible -= cantidad;

            System.out.println("Pago en efectivo: $" + cantidad);
            System.out.println("Cambio: $ " + cambio);
            return true;
        } else{
            System.out.println("Efectivo insuficiente. Usted tiene: $" + efectivoDisponible + "usted necesita: $" + cantidad);
            return false;
        }
    }
    @Override
    public String obtenerNombre(){
        return  "Efectivo";
    }
}
