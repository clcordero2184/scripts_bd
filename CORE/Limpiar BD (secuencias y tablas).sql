drop trigger CORE_OWNER.CORE_CATALOGO_BII_TRG_01;
/

drop trigger CORE_OWNER.CORE_ESTADO_BII_TRG_01;
/

drop trigger CORE_OWNER.CORE_PARAMETRO_BII_TRG_01;
/

drop trigger CORE_OWNER.CORE_TIPO_BII_TRG_01;
/

alter table CORE_OWNER.CORE_ESTADO
   drop constraint CORE_ESTADO_FK_01;
/

alter table CORE_OWNER.CORE_TIPO
   drop constraint CORE_TIPO_FK_01;
/

drop table CORE_OWNER.CORE_CATALOGO cascade constraints;
/

drop table CORE_OWNER.CORE_ESTADO cascade constraints;
/

drop table CORE_OWNER.CORE_PARAMETRO cascade constraints;
/

drop table CORE_OWNER.CORE_PERSONA cascade constraints;
/

drop table CORE_OWNER.CORE_TIPO cascade constraints;
/

drop table CORE_OWNER.CORE_UNIDAD_PROGRAMATICA cascade constraints;
/


drop sequence CORE_OWNER.SEC_CORE_CATALOGO;
/

drop sequence CORE_OWNER.SEC_CORE_ESTADO;
/

drop sequence CORE_OWNER.SEC_CORE_PARAMETRO;
/

drop sequence CORE_OWNER.SEC_CORE_TIPO;
/

create sequence CORE_OWNER.SEC_CORE_CATALOGO START WITH 1     NOCACHE     ORDER;
/

create sequence CORE_OWNER.SEC_CORE_ESTADO START WITH 1 NOCACHE ORDER;
/

create sequence CORE_OWNER.SEC_CORE_PARAMETRO START WITH 1    NOCACHE ORDER;
/

create sequence CORE_OWNER.SEC_CORE_TIPO START WITH 1 NOCACHE   ORDER;
/