# Stack del Curso 3 — Ciberseguridad

> Todo lo que necesitas instalar antes de empezar.

---

## Lo esencial (semanas 1-3)

| Herramienta | Para que | Instalacion |
|------------|---------|-------------|
| Wireshark | Capturar y analizar trafico de red | Ver `01_Wireshark.md` |
| nmap | Escanear puertos y detectar servicios | `sudo apt install nmap` |
| Docker | Correr WebGoat, Wazuh | Ver Curso 2 instalacion Docker |

## Herramientas web (semanas 4-7)

| Herramienta | Para que | Instalacion |
|------------|---------|-------------|
| Burp Suite Community | Interceptar y modificar HTTP | Ver `02_Burp_Suite.md` |
| WebGoat | App web vulnerable para practicar | `docker run -p 8081:8080 webgoat/webgoat` |

## CTF y seguridad avanzada (semanas 6-8)

| Herramienta | Para que | Instalacion |
|------------|---------|-------------|
| John the Ripper | Crackear hashes | `sudo apt install john` |
| Kali Linux (opcional) | Suite completa de herramientas | Ver `03_Kali_Linux.md` |
| Wazuh | SIEM open source | Ver `04_Wazuh.md` |

## Python — librerias de seguridad

```bash
pip install cryptography bcrypt PyJWT python-dotenv pip-audit
```

---

## Cuentas que necesitas crear (gratis)

- [ ] TryHackMe — `tryhackme.com`
- [ ] PicoCTF — `picoctf.org`
- [ ] HaveIBeenPwned — solo para consultar, no requiere cuenta
