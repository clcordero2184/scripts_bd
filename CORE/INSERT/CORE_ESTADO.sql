--BORRAR LA SECUENCIA PARA QUE NO PROBLEMAS
drop sequence CORE_OWNER.SEC_CORE_ESTADO;
commit;

--DESHABILITAR EL TRIGGER
alter trigger CORE_OWNER.CORE_ESTADO_BII_TRG_01 disable;
commit;

--BORRAR LOS DATOS DE LA TABLA
delete from CORE_OWNER.CORE_ESTADO;
commit;

-- INSERT EN LA TABLA ESTADO

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(1,'Agendada',1,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(2,'Ausente',1,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(3,'Presente',1,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(4,'Cancelada',1,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(5,'Atendida',2,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(6,'Todas',1,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(7,'Pendiente tramitar',2,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(8,'Digitada',2,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(9,'Caducada',2,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(10,'Terminada',2,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

-- INSERT EN LA TABLA ESTADOS PARA SIOP
INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(11,'Aprobada',16,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(12,'Rechazada',16,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

INSERT INTO CORE_OWNER.CORE_ESTADO (COD_ESTADO,DSC_ESTADO,COD_CATALOGO, COD_USUARIO_REGISTRO, FEC_REGISTRO, LOG_ACTIVO) VALUES 
(13,'Enviada',16,'Claudio Gerardo Cordero Soto (ccorderos)',TO_date('08/03/2022','DD/MM/YYYY'),0);
commit;

--CREAR LA SECUENCIA NUEVAMENTE EN EL VALOR FINAL
CREATE SEQUENCE CORE_OWNER.SEC_CORE_ESTADO START WITH 14 NOCACHE ORDER ;

--HABILITAR EL TRIGGER
alter trigger CORE_OWNER.CORE_ESTADO_BII_TRG_01 enable;
commit;

CREATE OR REPLACE TRIGGER CORE_OWNER.CORE_ESTADO_BII_TRG_01 
BEFORE INSERT ON CORE_OWNER.CORE_ESTADO 
FOR EACH ROW 
WHEN (NEW.COD_ESTADO IS NULL) 
BEGIN
:new.cod_estado := sec_CORE_ESTADO.nextval;

end;
/