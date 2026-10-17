---
semana: 7
tema: React estado — useState, useEffect y ciclo de vida
estado: pendiente
---

# Semana 7 — React estado: useState y useEffect

> Tiempo estimado: 6–8 horas
> Al terminar: `bash scripts/push.sh "semana-07 usestate useeffect"`

---

## Objetivo

Al terminar debes poder:
- Usar `useState` para manejar estado local
- Entender el ciclo de vida de un componente
- Usar `useEffect` para efectos secundarios (fetch, timers, subscriptions)
- Manejar estado de objetos y arrays correctamente

---

## 1. Estado — por qué existe

En la semana 3 modificaste el DOM directamente. React usa un enfoque diferente: tú describes CÓMO debe verse la UI en función de los datos, y React se encarga de actualizar el DOM.

```
Estado cambia → React re-renderiza → DOM actualizado automáticamente
```

```tsx
// MAL: modificar DOM directamente en React
document.querySelector("#contador").textContent = "5";

// BIEN: cambiar estado y dejar que React actualice
setContador(5);
```

---

## 2. useState

```tsx
import { useState } from "react";

function Contador() {
    // [valorActual, funcionParaCambiar] = useState(valorInicial)
    const [contador, setContador] = useState(0);

    return (
        <div>
            <p>Valor: {contador}</p>
            <button onClick={() => setContador(contador + 1)}>+1</button>
            <button onClick={() => setContador(contador - 1)}>-1</button>
            <button onClick={() => setContador(0)}>Reset</button>
        </div>
    );
}
```

### Estado con strings y booleans

```tsx
function Toggle() {
    const [activo, setActivo] = useState(false);
    const [mensaje, setMensaje] = useState("Escribe algo...");

    return (
        <div>
            <button onClick={() => setActivo(!activo)}>
                {activo ? "Desactivar" : "Activar"}
            </button>
            <input
                value={mensaje}
                onChange={(e) => setMensaje(e.target.value)}
            />
            <p>{mensaje}</p>
        </div>
    );
}
```

### Estado con objetos — SIEMPRE copiar con spread

```tsx
interface Formulario {
    nombre: string;
    email: string;
    activo: boolean;
}

function FormularioUsuario() {
    const [form, setForm] = useState<Formulario>({
        nombre: "",
        email: "",
        activo: true
    });

    // Actualizar UNA propiedad sin perder las demás
    const handleChange = (campo: keyof Formulario, valor: string | boolean) => {
        setForm({ ...form, [campo]: valor });
    };

    return (
        <form>
            <input
                value={form.nombre}
                onChange={(e) => handleChange("nombre", e.target.value)}
                placeholder="Nombre"
            />
            <input
                value={form.email}
                onChange={(e) => handleChange("email", e.target.value)}
                placeholder="Email"
            />
            <label>
                <input
                    type="checkbox"
                    checked={form.activo}
                    onChange={(e) => handleChange("activo", e.target.checked)}
                />
                Activo
            </label>
        </form>
    );
}
```

### Estado con arrays — NUNCA mutar directamente

```tsx
function ListaTareas() {
    const [tareas, setTareas] = useState<string[]>([]);
    const [nueva, setNueva] = useState("");

    const agregar = () => {
        if (!nueva.trim()) return;
        setTareas([...tareas, nueva]);   // crea array nuevo con el elemento agregado
        setNueva("");
    };

    const eliminar = (indice: number) => {
        setTareas(tareas.filter((_, i) => i !== indice));  // crea array sin ese elemento
    };

    return (
        <div>
            <input value={nueva} onChange={(e) => setNueva(e.target.value)} />
            <button onClick={agregar}>Agregar</button>
            <ul>
                {tareas.map((tarea, i) => (
                    <li key={i}>
                        {tarea}
                        <button onClick={() => eliminar(i)}>X</button>
                    </li>
                ))}
            </ul>
        </div>
    );
}
```

---

## 3. useEffect

`useEffect` permite ejecutar código como efecto de que el componente se montó, actualizó o desmontó. Se usa para fetch de datos, timers, subscripciones, etc.

```tsx
import { useState, useEffect } from "react";

useEffect(() => {
    // código a ejecutar
    return () => {
        // cleanup — se ejecuta cuando el componente se desmonta
    };
}, [/* dependencias */]);
```

### Array de dependencias — el parámetro más importante

```tsx
// Sin segundo argumento — corre en CADA render (casi nunca lo que quieres)
useEffect(() => { console.log("render"); });

// Array vacío [] — corre UNA SOLA VEZ al montar el componente (como componentDidMount)
useEffect(() => {
    console.log("El componente se montó");
    cargarDatos();
}, []);

// Con dependencias — corre cuando alguna dependencia cambia
useEffect(() => {
    console.log("userId cambió:", userId);
    cargarUsuario(userId);
}, [userId]);
```

### Fetch de datos con useEffect

```tsx
interface Usuario {
    id: number;
    name: string;
    email: string;
}

function ListaUsuarios() {
    const [usuarios, setUsuarios] = useState<Usuario[]>([]);
    const [cargando, setCargando] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        async function cargar() {
            try {
                const res = await fetch("https://jsonplaceholder.typicode.com/users");
                if (!res.ok) throw new Error(`Error ${res.status}`);
                const data: Usuario[] = await res.json();
                setUsuarios(data);
            } catch (err) {
                setError("No se pudieron cargar los usuarios");
            } finally {
                setCargando(false);
            }
        }

        cargar();
    }, []);  // [] = solo al montar

    if (cargando) return <p>Cargando...</p>;
    if (error)    return <p className="error">{error}</p>;

    return (
        <ul>
            {usuarios.map(u => (
                <li key={u.id}>{u.name} — {u.email}</li>
            ))}
        </ul>
    );
}
```

### useEffect con cleanup

```tsx
function Temporizador() {
    const [segundos, setSegundos] = useState(0);

    useEffect(() => {
        const interval = setInterval(() => {
            setSegundos(s => s + 1);  // forma funcional del setState
        }, 1000);

        // Cleanup: limpiar el interval cuando el componente se desmonta
        return () => clearInterval(interval);
    }, []);

    return <p>Han pasado {segundos} segundos</p>;
}
```

---

## 4. Flujo de datos — regla de oro

```
Props → de padre a hijo (solo hacia abajo)
Eventos → de hijo a padre (llaman una función que el padre pasó como prop)
```

```tsx
// Padre tiene el estado
function Padre() {
    const [items, setItems] = useState<string[]>([]);

    const agregarItem = (nuevoItem: string) => {
        setItems([...items, nuevoItem]);
    };

    return (
        <div>
            {/* Pasa datos hacia abajo (props) */}
            <Lista items={items} />
            {/* Pasa función hacia abajo para que el hijo pueda "subir" datos */}
            <Formulario onAgregar={agregarItem} />
        </div>
    );
}

// Hijo llama a la función del padre para comunicar cambios
function Formulario({ onAgregar }: { onAgregar: (item: string) => void }) {
    const [texto, setTexto] = useState("");

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        if (texto.trim()) {
            onAgregar(texto);  // "sube" el dato al padre
            setTexto("");
        }
    };

    return (
        <form onSubmit={handleSubmit}>
            <input value={texto} onChange={(e) => setTexto(e.target.value)} />
            <button type="submit">Agregar</button>
        </form>
    );
}
```

---

## Resumen

| Hook | Para qué |
|------|---------|
| `useState(valor)` | Estado local del componente |
| `useEffect(() => {}, [])` | Ejecutar código al montar |
| `useEffect(() => {}, [dep])` | Ejecutar cuando `dep` cambia |
| `useEffect(() => { return () => {} }, [])` | Con cleanup al desmontar |

---

Cuando termines: `vault/03_Practicas/semana-07.md`
