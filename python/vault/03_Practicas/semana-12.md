---
semana: 12
tema: API Gateway + Lambda — proyecto final
estado: pendiente
---

# Practica Semana 12 — Proyecto Final: API Serverless completa

> Lee la teoria en `02_Teoria/semana-12.md` antes de empezar.
> Guarda tu codigo en: `codigo/semana-12/`
> Esta es la practica mas larga — date tiempo.

---

## Proyecto Final: API de Notas Personales

Construiras una API REST completa y 100% serverless usando:
- AWS Lambda (logica)
- API Gateway (endpoints HTTP)
- DynamoDB (base de datos)
- boto3 (SDK Python)

---

## Paso 1 — Crear tabla DynamoDB

1. Consola AWS → DynamoDB → Create Table
2. Table name: `notas-jess`
3. Partition key: `id` (String)
4. Deja todo lo demas en default
5. Create Table

---

## Paso 2 — Crear la Lambda

Crea `lambda_function.py` con el handler completo de la teoria (semana-12). Es tu punto de partida.

Rol IAM necesario:
- `dynamodb:PutItem`
- `dynamodb:GetItem`
- `dynamodb:DeleteItem`
- `dynamodb:Scan`

---

## Paso 3 — Crear API Gateway

1. API Gateway → Create API → HTTP API
2. Integration: Lambda → seleccionar tu Lambda
3. Routes:
   - `GET /notas`
   - `POST /notas`
   - `DELETE /notas/{id}`
4. Deploy → Stage: `dev`
5. Copia tu URL

---

## Paso 4 — Probar la API (obligatorio)

Con `curl` o Postman, prueba cada endpoint:

```bash
BASE="https://tu-url.execute-api.us-east-1.amazonaws.com/dev"

# Crear 3 notas
curl -X POST $BASE/notas -H "Content-Type: application/json" \
    -d '{"titulo": "Primera nota", "contenido": "Aprendi Lambda"}'

curl -X POST $BASE/notas -H "Content-Type: application/json" \
    -d '{"titulo": "Segunda nota", "contenido": "S3 es util"}'

curl -X POST $BASE/notas -H "Content-Type: application/json" \
    -d '{"titulo": "Tercera nota", "contenido": "DynamoDB es NoSQL"}'

# Listar todas
curl $BASE/notas

# Eliminar una (copia el id de la respuesta anterior)
curl -X DELETE $BASE/notas/ID_AQUI
```

Escribe en `notas.md` los resultados que obtuviste.

---

## Paso 5 — Mejora opcional (reto)

Agrega un endpoint `GET /notas/{id}` que regrese solo una nota especifica o 404 si no existe.

---

## Reflexion Final del Curso

**¿Que fue lo mas dificil de este curso?**

_Tu respuesta:_

**¿Que fue lo que mas te gusto?**

_Tu respuesta:_

**¿Que parte te gustaria profundizar mas?**

_Tu respuesta:_

**¿Te sientes lista para el Curso 3 de Seguridad?**

_Tu respuesta:_

---

> Felicidades. Tienes una API real, corriendo en AWS, sin servidor propio. Eso es exactamente lo que Carlos hace profesionalmente.

Al terminar: `bash scripts/push.sh "semana-12 proyecto-final COMPLETADO"`
