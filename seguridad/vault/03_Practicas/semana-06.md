# Practica — Semana 6: Criptografia y autenticacion

---

## Ejercicio 1 — Cifrado y hashing en Python (obligatorio)

```bash
pip install cryptography bcrypt
```

**Parte A — Cifrado simetrico con Fernet:**

```python
# crypto_ejercicio.py
from cryptography.fernet import Fernet

# 1. Generar clave y guardarla
clave = Fernet.generate_key()
print(f"Clave generada: {clave.decode()}")

# 2. Guardar clave en archivo (simulando manejo seguro)
with open("clave_secreta.key", "wb") as f:
    f.write(clave)

# 3. Cifrar un mensaje
f = Fernet(clave)
mensaje_secreto = "Este es un mensaje confidencial de Jess"
cifrado = f.encrypt(mensaje_secreto.encode())
print(f"Cifrado: {cifrado}")

# 4. Descifrar
descifrado = f.decrypt(cifrado).decode()
print(f"Descifrado: {descifrado}")

# 5. Intentar descifrar con una clave incorrecta
clave_incorrecta = Fernet.generate_key()
try:
    Fernet(clave_incorrecta).decrypt(cifrado)
except Exception as e:
    print(f"Error esperado: {e}")
```

**Parte B — Hashing de passwords:**

```python
import bcrypt
import hashlib
import time

password = "MiPassword123!"

# Comparar velocidades
start = time.time()
for _ in range(100):
    hashlib.sha256(password.encode()).hexdigest()
sha_time = time.time() - start

start = time.time()
bcrypt.hashpw(password.encode(), bcrypt.gensalt(rounds=12))
bcrypt_time = time.time() - start

print(f"SHA-256 x100: {sha_time:.4f}s")
print(f"bcrypt x1:    {bcrypt_time:.4f}s")
print(f"bcrypt es ~{int(bcrypt_time/sha_time*100)} veces mas lento que SHA-256 x100")
```

**Responde:**
a) Cuanto tarda bcrypt en tu maquina? Cuanto tardaria un atacante en probar 1 millon de passwords?
b) Genera 2 hashes bcrypt del mismo password. Son iguales? Por que?
c) Que es el "salt" que bcrypt genera automaticamente?

---

## Ejercicio 2 — JWT seguro en FastAPI (obligatorio)

Implementa autenticacion JWT correcta en un mini-proyecto:

```python
# jwt_seguro.py
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
import jwt
from datetime import datetime, timedelta
import bcrypt

app = FastAPI()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/token")

SECRET_KEY = "clave_super_secreta_cambiar_en_produccion_min_32_chars"
ALGORITHM = "HS256"
EXPIRE_MINUTES = 30

# Base de datos simulada
USUARIOS = {
    "jess": {
        "username": "jess",
        "password_hash": bcrypt.hashpw(b"password123", bcrypt.gensalt()).decode(),
        "rol": "user"
    }
}

def crear_token(data: dict) -> str:
    payload = data.copy()
    payload["exp"] = datetime.utcnow() + timedelta(minutes=EXPIRE_MINUTES)
    payload["iat"] = datetime.utcnow()
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

def verificar_token(token: str = Depends(oauth2_scheme)) -> dict:
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token expirado")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Token invalido")

@app.post("/token")
async def login(form: OAuth2PasswordRequestForm = Depends()):
    user = USUARIOS.get(form.username)
    if not user or not bcrypt.checkpw(form.password.encode(), user["password_hash"].encode()):
        raise HTTPException(status_code=401, detail="Credenciales incorrectas")
    token = crear_token({"sub": form.username, "rol": user["rol"]})
    return {"access_token": token, "token_type": "bearer"}

@app.get("/mi-perfil")
async def mi_perfil(payload: dict = Depends(verificar_token)):
    return {"usuario": payload["sub"], "rol": payload["rol"]}

@app.get("/admin")
async def admin_only(payload: dict = Depends(verificar_token)):
    if payload.get("rol") != "admin":
        raise HTTPException(status_code=403, detail="Sin permiso")
    return {"mensaje": "Bienvenida al panel de admin"}
```

**Prueba:**
```bash
# Login
curl -X POST http://localhost:8000/token -d "username=jess&password=password123"

# Con el token
curl http://localhost:8000/mi-perfil -H "Authorization: Bearer <token>"

# Sin token (debe dar 401)
curl http://localhost:8000/mi-perfil

# Intentar acceder a admin sin ser admin (debe dar 403)
curl http://localhost:8000/admin -H "Authorization: Bearer <token>"
```

---

## Ejercicio 3 — Reto: Crackear hashes debiles (reto)

**Objetivo educativo:** entender por que los hashes debiles son inseguros.

```bash
# Instalar John the Ripper
sudo apt install john

# Crear archivo con hashes MD5 de passwords comunes
python3 -c "
import hashlib
passwords = ['password', '123456', 'qwerty', 'abc123', 'letmein', 'monkey', 'dragon']
for p in passwords:
    h = hashlib.md5(p.encode()).hexdigest()
    print(f'{h}')
" > hashes_md5.txt

# Crackear con John + rockyou.txt
john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt hashes_md5.txt
john --show --format=raw-md5 hashes_md5.txt
```

**Ahora con bcrypt:**
```python
import bcrypt
passwords = ['password', '123456', 'qwerty']
for p in passwords:
    h = bcrypt.hashpw(p.encode(), bcrypt.gensalt(rounds=12))
    print(h.decode())
```

```bash
# Guardar en archivo y intentar crackear
john --format=bcrypt --wordlist=/usr/share/wordlists/rockyou.txt hashes_bcrypt.txt
```

Documenta: cuanto tarda John en crackear los MD5? Y los bcrypt? Que concluyes?

---

## Reflexion semanal

1. Tu proyecto de FastAPI (Curso 2): guarda passwords? Con que algoritmo? Esta bien?
2. Un JWT sin expiracion: que riesgo implica si el token se filtra?
3. Por que no es suficiente con HTTPS para proteger passwords? (pista: que pasa si hackean la BD?)
4. Investigacion: que es argon2 y en que es mejor que bcrypt?
