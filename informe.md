# Informe Técnico de Hardening de PostgreSQL

**Estudiante:** Irwin Gabriel Martinez Prado  
**Materia:** Gestión de Seguridad y Desempeño de Bases de Datos  
**Práctica:** LAB-04 — Hardening y configuración segura de PostgreSQL  

---

## Cuestionario Técnico de Evaluación

### 1. ¿Cuál era la principal superficie de ataque?
La exposición global del servicio en la red a través del parámetro `listen_addresses = '*'` combinado con reglas de autenticación permisivas en `pg_hba.conf`.

### 2. ¿Qué configuración representaba el mayor riesgo?
Permitir conexiones remotas desde `0.0.0.0/0` con métodos de autenticación débiles o el uso de la cuenta `postgres` (SUPERUSER) para las conexiones de las aplicaciones.

### 3. ¿Qué cambio produjo la mayor reducción de exposición?
Restringir `listen_addresses` a la interfaz local/privada y ajustar `pg_hba.conf` para aceptar únicamente el segmento de red autorizado mediante `scram-sha-256`.

### 4. ¿Qué diferencia existe entre firewall y `pg_hba.conf`?
El firewall opera a nivel de red (Capa 3/4) filtrando paquetes por IP/puerto antes de llegar al servicio; `pg_hba.conf` opera a nivel de aplicación (PostgreSQL) validando la base de datos, el usuario y la regla de autenticación una vez establecida la conexión de red.

### 5. ¿Qué diferencia existe entre autenticación y autorización?
La autenticación confirma **quién es** el usuario (verificación de identidad/contraseña); la autorización determina **qué puede hacer** ese usuario autenticado (permisos `SELECT`, `INSERT`, `UPDATE`).

### 6. ¿Por qué una cuenta de aplicación no debe ser SUPERUSER?
Porque si la aplicación sufre una vulnerabilidad (como inyección SQL), el atacante obtendría control total sobre la base de datos, el sistema de archivos subyacente y las demás bases de datos de la instancia.

### 7. ¿Por qué cambiar el puerto de PostgreSQL no constituye hardening suficiente?
Porque cambiar el puerto 5432 por otro solo implementa "seguridad por oscuridad". Un escaneo de puertos automatizado descubrirá el nuevo puerto en segundos si no hay un firewall o autenticación adecuada.

### 8. ¿Por qué `listen_addresses='*'` puede ser innecesario?
Porque la gran mayoría de las aplicaciones conviven en la misma red privada o en el mismo servidor local (*localhost*) que la base de datos, por lo que escuchar en interfaces públicas expone el servicio a ataques externos innecesariamente.

### 9. ¿Qué papel tiene el sistema operativo en la seguridad de PostgreSQL?
El sistema operativo administra el acceso físico a los archivos (`postgresql.conf`, `pg_hba.conf`, archivos de datos). Si los permisos del SO son débiles, un usuario local puede leer las configuraciones, alterar los archivos de datos o extraer credenciales sin pasar por los controles de PostgreSQL.

### 10. ¿Qué controles deberían revisarse periódicamente?
Reglas de `pg_hba.conf`, cuentas inactivas de usuarios, permisos de roles, logs de auditoría de conexiones fallidas y parches de actualización del motor.

---

## Sección de Reflexión Individual

**¿Qué cambiarías primero si recibieras la responsabilidad de asegurar un servidor PostgreSQL que ya se encuentra funcionando en producción?**

Priorizaría la **restricción del acceso por red y las reglas en `pg_hba.conf`** (cerrar accesos globales `0.0.0.0/0` y cambiar autenticaciones a `scram-sha-256`).

**Justificación:**
Un servidor expuesto a toda la red con reglas permisivas es vulnerable a ataques de fuerza bruta y explotación remota inmediata. Corregir las reglas de red y autenticación reduce drásticamente el riesgo de intrusión externa con un impacto mínimo en la disponibilidad de los servicios que ya están autorizados a conectarse. Posterior a esto, procedería con la segregación de roles y la revisión de permisos a nivel del sistema operativo.