# Practica — Semana 3: Linux

---

## Ejercicio 1 — Permisos, usuarios y archivos sospechosos (obligatorio)

En una terminal Linux (puede ser Kali, Ubuntu, o WSL):

**Parte A — Exploracion de permisos:**
```bash
ls -la /etc/ | head -20
ls -la /tmp/
ls -la /var/log/
```

Responde:
- Que archivos en `/etc/` tienen permisos de escritura para "others"? Eso es un problema?
- Que hay en `/tmp/`? Por que los atacantes suelen usar esta carpeta?
- Que archivos de log existen en `/var/log/`?

**Parte B — Crear y gestionar usuarios:**
```bash
# Crear usuario de prueba
sudo useradd -m usuario_prueba
sudo passwd usuario_prueba

# Ver informacion del usuario
id usuario_prueba
cat /etc/passwd | grep usuario_prueba

# Agregar a un grupo
sudo usermod -aG sudo usuario_prueba

# Eliminar al terminar
sudo userdel -r usuario_prueba
```

**Parte C — Buscar archivos con SUID:**
```bash
find / -perm -4000 2>/dev/null
```

Lista los archivos que encontraste con SUID. Investiga si alguno tiene vulnerabilidades conocidas.

---

## Ejercicio 2 — Analisis de logs del sistema (obligatorio)

```bash
# Ver ultimos intentos de login
last -n 20
lastb -n 10    # intentos fallidos

# Buscar en auth.log (Ubuntu) o /var/log/secure (CentOS)
sudo grep "Failed password" /var/log/auth.log | tail -20
sudo grep "Accepted" /var/log/auth.log | tail -10
```

**Si no tienes auth.log** (sistema nuevo sin intentos de login), crea el escenario:
```bash
# Simular intentos fallidos SSH en localhost
ssh usuario_incorrecto@localhost  # repetir 5 veces con password incorrecto
# Luego buscar en los logs
```

**Responde:**
a) Cuantos intentos fallidos hay en tu sistema?
b) De que IPs vienen (si las hay)?
c) Escribe un comando que cuente intentos fallidos por IP y los ordene de mayor a menor

---

## Ejercicio 3 — Reto: Script de auditoria de seguridad (reto)

Crea un script `auditoria.sh` que haga lo siguiente automaticamente:

```bash
#!/usr/bin/env bash
# auditoria.sh — script de auditoria basica de seguridad

echo "=== AUDITORIA DE SEGURIDAD $(date) ==="
echo ""

echo "--- Usuarios con login ---"
# TODO: listar usuarios con shell valida en /etc/passwd

echo ""
echo "--- Puertos escuchando ---"
# TODO: listar puertos TCP/UDP en escucha

echo ""
echo "--- Archivos SUID en / ---"
# TODO: buscar archivos con bit SUID

echo ""
echo "--- Ultimos 5 logins exitosos ---"
# TODO: mostrar los 5 ultimos logins

echo ""
echo "--- Ultimos 5 intentos fallidos ---"
# TODO: mostrar los 5 ultimos intentos fallidos

echo ""
echo "--- Procesos escuchando en red ---"
# TODO: mostrar procesos con conexiones de red

echo "=== FIN AUDITORIA ==="
```

Completa todos los `TODO` con los comandos correctos.

---

## Reflexion semanal

1. En tus proyectos de Python/Java, que usuario del sistema operativo ejecuta la aplicacion? Deberia ser root?
2. Que logs genera tu API FastAPI? Donde se guardan?
3. Si un atacante comprometiera tu servidor, que seria lo primero que buscarias en los logs para detectarlo?
4. Que diferencia hay entre ejecutar `sudo python3 app.py` y `python3 app.py`? Por que importa?
