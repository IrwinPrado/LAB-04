-- ============================================================
-- LAB-04: Hardening y configuración segura de PostgreSQL
-- Script: 02-roles.sql
-- Estudiante: Irwin Gabriel Martinez Prado
-- Descripción: Inspección de roles, superusuarios y segregación
--              de cuentas (DBA, App, Consulta).
-- ============================================================

-- 1. Inspección de todos los roles existentes en la instancia
SELECT 
    rolname, 
    rolsuper, 
    rolinherit, 
    rolcreaterole, 
    rolcreatedb, 
    rolcanlogin
FROM pg_roles 
ORDER BY rolname;

-- 2. Creación conceptual de cuentas segregadas para Mínimo Privilegio (Ejemplo de Hardening)
DROP ROLE IF EXISTS app_user;
DROP ROLE IF EXISTS consulta_user;

-- Cuenta de Aplicación (Solo Login y acceso controlado a tablas operativas)
CREATE ROLE app_user WITH LOGIN PASSWORD 'AppPasswordSecure2026!';

-- Cuenta de Consulta / Lectura (Solo lectura para auditoría o reportes)
CREATE ROLE consulta_user WITH LOGIN PASSWORD 'ReadonlySecure2026!';

-- Verificación final de los roles creados y sus privilegios
SELECT 
    rolname, 
    rolsuper, 
    rolcreaterole, 
    rolcreatedb, 
    rolcanlogin
FROM pg_roles 
WHERE rolname IN ('app_user', 'consulta_user');