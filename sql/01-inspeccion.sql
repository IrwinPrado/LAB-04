-- ============================================================
-- LAB-04: Hardening y configuración segura de PostgreSQL
-- Script: 01-inspeccion.sql
-- Estudiante: Irwin Gabriel Martinez Prado
-- Descripción: Inspección inicial de la superficie de ataque,
--              rutas de configuración, listen_addresses y extensiones.
-- ============================================================

-- 1. Información de versión y parámetros principales de exposición
SELECT version();
SHOW port;
SHOW listen_addresses;
SHOW ssl;
SHOW password_encryption;

-- 2. Rutas físicas de archivos de configuración y datos
SHOW config_file;
SHOW hba_file;
SHOW ident_file;
SHOW data_directory;
SHOW log_directory;

-- 3. Monitoreo de conexiones activas
SELECT
    pid,
    usename,
    datname,
    client_addr,
    client_port,
    application_name
FROM pg_stat_activity;

-- 4. Extensiónes instaladas
SELECT extname, extversion FROM pg_extension ORDER BY extname;

-- 5. Estado de cifrado SSL/TLS de la sesión actual
SELECT
    pid,
    usename,
    client_addr,
    ssl,
    version,
    cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();