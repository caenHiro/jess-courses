---
semana: 5
tema: TypeScript — tipos, interfaces y generics
estado: pendiente
---

# Semana 5 — TypeScript

> Tiempo estimado: 5–6 horas
> Al terminar: `bash scripts/push.sh "semana-05 typescript"`

---

## Objetivo

Al terminar debes poder:
- Entender qué agrega TypeScript sobre JavaScript
- Tipar variables, funciones y objetos
- Crear interfaces y tipos
- Usar generics básicos
- Configurar y compilar TypeScript

---

## 1. Qué es TypeScript y por qué existe

JavaScript no tiene tipos en tiempo de compilación — los errores de tipo aparecen cuando ya se ejecuta el código (a veces en producción). TypeScript agrega un sistema de tipos encima de JavaScript.

```javascript
// JavaScript — esto no da error hasta que corre
function sumar(a, b) {
    return a + b;
}
sumar("5", 3);  // "53" — concatena en lugar de sumar, sin aviso
```

```typescript
// TypeScript — el error aparece antes de correr
function sumar(a: number, b: number): number {
    return a + b;
}
sumar("5", 3);  // ERROR en el editor: Argument of type 'string' is not assignable to parameter of type 'number'
```

Analogía Java: TypeScript es JavaScript con el sistema de tipos de Java. Vienes de Java, así que esto te va a resultar familiar.

---

## 2. Instalación y configuración

```bash
# Instalar TypeScript globalmente
npm install -g typescript

# Verificar
tsc --version

# En un proyecto nuevo
mkdir mi-proyecto && cd mi-proyecto
npm init -y
npm install -D typescript
npx tsc --init   # crea tsconfig.json
```

**tsconfig.json** mínimo:
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "strict": true,
    "outDir": "./dist",
    "rootDir": "./src"
  }
}
```

Compilar:
```bash
tsc          # compila todo
tsc --watch  # recompila al guardar
node dist/index.js  # corre el JS compilado
```

---

## 3. Tipos básicos

```typescript
// Primitivos
let nombre: string = "Jess";
let edad: number = 25;
let activo: boolean = true;

// Arrays
let frutas: string[] = ["manzana", "pera"];
let numeros: number[] = [1, 2, 3];
let mixto: (string | number)[] = ["hola", 42];

// Tuplas — array de tamaño y tipos fijos
let coordenada: [number, number] = [10, 20];
let persona: [string, number] = ["Jess", 25];

// any — deshabilita el tipado (EVITAR, solo para casos excepcionales)
let cualquierCosa: any = "texto";
cualquierCosa = 42;  // no da error

// unknown — como any pero más seguro
let dato: unknown = "texto";
if (typeof dato === "string") {
    console.log(dato.toUpperCase());  // aquí ya sabe que es string
}

// void — función que no devuelve nada
function imprimir(texto: string): void {
    console.log(texto);
}

// null y undefined
let vacio: null = null;
let noAsignado: undefined = undefined;

// Union types — puede ser uno u otro
let id: string | number = "abc-123";
id = 42;  // también válido
```

---

## 4. Funciones tipadas

```typescript
// Parámetros y retorno tipados
function sumar(a: number, b: number): number {
    return a + b;
}

// Parámetros opcionales
function saludar(nombre: string, titulo?: string): string {
    return titulo ? `${titulo} ${nombre}` : nombre;
}
saludar("Jess");           // "Jess"
saludar("Jess", "Lic.");   // "Lic. Jess"

// Parámetros con valor por defecto
function crear(nombre: string, activo: boolean = true) {
    return { nombre, activo };
}

// Arrow function tipada
const multiplicar = (a: number, b: number): number => a * b;

// Tipo de una función
type Operacion = (a: number, b: number) => number;
const dividir: Operacion = (a, b) => a / b;
```

---

## 5. Interfaces

Las interfaces definen la forma de un objeto. Es el equivalente a una clase POJO/DTO en Java.

```typescript
interface Usuario {
    id: number;
    nombre: string;
    email: string;
    activo: boolean;
    rol?: string;  // opcional
}

// Usar la interfaz
const usuario: Usuario = {
    id: 1,
    nombre: "Jess",
    email: "jess@ine.mx",
    activo: true
};

// Función que recibe un Usuario
function mostrarUsuario(u: Usuario): string {
    return `${u.nombre} (${u.email}) — ${u.activo ? "activo" : "inactivo"}`;
}

// Extender interfaces (como herencia en Java)
interface Empleado extends Usuario {
    puesto: string;
    departamento: string;
    salario: number;
}

const empleado: Empleado = {
    id: 1,
    nombre: "Jess",
    email: "jess@ine.mx",
    activo: true,
    puesto: "Frontend Developer",
    departamento: "Informatica",
    salario: 25000
};
```

---

## 6. Type aliases

```typescript
// type — similar a interface pero más flexible
type ID = string | number;
type Coordenadas = [number, number];

// Tipos de unión con nombre
type EstadoTarea = "pendiente" | "en_progreso" | "completada";
let estado: EstadoTarea = "pendiente";
estado = "completada";
estado = "eliminada";  // ERROR — no es un valor válido

// Intersection types — combinar tipos
type PersonaBase = { nombre: string; edad: number };
type Empleado = PersonaBase & { puesto: string; salario: number };
```

---

## 7. Generics

Los generics permiten escribir código que funciona con cualquier tipo, manteniendo el tipado. Como `List<T>` en Java.

```typescript
// Sin generics — tienes que repetir para cada tipo
function primeroString(arr: string[]): string { return arr[0]; }
function primeroNumber(arr: number[]): number { return arr[0]; }

// Con generics — una sola función para cualquier tipo
function primero<T>(arr: T[]): T {
    return arr[0];
}

primero<string>(["a", "b", "c"]);  // "a"
primero<number>([1, 2, 3]);         // 1
primero([true, false]);             // TypeScript infiere T = boolean

// Interfaz genérica — muy común para respuestas de APIs
interface RespuestaAPI<T> {
    data: T;
    mensaje: string;
    exito: boolean;
}

interface Usuario { nombre: string; email: string; }

const respuesta: RespuestaAPI<Usuario[]> = {
    data: [{ nombre: "Jess", email: "jess@ine.mx" }],
    mensaje: "OK",
    exito: true
};
```

---

## 8. TypeScript con DOM

```typescript
// querySelector devuelve Element | null — hay que verificar o asegurarse del tipo
const boton = document.querySelector("#mi-boton");
boton.addEventListener("click", () => {});  // ERROR: boton puede ser null

// Opción 1: verificar
if (boton) {
    boton.addEventListener("click", () => {});
}

// Opción 2: type assertion (afirmas que sabes el tipo)
const boton = document.querySelector("#mi-boton") as HTMLButtonElement;
const input  = document.querySelector("#nombre")  as HTMLInputElement;
console.log(input.value);  // TypeScript sabe que tiene .value
```

---

## Resumen rápido

| JavaScript | TypeScript equivalente |
|------------|----------------------|
| `let x = 5` | `let x: number = 5` |
| `function f(a, b)` | `function f(a: number, b: string): void` |
| Objeto sin forma definida | `interface Persona { nombre: string }` |
| `"pendiente"` o `"activo"` | `type Estado = "pendiente" \| "activo"` |
| `List<T>` de Java | `Array<T>` o `T[]` |
| Generics de Java | Generics TS: `function f<T>(x: T): T` |

---

Cuando termines: `vault/03_Practicas/semana-05.md`
