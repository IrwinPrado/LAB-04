# Línea Base de Seguridad (Baseline) — PostgreSQL 16

**Estudiante:** Irwin Gabriel Martinez Prado  
**Materia:** Gestión de Seguridad y Desempeño de Bases de Datos  
**Práctica:** LAB-04 — Hardening y configuración segura de PostgreSQL  

---

## 1. Red y Control de Acceso Perimetral
* **Interfaces de Escucha:** `listen_addresses = '127.0.0.1'` (o IP del segmento privado autorizado). Se prohíbe la escucha global `*` a menos que esté respaldada por firewall.
* **Puerto de Red:** Puerto por defecto `5432/TCP` documentado y monitoreado mediante reglas de firewall restringidas al segmento autorizado.
* **Firewall Externo:** Regla por defecto `DROP/REJECT` para cualquier origen no perteneciente al segmento de red de la aplicación o administración.

---

## 2. Autenticación y Control Host-Based (`pg_hba.conf`)
* **Mecanismo de Contraseñas:** `password_encryption = scram-sha-256`.
* **Reglas de Acceso Remoto:**
  * Prohibición estricta de rangos universales (`0.0.0.0/0` o `::/0`).
  * Conexiones obligatorias con autenticación `scram-sha-256` e IPs específicas (`10.10.10.0/24`).
  * Sin accesos remotos directos para el superusuario `postgres`.

---

## 3. Segregación de Roles y Autorización
* **Superusuarios:** Uso exclusivo de la cuenta `postgres` para tareas de mantenimiento del motor.
* **Cuentas de Aplicación:** Cuentas con privilegio `LOGIN` sin permisos de creación de bases de datos (`NOCREATEDB`) ni roles (`NOCREATEROLE`).
* **Cuentas de Consulta:** Roles de solo lectura asignados explícitamente mediante esquemas o vistas.

---

## 4. Parámetros de Sesión y Disponibilidad
* `max_connections = 100` (ajustado a la capacidad del servidor).
* `superuser_reserved_connections = 3` (garantiza acceso administrativo en emergencias).
* `idle_in_transaction_session_timeout = 60000` (60 segundos para evitar acaparamiento de bloqueos).
* `statement_timeout = 30000` (30 segundos para mitigar consultas desmedidas).

---

## 5. Permisos del Sistema Operativo
* **Propietario de Archivos:** Usuario `postgres:postgres` del sistema operativo.
* **Permisos de Directorio de Datos:** `0700` (`drwx------`) en `/var/lib/postgresql/data`.
* **Permisos de Archivos de Configuración:** `0600` (`-rw-------`) en `postgresql.conf` y `pg_hba.conf`.

---

## 6. Cifrado y Comunicaciones (TLS)
* `ssl = on` para cifrar todo el tráfico en tránsito.
* `ssl_min_protocol_version = 'TLSv1.2'` para bloquear protocolos obsoletos (TLS 1.0, TLS 1.1, SSLv3).