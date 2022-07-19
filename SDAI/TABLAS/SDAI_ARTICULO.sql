--BORRAR TABLA
DROP TABLE SDAI_OWNER.SDAI_ARTICULO CASCADE CONSTRAINTS;
COMMIT;
--BORRAR LA SECUENCIA PARA QUE NO PROBLEMAS
DROP SEQUENCE SDAI_OWNER.SEC_SDAI_ARTICULO;
COMMIT;
--DESHABILITAR EL TRIGGER
DROP TRIGGER SDAI_OWNER.SDAI_ARTICULO_ANTEJO_BII_TRG_01;
COMMIT;

CREATE TABLE SDAI_OWNER.SDAI_ARTICULO (
    COD_ARTICULO         NUMBER NOT NULL,
    COD_SIGES            VARCHAR2(20) NOT NULL,
    DSC_ARTICULO         VARCHAR2(200) NOT NULL,
    TIP_CONDICION        NUMBER(4) NOT NULL,
    TIP_LENTE            NUMBER(4) NOT NULL,
    TIP_ARO              NUMBER(4) NOT NULL,
    MON_COSTO            NUMBER(6) NOT NULL,
    COD_USUARIO_REGISTRO VARCHAR2(100),
    FEC_REGISTRO         DATE,
    COD_USUARIO_MODIFICO VARCHAR2(100),
    FEC_MODIFICO         DATE,
    LOG_ACTIVO           CHAR(1)
);

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.COD_ARTICULO IS
    'Codigo de articulo PK';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.COD_SIGES IS
    'Codigo de articulo en SIGES para compras';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.DSC_ARTICULO IS
    'Descripción del articulo';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.TIP_CONDICION IS
    'Codigo del tipo de condicion del lente';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.TIP_LENTE IS
    'Codigo del tipo de lente';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.TIP_ARO IS
    'Codigo del tipo de aro';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.MON_COSTO IS
    'El monto que cuesta el articulo';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.COD_USUARIO_REGISTRO IS
    'Usuario que realiza el registro (auditoria)';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.fec_registro IS
    'Fecha que se realiza el registro (auditoria)';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.cod_usuario_modifico IS
    'Usuario que realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.fec_modifico IS
    'Fecha que se realiza la modificación del registro (auditoria)';

COMMENT ON COLUMN SDAI_OWNER.SDAI_ARTICULO.LOG_ACTIVO IS
    'Estado del registro (Activo=0, Inactivo=1)';
    
---INDEX
CREATE INDEX SDAI_OWNER.SDAI_ARTICULO_PK ON SDAI_OWNER.SDAI_ARTICULO (COD_ARTICULO) TABLESPACE INDICES_01 ;
---PK
ALTER TABLE SDAI_OWNER.SDAI_ARTICULO ADD PRIMARY KEY (COD_ARTICULO) USING INDEX SDAI_OWNER.SDAI_ARTICULO_PK  ENABLE;
---SECUENCIA
CREATE SEQUENCE SDAI_OWNER.SEC_SDAI_ARTICULO START WITH 1 NOCACHE ORDER ;
---TRIGER
CREATE OR REPLACE TRIGGER SDAI_OWNER.SDAI_ARTICULO_BII_TRG_01 
BEFORE INSERT ON SDAI_OWNER.SDAI_ARTICULO 
FOR EACH ROW 
WHEN (NEW.COD_ARTICULO IS NULL) 
BEGIN
:new.COD_ARTICULO := SEC_SDAI_ARTICULO.nextval;
end;

