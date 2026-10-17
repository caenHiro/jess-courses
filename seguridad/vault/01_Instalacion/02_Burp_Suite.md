# Burp Suite Community — Instalacion y configuracion

## Instalacion

### Linux

```bash
# Descargar de portswigger.net/burp/communitydownload
# Ejecutar el instalador
chmod +x burpsuite_community_linux_v*.sh
./burpsuite_community_linux_v*.sh
```

### Windows / Mac

1. Descargar de `portswigger.net/burp/communitydownload`
2. Ejecutar el instalador `.exe` o `.dmg`
3. Seguir el asistente

## Configurar Firefox con Burp

1. Abrir Firefox
2. Configuracion > General > Configuracion de red > Configuracion manual de proxy
3. Proxy HTTP: `127.0.0.1` Puerto: `8080`
4. Marcar "Usar este proxy para todos los protocolos"
5. OK

## Instalar certificado SSL de Burp (para HTTPS)

1. Con el proxy configurado, visitar `http://burpsuite` en Firefox
2. Click en "CA Certificate" para descargar
3. Firefox > Configuracion > Buscar "certificados" > Ver certificados
4. Pestaña "Autoridades" > Importar
5. Seleccionar el archivo descargado
6. Marcar "Confiar para identificar sitios web"
7. OK

## Verificar que funciona

1. Abrir Burp Suite
2. Proxy > Intercept > ON
3. En Firefox, navegar a `http://google.com`
4. Burp debe mostrar el request interceptado
5. Click en "Forward" para continuar
6. Apagar Intercept cuando no lo uses (Intercept > OFF)

## Tip: Perfil de Firefox dedicado a Burp

Crea un perfil de Firefox solo para Burp para no mezclar tu navegacion normal:

```bash
firefox -P burp-profile
```
