-- trigger
-- TRIGGER 1: Validar stock disponible antes de insertar un producto en pedido
DELIMITER $$

CREATE TRIGGER trg_validar_stock_insumo
BEFORE INSERT ON PedidoProducto
FOR EACH ROW
BEGIN
    -- Si para algún insumo del producto no hay suficiente stock, lanzar error
    IF EXISTS (
        SELECT 1
        FROM InsumosProducto ip
        JOIN Insumos i ON ip.InsumosIdInsumos = i.idInsumos
        WHERE ip.ProductoIdPro = NEW.productoIdPro
          AND (ip.Cantidad * NEW.Cantidad) > i.Stock
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stock insuficiente para al menos un insumo del producto.';
    END IF;
END$$

DELIMITER ;

-- TRIGGER 2: Evitar asignar mesas ocupadas a una reserva
DELIMITER $$

CREATE TRIGGER trg_validar_disponibilidad_mesa
BEFORE INSERT ON Reserva_Mesa
FOR EACH ROW
BEGIN
    -- Verificar si la mesa no existe
    IF NOT EXISTS (
        SELECT 1 FROM Mesa WHERE idMesa = NEW.IdMesa
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La mesa no existe.';
    END IF;

    -- Verificar si la mesa está ocupada
    IF EXISTS (
        SELECT 1 FROM Mesa WHERE idMesa = NEW.IdMesa AND disponibilidad = 0
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La mesa no está disponible.';
    END IF;
END$$

DELIMITER ;

 -- TRIGGER 3: Prevenir cambio de estado redundante en reserva
DELIMITER $$

CREATE TRIGGER trg_validar_cambio_estado_reserva
BEFORE UPDATE ON Reserva
FOR EACH ROW
BEGIN
    DECLARE v_estado_cancelada INT;

    -- Obtener el ID del estado "Cancelada"
    SELECT idEstado INTO v_estado_cancelada
    FROM Estado
    WHERE NombreEstado = 'Cancelada'
    LIMIT 1;

    -- Si ya estaba cancelada y se vuelve a cancelar
    IF OLD.idEstado = v_estado_cancelada AND NEW.idEstado = v_estado_cancelada THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La reserva ya estaba cancelada.';
    END IF;
END$$

DELIMITER ;

-- TRIGGER: trg_validar_insumos_suficientes_producto
DELIMITER $$

CREATE TRIGGER trg_validar_insumos_suficientes_producto
BEFORE INSERT ON PedidoProducto
FOR EACH ROW
BEGIN
    -- Verifica si existe al menos un insumo insuficiente para el producto solicitado
    IF EXISTS (
        SELECT 1
        FROM InsumosProducto ip
        JOIN Insumos i ON ip.InsumosIdInsumos = i.idInsumos
        WHERE ip.ProductoIdPro = NEW.productoIdPro
          AND (ip.Cantidad * NEW.Cantidad) > i.Stock
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El producto solicitado no se puede fabricar por falta de insumos.';
    END IF;
END$$

DELIMITER ;











