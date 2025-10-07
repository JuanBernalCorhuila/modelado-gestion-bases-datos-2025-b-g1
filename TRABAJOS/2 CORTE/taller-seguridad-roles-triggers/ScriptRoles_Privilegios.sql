-- Creación de usuarios que representan los roles del sistema
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'abcdadmin';
CREATE USER IF NOT EXISTS 'medico'@'localhost' IDENTIFIED BY 'abcdmedico';
CREATE USER IF NOT EXISTS 'recepcionista'@'localhost' IDENTIFIED BY 'abcdrecepcionista';
CREATE USER IF NOT EXISTS 'auditor'@'localhost' IDENTIFIED BY 'abcdauditor';

-- Asignar privilegios según el rol
GRANT ALL PRIVILEGES ON Hospital_Care.* TO 'admin'@'localhost';

GRANT SELECT,INSERT,UPDATE ON Hospital_Care.paciente TO 'medico'@'localhost';
GRANT SELECT,INSERT,UPDATE ON Hospital_Care.tratamiento TO 'medico'@'localhost';
GRANT SELECT,INSERT,UPDATE ON Hospital_Care.historial TO 'medico'@'localhost';
GRANT SELECT ON Hospital_Care.cita TO 'medico'@'localhost';

GRANT SELECT,INSERT,UPDATE ON Hospital_Care.cita TO 'recepcionista'@'localhost';
GRANT SELECT ON Hospital_Care.paciente TO 'recepcionista'@'localhost';

GRANT SELECT ON Hospital_Care.* TO 'auditor'@'localhost';

-- Aplicar los cambios
FLUSH PRIVILEGES;

-- Usar el revoke por si se quiere quitar un permiso
-- Ejemplo para que el medico no pueda actualizar pacientes
REVOKE UPDATE ON Hospital_Care FROM 'medico'@'localhost';








