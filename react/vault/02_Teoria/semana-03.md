---
semana: 3
tema: El navegador — DOM, eventos, formularios
estado: pendiente
---

# Semana 3 — El navegador: DOM y Eventos

> Tiempo estimado: 4–6 horas
> Al terminar: `bash scripts/push.sh "semana-03 dom eventos"`

---

## Objetivo

Al terminar debes poder:
- Seleccionar elementos HTML desde JavaScript
- Modificar el contenido y estilo de la pagina
- Responder a eventos del usuario (clicks, teclado, formularios)
- Construir una mini app interactiva SIN ningún framework

> Esta semana es la base de todo. React hace exactamente esto, pero de forma más organizada. Si entiendes el DOM puro, React va a tener mucho más sentido.

---

## 1. El DOM — qué es

Cuando el navegador carga una página HTML la convierte en un árbol de objetos en memoria. Ese árbol se llama **DOM** (Document Object Model). JavaScript puede leer y modificar ese árbol en tiempo real.

```html
<!-- Tu HTML -->
<div id="app">
  <h1 class="titulo">Hola</h1>
  <p>Párrafo</p>
</div>
```

```javascript
// JavaScript accede al DOM
const app = document.getElementById("app");
const titulo = document.querySelector(".titulo");
const parrafo = document.querySelector("p");
```

---

## 2. Seleccionar elementos

```javascript
// Por ID (devuelve un elemento)
const btn = document.getElementById("mi-boton");

// Por selector CSS (devuelve el PRIMERO que encuentre)
const titulo = document.querySelector("h1");
const caja = document.querySelector(".mi-clase");
const input = document.querySelector("#nombre");

// Por selector CSS (devuelve TODOS como una lista)
const botones = document.querySelectorAll("button");
botones.forEach(btn => console.log(btn.textContent));
```

---

## 3. Leer y modificar elementos

```javascript
const titulo = document.querySelector("h1");

// Leer contenido
console.log(titulo.textContent);   // "Hola" (solo texto)
console.log(titulo.innerHTML);      // "Hola" (puede incluir HTML)

// Modificar contenido
titulo.textContent = "Nuevo título";
titulo.innerHTML = "<strong>Título en negrita</strong>";

// Modificar estilos directamente
titulo.style.color = "red";
titulo.style.fontSize = "32px";

// Agregar/quitar clases CSS (la forma correcta)
titulo.classList.add("activo");
titulo.classList.remove("inactivo");
titulo.classList.toggle("visible");       // si está → lo quita, si no → lo agrega
console.log(titulo.classList.contains("activo"));  // true o false

// Leer/modificar atributos
const img = document.querySelector("img");
console.log(img.getAttribute("src"));
img.setAttribute("alt", "Mi imagen");

// Propiedad value en inputs
const input = document.querySelector("input");
console.log(input.value);   // lo que el usuario escribió
input.value = "";            // limpiar el input
```

---

## 4. Crear y eliminar elementos

```javascript
// Crear un elemento nuevo
const nuevoParrafo = document.createElement("p");
nuevoParrafo.textContent = "Elemento nuevo";
nuevoParrafo.classList.add("mi-clase");

// Agregarlo al DOM
const contenedor = document.querySelector("#contenedor");
contenedor.appendChild(nuevoParrafo);      // al final
contenedor.prepend(nuevoParrafo);          // al inicio

// Eliminar un elemento
nuevoParrafo.remove();
```

---

## 5. Eventos

Los eventos son cosas que suceden: el usuario hace clic, mueve el mouse, escribe, envía un formulario.

```javascript
const boton = document.querySelector("#mi-boton");

// Agregar un listener de evento
boton.addEventListener("click", function(evento) {
    console.log("Se hizo clic!", evento);
});

// Con arrow function (la forma moderna)
boton.addEventListener("click", (e) => {
    console.log("Clic!");
});
```

### Eventos comunes

```javascript
// Click
btn.addEventListener("click", () => { ... });

// Input — se dispara cada vez que el usuario escribe
input.addEventListener("input", (e) => {
    console.log(e.target.value);  // lo que se escribio hasta ahora
});

// Keydown — tecla presionada
document.addEventListener("keydown", (e) => {
    console.log(e.key);   // "Enter", "a", "ArrowUp", etc.
    if (e.key === "Enter") { ... }
});

// Submit — cuando se envía un formulario
form.addEventListener("submit", (e) => {
    e.preventDefault();   // IMPORTANTE: evita que la página se recargue
    const datos = new FormData(form);
    console.log(datos.get("nombre"));
});

// Mouseover / Mouseout
elemento.addEventListener("mouseover", () => elemento.style.background = "blue");
elemento.addEventListener("mouseout",  () => elemento.style.background = "");
```

### El objeto evento (`e`)

```javascript
btn.addEventListener("click", (e) => {
    e.target;          // el elemento que disparó el evento (el botón)
    e.currentTarget;   // el elemento al que pegaste el listener
    e.preventDefault(); // cancela el comportamiento por defecto (útil en forms y links)
    e.stopPropagation(); // evita que el evento suba al padre
});
```

---

## 6. Delegación de eventos

En lugar de poner un listener a cada elemento de una lista, pones uno solo en el contenedor padre. Eficiente y funciona con elementos que se crean dinámicamente.

```javascript
const lista = document.querySelector("#mi-lista");

lista.addEventListener("click", (e) => {
    // e.target es el elemento específico donde se hizo clic
    if (e.target.tagName === "LI") {
        e.target.classList.toggle("completado");
    }
    if (e.target.classList.contains("btn-eliminar")) {
        e.target.parentElement.remove();
    }
});
```

---

## Patron completo — Mini app

```html
<!DOCTYPE html>
<html lang="es">
<head>
  <title>Lista de tareas</title>
</head>
<body>
  <input id="input-tarea" type="text" placeholder="Nueva tarea...">
  <button id="btn-agregar">Agregar</button>
  <ul id="lista-tareas"></ul>

  <script>
    const input = document.querySelector("#input-tarea");
    const btn   = document.querySelector("#btn-agregar");
    const lista = document.querySelector("#lista-tareas");

    function agregarTarea() {
        const texto = input.value.trim();
        if (!texto) return;

        const li = document.createElement("li");
        li.textContent = texto;

        const btnEliminar = document.createElement("button");
        btnEliminar.textContent = "X";
        btnEliminar.addEventListener("click", () => li.remove());
        li.appendChild(btnEliminar);

        lista.appendChild(li);
        input.value = "";
        input.focus();
    }

    btn.addEventListener("click", agregarTarea);
    input.addEventListener("keydown", (e) => {
        if (e.key === "Enter") agregarTarea();
    });
  </script>
</body>
</html>
```

> Esta mini app hace exactamente lo que React va a hacer en las semanas 6-8, pero sin componentes ni estado. Notarás cuánto código se necesita — para eso existe React.

---

Cuando termines: `vault/03_Practicas/semana-03.md`
