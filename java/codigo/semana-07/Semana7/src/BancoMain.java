public class BancoMain {
    public static void main(String[] args) {
        CuentaBancaria cuentaJess = new CuentaBancaria("Jessica Chino", 500.0, "BMX-001");
        CuentaBancaria cuentaCarlos = new CuentaBancaria("Carlos Escalona", 1000.0, "BMX-002");
        CuentaBancaria cuenaTifon = new CuentaBancaria("Tifon Esc", 2000.0, "BMX-003");

        System.out.println("=== Estado inicial ===");
        cuentaJess.muestraResumen();
        cuentaCarlos.muestraResumen();
        cuenaTifon.muestraResumen();
        
        System.out.println("\n=== Transacciones ===");
        cuentaJess.depositar(200.0);
        cuentaCarlos.retirar(300);
        cuenaTifon.depositar(500);
        cuentaJess.retirar(3000);

        System.out.println("\n=== Estado final ===");
        cuentaJess.muestraResumen();
        cuentaCarlos.muestraResumen();
        cuenaTifon.muestraResumen();

    }

}
