CREATE TABLE stg_zona 
    (id int auto_increment,
     zona varchar(10),
     primary key(id));

-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE stg_dolar(
	 anio INT,
     valor DECIMAL(10,2));

-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE stg_inversion (
    anio INT,
    mes INT,
    municipio_id INT,
    concepto VARCHAR(50),
    monto FLOAT);

-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE stg_poblacion (
	municipio_id FLOAT,
    municipio_nombre VARCHAR(50), 
	anio INT,
    poblacion INT,
	id_zona INT,
	FOREIGN KEY (id_zona) REFERENCES zona(id));

-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE stg_colegios (
  anio INT,
  municipio_id INT,
  unidades_de_servicio_nivel_inicial INT,
  unidades_de_servicio_nivel_primario INT,
  unidades_de_servicio_nivel_secundario INT,
  sector_de_gestión_estatal INT,
  sector_de_gestión_privada INT,
  matricula_sexo_femenino INT,
  matricula_sexo_masculino INT,
  matricula_nivel_inicial INT,
  matricula_nivel_primario INT,
  matricula_nivel_secundario INT);

-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE stg_repitencia (
  anio INT,
  municipio_id INT,
  promocion_efectiva_primaria DECIMAL(10,2),
  promocion_efectiva_secundaria DECIMAL(10,2),
  repitencia_primaria DECIMAL(10,2),
  repitencia_secundaria DECIMAL(10,2),
  reinscripcion_primaria DECIMAL(10,2),
  reinscripcion_secundaria DECIMAL(10,2),
  abandono_interanual_primaria DECIMAL(10,2),
  abandono_interanual_secundaria DECIMAL(10,2),
  alumnos_promovidos_primaria DECIMAL(10,2),
  alumnos_promovidos_secundaria DECIMAL(10,2),
  alumnos_no_promovidos_primaria DECIMAL(10,2),
  alumnos_no_promovidos_secundaria DECIMAL(10,2),
  salidos_sin_pase_primaria DECIMAL(10,2),
  salidos_sin_pase_secundaria DECIMAL(10,2),
  salidos_con_pase_primaria DECIMAL(10,2),
  salidos_con_pase_secundaria DECIMAL(10,2),
  sobreedad_primaria DECIMAL(10,2),
  sobreedad_secundaria DECIMAL(10,2),
  sobreedad_avanzada_primaria DECIMAL(10,2),
  sobreedad_avanzada_secundaria DECIMAL(10,2));
