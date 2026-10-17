# Semana 12 — Proyecto Final: API Serverless con Lambda + API Gateway + DynamoDB

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-12 api serverless"`

---


---

## Objetivo de la semana

Al terminar, Jess debe tener una API funcional en la nube que:
- Recibe peticiones HTTP (GET, POST, DELETE) via API Gateway
- Las procesa con una Lambda en Python
- Guarda y lee datos en DynamoDB (base de datos serverless)
- Regresa respuestas JSON correctas con statusCode adecuado

**Esta semana integra todo:** es el proyecto final del curso

---

## Analogia clave 

> "API Gateway es el portero del edificio. Cuando alguien llama al timbre (hace una peticion HTTP), el portero revisa si tiene permiso, y si lo tiene, le dice a la Lambda: 'oye, alguien quiere entrar y quiere hacer esto'. La Lambda procesa la solicitud y le devuelve la respuesta al portero, quien se la da al cliente."

> "DynamoDB es una cajeta de fichas de catalogo de biblioteca. Cada ficha (item) tiene un ID unico (partition key) y puedes guardar cualquier dato adicional sin un esquema fijo. No necesitas definir columnas como en MySQL — cada ficha puede tener campos diferentes. La ventaja: escala sola y no necesitas administrar servidor."

> "La funcion `resp()` es como el molde de una taquiza: siempre el mismo formato (tortilla + relleno + salsa), pero el contenido cambia. statusCode es la tortilla, los headers son la salsa, y el body es el relleno. Siempre el mismo molde, diferente contenido."

---

## Contenido teorico

### 12.1 DynamoDB — base de datos serverless

DynamoDB es una base de datos NoSQL gestionada por AWS: sin servidor que administrar, escala sola.

| Concepto DynamoDB | Equivalente SQL | Notas |
|---|---|---|
| Tabla | Tabla | Nombre unico en la cuenta |
| Item | Fila/registro | Cada item puede tener campos diferentes |
| Attribute | Columna | No hay esquema fijo — flexible |
| Partition Key | Primary Key | Campo obligatorio que identifica cada item |

**Crear tabla DynamoDB en consola:**
1. DynamoDB → Create table
2. Table name: `notas-jess`
3. Partition key: `id` (tipo: String)
4. Table settings: Default settings
5. Create table

### 12.2 Operaciones DynamoDB con boto3

```python
import boto3      # SDK de AWS para Python
import json       # para serializar/deserializar JSON
import uuid       # para generar IDs unicos
from datetime import datetime  # para guardar la fecha de creacion

# Conectar a DynamoDB con boto3.resource (interfaz de alto nivel)
dynamodb = boto3.resource("dynamodb")

# Referencia a la tabla — NO crea la tabla, solo apunta a la existente
tabla = dynamodb.Table("notas-jess")

# ── Guardar un item (PUT) ─────────────────────────────────────────────────────
nota = {
    "id": str(uuid.uuid4()),          # ID unico: "550e8400-e29b-41d4-a716-446655440000"
    "titulo": "Mi primera nota",       # campo texto
    "contenido": "Hola desde Python!", # campo texto opcional
    "fecha": datetime.now().isoformat() # fecha en formato ISO: "2026-06-25T10:30:00"
}
tabla.put_item(Item=nota)  # guarda el item completo — si ya existe, lo reemplaza
print(f"Nota guardada con ID: {nota['id']}")

# ── Leer un item por ID (GET) ──────────────────────────────────────────────────
respuesta = tabla.get_item(Key={"id": nota["id"]})  # buscar por la partition key
item = respuesta.get("Item")  # .get() porque si no existe, no hay "Item" en la respuesta

if item:
    print(f"Titulo: {item['titulo']}")
else:
    print("Nota no encontrada")

# ── Listar todos los items (SCAN) ──────────────────────────────────────────────
# Scan recorre TODA la tabla — eficiente para tablas pequenas, lento para grandes
respuesta = tabla.scan()
items = respuesta.get("Items", [])  # lista vacia si la tabla esta vacia
print(f"Total de notas: {len(items)}")
for item in items:
    print(f"- [{item['id']}] {item['titulo']}")

# ── Eliminar un item (DELETE) ──────────────────────────────────────────────────
tabla.delete_item(Key={"id": nota["id"]})  # eliminar por partition key
print("Nota eliminada")
```

### 12.3 Funcion helper para respuestas HTTP

Una funcion `resp()` que centraliza el formato de respuesta evita repetir codigo:

```python
import json

def resp(status, body):
    # Todas las respuestas de Lambda para API Gateway deben tener este formato
    return {
        "statusCode": status,      # codigo HTTP: 200=OK, 201=creado, 400=error, 404=no encontrado
        "headers": {
            "Content-Type": "application/json",  # indicar que la respuesta es JSON
            "Access-Control-Allow-Origin": "*"   # permitir llamadas desde el navegador (CORS)
        },
        # json.dumps convierte el diccionario Python a texto JSON
        # ensure_ascii=False: permite acentos y caracteres especiales en espanol
        "body": json.dumps(body, ensure_ascii=False)
    }

# Ejemplos de uso:
resp(200, {"mensaje": "OK"})              # respuesta exitosa
resp(201, {"id": "abc123"})               # recurso creado
resp(400, {"error": "Titulo requerido"})  # error del cliente
resp(404, {"error": "No encontrado"})     # recurso no existe
resp(500, {"error": "Error interno"})     # error del servidor
```

### 12.4 Lambda handler completo — API REST

```python
import boto3
import json
import uuid
from datetime import datetime

# Crear la conexion a DynamoDB al inicio (fuera del handler)
# Esto permite reutilizar la conexion entre invocaciones de la misma Lambda
dynamodb = boto3.resource("dynamodb")
tabla = dynamodb.Table("notas-jess")  # apuntar a la tabla creada en DynamoDB

def handler(event, context):
    # API Gateway envia el metodo HTTP y el path en el event
    metodo = event.get("httpMethod", "")      # "GET", "POST", "DELETE"
    path = event.get("path", "")              # "/notas" o "/notas/abc123"
    # pathParameters viene cuando el path tiene variables: /notas/{id}
    path_params = event.get("pathParameters") or {}  # el "or {}" evita que sea None
    
    # Envolver todo en try/except para capturar errores inesperados
    try:
        # Ruteo: decidir que hacer segun el metodo y el path
        if metodo == "GET" and path == "/notas":
            return listar_notas()               # listar todas
        elif metodo == "POST" and path == "/notas":
            body = json.loads(event.get("body", "{}"))  # parsear el body del request
            return crear_nota(body)             # crear nueva nota
        elif metodo == "GET" and "id" in path_params:
            return obtener_nota(path_params["id"])  # obtener una por ID
        elif metodo == "DELETE" and "id" in path_params:
            return eliminar_nota(path_params["id"])  # eliminar por ID
        else:
            return resp(404, {"error": f"Ruta no encontrada: {metodo} {path}"})
    except Exception as e:
        # Loguear el error en CloudWatch para debug
        print(f"Error inesperado: {e}")
        return resp(500, {"error": "Error interno del servidor"})

def listar_notas():
    # scan() recorre toda la tabla y devuelve todos los items
    respuesta = tabla.scan()
    return resp(200, respuesta.get("Items", []))  # lista vacia si no hay notas

def crear_nota(datos):
    # Validar que el titulo viene — es el campo minimo requerido
    if not datos.get("titulo"):
        return resp(400, {"error": "El titulo es requerido"})
    
    nota = {
        "id": str(uuid.uuid4()),                    # ID unico generado automaticamente
        "titulo": datos["titulo"],                   # titulo del request
        "contenido": datos.get("contenido", ""),     # contenido opcional — "" si no viene
        "fecha": datetime.now().isoformat()          # fecha de creacion en ISO format
    }
    tabla.put_item(Item=nota)   # guardar en DynamoDB
    return resp(201, nota)      # 201 = creado exitosamente

def obtener_nota(nota_id):
    # get_item busca por partition key — muy rapido
    respuesta = tabla.get_item(Key={"id": nota_id})
    nota = respuesta.get("Item")   # None si no existe
    if not nota:
        return resp(404, {"error": f"Nota con ID '{nota_id}' no encontrada"})
    return resp(200, nota)

def eliminar_nota(nota_id):
    # delete_item no falla si el item no existe — elimina silenciosamente
    tabla.delete_item(Key={"id": nota_id})
    return resp(204, {})   # 204 = eliminado, sin contenido en la respuesta

def resp(status, body):
    return {
        "statusCode": status,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
        },
        "body": json.dumps(body, ensure_ascii=False)
    }
```

### 12.5 Configurar API Gateway

1. Consola AWS → API Gateway → Create API
2. Elegir: **HTTP API** (mas simple que REST API)
3. Add integration: Lambda → seleccionar la funcion `notas-jess`
4. Configurar rutas:
   - `GET /notas` → Lambda
   - `POST /notas` → Lambda
   - `GET /notas/{id}` → Lambda
   - `DELETE /notas/{id}` → Lambda
5. Stage: `$default` (autodeployment)
6. Create

### 12.6 Probar la API con curl

```bash
# Guardar la URL base del API Gateway (se muestra al crearlo)
BASE_URL="https://abc123.execute-api.us-east-1.amazonaws.com"

# Crear una nota (POST)
curl -X POST "$BASE_URL/notas" \
  -H "Content-Type: application/json" \
  -d '{"titulo": "Primera nota", "contenido": "Hola desde el proyecto final!"}'
# Respuesta esperada: {"id": "uuid-...", "titulo": "Primera nota", ...}

# Guardar el ID de la nota creada (copiar del resultado anterior)
ID="el-uuid-que-devolvio-post"

# Listar todas las notas (GET)
curl "$BASE_URL/notas"
# Respuesta esperada: [{"id": "...", "titulo": "Primera nota", ...}]

# Obtener una nota por ID (GET /{id})
curl "$BASE_URL/notas/$ID"
# Respuesta esperada: la nota con ese ID

# Eliminar la nota (DELETE)
curl -X DELETE "$BASE_URL/notas/$ID"
# Respuesta esperada: statusCode 204, body vacio

# Verificar que fue eliminada (debe dar 404)
curl "$BASE_URL/notas/$ID"
# Respuesta esperada: {"error": "Nota con ID '...' no encontrada"}
```

### 12.7 Permisos IAM para DynamoDB

Agregar esta policy al rol de la Lambda:

```json
{
    "Effect": "Allow",
    "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:DeleteItem",
        "dynamodb:Scan"
    ],
    "Resource": "arn:aws:dynamodb:us-east-1:TU_CUENTA:table/notas-jess"
}
```

---

## Errores comunes y como corregirlos

### Error 1: body llega como string, no como diccionario

```python
# MAL — event["body"] es un string JSON, no un diccionario
datos = event["body"]
titulo = datos["titulo"]  # TypeError: string indices must be integers

# BIEN — parsear el body con json.loads primero
body_texto = event.get("body", "{}")  # texto JSON como string
datos = json.loads(body_texto)         # convertir a diccionario Python
titulo = datos.get("titulo")           # ahora si funciona
```

### Error 2: pathParameters llega como None

```python
# MAL — si no hay path params, pathParameters es None (no un dict vacio)
nota_id = event["pathParameters"]["id"]  # TypeError: 'NoneType' is not subscriptable

# BIEN — usar "or {}" para manejar el caso None
path_params = event.get("pathParameters") or {}
nota_id = path_params.get("id")  # None si no hay id en el path
```

### Error 3: DynamoDB devuelve Decimal en lugar de float

```python
# DynamoDB guarda numeros como Decimal, no como float
# json.dumps falla con Decimal
respuesta = tabla.scan()
return json.dumps(respuesta["Items"])  # Error: Object of type Decimal is not JSON serializable

# BIEN — convertir Decimal a float antes de serializar
from decimal import Decimal
def decimal_a_float(obj):
    if isinstance(obj, Decimal):
        return float(obj)  # convertir Decimal a float para JSON
    raise TypeError

return json.dumps(respuesta["Items"], default=decimal_a_float)
```

### Error 4: CORS bloqueado en el navegador

```
Access to fetch at '...' from origin '...' has been blocked by CORS policy
```

**Causa:** Las respuestas no incluyen el header `Access-Control-Allow-Origin`.
**Solucion:** Agregar el header en TODAS las respuestas (incluidas las de error):

```python
"headers": {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*"  # permitir cualquier origen
}
```

---

## Ejercicios de la semana (Proyecto Final)

### Ejercicio 1 — CRUD basico
Implementar `POST /notas`, `GET /notas` y `DELETE /notas/{id}`. Probar con curl.

### Ejercicio 2 — Validacion y errores
Agregar validacion: titulo requerido (400 si falta), nota no encontrada (404), error interno (500).

### Ejercicio 3 — Documentar con curl (reto)
Crear un archivo `notas.md` con los comandos curl usados para probar la API, con los resultados esperados y los resultados reales obtenidos.

---
