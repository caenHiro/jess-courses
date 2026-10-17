---
semana: 4
tema: POO en Python
estado: pendiente
---

# Practica Semana 4 — Programacion Orientada a Objetos

> Lee la teoria en `02_Teoria/semana-04.md` antes de empezar.
> Guarda tu codigo en: `codigo/semana-04/`

---

## Ejercicio 1 — Clase Mascota (obligatorio)

Crea `mascota.py` con la clase `Mascota`:

Atributos: `nombre`, `especie`, `edad`

Metodos:
- `presentarse()` — "Hola, soy [nombre], un/una [especie] de [edad] anos"
- `cumplir_anos()` — incrementa la edad en 1 y muestra "Feliz cumpleanos [nombre]!"

Crea 2 mascotas y llama a sus metodos.

---

## Ejercicio 2 — Clase CuentaBancaria (obligatorio)

Crea `cuenta.py` con la clase `CuentaBancaria`:

Atributos: `titular`, `saldo` (default 0)

Metodos:
- `depositar(cantidad)` — suma al saldo, muestra el nuevo saldo
- `retirar(cantidad)` — si hay fondos: resta y muestra saldo; si no: "Fondos insuficientes"
- `consultar_saldo()` — muestra el saldo actual

Crea una cuenta, deposita $500, retira $200, intenta retirar $400 (debe fallar), y muestra el saldo final.

---

## Ejercicio 3 — Herencia: Vehiculos (reto)

Crea `vehiculos.py`:

Clase base `Vehiculo`:
- Atributos: `marca`, `modelo`, `velocidad_max`
- Metodo: `describir()` — muestra los atributos

Clase `Auto(Vehiculo)`:
- Atributo adicional: `num_puertas`
- `describir()` — llama al padre y agrega "Puertas: [num]"

Clase `Moto(Vehiculo)`:
- Atributo adicional: `tipo` (deportiva, clasica, etc)
- `describir()` — llama al padre y agrega "Tipo: [tipo]"

Crea un auto y una moto, llama a `describir()` en ambos.

---

## Reflexion

**¿Que ventaja tiene usar `__init__` con `self` en Python vs el constructor de Java?**

_Tu respuesta:_

**¿Cuando conviene usar herencia en lugar de crear clases independientes?**

_Tu respuesta:_

**¿Que hace `super()` y para que sirve?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-04 poo-python"`
