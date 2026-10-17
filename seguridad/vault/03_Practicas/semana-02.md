# Practica — Semana 2: Redes y trafico

---

## Ejercicio 1 — Captura de trafico con Wireshark (obligatorio)

**Configuracion previa:**
- Instalar Wireshark
- Tener acceso a una red local (wifi de casa)

**Pasos:**

1. Abrir Wireshark, seleccionar tu interfaz de red activa (wlan0, eth0)
2. Iniciar captura (boton play)
3. Abrir tu navegador y visitar `http://neverssl.com` (sitio en HTTP puro)
4. Detener captura despues de 30 segundos
5. Aplicar el filtro: `http`

**Responde:**

a) Cuantos paquetes HTTP capturaste?
b) Encuentra un request GET. Que URL pidio el navegador?
c) Encuentra la response. Que codigo de estado devolvio el servidor?
d) Puedes ver el contenido HTML de la respuesta en texto claro? Por que es esto un problema de seguridad?
e) Ahora visita `https://google.com`. En la captura con filtro `tls`, puedes ver el contenido? Por que?

**Entregar:** captura de pantalla de Wireshark mostrando el trafico HTTP

---

## Ejercicio 2 — Escaneo de tu red local con nmap (obligatorio)

**Solo en tu red de casa. Nunca en redes que no sean tuyas.**

```bash
# Tu IP local (busca el rango)
ip addr show    # Linux
ipconfig        # Windows
ifconfig        # Mac

# Escaneo de hosts activos en tu red
nmap -sn 192.168.1.0/24   # cambia el rango segun tu red

# Escaneo del router (primera IP del rango, generalmente .1)
nmap -sV 192.168.1.1
```

**Responde:**

a) Cuantos dispositivos encontro en tu red local?
b) Que puertos tiene abiertos tu router?
c) Que version del servicio detecto en cada puerto?
d) Hay algun puerto abierto que no esperabas? Investiga a que servicio pertenece.
e) Si hubiera un puerto 23 (Telnet) abierto, que significa eso?

---

## Ejercicio 3 — Reto: Analizar una captura de red (reto)

Descarga la captura de red de practica (archivo `.pcap`):

```
http://wiki.wireshark.org/SampleCaptures (seccion HTTP)
Descargar: "http.cap" o "http_with_jpegs.cap"
```

Abre el archivo en Wireshark y encuentra:

1. Cuantos hosts distintos participan en la comunicacion?
2. Cual es la URL mas visitada?
3. Hay credenciales enviadas en texto claro? (busca POST requests)
4. Exporta un objeto HTTP embebido (File > Export Objects > HTTP)
5. Que herramienta de analisis de red usarias si este fuera un incidente real en produccion?

---

## Reflexion semanal

1. Sabias que todo tu trafico HTTP puede ser visto por cualquiera en la misma red wifi?
2. En tu trabajo o proyectos, que APIs o servicios usan HTTP (no HTTPS)?
3. Como verificarias que tu propia API FastAPI solo acepta HTTPS?
4. Si eres defensora: que colocarias entre el router de la empresa y los servidores internos para monitorear trafico?
