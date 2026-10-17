# Kali Linux — Instalacion (opcional pero recomendado)

> Kali es una distribucion de Linux con todas las herramientas de seguridad preinstaladas.
> Para este curso puedes usarla como VM o como WSL2 en Windows.

---

## Opcion 1: WSL2 en Windows (mas facil)

```powershell
# En PowerShell como administrador
wsl --install -d kali-linux

# Iniciar Kali
wsl -d kali-linux

# Instalar herramientas comunes
sudo apt update && sudo apt install -y \
    kali-tools-web \
    kali-tools-passwords \
    wireshark \
    burpsuite \
    nmap
```

## Opcion 2: VirtualBox (recomendado para Mac/Linux)

1. Instalar VirtualBox: `virtualbox.org`
2. Descargar imagen de Kali: `kali.org/get-kali/#kali-virtual-machines`
3. Seleccionar "VirtualBox" → descargar el `.ova`
4. VirtualBox > Archivo > Importar servicio virtualizado
5. Seleccionar el `.ova`
6. Iniciar la VM

**Credenciales por defecto:** `kali / kali`

## Herramientas incluidas en Kali (las que usaremos)

```bash
# Escaneo de red
nmap --version
masscan --version

# Sniffing
wireshark
tcpdump

# Web
burpsuite
sqlmap --version
nikto -Version

# Passwords
john --version
hashcat --version

# Explotacion
msfconsole --version
```

## Alternativa: usar Ubuntu con herramientas instaladas manualmente

```bash
sudo apt install nmap wireshark john hashcat netcat-traditional sqlmap
pip3 install jwt-tool scapy
```

---

## Nota importante

Kali es una herramienta, no magia. Las herramientas que instalas en Ubuntu son las mismas que en Kali. La diferencia es que Kali ya las tiene todo configurado y preinstalado.
