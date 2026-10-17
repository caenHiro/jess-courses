---
semana: 3
tema: DOM y Eventos
estado: pendiente
---

# Practica — Semana 3: DOM y Eventos

> Guarda los archivos en: `codigo/semana-03/`
> Abre los `.html` directo en el navegador (doble clic)
> Al terminar: `bash scripts/push.sh "semana-03 dom eventos"`

---

## Ejercicio 1 — Tarjeta interactiva (obligatorio)

Crea `ejercicio1.html`.

La página debe tener una tarjeta con: nombre, email y un botón "Ver más".
Al hacer clic en "Ver más":
- Muestra información adicional (teléfono, departamento)
- El botón cambia su texto a "Ver menos"
- Al volver a hacer clic, oculta la información adicional

Sin usar CSS externo — usa `classList.toggle()` para agregar/quitar una clase `oculto` que tenga `display: none`.

**Tu solucion:**

---

## Ejercicio 2 — Calculadora en el navegador (obligatorio)

Crea `ejercicio2.html`.

Una calculadora simple con:
- Dos inputs de número
- Cuatro botones: Sumar, Restar, Multiplicar, Dividir
- Un área de resultado

Requisitos:
- Si se intenta dividir entre 0, mostrar un mensaje de error en rojo
- El resultado se muestra debajo de los botones sin recargar la página
- Si los inputs están vacíos al presionar un botón, mostrar "Por favor ingresa dos números"

**Tu solucion:**

---

## Ejercicio 3 — Lista de tareas DOM puro (obligatorio)

Crea `ejercicio3.html`.

App de lista de tareas que funcione así:
- Input de texto + botón "Agregar" (también funciona con Enter)
- Cada tarea tiene: checkbox de completar, texto, botón "X" para eliminar
- Al marcar un checkbox, el texto de la tarea debe tener tachado (`text-decoration: line-through`)
- Mostrar un contador: "3 de 5 completadas"
- Botón "Limpiar completadas" que elimina solo las que ya tienen check

**Tu solucion:**

---

## Ejercicio 4 — Formulario con validación en tiempo real (obligatorio)

Crea `ejercicio4.html`.

Formulario de registro con: nombre, email, password, confirmar password.

Validaciones que aparecen mientras se escribe (con el evento `input`):
- Nombre: mínimo 3 caracteres
- Email: debe contener `@` y `.`
- Password: mínimo 8 caracteres
- Confirmar password: debe coincidir con el password

El botón "Registrar" debe estar deshabilitado hasta que todos los campos sean válidos.

Al enviar (submit), mostrar un mensaje de éxito y limpiar el formulario.

**Tu solucion:**

---

## Ejercicio 5 — Galería con delegación de eventos (opcional)

Crea `ejercicio5.html`.

Una galería de tarjetas de colores. Cada tarjeta tiene: color de fondo aleatorio, un número, y un botón "X".

- Al cargar, genera 9 tarjetas automáticamente con `createElement` en un loop
- Usa delegación de eventos: un solo `addEventListener` en el contenedor padre
- Clic en una tarjeta (no en el botón X): la selecciona (borde más grueso, escala mayor con CSS)
- Clic en botón X: elimina esa tarjeta
- Contador que muestra cuántas tarjetas quedan

**Tu solucion:**

---

## Checklist antes de subir

- [ ] Ejercicio 1: el toggle de "Ver más/menos" funciona
- [ ] Ejercicio 2: la división entre cero muestra error
- [ ] Ejercicio 3: el contador se actualiza al marcar/desmarcar
- [ ] Ejercicio 4: el botón está disabled hasta que todo es válido
- [ ] Subi con `bash scripts/push.sh`
