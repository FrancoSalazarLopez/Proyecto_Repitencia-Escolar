INSERT INTO zona (zona)
  VALUES  
    ("sur"),
    ("oeste"),
    ("norte"),
    ("suroeste"),
    ("interior");

-- ------------------------------------------------------------------------------------------------------------------------------------------ --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stg_dolar.csv' 
INTO TABLE stg_dolar
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS

-- ------------------------------------------------------------------------------------------------------------------------------------------- --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stg_inversion.csv' 
INTO TABLE stg_inversion
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(anio,mes,municipio_id,municipio_nombre,concepto,monto);
-----------------------------------------------------------------------------------------------------------------------------------------------

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stg_poblacion.csv' 
INTO TABLE stg_poblacion
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(municipio_id,municipio_nombre,anio,poblacion);
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

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stg_repitencia.csv' 
INTO TABLE stg_repitencia
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(anio, municipio_id, municipio_nombre, promocion_efectiva_primaria, promocion_efectiva_secundaria, repitencia_primaria, repitencia_secundaria,
reinscripcion_primaria, reinscripcion_secundaria, abandono_interanual_primaria, abandono_interanual_secundaria, alumnos_promovidos_primaria,
alumnos_promovidos_secundaria, alumnos_no_promovidos_primaria, alumnos_no_promovidos_secundaria, salidos_sin_pase_primaria, salidos_sin_pase_secundaria, 
salidos_con_pase_primaria, salidos_con_pase_secundaria, sobreedad_primaria, sobreedad_secundaria, sobreedad_avanzada_primaria,sobreedad_avanzada_secundaria);

