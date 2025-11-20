-- Drop database if exists
DROP DATABASE IF EXISTS park_amusement;

-- Create Database 
CREATE DATABASE park_amusement;

-- Use the database
USE park_amusement;

-- Module Security 🔐

-- table: person
CREATE TABLE person (
    id INT PRIMARY KEY AUTO_INCREMENT,
    document_type VARCHAR(20) NOT NULL,
    document_number VARCHAR(30) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    address VARCHAR(150)
);

-- table: user_account
CREATE TABLE user_account (
    id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (person_id) REFERENCES person(id)
);

-- table: role
CREATE TABLE role (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(150)
);

-- table: user_role
CREATE TABLE user_role (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_account_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (user_account_id) REFERENCES user_account(id),
    FOREIGN KEY (role_id) REFERENCES role(id)
);

-- table: module
CREATE TABLE module (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(150)
);

-- table: module_role
CREATE TABLE module_role (
    id INT PRIMARY KEY AUTO_INCREMENT,
    module_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (module_id) REFERENCES module(id),
    FOREIGN KEY (role_id) REFERENCES role(id)
);

-- table: view
CREATE TABLE view (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(150)
);

-- table: view_module
CREATE TABLE view_module (
    id INT PRIMARY KEY AUTO_INCREMENT,
    view_id INT NOT NULL,
    module_id INT NOT NULL,
    FOREIGN KEY (view_id) REFERENCES view(id),
    FOREIGN KEY (module_id) REFERENCES module(id)
);

-- 🏞️ MODULE: PARK

-- table: zone
CREATE TABLE zone (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL CHECK (capacity >= 0),
    description VARCHAR(255)
);

-- table: attraction
CREATE TABLE attraction (
    id INT PRIMARY KEY AUTO_INCREMENT,
    zone_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    min_height INT CHECK (min_height >= 0),
    max_capacity INT CHECK (max_capacity >= 0),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (zone_id) REFERENCES zone(id)
);

-- table: employee
CREATE TABLE employee (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(120),
    hire_date DATE NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    role ENUM('operator','maintenance','security','cleaning','admin','seller') NOT NULL,
    zone_id INT NOT NULL,
    attraction_id INT NOT NULL,
    FOREIGN KEY (zone_id) REFERENCES zone(id),
    FOREIGN KEY (attraction_id) REFERENCES attraction(id)
);

-- table: visitor
CREATE TABLE visitor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    document_type VARCHAR(20) NOT NULL,
    document_number VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(120),
    phone VARCHAR(20),
    age INT NOT NULL CHECK (age >= 0)
);

-- table: ticket
CREATE TABLE ticket (
    id INT PRIMARY KEY AUTO_INCREMENT,
    visitor_id INT NOT NULL,
    purchase_date DATETIME NOT NULL,
    ticket_type VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    valid_until DATE NOT NULL,
    FOREIGN KEY (visitor_id) REFERENCES visitor(id)
);

-- table: ticket_attraction
CREATE TABLE ticket_attraction (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT NOT NULL,
    attraction_id INT NOT NULL,
    access_time DATETIME NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES ticket(id),
    FOREIGN KEY (attraction_id) REFERENCES attraction(id)
);

-- table: product
CREATE TABLE product (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    category VARCHAR(100) NOT NULL
);

-- table: purchase
CREATE TABLE purchase (
    id INT PRIMARY KEY AUTO_INCREMENT,
    visitor_id INT NOT NULL,
    purchase_date DATETIME NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    FOREIGN KEY (visitor_id) REFERENCES visitor(id)
);

-- table: purchase_detail
CREATE TABLE purchase_detail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    FOREIGN KEY (purchase_id) REFERENCES purchase(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- table: maintenance
CREATE TABLE maintenance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    attraction_id INT NOT NULL,
    employee_id INT NOT NULL,
    maintenance_date DATE NOT NULL,
    description VARCHAR(255),
    status ENUM('scheduled','in_progress','completed') NOT NULL,
    FOREIGN KEY (attraction_id) REFERENCES attraction(id),
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

-- Inserción de datos

-- Module Security 🔐
INSERT INTO person (document_type, document_number, first_name, last_name, phone, email, address)VALUES
('CC', '2727721511', 'Mariela', 'Salvador Guitierrez', '32155550101', 'mariela.salvador@hotmail.com', 'Calle 100 #10-20'),
('TI', '1002003002', 'Luna', 'Pérez Salvador', '3166604402', 'lunap.salvador@gmail.com', 'Calle 100 #10-20'),
('CC', '1234567890', 'Carlos', 'Gómez Martínez', '3101116233', 'carlos.gomez@hotmail.com', 'Carrera 15 #45-67'),
('CC', '2345678901', 'Ana', 'Rodríguez López', '3112223344', 'ana.rodriguez@gmail.com', 'Calle 80 #12-34'),
('TI', '3456789012', 'Santiago', 'Hernández Díaz', '1312334455', 'santiago.hernandez@gmail.com', 'Avenida 68 #23-45'),
('CC', '4567890123', 'Laura', 'García Silva', '5313444556', 'laura.garcia@gmail.com', 'Carrera 20 #56-78'),
('CC', '5678901234', 'Diego', 'Martínez Pérez', '73145556677', 'diego.martinez@gmail.com', 'Calle 72 #34-56'),
('TI', '6789012345', 'Valentina', 'López Gómez', '3715667788', 'valentina.lopez@gmail.com', 'Avenida 19 #67-89'),
('CC', '7890123456', 'Andrés', 'Díaz Rodríguez', '31673778899', 'andres.diaz@gmail.com', 'Carrera 25 #78-90'),
('CC', '8901234567', 'Camila', 'Silva Hernández', '3150889900', 'camila.silva@gmail.com', 'Calle 85 #45-67'),
('TI', '9012345678', 'Juan', 'Pérez García', '3185690011', 'juan.perez@hotmail.com', 'Avenida 7 #89-12'),
('CC', '1122334455', 'María', 'Fernández Castro', '6190001122', 'maria.fernandez@hotmail.com', 'Carrera 30 #12-34'),
('CC', '2233445566', 'Pedro', 'Castro Ruiz', '3208112233', 'pedro.castro@hotmail.com', 'Calle 95 #23-45'),
('TI', '3344556677', 'Isabella', 'Ruiz Morales', '3216223344', 'isabella.ruiz@gmail.com', 'Avenida 15 #34-56'),
('CC', '4455667788', 'Javier', 'Morales Ortega', '3223334455', 'javier.morales@hotmail.com', 'Carrera 40 #45-67'),
('CC', '5566778899', 'Carolina', 'Ortega Vargas', '3224445566', 'carolina.ortega@gmail.com', 'Calle 105 #56-78'),
('TI', '6677889900', 'Miguel', 'Vargas Rojas', '3245546677', 'miguel.vargas@hotmail.com', 'Avenida 22 #67-89'),
('CC', '7788990011', 'Daniela', 'Rojas Mendoza', '3253667788', 'daniela.rojas@gmail.com', 'Carrera 50 #78-90'),
('CC', '8899001122', 'Ricardo', 'Mendoza Herrera', '3247778899', 'ricardo.mendoza@gmail.com', 'Calle 115 #89-12'),
('TI', '9900112233', 'Sofía', 'Herrera Peña', '3278889200', 'sofia.herrera@hotmail.com', 'Avenida 30 #12-34');

INSERT INTO user_account (person_id, username, password_hash, status)VALUES
(1 , 'Mariela_salazar', '$2b$10$password0', TRUE),
(2 , 'Luna_perez', '$2b$10$password1', TRUE),
(3, 'carlos_gomez', '$2b$10$password2', TRUE),
(4, 'ana_rodriguez', '$2b$10$password3', FALSE),
(5, 'santiago_hernandez', '$2b$10$password4', TRUE),
(6, 'laura_garcia', '$2b$10$password5', TRUE),
(7, 'diego_martinez', '$2b$10$password6', TRUE),
(8, 'valentina_lopez', '$2b$10$password7', FALSE),
(9, 'andres_diaz', '$2b$10$password8', TRUE),
(10, 'camila_silva', '$2b$10$password9', TRUE),
(11, 'juan_perez', '$2b$10$password10', TRUE),
(12, 'maria_fernandez', '$2b$10$password11', TRUE),
(13, 'pedro_castro', '$2b$10$password12', FALSE),
(14, 'isabella_ruiz', '$2b$10$password13', TRUE),
(15, 'javier_morales', '$2b$10$password14', TRUE),
(16, 'carolina_ortega', '$2b$10$password15', TRUE),
(17, 'miguel_vargas', '$2b$10$password16', FALSE),
(18, 'daniela_rojas', '$2b$10$password17', TRUE),
(19, 'ricardo_mendoza', '$2b$10$password18', TRUE),
(20, 'sofia_herrera', '$2b$10$password19', TRUE);

INSERT INTO role (name, description)VALUES
('admin', 'Administrador del parque, con todo permitido'),
('operator', 'operador del parque y atracciones'),
('supervisor', 'Supervisor de operaciones'),
('maintenance_manager', 'Jefe de mantenimiento de atracciones'),
('cashier', 'Cajero de taquilla y puntos de venta'),
('security_guard', 'Guardia de seguridad'),
('cleaner', 'Personal de limpieza y aseo'),
('food_service', 'Personal encargado del servicio de alimentos'),
('lifeguard', 'Salvavidas en zonas acuáticas'),
('ticket_checker', 'Verificador de tickets en atracciones'),
('customer_service', 'Atención al cliente'),
('technician', 'Técnico de las atracciones'),
('manager', 'Gerente en un área específica'),
('coordinator', 'Coordinador del personal'),
('trainer', 'Instructor y entrenador de personal'),
('analyst', 'Analista de datos'),
('marketing', 'Encargados de las promociones y publicidad'),
('rh', 'Recursos humanos del parque'),
('accountant', 'Contador del parque'),
('support', 'Soporte técnico de sistemas');

INSERT INTO user_role (user_account_id, role_id ) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 10),
(6, 6),
(7, 11),
(8, 16),
(9, 20),
(10, 5),
(11, 7),
(12, 19),
(13, 13),
(14, 14),
(15, 15),
(16, 8),
(17, 11),
(18, 18),
(19, 12),
(20, 9);

INSERT INTO module (name, description ) VALUES 
("security", " Módulo de seguridad con 8 entidades"),
("Park", "Módulo del sistema de atracciones con 10 entidades"),
('sales', 'Módulo de ventas y puntos de venta'),
('maintenance', 'Módulo de mantenimiento'),
('rrhh', 'Módulo de recursos humanos'),
('finance', 'Módulo financiero'),
('inventory', 'Módulo de inventario' ),
('marketing', 'Módulo de marketing'),
('reports', 'Módulo de reportes'),
('customer_service', 'Módulo de servicio al cliente'),
('ticketing', 'Módulo de gestión de tickets'),
('scheduling', 'Módulo de programación y horarios'),
('quality', 'Módulo de control de calidad'),
('safety', 'Módulo de seguridad industrial'),
('training', 'Módulo de capacitación'),
('facilities', 'Módulo de gestión de instalaciones'),
('suppliers', 'Módulo de proveedores'),
('events', 'Módulo de gestión de eventos'),
('membership', 'Módulo de membresías'),
('mobile_app', 'Módulo de aplicación móvil');

INSERT INTO module_role (module_id, role_id ) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 10),
(6, 6),
(7, 11),
(8, 16),
(9, 20),
(10, 5),
(11, 7),
(12, 19),
(13, 13),
(14, 14),
(15, 15),
(16, 8),
(17, 11),
(18, 18),
(19, 12),
(20, 9);

INSERT INTO view (name, description ) VALUES 
('Dashboard', 'Vista principal del sistema'),
('user_management', 'Gestion de usuarios'),
('sales_dashboard', 'Panel de control de ventas'),
('maintenance_tracking', 'Seguimiento de mantenimientos'),
('employee_management', 'Gestión de empleados'),
('financial_reports', 'Reportes financieros'),
('inventory_control', 'Control de inventario'),
('marketing_campaigns', 'Campaña de marketing'),
('customer_analytics', 'Analisis de clientes'),
('ticket_sales', 'Ventas de tickets'),
('schedule_management', 'Gestión de horarios'),
('quality_metrics', 'Métricas de calidad'),
('safety_reports', 'Reportes de seguridad'),
('training_modules', 'Modulos de capacitación'),
('facility_management', 'Gestión de instalaciones'),
('supplier_management', 'Gestión de proveedores'),
('event_management', 'Gestión de eventos'),
('membership_management', 'Gestión de membresias'),
('mobile_analytics', 'Analisis movil'),
('system_settings', 'Configuración del sistema');

INSERT INTO view_module (view_id, module_id ) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 10),
(6, 6),
(7, 11),
(8, 16),
(9, 20),
(10, 5),
(11, 7),
(12, 19),
(13, 13),
(14, 14),
(15, 15),
(16, 8),
(17, 11),
(18, 18),
(19, 12),
(20, 9);

-- 🏞️ MODULE: PARK

INSERT INTO zone (name, capacity, description ) VALUES 
('Kids zone',120, 'Zona infantil'),
('Water zone', 130, 'Zona acuática con piscinas y toboganes'),
('Adventure Zone', 200, 'Zona de atracciones tematica selva'),
('Family Zone', 150, 'Zona familiar con atracciones familiares'),
('Thrill Zone', 100, 'Zona de alta adrenalina para amantes de la emocion'),
('Relax Zone', 80, 'Zona de descanso'),
('Food Court', 300, 'Área de comidas'),
('Shopping Zone', 120, 'Zona de tiendas'),
('Entertainment Zone', 250, 'Zona de ecenario'),
('Sports Zone', 180, 'Zona de actividades deportivas'),
('Educational Zone', 90, 'Zona educativa'),
('VIP Zone', 50, 'Zona exclusiva para VIP'),
('Seasonal Zone', 110, 'Zona para atracciones temporales'),
('Night Zone', 140, 'Zona especial para eventos nocturnos'),
('Dance Zone', 95, 'Zona de baile'),
('Technology Zone', 85, 'Zona de atracciones tecnológicas'),
('Nature Zone', 200, 'Zona de contacto con la naturaleza'),
('Fantasy Zone', 160, 'Zona temática de fantasía'),
('Science Zone', 75, 'Zona científica e interactiva'),
('Music Zone', 130, 'Zona musical');

INSERT INTO attraction (zone_id, name, description, min_height, max_capacity, status) VALUES 
(1, 'Carousel for children', 'Carusel divertido de caballos', 80, 10, TRUE),
(2, 'Animal Slide', 'Tobogan de 40 metros', 150, 20, TRUE),
(3, 'Roller Coaster Extreme', 'Montaña rusa de alta velocidad', 140, 24, FALSE),
(4, 'Ferris Wheel', 'Rueda de la fortuna', 100, 30, TRUE),
(5, 'Haunted Mansion', 'Casa encantada', 120, 15, TRUE),
(6, 'Bumper Cars', 'Autos chocones', 110, 20, FALSE),
(7, 'Pirate Ship', 'Barco pirata que se balancea', 130, 40, TRUE),
(8, 'Virtual Reality Arena', 'Arena de realidad virtual', 125, 12, TRUE),
(9, 'Laser Tag', 'Juego de láser multijugador', 120, 25, TRUE),
(10, 'Wave Pool', 'Piscina de olas artificiales', 130, 50, FALSE),
(11, 'Rock Climbing Wall', 'Muro de escalada de 15 metros', 140, 8, TRUE),
(12, 'Go-Kart Track', 'Pista de karts para carreras', 145, 16, TRUE),
(13, '3D Cinema', 'Cine 3D con películas exclusivas', 100, 60, TRUE),
(14, 'Arcade Center', 'Centro de arcade', 90, 40, TRUE),
(15, 'Zip Line', 'Tirolina de 100 metros', 150, 4, FALSE),
(16, 'Merry-Go-Round', 'Carrusel clásico con música', 80, 25, TRUE),
(17, 'Water Coaster', 'Montaña rusa acuática', 140, 20, TRUE),
(18, 'Dancing Fountains', 'Fuentes danzantes con luces', 90, 100, TRUE),
(19, 'Science Lab', 'Laboratorio científico', 110, 20, TRUE),
(20, 'Karaoke Stage', 'Escenario de karaoke privado', 100, 15, FALSE);

INSERT INTO employee (first_name, last_name, phone, email, hire_date, status, role, zone_id, attraction_id) VALUES 
('Mateo', 'Tamayo Parra', '828288181', 'mateo.tamayo@gmail.com', '2023-01-05', TRUE, 'maintenance', 2, 2 ),
('Esmeralda', 'Nuñez Fuentes', '829902022', 'esmeralda.nuñez@gmail.com', '2023-01-05', TRUE, 'operator', 1, 1 ),
('Carlos', 'Mendoza López', '3101112233', 'carlos.mendoza@gmail.com', '2023-01-15', FALSE, 'admin', 3, 3),
('Ana', 'García Ruiz', '3112223344', 'ana.garcia@gmail.com', '2023-02-20', TRUE, 'seller', 4, 4),
('Luis', 'Hernández Castro', '3123334455', 'luis.hernandez@gmail.com', '2023-03-10', TRUE, 'security', 5, 5),
('Marta', 'Díaz Ortega', '3134445566', 'marta.diaz@gmail.com', '2023-04-05', TRUE, 'cleaning', 6, 6),
('Jorge', 'Ramírez Silva', '3145556677', 'jorge.ramirez@gmail.com', '2023-05-12', TRUE, 'seller', 7, 7),
('Patricia', 'Torres Vargas', '3156667788', 'patricia.torres@gmail.com', '2023-06-18', TRUE, 'operator', 8, 8),
('Fernando', 'Rojas Mendoza', '3167778899', 'fernando.rojas@gmail.com', '2023-07-22', FALSE, 'operator', 9, 9),
('Gabriela', 'Castro Herrera', '3178889900', 'gabriela.castro@gmail.com', '2023-08-30', TRUE, 'seller', 10, 10),
('Raúl', 'Ortega Peña', '3189990011', 'raul.ortega@gmail.com', '2023-09-14', TRUE, 'maintenance', 11, 11),
('Sandra', 'Vargas Ríos', '3190001122', 'sandra.vargas@gmail.com', '2023-10-25', TRUE, 'admin', 12, 12),
('Roberto', 'Morales Jiménez', '3201112233', 'roberto.morales@gmail.com', '2023-11-08', TRUE, 'operator', 13, 13),
('Lucía', 'Herrera Núñez', '3212223344', 'lucia.herrera@gmail.com', '2023-12-01', TRUE, 'seller', 14, 14),
('Alberto', 'Peña Castillo', '3223334455', 'alberto.pena@gmail.com', '2024-01-15', FALSE, 'admin', 15, 15),
('Elena', 'Ríos Delgado', '3234445566', 'elena.rios@gmail.com', '2024-02-20', TRUE, 'seller', 16, 16),
('José', 'Jiménez Flores', '3245556677', 'jose.jimenez@gmail.com', '2024-03-10', TRUE, 'security', 17, 17),
('Carmen', 'Núñez Reyes', '3256667788', 'carmen.nunez@gmail.com', '2024-04-05', TRUE, 'cleaning', 18, 18),
('David', 'Castillo Soto', '3267778899', 'david.castillo@gmail.com', '2024-05-12', TRUE, 'maintenance', 19, 19),
('Teresa', 'Delgado Mora', '3278889900', 'teresa.delgado@gmail.com', '2024-06-18', FALSE, 'operator', 20, 20);

INSERT INTO visitor (first_name, last_name, document_type, document_number, email, phone, age) VALUES 
('Paula', 'Díaz Poveda', 'TI', '71716166116', 'paula.diaz@gmail.com', '9299282881', 17 ),
('Ernesto', 'Rojas Peréz', 'CC', '8277278921', 'erne.rojas@hotmail.com', '3727772828', 40),
('Alejandro', 'Martínez Rojas', 'CC', '1122334455', 'alejandro.martinez@gmail.com', '3101112233', 25),
('Beatriz', 'López García', 'CC', '2233445566', 'beatriz.lopez@gmail.com', '3112223344', 30),
('Caesar', 'Gómez Hernández', 'TI', '3344556677', 'caesar.gomez@gmail.com', '3123334455', 16),
('Diana', 'Rodríguez Silva', 'CC', '4455667788', 'diana.rodriguez@gmail.com', '3134445566', 28),
('Eduardo', 'Hernández Díaz', 'CC', '5566778899', 'eduardo.hernandez@gmail.com', '3145556677', 35),
('Fabiola', 'Silva Martínez', 'TI', '6677889900', 'fabiola.silva@fmail.com', '3156667788', 15),
('Gustavo', 'Díaz López', 'CC', '7788990011', 'gustavo.diaz@gmail.com', '3167778899', 40),
('Helena', 'Martínez Gómez', 'CC', '8899001122', 'helena.martinez@gmail.com', '3178889900', 22),
('Iván', 'López Rodríguez', 'TI', '9900112233', 'ivan.lopez@gmail.com', '3189990011', 17),
('Julia', 'Gómez Silva', 'CC', '1011223344', 'julia.gomez@gmail.com', '3190001122', 29),
('Kevin', 'Rodríguez Hernández', 'CC', '2022334455', 'kevin.rodriguez@gmail.com', '3201112233', 32),
('Liliana', 'Hernández Martínez', 'TI', '3033445566', 'liliana.hernandez@gmail.com', '3212223344', 14),
('Manuel', 'Silva Díaz', 'CC', '4044556677', 'manuel.silva@gmail.com', '3223334455', 38),
('Natalia', 'Díaz Gómez', 'CC', '5055667788', 'natalia.diaz@gmail.com', '3234445566', 26),
('Óscar', 'Martínez Rodríguez', 'TI', '6066778899', 'oscar.martinez@gmail.com', '3245556677', 13),
('Paulina', 'López Hernández', 'CC', '7077889900', 'paulina.lopez@gmail.com', '3256667788', 31),
('Mauro', 'Gómez Díaz', 'CC', '8088990011', 'mauro.gomez@gmail.com', '3267778899', 27),
('Rosa', 'Rodríguez Martínez', 'TI', '9099001122', 'rosa.rodriguez@gmail.com', '3278889900', 16);

INSERT INTO ticket (visitor_id, purchase_date, ticket_type, price, valid_until) VALUES 
(1, '2025-11-16 10:30:00', 'common', 50000, '2025-11-16' ),
(2, '2025-11-16 10:50:00', 'VIP', 80000,'2025-11-16'),
(3, '2025-11-16 09:00:00', 'common', 50000, '2025-11-16'),
(4, '2025-11-16 09:15:00', 'VIP', 80000, '2025-11-16'),
(5, '2025-11-16 09:30:00', 'common', 50000, '2025-11-16'),
(6, '2025-11-16 09:45:00', 'child', 30000, '2025-11-16'),
(7, '2025-11-16 10:00:00', 'VIP', 80000, '2025-11-16'),
(8, '2025-11-16 10:15:00', 'common', 50000, '2025-11-16'),
(9, '2025-11-16 10:30:00', 'student', 40000, '2025-11-16'),
(10, '2025-11-16 10:45:00', 'VIP', 80000, '2025-11-16'),
(11, '2025-11-16 11:00:00', 'common', 50000, '2025-11-16'),
(12, '2025-11-16 11:15:00', 'child', 30000, '2025-11-16'),
(13, '2025-11-16 11:30:00', 'VIP', 80000, '2025-11-16'),
(14, '2025-11-16 11:45:00', 'common', 50000, '2025-11-16'),
(15, '2025-11-17 12:00:00', 'student', 40000,'2025-11-17'),
(16, '2025-11-17 12:15:00', 'VIP', 80000, '2025-11-17'),
(17, '2025-11-17 12:30:00', 'common', 50000,'2025-11-17'),
(18, '2025-11-18 12:45:00', 'child', 30000, '2025-11-18'),
(19, '2025-11-18 13:00:00', 'VIP', 80000,'2025-11-18'),
(20, '2025-11-18 13:15:00', 'common', 50000, '2025-11-18');

INSERT INTO ticket_attraction (ticket_id, attraction_id, access_time) VALUES 
(1, 1, '2025-11-16 10:50:00'),
(2, 2, '2025-11-16 11:00:00'),
(3, 3, '2025-11-16 09:30:00'),
(4, 4, '2025-11-16 09:45:00'),
(5, 5, '2025-11-16 10:00:00'),
(6, 6, '2025-11-16 10:15:00'),
(7, 7, '2025-11-16 10:30:00'),
(8, 8, '2025-11-16 10:45:00'),
(9, 9, '2025-11-16 11:00:00'),
(10, 10,'2025-11-16 11:15:00'),
(11, 11,'2025-11-16 11:30:00'),
(12, 12,'2025-11-16 11:45:00'),
(13, 13,'2025-11-16 12:00:00'),
(14, 14,'2025-11-16 12:15:00'),
(15, 15,'2025-11-17 12:30:00'),
(16, 16,'2025-11-17 12:45:00'),
(17, 17,'2025-11-17 13:00:00'),
(18, 18,'2025-11-18 13:15:00'),
(19, 19,'2025-11-18 13:30:00'),
(20, 20,'2025-11-18 13:45:00');

INSERT INTO product (name, price, stock, category) VALUES 
('Helado de chocolate', 9900, 50, 'Postre'),
('Batido de fresa', 12990, 12, 'Bebida'),
('Hamburguesa clásica', 15900, 30, 'Comida'),
('Hot dog', 8900, 40, 'Comida'),
('Pizza porción', 12900, 25, 'Comida'),
('Ensalada fresca', 13900, 20, 'Comida'),
('Agua Cristal', 4500, 100, 'Bebida'),
('Cola Condor', 5900, 80, 'Bebida'),
('Jugo natural', 7900, 35, 'Bebida'),
('Café', 4900, 50, 'Bebida'),
('Palomitas', 7900, 45, 'Snack'),
('Nachos con queso', 11900, 30, 'Snack'),
('Helado de vainilla', 9900, 25, 'Postre'),
('Brownie', 8900, 20, 'Postre'),
('Camiseta Park', 29900, 15, 'Souvenir'),
('Gorra Park', 24900, 20, 'Souvenir'),
('Llavero Park', 12900, 30, 'Souvenir'),
('Taza Park', 19900, 18, 'Souvenir'),
('Fotos con personaje', 14900, 50, 'Servicio'),
('Lockers', 9900, 40, 'Servicio');

INSERT INTO purchase (visitor_id, purchase_date, total_amount) VALUES 
(1, '2025-11-16 10:50:00', 30000),
(2, '2025-11-16 11:00:00', 32000),
(3, '2025-11-16 09:30:00', 24800),
(4, '2025-11-16 09:45:00', 31800),
(5, '2025-11-16 10:00:00', 15700),
(6, '2025-11-16 10:15:00', 22800),
(7, '2025-11-16 10:30:00', 29800),
(8, '2025-11-16 10:45:00', 16800),
(9, '2025-11-16 11:00:00', 23800),
(10, '2025-11-16 11:15:00', 30800),
(11, '2025-11-16 11:30:00', 17800),
(12, '2025-11-16 11:45:00', 24800),
(13, '2025-11-16 12:00:00', 31800),
(14, '2025-11-16 12:15:00', 18800),
(15, '2025-11-17 12:30:00', 25800),
(16, '2025-11-17 12:45:00', 32800),
(17, '2025-11-17 13:00:00', 19800),
(18, '2025-11-18 13:15:00', 26800),
(19, '2025-11-18 13:30:00', 33800),
(20, '2025-11-18 13:45:00', 20800);

INSERT INTO purchase_detail (purchase_id, product_id, quantity, unit_price) VALUES 
(1, 1, 1, 9900),
(1, 2, 1, 12990),
(3, 3, 1, 15900),
(3, 5, 2, 4500),
(4, 4, 1, 13900),
(4, 6, 2, 6900),
(5, 5, 4, 35600),
(5, 7, 1, 6900),
(6, 6, 2, 12900),
(7, 7, 1, 15900),
(7, 8, 3, 11850),
(8, 8, 1, 13900),
(8, 9, 1, 7900),
(9, 9, 2, 11900),
(10, 10, 7, 111300),
(10, 11, 2, 9900),
(11, 11, 1, 13900),
(11, 12, 5, 44500),
(12, 12, 2, 12900),
(13, 13, 1, 15900);

INSERT INTO maintenance (attraction_id, employee_id,maintenance_date, description, status) VALUES 
(1, 2, '2025-11-16', 'Revisión del Carousel', 'completed'),
(2, 2, '2025-11-16', 'Revisión previa de seguridad', 'in_progress'),
(3, 3, '2025-11-15', 'Revisión general de seguridad', 'in_progress'),
(4, 4, '2025-11-15', 'Lubricación de mecanismos', 'completed'),
(5, 5, '2025-11-16', 'Cambio de piezas desgastadas', 'in_progress'),
(6, 6, '2025-11-16', 'Limpieza profunda', 'completed'),
(7, 7, '2025-11-17', 'Actualización de software', 'scheduled'),
(8, 8, '2025-11-17', 'Revisión eléctrica', 'scheduled'),
(9, 9, '2025-11-15', 'Pruebas de carga', 'completed'),
(10, 10, '2025-11-16', 'Mantenimiento preventivo', 'in_progress'),
(11, 11, '2025-11-16', 'Calibración de sensores', 'completed'),
(12, 12, '2025-11-17', 'Cambio de fluidos', 'scheduled'),
(13, 13, '2025-11-15', 'Inspección estructural', 'completed'),
(14, 14, '2025-11-16', 'Reparación de asientos', 'in_progress'),
(15, 15, '2025-11-16', 'Mantenimiento de pista', 'completed'),
(16, 16, '2025-11-17', 'Actualización de efectos', 'scheduled'),
(17, 17, '2025-11-15', 'Limpieza de filtros', 'completed'),
(18, 18, '2025-11-16', 'Revisión de audio', 'in_progress'),
(19, 19, '2025-11-16', 'Calibración de equipos', 'completed'),
(20, 20, '2025-11-17', 'Mantenimiento general', 'scheduled');

-- FUNCTIONS 

-- Calcula el total gastado por un visitante sumando compras y tickets
DELIMITER $$

CREATE FUNCTION fn_total_gastado_visitante(p_visitor_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_compras DECIMAL(10,2);	
    DECLARE total_tickets DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    -- Total en compras
    SELECT IFNULL(SUM(total_amount), 0)
    INTO total_compras
    FROM purchase
    WHERE visitor_id = p_visitor_id;

    -- Total en tickets
    SELECT IFNULL(SUM(price), 0)
    INTO total_tickets
    FROM ticket
    WHERE visitor_id = p_visitor_id;

    SET total = total_compras + total_tickets;
    RETURN total;
END $$

DELIMITER ;

/* Calcula el aforo disponible en una zona comparando su capacidad con la suma de capacidades 
de sus atracciones*/
DELIMITER $$

CREATE FUNCTION fn_aforo_disponible_zona(p_zone_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE capacidad_zona INT;
    DECLARE capacidad_atracciones INT;

    -- Capacidad total de la zona
    SELECT capacity
    INTO capacidad_zona
    FROM zone
    WHERE id = p_zone_id;

    -- Suma de capacidad máxima de atracciones en esa zona
    SELECT IFNULL(SUM(max_capacity), 0)
    INTO capacidad_atracciones
    FROM attraction
    WHERE zone_id = p_zone_id;

    -- Aforo disponible
    RETURN capacidad_zona - capacidad_atracciones;
END $$

DELIMITER ;

-- PROCEDURES

-- Genera un ticket para un visitante, registrando la compra y la fecha de validez
DELIMITER $$

CREATE PROCEDURE sp_generar_ticket(
    IN p_visitor_id INT,
    IN p_ticket_type VARCHAR(50),
    IN p_price DECIMAL(10,2)
)
BEGIN
    INSERT INTO ticket(visitor_id, purchase_date, ticket_type, price, valid_until)
    VALUES (p_visitor_id, NOW(), p_ticket_type, p_price, DATE_ADD(CURDATE(), INTERVAL 1 DAY));
END $$

DELIMITER ;

-- Registra un mantenimiento y actualiza la atracción para dejarla inactiva
DELIMITER $$

CREATE PROCEDURE sp_registrar_mantenimiento(
    IN p_attraction_id INT,
    IN p_employee_id INT,
    IN p_description VARCHAR(255)
)
BEGIN
    INSERT INTO maintenance(attraction_id, employee_id, maintenance_date, description, status)
    VALUES (p_attraction_id, p_employee_id, CURDATE(), p_description, 'scheduled');

    -- Cambiar estado de atracción
    UPDATE attraction
    SET status = FALSE
    WHERE id = p_attraction_id;
END $$

DELIMITER ;

-- TRIGGER

-- Trigger para regresar la atracción a active cuando el mantenimiento termine
DELIMITER $$

CREATE TRIGGER tr_complete_maintenance
AFTER UPDATE ON maintenance
FOR EACH ROW
BEGIN
    -- Si el mantenimiento pasó a "completed", activar la atracción
    IF NEW.status = 'completed' THEN
        UPDATE attraction
        SET status = TRUE
        WHERE id = NEW.attraction_id;
    END IF;
END $$

DELIMITER ;

-- CONSULTAS JOINS

-- 1. Listar visitantes, sus tickets, atracciones visitadas, zonas y el empleado encargado 
SELECT v.first_name, v.last_name, t.id AS ticket_id,
       a.name AS attraction, z.name AS zone,
       e.first_name AS employee, e.role AS employee_role,
       ta.access_time
FROM visitor v
INNER JOIN ticket t ON v.id = t.visitor_id
INNER JOIN ticket_attraction ta ON t.id = ta.ticket_id
INNER JOIN attraction a ON ta.attraction_id = a.id
INNER JOIN zone z ON a.zone_id = z.id
INNER JOIN employee e ON a.id = e.attraction_id;

-- 2. Mostrar compras con productos, ticket del visitante y atracciones visitadas 
SELECT v.first_name, v.last_name, p.id AS purchase_id,
       prd.name AS product, pd.quantity,
       t.id AS ticket_id, a.name AS attraction
FROM visitor v
INNER JOIN purchase p ON v.id = p.visitor_id
INNER JOIN purchase_detail pd ON p.id = pd.purchase_id
INNER JOIN product prd ON pd.product_id = prd.id
INNER JOIN ticket t ON v.id = t.visitor_id
INNER JOIN ticket_attraction ta ON t.id = ta.ticket_id
INNER JOIN attraction a ON ta.attraction_id = a.id;

-- 3. Listar todo el personal encargado de cada atracción y sus mantenimientos 
SELECT a.name AS attraction, z.name AS zone,
       e.first_name AS employee, e.role AS employee_role,
       m.maintenance_date, m.status AS maintenance_status
FROM attraction a
INNER JOIN zone z ON a.zone_id = z.id
INNER JOIN employee e ON a.id = e.attraction_id
LEFT JOIN maintenance m ON a.id = m.attraction_id AND e.id = m.employee_id;

-- 4. Usuarios del sistema con persona, roles, módulos y vistas 
SELECT p.first_name, p.last_name, ua.username,
       r.name AS role_name, m.name AS module,
       v.name AS view_name
FROM person p
INNER JOIN user_account ua ON p.id = ua.person_id
INNER JOIN user_role ur ON ua.id = ur.user_account_id
INNER JOIN role r ON ur.role_id = r.id
INNER JOIN module_role mr ON r.id = mr.role_id
INNER JOIN module m ON mr.module_id = m.id
INNER JOIN view_module vm ON m.id = vm.module_id
INNER JOIN view v ON vm.view_id = v.id;

-- 5. Listar zonas con sus atracciones, empleados asignados y mantenimientos 
SELECT z.name AS zone, a.name AS attraction,
       e.first_name AS employee, e.role,
       m.maintenance_date, m.status
FROM zone z
INNER JOIN attraction a ON z.id = a.zone_id
INNER JOIN employee e ON a.id = e.attraction_id
LEFT JOIN maintenance m ON a.id = m.attraction_id;

-- 6. Reporte de visitantes: tickets, atracciones, compras y productos 
SELECT v.first_name, v.last_name,
       t.id AS ticket_id, a.name AS attraction,
       p.id AS purchase_id, prd.name AS product
FROM visitor v
LEFT JOIN ticket t ON v.id = t.visitor_id
LEFT JOIN ticket_attraction ta ON t.id = ta.ticket_id
LEFT JOIN attraction a ON ta.attraction_id = a.id
LEFT JOIN purchase p ON v.id = p.visitor_id
LEFT JOIN purchase_detail pd ON p.id = pd.purchase_id
LEFT JOIN product prd ON pd.product_id = prd.id;

-- 7. Atracciones con su uso, zona, empleados y mantenimientos 
SELECT a.name AS attraction, z.name AS zone,
       COUNT(ta.id) AS total_uses,
       e.first_name AS employee,
       m.status AS maintenance_status
FROM attraction a
INNER JOIN zone z ON a.zone_id = z.id
INNER JOIN ticket_attraction ta ON a.id = ta.attraction_id
INNER JOIN employee e ON a.id = e.attraction_id
LEFT JOIN maintenance m ON a.id = m.attraction_id
GROUP BY a.name, z.name, e.first_name, m.status;

-- 8. Historial de un empleado: zona, atracción, mantenimientos y visitantes atendidos 
SELECT e.first_name AS employee, e.role,
       z.name AS zone, a.name AS attraction,
       m.maintenance_date,
       v.first_name AS visitor
FROM employee e
INNER JOIN zone z ON e.zone_id = z.id
INNER JOIN attraction a ON e.attraction_id = a.id
LEFT JOIN maintenance m ON e.id = m.employee_id
LEFT JOIN ticket_attraction ta ON a.id = ta.attraction_id
LEFT JOIN ticket t ON ta.ticket_id = t.id
LEFT JOIN visitor v ON t.visitor_id = v.id;

-- 9. Ranking de visitantes por cantidad de atracciones y compras 
SELECT v.first_name, v.last_name,
       COUNT(DISTINCT ta.id) AS attractions_visited,
       COUNT(DISTINCT p.id) AS purchases_made
FROM visitor v
LEFT JOIN ticket t ON v.id = t.visitor_id
LEFT JOIN ticket_attraction ta ON t.id = ta.ticket_id
LEFT JOIN purchase p ON v.id = p.visitor_id
GROUP BY v.id
ORDER BY attractions_visited DESC, purchases_made DESC;

-- 10. Reporte completo: atracción, zona, empleados, visitantes y productos comprados 
SELECT a.name AS attraction, z.name AS zone,
       e.first_name AS employee,
       v.first_name AS visitor, p.id AS purchase_id, prd.name AS product
FROM attraction a
INNER JOIN zone z ON a.zone_id = z.id
INNER JOIN employee e ON a.id = e.attraction_id
LEFT JOIN ticket_attraction ta ON a.id = ta.attraction_id
LEFT JOIN ticket t ON ta.ticket_id = t.id
LEFT JOIN visitor v ON t.visitor_id = v.id
LEFT JOIN purchase p ON v.id = p.visitor_id
LEFT JOIN purchase_detail pd ON p.id = pd.purchase_id
LEFT JOIN product prd ON pd.product_id = prd.id;

-- 11. Atracciones visitadas por menores de edad 
SELECT v.first_name, v.last_name, v.age,
       a.name AS attraction, ta.access_time
FROM visitor v
INNER JOIN ticket t ON v.id = t.visitor_id
INNER JOIN ticket_attraction ta ON t.id = ta.ticket_id
INNER JOIN attraction a ON ta.attraction_id = a.id
WHERE v.age < 18;

-- Probar las funciones
-- 1
SELECT fn_total_gastado_visitante(1) AS total_gastado;

-- 2
SELECT fn_aforo_disponible_zona(1) AS aforo_disponible;

-- Probar Procedures
-- 1
CALL sp_generar_ticket(1, 'VIP', 50000);
SELECT * FROM ticket where visitor_id=1;

-- 2
CALL sp_registrar_mantenimiento(1, 2, 'Cambio de cables');
SELECT * FROM maintenance where attraction_id=1;
SELECT status FROM attraction WHERE id = 1;

-- Probar Trigger
SELECT id, status FROM attraction WHERE id = 3;

-- Actualizar
UPDATE maintenance
SET status = 'completed'
WHERE id = 3;

SELECT id, status FROM attraction WHERE id = 3;


