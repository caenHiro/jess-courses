public class MainPagos {
    public static void main(String[] args) {
        MetodoPago[] metodos = {
        new PagoTarjeta("4444"),
        new PagoEfectivo(666),
        new PagoTransferencia()
    };
    double montoPago = 500.0;
    for( MetodoPago metodo : metodos){
        System.out.println("--- " + metodo.obtenerNombre() + " ---");
        boolean exito = metodo.pagar(montoPago);
        if(exito){
            System.out.println("Pago abrobado");
        }else {
            System.out.println("Pago rechazado");
        }
        System.out.println();       
    }
    
    }
}
