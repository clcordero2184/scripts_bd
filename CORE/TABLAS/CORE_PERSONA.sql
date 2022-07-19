/*==============================================================*/
/* Table: CORE_PERSONA                                          */
/*==============================================================*/
create table CORE_OWNER.CORE_PERSONA (
   TIP_IDENTIFICACION   NUMBER                not null,
   NUM_IDENTIFICACION   VARCHAR2(60)          not null,
   NOM_PERSONA          VARCHAR2(60)          not null,
   NOM_APELLIDO1        VARCHAR2(60)          not null,
   NOM_APELLIDO2        VARCHAR2(60)          not null,
   FEC_NACIMIENTO       DATE                  not null,
   COD_GENERO           CHAR(1)               not null,
   NUM_CELULAR          VARCHAR2(9 CHAR),
   NUM_HABITACION       VARCHAR2(9 CHAR),
   DSC_EMAIL            VARCHAR2(255),
   COD_USUARIO_REGISTRO VARCHAR2(100),
   FEC_REGISTRO         DATE,
   COD_USUARIO_MODIFICO VARCHAR2(100),
   FEC_MODIFICO         DATE,
   LOG_ACTIVO           CHAR(1)
  -- constraint CORE_PERSONA_PK primary key (TIP_IDENTIFICACION, NUM_IDENTIFICACION)
) tablespace DATOS_01;
/

CREATE INDEX CORE_OWNER.CORE_PERSONA_PK ON CORE_OWNER.CORE_PERSONA (TIP_IDENTIFICACION, NUM_IDENTIFICACION) TABLESPACE INDICES_01 ;
ALTER TABLE CORE_OWNER.CORE_PERSONA ADD PRIMARY KEY (TIP_IDENTIFICACION, NUM_IDENTIFICACION) USING INDEX CORE_OWNER.CORE_PERSONA_PK  ENABLE;

comment on column CORE_OWNER.CORE_PERSONA.TIP_IDENTIFICACION is
'Tipo de identificación (nacional, extranjero, asegurado)'
;

comment on column CORE_OWNER.CORE_PERSONA.NUM_IDENTIFICACION is
'Número de identificación único de la persona'
;

comment on column CORE_OWNER.CORE_PERSONA.NOM_PERSONA is
'Nombre de la persona, se incluye ambos nombres'
;

comment on column CORE_OWNER.CORE_PERSONA.NOM_APELLIDO1 is
'Primer apellido de la persona'
;

comment on column CORE_OWNER.CORE_PERSONA.NOM_APELLIDO2 is
'Segundo apellido de la persona.'
;

comment on column CORE_OWNER.CORE_PERSONA.FEC_NACIMIENTO is
'Fecha de nacimiento de la persona.'
;

comment on column CORE_OWNER.CORE_PERSONA.COD_GENERO is
'Código de genero de la persona (F= Femenino, M=Masculino, I=Indefinido)'
;

comment on column CORE_OWNER.CORE_PERSONA.NUM_CELULAR is
'Número de celular de la persona'
;

comment on column CORE_OWNER.CORE_PERSONA.NUM_HABITACION is
'Número de celular de la persona'
;

comment on column CORE_OWNER.CORE_PERSONA.COD_USUARIO_REGISTRO is
'Usuario que realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_PERSONA.FEC_REGISTRO is
'Fecha que se realiza el registro (auditoria)'
;

comment on column CORE_OWNER.CORE_PERSONA.COD_USUARIO_MODIFICO is
'Usuario que realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_PERSONA.FEC_MODIFICO is
'Fecha que se realiza la modificación del registro (auditoria)'
;

comment on column CORE_OWNER.CORE_PERSONA.LOG_ACTIVO is
'Estado del registro (Activo=0, Inactivo=1)'
;

