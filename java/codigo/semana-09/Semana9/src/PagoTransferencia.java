public class PagoTransferencia implements MetodoPago{

    @Override
    public boolean pagar(double cantidad) {
        System.out.println(" Prosesando transferencia de: $" + cantidad);
        System.out.println("Transferencia realizada con exito");
        return true;
    }

    @Override
    public String obtenerNombre() {
       return  "Transferencia bancaria";
    }

}
