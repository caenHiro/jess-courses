---
semana: 8
tema: Herencia y Polimorfismo
estado: pendiente
---

# Práctica — Semana 8: Herencia y Polimorfismo

> Guarda tu código en: `codigo/semana-08/`
> Al terminar: `bash scripts/push.sh "semana-08 herencia"`

---

## Ejercicio 1 — Zoológico virtual (obligatorio)

Crea los archivos en `codigo/semana-08/`:

**Clase padre `Animal`:**
- Atributos: `nombre`, `especie`
- Constructor con ambos atributos
- Métodos: `comer()`, `dormir()`, `hacerSonido()` (que imprima "...")

**Clases hijo:**
- `Perro` — sobreescribe `hacerSonido()` para imprimir "¡Guau!" y agrega método `buscarPelota()`
- `Gato` — sobreescribe `hacerSonido()` para imprimir "¡Miau!" y agrega método `ronronear()`
- `Pajaro` — sobreescribe `hacerSonido()` para imprimir "¡Pío!" y agrega método `volar()`

**En Main.java:**
- Crea al menos un objeto de cada tipo
- Llama a `hacerSonido()` en todos — demuestra el polimorfismo

_Tu código:_
```java
public class Animal {

    protected String nombre;

    protected String especie;

  

    public Animal( String nombre, String especie) {

        this.nombre = nombre;

        this.especie = especie;

    }

  

    public void comer(){

        System.out.println("El " +  nombre + " esta comiendo.");

    }

    public void dormir() {

        System.out.println("El " +  nombre + " esta durmiendo.");

    }

    public void tomarAgua(){

        System.out.println("El " + nombre + " esta tomando agua.");

    }

    public void hacerSonido() {

        System.out.println( " ...");

    }
}


// pero
public class Perro extends  Animal{

    public Perro (String nombre) {

        super(nombre, "Canino");

    }

    @Override

    public  void hacerSonido() {

        System.out.println("El " + nombre + " hace Guau!");

    }

    public void  buscarPelota() {

        System.out.println( "El " + nombre + " busca la pelota.");

    }

}

// gato
public class  Gato extends Animal {

    public Gato(String nombre) {

        super( nombre,  " Felino");

    }

    @Override

    public void  hacerSonido() {

        System.out.println("El " + nombre + " hace Miau!");

    }

    public void ronronear() {

        System.out.println("El " + nombre + " ronronea");

    }

  

}

//pajaro
public class Pajaro extends Animal {

    public Pajaro(String nombre) {

        super(nombre, "Ave");

    }

    @Override

    public void hacerSonido(){

        System.out.println("El " + nombre + " hace Pio!");

    }

    public void volar(){

        System.out.println("El " + nombre + " vuela.");

    }

  

}

//main

public class Main {

    public static void main(String[] args) {

        Perro perro = new Perro("Tifon");

        Gato gato = new Gato( "Garfiel");

        Pajaro pajaro = new Pajaro("Piolin");

  

        System.out.println("=== Heredados del padre ===");

        perro.comer();

        gato.dormir();

        pajaro.tomarAgua();

  

        System.out.println("\n=== Polimorfismo ===");

        Animal[] animales = {perro , gato , pajaro};

        for (Animal a : animales){

            a.hacerSonido();

        }

  

        System.out.println("\n=== Polimorfismo ===");

        perro.buscarPelota();

        gato.ronronear();

        pajaro.volar();

    }

}


```
---

## Ejercicio 2 — Figuras geométricas (obligatorio)

**Clase padre `Figura`:**
- Atributo: `color` (String)
- Método: `calcularArea()` que devuelva 0.0

**Clases hijo:**
- `Circulo` — atributo `radio`, sobreescribe `calcularArea()` (PI × radio²)
- `Rectangulo` — atributos `base` y `altura`, sobreescribe `calcularArea()`
- `Triangulo` — atributos `base` y `altura`, sobreescribe `calcularArea()` (base × altura / 2)

**En Main.java:**
- Crea una figura de cada tipo
- Imprime el área de cada una

Pista: `Math.PI` es el valor de π en Java.

_Tu código:_


```java
public class Figura {

    protected  String color;

    protected String nombre;

  

    public Figura(String color, String nombre){

        this.color = color;

        this.nombre = nombre;

    }

    public double calcularArea() {

        return 0.0;

    }

    public void mostrar() {

        System.out.println("El  " + nombre + " es color " + color + " y su area es: " + calcularArea() );

    }

}

// circulo
public class Circulo extends Figura {

    private  double radio;

    public  Circulo(String color, String nombre, double  radio) {

        super(color, nombre);

        this.radio = radio;

    }

    @Override

    public  double calcularArea() {

        return  Math.PI * radio * radio;

    }

}

//Rectangulo
public class Rectangulo extends Figura {

    private double base;

    private double altura;

  

    public Rectangulo( String color, String nombre,double base, double altura){

        super(color, nombre);

        this.base = base;

        this.altura = altura;

    }

    @Override

    public double calcularArea (){

        return  base * altura;

    }

  

}

//Triangulo
public class Triangulo extends Figura{

    private double base;

    private double altura;

  

    public Triangulo(  String color,String nombre, double base, double  altura){

        super(color, nombre);

        this.base = base;

        this.altura = altura;

    }

    @Override

    public double  calcularArea() {

        return base * altura / 2;

    }

  

}

//MainFigura
public class MainFigura {

    public static void main(String[] args) {

        Circulo c = new  Circulo ( " Fiusha ", "circulo", 5.0);

        Rectangulo r = new Rectangulo("Amarillo" ,"rectangulo" ,4.0, 6.0);

        Triangulo t = new Triangulo ("Azul ", "triangulo",3.0, 8.0);

  

        c.mostrar();

        r.mostrar();

        t.mostrar();

  

        System.out.println("\n=== Con array polimórfico ===");

        Figura[] figuras = { c, r, t };

        for (Figura f : figuras){

            System.out.println("El area del "+ f.nombre + " es: "+  f.calcularArea());

        }

    }

  

}

```

---

## Reflexión

**¿Cuándo conviene usar herencia?**

_Tu respuesta:_

**¿Qué es polimorfismo? Exprésalo con tus palabras.**

_Tu respuesta:_

**¿Para qué sirve `super(...)` en el constructor hijo?**

_Tu respuesta:_
