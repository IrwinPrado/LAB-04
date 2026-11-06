-- ============================================================
-- LAB-04: Hardening y configuración segura de PostgreSQL
-- Script: 04-verificacion.sql
-- Estudiante: Irwin Gabriel Martinez Prado
-- Descripción: Verificación final del estado de seguridad, TLS y roles.
-- ============================================================

-- 1. Verificación de parámetros defensivos activos
SELECT name, setting, unit, context 
FROM pg_settings 
WHERE name IN (
    'listen_addresses', 
    'port', 
    'ssl', 
    'password_encryption', 
    'max_connections',
    'idle_in_transaction_session_timeout'
);

-- 2. Verificación de conexiones seguras (TLS)
SELECT pid, usename, client_addr, ssl, version, cipher 
FROM pg_stat_ssl;