-----------------------------------------------------------------------
-----------------------------------------------------------------------
--                                                                   --
--   **********    ****   ************  ************   ****    ****  --
--   ***********   ****   ************  ************   ****    ****  --
--   ****   ****   ****       ****            *****    ****    ****  --
--   **********    ****       ****          *****      ****    ****  --
--   ****   ****   ****       ****        *****        ****    ****  --
--   ***********   ****       ****      ************   ************  --
--   ***********   ****       ****      ************   ************  --
--                                                                   --
-----------------------------------------------------------------------
-----------------------------------------------------------------------

--------------------------------------------------------
--  DDL for Table siop_VALORACION_PROTESICA
--------------------------------------------------------

--BORRAR EL TRIGGER
DROP TRIGGER SIOP_OWNER.SIOP_VALORACION_PROTESICA_BII_TRG_01;

COMMIT;

--BORRAR LA SECUENCIA 
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_VALORACION_PROTESICA;

COMMIT;

--BORRAR LA TABLA
DROP TABLE SIOP_OWNER.SIOP_VALORACION_PROTESICA CASCADE CONSTRAINTS;

COMMIT;

CREATE TABLE SIOP_OWNER.SIOP_VALORACION_PROTESICA (
    CON_VALORACION_PROTESICA       NUMBER NOT NULL,
    COD_RECETA                     NUMBER NOT NULL,
    DSC_NIVEL_FUNCIONAL            VARCHAR2(2),
    DSC_VENDAJE                    VARCHAR2(15),
    DSC_AYUDA_TECNICA              VARCHAR2(15),
    DSC_EQUILIBRIO_MONOPODAL       NUMBER,
    DSC_ESTADO_PIE                 VARCHAR2(15),
    DSC_FORMA_MUNON                VARCHAR2(15),
    DSC_CARACTERISTICAS            VARCHAR2(30),
    DSC_CONTRACTURA_CADERA_FLEXION NUMBER,
    DSC_CONTRACTURA_RODILLA        NUMBER,
    DSC_CIRCUNFERENCIA             VARCHAR2(15),
    DSC_LONGITUD_MUNON             VARCHAR2(15),
    COD_USUARIO_REGISTRO           VARCHAR2(100),
    FEC_REGISTRO                   DATE,
    COD_USUARIO_MODIFICO           VARCHAR2(100),
    FEC_MODIFICO                   DATE,
    LOG_ACTIVO                     CHAR(1)
);

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.CON_VALORACION_PROTESICA IS
    'Código de la valoración protesica, consecutivo';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.COD_RECETA IS
    'Código de la receta que viene del EDUS';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_NIVEL_FUNCIONAL IS
    'Descripción del valor funcional';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_VENDAJE IS
    'Descripcioón del vendaje';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_AYUDA_TECNICA IS
    'Descripción de la ayuda técnica si tiene el paciente';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_EQUILIBRIO_MONOPODAL IS
    'Descripción si tiene equilibrio monopodal';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_ESTADO_PIE IS
    'Descripción del estado del pie';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_FORMA_MUNON IS
    'Descripción de la forma del muñón';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_CARACTERISTICAS IS
    'Caracteristicas';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_CONTRACTURA_CADERA_FLEXION IS
    'Descripción contractura cadera';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_CONTRACTURA_RODILLA IS
    'Descripción contractura rodilla';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_CIRCUNFERENCIA IS
    'Descripción de la circunferencia';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.DSC_LONGITUD_MUNON IS
    'Descripción de la longitud del muñón';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.COD_USUARIO_REGISTRO IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.FEC_REGISTRO IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.COD_USUARIO_MODIFICO IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.FEC_MODIFICO IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_VALORACION_PROTESICA.LOG_ACTIVO IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX SIOP_VALORACIONES_PROTE_IDX_01 ON
    SIOP_OWNER.SIOP_VALORACION_PROTESICA (
        CON_VALORACION_PROTESICA
    ASC );

ALTER TABLE SIOP_OWNER.SIOP_VALORACION_PROTESICA ADD CONSTRAINT OP_VALORACIONES_PROTESICAS_PK PRIMARY KEY ( CON_VALORACION_PROTESICA );

ALTER TABLE SIOP_OWNER.SIOP_VALORACION_PROTESICA
    ADD CONSTRAINT SIOP_VALORACIONES_PROTES_FK_01 FOREIGN KEY ( COD_RECETA )
        REFERENCES SIOP_OWNER.SIOP_RECETA ( COD_RECETA );

CREATE SEQUENCE SIOP_OWNER.SEC_SIOP_VALORACION_PROTESICA START WITH 1   NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SIOP_OWNER.SIOP_VALORACION_PRO_BII_TRG_01 
BEFORE INSERT ON SIOP_OWNER.SIOP_VALORACION_PROTESICA 
FOR EACH ROW 
WHEN (NEW.CON_VALORACION_PROTESICA IS NULL) 
BEGIN
:NEW.CON_VALORACION_PROTESICA := SEC_SIOP_VALORACION_PROTESICA.NEXTVAL;

END;
/

COMMIT;

