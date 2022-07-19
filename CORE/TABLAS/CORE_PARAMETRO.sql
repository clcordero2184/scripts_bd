/*==============================================================*/
/* Table: CORE_PARAMETRO                                       */
/*==============================================================*/
create table CORE_OWNER.CORE_PARAMETRO (
   COD_PARAMETRO        NUMBER                not null,
   DSC_CORTA_PARAMETRO  VARCHAR2(30)          not null,
   DSC_PARAMETRO        VARCHAR2(150)         not null,
   COD_CATALOGO         NUMBER                not null,
   DSC_VALOR            VARCHAR (2000)        not null
      constraint ENSURE_JSON check (dsc_valor IS JSON),
   COD_USUARIO_REGISTRO VARCHAR2(100),
   FEC_REGISTRO         DATE,
   COD_USUARIO_MODIFICO VARCHAR2(100),
   FEC_MODIFICO         DATE,
   LOG_ACTIVO           CHAR(1)
   --constraint CORE_PARAMETRO_PK primary key (COD_PARAMETRO)
) tablespace DATOS_01;
/

CREATE INDEX CORE_OWNER.CORE_PARAMETRO_PK ON CORE_OWNER.CORE_PARAMETRO (COD_PARAMETRO) TABLESPACE INDICES_01 ;
ALTER TABLE CORE_OWNER.CORE_PARAMETRO ADD PRIMARY KEY (COD_PARAMETRO) USING INDEX CORE_OWNER.CORE_PARAMETRO_PK  ENABLE;

comment on column CORE_OWNER.CORE_PARAMETRO.COD_PARAMETRO is
'Código de parametro (autoincremental)'
;

comment on column CORE_OWNER.CORE_PARAMETRO.DSC_CORTA_PARAMETRO is
'Nombre corto del parámetro'
;

comment on column CORE_OWNER.CORE_PARAMETRO.DSC_PARAMETRO is
'Descripción general del parámetro'
;

comment on column CORE_OWNER.CORE_PARAMETRO.COD_CATALOGO is
'Nombre del tipo de módulo del sistema donde pertenece'
;

comment on column CORE_OWNER.CORE_PARAMETRO.DSC_VALOR is
'Valor que tiene el parámetro para uso del sistema'
;

comment on column CORE_OWNER.CORE_PARAMETRO.COD_USUARIO_REGISTRO is
'Usuario que realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_PARAMETRO.FEC_REGISTRO is
'Fecha que se realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_PARAMETRO.COD_USUARIO_MODIFICO is
'Usuario que realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_PARAMETRO.FEC_MODIFICO is
'Fecha que se realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_PARAMETRO.LOG_ACTIVO is
'Estado del registro (Activo=0, Inactivo=1)'
;

create or replace trigger CORE_OWNER.CORE_PARAMETRO_BII_TRG_01
 before insert on CORE_OWNER.CORE_PARAMETRO
FOR EACH ROW 
WHEN (NEW.COD_PARAMETRO IS NULL) 
BEGIN
:new.cod_parametro := sec_CORE_PARAMETRO.nextval;

end;
/