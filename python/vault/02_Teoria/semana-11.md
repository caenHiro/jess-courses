# Semana 11 — S3 + boto3: guardar archivos en la nube

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-11 s3 + boto3"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Crear un bucket S3 desde la consola y desde CLI
- Subir, listar y descargar archivos con `boto3`
- Escribir una Lambda que lee archivos de S3 cuando llega un evento (trigger)
- Generar URLs temporales pre-firmadas para compartir archivos sin hacerlos publicos
- Entender los permisos IAM necesarios para que Lambda acceda a S3


---

## Analogia clave 

> "S3 es como una bodega de Amazon (coincidencia, literalmente). Un bucket es como un cuarto de la bodega que rentas: tiene un nombre unico en todo el mundo, y puedes meter archivos (objetos) de cualquier tipo y tamano. Cada objeto tiene una ruta (key) que es como la etiqueta del paquete: 'fotos/2026/enero/fiesta.jpg'."

> "boto3 es la grua que te permite mover cajas desde tu codigo Python a la bodega (S3). Sin la grua, tendrias que ir tu mismo a la bodega. Con boto3, le dices 'sube esta caja a la bodega X, ponla en el estante Y' y boto3 lo hace por ti."

> "Una URL pre-firmada es como un pase temporal para visitar la bodega sin ser empleado. Le dices a boto3: 'dame un pase para que mi cliente pueda ver el objeto X, pero que el pase expire en 1 hora'. Despues de una hora, el pase ya no sirve."

---

## Contenido teorico

### 11.1 Que es S3

S3 (Simple Storage Service) guarda archivos (objetos) en contenedores llamados buckets.

| Concepto | Equivalente local | Notas |
|---|---|---|
| Bucket | Carpeta raiz | El nombre es unico globalmente (entre todos los clientes AWS) |
| Object | Archivo | Puede ser imagen, PDF, JSON, CSV, codigo — cualquier cosa |
| Key | Ruta del archivo | `"fotos/2026/foto.jpg"` — la "/" no es carpeta real, es parte del nombre |
| Region | Ubicacion del servidor | Elegir la mas cercana: us-east-1 (Virginia) o us-west-2 (Oregon) |

**Free Tier S3:** 5 GB de almacenamiento gratis por 12 meses. Para practicas: imposible salir del free tier.

### 11.2 Crear cliente boto3

```python
import boto3   # SDK de AWS para Python — viene preinstalado en Lambda

# Forma 1: cliente de bajo nivel — mas control, mas verboso
# region_name: donde esta el bucket. Siempre especificar para evitar errores.
s3_cliente = boto3.client("s3", region_name="us-east-1")

# Forma 2: recurso de alto nivel — mas pythonica, menos control
s3_recurso = boto3.resource("s3", region_name="us-east-1")

# En Lambda: boto3 usa automaticamente las credenciales del rol IAM de la funcion
# En local: usa las credenciales configuradas con `aws configure`
```

### 11.3 Operaciones basicas con S3

```python
import boto3

# Crear cliente
s3 = boto3.client("s3", region_name="us-east-1")
BUCKET = "jess-practica-2026"  # cambiar por el nombre real del bucket

# ── Subir un archivo ──────────────────────────────────────────────────────────
# upload_file(archivo_local, nombre_bucket, nombre_en_s3)
# La "key" (nombre en S3) puede incluir "/" para simular carpetas
s3.upload_file("mensaje.txt", BUCKET, "mis-archivos/mensaje.txt")
print("Archivo subido a S3")

# ── Listar archivos del bucket ────────────────────────────────────────────────
# list_objects_v2 devuelve un diccionario con "Contents" si hay archivos
respuesta = s3.list_objects_v2(Bucket=BUCKET)

# .get("Contents", []) — si el bucket esta vacio, "Contents" no existe
for objeto in respuesta.get("Contents", []):
    clave = objeto["Key"]        # nombre/ruta del archivo
    tamano = objeto["Size"]      # tamano en bytes
    fecha = objeto["LastModified"]  # cuando se subio (datetime)
    print(f"- {clave} ({tamano} bytes, subido: {fecha})")

# ── Descargar un archivo ──────────────────────────────────────────────────────
# download_file(nombre_bucket, nombre_en_s3, destino_local)
s3.download_file(BUCKET, "mis-archivos/mensaje.txt", "descargado.txt")
with open("descargado.txt") as f:
    contenido = f.read()          # leer el contenido descargado
    print("Contenido:", contenido)

# ── Leer sin descargar (get_object) ──────────────────────────────────────────
# Util en Lambda donde no hay disco permanente
respuesta = s3.get_object(Bucket=BUCKET, Key="mis-archivos/mensaje.txt")
# .read() devuelve bytes — .decode("utf-8") los convierte a texto
contenido = respuesta["Body"].read().decode("utf-8")
print("Leido directo:", contenido)

# ── Borrar un archivo ──────────────────────────────────────────────────────────
s3.delete_object(Bucket=BUCKET, Key="mis-archivos/mensaje.txt")
print("Archivo eliminado")
```

### 11.4 Lambda con trigger S3

Una Lambda puede ejecutarse automaticamente cuando se sube un archivo a S3.

```python
import boto3

def handler(event, context):
    # Cuando S3 dispara la Lambda, el event viene con una lista de "Records"
    # Cada Record describe un archivo que se subio al bucket
    
    s3 = boto3.client("s3")  # en Lambda no necesitamos region — la detecta solo
    
    # event["Records"] es una lista — puede haber mas de un archivo a la vez
    for registro in event["Records"]:
        # Extraer el nombre del bucket y del archivo del event
        bucket = registro["s3"]["bucket"]["name"]   # nombre del bucket
        clave = registro["s3"]["object"]["key"]      # path del archivo subido
        
        print(f"Procesando archivo: {clave} del bucket: {bucket}")
        
        # Leer el contenido del archivo que se acaba de subir
        respuesta = s3.get_object(Bucket=bucket, Key=clave)
        # .read() devuelve bytes — .decode("utf-8") los convierte a texto
        contenido = respuesta["Body"].read().decode("utf-8")
        
        # Contar las lineas
        lineas = contenido.split("\n")
        cantidad = len(lineas)
        
        print(f"El archivo tiene {cantidad} lineas")
        
        # Regresar informacion del procesamiento
        return {
            "archivo": clave,
            "bucket": bucket,
            "lineas": cantidad
        }
```

**Configurar el trigger en la consola:**
1. Lambda → tu-funcion → Add trigger → S3
2. Bucket: seleccionar tu bucket
3. Event type: `s3:ObjectCreated:*` (se activa cuando se sube cualquier archivo)
4. Save

### 11.5 URL pre-firmada (acceso temporal)

```python
import boto3

s3 = boto3.client("s3", region_name="us-east-1")

def generar_url_temporal(bucket, clave, segundos=3600):
    # generate_presigned_url genera una URL que expira en `segundos` segundos
    # "get_object" significa que la URL sirve para DESCARGAR el archivo
    url = s3.generate_presigned_url(
        "get_object",                          # operacion: GET (descargar)
        Params={"Bucket": bucket, "Key": clave},  # que archivo
        ExpiresIn=segundos                     # cuantos segundos es valida
    )
    print(f"URL valida por {segundos} segundos:")
    print(url)
    return url

# Uso:
url = generar_url_temporal("jess-practica-2026", "mis-archivos/mensaje.txt")
# El receptor puede descargar el archivo con esta URL en su navegador
# Despues de 3600 segundos (1 hora), la URL expira y da 403 Forbidden
```

### 11.6 Permisos IAM para S3

La Lambda necesita un rol IAM con permisos para acceder a S3.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::jess-practica-2026",
                "arn:aws:s3:::jess-practica-2026/*"
            ]
        }
    ]
}
```

En la consola: IAM → Roles → el rol de tu Lambda → Add permissions → Attach policies → crear policy con el JSON de arriba.

---

## Errores comunes y como corregirlos

### Error 1: NoSuchBucket

```
botocore.exceptions.ClientError: An error occurred (NoSuchBucket) when calling the PutObject operation
```

**Causa:** El bucket no existe o el nombre tiene un typo.
**Solucion:** Verificar en la consola S3 que el bucket existe con ese nombre exacto. Los nombres son case-sensitive.

### Error 2: AccessDenied

```
botocore.exceptions.ClientError: An error occurred (AccessDenied) when calling the GetObject operation
```

**Causa:** El rol IAM de la Lambda no tiene permiso para acceder al bucket.
**Solucion:** Ir a IAM → Roles → el rol de la Lambda → agregar permisos S3.

### Error 3: Body.read() devuelve bytes

```python
# MAL — devuelve bytes: b"Hola mundo"
contenido = respuesta["Body"].read()
print(contenido)  # imprime b"Hola mundo" con la b al inicio

# BIEN — decodificar a texto
contenido = respuesta["Body"].read().decode("utf-8")
print(contenido)  # imprime "Hola mundo"
```

### Error 4: URL pre-firmada expirada

```
# El receptor recibe 403 Forbidden al intentar acceder a la URL
```

**Causa:** La URL pre-firmada expiro (el tiempo en `ExpiresIn` ya paso).
**Solucion:** Generar una URL nueva. Si las URLs expiran demasiado rapido, aumentar `ExpiresIn` (maximo: 7 dias para credenciales IAM de larga duracion).

---

## Ejercicios de la semana

### Ejercicio 1 — Subir y listar archivos
Crear un script Python local que cree un archivo `mensaje.txt`, lo suba a S3, liste todos los archivos del bucket y descargue el archivo.

### Ejercicio 2 — Lambda S3 trigger
Crear una Lambda que se active cuando se sube un `.txt` al bucket. La Lambda debe leer el contenido y loguear cuantas lineas tiene.

### Ejercicio 3 — URL pre-firmada (reto)
Agregar una funcion que genere una URL temporal valida por 1 hora para el archivo subido. Probar que la URL funciona en el navegador y que expira correctamente.

---
