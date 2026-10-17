---
semana: 9
tema: Interfaces y Abstracción
estado: pendiente
---

# Práctica — Semana 9: Interfaces y Abstracción

> Guarda tu código en: `codigo/semana-09/`
> Al terminar: `bash scripts/push.sh "semana-09 interfaces"`

---

## Ejercicio 1 — Sistema de pagos (obligatorio)

Crea una interfaz `MetodoPago` con los métodos:
- `boolean pagar(double cantidad)` — devuelve true si el pago fue exitoso
- `String obtenerNombre()` — nombre del método de pago

Luego implementa 3 clases que usen esta interfaz:
- `PagoTarjeta` — siempre acepta el pago (simula éxito)
- `PagoEfectivo` — recibe cuánto efectivo tiene el cliente, valida si alcanza
- `PagoTransferencia` — siempre acepta el pago pero imprime "Procesando transferencia..."

En `Main.java`, crea un array de `MetodoPago[]` con uno de cada tipo y procesa un pago de $500 con cada uno.

_Tu código:_
```java
public interface  MetodoPago {

    boolean pagar(double cantidad);

    String obtenerNombre();

}

//PagoEfectivo
public class PagoEfectivo implements MetodoPago {

    private double efectivoDisponible;

  

    public PagoEfectivo(double  efectivo) {

        this.efectivoDisponible = efectivo;

    }

    @Override

    public  boolean pagar(double cantidad){

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

        return  "Efectivo";

    }

}

//PagoTarjeta
public class PagoTarjeta implements MetodoPago  {  

        private String numeroTarjeta;

  

        public PagoTarjeta(String numero) {

            this.numeroTarjeta = numero;

        }

        @Override

        public boolean pagar(double cantidad) {

            System.out.println("Tarjeta " + numeroTarjeta +  ": pagando $" + cantidad);

            return true;

        }

  

        @Override

        public String obtenerNombre() {

            return "Tarjeta de crédito/débito";

        }

    }
    
    //PagoTransferencia
    public class PagoTransferencia implements MetodoPago{

  

    @Override

    public boolean pagar(double cantidad) {

        System.out.println(" Prosesando transferencia de: $" + cantidad);

        System.out.println("Transferencia realizada con exito");

        return true;

    }

  

    @Override

    public String obtenerNombre() {

       return  "Transferencia bancaria";

    }

  

}

//MainPagos
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
```

---

## Ejercicio 2 — Clase abstracta Vehículo (obligatorio)

Crea una clase abstracta `Vehiculo` con:
- Atributos: `marca`, `modelo`, `velocidadMaxima`
- Método concreto: `mostrarInfo()` — imprime todos los atributos
- Método abstracto: `calcularConsumo(double km)` — consume X litros por km

Implementa:
- `Auto` — consume 0.08 litros/km
- `Camion` — consume 0.25 litros/km
- `Moto` — consume 0.04 litros/km

_Tu código:_

```java
  
  

public abstract class  Vehiculo {

    protected String marca;

    protected String modelo;

    protected  int velocudadMaxima;

  

    public Vehiculo(String marca, String modelo, int  velocudadMaxima){

        this.marca = marca;

        this.modelo = modelo;

        this.velocudadMaxima = velocudadMaxima;

    }

  

    public void  mostrarInfo(){

        System.out.println( marca  + " " + modelo + " - velocidad maxima: " + velocudadMaxima + "km/h");

    }

    public abstract double calcularConsumo(double  km);

}

//Auto
public class Auto extends Vehiculo{

  

    public Auto(String marca, String modelo) {

        super(marca, modelo, 200);

    }

  

    @Override

    public double calcularConsumo(double km) {

       return km + 0.08;

    }

  

}

//Camion
public class Camion extends Vehiculo{
    public Camion(String marca, String modelo) {

        super(marca, modelo, 120);

    }

  

    @Override

    public double calcularConsumo(double km) {

        return km * 0.25;

    }  

}

//Moto
public class Moto extends  Vehiculo{

  

    public Moto(String marca, String modelo) {

        super(marca, modelo, 180);

    }

  

    @Override

    public double calcularConsumo(double km) {

        return  km * 0.04;

    }

  

}

//MainVehiculos
public class MainVehiculos {

    public static void main(String[] args) {

        Vehiculo auto = new Auto ("Toyota", "Camry");

        Vehiculo camion = new Camion("Kenworth", "T680");

        Vehiculo moto = new  Moto("Daytona", "GT1");

  

        double distancia = 100.0;

        Vehiculo[] flota = { auto, camion, moto };

        for(Vehiculo v : flota){

            v.mostrarInfo();

            double litros = v.calcularConsumo(distancia);

            System.out.println("El consum de su  vehiculo es: " + distancia + litros );

        }

    }

  

}

```

---

## Reflexión

**¿Cuál es la diferencia entre interfaz y clase abstracta?**

_Tu respuesta:_

**¿Por qué no puedes hacer `new MetodoPago()`?**

_Tu respuesta:_

**¿En qué situación usarías una interfaz en lugar de herencia?**

_Tu respuesta:_
