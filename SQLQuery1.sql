CREATE DATABASE BibliotecaPublicaciones

CREATE TABLE Pais(
    Id INT IDENTITY NOT NULL,
    CONSTRAINT pkPais PRIMARY KEY(Id),
    Nombre VARCHAR(100) NOT NULL,
    CodigoAlfa VARCHAR(5) NOT NULL,
    Indicativo VARCHAR(5) NULL
)

CREATE UNIQUE INDEX ixPais_Nombre
    ON Pais(Nombre)

CREATE UNIQUE INDEX ixPais_CodigoAlfa
    ON Pais(CodigoAlfa)

CREATE TABLE Region(
    Id INT IDENTITY NOT NULL,
    CONSTRAINT pkRegion PRIMARY KEY(Id),
    Nombre VARCHAR(100) NOT NULL,
    Codigo VARCHAR(5) NULL,
    IdPais INT NOT NULL,
    CONSTRAINT fkRegion_Pais FOREIGN KEY(IdPais) REFERENCES Pais(Id)
)

CREATE UNIQUE INDEX ixRegion_Nombre
    ON Region(IdPais, Nombre)

CREATE TABLE Ciudad(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Ciudad PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdRegion INT NOT NULL,
	CONSTRAINT fk_Ciudad_IdRegion FOREIGN KEY (IdRegion) REFERENCES Region(Id)
)

CREATE UNIQUE INDEX ixCiudad_Nombre
	ON Ciudad(IdRegion, Nombre)

CREATE TABLE Idioma(
    Id INT IDENTITY NOT NULL,
    CONSTRAINT pkIdioma PRIMARY KEY(Id),
    Nombre VARCHAR(100) NOT NULL,
    IdCiudad INT NULL,
    CONSTRAINT fkIdioma_Ciudad FOREIGN KEY(IdCiudad) REFERENCES Ciudad(Id)
)

CREATE UNIQUE INDEX ixIdioma_Nombre
	ON Idioma(IdCiudad, Nombre)


CREATE TABLE Editorial(
    Id INT IDENTITY NOT NULL,
    CONSTRAINT pkEditorial PRIMARY KEY(Id),
    Nombre VARCHAR(150) NOT NULL,
    IdCiudad INT NOT NULL,
    CONSTRAINT fkEditorial_Ciudad FOREIGN KEY(IdCiudad) REFERENCES Ciudad(Id)
)

CREATE UNIQUE INDEX ixEditorial_Nombre
    ON Editorial(Nombre)


CREATE TABLE Autor(
    Id INT IDENTITY NOT NULL,
    CONSTRAINT pkAutor PRIMARY KEY(Id),
    Nombre VARCHAR(150) NOT NULL,
    Año INT NULL,
    IdPais INT NOT NULL,
    CONSTRAINT fkAutor_Pais FOREIGN KEY(IdPais) REFERENCES Pais(Id)
)

CREATE INDEX ixAutor_Nombre
    ON Autor(Nombre)


CREATE TABLE Publicacion(
    Id INT IDENTITY NOT NULL,
    CONSTRAINT pkPublicacion PRIMARY KEY(Id),
    Nombre VARCHAR(200) NOT NULL,
    Año INT NULL,
    Descripcion VARCHAR(300) NULL,
    Version VARCHAR(20) NOT NULL DEFAULT '1',
    ISBN VARCHAR(20) NULL,
    IdEditorial INT NOT NULL,
    CONSTRAINT fkPublicacion_Editorial FOREIGN KEY(IdEditorial) REFERENCES Editorial(Id)
)

CREATE UNIQUE INDEX ixPublicacion_Nombre
    ON Publicacion(Nombre, Version)


CREATE TABLE Tipo(
    Id INT IDENTITY NOT NULL,
    CONSTRAINT pkTipo PRIMARY KEY(Id),
    Nombre VARCHAR(100) NOT NULL
)

CREATE UNIQUE INDEX ixTipo_Nombre
    ON Tipo(Nombre)


CREATE TABLE Genero(
    Id INT IDENTITY NOT NULL,
    CONSTRAINT pkGenero PRIMARY KEY(Id),
    Nombre VARCHAR(100) NOT NULL
)

CREATE UNIQUE INDEX ixGenero_Nombre
    ON Genero(Nombre)


CREATE TABLE Volumen(
    Id INT IDENTITY NOT NULL,
    CONSTRAINT pkVolumen PRIMARY KEY(Id),
    Nombre VARCHAR(100) NOT NULL,
    Año INT NULL
)

CREATE TABLE AutorPublicacion(
    IdAutor INT NOT NULL,
    IdPublicacion INT NOT NULL,
    CONSTRAINT pkAutorPublicacion PRIMARY KEY(IdAutor, IdPublicacion),
    CONSTRAINT fkAutorPublicacion_Autor FOREIGN KEY(IdAutor) REFERENCES Autor(Id),
    CONSTRAINT fkAutorPublicacion_Publicacion FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id)
)

CREATE TABLE PublicacionTipo(
    IdPublicacion INT NOT NULL,
    IdTipo INT NOT NULL,
    CONSTRAINT pkPublicacionTipo PRIMARY KEY(IdPublicacion, IdTipo),
    CONSTRAINT fkPublicacionTipo_Publicacion FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id),
    CONSTRAINT fkPublicacionTipo_Tipo FOREIGN KEY(IdTipo) REFERENCES Tipo(Id)
)

CREATE TABLE PublicacionGenero(
    IdPublicacion INT NOT NULL,
    IdGenero INT NOT NULL,
    CONSTRAINT pkPublicacionGenero PRIMARY KEY(IdPublicacion, IdGenero),
    CONSTRAINT fkPublicacionGenero_Publicacion FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id),
    CONSTRAINT fkPublicacionGenero_Genero FOREIGN KEY(IdGenero) REFERENCES Genero(Id)
)