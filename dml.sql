

-- Inserting data into Rol
INSERT INTO Rol (nomRol) VALUES
('cliente'),
('empleado'),
('admin');

-- Inserting data into TipDoc
INSERT INTO TipDoc (numDoc) VALUES
('T.I'),
('C.C'),
('Pasaporte'),
('C.E');



-- Inserting data into Usuario
INSERT INTO Usuario (idRol, documento, idTipDoc, nom, apell, tel, correo, pass, Nacimiento, direccion) VALUES
( 1, 1072340245, 1, 'Emiliano', 'Martinez', 3206466399, 'ecurvitaeae-663@gmail.com', '2SY9729aE@g', '2005-06-12', 'Amabal Lorenzton Delacruz 5 - Shreveport, Ast / 48673'),
( 2, 1007234015, 1, 'Pedro', 'Gonzales', 3008686735, 'johmtummeirma-848@gmail.com', '2M94F_i~U@h', '2004-11-17', 'Escalante Carlos s/n. - Plantation, Ast / 80459'),
( 2, 1053776140, 3, 'Cristiano', 'Ronaldo', 3345876699, 'croporeefee-564@gmail.com', 's0R0G02c7hAC', '2024-11-26', 'Apartamento Oscar, 75 - Charleston, Gai / 45421'),
( 1, 75077205, 4, 'Mohamed', 'Salah', 3902826198, 'jonluinfafio-756@gmail.com', 'IYSk0jI@kM-sJ', '1988-07-17', 'Terrenos Cesar Bustos, 10 - Honolulu, Leo / 02782'),
( 1, 1053817299, 4, 'James', 'Rodriguez', 3272962823, 'seifaddeufalo-380@gmail.com', '7s-99E0wO1DjP', '1986-11-09', 'Colegio Reina 84 - Jackson, Com / 12497'),
( 1, 1053784128, 2, 'Kevin', 'Debruynr', 3206406479, 'pneespejo-244@gmail.com', 'QDZy"G3719b', '1998-08-26', 'Bloque Cesar Tellez, 6 - Walnut Creek, Mur / 66860'),
( 1, 1007234235, 1, 'Ismael', 'Musala', 3446372442, 'poopiettootro-961@gmail.com', '828RH19qF91e', '1993-03-06', 'Questa Carlos Pantoja, 27 - Greensboro, Man / 50555'),
( 1, 1053782428, 2, 'Wataru', 'Endo', 3477380648, 'cofnagtissebrau-396@gmail.com', 'HKY10178rO', '1993-02-03', 'Extrrañao Tomas Lemms, 70 - Lauderdale, Rio / 07609'),
( 3, 1028031467, 3, 'Alisson', 'Becker', 3508189624, 'imbequaiisou-310@gmail.com', '8Kj6Y-2-5A@r', '1995-06-13', 'Riera German Quiñones, 1 - Providence, Vas / 38744'),
( 1, 1053783940, 1, 'Tek', 'Sezeny', 3539892190, 'unaiyeponi-200@gmail.com', 'i41SQ21s1584', '1981-12-16', 'Rua Jose Maria, 65 - Broomfield, Man / 20370'),
( 1, 1053775075, 1, 'Andrea', 'Pirlo', 3569798578, 'cessaivoullelieu-117@gmail.com', 'p6ijJvJv2_7', '1995-12-26', 'Camino Raul s/n. - Burnsville, Manj / 13680');

-- Inserting data into Categoria
INSERT INTO Categoria (NomCategoria) VALUES
('Licor'),
('Dulces'),
('Condimentos'),
('Perecederos'),
('Fruta');

-- Inserting data into Insumos
INSERT INTO Insumos (CategoriaIdCategoria, Nombre, Marca, Stock, UniMedida) VALUES
(1, 'Cerveza', 'corona', 30, 1),
(1, 'Ron', 'bull', 1000, 1),
(1, 'Wisky', 'Chivas-Regal', 500, 1),
(2, 'Gusanitos', 'Trululu', 600, 2),
(2, 'Aros', 'Trululu', 60, 2),
(4, 'Cables', 'Gomeros', 300, 2),
(5, 'Limon', 'N/A', 50, 3),
(3, 'Sal-limon', 'Refisal', 1000, 2),
(3, 'Paprica', 'Refisal', 1000, 2);

-- Inserting data into Ingresos
INSERT INTO Ingresos (Id_Admin, Fecha, Observaciones) VALUES
('1028031467', '2024-11-26', 'Se ingresa tanta cantidad de insumo'),
('1028031467', '2024-11-26', 'Se ingresa tanta cantidad de insumo'),
('1028031467', '2024-11-26', 'Se ingresa tanta cantidad de insumo'),
('1028031467', '2024-11-26', 'Se ingresa tanta cantidad de insumo'),
('1028031467', '2024-11-26', 'Se ingresa tanta cantidad de insumo'),
('1028031467', '2024-11-26', 'Se ingresa tanta cantidad de insumo'),
('1028031467', '2024-11-26', 'Se ingresa tanta cantidad de insumo'),
('1028031467', '2024-11-26', 'Se ingresa tanta cantidad de insumo'),
('1028031467', '2024-11-26', 'Se ingresa tanta cantidad de insumo');

-- Inserting data into IngresosInsumos
INSERT INTO IngresosInsumos (IngresosIdIngreso, InsumosIdInsumos, unidadMedida, cantidad) VALUES
(1, 1, 'Litros', 3),
(2, 2, 'Litros', 4),
(3, 1, 'Litros', 2),
(4, 2, 'Gramos', 5),
(5, 3, 'Gramos', 1),
(6, 4, 'Gramos', 3),
(7, 5, 'libras', 6),
(8, 6, 'Gramos', 5),
(9, 7, 'Gramos', 4);

-- Inserting data into Producto
INSERT INTO Producto (nomPro, valor, imgProdu) VALUES
('Michelada', 5000, 'url'),
('Mojito', 9000, 'url'),
('Curazao', 16000, 'url'),
('Red heart', 25000, 'url'),
('Cigarrillo', 1000, 'url'),
('Chicle tequila', 5000, 'url'),
('Lulo Ron', 12000, 'url');

-- Inserting data into InsumosProducto
INSERT INTO InsumosProducto (ProductoIdPro, InsumosIdInsumos, UniMedida, Cantidad) VALUES
(1, 1, 'Litros', 3),
(2, 1, 'Litros', 4),
(3, 1, 'Litros', 2),
(4, 2, 'Gramos', 5),
(5, 3, 'Gramos', 1),
(6, 4, 'Gramos', 3),
(7, 5, 'libras', 6),
(1, 6, 'Gramos', 5),
(2, 7, 'Gramos', 4);

-- Inserting data into Factura
INSERT INTO Factura (idEmpleado, idCliente, fecha, total) VALUES
('1007234015', '1072340245', '2002-05-06 00:00:00', 50000),
('1007234015', '75077205', '2008-11-17 00:00:00', 2000),
('1053776140', '1053817299', '2024-11-26 00:00:00', 20000),
('1053776140', '1053784128', '1988-07-17 00:00:00', 35000),
('1007234015', '1007234235', '1986-11-09 00:00:00', 6000),
('1053776140', '1053783940', '1998-08-26 00:00:00', 7000);

-- Inserting data into ProductoFactura
INSERT INTO ProductoFactura (ProductoidPro, idFactura, Cantidad, Valor) VALUES
(1, 1, 3, 5000),
(2, 1, 4, 9000),
(3, 1, 2, 16000),
(4, 2, 5, 25000),
(5, 2, 1, 1000),
(6, 2, 3, 5000),
(7, 3, 6, 12000);

-- Inserting data into Mesa
INSERT INTO Mesa (disponibilidad, cupo) VALUES
(1, 4),
(0, 5),
(0, 4),
(1, 2),
(0, 5),
(1, 5),
(1, 6),
(1, 9),
(0, 4),
(0, 5),
(1, 2),
(1, 4),
(0, 5);

-- Inserting data into Estado
INSERT INTO Estado (NombreEstado) VALUES
('Asignada'),
('Tomada'),
('Cancelada'),
('Pospiesta');

-- Inserting data into Reserva
INSERT INTO Reserva (idCliente, fechaAgenReserva, fechaDiaReserva, numeroPersonas, idEstado) VALUES
('1072340245', '2005-06-12', '1988-07-17 00:00:00', 4, 2),
('75077205', '2008-11-17', '1986-11-09 00:00:00', 2, 4),
('1053817299', '2024-11-26', '1998-08-26 00:00:00', 10, 4),
('1053784128', '1988-07-17', '1993-03-06 00:00:00', 5, 2),
('1007234235', '1986-11-09', '1995-06-13 00:00:00', 6, 3),
('1053782428', '1998-08-26', '1981-12-16 00:00:00', 5, 4),
('1053783940', '1993-03-06', '1995-12-26 00:00:00', 7, 4),
('1053775075', '1993-02-03', '2024-11-26 00:00:00', 1, 3);

-- Inserting data into Reserva_Mesa
INSERT INTO Reserva_Mesa (IdReserva, IdMesa) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 1),
(6, 1),
(7, 1),
(8, 1);

-- Inserting data into Pedido
INSERT INTO Pedido (fecha, Estado, idMesa) VALUES
('1988-07-17 00:00:00', 6, 1),
('1986-11-09 00:00:00', 5, 2),
('1998-08-26 00:00:00', 4, 3),
('1993-03-06 00:00:00', 10, 4),
('1993-02-03 00:00:00', 5, 5),
('1995-06-13 00:00:00', 4, 6),
('1981-12-16 00:00:00', 7, 7),
('1995-12-26 00:00:00', 1, 8),
('2024-11-26 00:00:00', 3, 9);

-- Inserting data into PedidoProducto
INSERT INTO PedidoProducto (idPedido, productoIdPro, Cantidad, valor) VALUES
(1, 1, 3, 5000),
(1, 2, 4, 9000),
(1, 3, 2, 16000),
(2, 4, 5, 25000),
(2, 5, 1, 1000),
(3, 6, 3, 5000),
(5, 7, 6, 12000),
(6, 1, 5, 5000),
(7, 2, 4, 9000);


