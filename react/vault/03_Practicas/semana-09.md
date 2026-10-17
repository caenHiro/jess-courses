---
semana: 9
tema: Hooks avanzados — useContext, useRef y custom hooks
estado: pendiente
---

# Practica — Semana 9: Hooks avanzados

> Al terminar: `bash scripts/push.sh "semana-09 hooks avanzados"`

---

## Ejercicio 1 — Context de autenticación (obligatorio)

Crea `src/context/AuthContext.tsx` y úsalo en toda la app.

El contexto debe proveer: `usuario`, `login(credenciales)`, `logout()`, `estaAutenticado`.

- Pantalla de Login: si no hay usuario, muestra formulario (usuario y contraseña)
- Acepta cualquier usuario con contraseña "1234" (simulado, sin API)
- Después del login, muestra el contenido principal de la app
- En el header: nombre del usuario logueado y botón "Salir"
- Al hacer logout, vuelve al login

Aplica el contexto a 3 componentes en diferentes niveles del árbol — sin prop drilling.

**Tu solucion:**

---

## Ejercicio 2 — Context de tema (obligatorio)

Crea `src/context/TemaContext.tsx`.

- Provee `tema: "claro" | "oscuro"` y `toggleTema()`
- En modo oscuro: fondo #1a1a2e, texto blanco
- En modo claro: fondo blanco, texto oscuro
- Guarda la preferencia en `localStorage` para que persista al recargar
- Un botón de toggle accesible desde cualquier componente

**Tu solucion:**

---

## Ejercicio 3 — useRef para el DOM (obligatorio)

Crea `src/components/BuscadorConFoco.tsx`.

Un campo de búsqueda que:
- Al presionar `Ctrl+K` o `Cmd+K` en cualquier parte de la página, enfoca el input automáticamente
- Tiene un botón "X" que limpia el texto Y devuelve el foco al input
- Un contador de caracteres restantes (máx 50)
- Al presionar Escape, limpia el campo

Usa `useRef` para el input y `addEventListener` en `document` con cleanup en `useEffect`.

**Tu solucion:**

---

## Ejercicio 4 — Custom hook useFetch (obligatorio)

Implementa `src/hooks/useFetch.ts` tal como se describe en la teoría.

Debe tener: `data`, `cargando`, `error`, `recargar()`.

Pruébalo en 3 componentes diferentes:
1. Lista de posts: `useFetch<Post[]>("/posts?_limit=5")`
2. Detalle de usuario: `useFetch<Usuario>("/users/1")`
3. Un componente que use `recargar()` para simular "pull to refresh"

**Tu solucion:**

---

## Ejercicio 5 — Reto: hook useFormulario + validación (opcional)

Crea `src/hooks/useFormulario.ts`.

Un hook reutilizable que recibe:
```typescript
useFormulario(configuracion: {
    valoresIniciales: Record<string, string>,
    validaciones: Record<string, (valor: string) => string | null>
})
```

Devuelve: `valores`, `errores`, `handleChange`, `handleBlur`, `esValido`, `resetear`

- `handleBlur` activa la validación del campo que perdió el foco
- `esValido` es `true` cuando todos los campos pasan su validación
- La validación de un campo solo se muestra si ya fue tocado (para no alarmar al usuario antes de que empiece)

Úsalo en un formulario de registro completo.

**Tu solucion:**

---

## Checklist

- [ ] Ejercicio 1: sin prop drilling — 3 componentes consumen el contexto directamente
- [ ] Ejercicio 2: el tema persiste al recargar la página
- [ ] Ejercicio 3: Ctrl+K enfoca el input desde cualquier parte
- [ ] Ejercicio 4: `recargar()` vuelve a llamar la API
- [ ] Subi con `bash scripts/push.sh`
