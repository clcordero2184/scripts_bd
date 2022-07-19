
-- borrado de tablas

DROP TABLE SIOP_catalogos CASCADE CONSTRAINTS;

DROP TABLE SIOP_estados CASCADE CONSTRAINTS;

DROP TABLE SIOP_parametros CASCADE CONSTRAINTS;

DROP TABLE SIOP_personas CASCADE CONSTRAINTS;

DROP TABLE SIOP_tipos CASCADE CONSTRAINTS;

DROP TABLE siop_liners CASCADE CONSTRAINTS;

DROP TABLE siop_pies CASCADE CONSTRAINTS;

DROP TABLE siop_recetas CASCADE CONSTRAINTS;

DROP TABLE siop_recetas_detalle CASCADE CONSTRAINTS;

DROP TABLE siop_valoraciones_protesicas CASCADE CONSTRAINTS;

--borrado de swecuencias

drop sequence sec_SIOP_catalogos;
commit;

drop sequence sec_SIOP_estados;
commit;

drop sequence sec_SIOP_parametros;
commit;

drop sequence sec_SIOP_tipos;
commit;

drop sequence sec_sdai_recetas;
commit;

drop sequence sec_siop_recetas;
commit;

drop sequence sec_siop_detalle_receta;
commit;

drop sequence sec_siop_liner;
commit;

drop sequence sec_siop_pies;
commit;

drop sequence sec_siop_valoraciones_protesic;
commit;
