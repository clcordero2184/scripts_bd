
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
--  DDL for Table SIOP_PIE
--------------------------------------------------------

--BORRAR LA SECUENCIA 
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_PIE;
COMMIT;

--BORRAR EL TRIGGER
DROP TRIGGER SIOP_OWNER.SIOP_PIE_BII_TRG_01;
COMMIT;

--BORRAR LA TABLA
DROP TABLE SIOP_OWNER.SIOP_PIE CASCADE CONSTRAINTS;
COMMIT;

-- CREAR LA TABLA EN EL ESQUEMA CORRESPONDIENTE
CREATE TABLE SIOP_OWNER.SIOP_PIE (
    COD_PIE              NUMBER NOT NULL,
    COD_INSTITUCIONAL    VARCHAR2(12 CHAR) NOT NULL,
    DSC_PIE              VARCHAR2(255) NOT NULL,
    COD_TIPO             NUMBER NOT NULL,
    COD_USUARIO_REGISTRO VARCHAR2(100),
    FEC_REGISTRO         DATE,
    COD_USUARIO_MODIFICO VARCHAR2(100),
    FEC_MODIFICO         DATE,
    LOG_ACTIVO           CHAR(1)
);

-- INCLUIR COMENTARIOS
COMMENT ON COLUMN SIOP_OWNER.SIOP_PIE.COD_PIE IS
    'Código institucional de los artículos';

COMMENT ON COLUMN SIOP_OWNER.SIOP_PIE.COD_INSTITUCIONAL IS
    'Código institucional para un artículo';

COMMENT ON COLUMN SIOP_OWNER.SIOP_PIE.DSC_PIE IS
    'Descripción del artículo pie';

COMMENT ON COLUMN SIOP_OWNER.SIOP_PIE.COD_TIPO IS
    'Tipo de Liner del articulo (FK Tipos)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_PIE.COD_USUARIO_REGISTRO IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_PIE.FEC_REGISTRO IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_PIE.COD_USUARIO_MODIFICO IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_PIE.FEC_MODIFICO IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SIOP_OWNER.SIOP_PIE.LOG_ACTIVO IS
    'Estado del registro (Activo=1, Inactivo=0)';

CREATE INDEX SIOP_OWNER.SIOP_PIE_IDX_01 ON
    SIOP_OWNER.SIOP_PIE (
        COD_PIE
    ASC );

---INCLUIR PRIMARY KEY (PK)
ALTER TABLE SIOP_OWNER.SIOP_PIE ADD PRIMARY KEY (COD_PIE) USING INDEX SIOP_OWNER.SIOP_PIE_IDX_01
ENABLE;

---CREAR SECUENCIA
CREATE SEQUENCE SIOP_OWNER.SEC_SIOP_PIE START WITH 1 NOCACHE ORDER;

---CREAR TRIGGER
CREATE OR REPLACE TRIGGER SIOP_OWNER.SIOP_PIE_BII_TRG_01 BEFORE
    INSERT ON SIOP_OWNER.SIOP_PIE
    FOR EACH ROW
    WHEN ( NEW.COD_PIE IS NULL )
BEGIN
    :NEW.COD_PIE := SIOP_OWNER.SEC_SIOP_PIE.NEXTVAL;
END;