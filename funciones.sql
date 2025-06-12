-- funciones de la base de datos

-- para saber disponibilidad de una mesa 
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

SELECT estaMesaDisponible(7); -- Retorna 1 (TRUE) o 0 (FALSE)

-- Función: Saber si una reserva está activa

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



SELECT estadoReserva(); -- Devuelve: 'Asignada', 'Cancelada', etc.

-- stock de un insumo 
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
SELECT infoInsumo(4);
-- Devuelve algo como: 'Insumo: Cerveza | Stock restante: 25'



