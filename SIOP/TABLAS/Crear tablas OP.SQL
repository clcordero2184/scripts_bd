-- Generado por Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   en:        2022-03-07 10:10:33 CST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE SIOP_catalogos (
    cod_catalogo         NUMBER NOT NULL,
    dsc_catalogo         VARCHAR2(30) NOT NULL,
    dsc_modulo           CHAR(2) NOT NULL,
    cod_usuario_registro VARCHAR2(100),
    fec_registro         DATE,
    cod_usuario_modifico VARCHAR2(100),
    fec_modifico         DATE,
    log_activo           CHAR(1)
);

COMMENT ON COLUMN SIOP_catalogos.cod_catalogo IS
    'Consecutivo de catálogos (autoincremental)';

COMMENT ON COLUMN SIOP_catalogos.dsc_catalogo IS
    'Descripción del catálogos';

COMMENT ON COLUMN SIOP_catalogos.dsc_modulo IS
    'Descripción al módulo correspondiente (DA, OP, GL, CF)';

COMMENT ON COLUMN SIOP_catalogos.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_catalogos.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_catalogos.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_catalogos.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_catalogos.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX SIOP_catalogos_idx_01 ON
    SIOP_catalogos (
        cod_catalogo
    ASC );

ALTER TABLE SIOP_catalogos ADD CONSTRAINT SIOP_catalogos_pk PRIMARY KEY ( cod_catalogo );

CREATE TABLE SIOP_estados (
    cod_estado           NUMBER NOT NULL,
    dsc_estado           VARCHAR2(70) NOT NULL,
    cod_catalogo         NUMBER NOT NULL,
    cod_usuario_registro VARCHAR2(100),
    fec_registro         DATE,
    cod_usuario_modifico VARCHAR2(100),
    fec_modifico         DATE,
    log_activo           CHAR(1)
);

COMMENT ON COLUMN SIOP_estados.cod_estado IS
    'Código del estado del sistema';

COMMENT ON COLUMN SIOP_estados.dsc_estado IS
    'Descripción del estado del sistema';

COMMENT ON COLUMN SIOP_estados.cod_catalogo IS
    'Descripción del parametro ó módulo correspondiente del estado';

COMMENT ON COLUMN SIOP_estados.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_estados.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_estados.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_estados.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_estados.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX SIOP_estados_idx_01 ON
    SIOP_estados (
        cod_estado
    ASC );

ALTER TABLE SIOP_estados ADD CONSTRAINT SIOP_estados_pk PRIMARY KEY ( cod_estado );

CREATE TABLE SIOP_parametros (
    cod_parametro        NUMBER NOT NULL,
    dsc_corta_parametro  VARCHAR2(30) NOT NULL,
    dsc_parametro        VARCHAR2(150) NOT NULL,
    cod_catalogo         NUMBER NOT NULL,
    dsc_valor            VARCHAR (2000) NOT NULL CONSTRAINT ensure_json CHECK (dsc_valor IS JSON),
    cod_usuario_registro VARCHAR2(100),
    fec_registro         DATE,
    cod_usuario_modifico VARCHAR2(100),
    fec_modifico         DATE,
    log_activo           CHAR(1)
);

COMMENT ON COLUMN SIOP_parametros.cod_parametro IS
    'Código de parametro (autoincremental)';

COMMENT ON COLUMN SIOP_parametros.dsc_corta_parametro IS
    'Nombre corto del parámetro';

COMMENT ON COLUMN SIOP_parametros.dsc_parametro IS
    'Descripción general del parámetro';

COMMENT ON COLUMN SIOP_parametros.cod_catalogo IS
    'Nombre del tipo de módulo del sistema donde pertenece';

COMMENT ON COLUMN SIOP_parametros.dsc_valor IS
    'Valor que tiene el parámetro para uso del sistema';

COMMENT ON COLUMN SIOP_parametros.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_parametros.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_parametros.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_parametros.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_parametros.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX SIOP_parametros_idx_01 ON
    SIOP_parametros (
        cod_parametro
    ASC );

ALTER TABLE SIOP_parametros ADD CONSTRAINT SIOP_parametros_pk PRIMARY KEY ( cod_parametro );

CREATE TABLE SIOP_personas (
    tip_identificacion   NUMBER NOT NULL,
    num_identificacion   VARCHAR2(60) NOT NULL,
    nom_nombre           VARCHAR2(60) NOT NULL,
    nom_apellido1        VARCHAR2(60) NOT NULL,
    nom_apellido2        VARCHAR2(60) NOT NULL,
    fec_nacimiento       DATE NOT NULL,
    cod_genero           CHAR(1) NOT NULL,
    num_celular          VARCHAR2(9 CHAR),
    num_habitacion       VARCHAR2(9 CHAR),
    dsc_email            VARCHAR2(255),
    cod_usuario_registro VARCHAR2(100),
    fec_registro         DATE,
    cod_usuario_modifico VARCHAR2(100),
    fec_modifico         DATE,
    log_activo           CHAR(1)
);

COMMENT ON COLUMN SIOP_personas.tip_identificacion IS
    'Tipo de identificación (nacional, extranjero, asegurado)';

COMMENT ON COLUMN SIOP_personas.num_identificacion IS
    'Número de identificación único de la persona';

COMMENT ON COLUMN SIOP_personas.nom_nombre IS
    'Nombre de la persona, se incluye ambos nombres';

COMMENT ON COLUMN SIOP_personas.nom_apellido1 IS
    'Primer apellido de la persona';

COMMENT ON COLUMN SIOP_personas.nom_apellido2 IS
    'Segundo apellido de la persona.';

COMMENT ON COLUMN SIOP_personas.fec_nacimiento IS
    'Fecha de nacimiento de la persona.';

COMMENT ON COLUMN SIOP_personas.cod_genero IS
    'Código de genero de la persona (F= Femenino, M=Masculino, I=Indefinido)';

COMMENT ON COLUMN SIOP_personas.num_celular IS
    'Número de celular de la persona';

COMMENT ON COLUMN SIOP_personas.num_habitacion IS
    'Número de celular de la persona';

COMMENT ON COLUMN SIOP_personas.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_personas.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_personas.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_personas.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_personas.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX SIOP_personas_idx_01 ON
    SIOP_personas (
        num_identificacion
    ASC );

ALTER TABLE SIOP_personas ADD CONSTRAINT SIOP_persona_pk PRIMARY KEY ( num_identificacion );

CREATE TABLE SIOP_tipos (
    cod_tipo             NUMBER NOT NULL,
    dsc_tipo             VARCHAR2(70) NOT NULL,
    cod_catalogo         NUMBER NOT NULL,
    cod_usuario_registro VARCHAR2(100),
    fec_registro         DATE,
    cod_usuario_modifico VARCHAR2(100),
    fec_modifico         DATE,
    log_activo           CHAR(1)
);

COMMENT ON COLUMN SIOP_tipos.cod_tipo IS
    'Código del tipo de sistema';

COMMENT ON COLUMN SIOP_tipos.dsc_tipo IS
    'Descripción del tipo de sistema';

COMMENT ON COLUMN SIOP_tipos.cod_catalogo IS
    'Descripción del módulo del tipo de sistema';

COMMENT ON COLUMN SIOP_tipos.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_tipos.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_tipos.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_tipos.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_tipos.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX SIOP_tipos_idx_01 ON
    SIOP_tipos (
        cod_tipo
    ASC );

ALTER TABLE SIOP_tipos ADD CONSTRAINT SIOP_tipos_pk PRIMARY KEY ( cod_tipo );

CREATE TABLE siop_liners (
    cod_liner            NUMBER NOT NULL,
    cod_institucional    VARCHAR2(12) NOT NULL,
    dsc_liner            VARCHAR2(255) NOT NULL,
    cod_tipo             NUMBER NOT NULL,
    cod_usuario_registro VARCHAR2(100),
    fec_registro         DATE,
    cod_usuario_modifico VARCHAR2(100),
    fec_modifico         DATE,
    log_activo           CHAR(1)
);

COMMENT ON COLUMN siop_liners.cod_liner IS
    'Número autoincremental del liner
';

COMMENT ON COLUMN siop_liners.cod_institucional IS
    'Código institucional del liner ';

COMMENT ON COLUMN siop_liners.dsc_liner IS
    'Descripción de los liner';

COMMENT ON COLUMN siop_liners.cod_tipo IS
    'Tipo de Liner  (FK Tipos)';

COMMENT ON COLUMN siop_liners.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN siop_liners.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN siop_liners.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_liners.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_liners.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX siop_liners_idx_01 ON
    siop_liners (
        cod_liner
    ASC );

ALTER TABLE siop_liners ADD CONSTRAINT siop_liner_pk PRIMARY KEY ( cod_liner );

CREATE TABLE siop_pies (
    cod_pie              NUMBER NOT NULL,
    cod_institucional    VARCHAR2(12 CHAR) NOT NULL,
    dsc_pie              VARCHAR2(255) NOT NULL,
    cod_tipo             NUMBER NOT NULL,
    cod_usuario_registro VARCHAR2(100),
    fec_registro         DATE,
    cod_usuario_modifico VARCHAR2(100),
    fec_modifico         DATE,
    log_activo           CHAR(1)
);

COMMENT ON COLUMN siop_pies.cod_pie IS
    'Código institucional de los artículos';

COMMENT ON COLUMN siop_pies.cod_institucional IS
    'Código institucional para un artículo';

COMMENT ON COLUMN siop_pies.dsc_pie IS
    'Descripción del artículo pie';

COMMENT ON COLUMN siop_pies.cod_tipo IS
    'Tipo de Liner del articulo (FK Tipos)';

COMMENT ON COLUMN siop_pies.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN siop_pies.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN siop_pies.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_pies.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_pies.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX siop_pies_idx_01 ON
    siop_pies (
        cod_pie
    ASC );

ALTER TABLE siop_pies ADD CONSTRAINT op_articulos_pk PRIMARY KEY ( cod_pie );

CREATE TABLE siop_recetas (
    cod_receta                    NUMBER NOT NULL,
    cod_receta_edus               VARCHAR2(20) NOT NULL,
    fec_receta                    DATE NOT NULL,
    cod_unidad_emision            VARCHAR2(4) NOT NULL,
    cod_unidad_adscripcion        VARCHAR2(4) NOT NULL,
    num_identificacion            VARCHAR2(60) NOT NULL,
    dsc_nivel_funcionalidad       VARCHAR2(2) NOT NULL,
    dsc_diagnostico               VARCHAR2(26) NOT NULL,
    dsc_prescripcion_protesica    VARCHAR2(30) NOT NULL,
    dsc_lateralidad               VARCHAR2(9) NOT NULL,
    dsc_tipo_socket               VARCHAR2(25) NOT NULL,
    dsc_metodo_suspension         VARCHAR2(26) NOT NULL,
    dsc_interfaz                  VARCHAR2(16) NOT NULL,
    dsc_tipo_articulacion_cadera  VARCHAR2(38) NOT NULL,
    dsc_tipo_articulacion_rodilla VARCHAR2(37) NOT NULL,
    dsc_modulo                    VARCHAR2(14) NOT NULL,
    cod_tipo                      NUMBER NOT NULL,
    cod_estado                    NUMBER NOT NULL,
    dsc_observaciones             VARCHAR2(255),
    cod_usuario_registro          VARCHAR2(100),
    fec_registro                  DATE,
    cod_usuario_modifico          VARCHAR2(100),
    fec_modifico                  DATE,
    log_activo                    CHAR(1)
);

COMMENT ON COLUMN siop_recetas.cod_receta IS
    'Código de la receta, número consecutivo';

COMMENT ON COLUMN siop_recetas.cod_receta_edus IS
    'Número de la receta que viene del EDUS';

COMMENT ON COLUMN siop_recetas.fec_receta IS
    'Fecha de la receta ';

COMMENT ON COLUMN siop_recetas.cod_unidad_emision IS
    'Código de la unidad programática que emite la receta (FK UP)';

COMMENT ON COLUMN siop_recetas.cod_unidad_adscripcion IS
    'Código de la unidad programática del paciente (FK UP)';

COMMENT ON COLUMN siop_recetas.num_identificacion IS
    'Número de identificación del paciente (FK Persona)';

COMMENT ON COLUMN siop_recetas.dsc_nivel_funcionalidad IS
    'Descripción del nivel de funcionalidad de la protesis';

COMMENT ON COLUMN siop_recetas.dsc_diagnostico IS
    'Descripción del diagnóstico de la protesis';

COMMENT ON COLUMN siop_recetas.dsc_prescripcion_protesica IS
    'Descripción de la prescripción protesica';

COMMENT ON COLUMN siop_recetas.dsc_lateralidad IS
    'Descripción de la lateralidad de la protésis (Derecha. IZquierda)';

COMMENT ON COLUMN siop_recetas.dsc_tipo_socket IS
    'Descripción del tipo de socket';

COMMENT ON COLUMN siop_recetas.dsc_metodo_suspension IS
    'Descripción del método de suspensión';

COMMENT ON COLUMN siop_recetas.dsc_interfaz IS
    'Descripción de la interfaz';

COMMENT ON COLUMN siop_recetas.dsc_tipo_articulacion_cadera IS
    'Descripción del tipo de articulación de la cadera';

COMMENT ON COLUMN siop_recetas.dsc_tipo_articulacion_rodilla IS
    'Descripción del tipo de articulación de la rodilla ';

COMMENT ON COLUMN siop_recetas.dsc_modulo IS
    'Descripción de módulo';

COMMENT ON COLUMN siop_recetas.cod_tipo IS
    'Tipo del pie (FK TIPOS)';

COMMENT ON COLUMN siop_recetas.cod_estado IS
    'Estado de la receta , (FK ESTADOS)';

COMMENT ON COLUMN siop_recetas.dsc_observaciones IS
    'Observaciones sobre la receta';

COMMENT ON COLUMN siop_recetas.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN siop_recetas.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN siop_recetas.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_recetas.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_recetas.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX siop_recetas_idx_01 ON
    siop_recetas (
        cod_receta
    ASC );

ALTER TABLE siop_recetas ADD CONSTRAINT op_recetas_pk PRIMARY KEY ( cod_receta );

CREATE TABLE siop_recetas_detalle (
    con_detalle_receta   NUMBER NOT NULL,
    cod_receta           NUMBER NOT NULL,
    cod_liner            NUMBER NOT NULL,
    cod_pie              NUMBER NOT NULL,
    cod_usuario_registro VARCHAR2(100),
    fec_registro         DATE,
    cod_usuario_modifico VARCHAR2(100),
    fec_modifico         DATE,
    log_activo           CHAR(1)
);

COMMENT ON COLUMN siop_recetas_detalle.con_detalle_receta IS
    'Código autonúmerico del detalle de la receta';

COMMENT ON COLUMN siop_recetas_detalle.cod_receta IS
    'Código de la receta que hace referencia (FK)';

COMMENT ON COLUMN siop_recetas_detalle.cod_liner IS
    'Código del liner correspondiente (FK)';

COMMENT ON COLUMN siop_recetas_detalle.cod_pie IS
    'Código de pie correspondiente (FK)';

COMMENT ON COLUMN siop_recetas_detalle.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN siop_recetas_detalle.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN siop_recetas_detalle.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_recetas_detalle.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_recetas_detalle.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX siop_recetas_detalle_idx_01 ON
    siop_recetas_detalle (
        con_detalle_receta
    ASC );

ALTER TABLE siop_recetas_detalle ADD CONSTRAINT op_recetas_detalle_pk PRIMARY KEY ( con_detalle_receta );

CREATE TABLE siop_valoraciones_protesicas (
    con_valoracion_protesica       NUMBER NOT NULL,
    cod_receta                     NUMBER NOT NULL,
    dsc_nivel_funcional            VARCHAR2(2),
    dsc_vendaje                    VARCHAR2(15),
    dsc_ayuda_tecnica              VARCHAR2(15),
    dsc_equilibrio_monopodal       NUMBER,
    dsc_estado_pie                 VARCHAR2(15),
    dsc_forma_munon                VARCHAR2(15),
    dsc_caracteristicas            VARCHAR2(30),
    dsc_contractura_cadera_flexion NUMBER,
    dsc_contractura_rodilla        NUMBER,
    dsc_circunferencia             VARCHAR2(15),
    dsc_longitud_munon             VARCHAR2(15),
    cod_usuario_registro           VARCHAR2(100),
    fec_registro                   DATE,
    cod_usuario_modifico           VARCHAR2(100),
    fec_modifico                   DATE,
    log_activo                     CHAR(1)
);

COMMENT ON COLUMN siop_valoraciones_protesicas.con_valoracion_protesica IS
    'Código de la valoración protesica, consecutivo';

COMMENT ON COLUMN siop_valoraciones_protesicas.cod_receta IS
    'Código de la receta que viene del EDUS';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_nivel_funcional IS
    'Descripción del valor funcional';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_vendaje IS
    'Descripcioón del vendaje';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_ayuda_tecnica IS
    'Descripción de la ayuda técnica si tiene el paciente';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_equilibrio_monopodal IS
    'Descripción si tiene equilibrio monopodal';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_estado_pie IS
    'Descripción del estado del pie';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_forma_munon IS
    'Descripción de la forma del muñón';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_caracteristicas IS
    'Caracteristicas';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_contractura_cadera_flexion IS
    'Descripción contractura cadera';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_contractura_rodilla IS
    'Descripción contractura rodilla';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_circunferencia IS
    'Descripción de la circunferencia';

COMMENT ON COLUMN siop_valoraciones_protesicas.dsc_longitud_munon IS
    'Descripción de la longitud del muñón';

COMMENT ON COLUMN siop_valoraciones_protesicas.cod_usuario_registro IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN siop_valoraciones_protesicas.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN siop_valoraciones_protesicas.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_valoraciones_protesicas.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN siop_valoraciones_protesicas.log_activo IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX siop_valoraciones_prote_idx_01 ON
    siop_valoraciones_protesicas (
        con_valoracion_protesica
    ASC );

ALTER TABLE siop_valoraciones_protesicas ADD CONSTRAINT op_valoraciones_protesicas_pk PRIMARY KEY ( con_valoracion_protesica );

ALTER TABLE SIOP_estados
    ADD CONSTRAINT SIOP_estados_fk_01 FOREIGN KEY ( cod_catalogo )
        REFERENCES SIOP_catalogos ( cod_catalogo );

ALTER TABLE SIOP_tipos
    ADD CONSTRAINT SIOP_tipos_fk_01 FOREIGN KEY ( cod_catalogo )
        REFERENCES SIOP_catalogos ( cod_catalogo );

ALTER TABLE siop_liners
    ADD CONSTRAINT siop_liners_fk_01 FOREIGN KEY ( cod_tipo )
        REFERENCES SIOP_tipos ( cod_tipo );

ALTER TABLE siop_pies
    ADD CONSTRAINT siop_pies_fk_01 FOREIGN KEY ( cod_tipo )
        REFERENCES SIOP_tipos ( cod_tipo );

ALTER TABLE siop_recetas_detalle
    ADD CONSTRAINT siop_recetas_detalle_fk_01 FOREIGN KEY ( cod_receta )
        REFERENCES siop_recetas ( cod_receta );

ALTER TABLE siop_recetas_detalle
    ADD CONSTRAINT siop_recetas_detalle_fk_02 FOREIGN KEY ( cod_liner )
        REFERENCES siop_liners ( cod_liner );

ALTER TABLE siop_recetas_detalle
    ADD CONSTRAINT siop_recetas_detalle_fk_03 FOREIGN KEY ( cod_pie )
        REFERENCES siop_pies ( cod_pie );

ALTER TABLE siop_recetas
    ADD CONSTRAINT siop_recetas_fk_01 FOREIGN KEY ( num_identificacion )
        REFERENCES SIOP_personas ( num_identificacion );

ALTER TABLE siop_recetas
    ADD CONSTRAINT siop_recetas_fk_02 FOREIGN KEY ( cod_tipo )
        REFERENCES SIOP_tipos ( cod_tipo );

ALTER TABLE siop_recetas
    ADD CONSTRAINT siop_recetas_fk_03 FOREIGN KEY ( cod_estado )
        REFERENCES SIOP_estados ( cod_estado );

ALTER TABLE siop_valoraciones_protesicas
    ADD CONSTRAINT siop_valoraciones_protes_fk_01 FOREIGN KEY ( cod_receta )
        REFERENCES siop_recetas ( cod_receta );

CREATE SEQUENCE SEC_SIOP_CATALOGOS 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_CATALOGOS_BII_TRG_01 
BEFORE INSERT ON SIOP_CATALOGOS 
FOR EACH ROW 
WHEN (NEW.COD_CATALOGO IS NULL) 
BEGIN
:new.cod_catalogo := sec_SIOP_catalogos.nextval;

end;
/

CREATE SEQUENCE SEC_SIOP_ESTADOS 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_ESTADOS_BII_TRG_01 
BEFORE INSERT ON SIOP_ESTADOS 
FOR EACH ROW 
WHEN (NEW.COD_ESTADO IS NULL) 
BEGIN
:new.cod_estado := sec_SIOP_estados.nextval;

end;
/

CREATE SEQUENCE SEC_SIOP_PARAMETROS 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_PARAMETROS_BII_TRG_01 
BEFORE INSERT ON SIOP_PARAMETROS 
FOR EACH ROW 
WHEN (NEW.COD_PARAMETRO IS NULL) 
BEGIN
:new.cod_parametro := sec_SIOP_parametros.nextval;

end;
/

CREATE SEQUENCE SEC_SIOP_TIPOS 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_TIPOS_BII_TRG_01 
BEFORE INSERT ON SIOP_TIPOS 
FOR EACH ROW 
WHEN (NEW.COD_TIPO IS NULL) 
BEGIN
:new.cod_tipo := sec_SIOP_tipos.nextval;

end;
/

CREATE SEQUENCE SEC_SIOP_LINER 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_LINER_BII_TRG_01 
BEFORE INSERT ON SIOP_LINERS 
FOR EACH ROW 
BEGIN
:new.cod_liner := sec_siop_liner.nextval;

end;
/

CREATE SEQUENCE SEC_SIOP_PIES 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_PIES_BII_TRG_01 
BEFORE INSERT ON SIOP_PIES 
FOR EACH ROW 
WHEN (NEW.COD_PIE IS NULL) 
BEGIN
:new.cod_pie := sec_siop_pies.nextval;

end;
/

CREATE SEQUENCE SEC_SIOP_RECETAS 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_RECETAS_BII_TRG_01 
BEFORE INSERT ON SIOP_RECETAS 
FOR EACH ROW 
WHEN (NEW.COD_RECETA IS NULL) 
BEGIN
:new.cod_receta := sec_siop_recetas.nextval;

end;
/

CREATE SEQUENCE SEC_SIOP_DETALLE_RECETA 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_DETALLE_RECETA_BII_TRG_01 
BEFORE INSERT ON SIOP_RECETAS_DETALLE 
FOR EACH ROW 
WHEN (NEW.CON_DETALLE_RECETA IS NULL) 
BEGIN
:new.con_detalle_receta := sec_siop_detalle_receta.nextval;

end;
/

CREATE SEQUENCE SEC_SIOP_VALORACIONES_PROTESIC 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_VALORACION_PRO_BII_TRG_01 
BEFORE INSERT ON SIOP_VALORACIONES_PROTESICAS 
FOR EACH ROW 
WHEN (NEW.CON_VALORACION_PROTESICA IS NULL) 
BEGIN
:new.con_valoracion_protesica := sec_siop_valoraciones_protesic.nextval;

end;
/

COMMIT;

