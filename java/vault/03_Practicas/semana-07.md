---
semana: 7
tema: Clases y Objetos
estado: pendiente
---

# Práctica — Semana 7: Clases y Objetos

> Guarda tu código en: `codigo/semana-07/`
> Al terminar: `bash scripts/push.sh "semana-07 clases"`

---

## Ejercicio 1 — Clase Persona (obligatorio)

Archivos: `codigo/semana-07/Persona.java` y `Main.java`

Crea la clase `Persona` con:
- Atributos: `nombre` (String), `edad` (int), `ciudad` (String)
- Constructor que reciba los 3 atributos
- Método `saludar()` que imprima "Hola, soy [nombre], tengo [edad] años y vivo en [ciudad]"
- Método `esMayorDeEdad()` que devuelva `true` si la edad es >= 18

En `Main.java`, crea al menos 2 objetos Persona y prueba todos los métodos.

_Tu código:_

```java
public class Persona {
    //atribitos
    private String nombre;
    private int  edad;
    private String ciudad;
    //Constructor
    public Persona (String nombre, int  edad,  String ciudad) {
        this.nombre = nombre;
        this.edad = edad;
        this.ciudad = ciudad;
    }
    public void saluda () {
        System.out.println("Hola mi nombre es " + nombre + " , tengo " + edad + " años y vivo en " + ciudad);
    }
    public boolean mayorDeEdad () {
        return edad >= 18;
    }
    public String getNombre() {
        return nombre;
    }
    public int getEdad() {
        return edad;
    }
    public String getCiudad(){
        return ciudad;
    }
}



public class Main {

     public static void main(String[] args) throws Exception {

        Persona jess = new Persona( "Jess", 35, "Ciudad de Mexico");

        Persona carlos = new Persona( "Carlos", 34, "Ciudad de Mexico");

  

        jess.saluda();

        carlos.saluda();

  

        System.out.println(jess.getNombre() + " tiene " + jess.getEdad() + " años");

  

        if (jess.mayorDeEdad()) {

            System.out.println(jess.getNombre() + " es mayor de edad. ");

        }

    }

}

```

---

## Ejercicio 2 — Clase Producto con IVA (obligatorio)

Archivos: `codigo/semana-07/Producto.java` y `Main2.java`

Crea la clase `Producto` con:
- Atributos privados: `nombre`, `precio` (double), `categoria`
- Constructor con los 3 atributos
- Getters para todos los atributos
- Setter para `precio` (validar que sea mayor que 0)
- Método `calcularPrecioConIVA()` que devuelva el precio × 1.16
- Método `mostrarInfo()` que imprima toda la información del producto

_Tu código:_
```java
public class Producto {

    //atribitos

    private  String nombre;

    private double precio;

    private String categoria;

  

    //Constructor

    public Producto(String nombre, double precio,  String categoria) {

        this.nombre = nombre;

        this.precio = precio > 0 ? precio : 0;

        this.categoria = categoria;

    }

  

    //Getter

    public String getNombre(){

        return nombre;

    }

    public double  getPrecio (){

        return precio;

    }

    public String getCategoria() {

        return categoria;

    }

  

    //Setter

    public void setPrecio(double  precio){

        if(precio > 0){

            this.precio = precio;

        }

    }

    //poner precio mas iva

    public double  precioConIva (double  precio){

        return precio * 1.16;

    }

  

    public  void mostrarInfo() {

        System.out.println("[ " + getCategoria() + " ]" + getNombre() + " - $" + getPrecio() + " precio con IVA " + precioConIva(getPrecio()) );

    }
}




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

```
---

## Ejercicio 3 — Cuenta bancaria (reto)

Archivo: `codigo/semana-07/CuentaBancaria.java` y `BancoMain.java`

Crea la clase `CuentaBancaria` con:
- Atributos privados: `titular` (String), `saldo` (double), `numeroCuenta` (String)
- Métodos: `depositar(double)`, `retirar(double)`, `getSaldo()`, `mostrarResumen()`
- `retirar` debe validar que hay suficiente saldo

Crea 2 cuentas en `BancoMain.java` y simula algunas transacciones.

_Tu código:_
```java
public class CuentaBancaria {

//Atributos

    private String titular;

    private double  saldo;

    private  String numeroCuenta;

  

    public CuentaBancaria(String titular, double  saldoInicial, String numeroCuenta ){

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

```
---

## Retroalimentacion — Semana 7

### Lo que hiciste bien ✅

- Constructor correcto con `this` en ambas clases — exactamente como se pide
- Validacion en el constructor de Producto (`precio > 0 ? precio : 0`) — muy bien
- Setter con validacion en `setPrecio` — perfecto
- Los objetos se crean correctamente con `new` en Main y Main2
- Los atributos son `private` en ambas clases — bien

### Lo que hay que corregir ⚠️

**1. Cada clase en su propio archivo**

En tus practicas pegaste `Persona` y `Main` en el mismo bloque de codigo. En Java cada clase publica va en su propio archivo `.java`. Java no compila si hay dos clases `public` en el mismo archivo.

```
Persona.java  <- solo contiene: public class Persona { ... }
Main.java     <- solo contiene: public class Main { ... }
```

En tu carpeta `codigo/semana-07/Semana7/src/` ya lo tienes correcto (archivos separados). En las notas de practica, cuando copies el codigo, muestra cada clase con su nombre de archivo encima.

**2. Nombres de metodos — la firma importa**

Se pidio `saludar()` pero escribiste `saluda()`. Se pidio `esMayorDeEdad()` pero escribiste `mayorDeEdad()`. En Java el nombre del metodo es parte del contrato — si el ejercicio pide `saludar()` y escribes `saluda()`, son dos metodos distintos. Revisa siempre el nombre exacto que se pide.

**3. Getters dentro de la propia clase — no son necesarios**

En tu `mostrarInfo()` de Producto usaste `getCategoria()`, `getNombre()`, `getPrecio()` desde dentro de la clase:

```java
// Tu version — funciona pero es innecesario
public void mostrarInfo() {
    System.out.println("[ " + getCategoria() + " ]" + getNombre() + " - $" + getPrecio() + "...");
}
```

**Regla de oro:** los getters son para que OTRA clase lea tus datos. Dentro de tu propia clase tienes acceso directo a los atributos `private`:

```java
// Version correcta — dentro de Producto.java accedes directo
public void mostrarInfo() {
    System.out.println("[" + categoria + "] " + nombre + " - $" + precio + "...");
}
```

**4. Firma de metodo — `precioConIva` no necesita parametro**

Definiste `precioConIva(double precio)` recibiendo precio desde afuera. Pero `precio` ya es un atributo del objeto — no necesitas que te lo manden:

```java
// Tu version — recibe precio como parametro (el objeto ya lo tiene)
public double precioConIva(double precio) {
    return precio * 1.16;
}
// Al llamarlo tienes que hacer: precioConIva(getPrecio()) <- redundante

// Version correcta — usa el atributo directamente
public double calcularPrecioConIVA() {
    return precio * 1.16;   // precio = el atributo del objeto
}
// Al llamarlo basta con: calcularPrecioConIVA() <- limpio
```

### Ejercicio 3 — Pendiente

`CuentaBancaria.java` esta vacia. Cuando puedas, implementa:
- Atributos privados: `titular`, `saldo`, `numeroCuenta`
- Constructor que valide que el saldo inicial no sea negativo
- `depositar(double cantidad)` — solo si cantidad > 0
- `retirar(double cantidad)` — solo si hay suficiente saldo
- `getSaldo()` — getter del saldo
- `mostrarResumen()` — imprime los datos de la cuenta

En `BancoMain.java` crea 2 cuentas y prueba depositar, retirar (con y sin fondos suficientes).

---

## Reflexión

**¿Cuál es la diferencia entre una clase y un objeto?**

_Tu respuesta:_

**¿Para qué sirve el constructor?**

_Tu respuesta:_

**¿Por qué hacemos los atributos `private`?**

_Tu respuesta:_

**¿Cuál fue el ejercicio más difícil y por qué?**

_Tu respuesta:_
