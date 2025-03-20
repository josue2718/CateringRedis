-- Creación del tipo LISTA DE CURSOS
CREATE OR REPLACE TYPE ListaDeCursos AS TABLE OF VARCHAR2(64);

-- Creación de la tabla DEPARTAMENTOTBLA con un campo de tipo tabla anidada
CREATE TABLE DepartamentoTbla (
    nombre VARCHAR2(20),
    director VARCHAR2(20),
    oficina VARCHAR2(20),
    cursos ListaDeCursos
) NESTED TABLE cursos STORE AS Cursos_tab;

-- Inserción de datos en la tabla
INSERT INTO DepartamentoTbla (nombre, director, oficina, cursos)
VALUES (
    'Programación',
    'Víctor Matos',
    'Desarrollo',
    ListaDeCursos(
        'Programación en Java',
        'Programación en C',
        'Programación en VB',
        'Programación en C Sharp',
        'Programación en PHP'
    )
);

-- Obteniendo los datos de DepartamentoTbla
SELECT * FROM DepartamentoTbla;

-- Contando los cursos insertados
SELECT CARDINALITY(cursos) FROM DepartamentoTbla;

-- Obteniendo el nombre y los cursos de la tabla DepartamentoTbla
SELECT dt.nombre, c.COLUMN_VALUE AS curso
FROM DepartamentoTbla dt, TABLE(dt.cursos) c;

-- Modificando la lista de cursos de "Programación"
DECLARE
    new_cursos ListaDeCursos := ListaDeCursos(
        'Programación en Java',
        'Programación en C',
        'Programación en VB',
        'Programación en C Sharp',
        'Programación en PHP',
        'Programación en Android'
    );
BEGIN
    UPDATE DepartamentoTbla
    SET cursos = new_cursos
    WHERE nombre = 'Programación';
    COMMIT;
END;
/


INSERT INTO DepartamentoTbla (nombre, director, oficina, cursos)
VALUES (
    'Soporte',
    'Mario May',
    'Soporte Tecnico 01',
    ListaDeCursos(
        'office - Word',
        'Excel',
        'Power Point',
        'cursos de Exchange',
        'Windows 2008',
        'Windows 7'
    )
);


SELECT dt.nombre, dt.director, dt.oficina , c.COLUMN_VALUE AS curso
FROM DepartamentoTbla dt, TABLE(dt.cursos) c WHERE dt.director = 'Mario May';


DECLARE
    new_cursos ListaDeCursos :=  ListaDeCursos(
        'office - Word',
        'Excel',
        'Power Point',
        'cursos de Exchange',
        'Windows 2008',
        'Windows 7',
        'Windows 8',
        'redes'
    );
BEGIN
    UPDATE DepartamentoTbla
    SET cursos = new_cursos
    WHERE nombre = 'Soporte';
    COMMIT;
END;


--------------------------------------------------------------------------------------------------------------

-- Tipo para los ingredientes de una receta
CREATE TYPE Ingrediente AS OBJECT (
    Nombre VARCHAR2(100),
    Cantidad VARCHAR2(50)
);
-- Tipo para la lista de ingredientes
CREATE TYPE ListaIngredientes AS TABLE OF Ingrediente;

-- Tabla de Cocineros
CREATE TABLE Cocineros (
    ID_Cocinero NUMBER PRIMARY KEY,
    Nombre VARCHAR2(100) UNIQUE,
    Nacionalidad VARCHAR2(50)
);

-- Tabla de Recetas
CREATE TABLE Recetas (
    ID_Receta NUMBER PRIMARY KEY,
    Nombre VARCHAR2(100),
    Descripcion CLOB,
    Ingredientes ListaIngredientes,
    ID_Cocinero NUMBER REFERENCES Cocineros(ID_Cocinero)
) NESTED TABLE Ingredientes STORE AS Ingredientes_Table;

-- Tabla de Libros de Cocina
CREATE TABLE Libros (
    ISBN VARCHAR2(20) PRIMARY KEY,
    Titulo VARCHAR2(100) UNIQUE,
    Fecha_Edicion DATE
);

-- Tabla intermedia entre Libros y Cocineros (Autores)
CREATE TABLE Autores (
    ID_Cocinero NUMBER REFERENCES Cocineros(ID_Cocinero),
    ISBN VARCHAR2(20) REFERENCES Libros(ISBN),
    PRIMARY KEY (ID_Cocinero, ISBN)
);


-- Insertar Cocineros
INSERT INTO Cocineros VALUES (1, 'Juan Pérez', 'Mexicana');
INSERT INTO Cocineros VALUES (2, 'Julia Child', 'Francesa');
INSERT INTO Cocineros VALUES (3, 'Gordon Ramsay', 'Británica');
INSERT INTO Cocineros VALUES (4, 'Jamie Oliver', 'Británica');
INSERT INTO Cocineros VALUES (5, 'José Andrés', 'Italiano');
INSERT INTO Cocineros VALUES (6, 'Alejandro Ortiz', 'Colombiana');
INSERT INTO Cocineros VALUES (7, 'Manuel Caballero', 'Española');

-- Insertar Recetas
-- Receta 1: Tacos al Pastor
INSERT INTO Recetas VALUES (103, 'Tacos al Pastor', 'Receta tradicional mexicana de tacos al pastor',
    ListaIngredientes(Ingrediente('Carne de cerdo', '500g'), Ingrediente('Tortillas de maíz', '10 unidades'),
    Ingrediente('Piña', '200g'), Ingrediente('Cebolla', '1 unidad')),
    1);

-- Receta 2: Ensalada César
INSERT INTO Recetas VALUES (104, 'Ensalada César', 'Ensalada fresca con aderezo César',
    ListaIngredientes(Ingrediente('Lechuga', '300g'), Ingrediente('Pollo a la parrilla', '200g'),
    Ingrediente('Queso parmesano', '50g'), Ingrediente('Aderezo César', '3 cucharadas')),
    2);

-- Receta 3: Sopa de Tomate
INSERT INTO Recetas VALUES (105, 'Sopa de Tomate', 'Sopa suave y cremosa de tomate',
    ListaIngredientes(Ingrediente('Tomates', '6 unidades'), Ingrediente('Cebolla', '1 unidad'),
    Ingrediente('Crema de leche', '200ml'), Ingrediente('Albahaca', 'hojas al gusto')),
    3);

-- Receta 4: Hamburguesa
INSERT INTO Recetas VALUES (106, 'Hamburguesa', 'Receta de hamburguesa clásica con carne de res',
    ListaIngredientes(Ingrediente('Carne de res molida', '300g'), Ingrediente('Pan de hamburguesa', '2 unidades'),
    Ingrediente('Lechuga', 'hojas al gusto'), Ingrediente('Queso cheddar', '2 rebanadas')),
    4);

-- Receta 5: Pizza Margarita
INSERT INTO Recetas VALUES (107, 'Pizza Margarita', 'Pizza con tomate, queso mozzarella y albahaca',
    ListaIngredientes(Ingrediente('Masa de pizza', '1 unidad'), Ingrediente('Tomate', '2 unidades'),
    Ingrediente('Queso mozzarella', '200g'), Ingrediente('Albahaca', 'hojas al gusto')),
    5);



INSERT INTO Libros VALUES ('978-3-16-148410-0', 'Cocina Europea', TO_DATE('2022-06-10', 'YYYY-MM-DD'));
INSERT INTO Libros VALUES ('978-3-16-148410-1', 'Cocina Mexicana', TO_DATE('2022-06-11', 'YYYY-MM-DD'));

-- Insertar Autores
INSERT INTO Autores VALUES (1, '978-3-16-148410-1');
INSERT INTO Autores VALUES (3, '978-3-16-148410-0');
INSERT INTO Autores VALUES (4, '978-3-16-148410-0');
INSERT INTO Autores VALUES (5, '978-3-16-148410-0');


SELECT * FROM  Cocineros;

SELECT r.nombre, r.descripcion, i. nombre AS Ingredientes,  i.Cantidad
FROM Recetas r, TABLE(r.Ingredientes) i;

SELECT * FROM Libros;


UPDATE Cocineros SET Nacionalidad = 'Italiana' WHERE ID_Cocinero = 4;
UPDATE Recetas SET Descripcion = 'Rioca Pizza Margarita' WHERE ID_Receta = 107;
UPDATE Libros SET Fecha_Edicion = TO_DATE('2023-01-01', 'YYYY-MM-DD') WHERE ISBN = '978-3-16-148410-0';
UPDATE Cocineros SET Nombre = 'Juan Carlos' WHERE ID_Cocinero = 1;
UPDATE Recetas SET Nombre = 'Tropo y tacos al pastor' WHERE ID_Receta = 103;

SELECT * FROM  Cocineros;

SELECT r.nombre, r.descripcion, i. nombre AS Ingredientes,  i.Cantidad
FROM Recetas r, TABLE(r.Ingredientes) i;

SELECT * FROM Libros;




DELETE FROM Cocineros WHERE ID_Cocinero = 7;

SELECT R.Nombre, R.Descripcion, I.Nombre AS Ingrediente, I.Cantidad
FROM Recetas R, TABLE(R.Ingredientes) I
WHERE R.ID_Receta = 103;

SELECT L.Titulo, R.Nombre AS Receta , i.Nombre AS Ingredientes,  i.Cantidad
FROM Libros L
JOIN Autores A ON L.ISBN = A.ISBN
JOIN Cocineros C ON A.ID_Cocinero = C.ID_Cocinero
JOIN Recetas R ON C.ID_Cocinero = R.ID_Cocinero
CROSS JOIN TABLE(R.Ingredientes) i  -- Asegúrate de usar TABLE() para acceder a la tabla anidada
WHERE L.ISBN = '978-3-16-148410-0';


SELECT * FROM Cocineros WHERE Nombre LIKE 'J%';

SELECT DISTINCT C.Nombre
FROM Cocineros C
JOIN Autores A ON C.ID_Cocinero = A.ID_Cocinero;

SELECT C.Nombre
FROM Cocineros C
JOIN Autores A ON C.ID_Cocinero = A.ID_Cocinero
WHERE A.ISBN = '978-3-16-148410-0';

CREATE OR REPLACE PROCEDURE ListarCocineros IS
    CURSOR cur IS SELECT * FROM Cocineros;
    reg cur%ROWTYPE;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO reg;
        EXIT WHEN cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || reg.ID_Cocinero || ' - Nombre: ' || reg.Nombre || ' - Nacionalidad: ' || reg.Nacionalidad);
    END LOOP;
    CLOSE cur;
END;
/

SET SERVEROUTPUT ON;
EXEC ListarCocineros;