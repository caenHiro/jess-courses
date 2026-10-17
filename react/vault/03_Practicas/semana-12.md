---
semana: 12
tema: Proyecto final
estado: pendiente
---

# Practica — Semana 12: Proyecto final

> Lee primero: `vault/02_Teoria/semana-12.md`
> Crea el proyecto: `npm create vite@latest proyecto-final -- --template react-ts`
> Al terminar: `bash scripts/push.sh "PROYECTO FINAL COMPLETADO"`

---

## El proyecto

Construye la **App de Gestión de Empleados** descrita en la teoría.

Esta es la lista completa de lo que debe funcionar:

---

## Entregable 1 — Autenticación

- [ ] Pantalla de login con campos usuario y contraseña
- [ ] Validación básica (ambos campos requeridos)
- [ ] Login simulado: cualquier usuario con contraseña `"admin123"` funciona
- [ ] Token guardado en localStorage
- [ ] Botón logout en el header que limpia el token y redirige al login

**Tu solucion:**

---

## Entregable 2 — Lista de empleados

- [ ] Tabla con: nombre, departamento, puesto, salario (formateado), estado (badge)
- [ ] Búsqueda por nombre con debounce
- [ ] Filtro por departamento
- [ ] Filtro solo activos
- [ ] Botón "Nuevo empleado" → va a `/empleados/nuevo`
- [ ] Clic en nombre → va a `/empleados/:id`
- [ ] Botón eliminar con confirmación

**Tu solucion:**

---

## Entregable 3 — Detalle de empleado

- [ ] URL: `/empleados/:id`
- [ ] Muestra todos los datos del empleado
- [ ] Botón "Editar" → va a `/empleados/:id/editar`
- [ ] Botón "Volver" → regresa a la lista

**Tu solucion:**

---

## Entregable 4 — Formulario crear/editar

- [ ] URL: `/empleados/nuevo` y `/empleados/:id/editar`
- [ ] Detecta si es nuevo o edición según la URL
- [ ] En edición pre-carga los datos del empleado
- [ ] Validación: nombre requerido, email válido, salario positivo
- [ ] Al guardar: regresa a la lista y muestra toast de éxito
- [ ] Botón cancelar que regresa sin guardar

**Tu solucion:**

---

## Entregable 5 — Calidad de código

- [ ] No hay `any` en TypeScript
- [ ] No hay `console.log` en el código final
- [ ] La lógica de API está en servicios separados, no en componentes
- [ ] Los componentes reutilizables están en `src/components/ui/`
- [ ] `npm run build` compila sin errores

**Tu solucion:**

---

## Reflexión final

Cuando termines, escribe en `vault/04_Notas_Personales/reflexion-final.md`:

1. ¿Qué fue lo más difícil del curso?
2. ¿Qué concepto te costó más entender?
3. ¿Qué harías diferente si empezaras de nuevo?
4. ¿Qué quieres aprender después de este curso?

---

## Comando final

```bash
bash scripts/push.sh "PROYECTO FINAL COMPLETADO - Gestion de Empleados - React + TS"
```
