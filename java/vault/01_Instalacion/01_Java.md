# Instalación de Java (JDK 21)

> Java Development Kit (JDK) es el software que necesitas para escribir y ejecutar programas Java.

---

## Windows

1. Ve a: https://adoptium.net
2. Descarga **Temurin 21 (LTS)** — elige "Windows x64 .msi"
3. Ejecuta el instalador → "Next" en todo → **activa la opción "Set JAVA_HOME"**
4. Cuando termine, abre una terminal (tecla Windows + R → escribe `cmd` → Enter)
5. Escribe: `java -version`
6. Debes ver algo como: `openjdk version "21.0.x"`

**Si no reconoce el comando:**
- Ve a "Variables de entorno del sistema" → busca `JAVA_HOME` → verifica que apunte a la carpeta donde instalaste Java
- Cierra y vuelve a abrir la terminal

---

## macOS

Con Homebrew (la forma más fácil):
```bash
brew install --cask temurin@21
```

Verifica:
```bash
java -version
```

Sin Homebrew: descarga desde https://adoptium.net (igual que Windows, elige "macOS .pkg")

---

## Linux (Ubuntu / Debian)

```bash
sudo apt update
sudo apt install -y openjdk-21-jdk
java -version
```

Para otras distribuciones (Fedora/RHEL):
```bash
sudo dnf install java-21-openjdk-devel
```

---

## Verificar instalación (en cualquier SO)

```bash
java -version
javac -version
```

Ambos comandos deben mostrar la versión 21.

---

## ¿Qué sigue?

Una vez instalado Java, instala VS Code: [[02_VSCode]]
