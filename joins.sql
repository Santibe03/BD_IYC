-- join 
-- IngresosInsumos con Ingresos e Insumos
SELECT 
    ii.IngresosIdIngreso,
    i.Fecha,
    u.nom AS Admin_Nombre,
    ins.Nombre AS Insumo,
    ii.unidadMedida,
    ii.cantidad
FROM IngresosInsumos ii
JOIN Ingresos i ON ii.IngresosIdIngreso = i.Id_Ingreso
JOIN Usuario u ON i.Id_Admin = u.documento
JOIN Insumos ins ON ii.InsumosIdInsumos = ins.idInsumos;

-- InsumosProducto con Producto e Insumos
SELECT 
    ip.ProductoIdPro,
    p.nomPro AS Producto,
    ip.InsumosIdInsumos,
    i.Nombre AS Insumo,
    ip.UniMedida,
    ip.Cantidad
FROM InsumosProducto ip
JOIN Producto p ON ip.ProductoIdPro = p.idPro
JOIN Insumos i ON ip.InsumosIdInsumos = i.idInsumos;

-- ProductoFactura con Producto y Factura
SELECT 
    pf.idFactura,
    f.fecha,
    f.total,
    pf.ProductoidPro,
    p.nomPro AS Producto,
    pf.Cantidad,
    pf.Valor
FROM ProductoFactura pf
JOIN Factura f ON pf.idFactura = f.id_factura
JOIN Producto p ON pf.ProductoidPro = p.idPro;

-- Reserva_Mesa con Reserva y Mesa
SELECT 
    rm.IdReserva,
    r.fechaDiaReserva,
    r.numeroPersonas,
    rm.IdMesa,
    m.disponibilidad,
    m.cupo
FROM Reserva_Mesa rm
JOIN Reserva r ON rm.IdReserva = r.Id_Reserva
JOIN Mesa m ON rm.IdMesa = m.idMesa;

--  PedidoProducto con Pedido y Producto 
SELECT 
    pp.idPedido,
    p.fecha,
    pp.productoIdPro,
    pr.nomPro AS Producto,
    pp.Cantidad,
    pp.valor
FROM PedidoProducto pp
JOIN Pedido p ON pp.idPedido = p.idPedido
JOIN Producto pr ON pp.productoIdPro = pr.idPro;

-- Usuario con Rol y TipDoc
SELECT 
    u.documento,
    u.nom,
    u.apell,
    r.nomRol,
    t.numDoc
FROM Usuario u
JOIN Rol r ON u.idRol = r.idRol
JOIN TipDoc t ON u.idTipDoc = t.idTipDoc;

-- Insumos con Categoria 
SELECT 
    i.idInsumos,
    i.Nombre,
    i.Marca,
    i.Stock,
    c.NomCategoria
FROM Insumos i
JOIN Categoria c ON i.CategoriaIdCategoria = c.idCategoria;

-- Ingresos con Usuario (admin)
SELECT 
    i.Id_Ingreso,
    i.Fecha,
    u.nom AS AdminNombre,
    u.apell AS AdminApellido
FROM Ingresos i
JOIN Usuario u ON i.Id_Admin = u.documento;

-- Factura con Usuario como cliente y empleado
SELECT 
    f.id_factura,
    f.fecha,
    f.total,
    CONCAT(e.nom, ' ', e.apell) AS Empleado,
    CONCAT(c.nom, ' ', c.apell) AS Cliente
FROM Factura f
JOIN Usuario e ON f.idEmpleado = e.documento
JOIN Usuario c ON f.idCliente = c.documento;

-- Reserva con Usuario y Estado
SELECT 
    r.Id_Reserva,
    CONCAT(u.nom, ' ', u.apell) AS Cliente,
    r.fechaAgenReserva,
    r.fechaDiaReserva,
    r.numeroPersonas,
    e.NombreEstado
FROM Reserva r
JOIN Usuario u ON r.idCliente = u.documento
JOIN Estado e ON r.idEstado = e.idEstado;

-- Pedido con Mesa
SELECT 
    p.idPedido,
    p.fecha,
    p.Estado,
    m.idMesa,
    m.disponibilidad,
    m.cupo
FROM Pedido p
JOIN Mesa m ON p.idMesa = m.idMesa;







