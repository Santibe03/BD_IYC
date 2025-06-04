-- PROCEDIMIENTOS ALMACENADOS (REY) 

-- PROCEDIMIENTO 1
-- Insertar un nuevo usuario validando los datos basicos 
USE `proyecto_t`;
DROP procedure IF EXISTS `sp_InsertarUsuario`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE sp_InsertarUsuario(
    IN p_idUser VARCHAR(15),
    IN p_idRol TINYINT,
    IN p_documento INT,
    IN p_idTipDoc INT,
    IN p_nom VARCHAR(30),
    IN p_apell VARCHAR(30),
    IN p_tel BIGINT,
    IN p_correo VARCHAR(255),
    IN p_pass VARCHAR(255),
    IN p_Nacimiento DATE,
    IN p_direccion VARCHAR(255)
)
BEGIN
    INSERT INTO Usuario (idUser, idRol, documento, idTipDoc, nom, apell, tel, correo, pass, Nacimiento, direccion)
    VALUES (p_idUser, p_idRol, p_documento, p_idTipDoc, p_nom, p_apell, p_tel, p_correo, p_pass, p_Nacimiento, p_direccion);
END$$

DELIMITER ;

-- CREAR FACTURA 2
USE `proyecto_t`;
DROP procedure IF EXISTS `CrearFactura`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE CrearFactura(
    IN p_idEmpleado VARCHAR(15),
    IN p_idCliente VARCHAR(15),
    IN p_total INT
)
BEGIN
    INSERT INTO Factura (idEmpleado, idCliente, fecha, total)
    VALUES (p_idEmpleado, p_idCliente, NOW(), p_total);
END$$

DELIMITER ;

-- ACTUALIZAR TELEFONO, CORREO Y DIRRECCION 3
USE `proyecto_t`;
DROP procedure IF EXISTS `ActualizarUsuario`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE ActualizarUsuario(
    IN p_idUser VARCHAR(15),
    IN p_tel BIGINT,
    IN p_correo VARCHAR(255),
    IN p_direccion VARCHAR(255)
)
BEGIN
    UPDATE Usuario
    SET
        tel = CASE WHEN p_tel IS NOT NULL THEN p_tel ELSE tel END,
        correo = CASE WHEN p_correo IS NOT NULL THEN p_correo ELSE correo END,
        direccion = CASE WHEN p_direccion IS NOT NULL THEN p_direccion ELSE direccion END
    WHERE idUser = p_idUser;
END$$

DELIMITER ;


-- ELIMINAR UN USUARIO 4
USE `proyecto_t`;
DROP procedure IF EXISTS `EliminarUsuario`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE EliminarUsuario(
    IN p_idUser VARCHAR(15)
)
BEGIN
    UPDATE Usuario
    SET activo = 0
    WHERE idUser = p_idUser;
END$$

DELIMITER ;

-- AGREGAR INSUMO 
-- PROCEDIMIENTO 5 

USE `proyecto_t`;
DROP procedure IF EXISTS `AgregarInsumo`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE AgregarInsumo(
    IN p_CategoriaIdCategoria TINYINT,
    IN p_Nombre VARCHAR(55),
    IN p_Marca VARCHAR(20),
    IN p_Stock INT,
    IN p_UniMedida INT
)
BEGIN
    INSERT INTO Insumos (CategoriaIdCategoria, Nombre, Marca, Stock, UniMedida)
    VALUES (p_CategoriaIdCategoria, p_Nombre, p_Marca, p_Stock, p_UniMedida);
END$$

DELIMITER ;


-- Actualizar el stock 
-- PROCEDIMIENTO 6 
USE `proyecto_t`;
DROP procedure IF EXISTS `ActualizarInsumo`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE ActualizarInsumo(
    IN p_idInsumo TINYINT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_stock_actual INT;

    SELECT Stock INTO v_stock_actual
    FROM Insumos
    WHERE idInsumos = p_idInsumo;

    IF v_stock_actual + p_cantidad >= 0 THEN
        UPDATE Insumos
        SET Stock = Stock + p_cantidad
        WHERE idInsumos = p_idInsumo;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El stock no puede ser negativo.';
    END IF;
END$$

DELIMITER ;

-- registrar ingreso insumo 
-- PROCEDIMIENTO 7
USE `proyecto_t`;
DROP procedure IF EXISTS `RegistrarIngresoInsumo`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE RegistrarIngresoInsumo(
    IN p_Id_Admin VARCHAR(15),
    IN p_Fecha DATE,
    IN p_Observaciones VARCHAR(255),
    IN p_IdInsumo TINYINT,
    IN p_UnidadMedida VARCHAR(15),
    IN p_Cantidad INT
)
BEGIN
    DECLARE v_IdIngreso INT;


    INSERT INTO Ingresos (Id_Admin, Fecha, Observaciones)
    VALUES (p_Id_Admin, p_Fecha, p_Observaciones);


    SET v_IdIngreso = LAST_INSERT_ID();


    INSERT INTO IngresosInsumos (IngresosIdIngreso, InsumosIdInsumos, unidadMedida, cantidad)
    VALUES (v_IdIngreso, p_IdInsumo, p_UnidadMedida, p_Cantidad);


    UPDATE Insumos
    SET Stock = Stock + p_Cantidad
    WHERE idInsumos = p_IdInsumo;
END$$

DELIMITER ;


-- PROCEDIMIENTO 8
USE `proyecto_t`;
DROP procedure IF EXISTS `AgregarProducto`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE AgregarProducto(
    IN p_nomPro VARCHAR(55),
    IN p_valor INT,
    IN p_imgProdu VARCHAR(255)
)
BEGIN
    INSERT INTO Producto (nomPro, valor, imgProdu)
    VALUES (p_nomPro, p_valor, p_imgProdu);
END$$

DELIMITER ;

-- PROCEDIMIENTO 9
USE `proyecto_t`;
DROP procedure IF EXISTS `ActualizarRecetaProducto`;

DELIMITER $$
USE `proyecto_t`$$
CREATE PROCEDURE ActualizarRecetaProducto(
    IN p_idPro TINYINT
)
BEGIN
    DELETE FROM InsumosProducto
    WHERE ProductoIdPro = p_idPro;
END$$

DELIMITER ;




























