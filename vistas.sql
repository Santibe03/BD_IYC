-- vistas 
-- vista_productos_insumos
USE `proyecto_t`;
CREATE OR REPLACE VIEW vista_productos_insumos AS
SELECT 
  p.idPro,
  p.nomPro AS producto,
  p.valor AS precio,
  i.Nombre AS insumo,
  ip.Cantidad AS cantidad_necesaria,
  ip.UniMedida AS unidad
FROM Producto p
JOIN InsumosProducto ip ON p.idPro = ip.ProductoIdPro
JOIN Insumos i ON ip.InsumosIdInsumos = i.idInsumos;
-- consulta 
SELECT * FROM vista_productos_insumos;


-- vista_ingresos_insumos
DROP VIEW IF EXISTS `proyecto_t`.`vista_productos_insumos` ;
USE `proyecto_t`;
CREATE OR REPLACE VIEW vista_ingresos_insumos AS
SELECT 
  i.Nombre AS insumo,
  ing.Fecha AS fecha_ingreso,
  ii.unidadMedida,
  ii.cantidad
FROM IngresosInsumos ii
JOIN Insumos i ON ii.InsumosIdInsumos = i.idInsumos
JOIN Ingresos ing ON ii.IngresosIdIngreso = ing.Id_Ingreso;

-- consulta 
select * from  vista_ingresos_insumos;


-- vista_cuentas_usuario
DROP VIEW IF EXISTS `proyecto_t`.`vista_ingresos_insumos` ;
USE `proyecto_t`;
CREATE OR REPLACE VIEW vista_cuentas_usuario AS
SELECT 
  documento,
  idRol,
  idTipDoc,
  nom,
  apell,
  tel,
  correo,
  Nacimiento,
  direccion
FROM Usuario;

-- consulta 
select * from vista_cuentas_usuario;

-- vista_mesas_estado
DROP VIEW IF EXISTS `proyecto_t`.`vista_cuentas_usuario` ;
USE `proyecto_t`;
CREATE OR REPLACE VIEW vista_mesas_estado AS
SELECT 
  idMesa,
  CASE 
    WHEN disponibilidad = 1 THEN 'Disponible'
    ELSE 'Ocupada'
  END AS estado,
  cupo AS personas_por_mesa
FROM Mesa;

-- consulta 
select * from vista_mesas_estado;

-- 	vista_facturas
DROP VIEW IF EXISTS `proyecto_t`.`vista_mesas_estado` ;
USE `proyecto_t`;
CREATE OR REPLACE VIEW vista_facturas AS
SELECT 
  f.id_factura,
  f.fecha,
  f.total,
  f.idCliente,
  CONCAT(c.nom, ' ', c.apell) AS nombre_cliente,
  f.idEmpleado,
  CONCAT(e.nom, ' ', e.apell) AS nombre_empleado
FROM Factura f
JOIN Usuario c ON f.idCliente = c.documento
JOIN Usuario e ON f.idEmpleado = e.documento;

-- consulta 
select * from vista_facturas;