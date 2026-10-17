---
semana: 9
tema: AWS — cuenta, IAM y CLI
estado: pendiente
---

# Practica Semana 9 — AWS: configura tu cuenta y herramientas

> Lee la teoria en `02_Teoria/semana-09.md` antes de empezar.
> Esta semana es mas configuracion que codigo.
> Guarda capturas o anotaciones en: `codigo/semana-09/notas.md`

---

## Ejercicio 1 — Crear cuenta AWS (obligatorio)

1. Ve a aws.amazon.com y crea tu cuenta
2. Configura las alertas de billing:
   - Billing Dashboard → Billing Preferences → Receive Free Tier Usage Alerts
   - Budget: crea un presupuesto de $5 USD mensual para avisarte antes de cualquier cargo
3. Crea un usuario IAM:
   - IAM → Users → Create User
   - Nombre: `jess-dev`
   - Permisos: `AdministratorAccess`
   - Genera Access Keys para CLI

En `notas.md` escribe:
- Que pasos seguiste
- Que dudas tuviste
- Donde viste las opciones de billing

(NO escribas tus Access Keys en el archivo — esas son secretas)

---

## Ejercicio 2 — Configurar AWS CLI (obligatorio)

```bash
pip install awscli
aws configure
```

Verifica que funciona:
```bash
aws sts get-caller-identity
```

Deberia mostrar tu Account ID, UserID y ARN.

En `notas.md` escribe el output de `aws sts get-caller-identity` (puedes ocultar parte del Account ID si quieres).

---

## Ejercicio 3 — Explorar la consola (reto)

Explora estos 5 servicios en la consola AWS y escribe en `notas.md` una linea sobre cada uno:
- Lambda
- S3
- API Gateway
- CloudWatch
- IAM

¿Que ves en cada uno? ¿Que opciones te llaman la atencion?

---

## Reflexion

**¿Por que no debes usar el usuario root para tareas cotidianas?**

_Tu respuesta:_

**¿Para que sirven las Access Keys y donde debes guardarlas?**

_Tu respuesta:_

**¿Que te dio mas curiosidad al explorar la consola AWS?**

_Tu respuesta:_

---

Al terminar: `bash scripts/push.sh "semana-09 aws-cuenta-iam"`
