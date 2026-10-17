# Semana 4 — POO en Python: clases y objetos

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-04 funciones"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Definir una clase con `__init__` y metodos
- Entender que `self` es el equivalente a `this` en Java
- Crear objetos e interactuar con sus atributos y metodos
- Implementar herencia con `super()`
- Usar la convencion `_atributo` para atributos "privados"
- (Opcional) Usar `@dataclass` para clases simples de datos

**No se espera que Jess implemente interfaces, clases abstractas, ni POO avanzada todavia.**

---

## Analogia clave 

> "Una clase es como el molde de una taquiza: el molde define que lleva cada taco (ingredientes = atributos) y que se puede hacer con el (acciones = metodos). Cada taco que haces con ese molde es un objeto — mismo molde, distintos ingredientes."

> "`self` en Python es como `this` en Java. Cuando le dices a Jess 'tu edad', estas hablando del atributo TUYO, no del de otra persona. `self.edad` = 'la edad de ESTE objeto especifico'."

> "La herencia en Python es como los tamales de la abuela: la receta base viene de la abuela (clase padre), pero tu le agregas chile (metodo extra) o cambias el relleno (override) para hacer los tuyos."

---

## Equivalente Java → Python

| Java | Python | Diferencia clave |
|------|--------|-----------------|
| `public class Persona {` | `class Persona:` | Sin `public`, sin `{}` |
| `public Persona(String n)` | `def __init__(self, n):` | Constructor es `__init__` |
| `this.nombre = nombre;` | `self.nombre = nombre` | `self` en lugar de `this` |
| `public void saludar()` | `def saludar(self):` | Sin tipos, `self` siempre primero |
| `Persona p = new Persona("Jess")` | `p = Persona("Jess")` | Sin `new`, sin tipo |
| `class Perro extends Animal` | `class Perro(Animal):` | Herencia con `()` |
| `super()` | `super().__init__(...)` | Llamada al padre |
| `private String nombre;` | `self._nombre = ...` | Convencion `_`, no real private |
| No existe nativo | `@dataclass` | Para clases solo de datos |

---

## Contenido teorico

### 4.1 Definir una clase

```python
# La clase define la estructura — como el molde del taco
class Persona:

    # __init__ es el constructor — se llama automaticamente al crear el objeto
    # self es siempre el PRIMER parametro (representa al objeto actual)
    def __init__(self, nombre, edad):
        self.nombre = nombre    # atributo publico del objeto
        self.edad = edad        # en Java seria: this.nombre = nombre;

    # Metodo de instancia — siempre recibe self como primer parametro
    def saludar(self):
        print(f"Hola, soy {self.nombre} y tengo {self.edad} anos")

    def es_mayor_de_edad(self):
        return self.edad >= 18    # devuelve True o False
```

### 4.2 Crear objetos

```python
# Crear objetos — sin 'new', sin declarar el tipo
jess = Persona("Jess", 22)
carlos = Persona("Carlos", 30)

# Llamar metodos
jess.saludar()           # Hola, soy Jess y tengo 22 anos
carlos.saludar()         # Hola, soy Carlos y tengo 30 anos

# Acceder a atributos directamente
print(jess.nombre)       # Jess
print(carlos.edad)       # 30

# Modificar un atributo (Python lo permite directamente)
jess.edad = 23
print(jess.edad)         # 23

# Llamar metodo que devuelve valor
print(jess.es_mayor_de_edad())    # True
```

### 4.3 Atributos "privados" — convencion con `_`

Python no tiene `private` real como Java. La convencion es usar `_` al inicio:

```python
class CuentaBancaria:
    def __init__(self, titular, saldo_inicial):
        self.titular = titular           # atributo publico: se puede acceder directo
        self._saldo = saldo_inicial      # atributo "privado": por convencion no acceder directo

    def depositar(self, cantidad):
        if cantidad <= 0:
            print("La cantidad debe ser positiva")
            return
        self._saldo += cantidad           # self._saldo += cantidad modifica el saldo
        print(f"Deposito de ${cantidad}. Nuevo saldo: ${self._saldo}")

    def retirar(self, cantidad):
        if cantidad > self._saldo:
            print("Saldo insuficiente")
            return
        self._saldo -= cantidad
        print(f"Retiro de ${cantidad}. Nuevo saldo: ${self._saldo}")

    def get_saldo(self):
        return self._saldo    # acceder al saldo a traves de un metodo

# Usar la clase
cuenta = CuentaBancaria("Jess", 1000.0)
cuenta.depositar(500)       # Deposito de $500. Nuevo saldo: $1500.0
cuenta.retirar(200)         # Retiro de $200. Nuevo saldo: $1300.0
print(cuenta.get_saldo())   # 1300.0
print(cuenta.titular)       # Jess (publico — acceso directo ok)
```

### 4.4 Herencia en Python

```python
# Clase padre (base)
class Animal:
    def __init__(self, nombre, especie):
        self.nombre = nombre
        self.especie = especie

    def hacer_sonido(self):
        print(f"{self.nombre} hace un sonido")   # comportamiento generico

    def __str__(self):
        # __str__ es como toString() en Java
        return f"{self.nombre} ({self.especie})"


# Clase hija — hereda de Animal con (Animal)
class Perro(Animal):
    def __init__(self, nombre, raza):
        # super() llama al constructor del padre (Animal)
        super().__init__(nombre, "Canis lupus familiaris")
        self.raza = raza    # atributo extra de Perro

    def hacer_sonido(self):
        # Override del metodo del padre
        print(f"{self.nombre}: Guau guau!")

    def buscar_pelota(self):
        # Metodo exclusivo de Perro
        print(f"{self.nombre} salio corriendo a buscar la pelota")


class Gato(Animal):
    def __init__(self, nombre):
        super().__init__(nombre, "Felis catus")

    def hacer_sonido(self):
        print(f"{self.nombre}: Miau...")

    def ronronear(self):
        print(f"{self.nombre} ronronea felizmente")
```

```python
# Usar las clases
rex = Perro("Rex", "Labrador")
misi = Gato("Misi")

rex.hacer_sonido()       # Rex: Guau guau!  (override)
misi.hacer_sonido()      # Misi: Miau...   (override)
rex.buscar_pelota()      # Rex salio corriendo a buscar la pelota
misi.ronronear()         # Misi ronronea felizmente

# Herencia: Perro tambien tiene los metodos de Animal
print(rex)               # Rex (Canis lupus familiaris)  — usa __str__
print(misi)              # Misi (Felis catus)

# isinstance verifica si un objeto es de cierta clase (incluyendo padres)
print(isinstance(rex, Perro))     # True
print(isinstance(rex, Animal))    # True  (por herencia!)
print(isinstance(misi, Perro))    # False
```

### 4.5 dataclass — para clases de solo datos

```python
from dataclasses import dataclass

# Sin @dataclass — mucho codigo repetitivo:
class ProductoNormal:
    def __init__(self, nombre, precio, stock):
        self.nombre = nombre
        self.precio = precio
        self.stock = stock

# Con @dataclass — automatico:
@dataclass
class Producto:
    nombre: str           # nota: aqui si declaras el tipo (opcional pero recomendado)
    precio: float
    stock: int = 0        # valor por defecto

# @dataclass genera automaticamente: __init__, __repr__, __eq__
laptop = Producto("Laptop", 15000.0, 5)
mouse = Producto("Mouse", 350.0)   # stock usa el default 0

print(laptop)   # Producto(nombre='Laptop', precio=15000.0, stock=5)
print(mouse)    # Producto(nombre='Mouse', precio=350.0, stock=0)

# Comparacion automatica
p1 = Producto("Teclado", 500.0, 10)
p2 = Producto("Teclado", 500.0, 10)
print(p1 == p2)    # True  (en clase normal seria False sin definir __eq__)
```

---

## Errores comunes

1. **Olvidar `self` en los parametros del metodo:** escribir `def saludar():` en lugar de `def saludar(self):` da `TypeError` al llamar el metodo. `self` es obligatorio en todo metodo de instancia.

2. **Olvidar `self.` al acceder a atributos dentro de la clase:** escribir `nombre` en lugar de `self.nombre` dentro de un metodo — Python no sabe que te refieres al atributo del objeto, busca una variable local.

3. **Olvidar llamar `super().__init__()`:** al heredar, si el padre tiene un `__init__`, el hijo DEBE llamarlo con `super().__init__(...)` para que los atributos del padre se inicialicen.

4. **Poner `new` al crear objetos:** `new Persona("Jess")` da `NameError`. En Python se crea con `Persona("Jess")` sin `new`.

5. **Confundir `__init__` con el nombre de la clase:** el constructor en Python siempre se llama `__init__`, con dos guiones bajos a cada lado. No lleva el nombre de la clase.

6. **Modificar atributos `_privados` directamente:** la convencion `_atributo` indica "no tocar desde fuera". Tecnicamente Python no lo bloquea, pero es mala practica.

---

## Soluciones

### Ejercicio 1 — Clase Jugador de futbol

```python
# Clase que representa a un jugador de futbol
class Jugador:

    def __init__(self, nombre, posicion, numero):
        # Atributos del jugador — se guardan en el objeto con self.
        self.nombre = nombre        # nombre del jugador
        self.posicion = posicion    # portero, defensa, medio, delantero
        self.numero = numero        # numero de playera
        self.goles = 0              # inicia en 0, aumenta con meter_gol

    def meter_gol(self):
        self.goles += 1             # incrementa el contador de goles
        print(f"¡GOOOL de {self.nombre}! Total: {self.goles} goles")

    def presentarse(self):
        print(f"Soy {self.nombre}, juego de {self.posicion}, numero {self.numero}")

    def __str__(self):
        # Como toString() en Java — se llama cuando haces print(objeto)
        return f"Jugador({self.nombre}, #{self.numero}, {self.goles} goles)"


# Crear jugadores
jess = Jugador("Jessica", "delantera", 9)
ana = Jugador("Ana", "portera", 1)

# Usar los metodos
jess.presentarse()
ana.presentarse()

jess.meter_gol()
jess.meter_gol()
print(f"Goles de Jess: {jess.goles}")   # 2

print(jess)    # Jugador(Jessica, #9, 2 goles)
```

### Ejercicio 2 — Herencia: Equipo y JugadorProfesional

```python
# Clase base: cualquier persona del equipo
class PersonaEquipo:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad

    def presentarse(self):
        print(f"Hola, me llamo {self.nombre} y tengo {self.edad} anos")


# Clase hija: jugador con sueldo
class JugadorProfesional(PersonaEquipo):
    def __init__(self, nombre, edad, posicion, sueldo):
        super().__init__(nombre, edad)   # inicializar los del padre
        self.posicion = posicion
        self.sueldo = sueldo
        self.goles = 0

    def presentarse(self):
        # Override: agrega informacion extra
        super().presentarse()            # llama al presentarse del padre
        print(f"  Juego de {self.posicion} y gano ${self.sueldo:,.0f}/mes")

    def marcar_gol(self):
        self.goles += 1

    def __str__(self):
        return f"{self.nombre} | {self.posicion} | {self.goles} goles"


# Clase hija: entrenador
class Entrenador(PersonaEquipo):
    def __init__(self, nombre, edad, especialidad):
        super().__init__(nombre, edad)
        self.especialidad = especialidad

    def presentarse(self):
        super().presentarse()
        print(f"  Soy entrenador especialista en {self.especialidad}")


# Usar las clases
jess = JugadorProfesional("Jessica", 22, "delantera", 25000)
profe = Entrenador("Carlos", 40, "tactica ofensiva")

jess.presentarse()
print()
profe.presentarse()

jess.marcar_gol()
jess.marcar_gol()
print(f"\n{jess}")
```

### Ejercicio 3 (Reto) — dataclass de Producto con metodos

```python
from dataclasses import dataclass

@dataclass
class Producto:
    nombre: str        # nombre del producto
    precio: float      # precio unitario en pesos
    stock: int = 0     # cantidad disponible, default 0

    def aplicar_descuento(self, porcentaje):
        """Reduce el precio por el porcentaje indicado."""
        descuento = self.precio * (porcentaje / 100)   # calcular cuanto se descuenta
        self.precio -= descuento                        # reducir el precio
        print(f"{self.nombre}: nuevo precio ${self.precio:.2f} ({porcentaje}% descuento)")

    def agregar_stock(self, cantidad):
        """Aumenta el stock disponible."""
        self.stock += cantidad
        print(f"{self.nombre}: stock actualizado a {self.stock} unidades")

    def vender(self, cantidad):
        """Reduce el stock al vender. Valida que haya suficiente."""
        if cantidad > self.stock:
            print(f"No hay suficiente stock. Disponible: {self.stock}")
            return False
        self.stock -= cantidad
        total = self.precio * cantidad
        print(f"Vendido: {cantidad} x {self.nombre} = ${total:.2f}")
        return True


# Usar la clase
laptop = Producto("Laptop Lenovo", 15000.0, 10)
teclado = Producto("Teclado mecanico", 800.0, 25)

print(laptop)   # Producto(nombre='Laptop Lenovo', precio=15000.0, stock=10)

laptop.aplicar_descuento(15)     # 15% de descuento
laptop.vender(2)                  # vender 2 laptops
laptop.agregar_stock(5)           # llego nuevo inventario

print(f"\nEstado final:")
print(laptop)
print(teclado)
```

---
