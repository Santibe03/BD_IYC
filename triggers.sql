-- trigger
-- TRIGGER 1: Validar stock disponible antes de insertar un producto en pedido
DELIMITER $$

CREATE TRIGGER trg_validar_stock_insumos
BEFORE INSERT ON PedidoProducto
FOR EACH ROW
BEGIN
  DECLARE idInsumo TINYINT;
  DECLARE cantidadNecesaria INT;
  DECLARE stockActual INT;
  DECLARE insuficiente BOOLEAN DEFAULT FALSE;
  DECLARE mensajeError VARCHAR(255);

  DECLARE cur CURSOR FOR
    SELECT InsumosIdInsumos, Cantidad
    FROM InsumosProducto
    WHERE ProductoIdPro = NEW.productoIdPro;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET insuficiente = TRUE;

  OPEN cur;

  insumo_loop: LOOP
    FETCH cur INTO idInsumo, cantidadNecesaria;
    IF insuficiente THEN
      LEAVE insumo_loop;
    END IF;

    SELECT Stock INTO stockActual
    FROM Insumos
    WHERE idInsumos = idInsumo;

    IF stockActual < cantidadNecesaria * NEW.Cantidad THEN
      SET mensajeError = CONCAT('Error: No hay suficiente stock del insumo ', idInsumo);
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = mensajeError;
    END IF;
  END LOOP;

  CLOSE cur;
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

-- 4 Descontar insumos automáticamente al insertar producto en pedido
DELIMITER $$

CREATE TRIGGER trg_descuento_insumos_autom
AFTER INSERT ON PedidoProducto
FOR EACH ROW
BEGIN
  DECLARE id_insumo TINYINT;
  DECLARE cantidad_uso INT;
  DECLARE fin BOOLEAN DEFAULT FALSE;

  DECLARE cur CURSOR FOR
    SELECT InsumosIdInsumos, Cantidad
    FROM InsumosProducto
    WHERE ProductoIdPro = NEW.productoIdPro;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

  OPEN cur;

  bucle: LOOP
    FETCH cur INTO id_insumo, cantidad_uso;
    IF fin THEN
      LEAVE bucle;
    END IF;

    UPDATE Insumos
    SET Stock = Stock - (cantidad_uso * NEW.Cantidad)
    WHERE idInsumos = id_insumo;
  END LOOP;

  CLOSE cur;
END$$

DELIMITER ;

-- 5 Evitar reservas si la mesa no tiene suficiente cupo
DELIMITER $$

CREATE TRIGGER trg_validar_cupo_mesa
BEFORE INSERT ON Reserva_Mesa
FOR EACH ROW
BEGIN
  DECLARE cupo_mesa TINYINT;
  DECLARE personas_reserva TINYINT;

  SELECT cupo INTO cupo_mesa FROM Mesa WHERE idMesa = NEW.IdMesa;
  SELECT numeroPersonas INTO personas_reserva 
  FROM Reserva WHERE Id_Reserva = NEW.IdReserva;

  IF cupo_mesa < personas_reserva THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: La mesa no tiene suficiente cupo para la reserva.';
  END IF;
END$$

DELIMITER ;

-- 6 Liberar la mesa si se elimina un pedido
DELIMITER $$

CREATE TRIGGER trg_liberar_mesa_al_eliminar_pedido
AFTER DELETE ON Pedido
FOR EACH ROW
BEGIN
  UPDATE Mesa
  SET disponibilidad = 1
  WHERE idMesa = OLD.idMesa;
END$$

DELIMITER ;

-- 7 Evitar reservas en fechas pasadas
DELIMITER $$

CREATE TRIGGER trg_fecha_reserva_valida
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
  IF NEW.fechaDiaReserva < NOW() THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: No se puede reservar para una fecha pasada.';
  END IF;
END$$

DELIMITER ;

 
-- ejemplos para probar el funcionamiento de las triggers 
-- ejemplos primer trigger 
CALL insertarPedido(1, 1); -- Mesa 1 está disponible
CALL insertarPedido(2, 1); -- Mesa 2 no está disponible
CALL insertarPedido(99, 1); -- Mesa 99 no existe
CALL actualizarStockInsumo(1, -5000);
CALL insertarProductoPedido(1, 1, 5, 5000);

-- ejemplo segundo trigger 

-- Intenta asignar una reserva a una mesa que no existe (por ejemplo, mesa 99)
INSERT INTO Reserva_Mesa (IdReserva, IdMesa)
VALUES (1, 99);
-- Primero verifica estado de la mesa
SELECT idMesa, disponibilidad FROM Mesa WHERE idMesa = 2;

-- Si está en 0, entonces prueba:
INSERT INTO Reserva_Mesa (IdReserva, IdMesa)
VALUES (1, 2);
-- Verifica que esté disponible
SELECT idMesa, disponibilidad FROM Mesa WHERE idMesa = 4;

-- Luego inserta correctamente
INSERT INTO Reserva_Mesa (IdReserva, IdMesa)
VALUES (1, 4);

-- ejemplo del tercer trigger 

-- Primero verifica el ID del estado "Cancelada"
SELECT * FROM Estado WHERE NombreEstado = 'Cancelada';

-- Supón que el ID de Cancelada es 3
-- Ahora mira el estado actual de la reserva 2:
SELECT Id_Reserva, idEstado FROM Reserva WHERE Id_Reserva = 2;

-- Si no es 3, puedes hacer:
UPDATE Reserva
SET idEstado = 3
WHERE Id_Reserva = 2;


-- Verifica que la reserva 5 ya esté cancelada
SELECT Id_Reserva, idEstado FROM Reserva WHERE Id_Reserva = 5;

-- Si ya tiene idEstado = 3 (Cancelada), intenta:
UPDATE Reserva
SET idEstado = 3
WHERE Id_Reserva = 5;

-- Reserva 5 estaba cancelada, ahora la cambiamos a "Pospuesta" (por ejemplo, idEstado = 4)
UPDATE Reserva
SET idEstado = 4
WHERE Id_Reserva = 5;



-- ejemplo trigger numero cuatro 
-- Asegúrate de tener insumos suficientes
CALL actualizarStockInsumo(1, 50); -- repón stock

-- Inserta un producto en un pedido
CALL insertarProductoPedido(1, 1, 2, 5000); -- Producto 1, 2 unidades

-- Verifica que los insumos se hayan descontado
SELECT * FROM Insumos WHERE idInsumos = 1;


-- ejemplo del sexto trigger 
-- Reserva con 6 personas
INSERT INTO Reserva (idCliente, fechaAgenReserva, fechaDiaReserva, numeroPersonas, idEstado)
VALUES ('1033162905', CURDATE(), '2025-07-04 20:00:00', 6, 1);

-- Intenta asignarla a mesa con cupo 4
INSERT INTO Reserva_Mesa (IdReserva, IdMesa)
VALUES (9, 4);
-- ❌ Esperado: Error por cupo insuficiente


-- ejemplo del 6 trigger 
-- Consulta estado antes
SELECT * FROM Mesa WHERE idMesa = 4;

-- Elimina un pedido asociado a esa mesa
DELETE FROM Pedido WHERE idPedido = 1;

-- Verifica si se liberó la mesa
SELECT * FROM Mesa WHERE idMesa = 4;


-- ejemplo 7 
-- Intentar una reserva para el año pasado
INSERT INTO Reserva (idCliente, fechaAgenReserva, fechaDiaReserva, numeroPersonas, idEstado)
VALUES ('1033162905', CURDATE(), '2023-05-01 20:00:00', 4, 1);
-- ❌ Esperado: Error


