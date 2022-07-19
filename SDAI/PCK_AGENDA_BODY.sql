create or replace PACKAGE BODY                       PCK_AGENDAS IS 
--CUERPO DEL PAQUETE

    PROCEDURE SP_AGENDAS_GETBY_FEC_AGENDA_AND_COD_ESTADO (
        P_OUT_JSON      OUT CLOB,
        P_OUT_RESULTADO OUT INTEGER,
        P_OUT_DETALLE   OUT VARCHAR2,
        P_IN_FEC_AGENDA IN DATE,
        P_IN_COD_ESTADO IN NUMBER
    ) AS
    
-- Se crean variables de confirmación para el resultado correspondiente
        V_CONFIRMACION_EXITOSA NUMBER(1) := 1;
        V_CONFIRMACION_ERRONEA NUMBER(1) := 0;
    BEGIN

-- se carga la informacion en un arreglo de objetos JSON
        SELECT
            JSON_ARRAYAGG(
                JSON_OBJECT
            ('conAgenda' VALUE SAGE.CON_AGENDA, 'fecAgenda' VALUE SAGE.FEC_AGENDA, 'horAgenda' VALUE SAGE.HOR_AGENDA, 'codEstado' VALUE
            SAGE.COD_ESTADO, 'dscEstado' VALUE CEST.DSC_ESTADO, 'numIdentificacion' VALUE SAGE.NUM_IDENTIFICACION, 'nomPersona' VALUE
            CPER.NOM_PERSONA, 'nomApellido1' VALUE CPER.NOM_APELLIDO1, 'nomApellido2' VALUE CPER.NOM_APELLIDO2, 'codGenero' VALUE CPER.
            COD_GENERO, 'numCelular' VALUE CPER.NUM_CELULAR, 'numHabitacion' VALUE CPER.NUM_HABITACION, 'dscEmail' VALUE CPER.DSC_EMAIL,
            'tipAgenda' VALUE SAGE.TIP_AGENDA, 'dscTipo' VALUE CTIP.DSC_TIPO, 'codUnidadProgramatica' VALUE SAGE.COD_UNIDAD_PROGRAMATICA,
            'codUnidadAdscripcion' VALUE SAGE.COD_UNIDAD_ADSCRIPCION, 'fecModifico' VALUE SAGE.FEC_MODIFICO, 'codUsuarioModifico' VALUE
            SAGE.COD_USUARIO_MODIFICO, 'logActivo' VALUE SAGE.LOG_ACTIVO)
            ORDER BY
                SAGE.HOR_AGENDA
            RETURNING CLOB)
        INTO P_OUT_JSON
        FROM
            SDAI_OWNER.SDAI_AGENDA SAGE
            INNER JOIN CORE_OWNER.CORE_PERSONA CPER ON SAGE.NUM_IDENTIFICACION = CPER.NUM_IDENTIFICACION
            INNER JOIN CORE_OWNER.CORE_ESTADO  CEST ON SAGE.COD_ESTADO = CEST.COD_ESTADO
            INNER JOIN CORE_OWNER.CORE_TIPO    CTIP ON SAGE.TIP_AGENDA = CTIP.TIP_TIPO
        WHERE
            SAGE.FEC_AGENDA = P_IN_FEC_AGENDA
            AND NVL(
                SAGE.COD_ESTADO, 0
            ) = CASE
                WHEN P_IN_COD_ESTADO IS NULL
                     OR P_IN_COD_ESTADO = 0 THEN
                NVL(
                    SAGE.COD_ESTADO, 0
                )
                ELSE
                P_IN_COD_ESTADO
                END;

        P_OUT_RESULTADO := V_CONFIRMACION_EXITOSA;
        IF P_OUT_JSON IS NULL THEN
            P_OUT_JSON := '[]';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            P_OUT_RESULTADO := V_CONFIRMACION_ERRONEA;
            P_OUT_DETALLE := 'SDAI --> ERROR - SP_AGENDAS_GETBY_FEC_AGENDA_AND_COD_ESTADO P_IN_FEC_AGENDA: '
                             || P_IN_FEC_AGENDA
                             || '  P_IN_COD_ESTADO: '
                             || P_IN_COD_ESTADO
                             || ', '
                             || SQLCODE
                             || ' -ERROR- '
                             || SQLERRM;

    END SP_AGENDAS_GETBY_FEC_AGENDA_AND_COD_ESTADO;

    PROCEDURE SP_AGENDAS_GETBY_FEC_AGENDA_AND_COD_ESTADO (
        P_OUT_RESULTADO OUT NUMBER,
        P_OUT_DETALLE   OUT VARCHAR2,
        P_OUT_CURSOR    OUT SYS_REFCURSOR,
        P_IN_FEC_AGENDA IN DATE,
        P_IN_COD_ESTADO IN NUMBER
    ) AS

-- Se crean variables de confirmación para el resultado correspondiente
        V_CONFIRMACION_EXITOSA NUMBER(1) := 1;
        V_CONFIRMACION_ERRONEA NUMBER(1) := 0;
    BEGIN

-- se carga la informacion en un cursor
        OPEN P_OUT_CURSOR FOR SELECT
                                  SAGE.CON_AGENDA              AS CON_AGENDA,
                                  SAGE.FEC_AGENDA              AS FEC_AGENDA,
                                  SAGE.HOR_AGENDA              AS HOR_AGENDA,
                                  SAGE.COD_ESTADO              AS COD_ESTADO,
                                  CEST.DSC_ESTADO              AS DSC_ESTADO,
                                  SAGE.TIP_IDENTIFICACION      AS TIP_IDENTIFICACION,
                                  SAGE.NUM_IDENTIFICACION      AS NUM_IDENTIFICACION,
                                  CPER.NOM_PERSONA             AS NOM_PERSONA,
                                  CPER.NOM_APELLIDO1           AS NOM_APELLIDO1,
                                  CPER.NOM_APELLIDO2           AS NOM_APELLIDO2,
                                  CPER.COD_GENERO              AS COD_GENERO,
                                  CPER.NUM_CELULAR             AS NUM_CELULAR,
                                  CPER.NUM_HABITACION          AS NUM_HABITACION,
                                  CPER.DSC_EMAIL               AS DSC_EMAIL,
                                  SAGE.LOG_ACTIVO              AS LOG_ACTIVO,
                                  SAGE.TIP_AGENDA              AS TIP_AGENDA,
                                  CTIP.DSC_TIPO                AS DSC_TIPO,
                                  SAGE.COD_UNIDAD_PROGRAMATICA AS COD_UNIDAD_PROGRAMATICA,
                                  SAGE.COD_UNIDAD_ADSCRIPCION  AS COD_UNIDAD_ADSCRIPCION
                              FROM
                                  SDAI_OWNER.SDAI_AGENDA SAGE
                                  INNER JOIN CORE_OWNER.CORE_PERSONA CPER ON SAGE.NUM_IDENTIFICACION = CPER.NUM_IDENTIFICACION
                                  INNER JOIN CORE_OWNER.CORE_ESTADO  CEST ON SAGE.COD_ESTADO = CEST.COD_ESTADO
                                  INNER JOIN CORE_OWNER.CORE_TIPO    CTIP ON SAGE.TIP_AGENDA = CTIP.TIP_TIPO
                              WHERE
                                  SAGE.FEC_AGENDA = P_IN_FEC_AGENDA
                              -- sies null que lo haga cero
                                  AND NVL(
                                      SAGE.COD_ESTADO, 0
                                  ) = CASE
                                      WHEN P_IN_COD_ESTADO IS NULL
                                           OR P_IN_COD_ESTADO = 0 THEN
                                      NVL(
                                          SAGE.COD_ESTADO, 0
                                      )
                                      ELSE
                                      P_IN_COD_ESTADO
                                      END
                              ORDER BY
                                  SAGE.HOR_AGENDA ASC;

        P_OUT_RESULTADO := V_CONFIRMACION_EXITOSA;  -- SE SETEA CON LA CONSULTA FUE CORRECTA
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            P_OUT_RESULTADO := V_CONFIRMACION_ERRONEA; -- CUANDO ES ERROR SE SETEA A ERRONEA
            P_OUT_DETALLE := 'SDAI --> ERROR - SP_AGENDA_LISTAR_CITAS '
                             || ' P_IN_FEC_AGENDA: '
                             || P_IN_FEC_AGENDA
                             || ' '
                             || ' P_IN_COD_ESTADO: '
                             || P_IN_COD_ESTADO
                             || ' '
                             || SQLCODE
                             || ' -ERROR- '
                             || SQLERRM;

            RAISE_APPLICATION_ERROR(
                                   -20001,
                                   P_OUT_DETALLE
            );
    END SP_AGENDAS_GETBY_FEC_AGENDA_AND_COD_ESTADO;

 --PROCEDIMIENTO CON SALIDA EN FORMATO JSON
    PROCEDURE SP_AGENDAS_GETBY_NUM_IDENTIFICACION_AND_COD_ESTADO (
        P_OUT_JSON              OUT CLOB,
        P_OUT_RESULTADO         OUT INTEGER,
        P_OUT_DETALLE           OUT VARCHAR2,
        P_IN_NUM_IDENTIFICACION IN VARCHAR2,
        P_IN_COD_ESTADO         IN NUMBER
    ) AS

-- SE CREAN VARIABLES 
        V_CONFIRMACION_EXITOSA NUMBER(1) := 1;
        V_CONFIRMACION_ERRONEA NUMBER(1) := 0;
    BEGIN

-- se carga la informacion en un arreglo de objetos JSON
        SELECT
            JSON_ARRAYAGG(
                JSON_OBJECT
            ('conAgenda' VALUE SAGE.CON_AGENDA, 'fecAgenda' VALUE SAGE.FEC_AGENDA, 'horAgenda' VALUE SAGE.HOR_AGENDA, 'codEstado' VALUE
            SAGE.COD_ESTADO, 'dscEstado' VALUE CEST.DSC_ESTADO, 'numIdentificacion' VALUE SAGE.NUM_IDENTIFICACION, 'nomPersona' VALUE
            CPER.NOM_PERSONA, 'nomApellido1' VALUE CPER.NOM_APELLIDO1, 'nomApellido2' VALUE CPER.NOM_APELLIDO2, 'codGenero' VALUE CPER.
            COD_GENERO, 'numCelular' VALUE CPER.NUM_CELULAR, 'numHabitacion' VALUE CPER.NUM_HABITACION, 'dscEmail' VALUE CPER.DSC_EMAIL,
            'tipAgenda' VALUE SAGE.TIP_AGENDA, 'dscTipo' VALUE CTIP.DSC_TIPO, 'codUnidadProgramatica' VALUE SAGE.COD_UNIDAD_PROGRAMATICA,
            'codUnidadAdscripcion' VALUE SAGE.COD_UNIDAD_ADSCRIPCION, 'fecModifico' VALUE SAGE.FEC_MODIFICO, 'codUsuarioModifico' VALUE
            SAGE.COD_USUARIO_MODIFICO, 'logActivo' VALUE SAGE.LOG_ACTIVO) RETURNING CLOB)
        INTO P_OUT_JSON
        FROM
            SDAI_OWNER.SDAI_AGENDA SAGE
            INNER JOIN CORE_OWNER.CORE_PERSONA CPER ON SAGE.NUM_IDENTIFICACION = CPER.NUM_IDENTIFICACION
            INNER JOIN CORE_OWNER.CORE_ESTADO  CEST ON SAGE.COD_ESTADO = CEST.COD_ESTADO
            INNER JOIN CORE_OWNER.CORE_TIPO    CTIP ON SAGE.TIP_AGENDA = CTIP.TIP_TIPO
        WHERE
            SAGE.NUM_IDENTIFICACION = P_IN_NUM_IDENTIFICACION
            AND NVL(
                SAGE.COD_ESTADO, 0
            ) = CASE
                WHEN P_IN_COD_ESTADO IS NULL
                     OR P_IN_COD_ESTADO = 0 THEN
                NVL(
                    SAGE.COD_ESTADO, 0
                )
                ELSE
                P_IN_COD_ESTADO
                END
        ORDER BY
            SAGE.HOR_AGENDA ASC;

        P_OUT_RESULTADO := V_CONFIRMACION_EXITOSA;
        IF P_OUT_JSON IS NULL THEN
            P_OUT_JSON := '[]';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            P_OUT_RESULTADO := V_CONFIRMACION_ERRONEA;
            P_OUT_DETALLE := 'SDAI --> ERROR - SP_AGENDAS_GETBY_IDENTIFICACION_AND_ESTADO '
                             || ' p_in_num_identificacion: '
                             || P_IN_NUM_IDENTIFICACION
                             || ' '
                             || ' P_IN_COD_ESTADO: '
                             || P_IN_COD_ESTADO
                             || ' '
                             || SQLCODE
                             || ' -ERROR- '
                             || SQLERRM;

    END SP_AGENDAS_GETBY_NUM_IDENTIFICACION_AND_COD_ESTADO;

    PROCEDURE SP_AGENDAS (
        P_OUT_JSON      OUT CLOB,
        P_OUT_RESULTADO OUT INTEGER,
        P_OUT_DETALLE   OUT VARCHAR2
    ) AS

-- SE CREAN VARIABLES 
        V_CONFIRMACION_EXITOSA NUMBER(1) := 1;
        V_CONFIRMACION_ERRONEA NUMBER(1) := 0;
    BEGIN
        SELECT
            JSON_ARRAYAGG(
                JSON_OBJECT(
                    'conAgenda' VALUE SAGE.CON_AGENDA
                )
            RETURNING CLOB)
        INTO P_OUT_JSON
        FROM
            SDAI_OWNER.SDAI_AGENDA SAGE;

        P_OUT_RESULTADO := V_CONFIRMACION_EXITOSA;
        IF P_OUT_JSON IS NULL THEN
            P_OUT_JSON := '[]';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            P_OUT_RESULTADO := V_CONFIRMACION_ERRONEA;
            P_OUT_DETALLE := 'SDAI --> ERROR - SP_AGENDAS '
                             || ' '
                             || SQLCODE
                             || ' -ERROR- '
                             || SQLERRM;
    END SP_AGENDAS;

END PCK_AGENDAS;