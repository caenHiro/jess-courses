---
semana: 10
tema: React Router — navegación SPA
estado: pendiente
---

# Practica — Semana 10: React Router

> Instala: `npm install react-router-dom`
> Al terminar: `bash scripts/push.sh "semana-10 react-router"`

---

## Ejercicio 1 — Navegación básica (obligatorio)

Configura React Router en tu app con estas rutas:
- `/` → `Inicio.tsx` — página de bienvenida
- `/usuarios` → `UsuariosLista.tsx` — lista de usuarios
- `/usuarios/:id` → `UsuarioDetalle.tsx` — detalle
- `/acerca` → `Acerca.tsx` — información del sistema
- `*` → `NoEncontrado.tsx` — página 404

El `Layout` con la barra de navegación debe envolver todas las rutas.
Usa `NavLink` para que el link activo tenga estilos distintos.

**Tu solucion:**

---

## Ejercicio 2 — Detalle de usuario con parámetro (obligatorio)

En `UsuarioDetalle.tsx`:
- Usa `useParams` para obtener el ID de la URL
- Carga el usuario con `useFetch`: `https://jsonplaceholder.typicode.com/users/${id}`
- Muestra todos los datos: nombre, email, teléfono, dirección, empresa
- Carga sus posts: `https://jsonplaceholder.typicode.com/posts?userId=${id}`
- Botón "Volver a la lista" que usa `useNavigate(-1)`

En `UsuariosLista.tsx`, cada fila/tarjeta debe ser un `Link` a `/usuarios/${u.id}`.

**Tu solucion:**

---

## Ejercicio 3 — Filtros en la URL (obligatorio)

En `UsuariosLista.tsx` agrega filtros que se reflejan en la URL:
- Búsqueda por nombre → `?buscar=texto`
- Orden → `?orden=nombre` o `?orden=email`

Usa `useSearchParams` para leer y actualizar los params.

Al compartir la URL con los filtros aplicados, la página debe cargar con esos filtros activos.

**Tu solucion:**

---

## Ejercicio 4 — Rutas protegidas (obligatorio)

Implementa `src/components/layout/RutaProtegida.tsx` tal como se describe en la teoría.

Las rutas `/usuarios`, `/usuarios/:id` y `/acerca` deben requerir autenticación.
La ruta `/` y `/login` son públicas.

Si el usuario accede a una ruta protegida sin estar logueado, lo redirige a `/login`.
Después del login exitoso, lo regresa a la ruta que intentaba acceder (usa el `state` de `useNavigate`).

Pista:
```typescript
navigate("/login", { state: { from: location.pathname } });
// y en Login.tsx:
const { state } = useLocation();
navigate(state?.from ?? "/");
```

**Tu solucion:**

---

## Ejercicio 5 — Reto: rutas anidadas (opcional)

Agrega a `UsuarioDetalle` una navegación con tabs usando rutas anidadas:
- `/usuarios/:id/info` — datos generales
- `/usuarios/:id/posts` — posts del usuario
- `/usuarios/:id/albumes` — albums (`/users/:id/albums`)

Cada tab es una ruta hija con su propio `<Outlet>`.

**Tu solucion:**

---

## Checklist

- [ ] La página 404 aparece al ir a una URL que no existe
- [ ] `NavLink` activo se ve diferente al resto
- [ ] Los filtros de búsqueda persisten en la URL al recargar
- [ ] Las rutas protegidas redirigen al login
- [ ] Después del login, vuelve a donde intentaba ir
- [ ] Subi con `bash scripts/push.sh`
