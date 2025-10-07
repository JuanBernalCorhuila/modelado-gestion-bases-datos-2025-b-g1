-- Si existe la base de datos con anterioridad
DROP DATABASE IF EXISTS Hospital_Care;

-- Crear base de datos
CREATE DATABASE Hospital_Care;

-- Usar la base de datos
USE Hospital_Care;

-- Crear tabla Paciente
CREATE TABLE paciente(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) NOT NULL, 
    correo VARCHAR(100) NOT NULL UNIQUE,
    eliminado BOOLEAN DEFAULT FALSE
);

-- Crear tabla Médico
CREATE TABLE medico(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(20) NOT NULL,
	apellido VARCHAR(20) NOT NULL,
	especialidad VARCHAR(20) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- crear tabla Citas
CREATE TABLE cita(
	id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado ENUM('Cancelada', 'Activa', 'Completada') NOT NULL DEFAULT 'Activa',
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    FOREIGN KEY(id_paciente) REFERENCES paciente(id),
    FOREIGN KEY(id_medico) REFERENCES medico(id)
);

-- crear tabla Tratamiento
CREATE TABLE tratamiento(
	id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT NOT NULL,
    costo DECIMAL(10,2) NOT NULL CHECK (costo>0),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_paciente)  REFERENCES paciente(id),
    CHECK (fecha_inicio < fecha_fin)
);

-- Crear tablla de historial clínico
CREATE TABLE historial(
	id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    notas TEXT NOT NULL,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    FOREIGN KEY(id_paciente) REFERENCES paciente(id),
    FOREIGN KEY(id_medico) REFERENCES medico(id)
);
-- crear tabla para auditoría
CREATE TABLE auditoria(
	id INT PRIMARY KEY AUTO_INCREMENT,
    tabla_afectada VARCHAR(50),
    operacion VARCHAR(20),
    usuario VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

