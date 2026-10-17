# Semana 1 — Fundamentos: El mundo de la ciberseguridad

> Objetivo: entender el panorama actual. Quien ataca, por que, y como nos defendemos.

---

## La Triada CIA

Todo en seguridad gira alrededor de tres principios. Si cualquiera de los tres falla, hay un incidente:

| Principio | Significado | Ejemplo de fallo |
|-----------|-------------|-----------------|
| **C**onfidencialidad | Solo quien debe ver los datos, los ve | Hackean Netflix y venden contrasenas |
| **I**ntegridad | Los datos no son modificados sin permiso | Alguien cambia un precio en la BD |
| **D**isponibilidad | El sistema siempre debe estar accesible | Ataque DDoS tira Amazon por 6 horas |

Memoriza esto: **CIA Triad**. Es el ABC de la seguridad.

---

## Tipos de actores (quien ataca)

```
Script Kiddie    — usa herramientas de otros, sin entender el fondo
Hacker etico     — tiene permiso, busca vulnerabilidades para ayudar (pentester)
Cracker          — rompe sistemas con intencion maliciosa
Insider threat   — empleado descontento que filtra datos internos
APT              — grupo organizado, estado-nacion, campanas largas (meses/anos)
Hacktivista      — por ideologia (Anonymous)
Cripto-criminal  — ransomware, extorsion
```

---

## Tipos de ataques (clasificacion)

### Por objetivo
- **Confidencialidad:** phishing, keylogger, sniffing
- **Integridad:** SQL injection, man-in-the-middle, defacement
- **Disponibilidad:** DDoS, ransomware

### Por metodo
| Ataque | Como funciona |
|--------|---------------|
| Phishing | Email falso que parece real, roba credenciales |
| Malware | Software malicioso: virus, troyano, worm, ransomware, spyware |
| SQL Injection | Insertar codigo SQL en formularios para robar/modificar BD |
| XSS | Inyectar JavaScript en paginas web |
| MITM | Interceptar comunicacion entre dos partes |
| DDoS | Saturar un servidor con trafico falso |
| Brute Force | Probar millones de contrasenas hasta adivinar |
| Social Engineering | Manipular a personas para que entreguen acceso |

---

## Tipos de malware

```
Virus          — se adjunta a archivos ejecutables, se propaga al abrir
Worm           — se propaga solo por la red sin interaccion del usuario
Troyano        — parece software legitimo pero tiene puerta trasera
Ransomware     — cifra archivos y pide rescate (WannaCry 2017, Lockbit 2022)
Spyware        — espiar actividad del usuario sin que lo sepa
Adware         — muestra publicidad no deseada
Rootkit        — se oculta en el sistema operativo a nivel kernel
Keylogger      — registra todo lo que escribes (contrasenas, emails)
Botnet         — red de computadoras infectadas controladas remotamente
```

---

## Casos reales para reflexionar

### WannaCry (2017)
- Ransomware que uso una vulnerabilidad de Windows (EternalBlue, robada de la NSA)
- Afecto 200,000 sistemas en 150 paises
- El NHS (salud publica de UK) perdio acceso a hospitales completos
- **Leccion:** parchear sistemas es critico

### SolarWinds (2020)
- APT ruso (Cozy Bear) inserto backdoor en una actualizacion de software legitimo
- Afecto a agencias del gobierno de EE.UU. durante meses sin que lo notaran
- **Leccion:** los ataques a la cadena de suministro son los mas peligrosos

### Log4Shell (2021)
- Vulnerabilidad en una libreria Java usada en miles de productos
- CVSS 10.0 — la maxima puntuacion posible
- **Leccion:** las dependencias de tu codigo son parte de tu superficie de ataque

---

## Conceptos clave que vas a escuchar siempre

| Termino | Definicion simple |
|---------|------------------|
| CVE | Identificador unico de vulnerabilidad (CVE-2021-44228 = Log4Shell) |
| CVSS | Puntuacion de gravedad 0-10 |
| Zero-day | Vulnerabilidad desconocida para el fabricante, sin parche |
| Exploit | Codigo que aprovecha una vulnerabilidad |
| Payload | El codigo malicioso que se ejecuta despues del exploit |
| IOC | Indicador de compromiso — evidencia de un ataque |
| Threat Intelligence | Informacion sobre actores y tecnicas conocidas |
| Attack Surface | Todo lo que puede ser atacado en un sistema |
| Hardening | Reducir la superficie de ataque configurando bien el sistema |

---

## Para explorar esta semana

- Busca en Google: "have I been pwned" y revisa tu email
- Lee el resumen del ataque de SolarWinds en Wikipedia
- Mira el documental "Zero Days" (2016) si tienes tiempo
