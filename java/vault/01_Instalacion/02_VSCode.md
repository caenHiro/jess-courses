# Instalación de VS Code + Extension Pack for Java

---

## 1. Instalar VS Code

Ve a https://code.visualstudio.com y descarga la versión para tu sistema operativo.

- **Windows:** descarga el instalador `.exe` → ejecuta → Next en todo
- **macOS:** descarga el `.zip` → mueve VS Code a la carpeta Aplicaciones
- **Linux:** descarga el `.deb` (Ubuntu) y ejecuta: `sudo dpkg -i code_*.deb`

---

## 2. Instalar la extensión de Java

1. Abre VS Code
2. Haz clic en el ícono de **Extensiones** (cuadradito en la barra lateral izquierda)
   — o usa el atajo: `Ctrl+Shift+X` (Windows/Linux) / `Cmd+Shift+X` (Mac)
3. En el buscador, escribe: `Extension Pack for Java`
4. Instala el paquete de **Microsoft** (tiene 6 extensiones incluidas)

---

## 3. Crear tu primer proyecto Java

1. Abre VS Code
2. Menú: **View → Command Palette** (o `Ctrl+Shift+P`)
3. Escribe: `Java: Create Java Project`
4. Elige: **No build tools** (para empezar simple)
5. Elige una carpeta donde guardar el proyecto
6. Dale un nombre, por ejemplo: `MiPrimerProyecto`

VS Code creará automáticamente la estructura:
```
MiPrimerProyecto/
├── src/
│   └── App.java    ← aquí escribes tu código
└── README.md
```

---

## 4. Ejecutar un programa

Dentro de un archivo `.java`, VS Code muestra un botón ▷ **Run** arriba del método `main`.
Haz clic en él — el programa correrá en la terminal integrada.

También puedes usar el atajo: `F5`

---

## 5. Configurar para el curso

Cada semana trabajarás en la carpeta `codigo/semana-XX/`. Puedes abrir esa carpeta directamente en VS Code:

1. **File → Open Folder**
2. Navega hasta `codigo/semana-01/`
3. Crea archivos `.java` directamente ahí

---

## Atajos útiles en VS Code

| Atajo | Acción |
|-------|--------|
| `Ctrl+Space` | Autocompletado |
| `F5` | Ejecutar |
| `Ctrl+S` | Guardar |
| `Ctrl+Z` | Deshacer |
| `Ctrl+/` | Comentar/descomentar línea |
| `Alt+Shift+F` | Formatear código automáticamente |

---

## ¿Qué sigue?

[[03_Git]]
