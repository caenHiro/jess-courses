---
semana: 10
tema: React Router — navegación SPA y rutas
estado: pendiente
---

# Semana 10 — React Router

> Tiempo estimado: 5–6 horas
> Al terminar: `bash scripts/push.sh "semana-10 react-router"`

---

## Objetivo

Al terminar debes poder:
- Configurar navegación entre páginas sin recargar el navegador
- Crear rutas con parámetros dinámicos
- Proteger rutas que requieren autenticación
- Navegar programáticamente (desde código, no solo con links)

---

## 1. Instalación

```bash
npm install react-router-dom
```

---

## 2. Configuración básica

```tsx
// main.tsx
import { BrowserRouter } from "react-router-dom";

ReactDOM.createRoot(document.getElementById("root")!).render(
    <BrowserRouter>
        <App />
    </BrowserRouter>
);
```

```tsx
// App.tsx
import { Routes, Route } from "react-router-dom";
import Inicio from "./pages/Inicio";
import Usuarios from "./pages/Usuarios";
import UsuarioDetalle from "./pages/UsuarioDetalle";
import NoEncontrado from "./pages/NoEncontrado";
import Layout from "./components/layout/Layout";

function App() {
    return (
        <Routes>
            <Route path="/" element={<Layout />}>
                <Route index element={<Inicio />} />
                <Route path="usuarios" element={<Usuarios />} />
                <Route path="usuarios/:id" element={<UsuarioDetalle />} />
                <Route path="*" element={<NoEncontrado />} />
            </Route>
        </Routes>
    );
}
```

```tsx
// Layout.tsx — componente que contiene la navegación y el Outlet
import { Outlet, NavLink } from "react-router-dom";

function Layout() {
    return (
        <div>
            <nav>
                {/* NavLink agrega clase "active" automáticamente a la ruta actual */}
                <NavLink to="/" end>Inicio</NavLink>
                <NavLink to="/usuarios">Usuarios</NavLink>
            </nav>
            <main>
                <Outlet />   {/* Aquí se renderiza la página actual */}
            </main>
        </div>
    );
}
```

---

## 3. Parámetros de ruta (`:id`)

```tsx
// Ruta definida como: /usuarios/:id

// Página que usa el parámetro
import { useParams } from "react-router-dom";

function UsuarioDetalle() {
    const { id } = useParams<{ id: string }>();
    const { data: usuario, cargando } = useFetch<Usuario>(
        `https://jsonplaceholder.typicode.com/users/${id}`
    );

    if (cargando) return <p>Cargando...</p>;
    if (!usuario) return <p>Usuario no encontrado</p>;

    return (
        <div>
            <h1>{usuario.name}</h1>
            <p>{usuario.email}</p>
        </div>
    );
}
```

---

## 4. Query params (filtros en la URL)

```tsx
// URL: /usuarios?departamento=frontend&activo=true
import { useSearchParams } from "react-router-dom";

function Usuarios() {
    const [searchParams, setSearchParams] = useSearchParams();

    const filtro = searchParams.get("departamento") ?? "todos";
    const activo  = searchParams.get("activo") === "true";

    const cambiarFiltro = (dpto: string) => {
        setSearchParams({ departamento: dpto, activo: String(activo) });
    };

    return (
        <div>
            <button onClick={() => cambiarFiltro("frontend")}>Frontend</button>
            <button onClick={() => cambiarFiltro("backend")}>Backend</button>
        </div>
    );
}
```

---

## 5. Navegación programática

```tsx
import { useNavigate } from "react-router-dom";

function Formulario() {
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        await guardarDatos();
        navigate("/usuarios");           // ir a una ruta
        navigate(-1);                     // volver atrás (como el botón back)
        navigate("/usuarios", { replace: true });  // sin agregar al historial
    };

    return <form onSubmit={handleSubmit}>...</form>;
}
```

---

## 6. Rutas protegidas

```tsx
// src/components/RutaProtegida.tsx
import { Navigate, Outlet } from "react-router-dom";
import { useAuth } from "../context/AuthContext";

function RutaProtegida() {
    const { usuario } = useAuth();

    if (!usuario) {
        // Redirige al login si no está autenticado
        return <Navigate to="/login" replace />;
    }

    return <Outlet />;  // si está autenticado, renderiza la ruta hija
}

// En App.tsx — envolver rutas privadas
<Routes>
    <Route path="/login" element={<Login />} />

    {/* Rutas que requieren autenticación */}
    <Route element={<RutaProtegida />}>
        <Route path="/" element={<Layout />}>
            <Route index element={<Dashboard />} />
            <Route path="usuarios" element={<Usuarios />} />
        </Route>
    </Route>
</Routes>
```

---

## 7. Hooks de React Router — resumen

| Hook | Para qué |
|------|---------|
| `useNavigate()` | Navegar desde código |
| `useParams()` | Leer parámetros de la URL (`/usuarios/:id`) |
| `useSearchParams()` | Leer y modificar query params (`?filtro=x`) |
| `useLocation()` | Acceder al objeto de ubicación actual (pathname, state) |

---

## Estructura de páginas recomendada

```
src/
├── pages/
│   ├── Inicio.tsx
│   ├── Login.tsx
│   ├── Usuarios/
│   │   ├── UsuariosLista.tsx
│   │   └── UsuarioDetalle.tsx
│   └── NotFound.tsx
├── components/
│   └── layout/
│       ├── Layout.tsx
│       └── RutaProtegida.tsx
└── App.tsx
```

---

Cuando termines: `vault/03_Practicas/semana-10.md`
