Importación y Creación de Tablas

Para asegurar la integridad de los datos en el proyecto de repitencia, definimos la estructura de la tabla de transferencias:

CREATE TABLE dataset_transferencias (
    anio INT,
    mes INT,
    id_municipio INT,
    municipio TEXT,
    concepto TEXT,
    monto FLOAT
);
