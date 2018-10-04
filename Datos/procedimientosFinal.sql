SELECT * FROM bdc.bdc_agente;
SELECT * FROM BDC.BDC_Agente_Auxiliar;

-- ****************************************************************************************************************************
LOAD DATA LOCAL INFILE 'C:/Users/krist/Desktop/agentes.csv' INTO table BDC.BDC_Agente_Auxiliar FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET SQL_SAFE_UPDATES = 0;
use BDC;
DELIMITER //
CREATE PROCEDURE cargarAgentes()
BEGIN
	-- Actualiza los productos que ya estaban
	update bdc.bdc_agente, BDC.BDC_Agente_Auxiliar 
	set bdc.bdc_agente.nombre = BDC.BDC_Agente_Auxiliar.nombre,
    bdc.bdc_agente.zona = BDC.BDC_Agente_Auxiliar.zona,
    bdc.bdc_agente.estatus = BDC.BDC_Agente_Auxiliar.estatus,
    bdc.bdc_agente.telefono = BDC.BDC_Agente_Auxiliar.telefono
	where bdc.bdc_agente.codigo = BDC.BDC_Agente_Auxiliar.codigo;


	-- Borra de la tabla los clientes que ya están en la tabla general
	delete from BDC.BDC_Agente_Auxiliar where 
	exists (select bdc.bdc_agente.codigo from bdc.bdc_agente
	where BDC.BDC_Agente_Auxiliar.codigo=bdc.bdc_agente.codigo);

	-- Inserta los nuevos productos en la tabla, los que no habían estado nunca en la base
	INSERT INTO bdc.bdc_agente
	SELECT * FROM BDC.BDC_Agente_Auxiliar;
    
    -- Borra los datos de la tabla de producto auxiliar
    delete from BDC.BDC_Agente_Auxiliar;
END
//
DELIMITER ;

drop procedure cargarAgentes;
call cargarAgentes();


-- -------------------------------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE 'C:/Users/krist/Desktop/productos.csv' INTO table BDC.BDC_Producto_Auxiliar FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 2 ROWS;


-- BDC_Producto
-- BDC_Producto_Auxiliar
SELECT * FROM BDC_Producto;
SELECT * FROM BDC_Producto_Auxiliar;


SET SQL_SAFE_UPDATES = 0;
use BDC;
DELIMITER //
CREATE PROCEDURE SPRO_cargar_productos()
BEGIN
	-- Actualiza los productos que ya estaban
	update BDC.BDC_Producto, BDC.BDC_Producto_Auxiliar 
	set BDC.BDC_Producto.categoria = BDC.BDC_Producto_Auxiliar.categoria,
	BDC.BDC_Producto.material = BDC.BDC_Producto_Auxiliar.material,
	BDC.BDC_Producto.talla = BDC.BDC_Producto_Auxiliar.talla,
	BDC.BDC_Producto.descripcion = BDC.BDC_Producto_Auxiliar.descripcion,
	BDC.BDC_Producto.estado = BDC.BDC_Producto_Auxiliar.estado,
	BDC.BDC_Producto.inventario = BDC.BDC_Producto_Auxiliar.inventario
	where BDC.BDC_Producto.codigo = BDC.BDC_Producto_Auxiliar.codigo;

	-- Borra de la tabla los productos que ya están en la tabla general
	delete from BDC.BDC_Producto_Auxiliar where 
	exists (select BDC.BDC_Producto.codigo from BDC.BDC_Producto 
	where BDC.BDC_Producto_Auxiliar.codigo=BDC.BDC_Producto.codigo);

	-- Inserta los nuevos productos en la tabla, los que no habían estado nunca en la base
	INSERT INTO BDC.BDC_Producto
	SELECT codigo, categoria, material, talla, descripcion, estado, inventario
    FROM BDC.BDC_Producto_Auxiliar;

    
    -- Borra los datos de la tabla de producto auxiliar
    delete from BDC.BDC_Producto_Auxiliar;
END
//
DELIMITER ;


drop procedure SPROC_cargar_productos;
call SPRO_cargar_productos();
 -- *************************************************************************************************************************
 
 -- ****************************************************************************************************************************
 
 LOAD DATA LOCAL INFILE 'C:/Users/krist/Desktop/clientes.csv' INTO table BDC.BDC_Cliente_Auxiliar FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- BDC.BDC_Cliente
-- BDC.BDC_Cliente_Auxiliar
SELECT * FROM BDC.BDC_Cliente; 
SELECT * FROM BDC.BDC_Cliente_Auxiliar;

SET SQL_SAFE_UPDATES = 0;
use BDC;
DELIMITER //
CREATE PROCEDURE SPRO_cargar_clientes()
BEGIN
	-- Actualiza los productos que ya estaban
	update BDC.BDC_Cliente, BDC.BDC_Cliente_Auxiliar 
	set BDC.BDC_Cliente.vendedor = BDC.BDC_Cliente_Auxiliar .vendedor,
    BDC.BDC_Cliente.nombre = BDC.BDC_Cliente_Auxiliar .nombre,
    BDC.BDC_Cliente.poblacion = BDC.BDC_Cliente_Auxiliar .poblacion,
    BDC.BDC_Cliente.codigo = BDC.BDC_Cliente_Auxiliar .codigo,
    BDC.BDC_Cliente.nombre2 = BDC.BDC_Cliente_Auxiliar .nombre2,
    BDC.BDC_Cliente.calle = BDC.BDC_Cliente_Auxiliar .calle,
    BDC.BDC_Cliente.poblacion2 = BDC.BDC_Cliente_Auxiliar .poblacion2,
    BDC.BDC_Cliente.region = BDC.BDC_Cliente_Auxiliar .region,
    BDC.BDC_Cliente.telefono = BDC.BDC_Cliente_Auxiliar .telefono
	where BDC.BDC_Cliente.cliente = BDC.BDC_Cliente_Auxiliar .cliente;


	-- Borra de la tabla los clientes que ya están en la tabla general
	delete from BDC.BDC_Cliente_Auxiliar where 
	exists (select BDC.BDC_Cliente.cliente from BDC.BDC_Cliente
	where BDC.BDC_Cliente_Auxiliar.cliente=BDC.BDC_Cliente.cliente);

	-- Inserta los nuevos productos en la tabla, los que no habían estado nunca en la base
	INSERT INTO BDC.BDC_Cliente
	SELECT * FROM BDC.BDC_Cliente_Auxiliar;
    
    -- Borra los datos de la tabla de producto auxiliar
    delete from BDC.BDC_Cliente_Auxiliar;
END
//
DELIMITER ;

drop procedure SPRO_cargar_clientes;
call SPRO_cargar_clientes();

-- ***************************************************************************************************************************