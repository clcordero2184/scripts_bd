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
--  DDL for Table siop_receta_detalle
--------------------------------------------------------

--BORRAR EL TRIGGER
DROP TRIGGER SIOP_OWNER.SIOP_RECETA_DETALLE_BII_TRG_01;

COMMIT;

--BORRAR LA SECUENCIA 
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_RECETA_DETALLE;

COMMIT;

--BORRAR LA TABLA
DROP TABLE SIOP_OWNER.SIOP_RECETA_DETALLE CASCADE CONSTRAINTS;

COMMIT;

CREATE TABLE SIOP_OWNER.SIOP_RECETA_DETALLE (
    CON_RECETA_DETALLE   NUMBER NOT NULL,
    COD_RECETA           NUMBER NOT NULL,
    COD_LINER            NUMBER NOT NULL,
    COD_PIE              NUMBER NOT NULL,
    COD_USUARIO_REGISTRO VARCHAR2(100),
    FEC_REGISTRO         DATE,
    COD_USUARIO_MODIFICO VARCHAR2(100),
    FEC_MODIFICO         DATE,
    LOG_ACTIVO           CHAR(1)
);

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA_DETALLE.CON_RECETA_DETALLE IS
    'Código autonúmerico del detalle de la receta';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA_DETALLE.COD_RECETA IS
    'Código de la receta que hace referencia (FK)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA_DETALLE.COD_LINER IS
    'Código del liner correspondiente (FK)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA_DETALLE.COD_PIE IS
    'Código de pie correspondiente (FK)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA_DETALLE.COD_USUARIO_REGISTRO IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA_DETALLE.FEC_REGISTRO IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA_DETALLE.COD_USUARIO_MODIFICO IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA_DETALLE.FEC_MODIFICO IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_RECETA_DETALLE.LOG_ACTIVO IS
    'Estado del registro (Activo=0, Inactivo=1)';

CREATE INDEX SIOP_OWNER.SIOP_RECETA_DETALLE_IDX_01 ON
    SIOP_OWNER.SIOP_RECETA_DETALLE (
        CON_RECETA_DETALLE
    ASC );


ALTER TABLE SIOP_OWNER.SIOP_RECETA_DETALLE ADD CONSTRAINT SIOP_RECETAS_DETALLE_PK PRIMARY KEY ( CON_RECETA_DETALLE );

ALTER TABLE SIOP_OWNER.SIOP_RECETA_DETALLE
    ADD CONSTRAINT SIOP_RECETA_DETALLE_FK_01 FOREIGN KEY ( COD_RECETA )
        REFERENCES SIOP_OWNER.SIOP_RECETA ( COD_RECETA );

CREATE SEQUENCE SIOP_OWNER.SEC_SIOP_RECETA_DETALLE START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER SIOP_OWNER.SIOP_RECETA_DETALLE_BII_TRG_01 BEFORE
    INSERT ON SIOP_OWNER.SIOP_RECETA_DETALLE
    FOR EACH ROW
    WHEN ( NEW.CON_RECETA_DETALLE IS NULL )
BEGIN
    :NEW.CON_RECETA_DETALLE := SEC_SIOP_RECETA_DETALLE.NEXTVAL;
END;
/

COMMIT;