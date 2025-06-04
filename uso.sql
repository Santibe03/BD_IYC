-- LLAMAR PROCEDIMIENTOS 
-- PROCEDIMIENTO 1


-- PROCEDIMIENTO 2 


-- ACTUALIZAR TELEFONO, CORREO Y DIRRECCION
-- PROCEDIMIENTO  3

-- quieres actualizar solo el teléfono y correo, pero dejar la dirección igual:
-- CALL ActualizarUsuario('cliente789', 3101234567, 'nuevo.email@example.com', NULL);
-- Si quieres actualizar solo la dirección:
-- CALL ActualizarUsuario('empleado456', NULL, NULL, 'Nueva Calle 123');

-- PROCEDIMIENTO 4
-- CALL EliminarUsuario('cliente789');

-- PROCEDIMIENTO 5
-- CALL AgregarInsumo(1, 'Zanahoria', 'CampoLindo', 10000, 1000);

-- Actualizar el stock 
-- PROCEDIMIENTO 6
-- CALL ActualizarStockInsumo(1, 5000);
-- CALL ActualizarStockInsumo(1, -2000);


-- PROCEDIMIENTO 7
-- CALL RegistrarIngresoInsumo('admin123',CURDATE(),'Ingreso por compra semanal','gramos',3000);

-- PROCEDIMIENTO 8

-- CALL AgregarProducto(
    -- 'Limonada Natural',
   -- 7000,
    -- 'limonada_natural.jpg'
--  );


-- PROCEDIMIENTO 9
-- 1. Eliminar receta actual
CALL ActualizarRecetaProducto(2);  -- Por ejemplo, para la Hamburguesa

-- 2. Agregar nueva receta (debes hacer estas llamadas aparte)
INSERT INTO InsumosProducto (ProductoIdPro, InsumosIdInsumos, UniMedida, Cantidad) VALUES
(2, 1, 'gramos', 70),
(2, 2, 'gramos', 50),
(2, 4, 'gramos', 180);

-- PROCEDIMIENTO 10
















