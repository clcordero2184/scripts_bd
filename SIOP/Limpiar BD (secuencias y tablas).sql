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
--  DDL for Limpiar la BD Completa
--------------------------------------------------------

--BORRADO DE TABLAS
DROP TABLE SIOP_OWNER.SIOP_LINER CASCADE CONSTRAINTS;
DROP TABLE SIOP_OWNER.SIOP_PIE CASCADE CONSTRAINTS;
DROP TABLE SIOP_OWNER.SIOP_RECETA CASCADE CONSTRAINTS;
DROP TABLE SIOP_OWNER.SIOP_RECETA_DETALLE CASCADE CONSTRAINTS;
DROP TABLE SIOP_OWNER.SIOP_VALORACION_PROTESICA CASCADE CONSTRAINTS;
COMMIT;

--BORRADO DE SECUENCIAS
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_RECETA;
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_RECETA_DETALLE;
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_LINER;
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_PIE;
DROP SEQUENCE SIOP_OWNER.SEC_SIOP_VALORACION_PROTESICA;
COMMIT;




