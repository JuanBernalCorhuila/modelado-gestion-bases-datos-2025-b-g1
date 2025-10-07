-- Auditoría para insertar, actualizar y eliminar pacientes
DELIMITER //

CREATE TRIGGER tr_insertar_paciente
AFTER INSERT ON paciente
FOR EACH ROW
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES ('paciente', 'INSERT', CURRENT_USER());
END;
//

CREATE TRIGGER tr_actualizar_paciente
AFTER UPDATE ON paciente
FOR EACH ROW
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES ('paciente', 'UPDATE', CURRENT_USER());
END;
//

CREATE TRIGGER tr_eliminar_paciente
AFTER DELETE ON paciente
FOR EACH ROW
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES ('paciente', 'DELETE', CURRENT_USER());
END;
//

DELIMITER ;

-- Auditoría para insertar, actualizar y eliminar citas
DELIMITER //

CREATE TRIGGER tr_insertar_cita
AFTER INSERT ON cita
FOR EACH ROW
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES ('cita', 'INSERT', CURRENT_USER());
END;
//

CREATE TRIGGER tr_actualizar_cita
AFTER UPDATE ON cita
FOR EACH ROW
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES ('cita', 'UPDATE', CURRENT_USER());
END;
//

CREATE TRIGGER tr_eliminar_cita
AFTER DELETE ON cita
FOR EACH ROW
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES ('cita', 'DELETE', CURRENT_USER());
END;
//

DELIMITER ;

-- Auditoría para insertar, actualizar y eliminar tratamiento
DELIMITER //

CREATE TRIGGER tr_insertar_tratamiento
AFTER INSERT ON tratamiento
FOR EACH ROW
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES ('tratamiento', 'INSERT', CURRENT_USER());
END;
//

CREATE TRIGGER tr_actualizar_tratamiento
AFTER UPDATE ON tratamiento
FOR EACH ROW
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES ('tratamiento', 'UPDATE', CURRENT_USER());
END;
//

CREATE TRIGGER tr_eliminar_tratamiento
AFTER DELETE ON tratamiento
FOR EACH ROW
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES ('tratamiento', 'DELETE', CURRENT_USER());
END;
//

DELIMITER ;

-- Marcar eliminado en lugar de borrar 
DELIMITER //

CREATE TRIGGER tr_softdelete_paciente
AFTER UPDATE ON paciente
FOR EACH ROW
BEGIN
    IF OLD.eliminado = FALSE AND NEW.eliminado = TRUE THEN
        INSERT INTO auditoria(tabla_afectada, operacion, usuario)
        VALUES ('paciente', 'SOFT DELETE', CURRENT_USER());
    END IF;
END;
//

DELIMITER ;

-- Validar que no se borren pacientes con citas pendientes
DELIMITER //

CREATE TRIGGER tr_validar_eliminacion_paciente
BEFORE DELETE ON paciente
FOR EACH ROW
BEGIN
    -- Validación de negocio: no borrar pacientes con citas pendientes
    IF EXISTS (SELECT 1 FROM cita WHERE id_paciente = OLD.id AND estado = 'Activa') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'VALIDACIÓN: No se puede eliminar un paciente con citas activas';
    END IF;
END;
//

DELIMITER ;