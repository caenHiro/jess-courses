---
tema: Conectarse a MySQL con DBeaver
estado: en-progreso
---

# Conectarse a MySQL con DBeaver

> DBeaver es un cliente de base de datos gratuito con interfaz gráfica. Te permite ver las tablas, ejecutar consultas y ver los resultados de forma visual.

---

## Paso 1 — Instalar DBeaver

Descarga la versión **Community Edition** (gratuita):
- Windows: ejecuta el instalador `.exe`
- Mac: instala el `.dmg`
- Linux: usa el `.deb` o `.rpm`

Sitio oficial: https://dbeaver.io/download/

---

## Paso 2 — Crear una nueva conexión

1. Abre DBeaver
2. Clic en el ícono de enchufe con `+` (esquina superior izquierda) o ve a **Database → New Database Connection**
3. En la lista de tipos, selecciona **MySQL**
4. Clic en **Next**

---

## Paso 3 — Configurar la conexión

Llena los campos con las credenciales de Docker:

| Campo | Valor |
|---|---|
| **Server Host** | `localhost` |
| **Port** | `3306` (o `3307` si usaste ese puerto) |
| **Database** | `rrhh` |
| **Username** | `root` |
| **Password** | `rrhh2025` |

Clic en **Test Connection** — debe decir "Connected". Si pide descargar el driver de MySQL, acepta.

Clic en **Finish**.

---

## Paso 4 — Explorar la base de datos

En el panel izquierdo (Database Navigator) verás:
```
mysql-rrhh
  └── rrhh
      ├── Tables
      ├── Views
      ├── Procedures
      └── Triggers
```

Haz clic derecho en cualquier tabla → **View Data** para ver su contenido.

---

## Paso 5 — Ejecutar un script SQL

**Opción A — Abrir un archivo SQL:**
1. `File → Open File`
2. Selecciona el archivo `.sql`
3. Presiona `Ctrl+A` para seleccionar todo
4. Presiona `Ctrl+Enter` o el botón de "play" naranja para ejecutar

**Opción B — Escribir una consulta nueva:**
1. Clic derecho en la base de datos `rrhh` → **SQL Editor → Open SQL Script**
2. Escribe tu consulta
3. `Ctrl+Enter` para ejecutar

---

## Atajos de teclado útiles en DBeaver

| Atajo | Función |
|---|---|
| `Ctrl+Enter` | Ejecutar la consulta donde está el cursor |
| `Ctrl+Shift+Enter` | Ejecutar todo el script |
| `Ctrl+A` | Seleccionar todo el texto |
| `Ctrl+/` | Comentar/descomentar línea |
| `Ctrl+Space` | Autocompletado SQL |
| `F5` | Refrescar la lista de tablas |

---

## Ver resultados de las consultas

Los resultados aparecen en el panel inferior en forma de tabla. Puedes:
- Ordenar haciendo clic en el encabezado de cada columna
- Exportar los resultados con clic derecho → **Export**
- Copiar filas seleccionadas con `Ctrl+C`

---

## Ejecutar los scripts del curso

Una vez conectada, ejecuta cada archivo en orden:

```
1. Abrir: scripts/01_ddl.sql     → Ctrl+A → Ctrl+Shift+Enter
2. Abrir: scripts/02_dml.sql     → Ctrl+A → Ctrl+Shift+Enter
3. Abrir: scripts/03_procedimientos.sql → Ctrl+A → Ctrl+Shift+Enter
4. Abrir: scripts/04_disparadores.sql   → Ctrl+A → Ctrl+Shift+Enter
```

Después de cada script, presiona **F5** en el panel izquierdo para refrescar y ver las nuevas tablas/procedimientos/triggers.

---

> Siguiente: [[../03_Ejercicios/00_Descripcion_BD]] — entender el esquema de la BD de práctica
