---
semana: 13
tema: Redux Toolkit — estado global de la aplicación
estado: pendiente
---

# Semana 13 — Redux Toolkit

> Tiempo estimado: 6–7 horas  
> Al terminar: `bash scripts/push.sh "semana-13 redux-toolkit"`

---

## Objetivo

Al terminar debes poder:
- Entender qué problema resuelve Redux y cuándo usarlo
- Crear un store con Redux Toolkit
- Definir slices (estado + acciones + reducers en un solo lugar)
- Leer estado con `useSelector` y despachar acciones con `useDispatch`
- Manejar llamadas a APIs con `createAsyncThunk`
- Usar Redux con TypeScript

---

## 1. ¿Qué es Redux y por qué existe?

### El problema sin Redux

Cuando el estado necesita compartirse entre componentes que no son padre-hijo, hay que "elevar" el estado hasta el ancestro común y pasarlo hacia abajo con props. Esto se vuelve complicado con árboles profundos.

```
App (estado: usuario, carrito, notificaciones)
├── Header (necesita: usuario, notificaciones)
│   └── AvatarUsuario (necesita: usuario)
├── Sidebar (necesita: usuario)
└── Contenido
    └── Carrito (necesita: carrito)
        └── ItemCarrito (necesita: carrito)
```

Prop drilling: pasas el mismo dato por 4 componentes intermedios que no lo usan.

### La solución: una tienda global

Redux crea una **tienda** (store) fuera del árbol de componentes. Cualquier componente puede leer de ella y actualizarla directamente.

Analogía Java: la tienda es como un singleton con estado, pero inmutable — cada actualización produce un nuevo estado en lugar de mutar el existente.

---

## 2. Conceptos clave

| Concepto | Qué hace | Analogía Java |
|---|---|---|
| **Store** | Contiene todo el estado global | Clase Singleton con campos finales |
| **Slice** | Agrupa estado + acciones + reducers | Un módulo con su propio Repository |
| **Action** | Describe QUÉ cambió | Un Event (CQRS) |
| **Reducer** | Describe CÓMO cambia el estado | Handler del Event |
| **Selector** | Lee un trozo del estado | Getter del Repository |
| **Dispatch** | Envía una acción a la tienda | Publicar un Event |

---

## 3. Instalación

```bash
npm install @reduxjs/toolkit react-redux
```

---

## 4. Crear un slice

Un slice define: el estado inicial, y todas las acciones que pueden modificarlo.

```typescript
// src/store/contadorSlice.ts
import { createSlice, PayloadAction } from "@reduxjs/toolkit";

// Tipo del estado
interface ContadorState {
    valor: number;
    paso: number;
}

// Estado inicial
const initialState: ContadorState = {
    valor: 0,
    paso: 1,
};

// Crear el slice
const contadorSlice = createSlice({
    name: "contador",
    initialState,
    reducers: {
        // Cada función aquí es un reducer + genera una acción automáticamente
        incrementar: (state) => {
            state.valor += state.paso;  // RTK usa Immer: puedes "mutar" el estado
        },
        decrementar: (state) => {
            state.valor -= state.paso;
        },
        reiniciar: (state) => {
            state.valor = 0;
        },
        cambiarPaso: (state, action: PayloadAction<number>) => {
            state.paso = action.payload;
        },
    },
});

// Exportar las acciones generadas
export const { incrementar, decrementar, reiniciar, cambiarPaso } = contadorSlice.actions;

// Exportar el reducer (para el store)
export default contadorSlice.reducer;
```

---

## 5. Crear la tienda (store)

```typescript
// src/store/index.ts
import { configureStore } from "@reduxjs/toolkit";
import contadorReducer from "./contadorSlice";

export const store = configureStore({
    reducer: {
        contador: contadorReducer,
        // aquí irían otros slices: usuarios, carrito, notificaciones...
    },
});

// Tipos para TypeScript
export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
```

---

## 6. Conectar la tienda a React

```tsx
// src/main.tsx
import { Provider } from "react-redux";
import { store } from "./store";

ReactDOM.createRoot(document.getElementById("root")!).render(
    <Provider store={store}>
        <App />
    </Provider>
);
```

---

## 7. Usar el estado en componentes

```tsx
// src/components/Contador.tsx
import { useSelector, useDispatch } from "react-redux";
import { RootState, AppDispatch } from "../store";
import { incrementar, decrementar, reiniciar, cambiarPaso } from "../store/contadorSlice";

function Contador() {
    // Leer estado
    const valor = useSelector((state: RootState) => state.contador.valor);
    const paso  = useSelector((state: RootState) => state.contador.paso);
    const dispatch = useDispatch<AppDispatch>();

    return (
        <div>
            <h2>Contador: {valor}</h2>
            <div>
                <button onClick={() => dispatch(decrementar())}>-</button>
                <span>{paso}</span>
                <button onClick={() => dispatch(incrementar())}>+</button>
            </div>
            <button onClick={() => dispatch(reiniciar())}>Reiniciar</button>
            <input
                type="number"
                value={paso}
                onChange={(e) => dispatch(cambiarPaso(Number(e.target.value)))}
            />
        </div>
    );
}
```

---

## 8. Crear hooks tipados (buena práctica)

En lugar de llamar `useSelector` con el tipo completo cada vez, crea hooks reutilizables:

```typescript
// src/store/hooks.ts
import { TypedUseSelectorHook, useDispatch, useSelector } from "react-redux";
import type { RootState, AppDispatch } from ".";

// Usar estos en vez de los originales
export const useAppDispatch = () => useDispatch<AppDispatch>();
export const useAppSelector: TypedUseSelectorHook<RootState> = useSelector;
```

```tsx
// Ahora en componentes:
import { useAppSelector, useAppDispatch } from "../store/hooks";

const valor = useAppSelector((state) => state.contador.valor);
const dispatch = useAppDispatch();
```

---

## 9. Llamadas a API con createAsyncThunk

Para operaciones asíncronas (fetch a un servidor), RTK tiene `createAsyncThunk`:

```typescript
// src/store/usuariosSlice.ts
import { createSlice, createAsyncThunk, PayloadAction } from "@reduxjs/toolkit";

interface Usuario {
    id: number;
    nombre: string;
    email: string;
}

interface UsuariosState {
    lista: Usuario[];
    cargando: boolean;
    error: string | null;
}

const initialState: UsuariosState = {
    lista: [],
    cargando: false,
    error: null,
};

// Thunk: función asíncrona que dispara acciones automáticamente
export const obtenerUsuarios = createAsyncThunk(
    "usuarios/obtener",
    async () => {
        const res = await fetch("/api/usuarios");
        if (!res.ok) throw new Error("Error al cargar usuarios");
        return await res.json() as Usuario[];
    }
);

const usuariosSlice = createSlice({
    name: "usuarios",
    initialState,
    reducers: {},
    // extraReducers maneja las acciones del thunk
    extraReducers: (builder) => {
        builder
            .addCase(obtenerUsuarios.pending, (state) => {
                state.cargando = true;
                state.error = null;
            })
            .addCase(obtenerUsuarios.fulfilled, (state, action: PayloadAction<Usuario[]>) => {
                state.cargando = false;
                state.lista = action.payload;
            })
            .addCase(obtenerUsuarios.rejected, (state, action) => {
                state.cargando = false;
                state.error = action.error.message ?? "Error desconocido";
            });
    },
});

export default usuariosSlice.reducer;
```

```tsx
// Componente que usa el thunk
function ListaUsuarios() {
    const { lista, cargando, error } = useAppSelector((s) => s.usuarios);
    const dispatch = useAppDispatch();

    useEffect(() => {
        dispatch(obtenerUsuarios());
    }, [dispatch]);

    if (cargando) return <p>Cargando...</p>;
    if (error)    return <p>Error: {error}</p>;

    return (
        <ul>
            {lista.map((u) => (
                <li key={u.id}>{u.nombre} — {u.email}</li>
            ))}
        </ul>
    );
}
```

---

## 10. Redux DevTools

Instala la extensión Redux DevTools en Chrome/Firefox. Te permite:
- Ver el historial de todas las acciones despachadas
- Inspeccionar el estado antes y después de cada acción
- Viajar en el tiempo (revertir acciones)

No requiere configuración adicional con RTK — ya está incluido.

---

## 11. ¿Cuándo usar Redux vs useContext?

| Situación | Usa |
|---|---|
| Estado simple compartido entre pocos componentes | `useContext` + `useState` |
| Estado complejo con muchas actualizaciones | Redux |
| Lógica asíncrona (fetching, cache) | Redux + createAsyncThunk o RTK Query |
| Estado de UI local (modal abierto/cerrado) | `useState` local |
| En el INE tienen Redux ya configurado | Redux (seguir el patrón existente) |

---

## 12. Estructura de carpetas recomendada en INE

```
src/
├── store/
│   ├── index.ts                # configureStore + tipos RootState/AppDispatch
│   ├── hooks.ts                # useAppSelector / useAppDispatch tipados
│   ├── contadorSlice.ts        # feature slice 1
│   └── usuariosSlice.ts        # feature slice 2
```

---

## Resumen de la semana

```
Redux Toolkit = la forma moderna de Redux (sin boilerplate)

Flujo completo:
1. createSlice()  → define estado + reducers + acciones
2. configureStore() → une todos los slices
3. <Provider store={store}> → envuelve la app
4. useAppSelector() → leer estado en componentes
5. useAppDispatch() + dispatch(accion()) → actualizar estado
6. createAsyncThunk() → operaciones asíncronas (fetch)
```
