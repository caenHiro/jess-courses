---
semana: 12
tema: Proyecto final — App de gestión de empleados
estado: pendiente
---

# Semana 12 — Proyecto final

> Tiempo estimado: 10–15 horas
> Al terminar: `bash scripts/push.sh "semana-12 proyecto-final COMPLETO"`

---

## El proyecto

Vas a construir una **app de gestión de empleados** que use todo lo aprendido en el curso:
- Autenticación (login/logout)
- Lista de empleados con búsqueda y filtros
- Detalle de empleado
- Formulario para crear y editar
- Protección de rutas
- Integración con una API (JSONPlaceholder como simulación)

---

## Funcionalidades requeridas

### Autenticación
- [ ] Pantalla de login con validación
- [ ] Token almacenado en localStorage
- [ ] Logout que limpia el token
- [ ] Ruta protegida — si no está logueado, redirige a login

### Lista de empleados
- [ ] Tabla con nombre, email, departamento, estado
- [ ] Búsqueda por nombre en tiempo real (con debounce)
- [ ] Filtro por departamento
- [ ] Filtro activos/inactivos
- [ ] Paginación o carga de más
- [ ] Botones de editar y eliminar con confirmación

### Detalle de empleado
- [ ] Página `/empleados/:id` con todos los datos
- [ ] Botón de volver a la lista
- [ ] Botón de editar que lleva al formulario

### Crear / Editar empleado
- [ ] Formulario con validación
- [ ] El mismo formulario sirve para crear y para editar (modo dual)
- [ ] Al guardar, vuelve a la lista y muestra mensaje de éxito

### Extras (opcionales)
- [ ] Modo oscuro con contexto
- [ ] Toast notifications al guardar/eliminar
- [ ] Loading skeleton en lugar de "Cargando..."

---

## Estructura de archivos sugerida

```
src/
├── api/
│   ├── cliente.ts         # instancia axios + interceptors
│   ├── authService.ts     # login, logout
│   └── empleadosService.ts  # CRUD empleados
├── context/
│   └── AuthContext.tsx    # usuario global, login, logout
├── hooks/
│   ├── useFetch.ts
│   ├── useEmpleados.ts
│   └── useForm.ts
├── pages/
│   ├── Login.tsx
│   └── Empleados/
│       ├── EmpleadosLista.tsx
│       ├── EmpleadoDetalle.tsx
│       └── EmpleadoFormulario.tsx
├── components/
│   ├── layout/
│   │   ├── Layout.tsx
│   │   └── RutaProtegida.tsx
│   └── ui/
│       ├── Boton.tsx
│       ├── Input.tsx
│       ├── Tarjeta.tsx
│       └── Toast.tsx
├── types/
│   └── index.ts           # todas las interfaces en un lugar
├── App.tsx
└── main.tsx
```

---

## Datos de prueba (mock)

Simula el backend con este arreglo. Guárdalo en `src/data/empleadosMock.ts`:

```typescript
export interface Empleado {
    id: number;
    nombre: string;
    email: string;
    departamento: "Frontend" | "Backend" | "Diseño" | "QA" | "Infraestructura";
    puesto: string;
    activo: boolean;
    fechaIngreso: string;
    salario: number;
    avatar?: string;
}

export const empleadosMock: Empleado[] = [
    { id: 1, nombre: "Ana García",    email: "ana@empresa.mx",   departamento: "Frontend",       puesto: "Senior Dev",  activo: true,  fechaIngreso: "2021-03-15", salario: 45000 },
    { id: 2, nombre: "Luis Martínez", email: "luis@empresa.mx",  departamento: "Backend",        puesto: "Tech Lead",   activo: true,  fechaIngreso: "2020-01-08", salario: 55000 },
    { id: 3, nombre: "Jessica López", email: "jess@empresa.mx",  departamento: "Frontend",       puesto: "Junior Dev",  activo: true,  fechaIngreso: "2026-09-16", salario: 25000 },
    { id: 4, nombre: "Pedro Soto",    email: "pedro@empresa.mx", departamento: "QA",             puesto: "QA Engineer", activo: false, fechaIngreso: "2019-07-20", salario: 35000 },
    { id: 5, nombre: "María Reyes",   email: "maria@empresa.mx", departamento: "Diseño",         puesto: "UX Designer", activo: true,  fechaIngreso: "2022-11-01", salario: 40000 },
    { id: 6, nombre: "Carlos Ruiz",   email: "carlos@empresa.mx",departamento: "Infraestructura",puesto: "DevOps",      activo: true,  fechaIngreso: "2021-05-10", salario: 50000 },
    { id: 7, nombre: "Sofia Vega",    email: "sofia@empresa.mx", departamento: "Backend",        puesto: "Mid Dev",     activo: true,  fechaIngreso: "2023-02-28", salario: 38000 },
    { id: 8, nombre: "Diego Mora",    email: "diego@empresa.mx", departamento: "Frontend",       puesto: "Mid Dev",     activo: false, fechaIngreso: "2022-08-15", salario: 32000 }
];
```

---

## Entregables mínimos

Para considerar el proyecto completo necesitas:

1. **Login funcional** — ingresa con cualquier usuario/contraseña, guarda un token simulado
2. **Lista con filtros** — busqueda, filtro por departamento, filtro activos
3. **Detalle** — al hacer clic en un empleado, va a `/empleados/:id` con sus datos
4. **Crear** — formulario con validación que agrega a la lista
5. **Editar** — el mismo formulario pre-cargado con los datos actuales
6. **Eliminar** — con confirmación antes de borrar
7. **Ruta protegida** — si borras el token y recargas, redirige al login

---

## Criterios de código limpio

- Cada componente en su propio archivo
- Los servicios de API separados de los componentes
- No hay `console.log` en el código final
- No hay variables sin usar
- Los tipos TypeScript están definidos (no usar `any`)
- El código corre sin errores en consola

---

## Mensaje al terminar

Cuando termines el proyecto sube con:
```bash
bash scripts/push.sh "PROYECTO FINAL COMPLETADO - semana-12"
```

Y escribe en `vault/04_Notas_Personales/reflexion-final.md` qué fue lo más difícil y qué aprendiste.
