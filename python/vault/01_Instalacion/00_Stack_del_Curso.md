# Stack del Curso Python + AWS

## Lo que vas a instalar

| Herramienta | Version | Para que |
|-------------|---------|---------|
| Python | 3.12+ | Lenguaje del curso |
| VS Code | Ultimo | Editor de codigo |
| Git | Ultimo | Control de versiones |
| Docker Desktop | Ultimo | PostgreSQL local |
| AWS CLI | 2.x | Controlar AWS desde terminal |

---

## Orden de instalacion recomendado

1. Python (`01_Python.md`)
2. VS Code (`02_VSCode.md`)
3. Git (`03_Git.md`)
4. Docker (`04_Docker.md`) — necesario desde la Semana 8
5. AWS CLI — se instala con pip en la Semana 9: `pip install awscli`

---

## Diferencias con el Curso de Java

Este curso no necesita:
- Maven
- Spring Boot
- IntelliJ (VS Code es suficiente para Python)

Agrega:
- `venv` — entornos virtuales Python (equivalente a Maven por proyecto)
- `pip` — gestor de paquetes Python (equivalente a Maven dependencies)
- AWS CLI — para desplegar Lambdas
- boto3 — libreria Python para AWS
