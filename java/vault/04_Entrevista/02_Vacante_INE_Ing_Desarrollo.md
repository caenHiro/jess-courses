---
tema: Vacante INE — Ingeniero en Desarrollo de Software y BD
estado: en-progreso
---

# Vacante INE — Ingeniero en Desarrollo de Software y Base de Datos

> Sueldo neto: $35,701.00 MXN  
> Nivel tabular: LB1  
> Entrega de documentos: **7 y 8 de julio de 2026** — 10:00 am a 15:00 hrs  
> Lugar: Unidad Técnica de Servicios de Informática, Viaducto Tlalpan 100 Edificio C, planta baja

---

## Checklist de documentos a entregar (original + fotocopia anverso y reverso)

- [ ] Curriculum Vitae en **formato oficial INE** (descárgalo de www.ine.mx) — firmado a mano
- [ ] Constancias de experiencia (mínimo 4 años) — cartas membretadas con: cargo, años, teléfono, correo, dirección, RFC, fecha y sello
- [ ] Título o cédula profesional (o comprobante de trámite + carta compromiso)
- [ ] Acta de nacimiento
- [ ] Identificación oficial vigente (INE, pasaporte o cédula)
- [ ] CURP
- [ ] RFC
- [ ] Comprobante de domicilio (máximo 30 días de antigüedad)
- [ ] La carta declaratoria bajo protesta se firma en el lugar

---

## Temario técnico que debes dominar

### 1. Java SE — Fundamentos

Los mismos temas de este curso: variables, tipos, condicionales, ciclos, clases, herencia, interfaces, excepciones, colecciones.

Lo que añade la vacante respecto al curso:
- **Genéricos:** `List<T>`, `Map<K,V>` con tipos definidos
- **Excepciones personalizadas:** `class MiExcepcion extends RuntimeException`
- **Manejo de fechas:** `LocalDate`, `LocalDateTime`, `DateTimeFormatter`
- **Streams y lambdas** (Java 8+)

### 2. Java EE — Aplicaciones empresariales

Java EE (ahora llamado Jakarta EE) es Java para aplicaciones grandes que corren en servidores.

Componentes que el INE usa:

| Tecnología | Para qué sirve | Ejemplo INE |
|---|---|---|
| **Servlets** | Recibir y responder peticiones HTTP | Recibir datos del sistema MCAD |
| **JSP** | Páginas web con código Java embebido | Pantallas del sistema de captura |
| **EJB** | Componentes empresariales con transacciones | Registrar actas en BD |
| **JPA** | Mapear clases Java a tablas de BD | Entidad `Acta` → tabla `TR_ACTAS` |

Ejemplo básico de Servlet:
```java
@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        // procesar...
        response.sendRedirect("/exito.jsp");
    }
}
```

### 3. Eclipse + JBoss (WildFly)

**Eclipse** es el IDE que usa el INE para desarrollo Java EE.

Conceptos clave de Eclipse:
- Perspective (vista de desarrollo)
- Workspace y Projects
- Build path y dependencias con Maven
- Run on Server (desplegar en JBoss desde Eclipse)

**JBoss / WildFly** es el servidor de aplicaciones donde corren los programas Java EE.

Comandos básicos de JBoss:
```bash
# Iniciar el servidor
./standalone.sh -c standalone.xml

# Desplegar una aplicación (colocar el .war en esta carpeta)
cp miapp.war $JBOSS_HOME/standalone/deployments/

# Ver logs en tiempo real
tail -f $JBOSS_HOME/standalone/log/server.log

# Detener el servidor
./jboss-cli.sh --connect command=:shutdown
```

### 4. Oracle Database

El INE usa Oracle (no MySQL ni PostgreSQL). Los conceptos SQL son los mismos, pero con algunas diferencias:

| MySQL / estándar | Oracle |
|---|---|
| `AUTO_INCREMENT` | `SEQUENCE` + `NEXTVAL` |
| `LIMIT 10` | `ROWNUM <= 10` (Oracle antiguo) o `FETCH FIRST 10 ROWS ONLY` |
| `NOW()` | `SYSDATE` |
| Strings con comillas dobles | Solo comillas simples `'texto'` |
| `SHOW TABLES` | `SELECT table_name FROM user_tables` |

Conceptos Oracle importantes:
- **Tablespace:** donde se almacenan físicamente los datos
- **Schema:** agrupación de objetos de un usuario (como `PREP.TR_ACTAS`)
- **Sequence:** genera IDs únicos automáticamente
- **PL/SQL:** lenguaje procedural de Oracle (como stored procedures)

Ejemplo de sequence en Oracle:
```sql
-- Crear la secuencia
CREATE SEQUENCE seq_actas START WITH 1 INCREMENT BY 1;

-- Usar en un INSERT
INSERT INTO TR_ACTAS (ID_ACTA, NOMBRE)
VALUES (seq_actas.NEXTVAL, 'Acta Centro');
```

**Oracle SQL Developer** — el IDE para Oracle (como DBeaver pero hecho por Oracle).
**Oracle Data Modeler** — herramienta para diseñar diagramas entidad-relación.

### 5. RedHat Linux — Comandos básicos

Los servidores del INE corren RedHat Enterprise Linux (RHEL).

Comandos que debes conocer:

```bash
# Navegar
ls -la                    # listar con detalles
cd /opt/jboss             # cambiar de carpeta
pwd                       # ver carpeta actual

# Archivos
cat archivo.log           # ver contenido
tail -f archivo.log       # ver últimas líneas en tiempo real
grep "ERROR" archivo.log  # buscar palabra en archivo
find / -name "*.war"      # buscar archivos

# Procesos
ps aux | grep jboss       # ver si JBoss está corriendo
kill -9 PID               # terminar proceso por ID

# Permisos
chmod 755 script.sh       # dar permisos de ejecución
chown usuario:grupo arch  # cambiar propietario

# Servicios (systemd en RHEL)
systemctl status wildfly  # ver estado del servicio
systemctl start wildfly   # iniciar
systemctl stop wildfly    # detener
systemctl restart wildfly # reiniciar

# Red
netstat -tlnp             # ver puertos abiertos
curl http://localhost:8080 # probar conexión HTTP
```

### 6. SIGETIC — Sistema de Gestión de TIC del INE

SIGETIC es el marco normativo que rige cómo se desarrollan y gestionan los sistemas de tecnología en el INE. Mencionarlo en la entrevista da puntos extra.

Lo que debes saber:
- **SIGETIC** establece el ciclo de vida del software: requerimientos → diseño → desarrollo → pruebas → despliegue → mantenimiento
- Los proyectos deben tener documentación formal (análisis, diseño, manuales)
- Las entregas pasan por un proceso de revisión antes de producción
- Hay estándares para nombrar variables, documentar código y versionar

Frase para la entrevista:
> "Estoy familiarizado con que en el INE el desarrollo sigue un proceso estructurado bajo SIGETIC, por lo que la documentación y el ciclo formal de vida del software son parte esencial del trabajo diario."

---

## Historia del INE (para la entrevista)

**¿Qué es el INE?**

El Instituto Nacional Electoral es el organismo autónomo encargado de organizar las elecciones federales en México. Es independiente del gobierno — no depende de ningún partido ni del presidente.

**Línea de tiempo clave:**

| Año | Evento |
|---|---|
| 1990 | Se crea el **IFE** (Instituto Federal Electoral) — primer organismo independiente para organizar elecciones |
| 1996 | El IFE se vuelve totalmente ciudadano (sin consejeros del gobierno) |
| 2014 | Reforma política: el IFE se transforma en **INE** con más atribuciones |
| 2014+ | El INE ahora también puede intervenir en elecciones locales (antes solo federales) |

**Estructura del INE:**
- **Consejo General:** máxima autoridad, 11 consejeras/os electorales (1 presidenta/e + 10)
- **Junta General Ejecutiva:** órgano ejecutivo
- **Unidades técnicas:** Servicios de Informática (donde está esta vacante), DERFE, etc.
- **Juntas Distritales:** ~300 oficinas locales en todo el país

**Funciones principales:**
- Organizar elecciones federales (presidencia, senado, diputados)
- Emitir la credencial de elector (el documento de identidad más usado en México)
- Mantener el Padrón Electoral (lista de votantes)
- Fiscalizar los recursos de los partidos políticos
- Organizar debates presidenciales

**Sistemas tecnológicos del INE:**
- **PREP:** Programa de Resultados Electorales Preliminares — muestra resultados la noche de la elección
- **SACER:** captura de actas en campo
- **MCAD:** módulo de captura y digitalización de actas
- **Sistema de credencialización:** emite las credenciales de elector

**Para la entrevista:**
> "Entiendo que el INE es un organismo autónomo que garantiza la certeza y transparencia electoral. Que la Unidad Técnica de Servicios de Informática da soporte a sistemas críticos como el PREP y el sistema de credencialización, lo que implica altos estándares de calidad, disponibilidad y seguridad en el software que se desarrolla."

---

## Simulador de examen técnico

Practica respondiendo estas preguntas en voz alta antes de memorizarlas:

**Java SE:**
- ¿Qué es la herencia en Java? Da un ejemplo
- ¿Cuál es la diferencia entre `ArrayList` y `LinkedList`?
- ¿Qué hace `try-catch-finally`?
- ¿Cuándo usas una interfaz y cuándo una clase abstracta?

**Java EE:**
- ¿Qué es un Servlet?
- ¿Cómo funciona JPA? ¿Qué es una entidad?
- ¿Qué diferencia hay entre `@Stateless` y `@Stateful` EJB?

**Oracle:**
- ¿Cómo haces una consulta con `JOIN`? Da un ejemplo
- ¿Qué es una secuencia en Oracle?
- ¿Cuál es la diferencia entre `DELETE` y `TRUNCATE`?
- ¿Qué es un índice y para qué sirve?

**Linux:**
- ¿Cómo verías los logs de una aplicación en tiempo real?
- ¿Cómo buscarías todos los archivos `.war` en el servidor?
- ¿Cómo verificarías si JBoss está corriendo?

**General/Soft skills:**
- ¿Cómo manejas un requerimiento poco claro de un área usuaria?
- ¿Cómo priorizas cuando tienes varios proyectos al mismo tiempo?
- ¿Qué harías si un sistema falla durante una elección?

---

## Frases clave para la entrevista

- "En mis proyectos he trabajado con arquitectura orientada a objetos y he seguido ciclos formales de desarrollo."
- "Estoy acostumbrado a trabajar con documentación técnica y a generar entregables claros para usuarios no técnicos."
- "Entiendo la importancia de la disponibilidad en sistemas electorales — una falla en producción tiene impacto directo en la ciudadanía."
- "He trabajado con bases de datos relacionales y tengo experiencia en el diseño e implementación de consultas complejas."
