# Wireshark — Instalacion

## Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install wireshark

# Permitir captura sin root
sudo dpkg-reconfigure wireshark-common
# Seleccionar "Yes"

sudo usermod -aG wireshark $USER
# Cerrar sesion y volver a entrar para que aplique

# Abrir Wireshark
wireshark
```

## Windows

1. Descargar de `wireshark.org/download.html`
2. Instalar con todas las opciones por defecto
3. Incluye Npcap (driver de captura)
4. Buscar "Wireshark" en el menu de inicio

## Mac

```bash
brew install --cask wireshark
```

## Verificar instalacion

```bash
wireshark --version
tshark --version   # version de linea de comandos
```

## Primera captura

1. Abrir Wireshark
2. Doble click en tu interfaz de red activa (wlan0, eth0, Wi-Fi)
3. Visitar `http://neverssl.com` en el navegador
4. Ver los paquetes en tiempo real
5. Presionar el boton rojo de stop
6. Aplicar filtro: `http`
