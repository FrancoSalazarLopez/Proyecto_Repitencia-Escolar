CREATE TABLE fact_inversion
SELECT 
	i.anio,
    m.id_zona,
    CAST(SUM(i.monto/d.valor) AS DECIMAL(15,0)) AS inversion_educativa_usd
FROM stg_inversion i

INNER JOIN stg_dolar d ON i.anio=d.anio
INNER JOIN stg_localizacion_municipios m ON i.municipio_id=m.municipio_id

WHERE i.anio BETWEEN 2013 and 2022 and i.concepto="Fondo Financiamiento Educativo"
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

WHERE p.anio BETWEEN 2013 and 2022 
GROUP BY p.anio,m.id_zona
ORDER BY p.anio ASC,m.id_zona ASC;

---------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE fact_colegios
SELECT anio,
	CASE 
		 WHEN municipio_nombre IN ('San Isidro', 'Vicente Lopez', 'General San Martin','San Miguel','Malvinas Argentinas','San Fernando', 'Tigre') THEN 3
		 WHEN municipio_nombre IN ('Ituzaingo','Moron', 'Hurlingham', 'Merlo', 'Moreno') THEN 2
		 WHEN municipio_nombre IN ('Almirante Brown', 'Avellaneda', 'Quilmes', 'Lanus', 'Florencio Varela', 'Berazategui', 'Lomas de Zamora', 'Esteban Echeverria','Ezeiza') THEN 1
		 WHEN municipio_nombre='La Matanza' THEN 4
		 ELSE 5
  END AS id_zona,
	  SUM(unidades_de_servicio_nivel_inicial) as unidades_de_servicio_nivel_inicial,
	  SUM(unidades_de_servicio_nivel_primario) as unidades_de_servicio_nivel_primario,
    SUM(unidades_de_servicio_nivel_secundario) as unidades_de_servicio_nivel_secundario,
    SUM(sector_de_gestión_estatal) as sector_de_gestion_estatal,
    SUM(sector_de_gestión_privada) as sector_de_gestion_privada,
    SUM(matricula_nivel_inicial) as matricula_nivel_inicial,
    SUM(matricula_nivel_primario) as matricula_nivel_primario,
    SUM(matricula_nivel_secundario) as matricula_nivel_secundario,
    SUM(matricula_sexo_masculino) as matricula_sexo_masculino,
    SUM(matricula_sexo_femenino) as matricula_sexo_femenino
FROM stg_colegios_2
WHERE (anio between 2013 and 2022) and municipio_nombre in ("Almirante Brown", "Avellaneda", "Berazategui", "Berisso", "Brandsen", 
    "Campana", "Cañuelas", "Ensenada", "Escobar", "Esteban Echeverría", "Exaltación de la Cruz", "Ezeiza", "Florencio Varela", "General Las Heras", 
    "General Rodríguez", "General San Martín", "Hurlingham", "Ituzaingó", "José C. Paz", "La Matanza", "La Plata", "Lanús", "Lomas de Zamora", 
    "Luján", "Malvinas Argentinas", "Marcos Paz", "Merlo", "Moreno", "Morón", "Pilar", "Presidente Perón", "Quilmes", "San Fernando", 
    "San Isidro", "San Miguel", "San Vicente", "Tigre", "Tres de Febrero", "Vicente López", "Zárate")
GROUP BY anio, 
		CASE 
		 WHEN municipio_nombre IN ('San Isidro', 'Vicente Lopez', 'General San Martin','San Miguel','Malvinas Argentinas','San Fernando', 'Tigre') THEN 3
		 WHEN municipio_nombre IN ('Ituzaingo','Moron', 'Hurlingham', 'Merlo', 'Moreno') THEN 2
		 WHEN municipio_nombre IN ('Almirante Brown', 'Avellaneda', 'Quilmes', 'Lanus', 'Florencio Varela', 'Berazategui', 'Lomas de Zamora', 'Esteban Echeverria','Ezeiza') THEN 1
		 WHEN municipio_nombre='La Matanza' THEN 4
		 ELSE 5
    END
ORDER BY anio ASC,id_zona ASC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE fact_repitencia
SELECT anio,
	CASE 
		 WHEN municipio_nombre IN ('San Isidro', 'Vicente Lopez', 'General San Martin','San Miguel','Malvinas Argentinas','San Fernando', 'Tigre') THEN 3
		 WHEN municipio_nombre IN ('Ituzaingo','Moron', 'Hurlingham', 'Merlo', 'Moreno') THEN 2
		 WHEN municipio_nombre IN ('Almirante Brown', 'Avellaneda', 'Quilmes', 'Lanus', 'Florencio Varela', 'Berazategui', 'Lomas de Zamora', 'Esteban Echeverria','Ezeiza') THEN 1
		 WHEN municipio_nombre='La Matanza' THEN 4
		 ELSE 5
    END AS id_zona,
	  CAST(AVG(promocion_efectiva_primaria) AS DECIMAL(10,2)) AS promocion_efectiva_primaria,
    CAST(AVG(promocion_efectiva_secundaria) AS DECIMAL(10,2)) AS promocion_efectiva_secundaria,
    CAST(AVG(repitencia_primaria) AS DECIMAL(10,2)) AS repitencia_primaria,
    CAST(AVG(repitencia_secundaria) AS DECIMAL(10,2)) AS repitencia_secundaria,
    CAST(AVG(reinscripcion_primaria) AS DECIMAL(10,2)) AS reinscripcion_primaria,
    CAST(AVG(reinscripcion_secundaria) AS DECIMAL(10,2)) AS reinscripcion_secundaria,
    CAST(AVG(abandono_interanual_primaria) AS DECIMAL(10,2)) AS abandono_interanual_primaria,
    CAST(AVG(abandono_interanual_secundaria) AS DECIMAL(10,2)) AS abandono_interanual_secundaria,
    CAST(AVG(alumnos_promovidos_primaria) AS DECIMAL(10,2)) AS alumnos_promovidos_primaria,
    CAST(AVG(alumnos_promovidos_secundaria) AS DECIMAL(10,2)) AS alumnos_promovidos_secundaria,
    CAST(AVG(alumnos_no_promovidos_primaria) AS DECIMAL(10,2)) AS alumnos_no_promovidos_primaria,
    CAST(AVG(alumnos_no_promovidos_secundaria) AS DECIMAL(10,2)) AS alumnos_no_promovidos_secundaria,
    CAST(AVG(salidos_sin_pase_primaria) AS DECIMAL(10,2)) AS salidos_sin_pase_primaria,
    CAST(AVG(salidos_sin_pase_secundaria) AS DECIMAL(10,2)) AS salidos_sin_pase_secundaria,
    CAST(AVG(salidos_con_pase_primaria) AS DECIMAL(10,2)) AS salidos_con_pase_primaria,
    CAST(AVG(salidos_con_pase_secundaria) AS DECIMAL(10,2)) AS salidos_con_pase_secundaria,
    CAST(AVG(sobreedad_primaria) AS DECIMAL(10,2)) AS sobreedad_primaria,
    CAST(AVG(sobreedad_secundaria) AS DECIMAL(10,2)) AS sobreedad_secundaria,
    CAST(AVG(sobreedad_avanzada_primaria) AS DECIMAL(10,2)) AS sobreedad_avanzada_primaria,
    CAST(AVG(sobreedad_avanzada_secundaria) AS DECIMAL(10,2)) AS sobreedad_avanzada_secundaria
FROM stg_repitencia
WHERE (anio between 2013 and 2022) and municipio_nombre in ("Almirante Brown", "Avellaneda", "Berazategui", "Berisso", "Brandsen", 
    "Campana", "Cañuelas", "Ensenada", "Escobar", "Esteban Echeverría", "Exaltación de la Cruz", "Ezeiza", "Florencio Varela", "General Las Heras", 
    "General Rodríguez", "General San Martín", "Hurlingham", "Ituzaingó", "José C. Paz", "La Matanza", "La Plata", "Lanús", "Lomas de Zamora", 
    "Luján", "Malvinas Argentinas", "Marcos Paz", "Merlo", "Moreno", "Morón", "Pilar", "Presidente Perón", "Quilmes", "San Fernando", 
    "San Isidro", "San Miguel", "San Vicente", "Tigre", "Tres de Febrero", "Vicente López", "Zárate")
GROUP BY anio, 
		CASE 
		 WHEN municipio_nombre IN ('San Isidro', 'Vicente Lopez', 'General San Martin','San Miguel','Malvinas Argentinas','San Fernando', 'Tigre') THEN 3
		 WHEN municipio_nombre IN ('Ituzaingo','Moron', 'Hurlingham', 'Merlo', 'Moreno') THEN 2
		 WHEN municipio_nombre IN ('Almirante Brown', 'Avellaneda', 'Quilmes', 'Lanus', 'Florencio Varela', 'Berazategui', 'Lomas de Zamora', 'Esteban Echeverria','Ezeiza') THEN 1
		 WHEN municipio_nombre='La Matanza' THEN 4
		 ELSE 5
    END
ORDER BY anio ASC,id_zona ASC;

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
  	anio,
  	zona,
    unidades_de_servicio_nivel_inicial,
  	unidades_de_servicio_nivel_primario,
  	unidades_de_servicio_nivel_secundario,
  	sector_de_gestion_estatal,
  	sector_de_gestion_privada,
  	matricula_nivel_inicial,
  	matricula_nivel_primario,
  	matricula_nivel_secundario,
  	matricula_sexo_masculino,
  	matricula_sexo_femenino,
    (matricula_nivel_inicial + matricula_nivel_primario + matricula_nivel_secundario) as matricula_total
FROM fact_colegios c
INNER JOIN zona z ON c.id_zona=z.id
ORDER BY zona,anio ASC

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE jup_alumnos_colegios
SELECT
  	anio,
  	zona,
    unidades_de_servicio_nivel_inicial,
  	unidades_de_servicio_nivel_primario,
  	unidades_de_servicio_nivel_secundario,
  	sector_de_gestion_estatal,
  	sector_de_gestion_privada,
  	matricula_nivel_inicial,
  	matricula_nivel_primario,
  	matricula_nivel_secundario,
  	matricula_sexo_masculino,
  	matricula_sexo_femenino,
    (matricula_nivel_inicial + matricula_nivel_primario + matricula_nivel_secundario) as matricula_total
FROM fact_colegios c
INNER JOIN zona z ON c.id_zona=z.id
ORDER BY zona,anio ASC

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE jup_repitencia
SELECT 
	anio,
  zona,
	promocion_efectiva_primaria, 
	promocion_efectiva_secundaria,
	repitencia_primaria, 
	repitencia_secundaria,
	reinscripcion_primaria,
	reinscripcion_secundaria,
	abandono_interanual_primaria,
	abandono_interanual_secundaria,
	alumnos_promovidos_primaria,
	alumnos_promovidos_secundaria,
	alumnos_no_promovidos_primaria,
	alumnos_no_promovidos_secundaria,
	salidos_sin_pase_primaria,
	salidos_sin_pase_secundaria,
	salidos_con_pase_primaria ,
	salidos_con_pase_secundaria ,
	sobreedad_primaria ,
	sobreedad_secundaria ,
	sobreedad_avanzada_primaria,
	sobreedad_avanzada_secundaria
FROM fact_repitencia r
INNER JOIN zona z ON r.id_zona=z.id
ORDER BY zona,anio ASC

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE jup_inversion_poblacion
SELECT 
	p.anio,
    z.zona,
    CAST(i.inversion_educativa_usd /(c.matricula_nivel_inicial + c.matricula_nivel_primario + c.matricula_nivel_secundario)AS DECIMAL (5,2)) AS inversion_alumno,
    p.poblacion_total,
    i.inversion_educativa_usd
	FROM fact_poblacion p
INNER JOIN zona z ON p.id_zona = z.Id
INNER JOIN fact_inversion i ON p.id_zona = i.id_zona AND p.anio=i.anio
INNER JOIN fact_colegios c ON p.id_zona = c.id_zona AND p.anio=c.anio
ORDER BY zona,anio ASC;

