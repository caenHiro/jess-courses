# Guia de uso — Curso 3: Ciberseguridad

> Bienvenida al curso de ciberseguridad. Este es el mas practico de los tres.

---

## Como funciona este curso

Cada semana sigue el mismo flujo:

```
Lunes         Leer la teoria de la semana (02_Teoria/semana-XX.md)
Martes-Jueves Practicar los ejercicios (03_Practicas/semana-XX.md)
Viernes       Entregar ejercicios + reflexion
```

---

## Reglas del curso

### Lo que SÍ puedes hacer
- Practicar en laboratorios locales (WebGoat, DVWA)
- Usar TryHackMe y PicoCTF
- Escanear TU propia red local con nmap
- Interceptar TU propio trafico con Wireshark/Burp
- Buscar vulnerabilidades en TUS propios proyectos

### Lo que NO puedes hacer
- Escanear, atacar o interceptar sistemas que no son tuyos
- Usar las herramientas sin permiso del dueno del sistema
- Hacer brute force a servicios en produccion
- Compartir herramientas o tecnicas con fines maliciosos

**La linea entre hacker etico y criminal es el PERMISO.**

---

## Rutina semanal

### Paso 1: Leer la teoria
1. Abrir `02_Teoria/semana-XX.md`
2. Tomar notas en `04_Notas_Personales/`
3. Probar los ejemplos de codigo en tu terminal

### Paso 2: Practicar
1. Abrir `03_Practicas/semana-XX.md`
2. Resolver los ejercicios en orden
3. Documentar todo lo que haces y aprendes

### Paso 3: Subir avances
```bash
bash scripts/push.sh "semana-01 fundamentos"
```

### Paso 4: Reflexion
1. Actualizar `04_Notas_Personales/_Progreso.md`
2. Responder las preguntas de reflexion de la practica

---

## Diferencias vs el Curso de Java y Python

| Aspecto | Java/Python | Ciberseguridad |
|---------|------------|---------------|
| Principal recurso | IDE | Terminal + herramientas |
| Practica | Escribir codigo | Analizar y atacar sistemas en lab |
| Plataforma | Local | Local + TryHackMe + PicoCTF |
| Riesgo de error | Tu codigo falla | Cuidado: errores legales si atacas sistemas reales |

---

## Herramientas principales

| Semana | Herramienta principal |
|--------|----------------------|
| 1 | Navegador + haveibeenpwned |
| 2 | Wireshark + nmap |
| 3 | Terminal Linux |
| 4-5 | WebGoat + Burp Suite |
| 6 | Python (cryptography, bcrypt, jwt) |
| 7 | TryHackMe + PicoCTF + Burp Suite |
| 8 | Wazuh |

---

## Estructura de carpetas

```
vault/
├── 00_Guia_Uso.md          <- este archivo
├── 01_Instalacion/         <- guias de instalacion de herramientas
├── 02_Teoria/              <- notas de cada semana
├── 03_Practicas/           <- ejercicios de cada semana
└── 04_Notas_Personales/    <- tus apuntes, progreso, flags de CTF
    ├── _Progreso.md        <- tabla de avance semanal
    └── semana-XX_*.md      <- notas especificas de cada semana
```
