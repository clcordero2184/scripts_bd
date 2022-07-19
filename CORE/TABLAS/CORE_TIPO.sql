/*==============================================================*/
/* Table: CORE_TIPO                                             */
/*==============================================================*/
create table CORE_OWNER.CORE_TIPO (
   TIP_TIPO             NUMBER                not null,
   DSC_TIPO             VARCHAR2(70)          not null,
   COD_CATALOGO         NUMBER                not null,
   COD_USUARIO_REGISTRO VARCHAR2(100),
   FEC_REGISTRO         DATE,
   COD_USUARIO_MODIFICO VARCHAR2(100),
   FEC_MODIFICO         DATE,
   LOG_ACTIVO           CHAR(1)
   --constraint CORE_TIPO_PK primary key (TIP_TIPO)
) tablespace DATOS_01;
/

CREATE INDEX CORE_OWNER.CORE_TIPO_PK ON CORE_OWNER.CORE_TIPO (TIP_TIPO) TABLESPACE INDICES_01 ;
ALTER TABLE CORE_OWNER.CORE_TIPO ADD PRIMARY KEY (TIP_TIPO) USING INDEX CORE_OWNER.CORE_TIPO_PK  ENABLE;


comment on column CORE_OWNER.CORE_TIPO.TIP_TIPO is
'Código del tipo de sistema'
;

comment on column CORE_OWNER.CORE_TIPO.DSC_TIPO is
'Descripción del tipo de sistema'
;

comment on column CORE_OWNER.CORE_TIPO.COD_CATALOGO is
'Descripción del módulo del tipo de sistema'
;

comment on column CORE_OWNER.CORE_TIPO.COD_USUARIO_REGISTRO is
'Usuario que realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_TIPO.FEC_REGISTRO is
'Fecha que se realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_TIPO.COD_USUARIO_MODIFICO is
'Usuario que realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_TIPO.FEC_MODIFICO is
'Fecha que se realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_TIPO.LOG_ACTIVO is
'Estado del registro (Activo=0, Inactivo=1)'
;

alter table CORE_OWNER.CORE_TIPO
   add constraint CORE_TIPO_FK_01 foreign key (COD_CATALOGO)
      references CORE_OWNER.CORE_CATALOGO (COD_CATALOGO);

create or replace trigger CORE_OWNER.CORE_TIPO_BII_TRG_01
 before insert on CORE_OWNER.CORE_TIPO
FOR EACH ROW 
WHEN (NEW.TIP_TIPO IS NULL) 
BEGIN
:new.TIP_TIPO := sec_CORE_tipo.nextval;

end;
/