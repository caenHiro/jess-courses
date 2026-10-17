# Practica — Semana 7: CTF y herramientas profesionales

---

## Ejercicio 1 — TryHackMe: Pre-Security Path (obligatorio)

**Crear cuenta en TryHackMe (gratis):** `tryhackme.com`

**Completar estas rooms en orden:**
1. `What is Networking?` — 30 min
2. `HTTP in Detail` — 30 min  
3. `How Websites Work` — 30 min

Para cada room documenta en `04_Notas_Personales/semana07_tryhackme.md`:
- Nombre del room
- Cuantas banderas encontraste
- 3 cosas que aprendiste que no sabias
- Captura de pantalla del certificado de completado (si aplica)

**Bonus:** Si terminas rapido, intenta `OWASP Top 10` room (3-4 horas, muy completo).

---

## Ejercicio 2 — Burp Suite: interceptar y modificar requests (obligatorio)

**Configuracion:**
1. Instalar Burp Suite Community
2. Configurar Firefox con proxy `127.0.0.1:8080`
3. Instalar certificado Burp en Firefox

**Practica con WebGoat:**

```bash
docker run -p 8081:8080 -t webgoat/webgoat
```

**Tareas:**

**A) Interceptar login:**
1. Activar Intercept en Burp (Proxy > Intercept > ON)
2. Hacer login en WebGoat
3. Capturar el request POST
4. Identificar donde van las credenciales (username y password)
5. Modificar el username antes de enviarlo y ver que responde

**B) Usar Repeater:**
1. Tomar cualquier request GET con un parametro (como `?id=1`)
2. Click derecho > "Send to Repeater"
3. Cambiar el valor del parametro y ver respuestas diferentes
4. Documentar: como ayuda esto a encontrar IDOR?

**C) Decoder:**
1. Tomar tu JWT del login
2. En Burp: Decoder > pegar el payload del JWT > "Decode as" > Base64
3. Ver el contenido
4. Modificar el rol a "admin", re-encodear, y reemplazar en el token
5. Que respuesta da el servidor cuando envias el token modificado?

---

## Ejercicio 3 — Reto: Tu primer CTF (reto)

**PicoCTF** — `picoctf.org` — crear cuenta gratuita.

**Resolver estos challenges (categoria Web Exploitation):**

1. `Inspect HTML` — nivel facil
2. `SQLiLite` — nivel medio
3. `Most Cookies` — nivel medio (JWT relacionado)

Para cada challenge documenta:
- Que tecnica usaste
- Cuanto tiempo tardaste
- El proceso de pensamiento: como llegaste a la solucion?
- La flag encontrada

**Formato:**
```markdown
## Challenge: [nombre]

**Categoria:** Web / Crypto / etc
**Dificultad:** Easy / Medium
**Tiempo:** X minutos

**Proceso:**
1. Primero vi que...
2. Luego intente...
3. La clave fue darme cuenta de que...

**Flag:** picoCTF{...}

**Leccion:** lo que aprendi de este reto...
```

---

## Reflexion semanal

1. El CTF: fue mas frustrante o mas divertido de lo que esperabas?
2. Que habilidad te falto en el CTF que no tenias y deberia haberte dado el curso?
3. Burp Suite — en tu trabajo como desarrolladora, lo usarias para probar tu propia API? Como?
4. TryHackMe: cual fue el concepto que mas te sorprendio del Pre-Security path?
