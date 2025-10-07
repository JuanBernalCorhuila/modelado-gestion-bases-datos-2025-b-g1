-- Insertar datos en las tablas
INSERT INTO paciente(nombre, apellido, telefono, correo)VALUES
('Juan', 'Valdez', '3134256768', 'valdez@gmail.com'),
('Ana', 'Cortes', '3125678392', 'anita@gmail.com'),
('Paola', 'Puentes', '3143578567', 'pao@gmail.com');

 INSERT INTO medico(nombre, apellido, especialidad)VALUES
('Pablo', 'Castro', 'Neurocirujano'),
('Maria', 'Lopez', 'Radiologo'),
('Ester', 'Bonilla', 'Inmunólogo');

 INSERT INTO cita(fecha, hora, estado, id_paciente, id_medico)VALUES
('2023-08-12', '12:10:56', 'Completada', 3, 2),
('2025-09-22', '19:04:26', 'Activa', 2, 3),
('2025-09-23', '22:04:16', 'Activa', 3, 2);

 INSERT INTO tratamiento(descripcion, costo, fecha_inicio, fecha_fin, id_paciente)VALUES
('Radiografía de tendón roto', 8000000, '2023-08-12', '2023-08-14', 3),
('Toma de antibioticos y evaluaciones de progreso', 200000, '2025-09-22', '2025-10-5', 2),
('Operación para corregir fractura', 6500000, '2025-07-23', '2025-10-4', 3);

INSERT INTO historial(fecha, notas, id_paciente, id_medico)VALUES
('2023-08-12', 'Paciente con tendón de la rodilla roto', 3, 2),
('2021-02-02', 'Paciente con sistema inmunológico débil', 2, 3),
('2025-09-23', 'Paciente con fractura', 3, 2);

-- Admin (privilegio total)
INSERT INTO paciente(nombre, apellido, telefono, correo) VALUES 
('Pedro','Rodriguez','31012213888','pedro@gmail.com');

-- Actualizar paciente
UPDATE paciente SET telefono='3142152635' WHERE id=1;
SELECT * FROM paciente;

-- Eliminar paciente
DELETE FROM paciente WHERE id=1;

-- Medico 
-- Consultar pacientes y citas
SELECT * FROM paciente;
SELECT * FROM cita;

-- Insertar tratamiento
INSERT INTO tratamiento(descripcion,costo,fecha_inicio,fecha_fin,id_paciente)
VALUES ('Tratamiento de hombro',180.00,'2025-10-12','2025-10-22',2);

-- Insertar historial 
INSERT INTO historial(fecha,notas,id_paciente,id_medico)
VALUES ('2025-10-12','Revisión inmunológica',2,3);

-- No puede eliminar paciente
DELETE FROM paciente WHERE id=1;

-- Recepcionista
-- Insertar cita
INSERT INTO cita(fecha,hora,estado,id_paciente,id_medico)
VALUES ('2025-10-13','09:30:00','Activa',2,1);

-- Actualizar cita
UPDATE cita SET estado='Cancelada' WHERE id=1;
SELECT * FROM cita;
SELECT * FROM paciente;

-- No puede actualizar ni eliminar paciente
UPDATE paciente SET correo = 'benitez@gmail.com' WHERE id = 3;
DELETE FROM paciente WHERE id=1;

-- Auditor
-- Consultar más no modificar
SELECT * FROM paciente;
SELECT * FROM medico;
SELECT * FROM cita;
SELECT * FROM tratamiento;
SELECT * FROM historial;
SELECT * FROM auditoria;

-- No permite modificar
INSERT INTO paciente(nombre, apellido, telefono, correo)
VALUES ('Camilo','Audor','3124152512','audor@gmail.com');

-- No se puede eliminar un paciente con citas activas
SELECT * FROM cita;
DELETE FROM paciente WHERE id = 2;

-- Verificar Triggers
SELECT * FROM auditoria;
