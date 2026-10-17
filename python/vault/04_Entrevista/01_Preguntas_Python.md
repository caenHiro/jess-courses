---
tema: Preguntas de entrevista — Python
estado: completo
---

# Preguntas de Entrevista — Python

> Lee la pregunta, intenta responder en voz alta como si estuvieras en la entrevista, luego lee la respuesta. No memorices — entiende.

---

## Fundamentos del lenguaje

**¿Qué es Python y por qué se usa tanto?**

Python es un lenguaje de programación de propósito general, interpretado y de tipado dinámico. Se usa tanto porque tiene una sintaxis muy legible (se parece al inglés), tiene miles de librerías disponibles y funciona para web, análisis de datos, automatización, inteligencia artificial y más.

---

**¿Cuál es la diferencia entre una lista y una tupla?**

- **Lista** `[1, 2, 3]`: mutable — puedes agregar, quitar o modificar elementos.
- **Tupla** `(1, 2, 3)`: inmutable — una vez creada no puedes cambiarla.

Usa tupla cuando los datos no deben cambiar (coordenadas, configuración fija). Las tuplas son más rápidas que las listas.

```python
lista = [1, 2, 3]
lista.append(4)     # OK

tupla = (1, 2, 3)
tupla.append(4)     # ERROR: las tuplas no tienen append
```

---

**¿Qué es un diccionario?**

Una estructura de datos que almacena pares clave-valor. Es como una tabla hash. La clave debe ser inmutable (string, número, tupla).

```python
empleado = {
    "nombre": "Laura",
    "salario": 58000,
    "activo": True
}

print(empleado["nombre"])          # Laura
print(empleado.get("edad", 0))     # 0 (valor default si no existe la clave)
```

---

**¿Cuál es la diferencia entre `==` e `is`?**

- `==`: compara el **valor** de dos objetos.
- `is`: compara si dos variables apuntan al **mismo objeto en memoria**.

```python
a = [1, 2, 3]
b = [1, 2, 3]

print(a == b)   # True  — tienen el mismo valor
print(a is b)   # False — son objetos diferentes en memoria

c = a
print(a is c)   # True  — c apunta al mismo objeto que a
```

---

**¿Qué es una función lambda?**

Una función anónima de una sola expresión. Se usa cuando necesitas una función simple y no vale la pena ponerle nombre.

```python
# Función normal
def doble(x):
    return x * 2

# Lambda equivalente
doble = lambda x: x * 2

# Uso común: ordenar una lista por un criterio
empleados = [("Laura", 58000), ("Javier", 35000), ("Ana", 88000)]
empleados.sort(key=lambda e: e[1])  # ordena por salario
```

---

**¿Qué son los decoradores?**

Un decorador es una función que **envuelve a otra función** para agregarle comportamiento sin modificar su código.

```python
def log(func):
    def wrapper(*args, **kwargs):
        print(f"Llamando a {func.__name__}")
        resultado = func(*args, **kwargs)
        print(f"Terminó {func.__name__}")
        return resultado
    return wrapper

@log
def saludar(nombre):
    print(f"Hola, {nombre}")

saludar("Laura")
# Imprime:
# Llamando a saludar
# Hola, Laura
# Terminó saludar
```

---

**¿Cuál es la diferencia entre `*args` y `**kwargs`?**

- `*args`: recibe un número variable de argumentos **posicionales** como tupla.
- `**kwargs`: recibe un número variable de argumentos **nombrados** como diccionario.

```python
def ejemplo(*args, **kwargs):
    print(args)    # tupla: (1, 2, 3)
    print(kwargs)  # dict: {'nombre': 'Laura', 'salario': 58000}

ejemplo(1, 2, 3, nombre="Laura", salario=58000)
```

---

## Programación orientada a objetos

**¿Qué es la herencia?**

Permite que una clase hija tenga todos los atributos y métodos de una clase padre, y además agregue o modifique lo que necesite.

```python
class Empleado:
    def __init__(self, nombre, salario):
        self.nombre = nombre
        self.salario = salario

    def presentarse(self):
        return f"Soy {self.nombre}"

class Gerente(Empleado):  # Hereda de Empleado
    def __init__(self, nombre, salario, equipo):
        super().__init__(nombre, salario)  # llama al __init__ del padre
        self.equipo = equipo

    def presentarse(self):  # sobreescribe el método del padre
        return f"Soy {self.nombre}, gerente de {len(self.equipo)} personas"
```

---

**¿Qué es un método de clase vs un método de instancia?**

```python
class Empleado:
    total = 0  # atributo de clase (compartido por todas las instancias)

    def __init__(self, nombre):
        self.nombre = nombre    # atributo de instancia (único por objeto)
        Empleado.total += 1

    def saludar(self):          # método de instancia (accede a self)
        return f"Hola, soy {self.nombre}"

    @classmethod
    def cuantos_hay(cls):       # método de clase (accede a la clase, no a la instancia)
        return cls.total

    @staticmethod
    def validar_salario(salario):  # método estático (no accede ni a self ni a cls)
        return salario > 0
```

---

## Preguntas de arquitectura (para puestos backend)

**¿Qué es REST?**

REST (Representational State Transfer) es un estilo de arquitectura para APIs que usa HTTP. Los principios básicos son:
- Cada recurso tiene su propia URL (`/empleados`, `/empleados/7`)
- Se usan los verbos HTTP: `GET` (leer), `POST` (crear), `PUT/PATCH` (actualizar), `DELETE` (eliminar)
- Las respuestas son stateless — cada request contiene toda la información necesaria

---

**¿Cuál es la diferencia entre una API REST y GraphQL?**

- **REST**: múltiples endpoints, cada uno devuelve datos fijos. Simple de entender.
- **GraphQL**: un solo endpoint, el cliente especifica exactamente qué datos quiere. Evita over-fetching (recibir más datos de los necesarios) y under-fetching (tener que hacer varios requests).

---

**¿Qué es Docker y para qué lo usamos en Python?**

Docker permite empaquetar una aplicación con todo lo que necesita para funcionar (Python, librerías, configuración) en un **contenedor**. Así funciona igual en cualquier máquina, sin el problema de "en mi máquina sí funciona".

```bash
# Construir imagen
docker build -t mi-app .

# Correr contenedor
docker run -p 8000:8000 mi-app
```

---

**¿Qué es una variable de entorno y por qué se usan?**

Son valores de configuración que se guardan fuera del código. Se usan para no hardcodear contraseñas, URLs de base de datos o API keys directamente en el código (que podría publicarse en GitHub).

```python
import os

DB_PASSWORD = os.environ.get("DB_PASSWORD", "default_local")
```
