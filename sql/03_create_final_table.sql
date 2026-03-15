CREATE TABLE fact_inversion
SELECT 
	i.anio,
    m.id_zona,
    CAST(SUM(i.monto/d.valor) AS DECIMAL(15,0)) AS inversion_educativa_usd
FROM stg_inversion i

INNER JOIN stg_dolar d ON i.anio=d.anio
INNER JOIN stg_localizacion_municipios m ON i.municipio_id=m.municipio_id

WHERE i.anio between 2013 and 2022 and i.concepto="Fondo Financiamiento Educativo"
GROUP BY i.anio,m.id_zona
ORDER BY i.anio ASC, m.id_zona ASC;

---------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE fact_poblacion
SELECT 
	p.anio,
    m.id_zona,
    SUM(p.poblacion) AS poblacion_total
FROM stg_poblacion p

INNER JOIN stg_localizacion_municipios m ON p.municipio_id=m.municipio_id

WHERE p.anio between 2013 and 2022 
GROUP BY p.anio,m.id_zona
ORDER BY p.anio ASC,m.id_zona ASC;

---------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE fact_colegios
SELECT 
	c.anio,
    m.id_zona,
	SUM(c.unidades_de_servicio_nivel_inicial) as unidades_de_servicio_nivel_inicial,
	SUM(c.unidades_de_servicio_nivel_primario) as unidades_de_servicio_nivel_primario,
    SUM(c.unidades_de_servicio_nivel_secundario) as unidades_de_servicio_nivel_secundario,
    SUM(c.sector_de_gestión_estatal) as sector_de_gestion_estatal,
    SUM(c.sector_de_gestión_privada) as sector_de_gestion_privada,
    SUM(c.matricula_nivel_inicial) as matricula_nivel_inicial,
    SUM(c.matricula_nivel_primario) as matricula_nivel_primario,
    SUM(c.matricula_nivel_secundario) as matricula_nivel_secundario,
    SUM(c.matricula_sexo_masculino) as matricula_sexo_masculino,
    SUM(c.matricula_sexo_femenino) as matricula_sexo_femenino
FROM stg_colegios c

INNER JOIN stg_localizacion_municipios m ON c.municipio_id=m.municipio_id

WHERE anio between 2013 and 2022
GROUP BY c.anio,m.id_zona
ORDER BY c.anio ASC,m.id_zona ASC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE fact_repitencia
SELECT 
	r.anio,
	m.id_zona,
	CAST(AVG(r.promocion_efectiva_primaria) AS DECIMAL(10,2)) AS promocion_efectiva_primaria,
    CAST(AVG(r.promocion_efectiva_secundaria) AS DECIMAL(10,2)) AS promocion_efectiva_secundaria,
    CAST(AVG(r.repitencia_primaria) AS DECIMAL(10,2)) AS repitencia_primaria,
    CAST(AVG(r.repitencia_secundaria) AS DECIMAL(10,2)) AS repitencia_secundaria,
    CAST(AVG(r.reinscripcion_primaria) AS DECIMAL(10,2)) AS reinscripcion_primaria,
    CAST(AVG(r.reinscripcion_secundaria) AS DECIMAL(10,2)) AS reinscripcion_secundaria,
    CAST(AVG(r.abandono_interanual_primaria) AS DECIMAL(10,2)) AS abandono_interanual_primaria,
    CAST(AVG(r.abandono_interanual_secundaria) AS DECIMAL(10,2)) AS abandono_interanual_secundaria,
    CAST(AVG(r.alumnos_promovidos_primaria) AS DECIMAL(10,2)) AS alumnos_promovidos_primaria,
    CAST(AVG(r.alumnos_promovidos_secundaria) AS DECIMAL(10,2)) AS alumnos_promovidos_secundaria,
    CAST(AVG(r.alumnos_no_promovidos_primaria) AS DECIMAL(10,2)) AS alumnos_no_promovidos_primaria,
    CAST(AVG(r.alumnos_no_promovidos_secundaria) AS DECIMAL(10,2)) AS alumnos_no_promovidos_secundaria,
    CAST(AVG(r.salidos_sin_pase_primaria) AS DECIMAL(10,2)) AS salidos_sin_pase_primaria,
    CAST(AVG(r.salidos_sin_pase_secundaria) AS DECIMAL(10,2)) AS salidos_sin_pase_secundaria,
    CAST(AVG(r.salidos_con_pase_primaria) AS DECIMAL(10,2)) AS salidos_con_pase_primaria,
    CAST(AVG(r.salidos_con_pase_secundaria) AS DECIMAL(10,2)) AS salidos_con_pase_secundaria,
    CAST(AVG(r.sobreedad_primaria) AS DECIMAL(10,2)) AS sobreedad_primaria,
    CAST(AVG(r.sobreedad_secundaria) AS DECIMAL(10,2)) AS sobreedad_secundaria,
    CAST(AVG(r.sobreedad_avanzada_primaria) AS DECIMAL(10,2)) AS sobreedad_avanzada_primaria,
    CAST(AVG(r.sobreedad_avanzada_secundaria) AS DECIMAL(10,2)) AS sobreedad_avanzada_secundaria
FROM stg_repitencia r

INNER JOIN stg_localizacion_municipios m USING(municipio_id)

WHERE anio between 2013 and 2022
GROUP BY r.anio,m.id_zona
ORDER BY r.anio ASC,m.id_zona ASC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE fact_analisis_general
SELECT 
    r.anio,
    SUM(c.unidades_de_servicio_nivel_inicial + c.unidades_de_servicio_nivel_primario + c.unidades_de_servicio_nivel_secundario) as colegios_totales,
    SUM(c.matricula_nivel_inicial + c.matricula_nivel_primario + c.matricula_nivel_secundario) as matricula_total,
    SUM(c.matricula_nivel_inicial) as matricula_inicial,
    SUM(c.matricula_nivel_primario) as matricula_primaria,
    SUM(c.matricula_nivel_secundario) as matricula_secundaria,
    SUM(i.inversion_educativa_usd) as inversion_total,
    CAST(AVG(r.repitencia_primaria) AS DECIMAL(10,2)) as repitencia_primaria,
    CAST(AVG(r.repitencia_secundaria) AS DECIMAL(10,2)) as repitencia_secundaria 
FROM fact_repitencia r

INNER JOIN fact_colegios c ON r.id_zona=c.id_zona AND r.anio=c.anio 
INNER JOIN fact_inversion i ON r.id_zona=i.id_zona AND r.anio=i.anio 
GROUP BY r.anio;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE jup_alumnos_colegios
SELECT
  	c.anio,
  	z.zona,
    c.unidades_de_servicio_nivel_inicial,
  	c.unidades_de_servicio_nivel_primario,
  	c.unidades_de_servicio_nivel_secundario,
  	c.sector_de_gestion_estatal,
  	c.sector_de_gestion_privada,
  	c.matricula_nivel_inicial,
  	c.matricula_nivel_primario,
  	c.matricula_nivel_secundario,
  	c.matricula_sexo_masculino,
  	c.matricula_sexo_femenino,
    (c.matricula_nivel_inicial + c.matricula_nivel_primario + c.matricula_nivel_secundario) as matricula_total
FROM fact_colegios c
INNER JOIN stg_zona z ON c.id_zona=z.id
ORDER BY c.anio ASC, z.zona ASC;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE jup_repitencia
SELECT 
	r.anio,
    z.zona,
	r.promocion_efectiva_primaria, 
	r.promocion_efectiva_secundaria,
	r.repitencia_primaria, 
	r.repitencia_secundaria,
	r.reinscripcion_primaria,
	r.reinscripcion_secundaria,
	r.abandono_interanual_primaria,
	r.abandono_interanual_secundaria,
	r.alumnos_promovidos_primaria,
	r.alumnos_promovidos_secundaria,
	r.alumnos_no_promovidos_primaria,
	r.alumnos_no_promovidos_secundaria,
	r.salidos_sin_pase_primaria,
	r.salidos_sin_pase_secundaria,
	r.salidos_con_pase_primaria ,
	r.salidos_con_pase_secundaria ,
	r.sobreedad_primaria ,
	r.sobreedad_secundaria ,
	r.sobreedad_avanzada_primaria,
	r.sobreedad_avanzada_secundaria
FROM fact_repitencia r
	
INNER JOIN stg_zona z ON r.id_zona=z.id
ORDER BY r.anio ASC, z.zona ASC;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE jup_inversion_poblacion
SELECT 
	p.anio,
    z.zona,
	p.poblacion_total,
    CAST(i.inversion_educativa_usd /(c.matricula_nivel_inicial + c.matricula_nivel_primario + c.matricula_nivel_secundario)AS DECIMAL (5,2)) AS inversion_alumno,
    i.inversion_educativa_usd
FROM fact_poblacion p
	
INNER JOIN stg_zona z ON p.id_zona = z.id
INNER JOIN fact_inversion i ON p. id_zona = i.id_zona AND p.anio=i.anio	
INNER JOIN fact_colegios c ON p.id_zona = c.id_zona AND p.anio=c.anio
	
ORDER BY p.anio ASC, z.zona ASC;

