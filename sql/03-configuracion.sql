-- ============================================================
-- LAB-04: Hardening y configuración segura de PostgreSQL
-- Script: 03-configuracion.sql
-- Estudiante: Irwin Gabriel Martinez Prado
-- Descripción: Inspección de reglas de pg_hba.conf, parámetros
--              de conexión y timeouts de sesión.
-- ============================================================

-- 1. Inspección de las reglas de pg_hba.conf desde SQL
SELECT 
    line_number,
    type, 
    database, 
    user_name, 
    address, 
    auth_method 
FROM pg_hba_file_rules
ORDER BY line_number;

-- 2. Verificación del método de encriptación de contraseñas
SHOW password_encryption;

-- 3. Verificación de parámetros de conexión y límites de recursos
SHOW max_connections;
SHOW superuser_reserved_connections;
SHOW statement_timeout;
SHOW idle_in_transaction_session_timeout;