# Instalación de Docker y PostgreSQL en contenedor

> Docker te permite correr bases de datos (y otros servicios) sin instalarlos directamente en tu máquina. Todo queda en un "contenedor" aislado que puedes prender/apagar en segundos.

---

## ¿Qué es Docker?

Imagina que en lugar de instalar MySQL directamente en tu computadora (con sus configuraciones, permisos, posibles conflictos), lo "empaques" en una caja sellada que funciona siempre igual, sin importar en qué computadora la pongas. Eso es Docker.

Ventajas:
- PostgreSQL / MySQL listos en un solo comando
- Sin conflictos con otras instalaciones
- Fácil de borrar y recrear
- El mismo entorno en todas las computadoras

---

## Instalación de Docker

### Windows

1. Ve a: https://www.docker.com/products/docker-desktop/
2. Descarga **Docker Desktop** para Windows
3. Ejecuta el instalador → acepta los términos → reinicia la computadora
4. Abre Docker Desktop — espera a que el ícono en la barra de tareas deje de girar
5. Abre una terminal (PowerShell o CMD) y escribe: `docker --version`

**Requisito en Windows:** necesitas WSL 2 activado. Si el instalador te lo pide:
```
wsl --install
```
Reinicia y vuelve a abrir Docker Desktop.

### macOS

1. Descarga Docker Desktop desde https://www.docker.com/products/docker-desktop/
   - Elige "Mac with Apple chip" si tienes M1/M2/M3/M4, o "Mac with Intel chip" si es Intel
2. Arrastra Docker.app a la carpeta Aplicaciones
3. Abre Docker desde Aplicaciones
4. Verifica: `docker --version`

Con Homebrew:
```bash
brew install --cask docker
```

### Linux (Ubuntu)

```bash
# Instalar dependencias
sudo apt update
sudo apt install -y ca-certificates curl gnupg

# Agregar repositorio oficial de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

# Instalar Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Agregar tu usuario al grupo docker (para no necesitar sudo)
sudo usermod -aG docker $USER
newgrp docker

# Verificar
docker --version
```

---

## Levantar PostgreSQL con Docker

> Atajo: este repo ya trae un `docker-compose.yml` en la raíz con un servicio `db` listo (usuario `jess`/`jess123`, base `curso_java`, puerto 5434) — `docker compose up -d db` y listo. Lo de abajo es para entender qué hace ese compose por dentro.

Una vez que Docker esté instalado, crear una base de datos PostgreSQL es un solo comando:

```bash
docker run -d \
  --name mi-postgres \
  -e POSTGRES_USER=alumno \
  -e POSTGRES_PASSWORD=alumno123 \
  -e POSTGRES_DB=mi_escuela \
  -p 5434:5432 \
  postgres:16
```

Qué hace cada parte:
- `--name mi-postgres` — nombre del contenedor
- `-e POSTGRES_USER=alumno` — usuario de la BD
- `-e POSTGRES_PASSWORD=alumno123` — contraseña
- `-e POSTGRES_DB=mi_escuela` — nombre de la base de datos
- `-p 5434:5432` — expone el puerto 5434 de tu máquina (mapeado al 5432 interno del contenedor). Se usa 5434 en vez del 5432 estándar porque en este workspace el 5432 ya lo ocupa el Postgres del Portal Personal — si en tu máquina el 5432 está libre, puedes usarlo sin problema (`-p 5432:5432`)
- `postgres:16` — imagen de PostgreSQL versión 16

---

## Comandos básicos de Docker

```bash
# Ver contenedores en ejecución
docker ps

# Ver TODOS los contenedores (incluyendo detenidos)
docker ps -a

# Detener un contenedor
docker stop mi-postgres

# Volver a iniciarlo (no pierde datos)
docker start mi-postgres

# Ver los logs del contenedor
docker logs mi-postgres

# Eliminar el contenedor (¡cuidado! borra los datos también si no tienes volumen)
docker rm mi-postgres
```

---

## Conectarse a PostgreSQL desde la terminal

```bash
# Entrar al contenedor y abrir psql
docker exec -it mi-postgres psql -U alumno -d mi_escuela

# Desde ahí puedes escribir queries SQL directamente:
\dt       -- ver tablas
\q        -- salir
```

---

## Conectarse desde DBeaver

1. Abre DBeaver
2. Nueva conexión → **PostgreSQL**
3. Configura:
   - **Host:** localhost
   - **Port:** 5434 (o 5432 si no usaste el mapeo alterno)
   - **Database:** mi_escuela
   - **Username:** alumno
   - **Password:** alumno123
4. Test Connection → si sale "Connected", ¡listo!

---

## MySQL con Docker (alternativa)

Si prefieres MySQL en lugar de PostgreSQL:

```bash
docker run -d \
  --name mi-mysql \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -e MYSQL_DATABASE=mi_escuela \
  -e MYSQL_USER=alumno \
  -e MYSQL_PASSWORD=alumno123 \
  -p 3306:3306 \
  mysql:8
```

Conectarte:
```bash
docker exec -it mi-mysql mysql -u alumno -palumno123 mi_escuela
```

---

## Persistir datos con volúmenes (recomendado)

Por defecto, si borras el contenedor pierdes todos los datos. Para evitarlo:

```bash
docker run -d \
  --name mi-postgres \
  -e POSTGRES_USER=alumno \
  -e POSTGRES_PASSWORD=alumno123 \
  -e POSTGRES_DB=mi_escuela \
  -p 5434:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:16
```

El volumen `postgres_data` persiste aunque borres el contenedor.

---

## ¿Qué sigue?

Cuando tengas Docker y PostgreSQL corriendo, estás listo para la semana 11 (SQL).
También lo usarás en Spring Boot para conectar tu aplicación a la base de datos.
