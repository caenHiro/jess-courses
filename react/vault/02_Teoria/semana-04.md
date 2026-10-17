---
semana: 4
tema: Async JavaScript — Promises, async/await, fetch y APIs REST
estado: pendiente
---

# Semana 4 — Async JavaScript y APIs REST

> Tiempo estimado: 5–7 horas
> Al terminar: `bash scripts/push.sh "semana-04 async apis"`

---

## Objetivo

Al terminar debes poder:
- Entender por qué JavaScript es asíncrono
- Usar `async/await` para consumir APIs
- Manejar errores de red correctamente
- Trabajar con datos JSON de una API real

---

## 1. Por qué async — el problema

JavaScript corre en un solo hilo. Si haces una operación lenta (pedir datos a un servidor), el navegador se congela. La solución: operaciones asíncronas.

```javascript
// PROBLEMA: esto bloquearía el navegador (no existe en JS real)
const datos = fetchBloqueante("https://api.ejemplo.com/usuarios");  // 2 segundos esperando

// SOLUCIÓN: async — sigues con otras cosas mientras espera
const datos = await fetch("https://api.ejemplo.com/usuarios");  // no bloquea
```

Analogía: en Java con Spring Boot normalmente esperas la respuesta de un método antes de continuar. En el navegador, el usuario no puede esperar — si el hilo se bloquea, no puede ni hacer clic.

---

## 2. Promises — la promesa de un valor futuro

Una `Promise` representa un valor que puede estar disponible ahora, más tarde, o nunca.

```javascript
// Una promesa tiene 3 estados:
// pending  — esperando
// fulfilled — completada con éxito
// rejected  — falló

const promesa = new Promise((resolve, reject) => {
    setTimeout(() => {
        const exito = true;
        if (exito) {
            resolve("Datos obtenidos");  // éxito
        } else {
            reject("Error al obtener datos");  // fallo
        }
    }, 2000);
});

// Consumir una promesa con .then() y .catch()
promesa
    .then(resultado => console.log(resultado))  // "Datos obtenidos"
    .catch(error => console.error(error));
```

---

## 3. async/await — la forma moderna (la que usarás siempre)

`async/await` es syntactic sugar sobre Promises. Hace código asíncrono que se LEE como síncrono.

```javascript
// Función async — siempre devuelve una Promise
async function obtenerUsuarios() {
    const respuesta = await fetch("https://jsonplaceholder.typicode.com/users");
    const usuarios = await respuesta.json();  // convertir a JSON también es async
    return usuarios;
}

// Llamar la función async
obtenerUsuarios().then(u => console.log(u));
```

### Con manejo de errores

```javascript
async function obtenerUsuario(id) {
    try {
        const respuesta = await fetch(`https://jsonplaceholder.typicode.com/users/${id}`);

        if (!respuesta.ok) {
            throw new Error(`Error HTTP: ${respuesta.status}`);
        }

        const usuario = await respuesta.json();
        return usuario;

    } catch (error) {
        console.error("Falló la petición:", error.message);
        return null;
    }
}
```

---

## 4. fetch — peticiones HTTP

`fetch` es la función nativa del navegador para hacer peticiones HTTP.

### GET (obtener datos)

```javascript
async function obtenerPosts() {
    const res = await fetch("https://jsonplaceholder.typicode.com/posts");
    const posts = await res.json();
    return posts;  // array de objetos
}
```

### POST (enviar datos)

```javascript
async function crearPost(titulo, cuerpo, userId) {
    const res = await fetch("https://jsonplaceholder.typicode.com/posts", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ title: titulo, body: cuerpo, userId })
    });
    const nuevoPost = await res.json();
    return nuevoPost;
}
```

### PUT/PATCH (actualizar) y DELETE (eliminar)

```javascript
// PUT — reemplaza el recurso completo
async function actualizarPost(id, datos) {
    const res = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(datos)
    });
    return await res.json();
}

// DELETE — eliminar
async function eliminarPost(id) {
    const res = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`, {
        method: "DELETE"
    });
    return res.ok;  // true si fue exitoso
}
```

---

## 5. Múltiples peticiones en paralelo

```javascript
// Secuencial (más lento — espera una antes de la otra)
const usuarios = await obtenerUsuarios();
const posts    = await obtenerPosts();

// Paralelo (más rápido — ambas al mismo tiempo)
const [usuarios, posts] = await Promise.all([
    obtenerUsuarios(),
    obtenerPosts()
]);
```

---

## 6. API pública para practicar

Para esta semana usa **JSONPlaceholder** — una API falsa gratuita:

```
GET  https://jsonplaceholder.typicode.com/users        → lista de usuarios
GET  https://jsonplaceholder.typicode.com/users/1      → usuario por ID
GET  https://jsonplaceholder.typicode.com/posts        → lista de posts
GET  https://jsonplaceholder.typicode.com/posts?userId=1  → posts de un usuario
POST https://jsonplaceholder.typicode.com/posts        → crear post (simulado)
```

---

## Flujo completo — App que consume una API

```html
<!DOCTYPE html>
<html lang="es">
<body>
  <button id="btn-cargar">Cargar usuarios</button>
  <p id="estado">Listo.</p>
  <ul id="lista"></ul>

  <script>
    const btnCargar = document.querySelector("#btn-cargar");
    const estado    = document.querySelector("#estado");
    const lista     = document.querySelector("#lista");

    async function cargarUsuarios() {
        estado.textContent = "Cargando...";
        btnCargar.disabled = true;
        lista.innerHTML = "";

        try {
            const res = await fetch("https://jsonplaceholder.typicode.com/users");
            if (!res.ok) throw new Error(`Error ${res.status}`);
            const usuarios = await res.json();

            usuarios.forEach(u => {
                const li = document.createElement("li");
                li.textContent = `${u.name} — ${u.email}`;
                lista.appendChild(li);
            });

            estado.textContent = `${usuarios.length} usuarios cargados.`;
        } catch (err) {
            estado.textContent = `Error: ${err.message}`;
        } finally {
            btnCargar.disabled = false;
        }
    }

    btnCargar.addEventListener("click", cargarUsuarios);
  </script>
</body>
</html>
```

---

## Resumen

| Concepto | Uso |
|----------|-----|
| `async function` | Declara una función que puede usar `await` |
| `await` | Espera que una Promise se resuelva |
| `try/catch` | Maneja errores de red o de la API |
| `fetch(url)` | GET request |
| `fetch(url, { method, headers, body })` | POST/PUT/DELETE |
| `res.json()` | Convierte la respuesta a objeto JS |
| `res.ok` | true si HTTP 200-299 |
| `Promise.all([...])` | Ejecuta múltiples async en paralelo |

---

Cuando termines: `vault/03_Practicas/semana-04.md`
