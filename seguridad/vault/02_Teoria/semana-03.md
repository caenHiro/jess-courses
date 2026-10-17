# Semana 3 — Linux: El sistema operativo de los hackers

> Objetivo: moverse con confianza en Linux — permisos, procesos, logs, scripting.

---

## Por que Linux importa en seguridad

- La mayoria de servidores en internet corren Linux
- Las herramientas de seguridad (Kali, Wireshark, nmap) son nativas de Linux
- Los malware para servidores estan escritos para Linux
- Como defensora debes poder leer logs, procesos y permisos en Linux

---

## Sistema de archivos Linux

```
/           — raiz del sistema
/etc        — archivos de configuracion
/var/log    — logs del sistema
/home       — carpetas de usuarios (/home/jess)
/tmp        — archivos temporales (los malware los usan)
/bin /usr/bin — ejecutables del sistema
/sbin /usr/sbin — ejecutables de administracion
/proc       — informacion de procesos en ejecucion
/root       — home del superusuario
```

---

## Usuarios y permisos

### Tipos de usuario

```bash
# Ver quien soy
whoami

# Ver todos los usuarios del sistema
cat /etc/passwd

# Ver grupos
cat /etc/group

# Cambiar a superusuario
sudo su
```

### Permisos de archivo

```bash
ls -la /etc/passwd
```

Resultado:
```
-rw-r--r--  1  root  root  2847  jun 14  /etc/passwd
```

Desglose:
```
-  rw-  r--  r--
|   |    |    |
|   |    |    otros: solo leer
|   |    grupo: solo leer
|   dueno: leer y escribir
tipo: - = archivo, d = directorio, l = symlink
```

| Permiso | Numero | Significado |
|---------|--------|-------------|
| r (read) | 4 | Leer |
| w (write) | 2 | Escribir |
| x (execute) | 1 | Ejecutar |

```bash
# Cambiar permisos
chmod 644 archivo.txt     # rw-r--r--
chmod 755 script.sh       # rwxr-xr-x
chmod 600 clave_privada   # rw------- (solo el dueno)

# Cambiar dueno
chown jess:jess archivo.txt
```

### SUID/SGID — bit especial (vulnerabilidad comun)

```bash
# Buscar archivos con SUID (se ejecutan con permisos del dueno, no del usuario)
find / -perm -4000 2>/dev/null
```

Si un ejecutable del root tiene SUID y es vulnerable, el atacante puede escalar privilegios.

---

## Procesos

```bash
# Ver todos los procesos
ps aux

# Ver en tiempo real
top
htop  # version mejorada

# Buscar proceso por nombre
ps aux | grep nginx

# Matar proceso
kill 1234        # por PID
killall nginx    # por nombre

# Ver conexiones de red activas
netstat -tuln
ss -tuln

# Ver que proceso usa un puerto
lsof -i :8000
```

### /proc — sistema de archivos de procesos

```bash
# Ver info de proceso 1234
ls /proc/1234/

cat /proc/1234/cmdline   # comando que lo inicio
cat /proc/1234/environ   # variables de entorno (pueden tener secretos)
ls -la /proc/1234/fd/    # archivos abiertos
```

---

## Logs del sistema

Los logs son el oro del Blue Team. Todo queda registrado.

```bash
# Logs del sistema
tail -f /var/log/syslog
tail -f /var/log/auth.log    # intentos de login

# Ultimas conexiones SSH
last
lastb  # intentos fallidos

# Logs de aplicaciones comunes
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log
tail -f /var/log/mysql/error.log

# Logs con journalctl (systemd)
journalctl -u nginx         # logs del servicio nginx
journalctl -f               # seguimiento en tiempo real
journalctl --since "1 hour ago"
```

### Analisis de logs — que buscar

```bash
# Buscar errores
grep -i "error\|fail\|deny" /var/log/auth.log

# Contar intentos fallidos por IP
grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -rn

# Buscar accesos inusuales por hora
grep "10/Jun/2025" /var/log/nginx/access.log | awk '{print $4}' | cut -d: -f2 | sort | uniq -c
```

---

## Bash scripting para seguridad

### Estructura basica

```bash
#!/usr/bin/env bash
# descripcion del script

set -euo pipefail  # errores fatales

VARIABLE="valor"
echo "Hola $VARIABLE"

# Condicional
if [ "$1" == "test" ]; then
    echo "modo test"
fi

# Loop
for archivo in /var/log/*.log; do
    echo "Revisando: $archivo"
    grep -c "error" "$archivo" || true
done
```

### Script: buscar conexiones activas

```bash
#!/usr/bin/env bash
echo "=== Conexiones activas ==="
ss -tuln

echo ""
echo "=== Procesos escuchando ==="
ss -tlnp

echo ""
echo "=== Ultimos logins ==="
last -n 10
```

### Script: buscar archivos modificados recientemente

```bash
#!/usr/bin/env bash
# Archivos modificados en las ultimas 24 horas — util para deteccion de intrusion
find / -mtime -1 -type f 2>/dev/null | grep -v "/proc\|/sys\|/dev" | head -50
```

---

## Hardening basico de Linux

```bash
# Deshabilitar acceso SSH como root
# Editar /etc/ssh/sshd_config:
PermitRootLogin no
PasswordAuthentication no  # solo claves SSH

# Ver intentos de brute force
grep "Failed password" /var/log/auth.log | wc -l

# Instalar fail2ban (bloquea IPs con multiples intentos fallidos)
sudo apt install fail2ban

# Ver reglas de firewall
sudo iptables -L
sudo ufw status  # en Ubuntu
```

---

## Escalada de privilegios (concepto)

El atacante entra con usuario limitado y busca escalar a root.

Vectores comunes:
1. **SUID mal configurado** — ejecutable root con SUID vulnerable
2. **Sudo mal configurado** — `sudo -l` muestra comandos que puedes ejecutar como root
3. **Cron jobs** — script de root que escribe archivos que puedes modificar
4. **Kernel vulnerability** — exploit del kernel (dirty cow, etc.)

```bash
# Que puedo ejecutar como sudo
sudo -l

# Variables de entorno inseguras
env

# Cron jobs
cat /etc/crontab
ls /etc/cron*
```

Herramienta de referencia: **LinPEAS** (linux privilege escalation awesome script) — solo en laboratorio.
