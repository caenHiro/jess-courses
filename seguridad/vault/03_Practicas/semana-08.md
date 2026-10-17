# Practica — Semana 8: Blue Team y SIEM

---

## Ejercicio 1 — Wazuh: instalar y explorar alertas (obligatorio)

```bash
# Levantar Wazuh con Docker
curl -so wazuh-docker-compose.yml \
  https://packages.wazuh.com/4.7/docker/docker-compose.yml

docker-compose -f wazuh-docker-compose.yml up -d

# Esperar ~5 minutos para que inicialice
# Dashboard: https://localhost:443
# Usuario: admin
# Password: ver en el archivo .env generado
```

**Si Wazuh es demasiado pesado para tu maquina**, usa la instancia de prueba de TryHackMe:
- Room: `Wazuh` en TryHackMe (tiene maquina virtual incluida)

**Tareas:**

**A) Explorar el dashboard:**
- Cuantos agentes tiene instalados?
- Cuantas alertas hay en las ultimas 24 horas?
- Cual es la alerta mas critica (nivel mas alto)?

**B) Generar una alerta:**
```bash
# En la maquina donde esta el agente Wazuh:
# Intentar login SSH con usuario incorrecto 5 veces
for i in {1..5}; do ssh usuario_falso@localhost; done

# Ver si Wazuh detecto los intentos fallidos
# Dashboard > Security Events > filtrar por "authentication_failed"
```

**C) Analizar una alerta:**
Elige una alerta y documenta:
- ID y nivel de la regla
- Que evento lo disparo?
- De que agente viene?
- Que accion recomiendas tomar?

---

## Ejercicio 2 — Analisis manual de logs: detectar un ataque simulado (obligatorio)

Analiza el siguiente fragmento de log (nginx access log):

```
192.168.1.100 - - [14/Jun/2026:10:00:01] "GET / HTTP/1.1" 200 1234
192.168.1.100 - - [14/Jun/2026:10:00:02] "GET /admin HTTP/1.1" 404 -
192.168.1.100 - - [14/Jun/2026:10:00:02] "GET /admin.php HTTP/1.1" 404 -
192.168.1.100 - - [14/Jun/2026:10:00:02] "GET /.env HTTP/1.1" 404 -
192.168.1.100 - - [14/Jun/2026:10:00:03] "GET /wp-admin HTTP/1.1" 404 -
192.168.1.100 - - [14/Jun/2026:10:00:03] "GET /phpmyadmin HTTP/1.1" 404 -
192.168.1.100 - - [14/Jun/2026:10:00:03] "GET /config HTTP/1.1" 404 -
192.168.1.100 - - [14/Jun/2026:10:00:04] "GET /backup HTTP/1.1" 404 -
192.168.1.100 - - [14/Jun/2026:10:00:04] "GET /api/users HTTP/1.1" 401 -
10.0.0.5 - - [14/Jun/2026:10:01:00] "POST /api/auth HTTP/1.1" 401 -
10.0.0.5 - - [14/Jun/2026:10:01:01] "POST /api/auth HTTP/1.1" 401 -
10.0.0.5 - - [14/Jun/2026:10:01:01] "POST /api/auth HTTP/1.1" 401 -
[... 200 lineas identicas de 10.0.0.5 ...]
10.0.0.5 - - [14/Jun/2026:10:01:45] "POST /api/auth HTTP/1.1" 200 -
10.0.0.5 - - [14/Jun/2026:10:01:46] "GET /api/admin/users HTTP/1.1" 200 -
10.0.0.5 - - [14/Jun/2026:10:01:47] "GET /api/admin/config HTTP/1.1" 200 -
```

**Preguntas:**

a) Que tipo de ataque esta realizando `192.168.1.100`? Que herramienta probablemente usa?
b) Que tipo de ataque realiza `10.0.0.5`? Como lo detecto?
c) El ataque de `10.0.0.5` tuvo exito? Como lo sabes?
d) Que acciones tomarias inmediatamente como analista SOC?
e) Que regla crearias en el SIEM para detectar este patron automaticamente?

```bash
# Comandos de analisis real (si tuvieras el log real):
# Contar requests por IP
awk '{print $1}' access.log | sort | uniq -c | sort -rn | head -10

# Ver todas las rutas que no existen (404) de una IP
grep "192.168.1.100" access.log | awk '$9==404 {print $7}'

# Detectar brute force (mas de 50 intentos de POST en 60 segundos)
awk '$6=="\"POST" {print $4,$1}' access.log | \
    cut -d: -f1,2 | sort | uniq -c | sort -rn | head
```

---

## Ejercicio 3 — Reto: Plan de respuesta a incidentes (reto)

**Escenario:** Eres analista SOC Nivel 1 en una empresa de e-commerce. A las 3am recibes una alerta de Wazuh nivel 15 (critico): "Multiple failed SSH logins followed by successful login from unknown IP".

Escribe el **Playbook de Respuesta** para este incidente:

```markdown
## Playbook: Posible Compromiso SSH

### Contexto
- Alerta: login SSH exitoso precedido de multiples intentos fallidos
- Nivel: 15 (critico)
- Sistema afectado: [servidor]

### 1. Triage (primeros 5 minutos)
[ ] Confirmar la alerta es real (no falso positivo)
[ ] Identificar el servidor afectado
[ ] Determinar si el IP atacante es conocido (threat intel)
[ ] Escalar a L2/L3?

### 2. Contencion (primeros 15 minutos)
[ ] Bloquear la IP atacante en el firewall:
    comando: iptables -I INPUT -s [IP] -j DROP
[ ] Forzar cierre de sesion del atacante:
    comando: pkill -KILL -u [usuario_comprometido]
[ ] Revocar credenciales comprometidas

### 3. Investigacion (primera hora)
[ ] Que hizo el atacante durante la sesion?
    comando: last / who / history
[ ] Se creo algun archivo nuevo?
    comando: find / -mtime -1 -type f 2>/dev/null
[ ] Se instalo algun proceso nuevo?
    comando: ps aux / crontab -l
[ ] Se exfiltraron datos?
    comando: revisar logs de red, netflow

### 4. Erradicacion
[ ] Cambiar TODAS las passwords del servidor
[ ] Revocar claves SSH comprometidas
[ ] Parchear el vector de entrada (si aplica)

### 5. Recuperacion
[ ] Restaurar desde backup si hay compromiso de integridad
[ ] Verificar integridad del sistema
[ ] Monitoreo intensivo por 72 horas

### 6. Documentacion
[ ] Reporte de incidente: timeline, impacto, acciones tomadas
[ ] Leccion aprendida: que se puede mejorar?
[ ] Actualizar reglas SIEM para mejor deteccion
```

Personaliza el playbook con comandos especificos que usarias.

---

## Reflexion final del curso

1. Al inicio del curso, que pensabas que era la ciberseguridad? En que cambio tu perspectiva?
2. De todo lo que aprendiste, que es lo que mas quieres profundizar?
3. Como aplicaras lo aprendido en tus proyectos de desarrollo?
4. Cual seria tu siguiente paso concreto en la carrera de seguridad? (certificacion, CTF, trabajo, proyecto)
5. Recomendarias este curso a alguien mas? Que cambiarías?
