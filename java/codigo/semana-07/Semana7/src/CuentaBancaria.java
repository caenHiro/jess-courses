public class CuentaBancaria {
//Atributos
    private String titular;
    private double  saldo;
    private  String numeroCuenta;

    public CuentaBancaria(String titular, double  saldoInicial, String numeroCuenta ){
        this.titular = titular;
        this.saldo = saldoInicial >= 0 ? saldoInicial : 0 ;
        this.numeroCuenta = numeroCuenta;
    }
    //Métodos: `depositar(double)`, `retirar(double)`, `getSaldo()`, `mostrarResumen()`

    public void depositar(double cantidad){
        if(cantidad > 0) {
            saldo += cantidad;
            System.out.println("Ustede " + titular + " deposito: $" + cantidad + " Su saldo actual es: $" + saldo);
        }

    }
    public void retirar(double cantidad){
        if (cantidad > saldo) {
            System.out.println( titular +" su saldo es insuficiente, su saldo es: $ " + saldo);
        } else {
            saldo -= cantidad;
            System.err.println("Ustede " + titular +" retiro: $" + cantidad + " Su alsdo actual es de: $" + saldo);
        }
    }

    public double getSaldo(){
        return saldo;
    }
    public void muestraResumen(){
        System.out.println("Cuenta: " + numeroCuenta + 
                            " | Titular: " + titular + 
                            " | Saldo: " + saldo);
    }
}

