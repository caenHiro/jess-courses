---
semana: 4
tema: Async JavaScript y APIs REST
estado: pendiente
---

# Practica — Semana 4: Async y APIs

> Guarda en: `codigo/semana-04/`
> Corre con Node: `node ejercicioX.js` (los que no usen DOM)
> Los que usan DOM: abrir `.html` en el navegador
> Al terminar: `bash scripts/push.sh "semana-04 async apis"`

---

## Ejercicio 1 — Tu primera llamada a una API (obligatorio)

Crea `ejercicio1.js`.

Usa `fetch` y `async/await` para:
1. Obtener la lista de usuarios de `https://jsonplaceholder.typicode.com/users`
2. Imprime en consola: nombre, email y ciudad de cada usuario
3. Imprime al final cuántos usuarios hay en total

Maneja el error con `try/catch` — si el fetch falla, imprime un mensaje claro.

```
--- Usuarios ---
1. Leanne Graham | Sincere@april.biz | Gwenborough
2. Ervin Howell | Shanna@melissa.tv | Wisokyburgh
...
Total: 10 usuarios
```

**Tu solucion:**

---

## Ejercicio 2 — Buscar usuario por ID (obligatorio)

Crea `ejercicio2.js`.

Escribe una función `buscarUsuario(id)` que:
1. Llama a `https://jsonplaceholder.typicode.com/users/${id}`
2. Si el usuario existe, muestra: nombre, email, empresa (user.company.name)
3. Si el ID no existe (respuesta vacía o 404), muestra "Usuario no encontrado"

Pruébala con los IDs: 1, 5, 99 (el 99 no existe)

**Tu solucion:**

---

## Ejercicio 3 — Posts de un usuario (obligatorio)

Crea `ejercicio3.js`.

Escribe una función `obtenerPostsDeUsuario(userId)` que:
1. Llame a `https://jsonplaceholder.typicode.com/posts?userId=${userId}` para obtener sus posts
2. Llame a `https://jsonplaceholder.typicode.com/users/${userId}` para obtener su nombre

Haz AMBAS llamadas en PARALELO con `Promise.all` (no en secuencia).

Imprime:
```
Posts de Leanne Graham:
1. sunt aut facere repellat provident...
2. qui est esse...
(y todos sus posts)
Total: 10 posts
```

**Tu solucion:**

---

## Ejercicio 4 — App de búsqueda en el navegador (obligatorio)

Crea `ejercicio4.html`.

Una pequeña app con:
- Input de texto "Buscar usuario por ID (1-10)"
- Botón "Buscar"
- Área de resultado que muestra la tarjeta del usuario encontrado

Mientras busca: mostrar "Buscando..."
Si encuentra: mostrar nombre, email, teléfono, empresa
Si no encuentra: mostrar "Usuario no encontrado"
Si hay error de red: mostrar "Error de conexión, intenta más tarde"

**Tu solucion:**

---

## Ejercicio 5 — Reto: crear un post (opcional)

Crea `ejercicio5.js`.

Escribe una función `crearPost({ titulo, cuerpo, userId })` que:
1. Haga un POST a `https://jsonplaceholder.typicode.com/posts`
2. Con headers `Content-Type: application/json`
3. Con el body en JSON: `{ title, body, userId }`
4. Imprima el post creado con su nuevo ID

JSONPlaceholder lo simula — devuelve el post con `id: 101`.

**Tu solucion:**

---

## Checklist antes de subir

- [ ] Ejercicio 1: imprime los 10 usuarios correctamente
- [ ] Ejercicio 2: el ID 99 muestra "no encontrado" sin romperse
- [ ] Ejercicio 3: usa Promise.all (no await await en secuencia)
- [ ] Ejercicio 4: el estado de "Buscando..." aparece durante la llamada
- [ ] Subi con `bash scripts/push.sh`
