---
semana: 6
tema: React fundamentos — JSX, componentes y props
estado: pendiente
---

# Practica — Semana 6: React fundamentos

> Crea el proyecto: `npm create vite@latest semana-06 -- --template react-ts && cd semana-06 && npm install && npm run dev`
> Guarda en: `codigo/semana-06/src/`
> Al terminar: `bash scripts/push.sh "semana-06 react fundamentos"`

---

## Ejercicio 1 — Componentes de layout (obligatorio)

En `src/components/layout/` crea:

**`Encabezado.tsx`** — recibe como props: `titulo: string`, `subtitulo?: string`
- Muestra el título en `<h1>` y el subtitulo en `<p>` (solo si existe)

**`PiePagina.tsx`** — sin props
- Muestra "© 2026 Portal INE — Todos los derechos reservados"

**`Layout.tsx`** — recibe `children: React.ReactNode`
- Envuelve con `<Encabezado>` arriba y `<PiePagina>` abajo
- En el medio renderiza `{children}`

Usa `Layout` en `App.tsx` con algún contenido.

**Tu solucion:**

---

## Ejercicio 2 — Tarjeta de empleado (obligatorio)

Crea `src/components/TarjetaEmpleado.tsx`.

Props requeridas: `nombre`, `email`, `puesto`, `departamento`, `activo: boolean`
Props opcionales: `avatar?: string`, `telefono?: string`

La tarjeta debe mostrar:
- Iniciales del nombre como avatar circular (si no hay foto) — "Ana García" → "AG"
- Nombre y puesto
- Badge verde "Activo" o rojo "Inactivo"
- Email (siempre) y teléfono (solo si existe)
- Departamento en gris pequeño

En `App.tsx` muestra 4 tarjetas con datos distintos, al menos una inactiva y una sin teléfono.

**Tu solucion:**

---

## Ejercicio 3 — Lista de empleados desde array (obligatorio)

Crea `src/pages/Empleados.tsx`.

Define un array de 8 empleados directamente en el componente (no hace falta fetch aún).
Cada empleado: `{ id, nombre, email, puesto, departamento, activo }`.

Muestra:
- Contador: "8 empleados — 6 activos"
- La lista usando `TarjetaEmpleado` con `map`
- Solo los activos (filter antes del map)
- Botón "Mostrar todos" / "Solo activos" que alterne entre ambas vistas

Usa `useState` para el toggle.

**Tu solucion:**

---

## Ejercicio 4 — Componente Badge reutilizable (obligatorio)

Crea `src/components/ui/Badge.tsx`.

Props: `texto: string`, `tipo: "exito" | "error" | "advertencia" | "info" | "neutro"`

Cada tipo tiene un color de fondo diferente. Sin CSS externo — usa el prop `style` directamente o define los colores en un objeto dentro del componente.

Úsalo en la `TarjetaEmpleado` para el estado activo/inactivo y en donde más tenga sentido.

**Tu solucion:**

---

## Ejercicio 5 — Reto: Componente de tabla (opcional)

Crea `src/components/ui/TablaGenerica.tsx`.

Un componente que recibe:
- `columnas: { clave: string; titulo: string }[]`
- `datos: Record<string, any>[]`

Y renderiza una tabla HTML con esas columnas y datos sin conocer de antemano qué campos son.

Pruébala pasando los empleados y columnas como: `[{ clave: "nombre", titulo: "Nombre" }, { clave: "email", titulo: "Email" }, ...]`

**Tu solucion:**

---

## Checklist antes de subir

- [ ] `Layout` envuelve `App` correctamente
- [ ] Las iniciales del avatar se calculan bien (dos palabras → dos letras)
- [ ] `key` en todos los `.map()` usando el `id`
- [ ] El toggle activos/todos funciona
- [ ] `npm run build` no muestra errores de TypeScript
- [ ] Subi con `bash scripts/push.sh`
