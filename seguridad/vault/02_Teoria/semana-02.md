# Semana 2 — Redes: Como viaja la informacion (y como se intercepta)

> Objetivo: entender el trafico de red lo suficiente para detectar ataques.

---

## Modelo OSI en 2 minutos

No necesitas memorizar las 7 capas completas. Lo importante:

```
Capa 7 — Aplicacion   HTTP, DNS, SMTP, FTP — lo que ves como usuario
Capa 4 — Transporte   TCP (confiable), UDP (rapido)
Capa 3 — Red          IP — direccionamiento y enrutamiento
Capa 2 — Enlace       MAC address, switches locales
Capa 1 — Fisica       Cables, wifi
```

Los ataques pasan en todas las capas. DDoS es capa 3/4. XSS es capa 7.

---

## IP, puertos y protocolos

### Direcciones IP
- **IPv4:** 192.168.1.1 — 4 numeros 0-255 separados por puntos
- **Privadas:** 192.168.x.x / 10.x.x.x / 172.16.x.x — solo en red local
- **Publica:** la que ve internet (la de tu router)
- **127.0.0.1 (localhost):** tu propia maquina

### Puertos
Los puertos son como puertas numeradas del 0 al 65535. Cada servicio tiene su puerta:

```
20/21  — FTP (transferencia de archivos, inseguro)
22     — SSH (consola remota segura)
23     — Telnet (consola remota insegura — obsoleto)
25     — SMTP (correo saliente)
53     — DNS (resolucion de nombres)
80     — HTTP (web sin cifrar)
443    — HTTPS (web cifrada)
3306   — MySQL
5432   — PostgreSQL
6379   — Redis
8080   — HTTP alternativo (desarrollo)
27017  — MongoDB
```

**Por que importa:** nmap escanea puertos para saber que servicios tiene un servidor.

### TCP vs UDP

| TCP | UDP |
|-----|-----|
| Confiable, confirmacion de entrega | Rapido, sin confirmacion |
| HTTP, SSH, PostgreSQL | DNS, streaming, VoIP |
| Handshake 3 pasos (SYN/SYN-ACK/ACK) | Sin conexion |

---

## DNS — El directorio de internet

```
www.google.com  →  DNS lookup  →  142.250.80.46
```

Tipos de registros DNS importantes:
- **A** — nombre → IP (IPv4)
- **AAAA** — nombre → IP (IPv6)
- **MX** — servidor de correo
- **CNAME** — alias de otro nombre
- **TXT** — informacion libre (SPF, DKIM para email)

**Ataque DNS:** DNS Spoofing/Cache Poisoning — responder con IP falsa para redirigir trafico.

---

## HTTP y HTTPS en detalle

### Request HTTP

```http
GET /api/usuarios HTTP/1.1
Host: miapp.com
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
Content-Type: application/json
```

### Response HTTP

```http
HTTP/1.1 200 OK
Content-Type: application/json

{"nombre": "Jess", "rol": "admin"}
```

### Codigos de estado relevantes para seguridad

```
200 OK           — todo bien
201 Created      — recurso creado
301/302          — redireccion (puede redirigir a sitio malicioso)
400 Bad Request  — parametros incorrectos
401 Unauthorized — no autenticado
403 Forbidden    — autenticado pero sin permiso
404 Not Found
500 Server Error — error interno (revela informacion del servidor)
```

### HTTPS = HTTP + TLS

TLS cifra el trafico. Sin HTTPS, cualquiera en la red puede leer tus datos (MITM).

---

## Wireshark — Capturar trafico de red

Wireshark es como una "escucha" de todo lo que pasa por tu tarjeta de red.

### Filtros basicos

```
http              — solo trafico HTTP
tcp.port == 80    — solo puerto 80
ip.addr == 8.8.8.8 — trafico con esa IP
dns               — solo consultas DNS
http.request.method == "POST" — solo POST
```

### Como usarlo

1. Abrir Wireshark
2. Seleccionar interfaz de red (wlan0 o eth0)
3. Presionar el boton de play (icono de aleta)
4. Navegar a una pagina web en HTTP (no HTTPS)
5. Ver los paquetes — puedes ver el contenido completo

**Nota:** en HTTPS solo ves que hay trafico cifrado, no el contenido.

---

## nmap — Escaneo de puertos

nmap descubre que puertos/servicios estan abiertos en un host.

### Comandos basicos

```bash
# Escaneo simple
nmap 192.168.1.1

# Escaneo de rango de red (tu red local)
nmap 192.168.1.0/24

# Escaneo con deteccion de version
nmap -sV 192.168.1.1

# Escaneo sigiloso (SYN scan)
nmap -sS 192.168.1.1

# Escaneo de puertos especificos
nmap -p 22,80,443,8080 192.168.1.1

# Escaneo rapido (top 100 puertos)
nmap -F 192.168.1.1

# Guardar resultado
nmap -oN resultado.txt 192.168.1.1
```

### Interpretacion de resultado

```
PORT     STATE  SERVICE  VERSION
22/tcp   open   ssh      OpenSSH 8.2
80/tcp   open   http     nginx 1.18
443/tcp  open   https    nginx 1.18
3306/tcp closed mysql
```

- `open` — accesible
- `closed` — no hay servicio
- `filtered` — firewall bloqueando

---

## Ataques de red comunes

### MITM (Man-in-the-Middle)

```
Jess  →  [Atacante]  →  Servidor
        intercepta y
        puede modificar
```

Herramienta clasica: `ettercap`, `arpspoof`. Por eso HTTPS es obligatorio.

### ARP Spoofing

ARP asocia IPs con MACs en la red local. El atacante puede responder ARP falsos para que el trafico de Jess pase por su maquina.

### DDoS

```
Bot1  ┐
Bot2  ├──→  Servidor  (se satura y cae)
Bot3  ┘
BotN
```

Tipos:
- **Volumetrico:** inundar de paquetes (UDP flood)
- **Protocolo:** explotar TCP (SYN flood)
- **Capa aplicacion:** miles de requests HTTP validos

---

## Herramientas de red en Kali

```bash
ping 8.8.8.8           # test conectividad
traceroute google.com  # ruta de paquetes
netstat -tuln          # puertos escuchando en tu maquina
ss -tuln               # version moderna de netstat
dig google.com         # consulta DNS
whois google.com       # info del dominio
```
