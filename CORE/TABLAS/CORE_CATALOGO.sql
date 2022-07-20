/*==============================================================*/
/* Table: CORE_CATALOGO                                         */
/*==============================================================*/
create table CORE_OWNER.CORE_CATALOGO (
   COD_CATALOGO         NUMBER                not null,
   DSC_CATALOGO         VARCHAR2(50)          not null,
   DSC_MODULO           VARCHAR2(50)              not null,
   COD_USUARIO_REGISTRO VARCHAR2(100),
   FEC_REGISTRO         DATE,
   COD_USUARIO_MODIFICO VARCHAR2(100),
   FEC_MODIFICO         DATE,
   LOG_ACTIVO           CHAR(1)
   --constraint CORE_CATALOGO_PK primary key (COD_CATALOGO)
) tablespace DATOS_01;
/


CREATE INDEX CORE_OWNER.CORE_CATALOGO_PK ON CORE_OWNER.CORE_CATALOGO (COD_CATALOGO) TABLESPACE INDICES_01 ;
ALTER TABLE CORE_OWNER.CORE_CATALOGO ADD PRIMARY KEY (COD_CATALOGO) USING INDEX CORE_OWNER.CORE_CATALOGO_PK  ENABLE;
  
comment on column CORE_OWNER.CORE_CATALOGO.COD_CATALOGO is
'Consecutivo de catálogos (autoincremental)'
;

comment on column CORE_OWNER.CORE_CATALOGO.DSC_CATALOGO is
'Descripción del catálogos'
;

comment on column CORE_OWNER.CORE_CATALOGO.DSC_MODULO is
'Descripción al módulo correspondiente (DA, OP, GL, CF)'
;

comment on column CORE_OWNER.CORE_CATALOGO.COD_USUARIO_REGISTRO is
'Usuario que realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_CATALOGO.FEC_REGISTRO is
'Fecha que se realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_CATALOGO.COD_USUARIO_MODIFICO is
'Usuario que realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_CATALOGO.FEC_MODIFICO is
'Fecha que se realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_CATALOGO.LOG_ACTIVO is
'Estado del registro (Activo=0, Inactivo=1)'
;

create or replace trigger CORE_OWNER.CORE_CATALOGO_BII_TRG_01
 before insert on CORE_OWNER.CORE_CATALOGO
FOR EACH ROW 
WHEN (NEW.COD_CATALOGO IS NULL) 
BEGIN
:new.cod_catalogo := sec_CORE_CATALOGO.nextval;

end;
/