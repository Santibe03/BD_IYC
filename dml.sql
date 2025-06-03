-- DML: Data Manipulation Language

-- 1. Rol
INSERT INTO Rol (nomRol) VALUES
('Administrador'),
('Empleado'),
('Cliente');

-- 2. TipDoc
INSERT INTO TipDoc (numDoc) VALUES
(1), -- Cédula de Ciudadanía
(2), -- Tarjeta de Identidad
(3), -- Cédula de Extranjería
(4); -- Pasaporte

-- 3. Usuario
INSERT INTO Usuario (idUser, idRol, documento, idTipDoc, nom, apell, tel, correo, pass, Nacimiento, direccion) VALUES
('admin123', 1, 1001001000, 1, 'Juan', 'Perez', 3001234567, 'juan.perez@example.com', 'hashed_pass_admin1', '1985-05-10', 'Calle 10 # 20-30'),
('empleado456', 2, 1002002000, 1, 'Maria', 'Gomez', 3019876543, 'maria.gomez@example.com', 'hashed_pass_emp1', '1990-11-20', 'Avenida 5 # 15-25'),
('cliente789', 3, 1003003000, 1, 'Carlos', 'Lopez', 3025551234, 'carlos.lopez@example.com', 'hashed_pass_client1', '1995-03-15', 'Carrera 8 # 30-10'),
('cliente010', 3, 1004004000, 1, 'Ana', 'Diaz', 3031112233, 'ana.diaz@example.com', 'hashed_pass_client2', '1988-07-01', 'Calle 25 # 5-40'),
('emp001', 2, 1005005000, 1, 'Laura', 'Ramirez', 3047778899, 'laura.ramirez@example.com', 'hashed_pass_emp2', '1992-09-22', 'Transversal 12 # 7-18');


-- 4. Categoria (Insumos)
INSERT INTO Categoria (NomCategoria) VALUES
('Frutas y Verduras'),
('Lácteos'),
('Carnes'),
('Granos y Legumbres'),
('Panadería y Pastelería'),
('Bebidas'),
('Abarrotes');

-- 5. Insumos
INSERT INTO Insumos (CategoriaIdCategoria, Nombre, Marca, Stock, UniMedida) VALUES
(1, 'Tomate', 'NaturalFresh', 50000, 1000), -- 1000 = Gramos
(1, 'Cebolla', 'HuertaViva', 30000, 1000), -- 1000 = Gramos
(2, 'Leche', 'Alpina', 100, 1000), -- 1000 = Mililitros
(3, 'Carne de Res', 'DelCampo', 50, 1000), -- 1000 = Gramos
(4, 'Arroz', 'Diana', 200, 1000), -- 1000 = Gramos
(5, 'Harina de Trigo', 'Haz de Oros', 150, 1000), -- 1000 = Gramos
(6, 'Café', 'Sello Rojo', 80, 500), -- 500 = Gramos
(7, 'Azúcar', 'Manuelita', 120, 1000); -- 1000 = Gramos


-- 6. Ingresos (de insumos)
INSERT INTO Ingresos (Id_Admin, Fecha, Observaciones) VALUES
('admin123', '2024-05-20', 'Compra semanal de insumos'),
('admin123', '2024-05-25', 'Reposición de lácteos y carnes');

-- 7. IngresosInsumos
INSERT INTO IngresosInsumos (IngresosIdIngreso, InsumosIdInsumos, unidadMedida, cantidad) VALUES
(1, 1, 'gramos', 10000),
(1, 2, 'gramos', 5000),
(1, 4, 'gramos', 10000),
(2, 3, 'mililitros', 20000),
(2, 4, 'gramos', 15000);

-- 8. Producto
INSERT INTO Producto (nomPro, valor, imgProdu) VALUES
('Café con Leche', 5000, 'cafe_leche.jpg'),
('Hamburguesa Sencilla', 15000, 'hamburguesa_sencilla.jpg'),
('Arroz con Pollo', 18000, 'arroz_pollo.jpg'),
('Jugo de Naranja Natural', 6000, 'jugo_naranja.jpg'),
('Torta de Chocolate', 8000, 'torta_chocolate.jpg');

-- 9. InsumosProducto (Recetas)
INSERT INTO InsumosProducto (ProductoIdPro, InsumosIdInsumos, UniMedida, Cantidad) VALUES
(1, 7, 'gramos', 10), -- Café para Café con Leche
(1, 3, 'mililitros', 200), -- Leche para Café con Leche
(2, 1, 'gramos', 50), -- Tomate para Hamburguesa
(2, 2, 'gramos', 30), -- Cebolla para Hamburguesa
(2, 4, 'gramos', 150), -- Carne para Hamburguesa
(3, 5, 'gramos', 200), -- Arroz para Arroz con Pollo
(3, 1, 'gramos', 50), -- Tomate para Arroz con Pollo
(4, 1, 'gramos', 200), -- Naranja (asumiendo que Tomate es un placeholder for a general fruit for juice)
(5, 6, 'gramos', 100), -- Harina para Torta
(5, 8, 'gramos', 50); -- Azúcar para Torta


-- 10. Factura
INSERT INTO Factura (idEmpleado, idCliente, fecha, total) VALUES
('empleado456', 'cliente789', '2024-06-01 10:30:00', 21000), -- Cafe con Leche + Hamburguesa Sencilla
('emp001', 'cliente010', '2024-06-01 12:45:00', 32000); -- Arroz con Pollo + Jugo de Naranja + Torta de Chocolate

-- 11. ProductoFactura
INSERT INTO ProductoFactura (ProductoidPro, idFactura, Cantidad, Valor) VALUES
(1, 1, 1, 5000),  -- Café con Leche
(2, 1, 1, 15000), -- Hamburguesa Sencilla
(3, 2, 1, 18000), -- Arroz con Pollo
(4, 2, 1, 6000),  -- Jugo de Naranja
(5, 2, 1, 8000);  -- Torta de Chocolate

-- 12. Mesa
INSERT INTO Mesa (disponibilidad, cupo) VALUES
(1, 4), -- Disponible, 4 personas
(1, 2), -- Disponible, 2 personas
(0, 6), -- Ocupada, 6 personas
(1, 4),
(1, 2);

-- 13. Estado (Reserva)
INSERT INTO Estado (NombreEstado) VALUES
('Pendiente'),
('Confirmada'),
('Cancelada'),
('Completada');

-- 14. Reserva
INSERT INTO Reserva (idCliente, fechaAgenReserva, fechaDiaReserva, numeroPersonas, idEstado) VALUES
('cliente789', '2024-05-30', '2024-06-05 19:00:00', 4, 1), -- Pendiente
('cliente010', '2024-05-28', '2024-06-02 13:00:00', 2, 2), -- Confirmada
('cliente789', '2024-05-29', '2024-06-03 20:00:00', 6, 3); -- Cancelada

-- 15. Reserva_Mesa
INSERT INTO Reserva_Mesa (IdReserva, IdMesa) VALUES
(1, 1),
(2, 2),
(3, 3); -- Mesa 3 estaba ocupada en el ejemplo de arriba, pero para que sea coherente con la reserva cancelada, se puede asumir que se había asignado.

-- 16. Pedido
INSERT INTO Pedido (fecha, Estado, idMesa) VALUES
('2024-06-01 10:45:00', 1, 1), -- Estado 1 = Pendiente (or 'En Preparación' if you want to expand)
('2024-06-01 13:00:00', 2, 2); -- Estado 2 = Completado (or 'Entregado')

-- 17. PedidoProducto
INSERT INTO PedidoProducto (idPedido, productoIdPro, Cantidad, valor) VALUES
(1, 1, 1, 5000),  -- Café con Leche
(1, 2, 1, 15000), -- Hamburguesa Sencilla
(2, 3, 1, 18000), -- Arroz con Pollo
(2, 4, 1, 6000),  -- Jugo de Naranja
(2, 5, 1, 8000);  -- Torta de Chocolate