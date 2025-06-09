-- LLAMAR PROCEDIMIENTOS 
-- PROCEDIMIENTO 1
-- CALL sp_insert_rol('Administrador');

-- PROCEDIMIENTO 2 
-- CALL sp_insert_tipodoc('Cédula de ciudadanía');

-- PROCEDIMIENTO  3
-- CALL sp_insert_usuario(
    1,                -- idTipoDoc (ej: Cédula)
    2,                -- idRol (ej: Cliente)
    '1234567890',     -- documento
    'Juan Pérez',     -- nombreUsuario
    'juan@email.com', -- correo
    'clave123',       -- clave (en texto plano, se recomienda encriptar)
    TRUE              -- estado (activo)
);

-- PROCEDIMIENTO  4
CALL insertarCategoria('Bebidas');

-- PROCEDIMIENTO  5
CALL insertarInsumo(1, 'Azúcar', 'Montero', 50, 1);

-- PROCEDIMIENTO  6
-- insertar ingresos 
CALL registrarIngreso(
    '1234567890',     -- ID del admin
    CURDATE(),        -- Fecha actual
    'Compra al proveedor XYZ',
    1,                -- ID del insumo
    'Kg',             -- Unidad de medida
    20                -- Cantidad
);

-- PROCEDIMIENTO  7
-- Ingresar producto
CALL insertarProductoConInsumos(
    'Hamburguesa Clásica', 15000, 'img/hamburguesa.png',
    1, 'g', 200,
    2, 'ml', 50,
    3, 'unidad', 1
);

-- PROCEDIMIENTO  8
CALL insertarFactura('12345', '67890', 8000, 2);


-- PROCEDIMIENTO  9
CALL insertarMesa(1, 4);  -- Inserta una mesa disponible con cupo para 4 personas

-- PROCEDIMIENTO  10
Copia y pega todo el bloque anterior en una pestaña nueva de tu editor.

Selecciona todo el bloque completo.

Haz clic en “Ejecutar conjunto de instrucciones” (ícono con rayo y hoja) para evitar errores por punto y coma.

-- PROCEDIMIENTO  11
CALL insertarReserva('1234567890', '2025-06-09', '2025-06-10 19:00:00', 4, 1);

-- PROCEDIMIENTO  12
-- Primero inserta un pedido:
CALL insertarPedido(2, 1); -- mesa 2, estado 1

-- Luego inserta un producto a ese pedido (sabiendo el ID):
CALL insertarProductoPedido(1, 3, 2, 15000); -- pedido 1, producto 3, 2 unidades, $15000















