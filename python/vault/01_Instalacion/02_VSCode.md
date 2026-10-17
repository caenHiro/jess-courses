# VS Code para Python

## Instalar

1. Descarga desde code.visualstudio.com
2. Instala normalmente

## Extensiones recomendadas

Abre VS Code → Extensions (Ctrl+Shift+X) → instala:

- **Python** (Microsoft) — indispensable
- **Pylance** — autocompletado inteligente
- **Python Indent** — indentacion automatica
- **REST Client** — probar APIs desde VS Code

## Configurar el interprete

1. Abre una carpeta de proyecto
2. Ctrl+Shift+P → "Python: Select Interpreter"
3. Selecciona el Python de tu `venv` (aparece con la ruta del proyecto)

## Atajos utiles

| Atajo | Accion |
|-------|--------|
| F5 | Ejecutar con debugger |
| Ctrl+F5 | Ejecutar sin debugger |
| Ctrl+` | Abrir terminal integrada |
| Ctrl+Shift+P | Paleta de comandos |
| Shift+Alt+F | Formatear codigo |

## Ejecutar un archivo Python

```bash
# En la terminal integrada de VS Code
python main.py

# O con venv activo
python archivo.py
```
