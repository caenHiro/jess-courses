---
semana: 7
tema: React estado — useState y useEffect
estado: pendiente
---

# Practica — Semana 7: useState y useEffect

> Continua en el mismo proyecto de semana-06 o crea uno nuevo
> Al terminar: `bash scripts/push.sh "semana-07 usestate useeffect"`

---

## Ejercicio 1 — Contador mejorado (obligatorio)

Crea `src/components/ContadorMejorado.tsx`.

Un contador que:
- Tiene un valor actual (empieza en 0)
- Botones: +1, -1, +10, -10, Reset
- No puede bajar de 0 ni subir de 100 (el botón se deshabilita en los límites)
- Muestra en color diferente según el valor: rojo (<20), amarillo (20-79), verde (80+)
- Un input numérico para saltar directamente a ese valor (validando que sea 0-100)

**Tu solucion:**

---

## Ejercicio 2 — Formulario controlado de perfil (obligatorio)

Crea `src/pages/EditarPerfil.tsx`.

Formulario con los campos: nombre, apellido, email, teléfono, departamento (select), bio (textarea).

Requisitos:
- Todos los campos son controlados con `useState`
- Al editar, el botón "Guardar" se habilita — al cargar o después de guardar, está deshabilitado
- Al hacer clic en "Guardar", muestra un mensaje de éxito por 3 segundos y el botón vuelve a deshabilitarse
- Botón "Cancelar" que restaura todos los campos a los valores originales
- Contador de caracteres en el bio (máx. 200)

**Tu solucion:**

---

## Ejercicio 3 — Lista con fetch real (obligatorio)

Crea `src/pages/ListaUsuariosAPI.tsx`.

Usa `useEffect` para cargar usuarios de `https://jsonplaceholder.typicode.com/users` al montar.

La página debe tener 3 estados bien implementados:
- **Cargando**: spinner o texto "Cargando usuarios..."
- **Error**: mensaje con botón "Reintentar" que vuelve a llamar la API
- **Datos**: tabla con nombre, email, teléfono y ciudad (user.address.city)

Al hacer clic en una fila, muestra el detalle del usuario en un panel lateral (sin cambiar de página).

**Tu solucion:**

---

## Ejercicio 4 — Temporizador Pomodoro (obligatorio)

Crea `src/components/Pomodoro.tsx`.

Un temporizador que:
- Alterna entre "Trabajo" (25 min) y "Descanso" (5 min)
- Muestra el tiempo en formato MM:SS
- Botones: Iniciar, Pausar, Reiniciar
- Al llegar a 00:00, cambia automáticamente al siguiente modo
- Muestra cuántos ciclos de trabajo se completaron

Usa `useRef` para guardar el interval y `useEffect` con cleanup.

**Tu solucion:**

---

## Ejercicio 5 — Reto: posts con comentarios (opcional)

Crea `src/pages/PostsConComentarios.tsx`.

1. Carga posts de JSONPlaceholder al montar (solo los primeros 10)
2. Al hacer clic en un post, carga sus comentarios: `https://jsonplaceholder.typicode.com/comments?postId=${id}`
3. Mientras carga los comentarios, muestra "Cargando comentarios..." en el panel de detalle
4. Si se hace clic en otro post mientras cargan los comentarios del anterior, cancela la petición anterior (busca `AbortController`)

**Tu solucion:**

---

## Checklist antes de subir

- [ ] Ejercicio 1: los botones se deshabilitan en 0 y 100
- [ ] Ejercicio 2: el botón guardar solo se habilita cuando hay cambios
- [ ] Ejercicio 3: los 3 estados (cargando/error/datos) se ven correctamente
- [ ] Ejercicio 4: el cleanup del interval funciona (no sigue corriendo al desmontar)
- [ ] Subi con `bash scripts/push.sh`
