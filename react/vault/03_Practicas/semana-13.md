---
semana: 13
tema: Redux Toolkit — práctica
estado: pendiente
---

# Semana 13 — Práctica Redux Toolkit

> Al terminar: `bash scripts/push.sh "semana-13 redux-practicas"`

---

## Ejercicio 1 — Carrito de compras (2 horas)

Crea una app sencilla de tienda con carrito usando Redux Toolkit.

### Setup

```bash
npm create vite@latest carrito -- --template react-ts
cd carrito
npm install @reduxjs/toolkit react-redux
npm run dev
```

### Lo que debes construir

Crea `src/store/carritoSlice.ts`:
- Estado: `{ items: { id, nombre, precio, cantidad }[], total: number }`
- Acciones: `agregar(producto)`, `quitar(id)`, `cambiarCantidad({ id, cantidad })`, `vaciar()`
- `total` se calcula automáticamente cuando cambia `items`

Crea `src/store/index.ts` con `configureStore`.

Crea `src/store/hooks.ts` con `useAppSelector` y `useAppDispatch`.

Crea estos componentes:
- `ListaProductos` — muestra 5 productos fijos con botón "Agregar al carrito"
- `Carrito` — muestra los items del carrito, botón – / + de cantidad, botón quitar, total
- `Badge` — número de items en el carrito (va en el header)

### Criterios de éxito
- [ ] Agregar un producto lo agrega al carrito
- [ ] Si el mismo producto ya está, aumenta la cantidad
- [ ] Cambiar cantidad actualiza el total
- [ ] Quitar elimina el item
- [ ] El badge del header muestra el número total de items
- [ ] "Vaciar carrito" limpia todo

---

## Ejercicio 2 — Lista de tareas con fetch (2 horas)

Agrega un slice `tareasSlice` que cargue tareas desde la API pública de JSONPlaceholder.

Endpoint: `GET https://jsonplaceholder.typicode.com/todos?_limit=10`

Usa `createAsyncThunk` para:
- `cargarTareas()` — fetch inicial al montar el componente
- Estado: `{ tareas, cargando, error }`
- Manejar los tres estados: pending / fulfilled / rejected

Crea un componente `ListaTareas` que:
- Al montar, dispara `cargarTareas()`
- Muestra "Cargando..." mientras `cargando === true`
- Muestra el error si existe
- Muestra la lista de tareas con su estado completado/pendiente

### Criterios de éxito
- [ ] Las tareas se cargan al abrir la app
- [ ] Se ve "Cargando..." mientras llega la respuesta
- [ ] Las tareas completadas tienen un estilo diferente (tachado o badge verde)
- [ ] Si cambias la URL a algo incorrecto, aparece el mensaje de error

---

## Ejercicio 3 — Redux DevTools (30 minutos)

Con el carrito del Ejercicio 1:
- Instala la extensión Redux DevTools en Chrome
- Abre la tienda, agrega productos, cambia cantidades, vacía el carrito
- En DevTools: observa cada acción en el historial
- Usa "Jump to state" para retroceder a un estado anterior

Entrega: screenshot del panel Redux DevTools con el historial de acciones.

---

## Bonus — Combinar con el proyecto de la semana 12

Si tienes el proyecto de empleados, agrega Redux:
- `authSlice` — guarda el usuario autenticado y el token
- `empleadosSlice` — lista de empleados + estado de carga
- Reemplaza los `useState` locales de autenticación por el slice
