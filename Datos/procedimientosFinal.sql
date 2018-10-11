SELECT * FROM bdc.bdc_agente;
SELECT * FROM BDC.BDC_Agente_Auxiliar;

-- ****************************************************************************************************************************
LOAD DATA LOCAL INFILE 'C:/Users/HP/OneDrive/Universidad/2018 II/EIF 401 Inge II/Datos reales/agentes.csv' INTO table BDC.BDC_Agente_Auxiliar FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET SQL_SAFE_UPDATES = 0;
use BDC;
DELIMITER //
CREATE PROCEDURE SPRO_cargar_agentes()
BEGIN

	-- Elimina todos los agentes de la tabla agentes
    delete from bdc.bdc_agente;
	-- Actualiza los productos que ya estaban
	-- update bdc.bdc_agente, BDC.BDC_Agente_Auxiliar 
	-- set bdc.bdc_agente.nombre = BDC.BDC_Agente_Auxiliar.nombre,
    -- bdc.bdc_agente.zona = BDC.BDC_Agente_Auxiliar.zona,
    -- bdc.bdc_agente.estatus = BDC.BDC_Agente_Auxiliar.estatus,
    -- bdc.bdc_agente.telefono = BDC.BDC_Agente_Auxiliar.telefono
	-- where bdc.bdc_agente.codigo = BDC.BDC_Agente_Auxiliar.codigo;


	-- Inserta los nuevos productos en la tabla, los que no habían estado nunca en la base
	INSERT INTO bdc.bdc_agente
	SELECT * FROM BDC.BDC_Agente_Auxiliar;
    -- Borra los datos de la tabla de producto auxiliar
    delete from BDC.BDC_Agente_Auxiliar;
END
//
DELIMITER ;

drop procedure SPRO_cargar_agentes;
call SPRO_cargar_agentes();


-- -------------------------------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE 'C:/Users/HP/OneDrive/Universidad/2018 II/EIF 401 Inge II/Datos reales/productos.csv' INTO table BDC.BDC_Producto_Auxiliar FIELDS TERMINATED BY ';'
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
	-- Borra todos los elementos de la tabla productos
    delete from BDC.BDC_Producto;

	-- Inserta los nuevos productos se insertan en la tabla productos
	INSERT INTO BDC.BDC_Producto
	SELECT codigo, categoria, material, talla, descripcion, estado, inventario
    FROM BDC.BDC_Producto_Auxiliar;

    -- Borra los datos de la tabla de producto auxiliar
    delete from BDC.BDC_Producto_Auxiliar;
END
//
DELIMITER ;

drop procedure SPRO_cargar_productos;
call SPRO_cargar_productos();
 -- *************************************************************************************************************************
 
 -- ****************************************************************************************************************************
 
LOAD DATA LOCAL INFILE 'C:/Users/HP/OneDrive/Universidad/2018 II/EIF 401 Inge II/Datos reales/clientes.csv' INTO table BDC.BDC_Cliente_Auxiliar FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- BDC.BDC_Cliente
-- BDC.BDC_Cliente_Auxiliar
SELECT * FROM BDC.BDC_Cliente; 
SELECT * FROM BDC.BDC_Cliente_Auxiliar;

select count(*) from  BDC.BDC_Cliente;

SET SQL_SAFE_UPDATES = 0;
use BDC;
DELIMITER //
CREATE PROCEDURE SPRO_cargar_clientes()
BEGIN

	-- Borra la información de la tabla clientes
	delete from BDC.BDC_Cliente;

	-- Inserta los nuevos clientes en la tabla general de clientes
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