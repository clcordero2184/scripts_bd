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
--  DDL for Table SIOP_LINER
--------------------------------------------------------

--BORRAR LA SECUENCIA 
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_LINER;

COMMIT;

--BORRAR EL TRIGGER
DROP TRIGGER SIOP_OWNER.SIOP_LINER_BII_TRG_01;

COMMIT;

--BORRAR LA TABLA
DROP TABLE SIOP_OWNER.SIOP_LINER CASCADE CONSTRAINTS;

COMMIT;

-- CREAR LA TABLA EN EL ESQUEMA CORRESPONDIENTE
CREATE TABLE "SIOP_OWNER"."SIOP_LINER" (
    "COD_LINER"            NUMBER,
    "COD_INSTITUCIONAL"    VARCHAR2(12 BYTE),
    "DSC_LINER"            VARCHAR2(255 BYTE),
    "TIP_LINER"            NUMBER,
    "COD_USUARIO_REGISTRO" VARCHAR2(100 BYTE),
    "FEC_REGISTRO"         DATE,
    "COD_USUARIO_MODIFICO" VARCHAR2(100 BYTE),
    "FEC_MODIFICO"         DATE,
    "LOG_ACTIVO"           CHAR(1 BYTE)
);

--INCLUIR COMENTARIOS
COMMENT ON COLUMN "SIOP_OWNER"."SIOP_LINER"."COD_LINER" IS
    'Número autoincremental del liner';

COMMENT ON COLUMN "SIOP_OWNER"."SIOP_LINER"."COD_INSTITUCIONAL" IS
    'Código institucional del liner ';

COMMENT ON COLUMN "SIOP_OWNER"."SIOP_LINER"."DSC_LINER" IS
    'Descripción de los liner';

COMMENT ON COLUMN "SIOP_OWNER"."SIOP_LINER"."TIP_LINER" IS
    'Tipo de Liner  (FK Tipos)';

COMMENT ON COLUMN "SIOP_OWNER"."SIOP_LINER"."COD_USUARIO_REGISTRO" IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN "SIOP_OWNER"."SIOP_LINER"."FEC_REGISTRO" IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN "SIOP_OWNER"."SIOP_LINER"."COD_USUARIO_MODIFICO" IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN "SIOP_OWNER"."SIOP_LINER"."FEC_MODIFICO" IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN "SIOP_OWNER"."SIOP_LINER"."LOG_ACTIVO" IS
    'Estado del registro (Activo=1, Inactivo=0)';

---CREAR INDEX
CREATE INDEX SIOP_OWNER.SIOP_LINER_IDX_01 ON
    SIOP_OWNER.SIOP_LINER (
        COD_LINER
    )
        TABLESPACE INDICES_01;

---INCLUIR PRIMARY KEY (PK)
ALTER TABLE SIOP_OWNER.SIOP_LINER
    ADD PRIMARY KEY ( COD_LINER )
        USING INDEX SIOP_OWNER.SIOP_LINER_IDX_01
    ENABLE;

---CREAR SECUENCIA
CREATE SEQUENCE SIOP_OWNER.SEC_SIOP_LINER START WITH 1 NOCACHE ORDER;

---CREAR TRIGGER
CREATE OR REPLACE TRIGGER SIOP_OWNER.SIOP_LINER_BII_TRG_01 BEFORE
    INSERT ON SIOP_OWNER.SIOP_LINER
    FOR EACH ROW
    WHEN ( NEW.COD_LINER IS NULL )
BEGIN
    :NEW.COD_LINER := SIOP_OWNER.SEC_SIOP_LINER.NEXTVAL;
END;