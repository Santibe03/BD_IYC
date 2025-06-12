-- funciones de la base de datos

-- 1  para saber disponibilidad de una mesa 
DROP FUNCTION IF EXISTS estaMesaDisponible;

DELIMITER $$

CREATE FUNCTION estaMesaDisponible(p_idMesa TINYINT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE disponible BIT;

    SELECT disponibilidad
    INTO disponible
    FROM Mesa
    WHERE idMesa = p_idMesa;

    RETURN disponible = 1;
END$$

DELIMITER ;

SELECT estaMesaDisponible(8); -- Retorna 1 (TRUE) o 0 (FALSE)

-- 2 Función: Saber si una reserva está activa

DROP FUNCTION IF EXISTS estadoReservaPorCliente;

DELIMITER $$

CREATE FUNCTION estadoReservaPorCliente(p_idCliente VARCHAR(15))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE v_estado VARCHAR(255);

    SELECT E.NombreEstado
    INTO v_estado
    FROM Reserva R
    JOIN Estado E ON R.idEstado = E.idEstado
    WHERE R.idCliente = p_idCliente
    ORDER BY R.fechaAgenReserva DESC
    LIMIT 1;

    RETURN v_estado;
END$$

DELIMITER ;



SELECT estadoReservaPorCliente(3); -- Devuelve: 'Asignada', 'Cancelada', etc.

-- 3 stock de un insumo 
DROP FUNCTION IF EXISTS infoInsumo;

DELIMITER $$

CREATE FUNCTION infoInsumo(p_idInsumo TINYINT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE v_nombre VARCHAR(55);
    DECLARE v_stock INT;

    SELECT Nombre, Stock
    INTO v_nombre, v_stock
    FROM Insumos
    WHERE idInsumos = p_idInsumo;

    RETURN CONCAT('Insumo: ', v_nombre, ' | Stock restante: ', v_stock);
END$$

DELIMITER ;
SELECT infoInsumo(8);
-- Devuelve algo como: 'Insumo: Cerveza | Stock restante: 25'

-- 4 Función: Validar Credenciales de Usuario
-- Retorna el documento del usuario si las credenciales son válidas, de lo contrario NULL.
DROP FUNCTION IF EXISTS validarCredencialesUsuario;
DELIMITER $$
CREATE FUNCTION validarCredencialesUsuario(p_correo VARCHAR(255), p_pass VARCHAR(255))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE v_documento VARCHAR(10);
    SELECT documento INTO v_documento
    FROM Usuario
    WHERE correo = p_correo AND pass = p_pass;
    RETURN v_documento;
END$$
DELIMITER ;
select validarCredencialesUsuario();


-- 5 Función: Obtener Valor de Producto
-- Retorna el valor de un producto dado su ID.
DROP FUNCTION IF EXISTS obtenerValorProducto;
DELIMITER $$
CREATE FUNCTION obtenerValorProducto(p_idPro TINYINT)
RETURNS INT(10)
DETERMINISTIC
BEGIN
    DECLARE v_valor INT(10);
    SELECT valor INTO v_valor
    FROM Producto
    WHERE idPro = p_idPro;
    RETURN v_valor;
END$$
DELIMITER ;

select obtenerValorProducto();

-- 6 Función: Calcular Subtotal de Producto en Factura
-- Calcula el subtotal para un producto específico basándose en su valor y la cantidad.
DROP FUNCTION IF EXISTS calcularSubtotalProductoFactura;
DELIMITER $$
CREATE FUNCTION calcularSubtotalProductoFactura(p_productoidPro TINYINT, p_cantidad INT)
RETURNS INT(10)
DETERMINISTIC
BEGIN
    DECLARE v_valor_unitario INT(10);
    SELECT valor INTO v_valor_unitario
    FROM Producto
    WHERE idPro = p_productoidPro;
    RETURN v_valor_unitario * p_cantidad;
END$$
DELIMITER ;

SELECT calcularSubtotalProductoFactura(2, 6);





