INSERT INTO zona (zona)
  VALUES  
    ("sur"),
    ("oeste"),
    ("norte"),
    ("suroeste"),
    ("interior");

----------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO stg_localizacion_municipios (municipio_id,municipio_nombre,id_zona)
VALUES
-- Zona 1: Sur
    (6028, 'Almirante Brown', 1), (6035, 'Avellaneda', 1), (6658, 'Quilmes', 1), (6434, 'Lanus', 1), 
    (6287, 'Florencio Varela', 1), (6091, 'Berazategui', 1), (6490, 'Lomas de Zamora', 1), (6260, 'Esteban Echeverria', 1), 
    (6274, 'Ezeiza', 1),
    -- Zona 2: Oeste 
    (6410, 'Ituzaingo', 2), (6568, 'Moron', 2), (6408, 'Hurlingham', 2), 
    (6539, 'Merlo', 2), (6560, 'Moreno', 2),
    -- Zona 3: Norte
    (6742, 'San Isidro', 3), (6847, 'Vicente Lopez', 3), (6371, 'General San Martin', 3), 
    (6762, 'San Miguel', 3), (6515, 'Malvinas Argentinas', 3), (6734, 'San Fernando', 3), (6805, 'Tigre', 3),
    -- Zona 4: La Matanza 
    (6427, 'La Matanza', 4),
    -- Zona 5: Resto de los 40 municipios del AMBA 
    (6098, 'Berisso', 5), (6119, 'Brandsen', 5), (6126, 'Campana', 5), (6134, 'Cañuelas', 5), (6245, 'Ensenada', 5), (6252, 'Escobar', 5), 
    (6266, 'Exaltación de la Cruz', 5), (6329, 'General Las Heras', 5), (6364, 'General Rodríguez', 5), (6412, 'José C. Paz', 5), 
    (6441, 'La Plata', 5), (6497, 'Luján', 5), (6525, 'Marcos Paz', 5), (6622, 'Pilar', 5), (6636, 'Presidente Perón', 5), (6769, 'San Vicente', 5), 
    (6822, 'Tres de Febrero', 5), (6854, 'Zárate', 5);

----------------------------------------------------------------------------------------------------------------------------------------------------
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

