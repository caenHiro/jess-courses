---
semana: 11
tema: Integración de APIs — axios, estados de carga y manejo de errores
estado: pendiente
---

# Semana 11 — APIs con React profesional

> Tiempo estimado: 6–8 horas
> Al terminar: `bash scripts/push.sh "semana-11 apis-react"`

---

## Objetivo

Al terminar debes poder:
- Usar axios como alternativa a fetch
- Crear una capa de servicios que separa la lógica de la UI
- Manejar autenticación con tokens JWT
- Implementar patrones de carga y error que se usan en equipos reales

---

## 1. Axios vs fetch

```bash
npm install axios
```

| | fetch | axios |
|-|-------|-------|
| Instancia reutilizable | No | Sí |
| Interceptors (añadir token a todas las peticiones) | No | Sí |
| JSON automático | `await res.json()` | Automático |
| Errores HTTP como excepciones | No (res.ok manual) | Sí |
| Cancel requests | AbortController | CancelToken / AbortController |

---

## 2. Instancia de axios configurada

```typescript
// src/api/cliente.ts
import axios from "axios";

const cliente = axios.create({
    baseURL: "https://jsonplaceholder.typicode.com",
    timeout: 10000,
    headers: {
        "Content-Type": "application/json"
    }
});

// Interceptor de request — agrega el token JWT a todas las peticiones
cliente.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem("token");
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
        }
        return config;
    },
    (error) => Promise.reject(error)
);

// Interceptor de response — maneja errores globales
cliente.interceptors.response.use(
    (response) => response,
    (error) => {
        if (error.response?.status === 401) {
            // Token expirado — redirigir al login
            localStorage.removeItem("token");
            window.location.href = "/login";
        }
        return Promise.reject(error);
    }
);

export default cliente;
```

---

## 3. Capa de servicios

La UI no debe saber de dónde vienen los datos. Los servicios son los responsables de hablar con la API.

```typescript
// src/api/usuariosService.ts
import cliente from "./cliente";

export interface Usuario {
    id: number;
    name: string;
    email: string;
    phone: string;
    username: string;
}

export interface NuevoUsuario {
    name: string;
    email: string;
    phone: string;
}

export const usuariosService = {
    async listar(): Promise<Usuario[]> {
        const { data } = await cliente.get<Usuario[]>("/users");
        return data;
    },

    async obtener(id: number): Promise<Usuario> {
        const { data } = await cliente.get<Usuario>(`/users/${id}`);
        return data;
    },

    async crear(usuario: NuevoUsuario): Promise<Usuario> {
        const { data } = await cliente.post<Usuario>("/users", usuario);
        return data;
    },

    async actualizar(id: number, usuario: Partial<NuevoUsuario>): Promise<Usuario> {
        const { data } = await cliente.patch<Usuario>(`/users/${id}`, usuario);
        return data;
    },

    async eliminar(id: number): Promise<void> {
        await cliente.delete(`/users/${id}`);
    }
};
```

```typescript
// src/api/authService.ts
import cliente from "./cliente";

interface Credenciales { username: string; password: string; }
interface TokenResponse { token: string; user: { id: number; nombre: string; rol: string; } }

export const authService = {
    async login(credenciales: Credenciales): Promise<TokenResponse> {
        const { data } = await cliente.post<TokenResponse>("/auth/login", credenciales);
        localStorage.setItem("token", data.token);
        return data;
    },

    logout() {
        localStorage.removeItem("token");
    },

    estaAutenticado(): boolean {
        return Boolean(localStorage.getItem("token"));
    }
};
```

---

## 4. Hook personalizado con servicio

```tsx
// src/hooks/useUsuarios.ts
import { useState, useEffect, useCallback } from "react";
import { usuariosService, Usuario } from "../api/usuariosService";

export function useUsuarios() {
    const [usuarios, setUsuarios] = useState<Usuario[]>([]);
    const [cargando, setCargando] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const cargar = useCallback(async () => {
        setCargando(true);
        setError(null);
        try {
            const data = await usuariosService.listar();
            setUsuarios(data);
        } catch (err: any) {
            setError(err.response?.data?.message ?? "Error al cargar usuarios");
        } finally {
            setCargando(false);
        }
    }, []);

    const eliminar = async (id: number) => {
        try {
            await usuariosService.eliminar(id);
            setUsuarios(prev => prev.filter(u => u.id !== id));
        } catch {
            setError("No se pudo eliminar el usuario");
        }
    };

    useEffect(() => { cargar(); }, [cargar]);

    return { usuarios, cargando, error, recargar: cargar, eliminar };
}
```

---

## 5. Página que usa el servicio

```tsx
// src/pages/Usuarios/UsuariosLista.tsx
import { useUsuarios } from "../../hooks/useUsuarios";
import { Link } from "react-router-dom";

function UsuariosLista() {
    const { usuarios, cargando, error, recargar, eliminar } = useUsuarios();
    const [confirmEliminar, setConfirmEliminar] = useState<number | null>(null);

    if (cargando) return <div className="spinner">Cargando usuarios...</div>;

    return (
        <div>
            <div className="encabezado">
                <h1>Usuarios</h1>
                <Link to="/usuarios/nuevo">+ Nuevo usuario</Link>
            </div>

            {error && (
                <div className="alerta-error">
                    {error}
                    <button onClick={recargar}>Reintentar</button>
                </div>
            )}

            <table>
                <thead>
                    <tr>
                        <th>Nombre</th><th>Email</th><th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    {usuarios.map(u => (
                        <tr key={u.id}>
                            <td>{u.name}</td>
                            <td>{u.email}</td>
                            <td>
                                <Link to={`/usuarios/${u.id}`}>Ver</Link>
                                <Link to={`/usuarios/${u.id}/editar`}>Editar</Link>
                                {confirmEliminar === u.id ? (
                                    <>
                                        <span>¿Seguro?</span>
                                        <button onClick={() => { eliminar(u.id); setConfirmEliminar(null); }}>
                                            Sí, eliminar
                                        </button>
                                        <button onClick={() => setConfirmEliminar(null)}>
                                            Cancelar
                                        </button>
                                    </>
                                ) : (
                                    <button onClick={() => setConfirmEliminar(u.id)}>
                                        Eliminar
                                    </button>
                                )}
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}
```

---

## 6. Patrones profesionales

### Toast notifications (sin librería)
```tsx
// Patrón simple para mostrar mensajes de éxito/error sin alert()
const [toast, setToast] = useState<{ tipo: "exito" | "error"; mensaje: string } | null>(null);

const mostrarToast = (tipo: "exito" | "error", mensaje: string) => {
    setToast({ tipo, mensaje });
    setTimeout(() => setToast(null), 3000);  // desaparece a los 3s
};

// En JSX:
{toast && (
    <div className={`toast toast-${toast.tipo}`}>{toast.mensaje}</div>
)}
```

### Debounce en búsqueda (no llamar la API en cada keystroke)
```tsx
function useDebouncedValue<T>(value: T, delay: number): T {
    const [debouncedValue, setDebouncedValue] = useState(value);

    useEffect(() => {
        const timer = setTimeout(() => setDebouncedValue(value), delay);
        return () => clearTimeout(timer);
    }, [value, delay]);

    return debouncedValue;
}

// Uso
const [busqueda, setBusqueda] = useState("");
const busquedaDebounced = useDebouncedValue(busqueda, 500);  // espera 500ms

useEffect(() => {
    if (busquedaDebounced) buscarUsuarios(busquedaDebounced);
}, [busquedaDebounced]);  // solo se llama cuando para de escribir
```

---

Cuando termines: `vault/03_Practicas/semana-11.md`
