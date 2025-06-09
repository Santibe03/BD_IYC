-- LLAMAR PROCEDIMIENTOS 
-- PROCEDIMIENTO 1
 CALL insert_rol('Administrador');

-- PROCEDIMIENTO 2 
CALL sp_insert_tipodoc('Cédula de ciudadanía');

-- PROCEDIMIENTO  3
CALL insert_usuario(
   1, 1033162905, 2, 'mateo', 'puerto', 3004054500, 'mateovalencia211@gmail.com', 'mateoooo', '2004-11-22', 'askjgdjasgdj'
);

-- PROCEDIMIENTO  4
CALL insertarCategoria('Bebidas');

-- PROCEDIMIENTO  5
CALL insertarInsumo(1, 'Azúcar', 'Montero', 50, 1);

-- PROCEDIMIENTO  6
-- insertar ingresos 
CALL registrarIngreso(
    '1028031467',     -- ID del admin
    CURDATE(),        -- Fecha actual
    'Compra al proveedor XYZ',
    1,                -- ID del insumo
    'Kg',             -- Unidad de medida
    20                -- Cantidad
);

-- PROCEDIMIENTO  7
-- Ingresar producto
CALL insertarProductoConInsumos(
    'Hamburguesa ', 15000, 'img/hamburguesa.png',
    1, 'g', 200,
    2, 'ml', 50,
    3, 'unidad', 1
);

-- PROCEDIMIENTO  8
CALL insertarFactura('1007234015', '1053817299', '1986-11-09', 2);


-- PROCEDIMIENTO  9
CALL insertarMesa(1, 4);  -- Inserta una mesa disponible con cupo para 4 personas

-- PROCEDIMIENTO  10
call insertarEstado ('xd');
-- PROCEDIMIENTO  11
CALL insertarReserva('1033162905', '2025-06-09', '2025-06-10 19:00:00', 4, 1);

-- PROCEDIMIENTO  12
-- Primero inserta un pedido:
CALL insertarPedido(2, 1); -- mesa 2, estado 1

-- Luego inserta un producto a ese pedido (sabiendo el ID):
CALL insertarProductoPedido(8, 3, 2, 15000); -- pedido 1, producto 3, 2 unidades, $150













