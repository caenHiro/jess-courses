# Semana 8 — Blue Team y SIEM: defender, detectar, responder

> Objetivo: entender el trabajo real del analista SOC y como usar un SIEM.

---

## El Blue Team

Si el Red Team ataca, el Blue Team defiende.

| Rol | Que hace |
|-----|---------|
| **SOC Analyst L1** | Monitorear alertas, clasificar incidentes, escalar |
| **SOC Analyst L2** | Investigar incidentes, analisis forense, mitigacion |
| **SOC Analyst L3** | Threat hunting, crear reglas de deteccion, respuesta a incidentes |
| **Incident Responder** | Contener y erradicar amenazas activas |
| **Threat Intelligence** | Rastrear actores y tecnicas (APT, IOCs) |
| **DFIR** | Digital Forensics and Incident Response |

**SOC Nivel 1 es el punto de entrada mas accesible al mercado de seguridad.**

---

## Ciclo de respuesta a incidentes (NIST SP 800-61)

```
1. PREPARACION    — tener playbooks, herramientas, equipo listo
2. DETECCION      — alertas SIEM, logs, IDS/IPS
3. CONTENCION     — aislar el sistema comprometido
4. ERRADICACION   — eliminar el malware/backdoor
5. RECUPERACION   — restaurar servicio normal
6. LECCIONES      — documentar y mejorar
```

---

## Tipos de logs — las fuentes del SOC

```
/var/log/auth.log          — autenticacion SSH, sudo
/var/log/syslog            — sistema operativo
/var/log/nginx/access.log  — trafico web
/var/log/nginx/error.log   — errores web
journalctl                 — todos los servicios systemd
Windows Event Log          — Security (4624=login OK, 4625=login fail)
Firewall logs              — trafico permitido/bloqueado
VPN logs                   — conexiones remotas
DNS logs                   — que dominios se resolvieron
Proxy logs                 — que URLs visito cada IP
CloudTrail (AWS)           — todas las acciones en AWS
```

---

## SIEM — Security Information and Event Management

Un SIEM centraliza logs de todas las fuentes y detecta patrones anomalos.

```
Logs de firewall ─┐
Logs de servidores─┤
Logs de endpoints ─┼──→  SIEM  →  Alertas  →  SOC Analyst
Logs de aplicacion─┤              Dashboards
Logs de red ───────┘              Correlaciones
```

**SIEMs populares:**
- **Splunk** — lider comercial, muy caro pero muy poderoso
- **Microsoft Sentinel** — Azure native
- **IBM QRadar** — enterprise
- **Wazuh** — open source, muy bueno, gratis
- **Elastic SIEM** — ELK Stack

---

## Wazuh — SIEM open source

### Arquitectura

```
Wazuh Agent (en cada servidor)  →  Wazuh Manager  →  Elasticsearch  →  Kibana Dashboard
```

### Levantar con Docker

```bash
# docker-compose.yml de Wazuh
curl -so docker-compose.yml https://packages.wazuh.com/4.7/docker/docker-compose.yml

docker-compose up -d

# Acceder al dashboard
https://localhost:443
# usuario: admin / password: SecretPassword (ver .env)
```

### Reglas en Wazuh

Wazuh tiene miles de reglas predefinidas. Tambien puedes crear las tuyas:

```xml
<!-- Regla personalizada: detectar escaneo de puertos -->
<group name="local,syslog,">
  <rule id="100001" level="10">
    <decoded_as>syslog</decoded_as>
    <match>nmap</match>
    <description>Posible escaneo de puertos detectado</description>
  </rule>
</group>
```

### Tipos de alertas Wazuh

| Nivel | Significado |
|-------|-------------|
| 0-3 | Informativo |
| 4-7 | Bajo/Medio |
| 8-11 | Alto — requiere atencion |
| 12-15 | Critico — actuar inmediatamente |

---

## Analisis de logs con comandos

```bash
# Top IPs con intentos fallidos de SSH
grep "Failed password" /var/log/auth.log | \
    awk '{print $11}' | \
    sort | uniq -c | sort -rn | head -20

# Detectar accesos fuera de horario (22:00-06:00)
grep "Accepted password\|Accepted publickey" /var/log/auth.log | \
    awk '$3 >= "22:" || $3 <= "06:"'

# Listar IPs que hacen muchas requests en poco tiempo (DDoS rudimentario)
awk '{print $1}' /var/log/nginx/access.log | \
    sort | uniq -c | sort -rn | head -10

# Buscar User-Agents de herramientas automatizadas
grep -i "sqlmap\|nikto\|nmap\|masscan" /var/log/nginx/access.log

# Encontrar respuestas 500 del servidor
awk '$9 == 500' /var/log/nginx/access.log | tail -20

# Buscar accesos a rutas sensibles
grep -E "/admin|/\.env|/config|/backup|/\.git" /var/log/nginx/access.log
```

---

## IDS/IPS — Deteccion/Prevencion de Intrusiones

| Sistema | Que hace |
|---------|---------|
| **IDS (Intrusion Detection System)** | Detecta y alerta, no bloquea |
| **IPS (Intrusion Prevention System)** | Detecta y bloquea automaticamente |

**Herramientas:**
- **Snort** — IDS/IPS clasico, open source
- **Suricata** — IDS/IPS moderno, multi-thread
- **fail2ban** — banea IPs con multiples intentos fallidos

```bash
# fail2ban — ver IPs baneadas
sudo fail2ban-client status sshd

# Ver log de fail2ban
sudo tail -f /var/log/fail2ban.log
```

---

## Threat Hunting

Buscar activamente amenazas que los sistemas automaticos no detectaron.

### Hipotesis basica

```
"Hay credenciales comprometidas si veo logins exitosos en horarios inusuales
 desde IPs que nunca habian accedido antes"
```

### Proceso

1. Definir hipotesis (basada en threat intel o intuicion)
2. Recopilar datos (logs, trafico, EDR)
3. Analizar en busca de evidencia
4. Si hay evidencia → incidente
5. Documentar y crear regla de deteccion automatica

---

## AWS Security Services

| Servicio | Que hace |
|---------|---------|
| **GuardDuty** | Detecta anomalias en CloudTrail, VPC Flow Logs, DNS |
| **CloudTrail** | Log de todas las acciones en AWS |
| **SecurityHub** | Panel centralizado de alertas de seguridad |
| **Config** — AWS Config | Audita configuracion de recursos |
| **Inspector** | Escanea vulnerabilidades en EC2 y Lambda |
| **Macie** | Detecta datos sensibles en S3 |
| **WAF** | Firewall para aplicaciones web (bloquea SQLi, XSS) |
| **Shield** | Proteccion DDoS |

```bash
# Ver eventos de CloudTrail
aws cloudtrail lookup-events --max-items 20

# Ver alertas de GuardDuty
aws guardduty list-findings --detector-id <id>
```

---

## Frameworks de seguridad

### MITRE ATT&CK

Framework que documenta tecnicas y tacticas que usan los atacantes reales.

```
Tacticas (el QUE):
  Reconocimiento → Acceso inicial → Ejecucion → Persistencia
  → Escalada → Evasion → Acceso credencial → Descubrimiento
  → Movimiento lateral → Exfiltracion → Impacto

Tecnicas (el COMO):
  T1190 — Exploit de aplicacion publica
  T1078 — Cuentas validas (credenciales robadas)
  T1566 — Phishing
```

### CIS Controls v8

18 controles priorizados para proteger una organizacion. Los primeros 6 son obligatorios:

1. Inventario de activos hardware
2. Inventario de activos software
3. Proteccion de datos
4. Configuracion segura de activos
5. Gestion de cuentas
6. Gestion de control de acceso

---

## La carrera en ciberseguridad

### Certificaciones de entrada (sin experiencia)

| Certificacion | Costo | Reconocimiento |
|--------------|-------|---------------|
| CompTIA Security+ | $380 USD | Muy alto, estandar de la industria |
| CompTIA Network+ | $338 USD | Util antes del Security+ |
| CEH (Ethical Hacking) | $950 USD | Bien visto en LATAM |
| eJPT (eLearnSecurity) | $200 USD | Practica, buena para empezar |
| TryHackMe Certs | Gratis-bajo | Para el CV |

### Ruta sugerida para Jess

```
Ahora:          TryHackMe Pre-Security Path (gratis)
3 meses:        CompTIA Network+ (estudiar con Profesor Messer gratis)
6 meses:        CompTIA Security+ (objetivo principal)
1 año:          Primer trabajo SOC L1
2 años:         CEH o eJPT, SOC L2
```

### Que buscan en un SOC L1

- Conocer el proceso de respuesta a incidentes
- Leer logs y detectar anomalias
- Usar SIEM (Splunk, Wazuh)
- TCP/IP basico, puertos, protocolos
- Windows y Linux en la terminal
- Inglés tecnico (la mayoria de docs son en ingles)
