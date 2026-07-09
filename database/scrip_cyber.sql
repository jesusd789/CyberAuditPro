	
DROP DATABASE IF EXISTS cyberaudit_db;
CREATE DATABASE cyberaudit_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cyberaudit_db;


CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
) ENGINE=InnoDB;


CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL, -- Aquí se guardaría el hash de la contraseña
    id_rol INT NOT NULL,
    CONSTRAINT fk_usuarios_roles FOREIGN KEY (id_rol) 
        REFERENCES roles(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE dispositivos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_host VARCHAR(100) NOT NULL UNIQUE,
    direccion_ip VARCHAR(45) NOT NULL,
    sistema_operativo VARCHAR(50) NOT NULL,
    dependencia_area VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE amenazas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_dispositivo INT NOT NULL,
    archivo VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    nivel_riesgo ENUM('critical', 'high', 'medium', 'low') NOT NULL,
    tamano VARCHAR(20) NOT NULL,
    fecha_deteccion DATETIME NOT NULL,
    estado VARCHAR(30) DEFAULT 'Cuarentena',
    CONSTRAINT chk_estado CHECK (estado IN ('Cuarentena', 'Restaurado', 'Eliminado')),
    CONSTRAINT fk_amenazas_dispositivos FOREIGN KEY (id_dispositivo) 
        REFERENCES dispositivos(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE historial_acciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_amenaza INT NOT NULL,
    id_usuario INT NOT NULL,
    accion_realizada VARCHAR(100) NOT NULL, -- Ej: 'Cambio de estado a Restaurado'
    fecha_accion DATETIME DEFAULT CURRENT_TIMESTAMP,
    justificacion TEXT,
    CONSTRAINT fk_historial_amenazas FOREIGN KEY (id_amenaza) 
        REFERENCES amenazas(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_historial_usuarios FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

SHOW TABLES;


INSERT INTO roles (nombre, descripcion) VALUES 
('Administrador', 'Acceso total al sistema de seguridad y gestión de usuarios'),
('Auditor', 'Capacidad de revisar amenazas y generar reportes de cumplimiento'),
('Analista TI', 'Encargado de contener amenazas y operar las acciones de aislamiento');


INSERT INTO usuarios (nombre, correo, contrasena, id_rol) VALUES 
('Carlos Mendoza', 'carlos.auditor@cyberaudit.com', 'hash_secure_password_1', 2),
('Ana Gómez', 'ana.admin@cyberaudit.com', 'hash_secure_password_2', 1);


INSERT INTO dispositivos (nombre_host, direccion_ip, sistema_operativo, dependencia_area) VALUES 
('SRV-WEB-PROD', '192.168.10.5', 'Ubuntu Server 22.04', 'Producción / Desarrollo'),
('LAP-FINANZAS01', '192.168.20.45', 'Windows 11 Pro', 'Contabilidad y Finanzas'),
('SRV-BD-BACKUP', '192.168.10.12', 'Red Hat Enterprise', 'Infraestructura TI');


INSERT INTO amenazas (id_dispositivo, archivo, tipo, nivel_riesgo, tamano, fecha_deteccion, estado) VALUES 
(1, '/tmp/x11.sh', 'Backdoor', 'critical', '14 KB', '2026-05-18 01:42:00', 'Cuarentena'),
(2, '/downloads/crack_v2.exe', 'Ransomware', 'critical', '2.1 MB', '2026-05-17 18:15:00', 'Cuarentena'),
(1, '/usr/share/libssl.so.1', 'Trojan', 'high', '680 KB', '2026-05-17 11:03:00', 'Cuarentena'),
(3, '/tmp/.hidden_miner', 'Cryptominer', 'high', '1.3 MB', '2026-05-15 09:11:00', 'Cuarentena');


UPDATE amenazas SET estado = 'Restaurado' WHERE id = 1;


INSERT INTO historial_acciones (id_amenaza, id_usuario, accion_realizada, justificacion) VALUES 
(1, 1, 'Cambio de estado: Cuarentena -> Restaurado', 'Falso positivo verificado por el analista. El script corresponde a una tarea programada legítima de X11.');


SELECT 
    A.id AS id_amenaza,
    D.nombre_host AS dispositivo,
    D.direccion_ip,
    A.archivo,
    A.tipo AS tipo_malware,
    A.nivel_riesgo,
    A.estado
FROM amenazas A
INNER JOIN dispositivos D ON A.id_dispositivo = D.id;


SELECT 
    H.fecha_accion,
    U.nombre AS usuario_operador,
    R.nombre AS rol_usuario,
    A.archivo AS archivo_afectado,
    H.accion_realizada,
    H.justificacion
FROM historial_acciones H
INNER JOIN usuarios U ON H.id_usuario = U.id
INNER JOIN roles R ON U.id_rol = R.id
INNER JOIN amenazas A ON H.id_amenaza = A.id;