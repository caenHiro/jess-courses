# Semana 10 — AWS Lambda: primera funcion serverless

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-10 lambda"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Entender que es "serverless" y por que importa
- Crear una Lambda desde la consola AWS
- Escribir un handler basico `def handler(event, context)`
- Pasar parametros via event JSON y leer variables de entorno
- Ver los logs de ejecucion en CloudWatch
- (Reto) Hacer deploy de la Lambda desde la terminal con `aws lambda`


---

## Analogia clave 

> "Una Lambda es como un taquero que solo abre el puesto cuando llega un cliente. Si no hay pedidos, el taquero no esta (y no cobra renta). Cuando llega un pedido — alguien llama al handler — el taquero aparece, prepara los tacos (ejecuta el codigo) y desaparece. Tu solo pagas por cada taco preparado, no por tener al taquero parado todo el dia."

> "El `event` es el pedido del cliente: viene en JSON con lo que pide. El `context` es la charola donde va el pedido — tiene info del tiempo limite, el ID del pedido, etc. La respuesta del handler es lo que le regresas al cliente."

> "CloudWatch Logs es el cuaderno de pedidos del taquero: cada vez que prepara algo, escribe que hizo, a que hora, y si algo salio mal. Si tu Lambda falla, el cuaderno te dice exactamente que paso."

---

## Contenido teorico

### 10.1 Que es serverless

"Serverless" NO significa que no hay servidor. Significa que **tu no administras el servidor**.

| Tradicional (EC2) | Serverless (Lambda) |
|---|---|
| Tu configuras el servidor | AWS lo configura |
| Pagas 24/7 aunque no haya trafico | Pagas solo cuando se ejecuta |
| Tu escalas manualmente | AWS escala automaticamente |
| Tu parcheas el sistema operativo | AWS lo parchea |

**Lambda en numeros (Free Tier):**
- 1,000,000 invocaciones gratis por mes
- 400,000 GB-segundo de computo gratis
- Para practicas con Jess: imposible salir del free tier

### 10.2 Anatomia de una Lambda

```python
# Todo comienza con esta firma — NUNCA cambiar el nombre del parametro "handler"
# Puedes cambiar "handler" a cualquier nombre SI lo configuras en la consola
def handler(event, context):
    # event: diccionario Python con el input que llego a la Lambda
    # context: objeto con metadata de la ejecucion (tiempo restante, request ID, etc.)
    
    # Leer datos del event con .get() para evitar KeyError si la clave no viene
    nombre = event.get("nombre", "Mundo")  # "Mundo" es el valor por defecto
    
    # Hacer algo con los datos
    mensaje = f"Hola desde Lambda, {nombre}!"
    
    # Siempre regresar un diccionario con statusCode
    # statusCode 200 = exito, 400 = error del cliente, 500 = error interno
    return {
        "statusCode": 200,         # codigo HTTP de respuesta
        "mensaje": mensaje         # el contenido que regresamos
    }
```

**Regla critica: el handler SIEMPRE debe regresar algo.** Si regresa `None`, la Lambda termina sin error pero el caller no recibe respuesta util.

### 10.3 Variables de entorno

Las variables de entorno permiten configurar la Lambda sin cambiar el codigo.

```python
import os  # modulo del sistema — necesario para leer variables de entorno

def handler(event, context):
    nombre = event.get("nombre", "Desconocida")
    
    # os.environ.get() devuelve None si la variable no existe (NO lanza error)
    # os.environ["CIUDAD"] lanzaria KeyError si no existe — evitar
    ciudad = os.environ.get("CIUDAD", "sin ciudad configurada")
    pais = os.environ.get("PAIS", "Mexico")  # valor por defecto: Mexico
    
    return {
        "statusCode": 200,
        "mensaje": f"Hola {nombre}! Mensaje desde {ciudad}, {pais}"
    }
```

En la consola AWS: `Lambda → tu-funcion → Configuration → Environment Variables`

**Por que usar variables de entorno:**
- El codigo va a GitHub — los secretos (passwords, API keys) NO deben estar en el codigo
- Puedes cambiar la configuracion sin re-deployar el codigo
- Diferente valor en dev vs produccion (mismo codigo, diferente config)

### 10.4 Leer datos del event correctamente

```python
def handler(event, context):
    # event puede ser cualquier JSON valido
    # Ejemplo event: {"numeros": [10, 20, 30, 40, 50], "operacion": "promedio"}
    
    # SIEMPRE usar .get() con valor por defecto en lugar de event["clave"]
    numeros = event.get("numeros", [])   # si no viene, lista vacia
    operacion = event.get("operacion", "suma")  # si no viene, "suma" por defecto
    
    # Validar que los datos tienen sentido antes de procesarlos
    if not numeros:
        # statusCode 400: el error es del cliente (mando datos invalidos)
        return {"statusCode": 400, "error": "Se requiere una lista de numeros"}
    
    if operacion == "suma":
        resultado = sum(numeros)           # sum() es funcion built-in de Python
    elif operacion == "promedio":
        resultado = sum(numeros) / len(numeros)  # division de enteros → float
    elif operacion == "maximo":
        resultado = max(numeros)           # max() devuelve el mayor
    else:
        return {"statusCode": 400, "error": f"Operacion '{operacion}' no reconocida"}
    
    return {
        "statusCode": 200,
        "operacion": operacion,            # regresamos que operacion se hizo
        "resultado": resultado,            # el valor calculado
        "cantidad_numeros": len(numeros)   # cuantos numeros procese
    }
```

### 10.5 Logs con CloudWatch

Dentro de una Lambda, `print()` escribe automaticamente a CloudWatch:

```python
import json  # para convertir diccionarios a texto legible

def handler(event, context):
    # Este print aparece en CloudWatch Logs — util para debug
    print(f"Lambda iniciada. Event: {json.dumps(event)}")
    
    nombre = event.get("nombre", "Mundo")
    
    # Log de cada paso importante
    print(f"Procesando solicitud para: {nombre}")
    
    resultado = f"Hola, {nombre}!"
    
    # Log del resultado antes de regresar
    print(f"Respuesta generada: {resultado}")
    
    return {"statusCode": 200, "mensaje": resultado}
```

**Ver los logs:** Consola AWS → Lambda → Monitor → View CloudWatch logs → Log streams → clic en el mas reciente

### 10.6 Deploy desde CLI (reto)

```bash
# Empaquetar el codigo en un zip
zip funcion.zip lambda_function.py

# Crear la Lambda desde CLI (necesita el ARN del rol IAM que creamos en S9)
aws lambda create-function \
  --function-name jess-calculadora \
  --runtime python3.12 \
  --handler lambda_function.handler \
  --role arn:aws:iam::TU_CUENTA:role/jess-lambda-role \
  --zip-file fileb://funcion.zip \
  --region us-east-1

# Invocar la Lambda y ver la respuesta
aws lambda invoke \
  --function-name jess-calculadora \
  --payload '{"numeros": [10, 20, 30], "operacion": "promedio"}' \
  --region us-east-1 \
  respuesta.json

# Ver la respuesta
cat respuesta.json
# Resultado esperado: {"statusCode": 200, "operacion": "promedio", "resultado": 20.0, ...}

# Actualizar el codigo sin borrar la funcion
zip funcion.zip lambda_function.py
aws lambda update-function-code \
  --function-name jess-calculadora \
  --zip-file fileb://funcion.zip \
  --region us-east-1
```

---

## Errores comunes y como corregirlos

### Error 1: KeyError al leer el event

```python
# MAL — lanza KeyError si "nombre" no viene en el event
nombre = event["nombre"]

# BIEN — devuelve "Mundo" si "nombre" no existe
nombre = event.get("nombre", "Mundo")
```

**Por que pasa:** El event puede llegar con diferentes campos dependiendo de quien lo invoca. Siempre usar `.get()`.

### Error 2: Handler con nombre incorrecto

```python
# MAL — si en la consola dice "lambda_function.handler" pero defines esto:
def mi_funcion(event, context):  # Lambda no la encuentra
    ...

# BIEN — el nombre en la consola debe coincidir con la funcion en el codigo
def handler(event, context):  # coincide con "lambda_function.handler"
    ...
```

**Por que pasa:** La consola AWS tiene un campo "Handler" que dice `archivo.funcion`. Si el nombre no coincide, la Lambda falla con "Handler not found".

### Error 3: Importar modulos que no existen en Lambda

```python
# MAL — pandas no esta instalado por defecto en Lambda
import pandas as pd

# BIEN — usar solo modulos que vienen en Python por defecto: os, json, uuid, datetime
import json   # OK — viene incluido
import os     # OK — viene incluido
import uuid   # OK — viene incluido
```

**Por que pasa:** Lambda tiene un ambiente limpio de Python. Solo los modulos de la libreria estandar estan disponibles. Para instalar modulos externos (boto3, requests, etc.) se necesitan Lambda Layers.

**Excepcion:** `boto3` SI viene instalado por defecto en Lambda — es el SDK de AWS.

### Error 4: No manejar excepciones

```python
# MAL — si json.loads falla, Lambda devuelve error 500 sin mensaje util
def handler(event, context):
    body = json.loads(event["body"])
    return {"statusCode": 200, "datos": body}

# BIEN — capturar excepciones y devolver mensajes claros
def handler(event, context):
    try:
        body = json.loads(event.get("body", "{}"))
        return {"statusCode": 200, "datos": body}
    except json.JSONDecodeError as e:
        return {"statusCode": 400, "error": f"JSON invalido: {str(e)}"}
    except Exception as e:
        print(f"Error inesperado: {e}")  # se guarda en CloudWatch
        return {"statusCode": 500, "error": "Error interno"}
```

---

## Ejercicios de la semana

### Ejercicio 1 — Primera Lambda (consola)
Crear una Lambda `jess-hola-mundo` en Python 3.12. Configurar un evento de prueba `{"nombre": "Jess"}`. La respuesta debe incluir `"Hola desde Lambda, Jess!"`.

### Ejercicio 2 — Variables de entorno
Agregar variables de entorno `CIUDAD="Ciudad de Mexico"` y `PAIS="Mexico"` a la Lambda. El handler debe leerlas con `os.environ.get()` y incluirlas en la respuesta.

### Ejercicio 3 — Calculadora Lambda (reto)
Crear una Lambda que recibe `{"numeros": [...], "operacion": "suma|promedio|maximo|minimo"}` y regresa el resultado. Manejar el caso de lista vacia con statusCode 400.

---
