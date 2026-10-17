# Instalar Python

## Windows

1. Ve a python.org/downloads
2. Descarga Python 3.12 (o mayor)
3. En el instalador: marca "Add Python to PATH" (importante)
4. Instala

Verifica:
```cmd
python --version
pip --version
```

## macOS

```bash
brew install python@3.12
```

O descargar desde python.org. Verifica:
```bash
python3 --version
pip3 --version
```

## Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install python3.12 python3-pip python3-venv
python3 --version
```

---

## Entorno Virtual (venv)

Cada proyecto Python usa su propio entorno virtual para no mezclar librerias:

```bash
# Crear entorno en el proyecto
python -m venv venv

# Activar (Linux/Mac)
source venv/bin/activate

# Activar (Windows)
venv\Scripts\activate

# Instalar una libreria
pip install fastapi

# Desactivar cuando terminas
deactivate
```

Sabes que esta activo porque el prompt muestra `(venv)`.
