CREATE DATABASE IF NOT EXISTS BDC DEFAULT CHARACTER SET utf8;


use BDC;
create table BDC_Producto (
  codigo varchar(245),
  categoria varchar(245),
  material varchar(245),
  talla varchar(245),
  descripcion varchar(245),
  estado varchar(245),
  inventario varchar(245),
  constraint PK_BDC_Producto primary key (codigo)
);

use BDC;
create table BDC_Producto_Auxiliar (
  categoria varchar(245),
  codigo varchar(245),
  material varchar(245),
  talla varchar(245),
  descripcion varchar(245),
  estado varchar(245),
  inventario varchar(245),
  constraint PK_BDC_Producto_Auxiliar primary key (codigo)
);


use BDC;
create table BDC_Cliente (
  cliente varchar(245),
  vendedor varchar(245),
  nombre varchar(245),
  poblacion varchar(245),
  codigo varchar(245),
  nombre2 varchar(245),
  calle varchar(245),
  poblacion2 varchar(245),
  region varchar(245),
  telefono varchar(245),
  constraint PK_BDC_Cliente primary key (cliente)
);

use BDC;
create table BDC_Cliente_Auxiliar (
  cliente varchar(245),
  vendedor varchar(245),
  nombre varchar(245),
  poblacion varchar(245),
  codigo varchar(245),
  nombre2 varchar(245),
  calle varchar(245),
  poblacion2 varchar(245),
  region varchar(245),
  telefono varchar(245),
  constraint PK_BDC_Cliente_Auxiliar primary key (cliente)
);

use BDC;
create table BDC_Agente(
	codigo varchar(245),
	nombre varchar(245),
	zona varchar(245),
	estatus varchar(245),
	telefono varchar(245),
    constraint PK_BDC_Agente primary key (codigo)
);

use BDC;
create table BDC_Agente_Auxiliar(
	codigo varchar(245),
	nombre varchar(245),
	zona varchar(245),
	estatus varchar(245),
	telefono varchar(245),
    constraint PK_BDC_Agente_Auxiliar primary key (codigo)
);


use BDC;
create table BDC_Usuario_Agente(
	codigo_Agente varchar(245),
    contrasena varchar(245),
    constraint PK_BDC_Usuario_Agente primary key (codigo_Agente),
    constraint FK0_BDC_Usuario_Agente foreign key (codigo_Agente) references BDC.BDC_Agente (codigo)
);

-- create table BDC_Usuario_Administrador(
-- 	codigo_Agente varchar(245),
--    contrasena varchar(245),
--    constraint PK_BDC_Usuario_Administrador primary key (codigo_Agente),
--    constraint FK0_BDC_Usuario_Administrador foreign key (codigo_Agente) references BDC.BDC_Administrador (identificacion)
-- );


create table BDC_Super_Usuario(
	codigo varchar(245),
    clave varchar(245),
    tipo varchar(245),
    constraint PK_BDC_Super_Usuario primary key (codigo)
);

-- Hay problemas con los fk constraints


use BDC;
create table BDC_Pedido(
	codigo varchar(245),
    fecha date,
    agente varchar(245),
    cliente varchar(245),
    estado int, -- (0-> venta 1->reserva)
    constraint PK_BDC_Pedido primary key (codigo),
    constraint FK0_BDC_Pedido_Agente foreign key (agente) references BDC.BDC_Agente (codigo),
    constraint FK1_BDC_Pedido_Cliente foreign key (cliente) references BDC.BDC_Cliente (cliente)  
);


use BDC;
create table BDC_Detalle_Pedido(
	pedido varchar(245),
    producto varchar(245),
    constraint FK0_BDC_Pedido foreign key (pedido) references BDC.BDC_Pedido (codigo),
    constraint FK1_BDC_Producto foreign key (producto) references BDC.BDC_Producto (codigo)
);


use BDC;
create table BDC_Administrador(
	identificacion varchar(245),
    nombre varchar(245),
    constraint PK_BDC_Administrador  primary key (identificacion)
);


use BDC;
create table BDC_Venta(
	codigo varchar(245),
    estado int, -- (concretada, enEspera)
    pedido varchar(245),
    constraint PK_BDC_Venta primary key (codigo),
    constraint FK0_BDC_Venta_Pedido foreign key (pedido) references BDC.BDC_Pedido (codigo)
);


use BDC;
create table BDC_Reserva(
	codigo varchar(245),
    fecha_inicio date,
    fecha_limite date, -- (30 días)
    pedido varchar(245),
    constraint PK_BDC_Reserva primary key (codigo),
    constraint FK0_BDC_Reserva_Pedido foreign key (pedido) references BDC.BDC_Pedido (codigo)
);

use BDC;
create table BDC_Img_Producto(
    imagen varchar(245),
    producto varchar(245),
    constraint PK_BDC_Img_Producto primary key (producto),
    constraint PK_BDC_Img_Producto foreign key (producto) references BDC.BDC_Producto (codigo)
);