-- Crear la base de datos
CREATE DATABASE GestorDeTareas;
GO
USE GestorDeTareas;

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    IDUsuario INT PRIMARY KEY IDENTITY(1,1),
    Usuario NVARCHAR(50) NOT NULL UNIQUE,
    Contraseña NVARCHAR(255) NOT NULL,
    Rol NVARCHAR(20) NOT NULL,
    FotoPerfil NVARCHAR(255) NULL -- URL o ruta de la foto de perfil
);

-- Crear la tabla Categoria con código numérico para cada categoría
CREATE TABLE Categoria (
    IDCategoria INT PRIMARY KEY IDENTITY(1,1),
    CodigoCategoria TINYINT NOT NULL UNIQUE, -- Código numérico que representa la categoría
    NombreCategoria NVARCHAR(50) NOT NULL UNIQUE -- Nombre descriptivo de la categoría
);

-- Crear la tabla Estado con código numérico para cada estado
CREATE TABLE Estado (
    IDEstado INT PRIMARY KEY IDENTITY(1,1),
    CodigoEstado TINYINT NOT NULL UNIQUE, -- Representa el estado con un número
    NombreEstado NVARCHAR(20) NOT NULL UNIQUE
);

-- Crear la tabla Importancia con código numérico para cada nivel de importancia
CREATE TABLE Importancia (
    IDImportancia INT PRIMARY KEY IDENTITY(1,1),
    CodigoImportancia TINYINT NOT NULL UNIQUE, -- Representa el nivel de importancia con un número
    NivelImportancia NVARCHAR(20) NOT NULL UNIQUE
);

-- Crear la tabla Tarea que usa los códigos numéricos de Categoria, Estado e Importancia
CREATE TABLE Tarea (
    IDTarea INT PRIMARY KEY IDENTITY(1,1),
    CodigoCategoria TINYINT FOREIGN KEY REFERENCES Categoria(CodigoCategoria) ON DELETE SET NULL,
    NombreTarea NVARCHAR(100) NOT NULL,
    UsuarioAsignado INT FOREIGN KEY REFERENCES Usuario(IDUsuario) ON DELETE SET NULL,
    FechaInicio DATE NOT NULL,
    FechaFinal DATE NULL,
    CodigoImportancia TINYINT FOREIGN KEY REFERENCES Importancia(CodigoImportancia) ON DELETE SET NULL,
    CodigoEstado TINYINT FOREIGN KEY REFERENCES Estado(CodigoEstado) ON DELETE SET NULL,
	Descripcion NVARCHAR(255) NULL
);

-- Insertar categorías con códigos numéricos
INSERT INTO Categoria (CodigoCategoria, NombreCategoria) 
VALUES (1, 'Limpieza'), (2, 'Mantenimiento'), (3, 'Caja');

-- Insertar estados con códigos numéricos
INSERT INTO Estado (CodigoEstado, NombreEstado) 
VALUES (1, 'Pendiente'), (2, 'En progreso'), (3, 'Completada');

-- Insertar niveles de importancia con códigos numéricos
INSERT INTO Importancia (CodigoImportancia, NivelImportancia) 
VALUES (1, 'Alta'), (2, 'Media'), (3, 'Baja');


-- Insertar datos de prueba en la tabla Tarea
INSERT INTO Tarea (CodigoCategoria, NombreTarea, UsuarioAsignado, FechaInicio, FechaFinal, CodigoImportancia, CodigoEstado, Descripcion)
VALUES
    (1, 'Limpiar oficina', 2, '2024-11-06', '2024-11-06', 1, 1, 'Limpiar el área de trabajo principal'), -- Tarea 1 (Empleado Juan)
    (2, 'Reparar computadora', 3, '2024-11-06', '2024-11-07', 2, 2, 'Reparación de la PC de la sala de reuniones'), -- Tarea 2 (Empleado Miguel)
    (3, 'Verificar caja', 2, '2024-11-06', '2024-11-06', 3, 3, 'Verificar el estado de la caja de la tienda'); -- Tarea 3 (Empleado Juan)

-- Insertar usuarios en la tabla Usuario
INSERT INTO Usuario (Usuario, Contraseña, Rol)
VALUES
    ('admin', 'admin1234', 'Administrador'),
    ('Juan', 'juan1234', 'Empleado'),
    ('Miguel', 'miguel1234', 'Empleado');

	-- Crear el login para el administrador
CREATE LOGIN admin WITH PASSWORD = 'admin123';

-- Crear el login para Roberto
CREATE LOGIN roberto WITH PASSWORD = 'roberto123';

-- Crear el login para Miguel
CREATE LOGIN miguel WITH PASSWORD = 'miguel123';

-- Cambiar a la base de datos GestorDeTareas
USE GestorDeTareas;

-- Crear el usuario para el administrador en la base de datos y asignar permisos de administrador
CREATE USER admin FOR LOGIN admin;
ALTER ROLE db_owner ADD MEMBER admin;  -- Asignar permisos de administrador completo

-- Crear el usuario para Roberto (Empleado) con permisos de lectura
CREATE USER roberto FOR LOGIN roberto;
ALTER ROLE db_datareader ADD MEMBER roberto;  -- Solo permisos de lectura

-- Crear el usuario para Miguel (Empleado) con permisos de lectura
CREATE USER miguel FOR LOGIN miguel;
ALTER ROLE db_datareader ADD MEMBER miguel;  -- Solo permisos de lectura

