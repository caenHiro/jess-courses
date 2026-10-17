---
semana: 5
tema: TypeScript
estado: pendiente
---

# Practica — Semana 5: TypeScript

> Configura el proyecto: `mkdir semana-05 && cd semana-05 && npm init -y && npm install -D typescript && npx tsc --init`
> Guarda en: `codigo/semana-05/src/`
> Compila: `npx tsc && node dist/ejercicioX.js`
> Al terminar: `bash scripts/push.sh "semana-05 typescript"`

---

## Ejercicio 1 — Tipar funciones y variables (obligatorio)

Crea `src/ejercicio1.ts`.

Escribe las siguientes funciones CON tipos explícitos en todo:

1. `calcularPromedio(notas: number[]): number` — promedio de un array
2. `formatearNombre(nombre: string, apellido: string): string` — "APELLIDO, Nombre"
3. `esMayorDeEdad(edad: number): boolean`
4. `clasificarNota(nota: number): "excelente" | "aprobado" | "reprobado"` — >=90 excelente, >=60 aprobado, resto reprobado
5. `obtenerPrimero<T>(arr: T[]): T | null` — genérico, null si el array está vacío

Prueba cada función con al menos 2 casos.

**Tu solucion:**

---

## Ejercicio 2 — Interfaces de un sistema escolar (obligatorio)

Crea `src/ejercicio2.ts`.

Define estas interfaces:
- `Alumno`: id, nombre, email, fechaNacimiento (string), activo
- `Materia`: id, nombre, creditos, semestre
- `Calificacion`: alumnoId, materiaId, calificacion, periodo ("2026-1" | "2026-2")
- `AlumnoConPromedio`: extiende Alumno y agrega promedio y materiasAprobadas

Crea al menos 3 alumnos, 3 materias y 6 calificaciones.

Escribe una función `calcularPromedioAlumno(alumnoId: number, calificaciones: Calificacion[]): number`

Escribe una función `obtenerAlumnosConPromedio(alumnos: Alumno[], calificaciones: Calificacion[]): AlumnoConPromedio[]`

Imprime los resultados.

**Tu solucion:**

---

## Ejercicio 3 — Union types y type guards (obligatorio)

Crea `src/ejercicio3.ts`.

Define:
```typescript
type Exitoso<T> = { exito: true; datos: T };
type Fallido = { exito: false; error: string; codigo: number };
type Resultado<T> = Exitoso<T> | Fallido;
```

Escribe funciones que devuelvan `Resultado<T>`:
- `buscarEmpleado(id: number, empleados: Empleado[]): Resultado<Empleado>`
  - Si lo encuentra: `{ exito: true, datos: empleado }`
  - Si no: `{ exito: false, error: "No encontrado", codigo: 404 }`

Escribe una función `procesarResultado<T>(resultado: Resultado<T>): void`
que imprima los datos si fue exitoso, o el error y código si falló.

Este patrón se llama **discriminated union** y se usa mucho en TypeScript profesional.

**Tu solucion:**

---

## Ejercicio 4 — Generics avanzados (obligatorio)

Crea `src/ejercicio4.ts`.

Implementa estas utilidades genéricas:

```typescript
// Devuelve una nueva interfaz donde todas las propiedades son opcionales
// (TypeScript ya tiene esto como Partial<T>, pero impleméntalo manual)

// 1. función paginar<T>(items: T[], pagina: number, porPagina: number): { datos: T[], total: number, paginas: number }
// Devuelve el subconjunto de items para esa página

// 2. función agrupar<T>(items: T[], clave: keyof T): Record<string, T[]>
// Agrupa un array de objetos por el valor de una propiedad
// Ejemplo: agrupar(empleados, "departamento") → { "Frontend": [...], "Backend": [...] }

// 3. función uniq<T>(items: T[]): T[]
// Elimina duplicados de un array
```

Prueba con arrays de empleados (del ejercicio 2 puedes reutilizar las interfaces).

**Tu solucion:**

---

## Ejercicio 5 — Tipar respuestas de API (opcional)

Crea `src/ejercicio5.ts`.

Crea interfaces para la API de JSONPlaceholder:
- `JSONPost`, `JSONUser`, `JSONComment`, `JSONAlbum`

Escribe una función `fetchTyped<T>(url: string): Promise<T>` que use `node-fetch` (instala con `npm install node-fetch`) y devuelva la respuesta tipada.

Llama a `/users`, `/posts?userId=1` y `/users/1/albums` usando la función tipada.

**Tu solucion:**

---

## Checklist antes de subir

- [ ] Ejercicio 1: ningún `any`, tipos explícitos en todo
- [ ] Ejercicio 2: las interfaces tienen sentido y el código compila sin errores
- [ ] Ejercicio 3: `procesarResultado` maneja ambos casos del union type
- [ ] Ejercicio 4: `agrupar` funciona con empleados por departamento
- [ ] Subi con `bash scripts/push.sh`
