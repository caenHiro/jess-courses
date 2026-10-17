# Semana 4 — OWASP Top 10: Las vulnerabilidades mas peligrosas del mundo

> Objetivo: conocer los 10 tipos de fallo mas comunes en aplicaciones web y detectarlos en codigo real.

---

## Que es OWASP

OWASP = Open Web Application Security Project. Organizacion sin fines de lucro que publica el **Top 10** de vulnerabilidades mas criticas en aplicaciones web, actualizado cada 3-4 anos.

La lista OWASP 2021 es el estandar de la industria. Cuando contratan a un pentester, esta lista es su guia.

---

## OWASP Top 10 (2021)

| # | Vulnerabilidad | Gravedad tipica |
|---|---------------|----------------|
| A01 | Broken Access Control | Critica |
| A02 | Cryptographic Failures | Critica |
| A03 | Injection | Critica |
| A04 | Insecure Design | Alta |
| A05 | Security Misconfiguration | Alta |
| A06 | Vulnerable Components | Alta |
| A07 | Auth and Session Management Failures | Alta |
| A08 | Software and Data Integrity Failures | Alta |
| A09 | Security Logging Failures | Media |
| A10 | SSRF | Alta |

---

## A01 — Broken Access Control

El usuario accede a recursos que no le corresponden.

### Tipos

**IDOR (Insecure Direct Object Reference):**
```
GET /api/facturas/1234  → tu factura
GET /api/facturas/1235  → factura de otro usuario (si el servidor no valida)
```

**Escalada horizontal:** acceder a datos de otro usuario del mismo nivel.
**Escalada vertical:** usuario normal accede a funciones de admin.

### En tu API FastAPI
```python
# INSEGURO — cualquiera puede ver cualquier usuario
@app.get("/usuarios/{user_id}")
async def get_usuario(user_id: int):
    return db.query(Usuario).filter(Usuario.id == user_id).first()

# SEGURO — solo puedes ver tu propio perfil (o eres admin)
@app.get("/usuarios/{user_id}")
async def get_usuario(user_id: int, current_user=Depends(get_current_user)):
    if current_user.id != user_id and current_user.rol != "admin":
        raise HTTPException(403, "Sin permiso")
    return db.query(Usuario).filter(Usuario.id == user_id).first()
```

---

## A02 — Cryptographic Failures

Datos sensibles mal protegidos (o sin proteger).

### Ejemplos
- Contrasenas guardadas en texto plano (sin hash)
- Hash debil: MD5, SHA1 (se crackean con rainbow tables)
- HTTP en lugar de HTTPS
- Datos sensibles en URL: `GET /login?password=mipassword`
- JWT sin firma o con algoritmo `none`

### Buenas practicas
```python
# MAL — MD5
import hashlib
hash_malo = hashlib.md5("mi_password".encode()).hexdigest()

# BIEN — bcrypt con salt
import bcrypt
password = "mi_password".encode()
salt = bcrypt.gensalt()
hash_seguro = bcrypt.hashpw(password, salt)

# Verificar
bcrypt.checkpw("mi_password".encode(), hash_seguro)  # True
```

---

## A03 — Injection (SQL Injection y otros)

El atacante inyecta codigo en un campo de entrada que el servidor ejecuta.

### SQL Injection

```
Campo usuario: admin' OR '1'='1
```

La query resultante:
```sql
SELECT * FROM usuarios WHERE username='admin' OR '1'='1' AND password='...'
-- '1'='1' siempre es true → acceso sin password
```

**Bypass de login clasico:**
```
usuario: ' OR 1=1--
password: cualquier cosa
```

**Extraccion de datos (UNION):**
```
' UNION SELECT username, password FROM admin--
```

**Prevencion:**
```python
# MAL — interpolacion directa
query = f"SELECT * FROM usuarios WHERE username='{username}'"

# BIEN — parametros preparados
query = "SELECT * FROM usuarios WHERE username=%s"
cursor.execute(query, (username,))
```

### Command Injection

```python
# MAL — el atacante pasa "127.0.0.1; rm -rf /"
import os
os.system(f"ping {user_input}")

# BIEN — usar subprocess con lista
import subprocess
subprocess.run(["ping", "-c", "1", user_input], capture_output=True)
```

---

## A04 — Insecure Design

Fallas en el diseno, no en la implementacion. La logica del sistema es defectuosa.

### Ejemplos
- App bancaria que no limita intentos de transferencia
- Reset de contrasena via pregunta de seguridad (facil de adivinar)
- Cupon de descuento reutilizable sin limite

### Solucion: Threat Modeling al disenar
Preguntarse: "Como podria un atacante abusar de esta funcion?"

---

## A05 — Security Misconfiguration

El sistema esta configurado inseguramente.

### Ejemplos comunes
- Puertos abiertos innecesarios
- Credenciales por defecto (admin/admin)
- Stack trace expuesto en produccion (revela estructura interna)
- CORS abierto para todos: `Access-Control-Allow-Origin: *`
- Directorio listing en el servidor web

```python
# MAL — en produccion muestra el error completo
@app.exception_handler(Exception)
async def error_handler(request, exc):
    return JSONResponse({"error": str(exc), "traceback": traceback.format_exc()})

# BIEN — error generico en produccion
@app.exception_handler(Exception)
async def error_handler(request, exc):
    logger.error(f"Error: {exc}", exc_info=True)
    return JSONResponse({"error": "Error interno del servidor"}, status_code=500)
```

---

## A06 — Vulnerable and Outdated Components

Usar librerias/frameworks con vulnerabilidades conocidas.

- Log4Shell: Log4j 2.0-2.14.1 (CVSS 10.0)
- Spring4Shell: Spring Framework < 5.3.18

**Comandos para revisar:**
```bash
# Python
pip list --outdated
pip audit  # necesita pip-audit

# npm
npm audit
npm outdated

# Java (Maven)
mvn dependency:check
```

---

## A07 — Auth and Session Management Failures

Problemas en login, sesion, tokens.

### Ejemplos
- JWT sin expiracion (`exp` no definido)
- Token almacenado en localStorage (vulnerable a XSS)
- Session ID predecible
- No invalidar sesion al hacer logout

```python
# JWT seguro
import jwt
from datetime import datetime, timedelta

payload = {
    "sub": str(user.id),
    "exp": datetime.utcnow() + timedelta(hours=1),  # expira en 1 hora
    "iat": datetime.utcnow(),
    "rol": user.rol,
}
token = jwt.encode(payload, SECRET_KEY, algorithm="HS256")
```

---

## A08 — Software and Data Integrity Failures

Confianza ciega en actualizaciones y descargas.

- SolarWinds: actualizacion troyanizada
- Descargar librerías sin verificar hash
- CI/CD sin revision de código (cualquiera puede meter código malicioso)

---

## A09 — Security Logging and Monitoring Failures

Si no tienes logs, no sabes si te han atacado.

**Que DEBES loggear:**
- Intentos de login fallidos (con IP y usuario)
- Cambios de privilegios
- Accesos a datos sensibles
- Errores de validacion de entrada

```python
import logging

logger = logging.getLogger("seguridad")

# Al fallar login
logger.warning(f"Login fallido | usuario={username} | ip={client_ip}")

# Al acceder a datos sensibles
logger.info(f"Acceso datos sensibles | usuario={user.id} | recurso={recurso}")
```

---

## A10 — SSRF (Server-Side Request Forgery)

El servidor hace requests HTTP a una URL que el atacante controla.

```python
# MAL — el atacante puede poner http://169.254.169.254/metadata (AWS metadata!)
@app.get("/preview")
async def preview(url: str):
    response = requests.get(url)
    return response.text
```

**Ataque clasico en AWS:**
```
url = http://169.254.169.254/latest/meta-data/iam/security-credentials/
→ devuelve credenciales AWS del servidor!
```

**Prevencion:** validar y whitelist de dominios permitidos.

---

## WebGoat — Laboratorio de practica

WebGoat es una app web intencionalmente vulnerable para practicar OWASP.

```bash
# Levantar con Docker
docker run -p 8081:8080 -t webgoat/webgoat

# Acceder en el navegador
http://localhost:8081/WebGoat
```

Modulos recomendados:
- SQL Injection (Basic → Advanced)
- XSS — Cross Site Scripting
- Access Control
- JWT
