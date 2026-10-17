# Semana 9 — AWS: cuenta, IAM y la consola

> Tiempo estimado: 3–5 horas
> Al terminar: `bash scripts/push.sh "semana-09 aws — cuenta e iam"`

---


---

## Objetivo de la semana

Al terminar, Al terminar esta semana debes poder:
- Crear y configurar una cuenta AWS con Free Tier
- Entender la diferencia entre root user, IAM user y roles
- Crear un usuario IAM con permisos adecuados
- Instalar y configurar AWS CLI con sus credenciales
- Verificar la conexion con `aws sts get-caller-identity`
- Entender los servicios AWS que usara en semanas 10-12

**Esta semana es mas de configuracion y lectura que de codigo. El enfoque es: entender AWS, configurar el entorno, no meter mano en nada que cueste dinero.**

---

## Analogia clave 

> "AWS es como el edificio de apartamentos de la CDMX mas grande del mundo. Tu rentas el espacio que necesitas (Lambda, S3, EC2) y solo pagas por lo que ocupas. El dueno del edificio (Amazon) se encarga de luz, agua, seguridad y mantenimiento — tu solo te preocupas por lo que pones en tu apartamento."

> "IAM es como el seguridad del edificio: decide quien puede entrar, a que pisos puede acceder, y que puede hacer en cada area. Root user = dueno del edificio (acceso total a todo). IAM user = residente con llave solo de su piso. Role = pase de visitante temporal con permisos especificos."

> "El Free Tier es como la prueba gratis de Netflix: te dan acceso a todo por 12 meses con limites. Si te pasas del limite, te cobran. Por eso es CRITICO configurar las alertas de billing desde el primer dia."

---

## Contenido teorico

### 9.1 Crear la cuenta AWS

1. Ir a `https://aws.amazon.com`
2. Clic en "Crear una cuenta de AWS"
3. Email, contrasena, nombre de cuenta
4. Tipo de cuenta: **Personal**
5. Datos de pago (tarjeta de credito/debito — necesaria aunque el Free Tier es gratis)
6. Verificacion por SMS
7. Plan: **Gratis (Free Tier)**

**Inmediatamente despues de crear la cuenta:**

```
Consola AWS → Billing → Billing Preferences
✓ Receive Free Tier Usage Alerts (alerta cuando te acercas al limite)
✓ Receive Billing Alerts
```

Luego crear una alerta de presupuesto:
```
Consola AWS → Billing → Budgets → Create Budget
→ Cost Budget → $5 USD monthly
→ Alerta al 80% (cuando gaste $4 USD)
```

**Si Jess no tiene tarjeta:** puede pedir a un familiar, o usar una tarjeta de debito con capacidad internacional (BBVA, Banorte, HSBC la tienen).

### 9.2 IAM — Identidad y Acceso

IAM controla QUIEN puede hacer QUE en la cuenta AWS.

**Conceptos clave:**

| Concepto | Que es | Cuando usar |
|----------|--------|------------|
| Root user | La cuenta original — acceso total | Solo para configuracion inicial |
| IAM User | Usuario con permisos especificos | Para trabajo cotidiano — SIEMPRE |
| IAM Role | Permisos temporales para servicios | Para dar permisos a Lambda, EC2, etc. |
| IAM Policy | Documento JSON que define permisos | Se adjunta a users o roles |

**Regla de oro: NUNCA usar el root user para trabajo cotidiano.** Solo usarlo para:
- Crear el primer IAM admin
- Cambiar el plan de pago
- Borrar la cuenta

### 9.3 Crear tu primer usuario IAM

En la consola AWS:

```
IAM → Users → Create User

Nombre del usuario: jess-dev
Acceso: AWS Management Console (para usar la consola web)
        Access key (para usar el CLI)

Permisos: Adjuntar policy directamente
          → AdministratorAccess (para aprender — en produccion seria mas restrictivo)

Crear Access Key:
IAM → Users → jess-dev → Security Credentials → Create Access Key
→ Caso de uso: Command Line Interface (CLI)
→ Guardar el Access Key ID y Secret Access Key (solo se muestran una vez!)
```

### 9.4 AWS CLI — controlar AWS desde la terminal

```bash
# Instalar AWS CLI
pip install awscli

# O en Mac con brew:
brew install awscli

# Verificar instalacion
aws --version

# Configurar con las credenciales de tu usuario IAM
aws configure
# AWS Access Key ID [None]: AKIA...  (el que copiaste al crear el access key)
# AWS Secret Access Key [None]: ...  (el secret — guardalo bien, no se puede recuperar)
# Default region name [None]: us-east-1
# Default output format [None]: json

# Verificar que funciona — devuelve info del usuario actual
aws sts get-caller-identity
# Respuesta exitosa:
# {
#     "UserId": "AIDA...",
#     "Account": "123456789012",
#     "Arn": "arn:aws:iam::123456789012:user/jess-dev"
# }
```

### 9.5 Servicios AWS del curso

| Servicio | Para que | Cuando lo usaremos |
|---------|----------|-------------------|
| **Lambda** | Codigo sin servidor | Semana 10, 11, 12 |
| **S3** | Almacenamiento de archivos | Semana 11 |
| **API Gateway** | Exponer Lambda como API HTTP | Semana 12 |
| **DynamoDB** | Base de datos NoSQL serverless | Semana 12 |
| **IAM** | Usuarios y permisos | Esta semana + siempre |
| **CloudWatch** | Logs y monitoreo | Semana 10 en adelante |

### 9.6 Modelo de precios AWS (para no llevarse sorpresas)

AWS cobra por uso. Los servicios que usaremos en el curso:

**Lambda:**
- Free Tier: 1,000,000 invocaciones/mes
- Precio despues del free tier: $0.20 por millon de invocaciones
- Para practicas: imposible salir del free tier

**S3:**
- Free Tier: 5 GB de almacenamiento por 12 meses
- Precio: $0.023 por GB/mes despues del free tier
- Para practicas con archivos pequenos: gratis

**DynamoDB:**
- Free Tier permanente: 25 GB de almacenamiento, 25 WCU/RCU
- Para practicas: gratis para siempre

**CloudWatch:**
- Free Tier: 10 metricas personalizadas, 3 dashboards
- Para ver logs de Lambda: gratis

**API Gateway:**
- Free Tier: 1,000,000 llamadas de API/mes por 12 meses
- Para practicas: gratis

---

## Errores comunes

1. **Usar el root user para todo:** es el error de seguridad mas grave en AWS. Crear un IAM user desde el primer dia y usar ese.

2. **No configurar alertas de billing:** pueden llegar cargos inesperados si por error se deja un recurso corriendo (ej: una instancia EC2 que no se apaga). Configurar alertas es lo primero.

3. **Perder el Access Key ID y Secret Access Key:** el secret solo se muestra una vez al crearlo. Si se pierde, hay que crear uno nuevo. Nunca subir las credenciales a GitHub.

4. **Dejar recursos corriendo que cuestan dinero:** EC2 (maquinas virtuales) cobran por hora aunque no las uses. Para el curso usar solo Lambda, S3, DynamoDB — son serverless y pagan por uso real.

5. **Region incorrecta:** algunas cosas que se crean en `us-east-1` no aparecen cuando ves otra region. Siempre verificar que la region en la consola sea `us-east-1` (o la que eligieron).

6. **No hacer `aws configure` con las credenciales del IAM user:** si se configuran con las del root, es mala practica y puede ser riesgoso.

---

## Soluciones / Checklist de la semana

Esta semana no tiene codigo como tal — es configuracion. El entregable es un checklist verificado:

### Checklist semana 9

```
Cuenta AWS:
[ ] Cuenta creada y email verificado
[ ] Tarjeta registrada (o confirmacion de que no tiene aun)
[ ] Alerta de Free Tier activada (Billing Preferences)
[ ] Alerta de presupuesto de $5 USD configurada (Budgets)

IAM:
[ ] Usuario IAM "jess-dev" creado
[ ] Policy AdministratorAccess adjuntada
[ ] Access Key generada y guardada en lugar seguro (NO en GitHub)
[ ] Root user: MFA (autenticacion de dos factores) activado (recomendado)

AWS CLI:
[ ] AWS CLI instalado (verificar con: aws --version)
[ ] Credenciales configuradas con: aws configure
[ ] Comando aws sts get-caller-identity devuelve respuesta exitosa con el ARN de jess-dev

Exploracion de la consola:
[ ] Consola visitada: Lambda, S3, DynamoDB, API Gateway, CloudWatch
[ ] Region seleccionada: us-east-1
```

### Script de verificacion

```python
# verificar_aws.py — verificar que AWS CLI esta configurado correctamente
import subprocess
import json

def verificar_aws():
    """Verifica que AWS CLI este configurado y funcionando."""
    print("=== Verificacion de AWS CLI ===\n")

    try:
        # Ejecutar aws sts get-caller-identity
        resultado = subprocess.run(
            ["aws", "sts", "get-caller-identity"],
            capture_output=True,    # capturar la salida
            text=True               # devolver como texto (no bytes)
        )

        if resultado.returncode == 0:
            # Parsear el JSON de respuesta
            datos = json.loads(resultado.stdout)
            print("Conexion exitosa!")
            print(f"Usuario: {datos['Arn']}")
            print(f"Cuenta AWS: {datos['Account']}")
            print(f"User ID: {datos['UserId']}")
        else:
            print("Error de conexion:")
            print(resultado.stderr)

    except FileNotFoundError:
        print("AWS CLI no esta instalado.")
        print("Instalar con: pip install awscli")

verificar_aws()
```

### Exploracion guiada de la consola

Durante la clase, recorrer estos servicios en la consola AWS:

1. **Lambda** — mostrar donde se crean funciones, el editor de codigo, los logs
2. **S3** — mostrar donde se crean buckets, como se ven los archivos
3. **DynamoDB** — mostrar la interfaz de tablas
4. **CloudWatch** — mostrar los log groups (donde apareceran los logs de Lambda)
5. **IAM** — mostrar Users, Roles, Policies

---
