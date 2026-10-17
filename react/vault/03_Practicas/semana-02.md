---
semana: 2
tema: JavaScript moderno — ES6+
estado: pendiente
---

# Practica — Semana 2: JavaScript moderno

> Guarda tu codigo en: `codigo/semana-02/`
> Corre cada archivo con: `node codigo/semana-02/ejercicioX.js`
> Al terminar: `bash scripts/push.sh "semana-02 practicas"`

---

## Ejercicio 1 — Destructuring de empleados (obligatorio)

Crea `ejercicio1.js`.

Tienes este objeto:
```javascript
const empleado = {
    nombre: "Jessica Lopez",
    puesto: "Desarrolladora Frontend",
    departamento: "Informatica",
    salario: 25000,
    contacto: {
        email: "jess@ine.mx",
        telefono: "55-1234-5678"
    }
};
```

1. Usa destructuring para obtener `nombre`, `puesto` y `salario` en variables separadas
2. Usa destructuring anidado para obtener el `email` directamente
3. Escribe una funcion `mostrarTarjeta({ nombre, puesto, departamento, contacto: { email } })` que imprima:
   ```
   === Tarjeta de empleado ===
   Jessica Lopez — Desarrolladora Frontend
   Departamento: Informatica
   Email: jess@ine.mx
   ```
4. Llama la funcion pasando el objeto `empleado`

**Tu solucion:**

---

## Ejercicio 2 — Spread y objetos inmutables (obligatorio)

Crea `ejercicio2.js`.

Tienes este sistema de usuarios:
```javascript
const usuarios = [
    { id: 1, nombre: "Ana", activo: true, rol: "admin" },
    { id: 2, nombre: "Luis", activo: false, rol: "usuario" },
    { id: 3, nombre: "Jess", activo: true, rol: "usuario" }
];
```

Sin modificar el array original, usando spread:
1. Crea un nuevo array con un usuario nuevo agregado al final: `{ id: 4, nombre: "Carlos", activo: true, rol: "admin" }`
2. Crea un nuevo array donde el usuario con id 2 tiene `activo: true` (los demas igual)
3. Imprime el array original para confirmar que no cambio
4. Imprime el array modificado

Pista para el punto 2: usa `map` y spread dentro del map.

**Tu solucion:**

---

## Ejercicio 3 — Modulos (obligatorio)

Crea TRES archivos:

**`codigo/semana-02/validaciones.js`** — exporta estas funciones:
- `esEmailValido(email)` — retorna `true` si el email contiene `@` y `.`
- `esMayorDeEdad(edad)` — retorna `true` si edad >= 18
- `esCampoVacio(texto)` — retorna `true` si el texto es `null`, `undefined` o `""`

**`codigo/semana-02/formatear.js`** — exporta:
- `formatearNombre(nombre)` — retorna el nombre con la primera letra de cada palabra en mayuscula
- `formatearSalario(cantidad)` — retorna el numero con formato: `"$25,000.00 MXN"`

**`codigo/semana-02/ejercicio3.js`** — importa las funciones anteriores y prueba:
```
esEmailValido("jess@ine.mx")    → true
esEmailValido("jess-sin-arroba") → false
esMayorDeEdad(20)               → true
esMayorDeEdad(15)               → false
formatearNombre("jessica lopez") → "Jessica Lopez"
formatearSalario(25000)         → "$25,000.00 MXN"
```

**Tu solucion:**

---

## Ejercicio 4 — Optional chaining y nullish coalescing (obligatorio)

Crea `ejercicio4.js`.

Tienes estos datos que vienen de una API (algunos campos pueden estar vacios):
```javascript
const respuestas = [
    { id: 1, usuario: { nombre: "Ana", direccion: { ciudad: "CDMX" } }, puntos: 100 },
    { id: 2, usuario: { nombre: "Luis" }, puntos: 0 },                  // sin direccion
    { id: 3, usuario: null, puntos: 50 },                               // sin usuario
    { id: 4, usuario: { nombre: "Jess", direccion: { ciudad: "GDL" } }, puntos: null }
];
```

Para cada respuesta imprime:
```
ID 1 | Ana | Ciudad: CDMX | Puntos: 100
ID 2 | Luis | Ciudad: Sin datos | Puntos: 0
ID 3 | Anonimo | Ciudad: Sin datos | Puntos: 50
ID 4 | Jess | Ciudad: GDL | Puntos: 0
```

Usa `?.` y `??` para manejar los valores que pueden ser null.

**Tu solucion:**

---

## Ejercicio 5 — Reto: pipeline de datos (opcional pero recomendado)

Crea `ejercicio5.js`.

Tienes datos de ventas:
```javascript
const ventas = [
    { vendedor: "Ana", region: "norte", monto: 15000, completada: true },
    { vendedor: "Luis", region: "sur", monto: 8000, completada: false },
    { vendedor: "Jess", region: "norte", monto: 22000, completada: true },
    { vendedor: "Pedro", region: "norte", monto: 5000, completada: true },
    { vendedor: "Maria", region: "sur", monto: 18000, completada: true },
    { vendedor: "Carlos", region: "sur", monto: 3000, completada: false }
];
```

Sin for loops, encadenando metodos de array:
1. Filtra solo ventas completadas de la region "norte"
2. De esas, obtén solo `{ vendedor, monto }`
3. Ordenalas por monto de mayor a menor (busca `.sort()`)
4. Calcula el total de esas ventas con `.reduce()`

Resultado esperado:
```
Ventas completadas — Region Norte:
1. Jess: $22,000
2. Ana: $15,000
3. Pedro: $5,000

Total region norte: $42,000
```

**Tu solucion:**

---

## Checklist antes de subir

- [ ] Ejercicio 1: destructuring normal y anidado funcionando
- [ ] Ejercicio 2: el array original NO se modifico
- [ ] Ejercicio 3: los tres archivos existen y los imports funcionan
- [ ] Ejercicio 4: imprime "Sin datos" y "Anonimo" donde corresponde, sin errores
- [ ] Subi con `bash scripts/push.sh`
