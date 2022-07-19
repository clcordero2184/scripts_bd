--BORRAR LA SECUENCIA PARA QUE NO PROBLEMAS
drop sequence CORE_OWNER.SEC_CORE_PARAMETRO;
commit;

--DESHABILITAR EL TRIGGER
alter trigger CORE_OWNER.CORE_PARAMETRO_BII_TRG_01 disable;
commit;

--BORRAR LOS DATOS DE LA TABLA
delete from CORE_OWNER.CORE_PARAMETRO;
commit;


INSERT INTO CORE_OWNER.CORE_PARAMETRO (COD_PARAMETRO, DSC_CORTA_PARAMETRO, DSC_PARAMETRO, COD_CATALOGO, DSC_VALOR, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) 
VALUES (1,'Minutos privado','Minutos de atención de una persona que viene con receta oftamologica del Sector Privado',15,'{"valor":10}', 'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),1);
COMMIT;

INSERT INTO CORE_OWNER.CORE_PARAMETRO (COD_PARAMETRO, DSC_CORTA_PARAMETRO, DSC_PARAMETRO, COD_CATALOGO, DSC_VALOR, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) 
VALUES (2,'Minutos CCSS','Minutos de atención de una persona que viene con receta oftamologica de la CCSS',15,'{"valor":5}', 'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),1);
COMMIT;

INSERT INTO CORE_OWNER.CORE_PARAMETRO (COD_PARAMETRO, DSC_CORTA_PARAMETRO, DSC_PARAMETRO, COD_CATALOGO, DSC_VALOR, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) 
VALUES (3,'Porcentaje CCSS','Porcentaje de cupos de atención para pacientes con receta de la CCSS',15,'{"valor":"0.7"}', 'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),1);
COMMIT;

INSERT INTO CORE_OWNER.CORE_PARAMETRO (COD_PARAMETRO, DSC_CORTA_PARAMETRO, DSC_PARAMETRO, COD_CATALOGO, DSC_VALOR, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) 
VALUES (4,'Porcentaje Privado','Porcentaje de cupos de atención para pacientes con receta del sector privado',15,'{"valor":"0.3"}', 'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),1);
COMMIT;

INSERT INTO CORE_OWNER.CORE_PARAMETRO (COD_PARAMETRO, DSC_CORTA_PARAMETRO, DSC_PARAMETRO, COD_CATALOGO, DSC_VALOR, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) 
VALUES (5,'Minutos Ausentes','Valor que indica cuantos  minutos se dura en una cita para poner una persona como ausente sino se presenta',15,'{"valor":15}', 'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),1);
COMMIT;

INSERT INTO CORE_OWNER.CORE_PARAMETRO (COD_PARAMETRO, DSC_CORTA_PARAMETRO, DSC_PARAMETRO, COD_CATALOGO, DSC_VALOR, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) 
VALUES (6, 'Días Feriados','Dias feriados a nivel nacionaL',15,'[{"descripcion": "Primero de Enero","estado": true,"fecha": "2021-01-01T06:00:00.000Z"},{"descripcion": "Juan Santamaria","estado": true,"fecha": "2021-04-11T06:00:00.000Z"}, {"descripcion": "Jueves Santo","estado": true,"fecha": "0000-04-14T06:00:00.000Z"}, {"descripcion": "Viernes Santo","estado": true,"fecha": "0000-04-15T06:00:00.000Z"}, {"descripcion": "Dia del Tabajador","estado": true,"fecha": "0000-05-01T06:00:00.000Z"}, {"descripcion": "Anexión de Guanacaste","estado": true,"fecha": "0000-07-25T06:00:00.000Z"}, {"descripcion": "Día de la Virgen de los Ángeles","estado": true,"fecha": "0000-08-02T06:00:00.000Z"}, {"descripcion": "Día de la madre", "estado": true,"fecha": "0000-08-15T06:00:00.000Z"}, {"descripcion": "Día de la Independencia","estado": true,"fecha": "0000-09-15T06:00:00.000Z"}, {"descripcion": "Día de la abolición del ejército","estado": true,"fecha": "0000-12-05T06:00:00.000Z"}, {"descripcion": "Día de Navidad","estado": true,"fecha": "0000-12-25T06:00:00.000Z"}]', 'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),1);
COMMIT;

INSERT INTO CORE_OWNER.CORE_PARAMETRO ( COD_PARAMETRO, DSC_CORTA_PARAMETRO, DSC_PARAMETRO, COD_CATALOGO, DSC_VALOR, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) 
VALUES ( 7,'Unidades Programáticas DA','Unidades programáticas correspondientes a la atención del Laboratorio Óptico',15,'[{"descripcion": "Hospital Rafael Ángel Calderón Guardia","codigoUnidad": "2101"},{"descripcion": "Hospital San Juan de Dios","codigoUnidad": "2102"},{"descripcion": "Hospital Nacional de Niños","codigoUnidad": "2103"},{"descripcion": "Hospital México","codigoUnidad": "2104"},{"descripcion": "Hospital Nacional de Geriatría y Gerontología","codigoUnidad": "2202"},{"descripcion": "Hospital San Rafael de Alajuela","codigoUnidad": "2205"},{"descripcion": "Hospital San Vicente de Paúl","codigoUnidad": "2208"},{"descripcion": "Hospital Máx Peralta Jiménez","codigoUnidad": "2306"},{"descripcion": "Clínica Clorito Picado","codigoUnidad": "2213"},{"descripcion": "Clínica Ricardo Moreno Cañas","codigoUnidad": "2311"},{"descripcion": "Área de Salud Hatillo","codigoUnidad": "2312"},{"descripcion": "Área de Salud Desamparados 1","codigoUnidad": "2315"},{"descripcion":"Área de Salud Zapote-catedral","codigoUnidad":"2314"},{"descripcion":"Clinica Oftalmologica","codigoUnidad":"2802"},{"descripcion":"Laboratorio Optico","codigoUnidad": "8203"}]', 'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),1);
COMMIT;

--CREAR SECUENCIA NUEVAMENTE
CREATE SEQUENCE CORE_OWNER.SEC_CORE_PARAMETRO START WITH 8 NOCACHE    ORDER ;

--HABILITAR EL TRIGGER
alter trigger CORE_OWNER.CORE_PARAMETRO_BII_TRG_01 enable;
commit;



CREATE OR REPLACE TRIGGER CORE_OWNER.CORE_PARAMETRO_BII_TRG_01 
BEFORE INSERT ON CORE_OWNER.CORE_PARAMETRO 
FOR EACH ROW 
WHEN (NEW.COD_PARAMETRO IS NULL) 
BEGIN
:new.cod_parametro := sec_CORE_PARAMETRO.nextval;

end;

