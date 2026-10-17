public class PagoTarjeta implements MetodoPago  {  
        private String numeroTarjeta; 

        public PagoTarjeta(String numero) {
            this.numeroTarjeta = numero;
        } 
        @Override
        public boolean pagar(double cantidad) {
            System.out.println("Tarjeta " + numeroTarjeta +  ": pagando $" + cantidad);
            return true;
        }

        @Override
        public String obtenerNombre() {
            return "Tarjeta de crédito/débito";
        }
       
    }

