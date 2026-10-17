---
semana: 14
tema: Tailwind CSS — práctica
estado: pendiente
---

# Semana 14 — Práctica Tailwind CSS

> Al terminar: `bash scripts/push.sh "semana-14 tailwind-practicas"`

---

## Ejercicio 1 — Página de perfil (2 horas)

Crea un componente `PerfilUsuario` con Tailwind CSS que muestre:

### Estructura visual requerida

```
┌──────────────────────────────────────┐
│  [Avatar 80px]  Nombre completo       │
│                 @username · Activo    │
│                 email@ejemplo.com     │
├──────────────────────────────────────┤
│  Bio: Texto de descripción del usuario│
├──────────────────────────────────────┤
│  Departamento │ Fecha ingreso │ Rol   │
├──────────────────────────────────────┤
│  [Editar perfil]    [Ver actividad]  │
└──────────────────────────────────────┘
```

### Criterios Tailwind
- [ ] La tarjeta tiene sombra y bordes redondeados
- [ ] El avatar usa las iniciales del nombre en un círculo con color
- [ ] El badge "Activo/Inactivo" cambia de color según el estado
- [ ] Los botones tienen hover state visible
- [ ] En pantallas pequeñas, la cabecera se apila en columna (flex-col en móvil, flex-row en md)

---

## Ejercicio 2 — Grid de cards responsivo (1.5 horas)

Crea `ListaEmpleados` que muestre 6 tarjetas en un grid:
- Móvil: 1 columna
- Tablet (sm): 2 columnas  
- Desktop (lg): 3 columnas

Cada card debe tener:
- Avatar con inicial
- Nombre y email
- Departamento y rol
- Badge de estado activo/inactivo

Agrega un campo de búsqueda encima del grid que filtre por nombre (en React con `useState`).

---

## Ejercicio 3 — Formulario completo (1.5 horas)

Crea un formulario de "Crear empleado" con Tailwind:

Campos:
- Nombre (text) — requerido
- Email (email) — requerido
- Departamento (select)
- Rol (select)
- Fecha de ingreso (date)
- Activo (checkbox)
- Notas (textarea)

Estilos requeridos:
- Labels en gris, tamaño small, uppercase
- Inputs con borde gris, focus con borde azul y ring azul suave
- Select estilizado con Tailwind
- Botones: "Guardar" azul, "Cancelar" gris
- Al hacer submit sin llenar campos requeridos, mostrar mensaje de error en rojo

---

## Ejercicio 4 — Dark mode toggle (30 minutos)

Agrega un toggle de dark mode a la página del Ejercicio 2:
- Botón en el header "Modo oscuro / Modo claro"
- Al activarlo, cambia la clase `dark` en el `<html>`
- Todos los componentes deben tener sus variantes `dark:` definidas
- El estado persiste en `localStorage`

```typescript
// Pista
useEffect(() => {
    const guardado = localStorage.getItem('dark-mode');
    if (guardado === 'true') {
        document.documentElement.classList.add('dark');
    }
}, []);
```

---

## Bonus — Integrar Redux + Tailwind + TypeScript

Combina lo de las últimas 3 semanas:
- El formulario del Ejercicio 3 dispara una acción Redux al guardar
- La lista del Ejercicio 2 lee del store de Redux
- Todo tipado con TypeScript
- Todo estilizado con Tailwind

Esta es exactamente la combinación que vas a encontrar en el INE.
