# Instalación de Maven

> Maven es una herramienta para gestionar proyectos Java más grandes. La usarás a partir de la semana 12 y en el curso de Spring Framework.

---

## Windows

1. Ve a: https://maven.apache.org/download.cgi
2. Descarga el "Binary zip archive" (ej: `apache-maven-3.9.x-bin.zip`)
3. Extrae el zip en una carpeta, por ejemplo: `C:\Program Files\Maven\`
4. Agrega Maven al PATH:
   - Busca "Variables de entorno" en el menú de inicio
   - En "Variables del sistema" → "Path" → "Editar" → "Nuevo"
   - Agrega: `C:\Program Files\Maven\apache-maven-3.9.x\bin`
5. Abre una nueva terminal y escribe: `mvn -version`

---

## macOS

```bash
brew install maven
mvn -version
```

---

## Linux (Ubuntu)

```bash
sudo apt install maven
mvn -version
```

---

## Verificar instalación

```bash
mvn -version
```

Debes ver algo como: `Apache Maven 3.9.x`

---

## ¿Para qué sirve Maven?

- Gestiona las dependencias de tu proyecto (librerías externas)
- Compila, prueba y empaqueta tu proyecto con un solo comando
- Es el estándar en proyectos Spring Boot

Lo usarás más adelante cuando trabajemos con Spring Framework.
