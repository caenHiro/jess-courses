---
semana: 8
tema: React práctico — formularios, listas y patrones comunes
estado: pendiente
---

# Semana 8 — React práctico

> Tiempo estimado: 6–8 horas
> Al terminar: `bash scripts/push.sh "semana-08 react practico"`

---

## Objetivo

Al terminar debes poder:
- Construir formularios controlados completos
- Manejar listas con agregar, editar y eliminar
- Implementar búsqueda y filtros
- Aplicar los patrones de componentes que se usan en equipos reales

---

## 1. Formularios controlados

Un formulario controlado es aquel donde React controla el valor de cada campo mediante estado.

```tsx
interface FormRegistro {
    nombre: string;
    email: string;
    password: string;
    rol: string;
}

function FormularioRegistro() {
    const [form, setForm] = useState<FormRegistro>({
        nombre: "", email: "", password: "", rol: "usuario"
    });
    const [errores, setErrores] = useState<Partial<FormRegistro>>({});

    const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { name, value } = e.target;
        setForm(prev => ({ ...prev, [name]: value }));
        // Limpiar error cuando el usuario corrige
        if (errores[name as keyof FormRegistro]) {
            setErrores(prev => ({ ...prev, [name]: "" }));
        }
    };

    const validar = (): boolean => {
        const nuevosErrores: Partial<FormRegistro> = {};
        if (!form.nombre.trim())  nuevosErrores.nombre   = "El nombre es requerido";
        if (!form.email.includes("@")) nuevosErrores.email = "Email inválido";
        if (form.password.length < 8) nuevosErrores.password = "Mínimo 8 caracteres";
        setErrores(nuevosErrores);
        return Object.keys(nuevosErrores).length === 0;
    };

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        if (!validar()) return;
        console.log("Formulario válido:", form);
    };

    return (
        <form onSubmit={handleSubmit}>
            <div>
                <label>Nombre</label>
                <input name="nombre" value={form.nombre} onChange={handleChange} />
                {errores.nombre && <span className="error">{errores.nombre}</span>}
            </div>
            <div>
                <label>Email</label>
                <input name="email" type="email" value={form.email} onChange={handleChange} />
                {errores.email && <span className="error">{errores.email}</span>}
            </div>
            <div>
                <label>Password</label>
                <input name="password" type="password" value={form.password} onChange={handleChange} />
                {errores.password && <span className="error">{errores.password}</span>}
            </div>
            <div>
                <label>Rol</label>
                <select name="rol" value={form.rol} onChange={handleChange}>
                    <option value="usuario">Usuario</option>
                    <option value="admin">Admin</option>
                    <option value="editor">Editor</option>
                </select>
            </div>
            <button type="submit">Registrar</button>
        </form>
    );
}
```

---

## 2. CRUD completo — lista con agregar, editar y eliminar

```tsx
interface Tarea {
    id: number;
    texto: string;
    completada: boolean;
}

function GestorTareas() {
    const [tareas, setTareas] = useState<Tarea[]>([]);
    const [nuevaTarea, setNuevaTarea] = useState("");
    const [editandoId, setEditandoId] = useState<number | null>(null);
    const [textoEdicion, setTextoEdicion] = useState("");

    const agregar = () => {
        if (!nuevaTarea.trim()) return;
        setTareas(prev => [
            ...prev,
            { id: Date.now(), texto: nuevaTarea.trim(), completada: false }
        ]);
        setNuevaTarea("");
    };

    const toggleCompletada = (id: number) => {
        setTareas(prev =>
            prev.map(t => t.id === id ? { ...t, completada: !t.completada } : t)
        );
    };

    const eliminar = (id: number) => {
        setTareas(prev => prev.filter(t => t.id !== id));
    };

    const iniciarEdicion = (tarea: Tarea) => {
        setEditandoId(tarea.id);
        setTextoEdicion(tarea.texto);
    };

    const guardarEdicion = () => {
        if (!textoEdicion.trim()) return;
        setTareas(prev =>
            prev.map(t => t.id === editandoId ? { ...t, texto: textoEdicion } : t)
        );
        setEditandoId(null);
    };

    return (
        <div>
            <div>
                <input
                    value={nuevaTarea}
                    onChange={(e) => setNuevaTarea(e.target.value)}
                    onKeyDown={(e) => e.key === "Enter" && agregar()}
                    placeholder="Nueva tarea..."
                />
                <button onClick={agregar}>Agregar</button>
            </div>

            <ul>
                {tareas.map(tarea => (
                    <li key={tarea.id}>
                        {editandoId === tarea.id ? (
                            <>
                                <input
                                    value={textoEdicion}
                                    onChange={(e) => setTextoEdicion(e.target.value)}
                                    autoFocus
                                />
                                <button onClick={guardarEdicion}>Guardar</button>
                                <button onClick={() => setEditandoId(null)}>Cancelar</button>
                            </>
                        ) : (
                            <>
                                <input
                                    type="checkbox"
                                    checked={tarea.completada}
                                    onChange={() => toggleCompletada(tarea.id)}
                                />
                                <span style={{ textDecoration: tarea.completada ? "line-through" : "none" }}>
                                    {tarea.texto}
                                </span>
                                <button onClick={() => iniciarEdicion(tarea)}>Editar</button>
                                <button onClick={() => eliminar(tarea.id)}>Eliminar</button>
                            </>
                        )}
                    </li>
                ))}
            </ul>

            <p>{tareas.filter(t => t.completada).length}/{tareas.length} completadas</p>
        </div>
    );
}
```

---

## 3. Búsqueda y filtros

```tsx
interface Empleado {
    id: number;
    nombre: string;
    departamento: string;
    activo: boolean;
}

function TablaEmpleados({ empleados }: { empleados: Empleado[] }) {
    const [busqueda, setBusqueda] = useState("");
    const [filtroDepto, setFiltroDepto] = useState("todos");
    const [soloActivos, setSoloActivos] = useState(false);

    // Calcular la lista filtrada — se recalcula en cada render
    const empleadosFiltrados = empleados
        .filter(e => e.nombre.toLowerCase().includes(busqueda.toLowerCase()))
        .filter(e => filtroDepto === "todos" || e.departamento === filtroDepto)
        .filter(e => !soloActivos || e.activo);

    const departamentos = [...new Set(empleados.map(e => e.departamento))];

    return (
        <div>
            <input
                placeholder="Buscar por nombre..."
                value={busqueda}
                onChange={(e) => setBusqueda(e.target.value)}
            />
            <select value={filtroDepto} onChange={(e) => setFiltroDepto(e.target.value)}>
                <option value="todos">Todos los departamentos</option>
                {departamentos.map(d => (
                    <option key={d} value={d}>{d}</option>
                ))}
            </select>
            <label>
                <input
                    type="checkbox"
                    checked={soloActivos}
                    onChange={(e) => setSoloActivos(e.target.checked)}
                />
                Solo activos
            </label>

            <p>{empleadosFiltrados.length} empleados</p>
            <table>
                <thead>
                    <tr><th>Nombre</th><th>Departamento</th><th>Estado</th></tr>
                </thead>
                <tbody>
                    {empleadosFiltrados.map(e => (
                        <tr key={e.id}>
                            <td>{e.nombre}</td>
                            <td>{e.departamento}</td>
                            <td>{e.activo ? "Activo" : "Inactivo"}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}
```

---

## 4. Componente de carga y error reutilizable

```tsx
// Componente genérico para estados de carga/error
function EstadoCarga({ cargando, error, children }: {
    cargando: boolean;
    error: string | null;
    children: React.ReactNode;
}) {
    if (cargando) return <div className="spinner">Cargando...</div>;
    if (error)    return <div className="error-msg">{error}</div>;
    return <>{children}</>;
}

// Uso
function MiPagina() {
    const [datos, setDatos] = useState(null);
    const [cargando, setCargando] = useState(true);
    const [error, setError] = useState(null);

    return (
        <EstadoCarga cargando={cargando} error={error}>
            {/* Solo se renderiza si no está cargando y no hay error */}
            <div>{/* contenido */}</div>
        </EstadoCarga>
    );
}
```

---

## Patrones clave de esta semana

| Patrón | Uso |
|--------|-----|
| `e.target.name` + `[name]` | Manejar múltiples inputs con un solo handler |
| `prev => prev.map(...)` | Actualizar un item en un array de estado |
| `prev => prev.filter(...)` | Eliminar un item del array de estado |
| `[...prev, nuevo]` | Agregar al final del array |
| Derivar datos del estado | Filtrar/buscar sin estado extra |

---

Cuando termines: `vault/03_Practicas/semana-08.md`
