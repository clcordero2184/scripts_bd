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
--  DDL for Table SIOP_RECETA
--------------------------------------------------------

--BORRAR EL TRIGGER
DROP TRIGGER SIOP_OWNER.SIOP_RECETA_BII_TRG_01;
COMMIT;

--BORRAR LA SECUENCIA 
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_RECETA;
COMMIT;

--BORRAR LA TABLA
DROP TABLE SIOP_OWNER.SIOP_RECETA CASCADE CONSTRAINTS;
COMMIT;

-- CREAR LA TABLA EN EL ESQUEMA CORRESPONDIENTE
CREATE TABLE SIOP_OWNER.SIOP_RECETA (
    COD_RECETA                    NUMBER NOT NULL,
    COD_RECETA_EDUS               VARCHAR2(20) NOT NULL,
    FEC_RECETA                    DATE NOT NULL,
    COD_UNIDAD_EMISION            VARCHAR2(4) NOT NULL,
    COD_UNIDAD_ADSCRIPCION        VARCHAR2(4) NOT NULL,
    NUM_IDENTIFICACION            VARCHAR2(60) NOT NULL,
    DSC_NIVEL_FUNCIONALIDAD       VARCHAR2(2) NOT NULL,
    DSC_DIAGNOSTICO               VARCHAR2(26) NOT NULL,
    DSC_PRESCRIPCION_PROTESICA    VARCHAR2(30) NOT NULL,
    DSC_LATERALIDAD               VARCHAR2(9) NOT NULL,
    DSC_TIPO_SOCKET               VARCHAR2(25) NOT NULL,
    DSC_METODO_SUSPENSION         VARCHAR2(26) NOT NULL,
    DSC_INTERFAZ                  VARCHAR2(16) NOT NULL,
    DSC_TIPO_ARTICULACION_CADERA  VARCHAR2(38) NOT NULL,
    DSC_TIPO_ARTICULACION_RODILLA VARCHAR2(37) NOT NULL,
    DSC_MODULO                    VARCHAR2(14) NOT NULL,
    COD_TIPO                      NUMBER NOT NULL,
    COD_ESTADO                    NUMBER NOT NULL,
    DSC_OBSERVACIONES             VARCHAR2(255),
    COD_USUARIO_REGISTRO          VARCHAR2(100),
    FEC_REGISTRO                  DATE,
    COD_USUARIO_MODIFICO          VARCHAR2(100),
    FEC_MODIFICO                  DATE,
    LOG_ACTIVO                    CHAR(1)
);

-- INCLUIR COMENTARIOS
COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.COD_RECETA IS
    'Código de la receta, número consecutivo';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.COD_RECETA_EDUS IS
    'Número de la receta que viene del EDUS';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.FEC_RECETA IS
    'Fecha de la receta ';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.COD_UNIDAD_EMISION IS
    'Código de la unidad programática que emite la receta (FK UP)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.COD_UNIDAD_ADSCRIPCION IS
    'Código de la unidad programática del paciente (FK UP)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.NUM_IDENTIFICACION IS
    'Número de identificación del paciente (FK Persona)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_NIVEL_FUNCIONALIDAD IS
    'Descripción del nivel de funcionalidad de la protesis';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_DIAGNOSTICO IS
    'Descripción del diagnóstico de la protesis';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_PRESCRIPCION_PROTESICA IS
    'Descripción de la prescripción protesica';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_LATERALIDAD IS
    'Descripción de la lateralidad de la protésis (Derecha. IZquierda)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_TIPO_SOCKET IS
    'Descripción del tipo de socket';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_METODO_SUSPENSION IS
    'Descripción del método de suspensión';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_INTERFAZ IS
    'Descripción de la interfaz';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_TIPO_ARTICULACION_CADERA IS
    'Descripción del tipo de articulación de la cadera';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_TIPO_ARTICULACION_RODILLA IS
    'Descripción del tipo de articulación de la rodilla ';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_MODULO IS
    'Descripción de módulo';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.COD_TIPO IS
    'Tipo del RECETA (FK TIPOS)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.COD_ESTADO IS
    'Estado de la receta , (FK ESTADOS)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.DSC_OBSERVACIONES IS
    'Observaciones sobre la receta';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.COD_USUARIO_REGISTRO IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.FEC_REGISTRO IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.COD_USUARIO_MODIFICO IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.FEC_MODIFICO IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA.LOG_ACTIVO IS
    'Estado del registro (Activo=1, Inactivo=0';

CREATE INDEX SIOP_OWNER.SIOP_RECETA_IDX_01 ON
    SIOP_OWNER.SIOP_RECETA (
        COD_RECETA
    ASC );

---INCLUIR PRIMARY KEY (PK)
ALTER TABLE SIOP_OWNER.SIOP_RECETA ADD CONSTRAINT SIOP_RECETA_PK PRIMARY KEY ( COD_RECETA );

---CREAR SECUENCIA
CREATE SEQUENCE SIOP_OWNER.SEC_SIOP_RECETA START WITH 1 NOCACHE ORDER;

---CREAR TRIGGER
CREATE OR REPLACE TRIGGER SIOP_OWNER.SIOP_RECETA_BII_TRG_01 BEFORE
    INSERT ON SIOP_OWNER.SIOP_RECETA
    FOR EACH ROW
    WHEN ( NEW.COD_RECETA IS NULL )
BEGIN
    :NEW.COD_RECETA := SIOP_OWNER.SEC_SIOP_RECETA.NEXTVAL;
END;