# CyberAudit Pro — Módulo CRUD de Amenazas (GA7-220501096-AA2-EV02)

Proyecto Java EE 8 + Maven + Tomcat + MySQL. CRUD completo sobre la tabla
`amenazas`, relacionada con `dispositivos` mediante llave foránea.

## Antes de ejecutar

1. Ejecuta `database/scrip_cyber.sql` en tu MySQL (Workbench / phpMyAdmin / consola).
2. Abre `src/main/java/config/Conexion.java` y coloca tu usuario y contraseña reales de MySQL.
3. Importa la carpeta como proyecto Maven en IntelliJ IDEA y espera a que descargue las dependencias.
4. Configura una run configuration de Tomcat apuntando a este war.
5. Ejecuta y entra a: `http://localhost:8080/CyberAuditPro/Controlador?accion=listar`

Ver la conversación con Claude para la explicación completa paso a paso.
