CREATE TABLE Cliente(
	id_cliente SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL, 
	correo VARCHAR(100) UNIQUE
);

CREATE TABLE Pelicula(
	id_pelicula SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL, 
	genero VARCHAR(100),
	duracion INT CHECK (duracion > 0)
);

CREATE TABLE Boleto(
	id_boleto SERIAL PRIMARY KEY,
	fecha DATE NOT NULL, 
	precio DECIMAL(10,2) CHECK (precio > 0),
	id_cliente INT REFERENCES Cliente (id_cliente),
	id_pelicula INT REFERENCES Pelicula (id_pelicula)
);

INSERT INTO Boleto(id_boleto, fecha, precio, id_cliente, id_pelicula)
VALUES (422214, '1/06/25', 2500.55, 12903876, 89076314);
SELECT nombre, id_pelicula FROM Pelicula;
DELETE FROM Boleto WHERE id_boleto=422214;
UPDATE Cliente SET correo='Ramirez@gmail.com' WHERE id_cliente=12903876;
