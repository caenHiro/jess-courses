# Semana 6 — Entornos virtuales, Excepciones y Decoradores

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-06 diccionarios"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Crear y activar un entorno virtual con `venv`
- Instalar paquetes con `pip` y guardar dependencias en `requirements.txt`
- Manejar excepciones con `try/except/finally` (incluyendo excepciones personalizadas)
- Entender que es un decorador y reconocer `@decorador` en el codigo
- Preparar el entorno para FastAPI (semana 7)

**No se espera que cree decoradores complejos — solo entenderlos para poder usar los de FastAPI.**

---

## Analogia clave 

> "Un entorno virtual es como una mochila de trabajo por proyecto. Cada proyecto tiene su propia mochila con sus propias herramientas. Asi la calculadora de matematicas no mezcla sus herramientas con las de la API web. En Java esto era como tener proyectos Maven separados, cada uno con su `pom.xml`."

> "Las excepciones en Python son iguales que en Java, solo cambia la sintaxis: `catch` se convierte en `except`. El concepto es el mismo: si algo sale mal, atrapa el error y maneja la situacion con gracia."

> "Un decorador es como un envoltorio de regalo. La funcion es el regalo, el decorador es el papel de regalo. El regalo sigue siendo el mismo, pero el decorador le agrega presentacion. En FastAPI, `@app.get("/")` es el papel que convierte tu funcion en un endpoint HTTP."

---

## Equivalente Java → Python

| Java | Python | Diferencia clave |
|------|--------|-----------------|
| `pom.xml` / Maven | `requirements.txt` / pip | pip es mas simple |
| Proyecto Maven con dependencias | `.venv` + `pip install` | Entorno virtual aislado |
| `try { } catch (Exception e) { }` | `try: ... except Exception as e:` | `catch` → `except`, sin llaves |
| `finally { }` | `finally:` | Mismo concepto, diferente sintaxis |
| `throw new Exception("msg")` | `raise ValueError("msg")` | `throw` → `raise` |
| `class MiExcepcion extends Exception` | `class MiExcepcion(Exception):` | Herencia igual |
| Anotaciones `@Override`, `@Deprecated` | Decoradores `@decorador` | Mismo concepto, mas poderosos |

---

## Contenido teorico

### 6.1 Entornos virtuales — fundamental en Python

**Por que son necesarios:**
Imagina que tienes dos proyectos:
- Proyecto A necesita `requests==2.28`
- Proyecto B necesita `requests==2.31`

Sin entorno virtual, solo puedes tener una version instalada globalmente y uno de los dos proyectos falla. Con entorno virtual, cada proyecto tiene su propia "copia" de cada libreria.

```bash
# === CREAR EL ENTORNO VIRTUAL ===
# Esto crea una carpeta .venv con Python y pip propios
python3 -m venv .venv

# === ACTIVAR (antes de instalar cualquier cosa) ===
# En Mac/Linux:
source .venv/bin/activate

# En Windows (PowerShell):
.venv\Scripts\activate

# Cuando esta activado, el prompt cambia: (.venv) tu_usuario@PC:~$
# Ahora todo lo que instales va dentro de .venv/

# === INSTALAR PAQUETES ===
pip install requests    # instala la libreria requests
pip install fastapi uvicorn    # instalar multiples a la vez

# === VER QUE ESTA INSTALADO ===
pip list

# === GUARDAR DEPENDENCIAS DEL PROYECTO ===
# Esto crea/actualiza requirements.txt con todo lo instalado y sus versiones
pip freeze > requirements.txt

# === INSTALAR DESDE requirements.txt ===
# (cuando alguien clona tu proyecto y necesita instalar todo)
pip install -r requirements.txt

# === DESACTIVAR EL ENTORNO ===
deactivate
```

**Reglas de oro:**
1. Nunca incluir `.venv/` en git — agregar al `.gitignore`
2. Siempre hacer `source .venv/bin/activate` antes de trabajar en el proyecto
3. Siempre hacer `pip freeze > requirements.txt` antes de hacer commit

### 6.2 Excepciones en Python

```python
# ====== ESTRUCTURA BASICA ======
# Java: try { } catch (TipoException e) { } finally { }
# Python: try: ... except TipoException as e: ... finally:

try:
    numero = int(input("Ingresa un numero entero: "))    # puede fallar si ponen letras
    resultado = 100 / numero                              # puede fallar si es 0
    print(f"100 / {numero} = {resultado}")

except ValueError:
    # Se lanza cuando int("hola") falla — texto que no es numero
    print("Error: eso no es un numero entero")

except ZeroDivisionError:
    # Se lanza cuando divides entre 0
    print("Error: no se puede dividir entre cero")

except Exception as e:
    # Atrapa CUALQUIER otro error — como el catch(Exception e) de Java
    print(f"Error inesperado: {e}")

finally:
    # Esto SIEMPRE se ejecuta, haya error o no — igual que en Java
    print("Gracias por usar la calculadora")
```

**Excepciones comunes en Python:**

| Excepcion | Cuando ocurre | Ejemplo |
|-----------|--------------|---------|
| `ValueError` | Conversion fallida | `int("hola")` |
| `ZeroDivisionError` | Division entre 0 | `10 / 0` |
| `FileNotFoundError` | Archivo no existe | `open("x.txt")` |
| `KeyError` | Clave no existe en dict | `d["clave_que_no_hay"]` |
| `IndexError` | Indice fuera de rango | `lista[100]` en lista de 5 |
| `TypeError` | Tipo incorrecto | `"hola" + 5` |
| `AttributeError` | Atributo no existe en objeto | `objeto.metodo_que_no_existe()` |

### 6.3 Lanzar tu propia excepcion

```python
# En Java: throw new Exception("mensaje")
# En Python: raise TipoException("mensaje")

def calcular_promedio(calificaciones):
    if not calificaciones:    # lista vacia
        raise ValueError("La lista de calificaciones no puede estar vacia")

    if any(c < 0 or c > 10 for c in calificaciones):
        raise ValueError("Las calificaciones deben estar entre 0 y 10")

    return sum(calificaciones) / len(calificaciones)

# Usar la funcion con manejo de error
try:
    prom = calcular_promedio([8.5, 9.0, 7.5])
    print(f"Promedio: {prom:.2f}")

    prom_vacio = calcular_promedio([])    # esto lanzara ValueError
    print(f"Promedio: {prom_vacio}")

except ValueError as e:
    print(f"Error de validacion: {e}")
```

### 6.4 Excepciones personalizadas

```python
# Igual que en Java: class MiExcepcion extends Exception
# En Python: class MiExcepcion(Exception)

class SaldoInsuficienteError(Exception):
    """Se lanza cuando el saldo de la cuenta es insuficiente para el retiro."""
    def __init__(self, saldo_actual, monto_requerido):
        self.saldo_actual = saldo_actual
        self.monto_requerido = monto_requerido
        # super().__init__() inicializa el mensaje de la excepcion padre
        super().__init__(
            f"Saldo insuficiente: tienes ${saldo_actual}, necesitas ${monto_requerido}"
        )


class CuentaBancaria:
    def __init__(self, titular, saldo):
        self.titular = titular
        self._saldo = saldo

    def retirar(self, cantidad):
        if cantidad > self._saldo:
            raise SaldoInsuficienteError(self._saldo, cantidad)
        self._saldo -= cantidad
        return self._saldo


# Usar la excepcion personalizada
cuenta = CuentaBancaria("Jess", 1000.0)

try:
    cuenta.retirar(500)     # OK
    print(f"Retiro exitoso. Saldo: ${cuenta._saldo}")
    cuenta.retirar(800)     # Falla — saldo insuficiente
except SaldoInsuficienteError as e:
    print(f"No se pudo retirar: {e}")
```

### 6.5 Decoradores — entender para usar FastAPI

Un decorador es una funcion que "envuelve" a otra funcion para agregarle comportamiento sin modificar su codigo interno.

```python
# ====== DECORADOR SIMPLE — para entender el concepto ======
def registrar(funcion):
    """Decorador que imprime cuando se llama una funcion."""
    def envolvente(*args, **kwargs):   # acepta cualquier argumentos
        print(f"Llamando a: {funcion.__name__}")   # log antes
        resultado = funcion(*args, **kwargs)         # ejecuta la funcion original
        print(f"Termino: {funcion.__name__}")        # log despues
        return resultado   # devuelve el resultado original
    return envolvente

# Aplicar el decorador con @
@registrar
def sumar(a, b):
    return a + b

# Cuando llamas sumar(), en realidad Python llama envolvente()
resultado = sumar(5, 3)    # imprime logs + devuelve 8
print(resultado)            # 8
```

**Lo mas importante para Jess: reconocer decoradores en FastAPI:**

```python
# Este es el patron que veras en semana 7 con FastAPI:
@app.get("/usuarios")           # @decorador que registra la ruta HTTP
def listar_usuarios():
    return [{"nombre": "Jess"}]

@app.post("/usuarios")          # otro decorador para metodo POST
def crear_usuario(datos):
    return {"creado": True}
```

No necesitas saber crear decoradores complejos — solo saber que `@algo` antes de una funcion MODIFICA el comportamiento de esa funcion.

---

## Errores comunes

1. **Trabajar sin activar el entorno virtual:** instalar paquetes globalmente en lugar de en el proyecto. Si `(.venv)` no aparece en el prompt, el entorno no esta activado.

2. **No hacer `pip freeze > requirements.txt` antes del commit:** el codigo queda en git pero las dependencias no, y el proyecto no funciona en otra maquina.

3. **Atrapar `Exception` directamente antes de las especificas:** si pones `except Exception:` primero, las excepciones especificas (`ValueError`, etc.) nunca se alcanzan. Las especificas siempre van ANTES del `Exception` generico.

4. **Confundir `raise` con `return`:** `raise` lanza una excepcion y DETIENE la ejecucion de la funcion. `return` devuelve un valor. Son conceptos muy diferentes.

5. **`finally` no siempre es necesario:** many students add it to every try/except. Solo usarlo cuando realmente necesitas ejecutar algo siempre (cerrar conexiones, liberar recursos).

6. **Olvidar `super().__init__()` en excepciones personalizadas:** sin llamar al padre, la excepcion no tiene el mensaje de error configurado correctamente.

---

## Soluciones

### Ejercicio 1 — Calculadora robusta con excepciones

```python
def dividir(a, b):
    """Divide a entre b. Lanza ValueError si b es 0."""
    if b == 0:
        raise ValueError("No se puede dividir entre cero")
    return a / b

def calculadora():
    """Calculadora interactiva con manejo de errores."""
    print("=== Calculadora Python ===")
    print("Operaciones: +, -, *, /")
    print("Escribe 'salir' para terminar\n")

    while True:
        entrada = input("Numero 1 (o 'salir'): ").strip()

        if entrada.lower() == "salir":
            print("¡Hasta luego!")
            break    # sale del while

        try:
            a = float(entrada)    # puede fallar si escribe letras
            operacion = input("Operacion (+, -, *, /): ").strip()
            b = float(input("Numero 2: "))

            if operacion == "+":
                resultado = a + b
            elif operacion == "-":
                resultado = a - b
            elif operacion == "*":
                resultado = a * b
            elif operacion == "/":
                resultado = dividir(a, b)    # puede lanzar ValueError
            else:
                print(f"Operacion '{operacion}' no reconocida")
                continue    # vuelve al inicio del while

            print(f"Resultado: {a} {operacion} {b} = {resultado:.4f}\n")

        except ValueError as e:
            print(f"Error de valor: {e}\n")

        except Exception as e:
            print(f"Error inesperado: {e}\n")

calculadora()
```

### Ejercicio 2 — Sistema de login con excepciones personalizadas

```python
class UsuarioNoEncontradoError(Exception):
    """Se lanza cuando el usuario no existe en el sistema."""
    pass    # pass = no agrega nada, hereda todo de Exception


class ContrasenaIncorrectaError(Exception):
    """Se lanza cuando la contrasena es incorrecta."""
    def __init__(self, intentos_restantes):
        self.intentos_restantes = intentos_restantes
        super().__init__(f"Contrasena incorrecta. Intentos restantes: {intentos_restantes}")


# Base de datos de usuarios simulada (diccionario)
USUARIOS = {
    "jess": "futbol123",
    "carlos": "python456",
    "admin": "admin999"
}

def login(usuario, contrasena, max_intentos=3):
    """Valida usuario y contrasena."""
    if usuario not in USUARIOS:
        raise UsuarioNoEncontradoError(f"El usuario '{usuario}' no existe")

    if USUARIOS[usuario] != contrasena:
        intentos_restantes = max_intentos - 1
        raise ContrasenaIncorrectaError(intentos_restantes)

    return True    # login exitoso

# Sistema de login con 3 intentos
usuario = input("Usuario: ")
intentos = 0
max_intentos = 3

while intentos < max_intentos:
    try:
        contrasena = input("Contrasena: ")
        login(usuario, contrasena, max_intentos - intentos)
        print(f"¡Bienvenido, {usuario}!")
        break    # sale del while si el login fue exitoso

    except UsuarioNoEncontradoError as e:
        print(f"Error: {e}")
        break    # no tiene sentido seguir intentando si el usuario no existe

    except ContrasenaIncorrectaError as e:
        intentos += 1
        print(f"Error: {e}")
        if intentos >= max_intentos:
            print("Cuenta bloqueada por demasiados intentos fallidos")
```

### Ejercicio 3 (Reto) — Decorador de tiempo

```python
import time    # modulo para medir tiempo

def medir_tiempo(funcion):
    """Decorador que mide cuanto tarda en ejecutarse una funcion."""
    def envolvente(*args, **kwargs):
        inicio = time.time()          # tiempo antes de ejecutar
        resultado = funcion(*args, **kwargs)    # ejecutar la funcion original
        fin = time.time()             # tiempo despues de ejecutar
        duracion = fin - inicio       # duracion en segundos

        print(f"[{funcion.__name__}] tardó {duracion:.4f} segundos")
        return resultado    # devolver el resultado original sin modificar
    return envolvente

@medir_tiempo
def busqueda_lenta(n):
    """Simula una busqueda que tarda un poco."""
    total = 0
    for i in range(n):
        total += i
    return total

@medir_tiempo
def suma_rapida(n):
    """Formula matematica directa — mucho mas rapida."""
    return n * (n - 1) // 2

# Comparar los tiempos
resultado1 = busqueda_lenta(1_000_000)
resultado2 = suma_rapida(1_000_000)

print(f"Resultado busqueda: {resultado1}")
print(f"Resultado formula: {resultado2}")
print(f"Mismo resultado: {resultado1 == resultado2}")
```

---
