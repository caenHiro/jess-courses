---
semana: 11
tema: APIs con React — axios, servicios y patrones profesionales
estado: pendiente
---

# Practica — Semana 11: APIs profesionales

> Instala: `npm install axios`
> Al terminar: `bash scripts/push.sh "semana-11 apis-profesionales"`

---

## Ejercicio 1 — Instancia de axios (obligatorio)

Crea `src/api/cliente.ts` con una instancia de axios configurada:
- `baseURL`: `https://jsonplaceholder.typicode.com`
- `timeout`: 10 segundos
- Interceptor de request que loguea en consola: `"→ GET /users"` (método + url)
- Interceptor de response que loguea: `"← 200 /users (245ms)"` (status + url + tiempo)

Prueba que los logs aparecen en consola al hacer cualquier petición.

**Tu solucion:**

---

## Ejercicio 2 — Capa de servicios (obligatorio)

Crea estos servicios usando tu instancia de axios:

**`src/api/usuariosService.ts`**:
- `listar()` — GET /users
- `obtener(id)` — GET /users/:id
- `crear(datos)` — POST /users
- `actualizar(id, datos)` — PATCH /users/:id
- `eliminar(id)` — DELETE /users/:id

**`src/api/postsService.ts`**:
- `listar(userId?)` — GET /posts (opcionalmente filtrado por userId)
- `obtener(id)` — GET /posts/:id
- `crearPost(datos)` — POST /posts

Los tipos TypeScript deben estar en `src/types/index.ts`.

**Tu solucion:**

---

## Ejercicio 3 — hook useUsuarios (obligatorio)

Crea `src/hooks/useUsuarios.ts` que use `usuariosService`.

Debe proveer: `usuarios`, `cargando`, `error`, `recargar`, `eliminar(id)`, `crear(datos)`.

Úsalo en una página `UsuariosAdmin.tsx` que tenga:
- Tabla con los usuarios
- Botón "Nuevo usuario" que abre un formulario inline
- Botón "Eliminar" con confirmación
- Al eliminar o crear, la lista se actualiza automáticamente
- Toast de éxito/error después de cada operación

**Tu solucion:**

---

## Ejercicio 4 — Búsqueda con debounce (obligatorio)

Implementa `src/hooks/useDebounce.ts`:

```typescript
function useDebounce<T>(value: T, delay: number): T
```

Úsalo en la barra de búsqueda de usuarios: el fetch a la API solo se ejecuta cuando el usuario para de escribir (500ms de pausa).

Muestra un indicador visual mientras espera el debounce ("Buscando..." aparece solo cuando hay delay activo).

**Tu solucion:**

---

## Ejercicio 5 — Reto: paginación (opcional)

Implementa paginación en la lista de posts (`https://jsonplaceholder.typicode.com/posts`):
- Muestra 10 posts por página
- Botones "Anterior" y "Siguiente"
- Indicador de página: "Página 3 de 10"
- Los parámetros de paginación van en la URL: `?pagina=3`

JSONPlaceholder soporta: `/posts?_page=3&_limit=10`

**Tu solucion:**

---

## Checklist

- [ ] Ejercicio 1: los interceptors se ven en consola
- [ ] Ejercicio 2: los servicios no tienen lógica de UI (solo llamadas a la API)
- [ ] Ejercicio 3: la lista se actualiza sin recargar la página
- [ ] Ejercicio 4: la búsqueda no llama la API en cada letra
- [ ] Subi con `bash scripts/push.sh`
