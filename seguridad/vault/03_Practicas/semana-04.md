# Practica — Semana 4: OWASP Top 10 en WebGoat

---

## Ejercicio 1 — SQL Injection en WebGoat (obligatorio)

**Configuracion:**
```bash
docker run -p 8081:8080 -t webgoat/webgoat
# Abrir: http://localhost:8081/WebGoat
# Registrarse con cualquier usuario/password
```

**Completa los siguientes modulos de WebGoat:**
1. `SQL Injection (intro)` — completar las primeras 5 lecciones
2. `SQL Injection (advanced)` — completar "Try It! String SQL Injection"

**Documenta para cada ejercicio:**
- Que payload usaste
- Por que funciono (explica la logica SQL)
- Como se hubiera prevenido con parametros preparados

**Ejemplo de lo que debes documentar:**
```
Ejercicio: "Login bypass"
Payload: admin'--
SQL resultante: SELECT * FROM users WHERE username='admin'-- AND password='xxx'
Razon: el -- comenta el resto de la query, bypasea la verificacion de password
Prevencion: usar cursor.execute("SELECT ... WHERE username=%s", (username,))
```

---

## Ejercicio 2 — XSS en WebGoat (obligatorio)

En WebGoat, ir al modulo `Cross-Site Scripting (XSS)`:

1. Completar `Reflected XSS`
2. Completar `Stored XSS`

**Para cada ejercicio documenta:**
- Que payload usaste
- Donde se ejecuto el script (que parte de la pagina)
- Si fue reflected o stored, explica la diferencia en tus palabras
- Como se previene en el servidor y en el cliente

**Payload basico a probar:**
```javascript
<script>alert('XSS por Jess')</script>
<img src=x onerror=alert('XSS')>
<svg onload=alert(1)>
```

---

## Ejercicio 3 — Reto: Auditar tu propia API (reto)

Revisa tu API de Python (del Curso 2) o cualquier proyecto FastAPI/Spring Boot que tengas.

**Checklist de seguridad:**

```markdown
## Auditoria OWASP de [nombre de mi proyecto]

### A01 — Access Control
- [ ] Todos los endpoints verifican que el usuario esta autenticado?
- [ ] Los endpoints de datos del usuario verifican que el ID pertenece al usuario actual?
- [ ] Hay endpoints de admin protegidos por rol?
- Hallazgos: ___

### A02 — Cryptographic Failures
- [ ] Las passwords se guardan con bcrypt/argon2?
- [ ] Los tokens JWT tienen expiracion?
- [ ] El app usa HTTPS en produccion?
- Hallazgos: ___

### A03 — Injection
- [ ] Todas las queries SQL usan parametros preparados?
- [ ] Se validan y sanitizan los inputs del usuario?
- Hallazgos: ___

### A05 — Misconfiguration
- [ ] Debug mode desactivado en produccion?
- [ ] El stack trace no se muestra al usuario?
- [ ] CORS configurado correctamente (no wildcard *)?
- Hallazgos: ___

### A09 — Logging
- [ ] Se loggean intentos de login fallidos?
- [ ] Los logs incluyen IP y timestamp?
- Hallazgos: ___
```

Entrega el checklist completo con tus hallazgos reales.

---

## Reflexion semanal

1. Encontraste vulnerabilidades reales en tu propio codigo? Cual fue la mas sorprendente?
2. De la lista OWASP Top 10, cual crees que es la mas facil de cometer por accidente como desarrolladora?
3. Si tuvieras que elegir solo 3 controles de seguridad para implementar HOY en un proyecto, cuales serian?
4. Cual es la diferencia entre un bug de seguridad y un bug normal?
