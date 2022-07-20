/*==============================================================*/
/* Table: CORE_ESTADO                                           */
/*==============================================================*/
create table CORE_OWNER.CORE_ESTADO (
   COD_ESTADO           NUMBER                not null,
   DSC_ESTADO           VARCHAR2(70)          not null,
   COD_CATALOGO         NUMBER                not null,
   COD_USUARIO_REGISTRO VARCHAR2(100),
   FEC_REGISTRO         DATE,
   COD_USUARIO_MODIFICO VARCHAR2(100),
   FEC_MODIFICO         DATE,
   LOG_ACTIVO           CHAR(1)
   --constraint CORE_ESTADO_PK primary key (COD_ESTADO)
) tablespace DATOS_01;
/

CREATE INDEX CORE_OWNER.CORE_ESTADO_PK ON CORE_OWNER.CORE_ESTADO (COD_ESTADO) TABLESPACE INDICES_01 ;
ALTER TABLE CORE_OWNER.CORE_ESTADO ADD PRIMARY KEY (COD_ESTADO) USING INDEX CORE_OWNER.CORE_ESTADO_PK  ENABLE;

comment on column CORE_OWNER.CORE_ESTADO.COD_ESTADO is
'Código del estado del sistema'
;

comment on column CORE_OWNER.CORE_ESTADO.DSC_ESTADO is
'Descripción del estado del sistema'
;

comment on column CORE_OWNER.CORE_ESTADO.COD_CATALOGO is
'Descripción del parametro ó módulo correspondiente del estado'
;

comment on column CORE_OWNER.CORE_ESTADO.COD_USUARIO_REGISTRO is
'Usuario que realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_ESTADO.FEC_REGISTRO is
'Fecha que se realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_ESTADO.COD_USUARIO_MODIFICO is
'Usuario que realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_ESTADO.FEC_MODIFICO is
'Fecha que se realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_ESTADO.LOG_ACTIVO is
'Estado del registro (Activo=0, Inactivo=1)'
;

alter table CORE_OWNER.CORE_ESTADO
   add constraint CORE_ESTADO_FK_01 foreign key (COD_CATALOGO)
      references CORE_OWNER.CORE_CATALOGO (COD_CATALOGO);
/

create or replace trigger CORE_OWNER.CORE_ESTADO_BII_TRG_01
 before insert on CORE_OWNER.CORE_ESTADO
FOR EACH ROW 
WHEN (NEW.COD_ESTADO IS NULL) 
BEGIN
:new.cod_estado := sec_CORE_ESTADO.nextval;

end;
/
