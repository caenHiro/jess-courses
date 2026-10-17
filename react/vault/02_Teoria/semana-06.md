---
semana: 6
tema: React fundamentos — JSX, componentes y props
estado: pendiente
---

# Semana 6 — React fundamentos

> Tiempo estimado: 5–7 horas
> Al terminar: `bash scripts/push.sh "semana-06 react fundamentos"`

---

## Objetivo

Al terminar debes poder:
- Crear un proyecto React con Vite
- Entender qué es JSX
- Crear componentes funcionales
- Pasar datos entre componentes con props
- Componer una página con múltiples componentes

---

## 1. Configurar el proyecto con Vite

```bash
npm create vite@latest mi-app -- --template react-ts
cd mi-app
npm install
npm run dev
```

Estructura básica del proyecto:
```
mi-app/
├── src/
│   ├── App.tsx          # componente raíz
│   ├── main.tsx         # punto de entrada
│   └── components/      # tus componentes
├── public/
├── index.html
└── vite.config.ts
```

---

## 2. JSX — JavaScript + HTML juntos

JSX parece HTML pero es JavaScript. Babel (o Vite) lo convierte en llamadas a `React.createElement()`.

```tsx
// JSX
function MiComponente() {
    return (
        <div className="caja">
            <h1>Hola mundo</h1>
            <p>Esto es JSX</p>
        </div>
    );
}

// Lo que realmente genera (no tienes que escribir esto)
function MiComponente() {
    return React.createElement("div", { className: "caja" },
        React.createElement("h1", null, "Hola mundo"),
        React.createElement("p", null, "Esto es JSX")
    );
}
```

### Reglas de JSX

```tsx
// 1. Un solo elemento raíz (o Fragment <>)
// MAL
return (
    <h1>Título</h1>
    <p>Párrafo</p>
);

// BIEN — envuelto en un div
return (
    <div>
        <h1>Título</h1>
        <p>Párrafo</p>
    </div>
);

// BIEN — con Fragment (no agrega nodo extra al DOM)
return (
    <>
        <h1>Título</h1>
        <p>Párrafo</p>
    </>
);

// 2. className en vez de class
<div className="mi-clase">...</div>

// 3. Expresiones JS con llaves {}
const nombre = "Jess";
<h1>Hola {nombre}</h1>
<p>{2 + 2}</p>
<p>{activo ? "Activo" : "Inactivo"}</p>

// 4. Etiquetas siempre cerradas
<img src="foto.jpg" alt="foto" />   // autocierre
<input type="text" />

// 5. style como objeto
<div style={{ color: "red", fontSize: "16px" }}>texto</div>
```

---

## 3. Componentes funcionales

Un componente es una función que devuelve JSX. Nombre en **PascalCase**.

```tsx
// Componente simple
function Encabezado() {
    return (
        <header>
            <h1>Mi Portal</h1>
            <nav>
                <a href="/">Inicio</a>
                <a href="/perfil">Perfil</a>
            </nav>
        </header>
    );
}

export default Encabezado;
```

```tsx
// En App.tsx — importar y usar
import Encabezado from "./components/Encabezado";
import PiePagina from "./components/PiePagina";

function App() {
    return (
        <>
            <Encabezado />
            <main>Contenido principal</main>
            <PiePagina />
        </>
    );
}
```

---

## 4. Props — pasar datos a componentes

Props son los parámetros de un componente. De padre a hijo, solo hacia abajo (unidireccional).

```tsx
// Definir las props con una interfaz
interface TarjetaUsuarioProps {
    nombre: string;
    email: string;
    activo: boolean;
    rol?: string;  // opcional
}

// Componente que recibe props
function TarjetaUsuario({ nombre, email, activo, rol = "usuario" }: TarjetaUsuarioProps) {
    return (
        <div className="tarjeta">
            <h2>{nombre}</h2>
            <p>{email}</p>
            <span className={activo ? "badge-verde" : "badge-rojo"}>
                {activo ? "Activo" : "Inactivo"}
            </span>
            <small>Rol: {rol}</small>
        </div>
    );
}

// Usar el componente con props
function App() {
    return (
        <div>
            <TarjetaUsuario
                nombre="Jessica Lopez"
                email="jess@ine.mx"
                activo={true}
                rol="Frontend Dev"
            />
            <TarjetaUsuario
                nombre="Ana Gomez"
                email="ana@ine.mx"
                activo={false}
            />
        </div>
    );
}
```

---

## 5. Renderizar listas

```tsx
interface Empleado {
    id: number;
    nombre: string;
    puesto: string;
}

const empleados: Empleado[] = [
    { id: 1, nombre: "Ana", puesto: "Frontend" },
    { id: 2, nombre: "Luis", puesto: "Backend" },
    { id: 3, nombre: "Jess", puesto: "Frontend" }
];

function ListaEmpleados() {
    return (
        <ul>
            {empleados.map(emp => (
                <li key={emp.id}>           {/* key es OBLIGATORIO — debe ser único */}
                    {emp.nombre} — {emp.puesto}
                </li>
            ))}
        </ul>
    );
}
```

> `key` le dice a React qué elemento es qué cuando la lista cambia. Usa siempre el ID único del dato, nunca el índice del array.

---

## 6. Props especiales: children

```tsx
// children es el contenido que va dentro del componente
interface TarjetaProps {
    titulo: string;
    children: React.ReactNode;
}

function Tarjeta({ titulo, children }: TarjetaProps) {
    return (
        <div className="tarjeta">
            <h2>{titulo}</h2>
            <div className="contenido">{children}</div>
        </div>
    );
}

// Usar con contenido interno
function App() {
    return (
        <Tarjeta titulo="Mi Tarjeta">
            <p>Este es el contenido</p>
            <button>Clic aqui</button>
        </Tarjeta>
    );
}
```

---

## 7. Renderizado condicional

```tsx
function Perfil({ usuario }: { usuario: Usuario | null }) {
    // Guarda — si no hay usuario, no renderizar nada
    if (!usuario) {
        return <p>No hay usuario seleccionado.</p>;
    }

    return (
        <div>
            <h2>{usuario.nombre}</h2>
            {/* && — renderiza solo si la condición es verdadera */}
            {usuario.activo && <span className="badge">Activo</span>}

            {/* Ternario — uno u otro */}
            <p>{usuario.rol === "admin" ? "Administrador" : "Usuario regular"}</p>
        </div>
    );
}
```

---

## Estructura de archivos recomendada

```
src/
├── components/
│   ├── ui/             # componentes genéricos reutilizables
│   │   ├── Boton.tsx
│   │   └── Tarjeta.tsx
│   └── layout/         # estructura de la página
│       ├── Encabezado.tsx
│       └── PiePagina.tsx
├── pages/              # páginas completas
│   ├── Inicio.tsx
│   └── Perfil.tsx
├── types/              # interfaces TypeScript
│   └── index.ts
├── App.tsx
└── main.tsx
```

---

Cuando termines: `vault/03_Practicas/semana-06.md`
