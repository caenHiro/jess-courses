# Guia de uso — Curso Python + AWS

Bienvenida al Curso 2. Ya sabes programar en Java — Python es el mismo razonamiento con menos ruido.

---

## Rutina semanal (4 pasos)

1. **Actualizar** — `git pull` para recibir el material de la semana
2. **Leer teoria** — `vault/02_Teoria/semana-XX.md` (30-45 min)
3. **Hacer practica** — `vault/03_Practicas/semana-XX.md`, escribe tu codigo en `codigo/semana-XX/`
4. **Subir avances** — `bash scripts/push.sh "semana-XX descripcion"`

---

## Diferencias vs el Curso de Java

| Concepto | Java | Python |
|---------|------|--------|
| Tipos | `int x = 5;` | `x = 5` |
| Bloques | `{ }` | indentacion |
| Imprimir | `System.out.println()` | `print()` |
| Main | `public static void main` | no existe, se ejecuta directo |
| Booleanos | `true` / `false` | `True` / `False` |

---

## Herramientas que vas a usar

| Herramienta | Para que |
|-------------|---------|
| Python 3.12+ | Lenguaje principal |
| `venv` | Entorno aislado por proyecto |
| `pip` | Instalar librerias |
| FastAPI | Hacer APIs web |
| boto3 | Conectar con AWS |
| AWS CLI | Controlar AWS desde terminal |
| Docker | PostgreSQL local para practicas |

---

## Reglas del juego

- Los errores son normales. Si algo no funciona, leelo, busca en Google, pregunta.
- No hay comparaciones con nadie. Tu avance es tu avance.
- Si una semana fue dificil, esta bien ir mas despacio.
- Escribe siempre en `04_Notas_Personales/_Progreso.md` como te fue.

---

## Checklist de instalacion

Antes de empezar la Semana 1:

- [ ] Python 3.12+ instalado (`python --version`)
- [ ] pip funcionando (`pip --version`)
- [ ] VS Code instalado
- [ ] Git configurado (`git config --global user.name "Jess"`)
- [ ] AWS account creada (puedes hacerlo en la Semana 9)
- [ ] Docker instalado (para las semanas de FastAPI + BD)
