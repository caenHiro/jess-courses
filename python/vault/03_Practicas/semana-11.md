---
semana: 11
tema: S3 + Lambda + boto3
estado: pendiente
---

# Practica Semana 11 — S3: archivos en la nube

> Lee la teoria en `02_Teoria/semana-11.md` antes de empezar.
> Guarda tu codigo en: `codigo/semana-11/`

---

## Ejercicio 1 — Subir y listar archivos (obligatorio)

1. Crea un bucket S3 desde la consola: `jess-practica-2026` (o agrega tus iniciales)
2. Crea `s3_basico.py`:

```python
import boto3

s3 = boto3.client("s3", region_name="us-east-1")
BUCKET = "jess-practica-2026"

# Subir un archivo de texto
with open("mensaje.txt", "w") as f:
    f.write("Hola desde S3! Esto lo guardo en la nube.")

s3.upload_file("mensaje.txt", BUCKET, "mis-archivos/mensaje.txt")
print("Archivo subido.")

# Listar
response = s3.list_objects_v2(Bucket=BUCKET)
for obj in response.get("Contents", []):
    print(f"- {obj['Key']} ({obj['Size']} bytes)")

# Descargar
s3.download_file(BUCKET, "mis-archivos/mensaje.txt", "descargado.txt")
with open("descargado.txt") as f:
    print("Contenido descargado:", f.read())
```

---

## Ejercicio 2 — Lambda que procesa archivos de S3 (obligatorio)

Crea una Lambda `jess-procesar-txt` que se active cuando subes un `.txt` a S3.

Handler:
```python
import boto3

def handler(event, context):
    s3 = boto3.client("s3")
    for registro in event["Records"]:
        bucket = registro["s3"]["bucket"]["name"]
        clave = registro["s3"]["object"]["key"]
        print(f"Procesando: {clave}")
        response = s3.get_object(Bucket=bucket, Key=clave)
        contenido = response["Body"].read().decode("utf-8")
        lineas = contenido.split("\n")
        print(f"El archivo tiene {len(lineas)} lineas")
        return {"lineas": len(lineas), "archivo": clave}
```

Pasos:
1. Crea la Lambda con el handler de arriba
2. Agrega trigger: S3 → tu bucket → Event: PUT
3. Asegurate de que el rol tenga permiso `s3:GetObject`
4. Sube un archivo `.txt` al bucket
5. Ve a CloudWatch Logs y verifica que la Lambda se ejecuto

---

## Ejercicio 3 — URL pre-firmada (reto)

Agrega a `s3_basico.py` una funcion que genere una URL pre-firmada para descargar un archivo sin necesitar credenciales AWS:

```python
def generar_url_temporal(bucket, clave, segundos=3600):
    url = s3.generate_presigned_url(
        "get_object",
        Params={"Bucket": bucket, "Key": clave},
        ExpiresIn=segundos
    )
    print(f"URL valida por {segundos}s: {url}")
    return url
```

Genera la URL y abrete en el navegador para verificar que funciona.

---

## Reflexion

**¿Para que tipo de datos usarias S3 vs una BD relacional como PostgreSQL?**

_Tu respuesta:_

**¿Que significa "pre-firmada" en una URL de S3?**

_Tu respuesta:_

**¿Como detecta S3 que tipo de archivo se subio para activar la Lambda correcta?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-11 s3-lambda-boto3"`
