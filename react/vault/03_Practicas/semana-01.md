---
semana: 1
tema: JavaScript fundamentos
estado: pendiente
---

# Practica — Semana 1: JavaScript fundamentos

> Guarda tu codigo en: `codigo/semana-01/`
> Al terminar: `bash scripts/push.sh "semana-01 practicas"`

Crea un archivo `.js` por ejercicio y correlo con:
```bash
node codigo/semana-01/ejercicio1.js
```

---

## Ejercicio 1 — Mi presentacion (obligatorio)

Crea el archivo `codigo/semana-01/ejercicio1.js`.

Declara variables para tu nombre, edad, ciudad y puesto actual.
Imprime un mensaje que diga:

```
=== Mi presentacion ===
Nombre: Jessica
Edad: 25 años
Ciudad: Ciudad de Mexico
Puesto: Desarrolladora Frontend
```

Usa template literals (backticks), no concatenacion con `+`.

**Tu solucion:**

---

## Ejercicio 2 — Calculadora simple (obligatorio)

Crea `ejercicio2.js`.

Escribe CUATRO funciones flecha:
- `sumar(a, b)` — retorna la suma
- `restar(a, b)` — retorna la resta
- `multiplicar(a, b)` — retorna el producto
- `dividir(a, b)` — retorna la division, pero si b es 0 debe retornar el string `"Error: no se puede dividir entre cero"`

Prueba cada funcion e imprime el resultado.

```
5 + 3 = 8
10 - 4 = 6
6 * 7 = 42
10 / 2 = 5
10 / 0 = Error: no se puede dividir entre cero
```

**Tu solucion:**

---

## Ejercicio 3 — Lista de tareas (obligatorio)

Crea `ejercicio3.js`.

Tienes este array:
```javascript
const tareas = [
    { id: 1, texto: "Instalar Node.js", completada: true },
    { id: 2, texto: "Leer teoria semana 1", completada: true },
    { id: 3, texto: "Hacer ejercicios", completada: false },
    { id: 4, texto: "Subir avances a GitHub", completada: false },
    { id: 5, texto: "Descansar", completada: false }
];
```

Usando `filter` y `map` (sin for loops):
1. Imprime solo las tareas pendientes (completada === false)
2. Imprime solo los textos de TODAS las tareas (sin el id ni el estado)
3. Imprime cuantas tareas ya estan completadas

Ejemplo de salida esperada:
```
Tareas pendientes:
- Hacer ejercicios
- Subir avances a GitHub
- Descansar

Todas las tareas:
- Instalar Node.js
- Leer teoria semana 1
- Hacer ejercicios
- Subir avances a GitHub
- Descansar

Completadas: 2 de 5
```

**Tu solucion:**

---

## Ejercicio 4 — Objeto empleado (obligatorio)

Crea `ejercicio4.js`.

1. Crea un objeto `empleado` con estas propiedades: nombre, puesto, departamento, activo (boolean), salario.
2. Escribe una funcion `describirEmpleado(emp)` que reciba un objeto empleado e imprima:
   ```
   Ana Lopez — Frontend Developer
   Departamento: Informatica
   Estado: Activo
   ```
3. Crea un array con 3 empleados diferentes y llama a `describirEmpleado` para cada uno usando `forEach`.

**Tu solucion:**

---

## Ejercicio 5 — Reto (opcional pero recomendado)

Crea `ejercicio5.js`.

Tienes este array de calificaciones de un estudiante:
```javascript
const calificaciones = [85, 92, 78, 90, 88, 76, 95, 83];
```

Sin usar for loops, usando solo metodos de array:
1. Calcula el promedio
2. Encuentra la calificacion mas alta (pista: busca `Math.max` y el operador spread `...`)
3. Encuentra la calificacion mas baja
4. Imprime cuantas calificaciones son mayores a 85
5. Imprime si el estudiante pasa (promedio >= 80) o reprueba

```
Promedio: 85.875
Mas alta: 95
Mas baja: 76
Arriba de 85: 4 calificaciones
Resultado: PASA
```

**Tu solucion:**

---

## Checklist antes de subir

- [ ] Ejercicio 1 corre sin errores con `node`
- [ ] Ejercicio 2 maneja la division entre cero
- [ ] Ejercicio 3 usa `filter` y `map`, no for loops
- [ ] Ejercicio 4 tiene la funcion y el array de 3 empleados
- [ ] Subi mis avances con `bash scripts/push.sh`
