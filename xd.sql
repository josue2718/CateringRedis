CREATE TABLE Menus_Empresa (
    id_menu_empresa UNIQUEIDENTIFIER PRIMARY KEY ,
	id_empresa UNIQUEIDENTIFIER NOT NULL,
    nombre NVARCHAR(250) NOT NULL,
    descripcion NVARCHAR(500) NULL,
	link_imagen NVARCHAR(250) NULL,
    precio DECIMAL(10, 2) NOT NULL,
	min_personas INT NOT NULL,
	max_personas INT NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa)
);

CREATE TABLE Gastronomia (
  id_gastronomia UNIQUEIDENTIFIER PRIMARY KEY,
  id_menu_empresa UNIQUEIDENTIFIER NOT NULL,
  id_tipo_gastronomia INT NOT NULL,
  nombre NVARCHAR(250)NOT NULL,
  descripcion NVARCHAR(250) NOT NULL,
  link_imagen NVARCHAR(MAX) NOT NULL,
  FOREIGN KEY (id_menu_empresa) REFERENCES         Menus_Empresa(id_menu_empresa),
  FOREIGN KEY (id_tipo_gastronomia) REFERENCES       Tipo_Gastronomia(id_tipo_gastronomia)
);


CREATE TABLE Cliente (
    id_cliente UNIQUEIDENTIFIER PRIMARY KEY,
    nombre NVARCHAR(250) NOT NULL,
    apellido NVARCHAR(250) NOT NULL,
	email NVARCHAR(100) NOT NULL,
    password NVARCHAR(255) NOT NULL,
    telefono NVARCHAR(250) NULL,
	latitud DECIMAL(9, 6)NULL,
    longitud DECIMAL(9, 6 )NULL,
    rfc NVARCHAR(250) NULL,
	link_imagen NVARCHAR(MAX) NULL,
    fecha_de_creacion DATETIME DEFAULT GETDATE()
);


CREATE TABLE Propietario_empresa(
	id_propietario UNIQUEIDENTIFIER PRIMARY KEY,
    nombre NVARCHAR(250) NOT NULL,
    apellido NVARCHAR(250) NOT NULL,
	email NVARCHAR(100) NOT NULL,
    password NVARCHAR(255) NOT NULL,
    telefono NVARCHAR(250) NULL,
	rfc NVARCHAR(250) NOT NULL,
	clave NVARCHAR(250) NULL,
	link_imagen NVARCHAR(MAX) NULL,
    fecha_de_creacion DATETIME DEFAULT GETDATE()
);

----------empresa---------------------

Alter TABLE Empresa (
    id_empresa UNIQUEIDENTIFIER PRIMARY KEY,
    id_propietario UNIQUEIDENTIFIER NOT NULL,
    nombre NVARCHAR(250) NOT NULL,
	email NVARCHAR(250)NOT NULL,
	telefono NVARCHAR(250) NULL,
    direccion NVARCHAR(250)NULL,
	zona NVARCHAR(250) NULL,
	ciudad NVARCHAR(250) NULL,
	premin INT NULL,
	min_personas INT NULL,
	max_personas INT NULL,
	informacion NVARCHAR(MAX) NULL,
	diainicio NVARCHAR(250) NULL,
	diafin NVARCHAR(250) NULL,
	horainicio NVARCHAR(250) NULL,
	horafin NVARCHAR(250) NULL,
	link_logo NVARCHAR(MAX)NULL,
	latitud DECIMAL(9, 6) NULL,
    longitud DECIMAL(9, 6)NULL,
	mobiliario BIT NULL,
	blancos BIT NULL,
	personal BIT NULL,
	cristaleria BIT NULL,
	chef BIT NULL,
	meseros BIT NULL,
	vyl BIT NULL,
    fecha_de_creacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_propietario) REFERENCES Propietario_empresa(id_propietario)
);
CREATE TABLE TipoServicio (
    id_tipo_servicio INT PRIMARY KEY,
    tipo NVARCHAR(250) NOT NULL
);
INSERT INTO TipoServicio (id_tipo_servicio, tipo) VALUES (1, 'Bodas');

CREATE TABLE Empresa_TipoServicio (
    id_empresa UNIQUEIDENTIFIER NOT NULL,
    id_tipo_servicio INT NOT NULL,
    PRIMARY KEY (id_empresa, id_tipo_servicio),
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
    FOREIGN KEY (id_tipo_servicio) REFERENCES TipoServicio(id_tipo_servicio)
);


CREATE TABLE Imagenes_empresa
(
    id_imagen UNIQUEIDENTIFIER PRIMARY KEY,
    id_empresa UNIQUEIDENTIFIER NOT NULL,
    link_imagen NVARCHAR(MAX) NOT NULL,
    fecha_de_creacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa)
);





----------Menus Empresa-----------
CREATE TABLE Menus_Empresa (
    id_menu_empresa UNIQUEIDENTIFIER PRIMARY KEY ,
	id_empresa UNIQUEIDENTIFIER NOT NULL,
    nombre NVARCHAR(250) NOT NULL,
    descripcion NVARCHAR(500) NULL,
	link_imagen NVARCHAR(250) NULL,
    precio DECIMAL(10, 2) NOT NULL,
	min_personas INT NOT NULL,
	max_personas INT NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa)
);

CREATE TABLE Tipo_Gastronomia (
    id_tipo_gastronomia INT PRIMARY KEY,
	tipo NVARCHAR(250) NOT NULL
);

CREATE TABLE Gastronomia (
    id_gastronomia UNIQUEIDENTIFIER PRIMARY KEY,
    id_menu_empresa UNIQUEIDENTIFIER NOT NULL,
	id_tipo_gastronomia INT NOT NULL,
	nombre NVARCHAR(250)NOT NULL,
    descripcion NVARCHAR(250) NOT NULL,
    link_imagen NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (id_menu_empresa) REFERENCES Menus_Empresa(id_menu_empresa),
	FOREIGN KEY (id_tipo_gastronomia) REFERENCES Tipo_Gastronomia(id_tipo_gastronomia)
);

INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (1, 'Entradas');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (2, 'Plato fuerte');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (3, 'Postre');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (4, 'Vinos');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (6, 'Aperitivos');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (7, 'Buffet');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (8, 'Coctelería');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (9, 'Menú infantil');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (10, 'Menú vegetariano');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (11, 'charolas');
INSERT INTO Tipo_Gastronomia (id_tipo_gastronomia, tipo) VALUES (12, 'Otros');

----------Reserva-P----------------

CREATE TABLE Reserva (
    id_reserva UNIQUEIDENTIFIER PRIMARY KEY,
    id_cliente UNIQUEIDENTIFIER NOT NULL,
    id_empresa UNIQUEIDENTIFIER NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    costo DECIMAL(10, 2),
    anticipo DECIMAL(10, 2),
	horas TIME NOT NULL,
	contrato NVARCHAR(MAX) NULL,
	mobiliario BIT NULL,
	blancos BIT NULL,
	personal BIT NULL,
	cristaleria BIT NULL,
	chef BIT NULL,
	meseros BIT NULL,
	cantidadmeseros INT NULL,
    fecha_de_creacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);
CREATE TABLE Reserva_Menus (
    id_reserva UNIQUEIDENTIFIER NOT NULL,
    id_menu_empresa UNIQUEIDENTIFIER NOT NULL,
	cantidad INT NOT NULL,
    PRIMARY KEY (id_reserva, id_menu_empresa), -- Clave primaria combinada
    FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva),
    FOREIGN KEY (id_menu_empresa) REFERENCES Menus_Empresa(id_menu_empresa)
);
CREATE TABLE Reserva_direccion (
    id_direccion UNIQUEIDENTIFIER PRIMARY KEY,
    id_reserva UNIQUEIDENTIFIER NOT NULL,
    latitud DECIMAL(9, 6),           
    longitud DECIMAL(9, 6),         
    direccion NVARCHAR(250) NOT NULL,   
    nombre_lugar NVARCHAR(250) NOT NULL, 
    num_casa NVARCHAR(250) NOT NULL,      
    referencias NVARCHAR(250) NOT NULL, 
    FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva)
);


CREATE TABLE Reserva_Info_Cliente (
    id_info UNIQUEIDENTIFIER PRIMARY KEY,
	id_reserva UNIQUEIDENTIFIER NOT NULL,
    primer_nombre NVARCHAR(250) NOT NULL,
    segundo_nombre NVARCHAR(250) NULL,
    primer_telefono NVARCHAR(250) NOT NULL,
    segundo_telefono NVARCHAR(250) NULL,
	FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva) ON DELETE CASCADE,
);

CREATE TABLE Estatus_Reserva
(
	id_estatus UNIQUEIDENTIFIER Primary key,
    id_reserva UNIQUEIDENTIFIER NOT NULL,
	enviado BIT NOT NULL,
	aceptado BIT NOT NULL,
	pagoanticipo BIT NOT NULL,
	preparando BIT NOT NULL,
	enviando BIT NOT NULL,
	entregado BIT NOT NULL,
	confirmado BIT NOT NULL,
	completado BIT NOT NULL,
	cancelado BIT NOT NULL,
	FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva)
	
);


CREATE TABLE Transacciones
(
	id_transaccion UNIQUEIDENTIFIER Primary key,
    id_cliente UNIQUEIDENTIFIER NOT NULL,
    id_empresa UNIQUEIDENTIFIER NOT NULL,
    id_reserva UNIQUEIDENTIFIER NOT NULL,
    preferenceId NVARCHAR(255) NOT NULL,
    producto NVARCHAR(255) NOT NULL,
    precio DECIMAL(18, 2) NOT NULL, -- Para precios con dos decimales
    cantidad INT NOT NULL,
    estado NVARCHAR(50) NOT NULL, -- Puede ser: 'pendiente', 'pagado', 'fallido'
    fechaCreacion DATETIME DEFAULT GETDATE(), -- Se asigna la fecha actual por defecto
	FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva),
	FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

select*from Transacciones
ALTER TABLE Descuentos ALTER COLUMN fecha_inicio DATETIME2;
ALTER TABLE Descuentos ALTER COLUMN fecha_fin DATETIME2;


--Descuentos--
CREATE TABLE Descuentos (
    id_descuento UNIQUEIDENTIFIER PRIMARY KEY,
    id_empresa UNIQUEIDENTIFIER NOT NULL,
    descripcion NVARCHAR(250) NOT NULL,
	link_imagen NVARCHAR(MAX) NOT NULL,
    porcentaje INT NULL,
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa)
);
--calificacion--
CREATE TABLE calificacion (
    id_calificacion UNIQUEIDENTIFIER PRIMARY KEY,
    id_empresa UNIQUEIDENTIFIER NOT NULL,
    id_cliente UNIQUEIDENTIFIER NOT NULL,
    comentario NVARCHAR(250) NOT NULL,
    estrellas INT NOT NULL,
    link_imagen NVARCHAR(MAX) NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE favoritos (
    id_favorito UNIQUEIDENTIFIER PRIMARY KEY,
    id_empresa UNIQUEIDENTIFIER NOT NULL,
    id_cliente UNIQUEIDENTIFIER NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);