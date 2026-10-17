---
semana: 10
tema: AWS Lambda — tu primera funcion serverless
estado: pendiente
---

# Practica Semana 10 — AWS Lambda: codigo que corre solo

> Lee la teoria en `02_Teoria/semana-10.md` antes de empezar.
> Guarda tu codigo en: `codigo/semana-10/`

---

## Ejercicio 1 — Primera Lambda desde la consola (obligatorio)

1. Abre la consola AWS → Lambda → Create Function
2. Nombre: `jess-hola-mundo`
3. Runtime: Python 3.12
4. Copia este codigo:

```python
def handler(event, context):
    nombre = event.get("nombre", "Desconocida")
    return {
        "statusCode": 200,
        "mensaje": f"Hola desde Lambda, {nombre}!"
    }
```

5. Crea un evento de prueba: `{"nombre": "Jess"}`
6. Ejecuta y verifica que regresa el mensaje correcto

En `notas.md` escribe:
- Cuanto tardo en ejecutarse (ver el log)
- Que dice el campo "Duration"
- Que ves en CloudWatch Logs

---

## Ejercicio 2 — Lambda con variables de entorno (obligatorio)

Modifica tu Lambda `jess-hola-mundo`:

1. Ve a Configuration → Environment Variables
2. Agrega: `CIUDAD = "Ciudad de Mexico"`
3. Agrega: `PAIS = "Mexico"`

Modifica el codigo para usar esas variables:

```python
import os

def handler(event, context):
    nombre = event.get("nombre", "Desconocida")
    ciudad = os.environ.get("CIUDAD", "sin ciudad")
    return {
        "statusCode": 200,
        "mensaje": f"Hola {nombre}! Escribiendo desde {ciudad}"
    }
```

Prueba de nuevo y verifica que usa las variables.

---

## Ejercicio 3 — Deploy desde CLI (reto)

Crea `lambda_function.py` localmente con este contenido:

```python
import json

def handler(event, context):
    numeros = event.get("numeros", [])
    if not numeros:
        return {"statusCode": 400, "error": "Lista vacia"}
    promedio = sum(numeros) / len(numeros)
    return {
        "statusCode": 200,
        "promedio": promedio,
        "maximo": max(numeros),
        "minimo": min(numeros)
    }
```

Deploy via CLI:
```bash
zip function.zip lambda_function.py
aws lambda create-function \
    --function-name jess-estadisticas \
    --runtime python3.12 \
    --role arn:aws:iam::TU_ACCOUNT_ID:role/TU_ROL \
    --handler lambda_function.handler \
    --zip-file fileb://function.zip
```

Prueba desde CLI:
```bash
aws lambda invoke \
    --function-name jess-estadisticas \
    --payload '{"numeros": [10, 20, 30, 40, 50]}' \
    response.json
cat response.json
```

---

## Reflexion

**¿Que ventaja tiene Lambda vs tener un servidor siempre prendido?**

_Tu respuesta:_

**¿Por que es importante usar variables de entorno en lugar de hardcodear datos?**

_Tu respuesta:_

**¿Que diferencias ves entre hacer deploy por consola vs por CLI?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-10 lambda-serverless"`
