# LAB-04 — Hardening y Configuración Segura de PostgreSQL

**Estudiante:** Irwin Gabriel Martinez Prado  
**Materia:** Gestión de Seguridad y Desempeño de Bases de Datos  
**Unidad:** II. Seguridad, privacidad y control de acceso  
**Tema:** 2.6 Hardening de bases de datos  
**Motor:** PostgreSQL 16  

---

## 1. Objetivo
Aplicar un proceso integral de hardening sobre un servidor PostgreSQL 16 para reducir la superficie de ataque, restringir accesos remotos no autorizados, asegurar las configuraciones de red, implementar autenticación fuerte (`scram-sha-256`) y segregar roles siguiendo el principio de mínimo privilegio.

---

## 2. Entorno de Trabajo
* **Sistema Operativo:** Windows 10 / Linux (Entorno de Laboratorio Aislado)
* **Motor de Base de Datos:** PostgreSQL 16
* **Herramientas:** `psql` CLI, Visual Studio Code

---

## 3. Estructura del Repositorio

```text
lab-04-hardening/
├── README.md
├── informe.md
├── sql/
│   ├── 01-inspeccion.sql
│   ├── 02-roles.sql
│   ├── 03-configuracion.sql
│   └── 04-verificacion.sql
├── configuracion/
│   ├── baseline.md
│   └── cambios.md
└── evidencias/
    ├── 01-superficie-ataque.png
    ├── 02-listen-addresses.png
    ├── 03-pg-hba.png
    ├── 04-roles.png
    ├── 05-tls.png
    └── 06-verificacion.png