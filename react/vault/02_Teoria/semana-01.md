---
semana: 1
tema: JavaScript fundamentos — variables, funciones, arrays, objetos
estado: pendiente
---

# Semana 1 — JavaScript fundamentos

> Tiempo estimado: 4–6 horas
> Al terminar: `bash scripts/push.sh "semana-01 js fundamentos"`

---

## Objetivo de la semana

Al terminar debes poder:
- Declarar variables con `let` y `const`
- Escribir funciones normales y funciones flecha
- Trabajar con arrays (recorrer, filtrar, transformar)
- Crear y acceder a objetos
- Entender por que JavaScript es diferente a Java (y por que no es malo)

---

## Analogia clave

> "En Java eres chef con uniforme obligatorio, recetas exactas y supervisor revisando cada paso.
> En JavaScript eres chef en casa: mismo resultado, menos burocracia, pero mas responsabilidad tuya."

JavaScript no te obliga a declarar el tipo de cada variable. Eso se siente raro al principio viniendo de Java, pero es exactamente para lo que existe TypeScript (semana 5).

---

## 1. Variables — let y const

En Java:
```java
int edad = 25;
String nombre = "Jess";
final double PI = 3.14;
```

En JavaScript:
```javascript
let edad = 25;          // puede cambiar
const nombre = "Jess";  // NO puede cambiar (como final en Java)
const PI = 3.14;
```

**Regla practica:** usa `const` para todo. Solo usa `let` cuando necesites reasignar el valor.
Nunca uses `var` (es el `var` viejo de JavaScript, tiene comportamientos raros).

```javascript
const precio = 100;
precio = 200;  // ERROR — no puedes reasignar una const

let contador = 0;
contador = 1;  // OK — let si permite reasignar
```

### Tipos de datos

```javascript
const numero = 42;              // number (no hay int, double, float — todo es number)
const decimal = 3.14;           // tambien number
const texto = "Hola";           // string
const activo = true;            // boolean
const nada = null;              // null (ausencia intencional de valor)
const noDefinido = undefined;   // undefined (no se le asigno nada)
```

---

## 2. Funciones

### Funcion normal (como en Java pero sin tipo de retorno)

Java:
```java
public String saludar(String nombre) {
    return "Hola " + nombre;
}
```

JavaScript:
```javascript
function saludar(nombre) {
    return "Hola " + nombre;
}

saludar("Jess");  // "Hola Jess"
```

### Template literals (como f-strings de Python, mejor que concatenar)

```javascript
const nombre = "Jess";
const edad = 25;

// Forma vieja (concatenar — como Java)
console.log("Hola " + nombre + ", tienes " + edad + " años");

// Forma moderna con template literals (usa backtick ` no comilla)
console.log(`Hola ${nombre}, tienes ${edad} años`);
```

### Funciones flecha (arrow functions) — las vas a ver TODO el tiempo en React

```javascript
// Funcion normal
function sumar(a, b) {
    return a + b;
}

// Misma funcion como arrow function
const sumar = (a, b) => {
    return a + b;
};

// Si el cuerpo es solo un return, puedes quitar las llaves y el return
const sumar = (a, b) => a + b;

// Si tiene un solo parametro, puedes quitar los parentesis
const doble = n => n * 2;
```

> Las arrow functions son la forma que React usa para TODO. Aprenderlas bien aqui te ahorra confusion despues.

---

## 3. Arrays

En Java un array tiene tamano fijo y un tipo. En JavaScript los arrays son flexibles.

```javascript
const frutas = ["manzana", "pera", "uva"];

// Acceder por indice (igual que Java)
console.log(frutas[0]);  // "manzana"
console.log(frutas.length);  // 3

// Agregar al final
frutas.push("kiwi");  // ["manzana", "pera", "uva", "kiwi"]

// Recorrer con forEach
frutas.forEach(fruta => {
    console.log(fruta);
});

// map — transforma cada elemento y devuelve un array nuevo
const mayusculas = frutas.map(fruta => fruta.toUpperCase());
// ["MANZANA", "PERA", "UVA", "KIWI"]

// filter — filtra elementos segun una condicion
const numeros = [1, 2, 3, 4, 5, 6];
const pares = numeros.filter(n => n % 2 === 0);
// [2, 4, 6]

// find — devuelve el PRIMER elemento que cumple la condicion
const primero = numeros.find(n => n > 3);
// 4
```

> `map`, `filter` y `find` son los tres que mas vas a usar en React para mostrar listas de datos.

---

## 4. Objetos

En Java usas clases para agrupar datos. En JavaScript tienes objetos literales (sin clase necesaria).

```javascript
// Objeto literal
const usuario = {
    nombre: "Jess",
    edad: 25,
    activo: true,
    email: "jess@ine.mx"
};

// Acceder a propiedades
console.log(usuario.nombre);        // "Jess"
console.log(usuario["email"]);      // "jess@ine.mx" (otra forma)

// Modificar una propiedad
usuario.edad = 26;

// Agregar una propiedad nueva
usuario.ciudad = "CDMX";

// Array de objetos (esto es lo que viene de las APIs)
const empleados = [
    { id: 1, nombre: "Ana", puesto: "Frontend" },
    { id: 2, nombre: "Luis", puesto: "Backend" },
    { id: 3, nombre: "Jess", puesto: "Frontend" }
];

// Filtrar todos los de Frontend
const frontenders = empleados.filter(emp => emp.puesto === "Frontend");
// [{ id: 1, nombre: "Ana", puesto: "Frontend" }, { id: 3, nombre: "Jess", puesto: "Frontend" }]
```

---

## 5. Condicionales y comparaciones

```javascript
const edad = 20;

// if/else — igual que Java
if (edad >= 18) {
    console.log("Mayor de edad");
} else {
    console.log("Menor de edad");
}

// IMPORTANTE: usa === (triple igual) para comparar, no == (doble)
// == hace conversiones raras de tipo
// === compara valor Y tipo (es el correcto)

console.log(1 == "1");   // true  (JavaScript convierte el string a number)
console.log(1 === "1");  // false (uno es number, el otro string — son diferentes)
```

---

## Resumen: Java vs JavaScript

| Concepto | Java | JavaScript |
|----------|------|------------|
| Variable | `int x = 5;` | `let x = 5;` |
| Constante | `final int X = 5;` | `const X = 5;` |
| Funcion | `public int sumar(int a, int b)` | `const sumar = (a, b) => a + b` |
| Imprimir | `System.out.println()` | `console.log()` |
| String con variable | `"Hola " + nombre` | `` `Hola ${nombre}` `` |
| Array dinamico | `ArrayList<String>` | `const arr = []` |
| Comparar | `==` | `===` |
| Objeto sin clase | No existe | `{ nombre: "Jess" }` |

---

Cuando termines de leer, ve a: `vault/03_Practicas/semana-01.md`
