# Registro de Cambios y Comparativa antes/después del Hardening

**Estudiante:** Irwin Gabriel Martinez Prado  
**Materia:** Gestión de Seguridad y Desempeño de Bases de Datos  
**Práctica:** LAB-04 — Hardening y configuración segura de PostgreSQL  

---

## Tabla Comparativa de Hardening

| Control / Parámetro | Estado Inicial (Antes) | Estado Modificado (Después) | Justificación Técnica del Cambio |
| :--- | :--- | :--- | :--- |
| **`listen_addresses`** | `*` (Escucha en todas las interfaces) | `localhost` / IP Privada | Reduce la superficie de ataque bloqueando la exposición a redes no confiables. |
| **`pg_hba.conf`** | Permisivo (`0.0.0.0/0` con método `trust` o `md5`) | Reglas específicas por IP / Subred con `scram-sha-256` | Garantiza autenticación fuerte y restringe el acceso remoto solo a hosts autorizados. |
| **Autenticación** | `md5` / `trust` | `scram-sha-256` | Evita ataques de relevo de hash y descifrado por fuerza bruta en contraseñas. |
| **Cuentas de Aplicación** | Uso directo de `postgres` (SUPERUSER) | Cuenta `app_user` dedicada (Sin superusuario) | Aplica el principio de mínimo privilegio; si la app se compromete, el motor sigue a salvo. |
| **Cuentas de Consulta** | Sin separación de roles | Cuenta `consulta_user` dedicada | Otorga únicamente privilegios de lectura (`SELECT`), impidiendo modificaciones accidentales o maliciosas. |
| **Tiempo de Inactividad** | `idle_in_transaction_session_timeout = 0` (Desactivado) | `60000` (60 segundos) | Libera conexiones bloqueadas por transacciones abandonadas, preservando la disponibilidad. |
| **Permisos en SO** | Permisos laxos en archivos de configuración | `0600` en archivos y `0700` en directorio `data` | Evita que usuarios locales no privilegiados del SO lean credenciales o configuraciones. |
| **Protocolo TLS** | SSL Opcional / Inactivo | `ssl = on` / `ssl_min_protocol_version = TLSv1.2` | Previene ataques de interceptación y modificación de tráfico en tránsito (Man-in-the-Middle). |