-- PROCEDIMIENTOS ALMACENADOS (REY) 

-- PROCEDIMIENTO 1
-- insert_rol
USE `proyecto_t`;
DROP procedure IF EXISTS `insert_rol`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insert_rol (
    IN p_nombreRol VARCHAR(50)
)
BEGIN
    INSERT INTO Rol (nomRol)
    VALUES (p_nombreRol);
END$$

DELIMITER ;

-- PROCEDIMIENTO 2
USE `proyecto_t`;
DROP procedure IF EXISTS `sp_insert_tipodoc`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE sp_insert_tipodoc (
    IN p_nombreTipoDoc varchar(50)
)
BEGIN
    INSERT INTO TipDoc (numDoc)
    VALUES (p_nombreTipoDoc);
END$$

DELIMITER ;

-- PROCEDIMIENTO 3

USE `proyecto_t`;
DROP procedure IF EXISTS `insert_usuario`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insert_usuario (
	IN p_idRol INT,
    IN p_documento VARCHAR(20),
    IN p_idTipoDoc INT,
    IN p_nom VARCHAR(100),
    IN p_apell VARCHAR(100),
    IN p_tel bigint (10),
    IN p_correo VARCHAR(100),
    IN p_pass VARCHAR(100),
    IN p_nacimiento date,
    IN p_direccion varchar (255)
)
BEGIN
    INSERT INTO usuario (
        idRol,documento,idTipDoc, nom, apell,tel, correo, pass, nacimiento, direccion
    )
    VALUES (
        p_idRol,p_documento, p_idTipoDoc, p_nom, p_apell, p_tel, p_correo, p_pass, p_nacimiento, p_direccion
    );
END$$

DELIMITER ;

-- PROCEDIMIENTO  4
USE `proyecto_t`;
DROP procedure IF EXISTS `insertarCategoria`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE `insertarCategoria` (
    IN p_NomCategoria VARCHAR(55)
)
BEGIN
    INSERT INTO Categoria (NomCategoria)
    VALUES (p_NomCategoria);
END;$$

DELIMITER ;

-- PROCEDIMIENTO  5 
USE `proyecto_t`;
DROP procedure IF EXISTS `insertarInsumo`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insertarInsumo(
    IN p_CategoriaIdCategoria TINYINT(3),
    IN p_Nombre VARCHAR(55),
    IN p_Marca VARCHAR(20),
    IN p_Stock INT(10),
    IN p_UniMedida INT(10)
)
BEGIN
    INSERT INTO Insumos (
        CategoriaIdCategoria,
        Nombre,
        Marca,
        Stock,
        UniMedida
    ) VALUES (
        p_CategoriaIdCategoria,
        p_Nombre,
        p_Marca,
        p_Stock,
        p_UniMedida
    );
END$$

DELIMITER ;

-- PROCEDIMIENTO  6
USE `proyecto_t`;
DROP procedure IF EXISTS `registrarIngreso`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE registrarIngreso(
    IN p_Id_Admin VARCHAR(15),
    IN p_Fecha DATE,
    IN p_Observaciones VARCHAR(255),
    IN p_IdInsumo TINYINT(3),
    IN p_UnidadMedida VARCHAR(15),
    IN p_Cantidad INT(10)
)
BEGIN

    INSERT INTO Ingresos (Id_Admin, Fecha, Observaciones)
    VALUES (p_Id_Admin, p_Fecha, p_Observaciones);


    SET @lastIdIngreso = LAST_INSERT_ID();

    INSERT INTO IngresosInsumos (IngresosIdIngreso, InsumosIdInsumos, unidadMedida, cantidad)
    VALUES (@lastIdIngreso, p_IdInsumo, p_UnidadMedida, p_Cantidad);
END$$

DELIMITER ;

-- PROCEDIMIENTO  7
USE `proyecto_t`;
DROP procedure IF EXISTS `insertarProductoConInsumos`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insertarProductoConInsumos(
    IN p_nomPro VARCHAR(55),
    IN p_valor INT(10),
    IN p_imgProdu VARCHAR(255),

    IN p_insumo1_id TINYINT(3), IN p_insumo1_uni VARCHAR(255), IN p_insumo1_cant INT(10),
    IN p_insumo2_id TINYINT(3), IN p_insumo2_uni VARCHAR(255), IN p_insumo2_cant INT(10),
    IN p_insumo3_id TINYINT(3), IN p_insumo3_uni VARCHAR(255), IN p_insumo3_cant INT(10)
)
BEGIN

    INSERT INTO Producto (nomPro, valor, imgProdu)
    VALUES (p_nomPro, p_valor, p_imgProdu);


    SET @last_id = LAST_INSERT_ID();


    IF p_insumo1_id IS NOT NULL THEN
        INSERT INTO InsumosProducto (ProductoIdPro, InsumosIdInsumos, UniMedida, Cantidad)
        VALUES (@last_id, p_insumo1_id, p_insumo1_uni, p_insumo1_cant);
    END IF;

    IF p_insumo2_id IS NOT NULL THEN
        INSERT INTO InsumosProducto (ProductoIdPro, InsumosIdInsumos, UniMedida, Cantidad)
        VALUES (@last_id, p_insumo2_id, p_insumo2_uni, p_insumo2_cant);
    END IF;

    IF p_insumo3_id IS NOT NULL THEN
        INSERT INTO InsumosProducto (ProductoIdPro, InsumosIdInsumos, UniMedida, Cantidad)
        VALUES (@last_id, p_insumo3_id, p_insumo3_uni, p_insumo3_cant);
    END IF;

END;$$

DELIMITER ;

-- PROCEDIMIENTO  8
USE `proyecto_t`;
DROP procedure IF EXISTS `insertarFactura`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insertarFactura(
    IN p_idEmpleado VARCHAR(15),
    IN p_idCliente VARCHAR(15),
    IN p_total INT,
    IN p_cantidadProductos INT
)
BEGIN
    DECLARE nuevaFacturaID INT;
    

    INSERT INTO Factura (idEmpleado, idCliente, fecha, total)
    VALUES (p_idEmpleado, p_idCliente, NOW(), p_total);


    SET nuevaFacturaID = LAST_INSERT_ID();

END$$

DELIMITER ;


-- PROCEDIMIENTO  9
USE `proyecto_t`;
DROP procedure IF EXISTS `insertarMesa`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insertarMesa (
    IN p_disponibilidad BIT,
    IN p_cupo TINYINT(3)
)
BEGIN
    INSERT INTO Mesa (disponibilidad, cupo)
    VALUES (p_disponibilidad, p_cupo);
END$$

DELIMITER ;

-- PROCEDIMIENTO  10
USE `proyecto_t`;
DROP procedure IF EXISTS `insertarEstado`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insertarEstado (
    IN p_NombreEstado VARCHAR(255)
)
BEGIN
    INSERT INTO Estado (NombreEstado)
    VALUES (p_NombreEstado);
END;$$

DELIMITER ;

-- PROCEDIMIENTO  11
USE `proyecto_t`;
DROP procedure IF EXISTS `insertarReserva`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insertarReserva (
    IN p_idCliente VARCHAR(15),
    IN p_fechaAgenReserva DATE,
    IN p_fechaDiaReserva TIMESTAMP,
    IN p_numeroPersonas TINYINT(3),
    IN p_idEstado INT(10)
)
BEGIN
    INSERT INTO Reserva (
        idCliente,
        fechaAgenReserva,
        fechaDiaReserva,
        numeroPersonas,
        idEstado
    )
    VALUES (
        p_idCliente,
        p_fechaAgenReserva,
        p_fechaDiaReserva,
        p_numeroPersonas,
        p_idEstado
    );
END$$

DELIMITER ;

-- PROCEDIMIENTO  12
USE `proyecto_t`;
DROP procedure IF EXISTS `insertarPedido`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insertarPedido (
    IN p_idMesa TINYINT(3),
    IN p_Estado TINYINT(3)
)
BEGIN
    -- Insertar nuevo pedido
    INSERT INTO Pedido (fecha, Estado, idMesa)
    VALUES (NOW(), p_Estado, p_idMesa);
END$$

DELIMITER ;


-- procedimiento 12+1
USE `proyecto_t`;
DROP procedure IF EXISTS `insertarProductoPedido`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE insertarProductoPedido (
    IN p_idPedido INT,
    IN p_idProducto TINYINT(3),
    IN p_Cantidad INT,
    IN p_Valor INT
)
BEGIN
    INSERT INTO PedidoProducto (idPedido, productoIdPro, Cantidad, valor)
    VALUES (p_idPedido, p_idProducto, p_Cantidad, p_Valor);
END$$

DELIMITER ;


-- Procedimiento: Actualizar Información de Usuario
-- Permite actualizar los datos personales de un usuario.
DROP PROCEDURE IF EXISTS actualizarInformacionUsuario;
DELIMITER $$
CREATE PROCEDURE actualizarInformacionUsuario(
    IN p_documento VARCHAR(10),
    IN p_nom VARCHAR(30),
    IN p_apell VARCHAR(30),
    IN p_tel BIGINT(10),
    IN p_correo VARCHAR(255),
    IN p_pass VARCHAR(255),
    IN p_Nacimiento DATE,
    IN p_direccion VARCHAR(255)
)
BEGIN
    UPDATE Usuario
    SET
        nom = p_nom,
        apell = p_apell,
        tel = p_tel,
        correo = p_correo,
        pass = p_pass,
        Nacimiento = p_Nacimiento,
        direccion = p_direccion
    WHERE documento = p_documento;
END$$
DELIMITER ;

CALL actualizarInformacionUsuario(
   1033162905,'mateo', 'valencia', 3196389023, 'mateovalencia211@gmail.com', 'mateo', '2004-11-22', 'askjgdjasgdj');

select * from usuario;

-- 2. Procedimiento: Actualizar Stock de Insumo
-- Actualiza el stock de un insumo. p_cantidadCambio puede ser positivo o negativo.
DROP PROCEDURE IF EXISTS actualizarStockInsumo;
DELIMITER $$
CREATE PROCEDURE actualizarStockInsumo(
    IN p_idInsumos TINYINT,
    IN p_cantidadCambio INT
)
BEGIN
    -- Se puede añadir una validación para no permitir stock negativo
    UPDATE Insumos
    SET Stock = Stock + p_cantidadCambio
    WHERE idInsumos = p_idInsumos;
END$$
DELIMITER ;
call actualizarStockInsumo (1,5);

select * from insumos;

-- 3. Procedimiento: Actualizar Producto
-- Permite modificar los detalles de un producto.
DROP PROCEDURE IF EXISTS actualizarProducto;
DELIMITER $$
CREATE PROCEDURE actualizarProducto(
    IN p_idPro TINYINT,
    IN p_nomPro VARCHAR(55),
    IN p_valor INT(10),
    IN p_imgProdu VARCHAR(255)
)
BEGIN
    UPDATE Producto
    SET
        nomPro = p_nomPro,
        valor = p_valor,
        imgProdu = p_imgProdu
    WHERE idPro = p_idPro;
END$$
DELIMITER ;

call actualizarProducto (1,'patoloko','10000','asjdnaj');

select * from producto;

























