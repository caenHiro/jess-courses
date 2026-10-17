---
semana: 9
tema: React Hooks avanzados — useContext, useRef y hooks personalizados
estado: pendiente
---

# Semana 9 — Hooks avanzados

> Tiempo estimado: 5–7 horas
> Al terminar: `bash scripts/push.sh "semana-09 hooks avanzados"`

---

## Objetivo

Al terminar debes poder:
- Compartir estado global con `useContext` (sin pasar props por varios niveles)
- Usar `useRef` para acceder al DOM y guardar valores que no re-renderizan
- Extraer lógica reutilizable en hooks personalizados

---

## 1. El problema de prop drilling

Cuando tienes estado en un componente padre y lo necesitas 3 o 4 niveles abajo, tienes que pasarlo como prop en cada nivel. Eso se llama **prop drilling** y hace el código difícil de mantener.

```
App → tiene el usuario
  └─ Layout
       └─ Sidebar
            └─ MenuUsuario  ← necesita el usuario, pero tuvo que pasar por Layout y Sidebar
```

La solución: `useContext`.

---

## 2. useContext — estado global simple

```tsx
// 1. Crear el contexto (en src/context/AuthContext.tsx)
import { createContext, useContext, useState, ReactNode } from "react";

interface Usuario {
    id: number;
    nombre: string;
    rol: string;
}

interface AuthContextType {
    usuario: Usuario | null;
    login: (u: Usuario) => void;
    logout: () => void;
}

// Crear el contexto con un valor por defecto
const AuthContext = createContext<AuthContextType | null>(null);

// 2. Crear el Provider — envuelve la app y provee el valor
export function AuthProvider({ children }: { children: ReactNode }) {
    const [usuario, setUsuario] = useState<Usuario | null>(null);

    const login = (u: Usuario) => setUsuario(u);
    const logout = () => setUsuario(null);

    return (
        <AuthContext.Provider value={{ usuario, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
}

// 3. Hook personalizado para consumir el contexto
export function useAuth() {
    const ctx = useContext(AuthContext);
    if (!ctx) throw new Error("useAuth debe usarse dentro de AuthProvider");
    return ctx;
}
```

```tsx
// En main.tsx — envolver la app con el Provider
import { AuthProvider } from "./context/AuthContext";

ReactDOM.createRoot(document.getElementById("root")!).render(
    <AuthProvider>
        <App />
    </AuthProvider>
);
```

```tsx
// En cualquier componente — consumir el contexto
import { useAuth } from "../context/AuthContext";

function MenuUsuario() {
    const { usuario, logout } = useAuth();  // sin prop drilling

    if (!usuario) return <button>Iniciar sesión</button>;

    return (
        <div>
            <span>Hola, {usuario.nombre}</span>
            <button onClick={logout}>Salir</button>
        </div>
    );
}
```

### Context para tema (dark/light mode)

```tsx
// src/context/TemaContext.tsx
type Tema = "claro" | "oscuro";

interface TemaContextType {
    tema: Tema;
    toggleTema: () => void;
}

const TemaContext = createContext<TemaContextType | null>(null);

export function TemaProvider({ children }: { children: ReactNode }) {
    const [tema, setTema] = useState<Tema>("claro");
    const toggleTema = () => setTema(t => t === "claro" ? "oscuro" : "claro");

    return (
        <TemaContext.Provider value={{ tema, toggleTema }}>
            <div className={`tema-${tema}`}>{children}</div>
        </TemaContext.Provider>
    );
}

export const useTema = () => {
    const ctx = useContext(TemaContext);
    if (!ctx) throw new Error("useTema fuera de TemaProvider");
    return ctx;
};
```

---

## 3. useRef

`useRef` tiene dos usos principales:

### A) Acceder directamente a un elemento del DOM

```tsx
import { useRef } from "react";

function InputConFoco() {
    const inputRef = useRef<HTMLInputElement>(null);

    const enfocar = () => {
        inputRef.current?.focus();
    };

    return (
        <div>
            <input ref={inputRef} placeholder="Haz clic en el botón" />
            <button onClick={enfocar}>Enfocar input</button>
        </div>
    );
}
```

### B) Guardar valores que NO deben causar re-render

```tsx
function Cronometro() {
    const [segundos, setSegundos] = useState(0);
    const [corriendo, setCorriendo] = useState(false);
    const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

    const iniciar = () => {
        if (corriendo) return;
        setCorriendo(true);
        intervalRef.current = setInterval(() => {
            setSegundos(s => s + 1);
        }, 1000);
    };

    const detener = () => {
        if (intervalRef.current) clearInterval(intervalRef.current);
        setCorriendo(false);
    };

    const reiniciar = () => {
        detener();
        setSegundos(0);
    };

    return (
        <div>
            <p>{segundos}s</p>
            <button onClick={iniciar} disabled={corriendo}>Iniciar</button>
            <button onClick={detener} disabled={!corriendo}>Detener</button>
            <button onClick={reiniciar}>Reiniciar</button>
        </div>
    );
}
```

> La diferencia con `useState`: cambiar un `ref` NO causa re-render. Úsalo cuando necesitas recordar un valor entre renders pero el valor no afecta la UI.

---

## 4. Hooks personalizados (custom hooks)

Un custom hook es una función que empieza con `use` y puede llamar a otros hooks. Permite extraer y reutilizar lógica.

### Hook para fetch de datos

```tsx
// src/hooks/useFetch.ts
import { useState, useEffect } from "react";

interface UseFetchResult<T> {
    data: T | null;
    cargando: boolean;
    error: string | null;
    recargar: () => void;
}

export function useFetch<T>(url: string): UseFetchResult<T> {
    const [data, setData] = useState<T | null>(null);
    const [cargando, setCargando] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [contador, setContador] = useState(0);  // para forzar recarga

    useEffect(() => {
        let cancelado = false;  // evita actualizar estado si el componente se desmontó

        async function cargar() {
            setCargando(true);
            setError(null);
            try {
                const res = await fetch(url);
                if (!res.ok) throw new Error(`Error ${res.status}`);
                const json: T = await res.json();
                if (!cancelado) setData(json);
            } catch (err) {
                if (!cancelado) setError((err as Error).message);
            } finally {
                if (!cancelado) setCargando(false);
            }
        }

        cargar();
        return () => { cancelado = true; };
    }, [url, contador]);

    return { data, cargando, error, recargar: () => setContador(c => c + 1) };
}
```

```tsx
// Usar el hook en un componente — mucho más limpio
import { useFetch } from "../hooks/useFetch";

interface Post { id: number; title: string; body: string; }

function ListaPosts() {
    const { data: posts, cargando, error, recargar } = useFetch<Post[]>(
        "https://jsonplaceholder.typicode.com/posts?_limit=5"
    );

    if (cargando) return <p>Cargando...</p>;
    if (error)    return <p>Error: {error} <button onClick={recargar}>Reintentar</button></p>;

    return (
        <>
            <button onClick={recargar}>Actualizar</button>
            <ul>
                {posts?.map(p => <li key={p.id}>{p.title}</li>)}
            </ul>
        </>
    );
}
```

### Hook para formularios

```tsx
// src/hooks/useForm.ts
export function useForm<T extends Record<string, string>>(valoresIniciales: T) {
    const [valores, setValores] = useState(valoresIniciales);

    const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { name, value } = e.target;
        setValores(prev => ({ ...prev, [name]: value }));
    };

    const resetear = () => setValores(valoresIniciales);

    return { valores, handleChange, resetear };
}

// Uso
function MiFormulario() {
    const { valores, handleChange, resetear } = useForm({
        nombre: "", email: "", password: ""
    });

    return (
        <form>
            <input name="nombre" value={valores.nombre} onChange={handleChange} />
            <input name="email"  value={valores.email}  onChange={handleChange} />
            <button type="button" onClick={resetear}>Limpiar</button>
        </form>
    );
}
```

### Hook para local storage

```tsx
// src/hooks/useLocalStorage.ts
export function useLocalStorage<T>(clave: string, valorInicial: T) {
    const [valor, setValor] = useState<T>(() => {
        const guardado = localStorage.getItem(clave);
        return guardado ? JSON.parse(guardado) : valorInicial;
    });

    const guardar = (nuevoValor: T) => {
        setValor(nuevoValor);
        localStorage.setItem(clave, JSON.stringify(nuevoValor));
    };

    return [valor, guardar] as const;
}

// Uso — las preferencias persisten al recargar la página
const [tema, setTema] = useLocalStorage("tema", "claro");
```

---

## Reglas de los hooks

1. Solo llama hooks en el **nivel superior** de la función (nunca dentro de if, for, etc.)
2. Solo llama hooks en **componentes React** o en otros **hooks personalizados**
3. Los hooks personalizados **siempre empiezan con `use`**

---

Cuando termines: `vault/03_Practicas/semana-09.md`
