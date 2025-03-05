CREATE TYPE direc AS OBJECT
(calle varchar2(60),
ciudad varchar2(30),
pais char(2),
CP varchar(9));

CREATE TYPE persona AS OBJECT
(nombre varchar2(25),
dirección direc);
CREATE TYPE estudiante AS OBJECT
(id-estudiante varchar2(9),
persona persona);

CREATE TABLE Estudiante
(solo_estudia estudiante); 