---
tema: Levantar MySQL con Docker
estado: en-progreso
---

# Levantar MySQL con Docker

> Docker te permite tener MySQL corriendo en tu computadora sin instalarlo directamente. Es más limpio, más fácil de reiniciar y puedes tener varias versiones al mismo tiempo.

---

## Requisitos previos

1. **Docker Desktop instalado** — descárgalo de [docker.com](https://www.docker.com/products/docker-desktop)
2. Verificar que funciona: abre una terminal y escribe:

```bash
docker --version
```

Debe mostrar algo como: `Docker version 27.x.x`

---

## Paso 1 — Descargar e iniciar MySQL

Copia y pega este comando en tu terminal (funciona en Windows con Git Bash, Mac o Linux):

```bash
docker run -d \
  --name mysql-rrhh \
  -e MYSQL_ROOT_PASSWORD=rrhh2025 \
  -e MYSQL_DATABASE=rrhh \
  -p 3306:3306 \
  mysql:8.0
```

**¿Qué hace cada parte?**
- `docker run -d` — ejecuta el contenedor en segundo plano (detached)
- `--name mysql-rrhh` — nombre del contenedor (para identificarlo)
- `-e MYSQL_ROOT_PASSWORD=rrhh2025` — contraseña del usuario `root`
- `-e MYSQL_DATABASE=rrhh` — crea la base de datos `rrhh` automáticamente
- `-p 3306:3306` — expone el puerto 3306 para conectarse desde DBeaver
- `mysql:8.0` — usa la imagen oficial de MySQL versión 8.0

---

## Paso 2 — Verificar que está corriendo

```bash
docker ps
```

Debes ver una línea con `mysql-rrhh` y estado `Up`.

---

## Paso 3 — Comandos útiles de Docker

```bash
# Detener MySQL (pero conservar los datos)
docker stop mysql-rrhh

# Volver a iniciar MySQL
docker start mysql-rrhh

# Ver los logs de MySQL (útil si algo falla)
docker logs mysql-rrhh

# Acceder a MySQL desde la terminal (opcional)
docker exec -it mysql-rrhh mysql -u root -prrhh2025 rrhh
```

---

## Paso 4 — Ejecutar los scripts SQL

Una vez que DBeaver esté conectado (ver siguiente nota), ejecuta los scripts en este orden:

1. `scripts/01_ddl.sql` — crea las tablas
2. `scripts/02_dml.sql` — inserta los datos de práctica
3. `scripts/03_procedimientos.sql` — crea los procedimientos almacenados
4. `scripts/04_disparadores.sql` — crea los triggers

---

## Credenciales de conexión

| Campo | Valor |
|---|---|
| Host | `localhost` |
| Puerto | `3306` |
| Base de datos | `rrhh` |
| Usuario | `root` |
| Contraseña | `rrhh2025` |

---

## Si el puerto 3306 está ocupado

Si ya tienes MySQL instalado en tu máquina, el puerto 3306 puede estar en uso. En ese caso, usa un puerto diferente:

```bash
docker run -d \
  --name mysql-rrhh \
  -e MYSQL_ROOT_PASSWORD=rrhh2025 \
  -e MYSQL_DATABASE=rrhh \
  -p 3307:3306 \
  mysql:8.0
```

Y en DBeaver pon el puerto `3307`.

---

## Solución de problemas comunes

**Error: `port is already allocated`**
→ El puerto 3306 está en uso. Cambia el puerto a 3307 o detén el MySQL local.

**El contenedor no inicia:**
→ Ejecuta `docker logs mysql-rrhh` para ver el error.

**Olvidaste la contraseña:**
→ Detén y elimina el contenedor (`docker rm -f mysql-rrhh`) y vuelve a crearlo desde el Paso 1.

---

> Siguiente: [[02_DBeaver]] — conectarse con DBeaver
