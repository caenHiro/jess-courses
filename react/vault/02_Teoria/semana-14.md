---
semana: 14
tema: Tailwind CSS — estilos sin salir del HTML
estado: pendiente
---

# Semana 14 — Tailwind CSS

> Tiempo estimado: 5–6 horas  
> Al terminar: `bash scripts/push.sh "semana-14 tailwind-css"`

---

## Objetivo

Al terminar debes poder:
- Instalar y configurar Tailwind CSS en un proyecto Vite + React
- Aplicar estilos con clases utilitarias directamente en JSX
- Usar el sistema de espaciado, colores y tipografía de Tailwind
- Crear layouts responsivos con Flexbox y Grid de Tailwind
- Implementar dark mode
- Extraer clases repetidas con `@apply`

---

## 1. ¿Qué es Tailwind CSS?

CSS tradicional: escribes clases semánticas y luego defines los estilos en otro archivo.

```css
/* styles.css */
.boton-primario {
    background-color: blue;
    color: white;
    padding: 8px 16px;
    border-radius: 4px;
}
```

```jsx
<button className="boton-primario">Guardar</button>
```

Tailwind CSS: los estilos van directamente como clases utilitarias en el HTML/JSX.

```jsx
<button className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
    Guardar
</button>
```

Cada clase hace **una sola cosa**. Se compone todo en el HTML.

Ventajas:
- No inventas nombres de clases
- No cambia entre archivos para estilizar
- El CSS final solo incluye las clases que usaste (tree-shaking automático)
- Consistencia visual: los valores vienen de una escala predefinida

---

## 2. Instalación con Vite + React

```bash
npm install -D tailwindcss @tailwindcss/vite
```

```typescript
// vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
    plugins: [
        react(),
        tailwindcss(),
    ],
})
```

```css
/* src/index.css — solo esta línea */
@import "tailwindcss";
```

```tsx
// src/main.tsx
import "./index.css"  // asegúrate de importarlo
```

---

## 3. Sistema de espaciado

Tailwind usa una escala numérica. `1` = 4px.

| Clase | Valor | Qué hace |
|---|---|---|
| `p-0` | 0px | padding en todos lados |
| `p-1` | 4px | padding en todos lados |
| `p-2` | 8px | padding en todos lados |
| `p-4` | 16px | padding en todos lados |
| `p-8` | 32px | padding en todos lados |
| `px-4` | 16px | padding horizontal (left + right) |
| `py-2` | 8px | padding vertical (top + bottom) |
| `pt-4` | 16px | padding top |
| `m-4` | 16px | margin en todos lados |
| `mx-auto` | auto | margin horizontal centrado |
| `gap-4` | 16px | espacio entre hijos (flex/grid) |

```jsx
<div className="p-4 mx-auto mt-8 mb-2">
    <p className="px-6 py-3">Texto con padding</p>
</div>
```

---

## 4. Colores

Tailwind tiene una paleta de colores con 11 niveles de intensidad (50 = muy claro, 900 = muy oscuro).

```
bg-{color}-{intensidad}   → background
text-{color}-{intensidad} → color de texto
border-{color}-{intensidad} → color de borde
```

Colores disponibles: `slate`, `gray`, `zinc`, `red`, `orange`, `amber`, `yellow`, `lime`, `green`, `emerald`, `teal`, `cyan`, `sky`, `blue`, `indigo`, `violet`, `purple`, `fuchsia`, `pink`, `rose`.

```jsx
<div className="bg-blue-500 text-white">Azul</div>
<div className="bg-red-100 text-red-800">Error suave</div>
<div className="bg-green-50 text-green-700 border border-green-200">Éxito</div>
```

---

## 5. Tipografía

```jsx
<h1 className="text-3xl font-bold text-gray-900">Título</h1>
<h2 className="text-xl font-semibold text-gray-800">Subtítulo</h2>
<p  className="text-base text-gray-600 leading-relaxed">Párrafo normal</p>
<p  className="text-sm text-gray-500">Texto pequeño secundario</p>
<p  className="text-xs font-mono text-gray-400">Monoespaciado</p>
```

| Clase | Tamaño |
|---|---|
| `text-xs` | 12px |
| `text-sm` | 14px |
| `text-base` | 16px |
| `text-lg` | 18px |
| `text-xl` | 20px |
| `text-2xl` | 24px |
| `text-3xl` | 30px |
| `font-normal` | 400 |
| `font-medium` | 500 |
| `font-semibold` | 600 |
| `font-bold` | 700 |

---

## 6. Flexbox

```jsx
{/* Fila centrada */}
<div className="flex items-center justify-between gap-4">
    <span>Izquierda</span>
    <span>Derecha</span>
</div>

{/* Columna */}
<div className="flex flex-col gap-2">
    <div>Arriba</div>
    <div>Abajo</div>
</div>

{/* Wrap — si no caben en una fila, van a la siguiente */}
<div className="flex flex-wrap gap-2">
    {items.map(i => <span key={i}>{i}</span>)}
</div>
```

| Clase | CSS equivalente |
|---|---|
| `flex` | display: flex |
| `flex-col` | flex-direction: column |
| `flex-wrap` | flex-wrap: wrap |
| `items-center` | align-items: center |
| `items-start` | align-items: flex-start |
| `justify-center` | justify-content: center |
| `justify-between` | justify-content: space-between |
| `flex-1` | flex: 1 (ocupa el espacio disponible) |
| `shrink-0` | flex-shrink: 0 (no se achica) |

---

## 7. Grid

```jsx
{/* Grid de 3 columnas iguales */}
<div className="grid grid-cols-3 gap-4">
    <div>Col 1</div>
    <div>Col 2</div>
    <div>Col 3</div>
</div>

{/* Grid responsivo: 1 col en móvil, 2 en tablet, 3 en desktop */}
<div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
    {cards.map(c => <Card key={c.id} {...c} />)}
</div>
```

---

## 8. Responsivo (breakpoints)

En Tailwind, los breakpoints se aplican como prefijos:

| Prefijo | Mínimo | Dispositivo |
|---|---|---|
| (ninguno) | 0px | Móvil (mobile-first) |
| `sm:` | 640px | Tablet pequeña |
| `md:` | 768px | Tablet |
| `lg:` | 1024px | Desktop |
| `xl:` | 1280px | Desktop grande |

Mobile-first: la clase sin prefijo aplica a todos los tamaños, y los prefijos sobreescriben desde ese tamaño hacia arriba.

```jsx
<div className="text-sm md:text-base lg:text-lg">
    Texto que crece con la pantalla
</div>

<div className="hidden md:block">
    Solo visible en tablet y desktop
</div>

<div className="block md:hidden">
    Solo visible en móvil
</div>
```

---

## 9. Estados (hover, focus, active)

```jsx
<button className="bg-blue-500 hover:bg-blue-600 active:bg-blue-700 text-white px-4 py-2 rounded transition-colors">
    Botón
</button>

<input className="border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 focus:outline-none px-3 py-2 rounded" />
```

---

## 10. Dark mode

```tsx
// tailwind.config.ts — activar dark mode por clase
/** @type {import('tailwindcss').Config} */
export default {
    darkMode: 'class',  // se activa con la clase "dark" en <html>
    // ...
}
```

```jsx
// Componente con dark mode
<div className="bg-white dark:bg-gray-900 text-gray-900 dark:text-white p-4">
    <p className="text-gray-600 dark:text-gray-300">Texto adaptable</p>
</div>
```

```tsx
// Toggle dark mode
function ToggleDark() {
    const [dark, setDark] = useState(false);
    const toggle = () => {
        setDark(!dark);
        document.documentElement.classList.toggle('dark');
    };
    return <button onClick={toggle}>{dark ? "Modo claro" : "Modo oscuro"}</button>;
}
```

---

## 11. Extraer componentes con @apply

Cuando repites muchas clases, puedes extraerlas a CSS:

```css
/* src/index.css */
@import "tailwindcss";

@layer components {
    .btn {
        @apply px-4 py-2 rounded font-medium transition-colors;
    }
    .btn-primary {
        @apply btn bg-blue-500 text-white hover:bg-blue-600;
    }
    .btn-secondary {
        @apply btn bg-gray-100 text-gray-700 hover:bg-gray-200;
    }
    .card {
        @apply bg-white rounded-lg shadow-sm border border-gray-200 p-4;
    }
}
```

```jsx
<button className="btn-primary">Guardar</button>
<button className="btn-secondary">Cancelar</button>
<div className="card">Contenido de la tarjeta</div>
```

---

## 12. Componente completo de ejemplo

```tsx
interface EmployeeCardProps {
    nombre: string;
    email: string;
    departamento: string;
    activo: boolean;
    avatar?: string;
}

function EmployeeCard({ nombre, email, departamento, activo, avatar }: EmployeeCardProps) {
    return (
        <div className="bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 p-5 shadow-sm hover:shadow-md transition-shadow">
            {/* Cabecera */}
            <div className="flex items-center gap-3 mb-4">
                <div className="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center text-blue-700 font-bold shrink-0">
                    {nombre[0]}
                </div>
                <div className="min-w-0">
                    <p className="font-semibold text-gray-900 dark:text-white truncate">{nombre}</p>
                    <p className="text-sm text-gray-500 dark:text-gray-400 truncate">{email}</p>
                </div>
            </div>

            {/* Departamento y estado */}
            <div className="flex items-center justify-between">
                <span className="text-xs font-medium text-gray-500 dark:text-gray-400">
                    {departamento}
                </span>
                <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${
                    activo
                        ? "bg-green-100 text-green-700"
                        : "bg-red-100 text-red-700"
                }`}>
                    {activo ? "Activo" : "Inactivo"}
                </span>
            </div>
        </div>
    );
}
```

---

## 13. Tailwind en el contexto del INE

En el INE verás Tailwind mezclado con componentes de librerías como Ant Design o Material-UI. Es común usar Tailwind para layout y espaciado, y la librería de componentes para elementos complejos (tablas, selects, datepickers).

Regla práctica: si la librería de componentes no controla ese estilo, usa Tailwind. Si lo controla, usa las props de la librería.

---

## Resumen de la semana

```
Tailwind CSS = clases utilitarias que aplicas directamente en JSX

Chuleta rápida:
- Espaciado: p-4 (padding), m-4 (margin), gap-4 (espacio entre hijos)
- Colores: bg-blue-500, text-gray-700, border-red-300
- Texto: text-lg, font-bold, leading-relaxed
- Layout: flex, grid, grid-cols-3, items-center, justify-between
- Responsivo: sm:text-lg md:grid-cols-2 lg:grid-cols-3
- Estados: hover:bg-blue-600 focus:ring-2 active:scale-95
- Dark: dark:bg-gray-900 dark:text-white
```
