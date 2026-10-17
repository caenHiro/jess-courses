# Semana 6 — Criptografia y autenticacion: los cimientos de la seguridad

> Objetivo: entender como funciona el cifrado, hashing y autenticacion moderna.

---

## Por que importa la criptografia

Cada vez que:
- Entras a una pagina con HTTPS → criptografia
- Guardas una contrasena en la BD → hashing
- Inicias sesion con JWT → firma criptografica
- Abres un archivo .age cifrado → criptografia simetrica

Sin criptografia no hay privacidad ni integridad.

---

## Tipos de cifrado

### Simetrico — misma clave para cifrar y descifrar

```
Texto claro  →  [Cifrar con clave K]  →  Texto cifrado
Texto cifrado →  [Descifrar con clave K]  →  Texto claro
```

**Algoritmos:**
- **AES-256** — estandar actual, muy seguro
- **ChaCha20** — alternativa, muy rapido en moviles
- **3DES** — obsoleto, no usar
- **DES** — roto desde los 90s

```python
from cryptography.fernet import Fernet

# Generar clave (guardarla con cuidado)
clave = Fernet.generate_key()
f = Fernet(clave)

# Cifrar
mensaje = b"datos confidenciales"
cifrado = f.encrypt(mensaje)
print(cifrado)  # token cifrado

# Descifrar (con la misma clave)
descifrado = f.decrypt(cifrado)
print(descifrado)  # b"datos confidenciales"
```

**Problema:** como compartir la clave de forma segura?

### Asimetrico — par de claves (publica + privada)

```
Clave publica:  puede compartirse con todos
Clave privada:  NUNCA se comparte

Cifrar con publica  → solo la privada puede descifrar
Firmar con privada  → cualquiera con la publica puede verificar
```

**Algoritmos:**
- **RSA** — estandar historico (2048 o 4096 bits)
- **ECDSA / Ed25519** — mas eficiente que RSA (SSH keys modernas)

```python
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives import hashes

# Generar par de claves
private_key = rsa.generate_private_key(public_exponent=65537, key_size=2048)
public_key = private_key.public_key()

# Cifrar con clave publica (solo el dueno de la privada puede descifrar)
mensaje = b"secreto para ti"
cifrado = public_key.encrypt(
    mensaje,
    padding.OAEP(mgf=padding.MGF1(hashes.SHA256()), algorithm=hashes.SHA256(), label=None)
)
```

**Uso en TLS/HTTPS:**
1. El navegador recibe la clave publica del servidor (certificado SSL)
2. Genera una clave de sesion simetrica aleatoria
3. La cifra con la clave publica del servidor
4. El servidor la descifra con su clave privada
5. A partir de ahi, comunicacion AES simetrica (rapida)

---

## Hashing — funcion de una sola via

```
Password  →  hash()  →  hash_irreversible
```

**Caracteristicas:**
- Irreversible: no puedes ir del hash al texto original
- Determinista: mismo input → mismo hash siempre
- Avalancha: un cambio minimo → hash completamente diferente
- Colision resistente: dos inputs distintos no deben dar el mismo hash

```bash
# MD5 (ROTO — no usar para passwords)
echo -n "password" | md5sum
# 5f4dcc3b5aa765d61d8327deb882cf99

# SHA-256 (mejor, pero NO para passwords — muy rapido = facil brute force)
echo -n "password" | sha256sum

# bcrypt (CORRECTO para passwords)
python3 -c "import bcrypt; print(bcrypt.hashpw(b'password', bcrypt.gensalt()))"
```

### Por que bcrypt y no SHA-256 para passwords

SHA-256 puede calcular ~10 billones de hashes por segundo en GPU moderna.
bcrypt es intencionalmente lento: ~100 hashes/segundo. El atacante tarda 100,000x mas.

```python
# BIEN — bcrypt con salt automatico
import bcrypt

def hash_password(password: str) -> str:
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt(rounds=12)).decode()

def verify_password(password: str, hashed: str) -> bool:
    return bcrypt.checkpw(password.encode(), hashed.encode())
```

### Rainbow Tables

Precomputar hashes de millones de passwords comunes. Por eso el **salt** es crucial:

```
password + salt_aleatorio = hash unico
```

Aunque dos usuarios tengan el mismo password, sus hashes son distintos gracias al salt.

---

## TLS y certificados SSL

### Que es TLS

TLS (Transport Layer Security) cifra la comunicacion entre cliente y servidor.
HTTPS = HTTP + TLS.

### Certificados SSL

```bash
# Ver certificado de un sitio
openssl s_client -connect google.com:443 -servername google.com

# Ver fechas de validez
echo | openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -dates

# Generar certificado auto-firmado (desarrollo)
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
```

### Cadena de confianza

```
Let's Encrypt (CA raiz)  →  firmó  →  cert de google.com
Tu navegador confía en Let's Encrypt  →  confía en google.com
```

---

## JWT en detalle

```
Header.Payload.Signature
```

```json
// Header (base64)
{"alg": "HS256", "typ": "JWT"}

// Payload (base64) — no es cifrado, solo codificado
{
  "sub": "user_123",
  "rol": "admin",
  "iat": 1718400000,
  "exp": 1718403600
}

// Signature
HMACSHA256(base64(header) + "." + base64(payload), SECRET_KEY)
```

### Claims estandar importantes

| Claim | Significado |
|-------|-------------|
| `sub` | Subject — ID del usuario |
| `iat` | Issued At — cuando se emitio |
| `exp` | Expiration — cuando expira |
| `iss` | Issuer — quien lo emitio |
| `aud` | Audience — para quien es |

---

## OAuth 2.0 y OpenID Connect

### Flujo OAuth (Login con Google)

```
1. Tu app redirige a Google: "dame acceso al email de este usuario"
2. Google pregunta al usuario si acepta
3. Google devuelve un authorization code
4. Tu app intercambia el code por un access token
5. Tu app llama a Google API con el token para obtener datos del usuario
```

Nunca manejas la contrasena del usuario — Google la maneja.

### Implementacion basica con FastAPI

```python
from authlib.integrations.starlette_client import OAuth

oauth = OAuth()
oauth.register(
    name="google",
    client_id=GOOGLE_CLIENT_ID,
    client_secret=GOOGLE_CLIENT_SECRET,
    server_metadata_url="https://accounts.google.com/.well-known/openid-configuration",
    client_kwargs={"scope": "openid email profile"},
)

@app.get("/login/google")
async def login_google(request: Request):
    redirect_uri = "http://localhost:8000/auth/callback"
    return await oauth.google.authorize_redirect(request, redirect_uri)
```

---

## MFA — Autenticacion Multifactor

**Factor 1:** algo que sabes (password)
**Factor 2:** algo que tienes (telefono, llave fisica)
**Factor 3:** algo que eres (huella, cara)

### TOTP (Time-based One-Time Password) — como Google Authenticator

```python
import pyotp

# Generar secreto para el usuario
secret = pyotp.random_base32()

# URL para QR code (el usuario lo escanea en su app)
totp = pyotp.TOTP(secret)
uri = totp.provisioning_uri(name="jess@email.com", issuer_name="MiApp")

# Verificar codigo de 6 digitos
codigo_usuario = "123456"
es_valido = totp.verify(codigo_usuario)  # True si es correcto y no expiro
```

---

## Manejo seguro de secretos

**NUNCA en el codigo:**
```python
# MAL
DATABASE_URL = "postgresql://user:password123@localhost/db"
API_KEY = "sk-abc123..."
```

**En variables de entorno:**
```python
import os
DATABASE_URL = os.environ["DATABASE_URL"]
API_KEY = os.environ["API_KEY"]
```

```bash
# .env (local, en .gitignore)
DATABASE_URL=postgresql://user:password123@localhost/db
API_KEY=sk-abc123...

# Cargar en Python
from dotenv import load_dotenv
load_dotenv()
```

**En produccion:** AWS Secrets Manager, HashiCorp Vault, variables de entorno del servidor.
