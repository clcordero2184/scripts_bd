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
CREATE OR REPLACE TRIGGER SDAI_ARTICULO_BII_TRG_01 
BEFORE INSERT ON SDAI_ARTICULO 
FOR EACH ROW 
WHEN (NEW.COD_ARTICULO IS NULL) 
BEGIN
:new.COD_ARTICULO := SEC_SDAI_ARTICULO.nextval;
end;


--INSERT
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-01-0032','Lentes bifocal más aro pasta de niño (a), dos lentes de proceso.',19,23,11,12610,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-01-0033','Lentes bifocal más aro pasta de niño (a), dos lentes terminados.',21,23,11,8170,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-01-0034','Lentes bifocal más aro pasta de niño (a), un lente terminado y un lente de proceso.',20,23,11,10390,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0001','Lente plástico blanco simple, dos lentes de proceso.',19,24,26,8960,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0002','Lente plástico blanco simple, dos lentes terminados.',21,24,26,4250,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0003','Lente plástico blanco simple, un lente de proceso y un terminado.',20,24,26,6600,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0004','Plástico blanco bifocal, dos lentes de proceso.',19,23,26,9090,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0005','Plástico blanco bifocal, dos lentes terminados.',21,23,26,4650,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0006','Plástico blanco bifocal, un lente de proceso y un lente terminado.',20,23,26,6870,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0007','Lentes simple más aro pasta, dos lentes de proceso.',19,24,12,11190,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0008','Lentes simple más aro pasta, dos lentes terminados',21,24,12,6490,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0009','Lentes simple más aro pasta, un lente terminado y un lente de proceso.',20,24,12,8840,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0010','Lentes bifocal más aro pasta, dos lentes de proceso.',19,23,12,11320,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0011','Lentes bifocal más aro pasta, dos lentes terminados.',21,23,12,6880,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0012','Lentes bifocal más aro pasta, un lente terminado y un lente de proceso.',20,23,12,9100,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0013','Lentes simples más aro metal, dos lentes de proceso.',19,24,13,10700,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0014','Lentes simples más aro metal, dos lentes terminados.',21,24,13,5990,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0015','Lentes simples más aro metal, un lente terminado y un lente de proceso.',20,24,13,8350,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0016','Lentes bifocal más aro metal, dos lentes de proceso',19,23,13,10830,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0017','Lentes bifocal más aro metal, dos lentes terminados.',21,23,13,6390,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0018','Lentes bifocal más aro metal, un lente terminado y un lente de proceso',20,23,13,8610,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0019','Lenticular plástico simple.',19,22,26,27270,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0020','Lenticular plástico simple más aro de pasta.',19,22,12,29510,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0021','Lenticular plástico simple más aro de metal.',19,22,13,29020,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0022','Lenticular plástico bifocal',19,25,26,27270,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0023','Lenticular plástico bifocal más aro pasta.',19,25,12,29510,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0024','Lenticular plástico bifocal más aro metal.',19,25,13,29020,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0025','Teñido de Lentes',71,70,26,800,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0026','Solo aro de pasta adulto',71,70,12,1620,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0027','Solo aro de metal adulto',71,71,13,1180,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0028','Lentes simple más aro pasta de niño (a), dos lentes de proceso.',19,24,11,12480,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0029','Lentes simple más aro pasta de niño (a), dos lentes terminados.',21,24,11,7780,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0030','Lentes simple más aro pasta de niño (a), un lente terminado y un lente de proceso.',20,24,11,10130,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);
Insert into SDAI_ARTICULO (COD_SIGES, DSC_ARTICULO,  TIP_CONDICION, TIP_LENTE, TIP_ARO, MON_COSTO, COD_USUARIO_REGISTRO, FEC_REGISTRO, COD_USUARIO_MODIFICO, FEC_MODIFICO, LOG_ACTIVO) values ('2-91-31-0031','Solo aro de pasta para niño (a)',71,70,11,2780,'Rafael Gamboa Molina (rggamboa)',TO_date('04/04/2022','DD/MM/YYYY'),'Rafael Gamboa Molina (rggamboa)',TO_date('08/07/2022','DD/MM/YYYY'),1);


    