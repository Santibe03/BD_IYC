drop database if exists proyecto_t;
create database proyecto_t;
use proyecto_t;

-- 1. Tablas

CREATE TABLE Rol (
    idRol TINYINT(3) AUTO_INCREMENT PRIMARY KEY,
    nomRol VARCHAR(30)
);

CREATE TABLE TipDoc (
    idTipDoc INT(10) AUTO_INCREMENT PRIMARY KEY,
    numDoc INT(10)
);

CREATE TABLE Usuario (
    idRol TINYINT(3),
    documento VARCHAR(10)PRIMARY KEY,
    idTipDoc INT(10),
    nom VARCHAR(30),
    apell VARCHAR(30),
    tel BIGINT(10),
    correo VARCHAR(255),
    pass VARCHAR(255),
    Nacimiento DATE,
    direccion VARCHAR(255)
);

CREATE TABLE Categoria (
    idCategoria TINYINT(3) AUTO_INCREMENT PRIMARY KEY,
    NomCategoria VARCHAR(55)
);

CREATE TABLE Insumos (
    idInsumos TINYINT(3) AUTO_INCREMENT PRIMARY KEY,
    CategoriaIdCategoria TINYINT(3),
    Nombre VARCHAR(55),
    Marca VARCHAR(20),
    Stock INT(10),
    UniMedida INT(10)
);

CREATE TABLE Ingresos (
    Id_Ingreso INT(10) AUTO_INCREMENT PRIMARY KEY,
    Id_Admin VARCHAR(15),
    Fecha DATE,
    Observaciones VARCHAR(255)
);

CREATE TABLE IngresosInsumos (
    IngresosIdIngreso INT(10),
    InsumosIdInsumos TINYINT(3),
    unidadMedida VARCHAR(15),
    cantidad INT(10),
    PRIMARY KEY (IngresosIdIngreso, InsumosIdInsumos)
);

CREATE TABLE Producto (
    idPro TINYINT(3) AUTO_INCREMENT PRIMARY KEY,
    nomPro VARCHAR(55),
    valor INT(10),
    imgProdu VARCHAR(255)
);

CREATE TABLE InsumosProducto (
    ProductoIdPro TINYINT(3),
    InsumosIdInsumos TINYINT(3),
    UniMedida VARCHAR(255),
    Cantidad INT(10),
    PRIMARY KEY (ProductoIdPro, InsumosIdInsumos)
);

CREATE TABLE Factura (
    id_factura INT(10) AUTO_INCREMENT PRIMARY KEY,
    idEmpleado VARCHAR(15),
    idCliente VARCHAR(15),
    fecha TIMESTAMP,
    total INT(10)
);

CREATE TABLE ProductoFactura (
    ProductoidPro TINYINT(3),
    idFactura INT(10),
    Cantidad INT(10),
    Valor INT(10),
    PRIMARY KEY (ProductoidPro, idFactura)
);

CREATE TABLE Mesa (
    idMesa TINYINT(3) AUTO_INCREMENT PRIMARY KEY,
    disponibilidad BIT,
    cupo TINYINT(3)
);

CREATE TABLE Estado (
    idEstado INT(10) AUTO_INCREMENT PRIMARY KEY,
    NombreEstado VARCHAR(255)
);

CREATE TABLE Reserva (
    Id_Reserva INT(10) AUTO_INCREMENT PRIMARY KEY,
    idCliente varchar(15),
    fechaAgenReserva DATE,
    fechaDiaReserva TIMESTAMP,
    numeroPersonas TINYINT(3),
    idEstado INT(10)
);

CREATE TABLE Reserva_Mesa (
    IdReserva INT(10),
    IdMesa TINYINT(3),
    PRIMARY KEY (IdReserva, IdMesa)
);

CREATE TABLE Pedido (
    idPedido INT(10) AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP,
    Estado TINYINT(3),
    idMesa TINYINT(3)
);

CREATE TABLE PedidoProducto (
    idPedido INT(10),
    productoIdPro TINYINT(3),
    Cantidad INT(10),
    valor INT(10),
    PRIMARY KEY (idPedido, productoIdPro)
);

-- 2. Claves foráneas

ALTER TABLE Usuario
    ADD CONSTRAINT fk_usuario_rol FOREIGN KEY (idRol) REFERENCES Rol(idRol),
    ADD CONSTRAINT fk_usuario_tipdoc FOREIGN KEY (idTipDoc) REFERENCES TipDoc(idTipDoc);

ALTER TABLE Insumos
    ADD CONSTRAINT fk_insumos_categoria FOREIGN KEY (CategoriaIdCategoria) REFERENCES Categoria(idCategoria);

ALTER TABLE Ingresos
    ADD CONSTRAINT fk_ingresos_admin FOREIGN KEY (Id_Admin) REFERENCES Usuario(documento);

ALTER TABLE IngresosInsumos
    ADD CONSTRAINT fk_ii_ingreso FOREIGN KEY (IngresosIdIngreso) REFERENCES Ingresos(Id_Ingreso),
    ADD CONSTRAINT fk_ii_insumo FOREIGN KEY (InsumosIdInsumos) REFERENCES Insumos(idInsumos);

ALTER TABLE InsumosProducto
    ADD CONSTRAINT fk_ip_producto FOREIGN KEY (ProductoIdPro) REFERENCES Producto(idPro),
    ADD CONSTRAINT fk_ip_insumo FOREIGN KEY (InsumosIdInsumos) REFERENCES Insumos(idInsumos);

ALTER TABLE Factura
    ADD CONSTRAINT fk_factura_empleado FOREIGN KEY (idEmpleado) REFERENCES Usuario(documento),
    ADD CONSTRAINT fk_factura_cliente FOREIGN KEY (idCliente) REFERENCES Usuario(documento);

ALTER TABLE ProductoFactura
    ADD CONSTRAINT fk_pf_producto FOREIGN KEY (ProductoidPro) REFERENCES Producto(idPro),
    ADD CONSTRAINT fk_pf_factura FOREIGN KEY (idFactura) REFERENCES Factura(id_factura);

ALTER TABLE Reserva
    ADD CONSTRAINT fk_reserva_cliente FOREIGN KEY (idCliente) REFERENCES Usuario(documento),
    ADD CONSTRAINT fk_reserva_estado FOREIGN KEY (idEstado) REFERENCES Estado(idEstado);

ALTER TABLE Reserva_Mesa
    ADD CONSTRAINT fk_rm_reserva FOREIGN KEY (IdReserva) REFERENCES Reserva(Id_Reserva),
    ADD CONSTRAINT fk_rm_mesa FOREIGN KEY (IdMesa) REFERENCES Mesa(idMesa);

ALTER TABLE Pedido
    ADD CONSTRAINT fk_pedido_mesa FOREIGN KEY (idMesa) REFERENCES Mesa(idMesa);

ALTER TABLE PedidoProducto
    ADD CONSTRAINT fk_pp_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    ADD CONSTRAINT fk_pp_producto FOREIGN KEY (productoIdPro) REFERENCES Producto(idPro);
