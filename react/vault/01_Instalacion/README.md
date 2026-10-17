# Instalacion — Setup del entorno

Antes de empezar necesitas instalar 3 cosas. Te toma menos de 20 minutos.

---

## 1. Node.js (el motor de JavaScript)

JavaScript nacio en el navegador. Node.js lo saca del navegador y te deja usarlo en tu computadora, igual que Java en la terminal.

Descarga la version **LTS** (la estable):
- Windows: https://nodejs.org/en/download

Elige el instalador `.msi` para Windows.

Verifica que se instalo bien (abre una terminal nueva despues de instalar):

```bash
node --version    # debe mostrar v20.x.x o mayor
npm --version     # debe mostrar 10.x.x o mayor
```

---

## 2. VS Code (el editor)

Si ya lo tienes, ve al paso 3.

Descarga: https://code.visualstudio.com/

### Extensiones recomendadas

Abre VS Code y en el panel izquierdo busca el icono de extensiones (cuatro cuadritos).
Instala estas:

| Extension | Para que sirve |
|-----------|---------------|
| **ES7+ React/Redux/React-Native snippets** | Atajos para escribir componentes React rapido |
| **Prettier - Code formatter** | Formatea tu codigo automaticamente |
| **ESLint** | Te avisa de errores comunes en JS/TS |
| **TypeScript Error Translator** | Traduce los errores de TypeScript a lenguaje normal |
| **Auto Rename Tag** | Al cambiar una etiqueta JSX cambia las dos automaticamente |
| **GitLens** | Ver quien cambio cada linea del codigo |

### Configurar Prettier (formateo automatico al guardar)

1. `Ctrl+Shift+P` → escribe "settings json" → abre `Preferences: Open User Settings (JSON)`
2. Agrega esto:

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.tabSize": 2
}
```

---

## 3. Git

Si ya tomaste el curso de Java ya tienes Git. Verifica:

```bash
git --version
```

Si no lo tienes: https://git-scm.com/download/win

---

## Configurar este repositorio

```bash
# Clona el repositorio (hazlo una sola vez)
git clone https://github.com/caenHiro/jess-react-course.git

# Entra a la carpeta
cd jess-react-course

# Ya puedes empezar con la semana 1
```

---

## Listo

Cuando tengas `node --version` y `git --version` funcionando, pasa a:
`vault/02_Teoria/semana-01.md`
