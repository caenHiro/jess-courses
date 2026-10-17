---
semana: 2
tema: JavaScript moderno — ES6+, destructuring, spread, modulos
estado: pendiente
---

# Semana 2 — JavaScript moderno (ES6+)

> Tiempo estimado: 4–5 horas
> Al terminar: `bash scripts/push.sh "semana-02 js moderno"`

---

## Objetivo de la semana

Al terminar debes poder:
- Usar destructuring para extraer valores de objetos y arrays
- Usar el operador spread (`...`) para copiar y combinar datos
- Entender los modulos de JavaScript (`import` / `export`)
- Escribir codigo mas limpio y conciso con las herramientas modernas de JS

> Esta semana es clave porque React usa TODOS estos patrones constantemente.
> Si no los dominas aqui, React va a parecer magico de la mala manera.

---

## 1. Destructuring de objetos

Es sacar propiedades de un objeto y ponerlas en variables, en una sola linea.

Sin destructuring (forma vieja):
```javascript
const usuario = { nombre: "Jess", edad: 25, ciudad: "CDMX" };

const nombre = usuario.nombre;
const edad = usuario.edad;
const ciudad = usuario.ciudad;
```

Con destructuring:
```javascript
const usuario = { nombre: "Jess", edad: 25, ciudad: "CDMX" };

const { nombre, edad, ciudad } = usuario;

console.log(nombre);  // "Jess"
console.log(edad);    // 25
```

### Renombrar al desestructurar

```javascript
const { nombre: nombreCompleto, edad: anos } = usuario;
console.log(nombreCompleto);  // "Jess"
console.log(anos);            // 25
```

### Valores por defecto

```javascript
const { nombre, rol = "usuario" } = usuario;
// Si 'rol' no existe en el objeto, usa "usuario" como valor por defecto
```

### En parametros de funciones (esto lo ves TODO el tiempo en React)

```javascript
// Sin destructuring
function saludar(usuario) {
    return `Hola ${usuario.nombre}, tienes ${usuario.edad} años`;
}

// Con destructuring en el parametro
function saludar({ nombre, edad }) {
    return `Hola ${nombre}, tienes ${edad} años`;
}

saludar(usuario);  // "Hola Jess, tienes 25 años"
```

---

## 2. Destructuring de arrays

```javascript
const colores = ["rojo", "verde", "azul"];

// Sin destructuring
const primero = colores[0];
const segundo = colores[1];

// Con destructuring
const [primero, segundo, tercero] = colores;
console.log(primero);  // "rojo"
console.log(segundo);  // "verde"

// Saltar elementos
const [, , ultimoColor] = colores;
console.log(ultimoColor);  // "azul"
```

> Vas a ver esto exactamente al usar `useState` en React:
> ```javascript
> const [contador, setContador] = useState(0);
> ```
> Eso es destructuring de array. El primer elemento es el valor, el segundo es la funcion para cambiarlo.

---

## 3. Operador Spread (`...`)

### Copiar arrays

```javascript
const frutas = ["manzana", "pera"];
const copia = [...frutas];  // copia real, no referencia

copia.push("uva");
console.log(frutas);  // ["manzana", "pera"] — no se modifico
console.log(copia);   // ["manzana", "pera", "uva"]
```

### Combinar arrays

```javascript
const verduras = ["zanahoria", "brocoli"];
const frutas = ["manzana", "pera"];

const todo = [...frutas, ...verduras];
// ["manzana", "pera", "zanahoria", "brocoli"]

// Agregar elementos al combinar
const conExtra = ["kiwi", ...frutas, "melon"];
// ["kiwi", "manzana", "pera", "melon"]
```

### Copiar objetos (muy usado en React para actualizar estado)

```javascript
const usuario = { nombre: "Jess", edad: 25, ciudad: "CDMX" };

// Copia del objeto
const copia = { ...usuario };

// Copia modificando una propiedad (sin mutar el original)
const actualizado = { ...usuario, edad: 26 };
// { nombre: "Jess", edad: 26, ciudad: "CDMX" }

console.log(usuario.edad);     // 25 — no cambio
console.log(actualizado.edad); // 26
```

> En React NUNCA modificas el estado directamente. Siempre creas una copia con cambios.
> El spread `...` es la herramienta para eso.

---

## 4. Parametros rest (`...` en funciones)

El mismo `...` pero en el otro sentido: agrupa multiples argumentos en un array.

```javascript
function sumarTodos(...numeros) {
    return numeros.reduce((total, n) => total + n, 0);
}

sumarTodos(1, 2, 3);        // 6
sumarTodos(10, 20, 30, 40); // 100
```

---

## 5. Optional chaining (`?.`)

Accede a propiedades anidadas sin romperse si algo es null o undefined.

```javascript
const usuario = {
    nombre: "Jess",
    direccion: {
        ciudad: "CDMX",
        colonia: "Del Valle"
    }
};

// Sin optional chaining — se rompe si direccion es null
console.log(usuario.direccion.ciudad);     // "CDMX"
console.log(usuario.trabajo.empresa);      // ERROR: Cannot read properties of undefined

// Con optional chaining — devuelve undefined en lugar de romperse
console.log(usuario.trabajo?.empresa);     // undefined (sin error)
console.log(usuario.direccion?.ciudad);    // "CDMX"
```

---

## 6. Nullish coalescing (`??`)

Valor por defecto, pero SOLO cuando el valor es `null` o `undefined` (no cuando es `0` o `""`)

```javascript
const nombre = null;
const resultado = nombre ?? "Anonimo";
console.log(resultado);  // "Anonimo"

const cantidad = 0;
const con_OR = cantidad || 10;    // 10 (0 es falsy, || lo reemplaza)
const con_NC = cantidad ?? 10;    // 0  (?? solo reemplaza null/undefined)
```

---

## 7. Modulos — import y export

JavaScript moderno divide el codigo en archivos (modulos). Cada archivo puede exportar funciones u objetos y otros archivos los importan.

**archivo: `calculadora.js`**
```javascript
// Export nombrado — puedes exportar varias cosas
export function sumar(a, b) {
    return a + b;
}

export function restar(a, b) {
    return a - b;
}

export const VERSION = "1.0";
```

**archivo: `main.js`**
```javascript
// Import nombrado — importas exactamente lo que necesitas
import { sumar, restar } from "./calculadora.js";

console.log(sumar(5, 3));  // 8
```

**Export default** — cuando el archivo exporta una sola cosa principal:
```javascript
// usuario.js
export default function crearUsuario(nombre) {
    return { nombre, activo: true };
}

// main.js — el default se importa sin llaves
import crearUsuario from "./usuario.js";
```

> En React cada componente es un modulo. Vas a escribir `export default` y `import` todo el tiempo.

---

## Resumen: los 5 patrones que mas vas a usar en React

```javascript
// 1. Destructuring en props de componentes
function Tarjeta({ nombre, edad, activo }) { ... }

// 2. Spread para actualizar estado sin mutar
setUsuario({ ...usuario, edad: 26 });

// 3. map para renderizar listas
empleados.map(emp => <div key={emp.id}>{emp.nombre}</div>)

// 4. Optional chaining para datos que pueden faltar
usuario?.direccion?.ciudad

// 5. Nullish coalescing para valores por defecto
const nombre = datos?.nombre ?? "Anonimo"
```

---

Cuando termines: `vault/03_Practicas/semana-02.md`
