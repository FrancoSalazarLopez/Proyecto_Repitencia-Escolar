LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stg_inversion.csv' 
INTO TABLE stg_inversion
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(anio,mes,municipio_id,municipio_nombre,concepto,monto);
-----------------------------------------------------------------------------------------------------------------------------------------------

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stg_colegios.csv' 
INTO TABLE stg_colegios
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(anio, municipio_id, municipio_nombre, unidades_de_servicio_nivel_inicial, unidades_de_servicio_nivel_primario,
unidades_de_servicio_nivel_secundario, sector_de_gestión_estatal, sector_de_gestión_privada, matricula_sexo_femenino, 
matricula_sexo_masculino, matricula_nivel_inicial, matricula_nivel_primario, matricula_nivel_secundario);
-----------------------------------------------------------------------------------------------------------------------------------------------
