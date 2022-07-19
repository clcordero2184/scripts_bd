create or replace PACKAGE BODY                                             PCK_DIGITACION IS 

--PROCEDIMIENTO QUE LISTA LAS RESETAS POR NUMERO DE IDENTIFICACION
    PROCEDURE SP_RECETA_GETBY_IDENTIFICACION_DIGITACION (
        P_OUT_JSON              OUT CLOB,
        P_OUT_RESULTADO         OUT INTEGER,
        P_OUT_DETALLE           OUT VARCHAR2,
        P_IN_NUM_IDENTIFICACION IN VARCHAR2
    ) AS
-- SE CREAN VARIABLES 
        V_CONFIRMACION_EXITOSA NUMBER(1) := 1;
        V_CONFIRMACION_ERRONEA NUMBER(1) := 0;
    BEGIN

-- se carga la informacion en un arreglo de JSON y se cargan como json cada objeto
        SELECT
            JSON_ARRAYAGG(
                JSON_OBJECT
            ('conReceta'                     VALUE SREC.COD_RECETA,    
            'codRecetaEdus'                  VALUE SREC.COD_RECETA_EDUS, 
            'fecReceta'                      VALUE SREC.FEC_RECETA, 
            'codUnidadEmision'               VALUE SREC.COD_UNIDAD_EMISION, 
            'codUnidadAdscripcion'           VALUE SREC.COD_UNIDAD_ADSCRIPCION, 
            'tipIdentificacion'              VALUE SREC.TIP_IDENTIFICACION,
            'numIdentificacion'              VALUE SREC.NUM_IDENTIFICACION, 
            'tipLente'                       VALUE SREC.TIP_LENTE, 
            'descTipLente'                   VALUE CTIP.DSC_TIPO, 
            'canDioptriasEsfericoDer'        VALUE SREC.CAN_DIOPTRIAS_ESFERICO_DER, 
            'canDioptriasEsfericoIzq'        VALUE SREC.CAN_DIOPTRIAS_ESFERICO_IZQ, 
            'canDioptriasCilindricoDer'      VALUE SREC.CAN_DIOPTRIAS_CILINDRICO_DER, 
            'canDioptriasCilindricoIzq'      VALUE SREC.CAN_DIOPTRIAS_CILINDRICO_IZQ, 
            'canDioptriasEjeDer'             VALUE SREC.CAN_DIOPTRIAS_EJE_DER, 
            'canDioptriasEjeIzq'             VALUE SREC.CAN_DIOPTRIAS_EJE_IZQ, 
            'canDioptriasPrismaDer'          VALUE SREC.CAN_DIOPTRIAS_PRISMA_DER, 
            'canDioptriasPrismaIzq'          VALUE SREC.CAN_DIOPTRIAS_PRISMA_IZQ, 
            'canDioptriasAdicion'            VALUE SREC.CAN_DIOPTRIAS_ADICION, 
            'canDioptriasDistPupilar'        VALUE SREC.CAN_DIOPTRIAS_DIST_PUPILAR, 
            'canDioptriasDistNasopupilar'    VALUE SREC.CAN_DIOPTRIAS_DIST_NASOPUPILAR, 
            'tipMaterial'                    VALUE SREC.TIP_MATERIAL_LENTE, 
            'descMaterial'                   VALUE CTIM.DSC_TIPO, 
            'dscTono'                        VALUE SREC.DSC_TONO,
            'logTennido'                     VALUE SREC.LOG_TENNIDO, 
            'canAltura'                      VALUE SREC.CAN_ALTURA, 
            'logTerminadoDerecho'            VALUE SREC.LOG_TERMINADO_DERECHO,
            'logTerminadoIzquierdo'          VALUE SREC.LOG_TERMINADO_IZQUIERDO, 
            'codEstado'                      VALUE SREC.COD_ESTADO, 
            'descCodEstado'                  VALUE CEST.DSC_ESTADO, 
            'monCostoTotal'                  VALUE SREC.MON_COSTO_TOTAL, 
            'obsReceta'                      VALUE SREC.OBS_RECETA, 
            'codUsuarioRegistro'             VALUE SREC.COD_USUARIO_REGISTRO, 
            'fecRegistro'                    VALUE SREC.FEC_REGISTRO, 
            'codUsuarioModifico'             VALUE SREC.COD_USUARIO_MODIFICO, 
            'fecModifico'                    VALUE SREC.FEC_MODIFICO, 
            'logActivo'                      VALUE SREC.LOG_ACTIVO
)
--            ORDER BY
--                SREC.COD_RECETA
            RETURNING CLOB)
        INTO P_OUT_JSON
        FROM
            SDAI_OWNER.SDAI_RECETA SREC
            INNER JOIN CORE_OWNER.CORE_TIPO   CTIP ON SREC.TIP_LENTE = CTIP.TIP_TIPO
            INNER JOIN CORE_OWNER.CORE_ESTADO CEST ON SREC.COD_ESTADO = CEST.COD_ESTADO
            INNER JOIN CORE_OWNER.CORE_TIPO   CTIM ON SREC.TIP_MATERIAL_LENTE = CTIM.TIP_TIPO
        WHERE
            SREC.NUM_IDENTIFICACION = P_IN_NUM_IDENTIFICACION
            -- Cambiar 7 y 8 depende de la base de datos segun sea DIGITADA o PENDIENTE DE TRAMITAR
            and SREC.COD_ESTADO IN (7 , 8);

        P_OUT_RESULTADO := V_CONFIRMACION_EXITOSA;
        IF P_OUT_JSON IS NULL THEN
            P_OUT_JSON := '[]';
        END IF;
        DBMS_OUTPUT.PUT_LINE('Salida');
        DBMS_OUTPUT.PUT_LINE(P_OUT_RESULTADO);
        DBMS_OUTPUT.PUT_LINE(P_OUT_JSON);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            P_OUT_RESULTADO := V_CONFIRMACION_ERRONEA;
            P_OUT_DETALLE := 'SDAI --> ERROR - SP_RECETA_GETBY_IDENTIFICACION'
                             || SQLCODE
                             || ' -ERROR- '
                             || SQLERRM;
            DBMS_OUTPUT.PUT_LINE(P_OUT_DETALLE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END SP_RECETA_GETBY_IDENTIFICACION_DIGITACION;

--PROCEDIMIENTO QUE LISTA LAS RESETAS POR ESTADO
    PROCEDURE SP_RECETAS_GETBY_COD_ESTADO (
        P_OUT_JSON      OUT CLOB,
        P_OUT_RESULTADO OUT INTEGER,
        P_OUT_DETALLE   OUT VARCHAR2,
        P_IN_COD_ESTADO IN NUMBER
    ) AS
--se crean las variables de confirmacion y errores
        V_CONFIRMACION_EXITOSA NUMBER(1) := 1;
        V_CONFIRMACION_ERRONEA NUMBER(1) := 0;
    BEGIN

-- se carga la informacion en un arreglo de JSON y se cargan como json cada objeto
        SELECT
            JSON_ARRAYAGG(
                JSON_OBJECT(
                    'codReceta'                     VALUE SREC.COD_RECETA, 
                    'codRecetaEdus'                 VALUE SREC.COD_RECETA_EDUS, 
                    'fecReceta'                     VALUE SREC.FEC_RECETA, 
                    'codUnidadEmision'              VALUE SREC.COD_UNIDAD_EMISION, 
                    'codUnidadAdscripcion'          VALUE SREC.COD_UNIDAD_ADSCRIPCION, 
                    'tipIdentificacion'             VALUE SREC.TIP_IDENTIFICACION,
                    'numIdentificacion'             VALUE SREC.NUM_IDENTIFICACION, 
                    'nomPersona'                    VALUE CPER.NOM_PERSONA, 
                    'nomApellido1'                  VALUE CPER.NOM_APELLIDO1, 
                    'nomApellido2'                  VALUE CPER.NOM_APELLIDO2, 
                    'codGenero'                     VALUE CPER.COD_GENERO,
                    'tipLente'                      VALUE SREC.TIP_LENTE, 
                    'dscLente'                      VALUE CTIP.DSC_TIPO, 
                    'canDioptriasEsfericoDer'       VALUE SREC.CAN_DIOPTRIAS_ESFERICO_DER, 
                    'canDioptriasEsfericoIzq'       VALUE SREC.CAN_DIOPTRIAS_ESFERICO_IZQ, 
                    'canDioptriasCilindricoDer'     VALUE SREC.CAN_DIOPTRIAS_CILINDRICO_DER, 
                    'canDioptriasCilindricoIzq'     VALUE SREC.CAN_DIOPTRIAS_CILINDRICO_IZQ, 
                    'canDioptriasEjeDer'            VALUE SREC.CAN_DIOPTRIAS_EJE_DER, 
                    'canDioptriasEjeIzq'            VALUE SREC.CAN_DIOPTRIAS_EJE_IZQ, 
                    'canDioptriasPrismaDer'         VALUE SREC.CAN_DIOPTRIAS_PRISMA_DER,
                    'canDioptriasPrismaIzq'         VALUE SREC.CAN_DIOPTRIAS_PRISMA_IZQ,
                    'canDioptriasAdicion'           VALUE SREC.CAN_DIOPTRIAS_ADICION,
                    'canDioptriasDistPupilar'       VALUE SREC.CAN_DIOPTRIAS_DIST_PUPILAR, 
                    'canDioptriasDistNasopupilar'   VALUE SREC.CAN_DIOPTRIAS_DIST_NASOPUPILAR, 
                    'tipMaterial'                   VALUE SREC.TIP_MATERIAL_LENTE, 
                    'dscMaterial'                   VALUE CTIM.DSC_TIPO, 
                    'dscTono'                       VALUE SREC.DSC_TONO,
                    'logTennido'                    VALUE SREC.LOG_TENNIDO, 
                    'canAltura'                     VALUE SREC.CAN_ALTURA, 
                    'logTerminadoDerecho'           VALUE SREC.LOG_TERMINADO_DERECHO,
                    'logTerminadoIzquierdo'         VALUE SREC.LOG_TERMINADO_IZQUIERDO, 
                    'codEstado'                     VALUE SREC.COD_ESTADO, 
                    'dscEstado'                     VALUE CEST.DSC_ESTADO, 
                    'monCostoTotal'                 VALUE SREC.MON_COSTO_TOTAL, 
                    'obsReceta'                     VALUE SREC.OBS_RECETA, 
                    'codUsuarioRegistro'            VALUE SREC.COD_USUARIO_REGISTRO, 
                    'fecRegistro'                   VALUE SREC.FEC_REGISTRO, 
                    'codUsuarioModifico'            VALUE SREC.COD_USUARIO_MODIFICO, 
                    'fecModifico'                   VALUE SREC.FEC_MODIFICO, 
                    'logActivo'                     VALUE SREC.LOG_ACTIVO
                ) ORDER BY  SREC.FEC_RECETA
            RETURNING CLOB)
        INTO P_OUT_JSON
        FROM
            SDAI_OWNER.SDAI_RECETA SREC
            INNER JOIN CORE_OWNER.CORE_TIPO   CTIP ON SREC.TIP_LENTE = CTIP.TIP_TIPO
            INNER JOIN CORE_OWNER.CORE_ESTADO CEST ON SREC.COD_ESTADO = CEST.COD_ESTADO
            INNER JOIN CORE_OWNER.CORE_TIPO   CTIM ON SREC.TIP_MATERIAL_LENTE = CTIM.TIP_TIPO
            INNER JOIN CORE_OWNER.CORE_PERSONA CPER ON SREC.NUM_IDENTIFICACION = CPER.NUM_IDENTIFICACION
        WHERE
            SREC.COD_ESTADO = P_IN_COD_ESTADO;

        P_OUT_RESULTADO := V_CONFIRMACION_EXITOSA;
        IF P_OUT_JSON IS NULL THEN
            P_OUT_JSON := '[]';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            P_OUT_RESULTADO := V_CONFIRMACION_ERRONEA;
            P_OUT_DETALLE := 'SDAI --> ERROR - SP_RECETAS_GETBY_COD_ESTADO'
                             || SQLCODE
                             || ' -ERROR- '
                             || SQLERRM;
    END SP_RECETAS_GETBY_COD_ESTADO;

--PROCEDIMIENTO QUE CALCULA  LOS PRECIOS DE LOS ARTICULOS
    PROCEDURE SP_ARTICULO_PRECIO_GETBY_CONDICION_LENTE_ARO (
        P_OUT_JSON          OUT CLOB,
        P_OUT_RESULTADO     OUT INTEGER,
        P_OUT_DETALLE       OUT VARCHAR2,
        P_IN_TIPO_CONDICION IN NUMBER,
        P_IN_TIPO_LENTE     IN NUMBER,
        P_IN_TIPO_ARO       IN NUMBER
    ) AS
-- 
-- SE CREAN VARIABLES 
        V_CONFIRMACION_EXITOSA NUMBER(1) := 1;
        V_CONFIRMACION_ERRONEA NUMBER(1) := 0;
    BEGIN

-- se carga la informacion en un arreglo de JSON y se cargan como json cada objeto
        SELECT
            JSON_ARRAYAGG(
                JSON_OBJECT
            ('conArticulo' VALUE SART.COD_ARTICULO, 'dscArticulo' VALUE SART.DSC_ARTICULO, 'tipCondicion' VALUE SART.TIP_CONDICION, 'tipLente'
            VALUE SART.TIP_LENTE, 'tipAro' VALUE SART.TIP_ARO, 'monCosto' VALUE SART.MON_COSTO, 'codUsuarioRegistro' VALUE SART.COD_USUARIO_REGISTRO,
            'fecRegistro' VALUE SART.FEC_REGISTRO, 'codUsuarioModifico' VALUE SART.COD_USUARIO_MODIFICO, 'fecModifico' VALUE SART.FEC_MODIFICO,
            'logActivo' VALUE SART.LOG_ACTIVO)
            ORDER BY
                SART.COD_ARTICULO
            RETURNING CLOB)
        INTO P_OUT_JSON
        FROM
            SDAI_OWNER.SDAI_ARTICULO SART
        WHERE
            SART.TIP_CONDICION = P_IN_TIPO_CONDICION
            AND SART.TIP_LENTE = P_IN_TIPO_LENTE
            AND SART.TIP_ARO = P_IN_TIPO_ARO;

        P_OUT_RESULTADO := V_CONFIRMACION_EXITOSA;
        IF P_OUT_JSON IS NULL THEN
            P_OUT_JSON := '[]';
        END IF;
        DBMS_OUTPUT.PUT_LINE('Salida');
        DBMS_OUTPUT.PUT_LINE(P_OUT_RESULTADO);
        DBMS_OUTPUT.PUT_LINE(P_OUT_JSON);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            P_OUT_RESULTADO := V_CONFIRMACION_ERRONEA;
            P_OUT_DETALLE := 'SDAI --> ERROR - SP_ARTICULO_PRECIO_GETBY_CONDICION_LENTE_ARO'
                             || SQLCODE
                             || ' -ERROR- '
                             || SQLERRM;
            DBMS_OUTPUT.PUT_LINE(P_OUT_DETALLE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END SP_ARTICULO_PRECIO_GETBY_CONDICION_LENTE_ARO;

--PROCEDIMIENTO QUE EVALUA EL LENTE Y ENVIA LA CONDICION    
    PROCEDURE SP_LENTE_GETBY_CONDICION (
    P_OUT_RESULTADO       OUT BOOLEAN,
    P_OUT_COD_GRADUACION  OUT INTEGER,
    P_OUT_VALIDA          OUT INTEGER,
    P_OUT_DETALLE         OUT VARCHAR2,
    P_TIPO_LENTE          IN VARCHAR2,
    P_CAN_DIOPTRIA_PRISMA IN VARCHAR2,
    P_DIOPTRIA_ADICION    IN VARCHAR2,
    P_DIOPTRIA_ESFERICO   IN VARCHAR2,
    P_DIOPTRIA_CILINDRO   IN VARCHAR2
) AS
-- SE CREAN VARIABLES DE CONTROL
    V_CONFIRMACION_EXITOSA  NUMBER(1) := 1;
    V_CONFIRMACION_ERRONEA  NUMBER(1) := 0;
-- SE CREAN VARIABLES DE CONTROL
    V_COD_GRADUACION        NUMBER(6);
    V_CAN_DIOPTRIA_ESFERICO NUMBER(4);
    V_DIOPTRIA_ESTADO    BOOLEAN;
    V_RESULT    VARCHAR(20);
BEGIN

DBMS_OUTPUT.PUT_LINE(P_TIPO_LENTE);


--INICIO DE PROCEDIMIENTO ALMACENADO
    --SE CASTEA UNA VARIABLE PARA HACER UNA OPERACION ARITMETICA
    V_CAN_DIOPTRIA_ESFERICO := CAST ( P_DIOPTRIA_ESFERICO AS INT );
    --EVALUACION DE LENTE(SI LA DIPTRIA NO ES 0 ES PROCESO->FALSE)
    IF P_CAN_DIOPTRIA_PRISMA != 0 THEN
        V_DIOPTRIA_ESTADO := FALSE;
        DBMS_OUTPUT.PUT_LINE('Prisma es mayor que cero y es en proceso');
    ELSE
        --EVALUACION DE LENTE(SI ES BIFOCAL Y EL CILINDRO NO ES 0 ES PROCESO->FALSE)
        IF P_TIPO_LENTE = '6' AND P_DIOPTRIA_CILINDRO != '0' THEN
            V_DIOPTRIA_ESTADO := FALSE;
            DBMS_OUTPUT.PUT_LINE('Es bifocal y cilindro es mayo que 0');
        ELSE
            --EVALUACION DE LENTE(SI EL ESFERICO ES MAYOR QUE 900 O MENOR QUE -900 ES PROCESO->FALSE)
            IF V_CAN_DIOPTRIA_ESFERICO >= 900 OR V_CAN_DIOPTRIA_ESFERICO <= -900 THEN
                V_DIOPTRIA_ESTADO := FALSE;
            ELSE
                --EVALUACION DE LENTE(SI EL ES BIFOCAL)
                IF P_TIPO_LENTE != '6' THEN
                DBMS_OUTPUT.PUT_LINE('Evalua bifocal');
                            BEGIN
                                    SELECT SGRA.COD_GRADUACION
                                    INTO V_COD_GRADUACION
                                    FROM SDAI_OWNER.SDAI_GRADUACION SGRA
                                    WHERE SGRA.CAN_DIOPTRIAS_ESFERICO = P_DIOPTRIA_ESFERICO
                                    AND SGRA.CAN_DIOPTRIAS_CILINDRICO = P_DIOPTRIA_CILINDRO
                                    AND ROWNUM <= 1;
                                EXCEPTION
                                    WHEN NO_DATA_FOUND THEN
                                        V_COD_GRADUACION:=0;
                                END;
                                
                    --EVALUACION DE LENTE(SI EL ES BIFOCAL Y HAY DATOS EN TABLA GRADUACIONES ES TERMINADO Y SI NO TIENE ES PROCESO->TRUE O FLASE)            
                    IF ( V_COD_GRADUACION = 0 ) THEN
                        V_DIOPTRIA_ESTADO := FALSE;
                    ELSE
                        V_DIOPTRIA_ESTADO := TRUE;
                    END IF;
                --EVALUACION DE LENTE(SI EL ES SIMPLE)   
                ELSE
                            BEGIN
                                SELECT SGRA.COD_GRADUACION
                                INTO V_COD_GRADUACION
                                FROM
                                    SDAI_OWNER.SDAI_GRADUACION SGRA
                                WHERE
                                    SGRA.CAN_DIOPTRIAS_ADICION = P_DIOPTRIA_ADICION
                                    AND SGRA.CAN_DIOPTRIAS_ESFERICO = P_DIOPTRIA_ESFERICO
                                    AND ROWNUM <= 1;
                                EXCEPTION
                                    WHEN NO_DATA_FOUND THEN
                                        V_COD_GRADUACION:=0;
                            END;
                    --EVALUACION DE LENTE(SI EL ES SIMPLE Y HAY DATOS EN TABLA GRADUACIONES ES TERMINADO Y SI NO TIENE ES PROCESO->TRUE O FLASE)
                    IF ( V_COD_GRADUACION = 0 ) THEN
                        V_DIOPTRIA_ESTADO := FALSE;
                    ELSE
                        V_DIOPTRIA_ESTADO := TRUE;
                    END IF;

                END IF;

            END IF;
        END IF;

    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Estamos aqui Codigo graduacion es');
    DBMS_OUTPUT.PUT_LINE(V_COD_GRADUACION);
    P_OUT_RESULTADO := V_DIOPTRIA_ESTADO;
    P_OUT_COD_GRADUACION :=V_COD_GRADUACION;
    P_OUT_VALIDA := V_CONFIRMACION_EXITOSA;
    P_OUT_DETALLE := 'SP_LENTE_GETBY_CONDICION FINALIZO CORRECTAMENTE';
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        P_OUT_VALIDA := V_CONFIRMACION_ERRONEA;
        P_OUT_DETALLE := 'SDAI --> ERROR - SP_CONDICION_UPTADE_TERMINADO'
                         || SQLCODE
                         || ' -ERROR- '
                         || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(P_OUT_DETALLE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END SP_LENTE_GETBY_CONDICION;

--PROCEDIMIENTO QUE ACTUALIZA LA CONDICION DEL LENTE
        PROCEDURE SP_LENTE_UPDATE_CONDICION(
    P_OUT_JSON      OUT CLOB,
    P_OUT_RESULTADO OUT INTEGER,
    P_OUT_DETALLE   OUT VARCHAR2,
    p_in_cod_receta_edus IN VARCHAR2
) AS

-- SE CREAN VARIABLES DE CONTROL
    v_confirmacion_exitosa NUMBER(1) := 1;
    v_confirmacion_erronea NUMBER(1) := 0;
-- VARIABLES QUE IMPRIME EL PROCEDIMIENTO CONDICION
    V_CONDICION_DER BOOLEAN;
    V_CONDICION_IZQ BOOLEAN;
    V_COD_GRADUACION_DER NUMBER(6);
    V_COD_GRADUACION_IZQ NUMBER(6);
    V_OUT_VALIDA_CON INTEGER;
    V_OUT_DETALLE_CON VARCHAR(200);
-- VARIABLES QUE IMPRIME EL PROCEDIMIENTO CALCULO BASE    
    V_ADICION_BASE INTEGER;
    v_esferico_der_base INTEGER;
    v_esferico_izq_base INTEGER;
    v_cilindro_der_base INTEGER;
    v_cilindro_izq_base INTEGER;

-- VARIABLES DE LA RECETA
    v_can_dioptria_prisma_der VARCHAR(200);
    v_can_dioptria_prisma_izq VARCHAR(200);
    v_can_dioptria_esferico_der VARCHAR(200);
    v_can_dioptria_esferico_izq VARCHAR(200);
    v_can_dioptria_cilindro_der VARCHAR(200);
    v_can_dioptria_cilindro_izq VARCHAR(200);
    v_tipo_lente NUMBER(4);
    v_can_dioptrias_adicion VARCHAR(200);
    V_RESULT_DER NUMBER(1);
    V_RESULT_IZQ NUMBER(1);

--CURSOR QUE LLAMA A LA RECETA CON LOS DATOS QUE SE OCUPAN   
         CURSOR c_receta IS
            SELECT
            COD_RECETA_EDUS,
            TIP_LENTE,
            CAN_DIOPTRIAS_ESFERICO_DER,
            CAN_DIOPTRIAS_ESFERICO_IZQ,
            CAN_DIOPTRIAS_CILINDRICO_DER,
            CAN_DIOPTRIAS_CILINDRICO_IZQ,
            CAN_DIOPTRIAS_EJE_DER,
            CAN_DIOPTRIAS_EJE_IZQ,
            CAN_DIOPTRIAS_PRISMA_DER,
            CAN_DIOPTRIAS_PRISMA_IZQ,
            CAN_DIOPTRIAS_ADICION,
            CAN_DIOPTRIAS_DIST_PUPILAR,
            CAN_DIOPTRIAS_DIST_NASOPUPILAR,
            LOG_TERMINADO_DERECHO,
            LOG_TERMINADO_IZQUIERDO
            FROM SDAI_OWNER.SDAI_RECETA
            WHERE COD_RECETA_EDUS = p_in_cod_receta_edus;


Begin
--INICIA PROCESO
FOR T_RECETA IN c_receta LOOP
   v_can_dioptria_prisma_der   := T_RECETA.CAN_DIOPTRIAS_PRISMA_DER;
   v_can_dioptria_prisma_izq   := T_RECETA.CAN_DIOPTRIAS_PRISMA_IZQ;
   v_can_dioptria_esferico_der := T_RECETA.CAN_DIOPTRIAS_ESFERICO_DER;
   v_can_dioptria_esferico_izq := T_RECETA.CAN_DIOPTRIAS_ESFERICO_IZQ;
   v_can_dioptria_cilindro_der := T_RECETA.CAN_DIOPTRIAS_CILINDRICO_DER;
   v_can_dioptria_cilindro_izq := T_RECETA.CAN_DIOPTRIAS_CILINDRICO_IZQ;
   v_tipo_lente                := T_RECETA.TIP_LENTE;
   v_can_dioptrias_adicion     := T_RECETA.CAN_DIOPTRIAS_ADICION;
  END LOOP;
        -- formatea la adicion
     V_ADICION_BASE := to_number(v_can_dioptrias_adicion);
     v_esferico_der_base := to_number(v_can_dioptria_esferico_der);
     v_esferico_izq_base := to_number(v_can_dioptria_esferico_izq);
     v_cilindro_der_base := to_number(v_can_dioptria_cilindro_der);
     v_cilindro_izq_base := to_number(v_can_dioptria_cilindro_izq);



     --SE EVALUAN LAS CONDICIONES DE LENTES DERECHO
     SDAI_OWNER.PCK_DIGITACION.SP_LENTE_GETBY_CONDICION (V_CONDICION_DER,V_COD_GRADUACION_DER,V_OUT_VALIDA_CON,V_OUT_DETALLE_CON,v_tipo_lente,v_can_dioptria_prisma_der,v_can_dioptrias_adicion,v_can_dioptria_esferico_der,v_can_dioptria_cilindro_der);
     --SE EVALUAN LAS CONDICIONES DE LENTES IZQUIERDO
     SDAI_OWNER.PCK_DIGITACION.SP_LENTE_GETBY_CONDICION (V_CONDICION_IZQ,V_COD_GRADUACION_IZQ,V_OUT_VALIDA_CON,V_OUT_DETALLE_CON,v_tipo_lente,v_can_dioptria_prisma_izq,v_can_dioptrias_adicion,v_can_dioptria_esferico_izq,v_can_dioptria_cilindro_izq);
     --Evalua el Lente Derecho
     IF V_CONDICION_DER THEN
     V_RESULT_DER := 1;
     DBMS_OUTPUT.PUT_LINE(V_COD_GRADUACION_DER);
     ELSE
     V_RESULT_DER := 0;
     V_COD_GRADUACION_DER := SDAI_OWNER.PCK_DIGITACION.FN_LENTE_CALCULO_BASE(V_ADICION_BASE,v_esferico_der_base,v_cilindro_der_base);
     DBMS_OUTPUT.PUT_LINE('Base Derecha codigo');
     DBMS_OUTPUT.PUT_LINE(V_COD_GRADUACION_DER);
     END IF;
     --Evalua el Lente Derecho
     IF V_CONDICION_IZQ THEN
     V_RESULT_IZQ:= 1;
     DBMS_OUTPUT.PUT_LINE(V_COD_GRADUACION_IZQ);
     ELSE
     V_RESULT_IZQ:= 0;
     V_COD_GRADUACION_DER := SDAI_OWNER.PCK_DIGITACION.FN_LENTE_CALCULO_BASE(V_ADICION_BASE,v_esferico_izq_base,v_cilindro_izq_base);
     DBMS_OUTPUT.PUT_LINE('Base Izquierda codigo');
     DBMS_OUTPUT.PUT_LINE(V_COD_GRADUACION_IZQ);
     END IF;
     
     DBMS_OUTPUT.PUT_LINE(V_RESULT_DER);
     DBMS_OUTPUT.PUT_LINE(V_RESULT_IZQ);
     DBMS_OUTPUT.PUT_LINE(V_COD_GRADUACION_DER);
     DBMS_OUTPUT.PUT_LINE(V_COD_GRADUACION_IZQ);
        
    --SE ACTUALIZA LA RECETA CON LAS CONDICIONES DE LOS LENTES YA EVALUADAS Y SUS CODIGOS
    -- UPDATE SDAI_OWNER.SDAI_RECETA
    -- SET LOG_TERMINADO_DERECHO = V_RESULT_DER, LOG_TERMINADO_IZQUIERDO = V_RESULT_IZQ ,COD_LENTE_DER =V_COD_GRADUACION_DER, COD_LENTE_IZQ=V_COD_GRADUACION_IZQ  WHERE COD_RECETA_EDUS =p_in_cod_receta_edus;
     --SE HACE LA CONSULTA YA CON EL DATO ACTUALIZADO Y SE ENVIA COMO RESPUESTA
          SELECT
            JSON_ARRAYAGG(
                JSON_OBJECT(
            'codReceta'                     VALUE SREC.COD_RECETA, 
            'codRecetaEdus'                 VALUE SREC.COD_RECETA_EDUS, 
            'fecReceta'                     VALUE SREC.FEC_RECETA, 
            'codUnidadEmision'              VALUE SREC.COD_UNIDAD_EMISION, 
            'codUnidadAdscripcion'          VALUE SREC.COD_UNIDAD_ADSCRIPCION, 
            'tipIdentificacion'             VALUE SREC.TIP_IDENTIFICACION,
            'numIdentificacion'             VALUE SREC.NUM_IDENTIFICACION, 
            'tipLente'                      VALUE SREC.TIP_LENTE, 
            'descTipLente'                  VALUE CTIP.DSC_TIPO, 
            'canDioptriasEsfericoDer'       VALUE SREC.CAN_DIOPTRIAS_ESFERICO_DER, 
            'canDioptriasEsfericoIzq'       VALUE SREC.CAN_DIOPTRIAS_ESFERICO_IZQ, 
            'canDioptriasCilindricoDer'     VALUE SREC.CAN_DIOPTRIAS_CILINDRICO_DER, 
            'canDioptriasCilindricoIzq'     VALUE SREC.CAN_DIOPTRIAS_CILINDRICO_IZQ, 
            'canDioptriasEjeDer'            VALUE SREC.CAN_DIOPTRIAS_EJE_DER, 
            'canDioptriasEjeIzq'            VALUE SREC.CAN_DIOPTRIAS_EJE_IZQ, 
            'canDioptriasPrismaDer'         VALUE SREC.CAN_DIOPTRIAS_PRISMA_DER, 
            'canDioptriasPrismaIzq'         VALUE SREC.CAN_DIOPTRIAS_PRISMA_IZQ, 
            'canDioptriasAdicion'           VALUE SREC.CAN_DIOPTRIAS_ADICION, 
            'canDioptriasDistPupilar'       VALUE SREC.CAN_DIOPTRIAS_DIST_PUPILAR, 
            'canDioptriasDistNasopupilar'   VALUE SREC.CAN_DIOPTRIAS_DIST_NASOPUPILAR, 
            'tipMaterial'                   VALUE SREC.TIP_MATERIAL_LENTE, 
            'descMaterial'                  VALUE CTIM.DSC_TIPO, 
            'dscTono'                       VALUE SREC.DSC_TONO,
            'logTennido'                    VALUE SREC.LOG_TENNIDO, 
            'canAltura'                     VALUE SREC.CAN_ALTURA, 
            'logTerminadoDerecho'           VALUE SREC.LOG_TERMINADO_DERECHO,
            'logTerminadoIzquierdo'         VALUE SREC.LOG_TERMINADO_IZQUIERDO, 
            'codEstado'                     VALUE SREC.COD_ESTADO, 
            'descCodEstado'                 VALUE CEST.DSC_ESTADO, 
            'monCostoTotal'                 VALUE SREC.MON_COSTO_TOTAL, 
            'obsReceta'                     VALUE SREC.OBS_RECETA, 
            'codUsuarioRegistro'            VALUE SREC.COD_USUARIO_REGISTRO, 
            'fecRegistro'                   VALUE SREC.FEC_REGISTRO, 
            'codUsuarioModifico'            VALUE SREC.COD_USUARIO_MODIFICO, 
            'fecModifico'                   VALUE SREC.FEC_MODIFICO, 
            'logActivo'                     VALUE SREC.LOG_ACTIVO)
            ORDER BY
                SREC.COD_RECETA
            RETURNING CLOB)
        INTO P_OUT_JSON
        FROM
            SDAI_OWNER.SDAI_RECETA SREC
            INNER JOIN CORE_OWNER.CORE_TIPO   CTIP ON SREC.TIP_LENTE = CTIP.TIP_TIPO
            INNER JOIN CORE_OWNER.CORE_ESTADO CEST ON SREC.COD_ESTADO = CEST.COD_ESTADO
            INNER JOIN CORE_OWNER.CORE_TIPO   CTIM ON SREC.TIP_MATERIAL_LENTE = CTIM.TIP_TIPO
        WHERE
            SREC.COD_RECETA_EDUS = p_in_cod_receta_edus;
            
       P_OUT_RESULTADO := V_CONFIRMACION_EXITOSA;
    IF P_OUT_JSON IS NULL THEN
        P_OUT_JSON := '[]';
    END IF;
--FIN DE PROCESO
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        P_OUT_RESULTADO := V_CONFIRMACION_ERRONEA;
        P_OUT_DETALLE := 'SDAI --> ERROR - SP_CONDICION_UPTADE_TERMINADO'
                         || SQLCODE
                         || ' -ERROR- '
                         || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(P_OUT_DETALLE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END SP_LENTE_UPDATE_CONDICION;


--PROCEDIMIENTO QUE IDENTIFICA EL MATERIAL BASE DEL LENTE
    PROCEDURE  SP_LENTE_CALCULO_BASE(
            P_OUT_VALIDADOR       OUT INTEGER,
            P_OUT_RESULTADO       OUT INTEGER,
            P_OUT_DETALLE         OUT VARCHAR2,
            P_ADICION   IN INTEGER,
            P_DIOPTRIA_ESFERICO   IN INTEGER,
            P_DIOPTRIA_CILINDRO   IN INTEGER
        ) AS
        -- SE CREAN VARIABLES DE CONTROL
            v_confirmacion_exitosa NUMBER(1) := 1;
            v_confirmacion_erronea NUMBER(1) := 0;
        -- VARIABLES DE CONSUMO
            v_cod_base NUMBER(8);
            v_esferico_cilindrico NUMBER(8);
            v_base NUMBER(2);
            v_adicion NUMBER(8):=P_ADICION;

Begin
   
-- Condiciones de Base 0
             /* 
             Base 0 (base plana): Para determinar si la graduación requiere de un base 0 se toman en cuenta tres condiciones:
             Condicion 1 - Solo esfera: Si la graduación es únicamente esférica tiene que estar en un rango de -9,75 a menos infinito.
             Condicion 2 - Solo cilindro: Si la graduación es únicamente cilíndrica tiene que estar en un rango de -9,75 a menos infinito.
             Condicion 3 - Esferos cilíndricos: Esta graduación se conforma por la suma del una esferico y un cilindrico y el resultado , 
             tiene que estar en un rango de -9,75 a menos infinito. Un ejemplo: la suma de la esfera -7,00 y el cilindro -8,00 da como resultado -15,00, 
             este resultado se encuentra dentro del rango asignado para un base 0.
             */
-- Condiciones de Base 1
             /*
             Base 1: Para determinar si la graduación requiere de un base 1 se toman en cuenta tres condiciones:
             Condicion 1 - Solo esfera: Si la graduación es únicamente esférica tiene que estar en un rango de -7,00 a -9,50.
             Condicion 2 - Solo cilindro: Si la graduación es únicamente cilíndrica tiene que estar en un rango de -7,00 a -9,50.
             Condicion 3 - Esferos cilíndricos: Esta graduación se conforma por la suma del una esferico y un cilindrico y el resultado , 
             tiene que estar en un rango de -7,00 a -9,50. Un ejemplo: la suma de la esfera -4,00 y el cilindro -5,00 da como resultado -9,00, 
             este resultado se encuentra dentro del rango asignado para un base 1.
             */
-- Condiciones de Base 2
             /*
             Base 2: Para determinar si la graduación requiere de un base 2 se toman en cuenta tres condiciones.
             Condicion 1 - Solo esfera: Si la graduación es únicamente esférica tiene que estar en un rango de -4,75 a -6,75.
             Condicion 2 - Solo cilindro: Si la graduación es únicamente cilíndrica tiene que estar en un rango de -4,75 a -6,75.
             Condicion 3 - Esferos cilíndricos: Esta graduación se conforma por la suma del una esferico y un cilindrico y el resultado , 
             tiene que estar en un rango de -4,75 a -6,75. Un ejemplo: la suma de la esfera -3,00 y el cilindro -3,00 da como resultado -6,00, 
             este resultado se encuentra dentro del rango asignado para un base 2.
             */
-- Condiciones de Base 4
             /*
             Base 4: Para determinar si la graduación requiere de un base 4 se toman en cuenta tres condiciones.
             Condicion 1 - Solo esfera: Si la graduación es únicamente esférica tiene que estar en un rango de -3,50 a -4,50.
             Condicion 2 - Solo cilindro: Si la graduación es únicamente cilíndrica tiene que estar en un rango de -3,50 a -4,50.
             Condicion 3 - Esferos cilíndricos: Esta graduación se conforma por la suma del una esferico y un cilindrico y el resultado , 
             tiene que estar en un rango de -3,50 a -4,50. Un ejemplo: la suma de la esfera -1,00 y el cilindro -3,00 da como resultado -4,00, 
             este resultado se encuentra dentro del rango asignado para un base 4.
             */
-- Condiciones de Base 6
             /*
             Base 6: Para determinar si la graduación requiere de un base 6 se toman en cuenta tres condiciones.
             Condicion 1 - Solo esfera: Si la graduación es únicamente esférica tiene que estar en un rango de -3,25 a +3,50.
             Condicion 2 - Solo cilindro: Si la graduación es únicamente cilíndrica tiene que estar en un rango de de -3,25 a +3,50.
             Condicion 3 - Esferos cilíndricos: Esta graduación se conforma por la suma del una esferico y un cilindrico y el resultado , 
             tiene que estar en un rango de -3,25 a +3,50. Un ejemplo: la suma de la esfera 1,75 y el cilindro -150 da como resultado -0,25, 
             este resultado se encuentra dentro del rango asignado para un base 6.
             */
-- Condiciones de Base 8
             /*
             Base 8: Para determinar si la graduación requiere de un base 8 se toman en cuenta tres condiciones.
             Condicion 1 - Solo esfera: Si la graduación es únicamente esférica tiene que estar en un rango de +3,75 a +6,50.
             Condicion 2 - Solo cilindro: Si la graduación es únicamente cilíndrica tiene que estar en un rango de +3,75 a +6,50.
             Condicion 3 - Esferos cilíndricos: Esta graduación se conforma por la suma del una esferico y un cilindrico y el resultado , 
             tiene que estar en un rango de +3,75 a +6,50. Un ejemplo: la suma de la esfera 3,00 y el cilindro 3,00 da como resultado 6,00, 
             este resultado se encuentra dentro del rango asignado para un base 8.
             */
-- Condiciones de Base 10
             /*
             Base 10: Para determinar si la graduación requiere de un base 10 se toman en cuenta tres condiciones.
             Condicion 1 - Solo esfera: Si la graduación es únicamente esférica tiene que estar en un rango de +6,75 a mas infinito.
             Condicion 2 - Solo cilindro: Si la graduación es únicamente cilíndrica tiene que estar en un rango de +6,75 a +9,75.
             Condicion 3 - Esferos cilíndricos: Esta graduación se conforma por la suma del una esferico y un cilindrico y el resultado , 
             tiene que estar en un rango de +6,75 a mas infinito. Un ejemplo: la suma de la esfera 5,00 y el cilindro 3,00 da como resultado 6,00, 
             este resultado se encuentra dentro del rango asignado para un base 10.
             */
           
CASE 
   WHEN P_DIOPTRIA_CILINDRO = 0 and P_DIOPTRIA_ESFERICO != 0  THEN 
            DBMS_OUTPUT.PUT_LINE('Condicion Solo Esferico');
            IF P_DIOPTRIA_ESFERICO <= -975  THEN 
            DBMS_OUTPUT.PUT_LINE('Es Base 0');
            V_BASE := 0;
            ELSIF P_DIOPTRIA_ESFERICO <= -700 AND  P_DIOPTRIA_ESFERICO >= -975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 1');
            V_BASE := 1;
            ELSIF P_DIOPTRIA_ESFERICO <= -475 AND  P_DIOPTRIA_ESFERICO >= -675 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 2');
            V_BASE := 2;
            ELSIF P_DIOPTRIA_ESFERICO <= -350 AND  P_DIOPTRIA_ESFERICO >= -450 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 4');
            V_BASE := 4;
            ELSIF P_DIOPTRIA_ESFERICO <= 350 AND  P_DIOPTRIA_ESFERICO >= -325 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 6');
            V_BASE := 6;
            ELSIF P_DIOPTRIA_ESFERICO <= 650 AND  P_DIOPTRIA_ESFERICO >= 375 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 8');
            V_BASE := 8;
            ELSIF P_DIOPTRIA_ESFERICO <= 675 AND  P_DIOPTRIA_ESFERICO >= 975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 10');
            V_BASE := 10;
            ELSE
            DBMS_OUTPUT.PUT_LINE('Base No se Provee');
            v_adicion:= 999;
            V_BASE:= 99;
            END IF;
   WHEN P_DIOPTRIA_ESFERICO = 0 and P_DIOPTRIA_CILINDRO != 0 THEN 
            DBMS_OUTPUT.PUT_LINE('Condicion Solo Cilindro');
            IF P_DIOPTRIA_CILINDRO <= -975  then
            DBMS_OUTPUT.PUT_LINE('Es Base 0');
            V_BASE := 0;
            ELSIF P_DIOPTRIA_CILINDRO <= -700 AND  P_DIOPTRIA_CILINDRO >= -950 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 1');
            V_BASE := 1;
            ELSIF P_DIOPTRIA_CILINDRO <= -475 AND  P_DIOPTRIA_CILINDRO >= -675 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 2');
            V_BASE := 2;
            ELSIF P_DIOPTRIA_CILINDRO <= -350 AND  P_DIOPTRIA_ESFERICO >= -450 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 4');
            V_BASE := 4;
            ELSIF P_DIOPTRIA_CILINDRO <= 350 AND  P_DIOPTRIA_CILINDRO >= -325 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 6');
            V_BASE := 6;
            ELSIF P_DIOPTRIA_CILINDRO <= 650 AND  P_DIOPTRIA_CILINDRO >= 375 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 8');
            V_BASE := 8;
            ELSIF P_DIOPTRIA_CILINDRO <= 675 AND  P_DIOPTRIA_CILINDRO >= 975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 10');
            V_BASE := 10;
            ELSE
            DBMS_OUTPUT.PUT_LINE('Base No se Provee');
            v_adicion:= 999;
            V_BASE:= 99;
            END IF;
   WHEN P_DIOPTRIA_ESFERICO != 0 and P_DIOPTRIA_CILINDRO != 0 THEN
    DBMS_OUTPUT.PUT_LINE('Condicion Esferos Cilindricos');
            v_esferico_cilindrico := P_DIOPTRIA_ESFERICO + P_DIOPTRIA_CILINDRO;
            DBMS_OUTPUT.PUT('EL RESULTADO DE ESFEROS CILINDRICOS ES: ');
            DBMS_OUTPUT.PUT_LINE (v_esferico_cilindrico);
            if v_esferico_cilindrico <= -975  then
            DBMS_OUTPUT.PUT_LINE('Es Base 0');
            V_BASE := 0;
            ELSIF v_esferico_cilindrico <= -700 AND  v_esferico_cilindrico >= -975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 1');
            V_BASE := 1;
            ELSIF v_esferico_cilindrico <= -475 AND  v_esferico_cilindrico >= -675 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 2');
            V_BASE := 2;
            ELSIF v_esferico_cilindrico <= -350 AND  v_esferico_cilindrico >= -450 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 4');
            V_BASE := 4;
            ELSIF v_esferico_cilindrico <= 350 AND  v_esferico_cilindrico >= -325 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 6');
            V_BASE := 6;
            ELSIF v_esferico_cilindrico <= 650 AND  v_esferico_cilindrico >= 375 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 8');
            V_BASE := 8;
            ELSIF v_esferico_cilindrico <= 675 AND  v_esferico_cilindrico >= 975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 10');
            V_BASE := 10;
            ELSE
            DBMS_OUTPUT.PUT_LINE('Base No se Provee');
            v_adicion:= 999;
            V_BASE:= 99;
            END IF;
END CASE;

        SELECT COD_BASE
        INTO v_cod_base
        FROM SDAI_OWNER.SDAI_BASE
        WHERE CAN_DIOPTRIA_ADICION = v_adicion
        and CON_DIOPTRIA_BASE = V_BASE;
        
        DBMS_OUTPUT.PUT_LINE(v_cod_base);
    
        P_OUT_RESULTADO := v_cod_base;
        P_OUT_VALIDADOR := V_CONFIRMACION_EXITOSA;
        P_OUT_DETALLE := 'SP_LENTE_CALCULO_BASE EJECUTADO CON EXITO';

--FIN DE PROCESO
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        P_OUT_VALIDADOR := V_CONFIRMACION_ERRONEA;
        P_OUT_DETALLE := 'SDAI --> ERROR - SP_CONDICION_UPTADE_TERMINADO'
                         || SQLCODE
                         || ' -ERROR- '
                         || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(P_OUT_DETALLE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END SP_LENTE_CALCULO_BASE;

PROCEDURE SP_DETALLE_RECETA_GETBY_COD_RECETA (
        P_OUT_JSON      OUT CLOB,
        P_OUT_RESULTADO OUT INTEGER,
        P_OUT_DETALLE   OUT VARCHAR2,
        P_IN_COD_RECETA IN NUMBER
    ) AS

        -- SE CREAN VARIABLES 
        V_CONFIRMACION_EXITOSA NUMBER(1) := 1;
        V_CONFIRMACION_ERRONEA NUMBER(1) := 0;
    BEGIN

        -- SE ESCOGEN LAS VARIABLES A DEVOLVER
        SELECT
            JSON_ARRAYAGG(
                JSON_OBJECT
            ('codReceta' VALUE SDRE.COD_RECETA, 'codDetalleReceta' VALUE SDRD.CON_DETALLE_RECETA, 'codArticulo' VALUE SART.COD_ARTICULO,
            'monCosto' VALUE SDRD.MON_COSTO, 'dscArticulo' VALUE SART.DSC_ARTICULO)
            ORDER BY
                SART.COD_ARTICULO
            RETURNING CLOB)
        INTO P_OUT_JSON
        FROM
            SDAI_OWNER.SDAI_ARTICULO SART
            INNER JOIN SDAI_OWNER.SDAI_DETALLE_RECETA SDRD ON SDRD.COD_ARTICULO = SART.COD_ARTICULO
            INNER JOIN SDAI_OWNER.SDAI_RECETA         SDRE ON SDRE.COD_RECETA = SDRD.COD_RECETA
        WHERE
            SDRE.COD_RECETA = P_IN_COD_RECETA;

        P_OUT_RESULTADO := V_CONFIRMACION_EXITOSA;
        IF P_OUT_JSON IS NULL THEN
            P_OUT_JSON := '[]';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            P_OUT_RESULTADO := V_CONFIRMACION_ERRONEA;
            P_OUT_DETALLE := 'SDAI --> ERROR - SP_CONDICION_UPTADE_TERMINADO'
                             || SQLCODE
                             || ' -ERROR- '
                             || SQLERRM;
            DBMS_OUTPUT.PUT_LINE(P_OUT_DETALLE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END SP_DETALLE_RECETA_GETBY_COD_RECETA;
    
FUNCTION FN_LENTE_CALCULO_BASE(
            P_ADICION   IN INTEGER,
            P_DIOPTRIA_ESFERICO   IN INTEGER,
            P_DIOPTRIA_CILINDRO IN INTEGER
            ) RETURN NUMBER 
AS
            v_cod_base number(6);
            v_adicion number;
            V_BASE number;
            v_esferico_cilindrico number;
Begin
V_ADICION := P_ADICION;
CASE 
   WHEN P_DIOPTRIA_CILINDRO = 0 and P_DIOPTRIA_ESFERICO != 0  THEN 
            DBMS_OUTPUT.PUT_LINE('Condicion Solo Esferico');
            IF P_DIOPTRIA_ESFERICO <= -975  THEN 
            DBMS_OUTPUT.PUT_LINE('Es Base 0');
            V_BASE := 0;
            ELSIF P_DIOPTRIA_ESFERICO <= -700 AND  P_DIOPTRIA_ESFERICO >= -975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 1');
            V_BASE := 1;
            ELSIF P_DIOPTRIA_ESFERICO <= -475 AND  P_DIOPTRIA_ESFERICO >= -675 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 2');
            V_BASE := 2;
            ELSIF P_DIOPTRIA_ESFERICO <= -350 AND  P_DIOPTRIA_ESFERICO >= -450 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 4');
            V_BASE := 4;
            ELSIF P_DIOPTRIA_ESFERICO <= 350 AND  P_DIOPTRIA_ESFERICO >= -325 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 6');
            V_BASE := 6;
            ELSIF P_DIOPTRIA_ESFERICO <= 650 AND  P_DIOPTRIA_ESFERICO >= 375 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 8');
            V_BASE := 8;
            ELSIF P_DIOPTRIA_ESFERICO <= 675 AND  P_DIOPTRIA_ESFERICO >= 975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 10');
            V_BASE := 10;
            ELSE
            DBMS_OUTPUT.PUT_LINE('Base No se Provee');
            v_adicion:= 999;
            V_BASE:= 99;
            END IF;
   WHEN P_DIOPTRIA_ESFERICO = 0 and P_DIOPTRIA_CILINDRO != 0 THEN 
            DBMS_OUTPUT.PUT_LINE('Condicion Solo Cilindro');
            IF P_DIOPTRIA_CILINDRO <= -975  then
            DBMS_OUTPUT.PUT_LINE('Es Base 0');
            V_BASE := 0;
            ELSIF P_DIOPTRIA_CILINDRO <= -700 AND  P_DIOPTRIA_CILINDRO >= -950 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 1');
            V_BASE := 1;
            ELSIF P_DIOPTRIA_CILINDRO <= -475 AND  P_DIOPTRIA_CILINDRO >= -675 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 2');
            V_BASE := 2;
            ELSIF P_DIOPTRIA_CILINDRO <= -350 AND  P_DIOPTRIA_ESFERICO >= -450 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 4');
            V_BASE := 4;
            ELSIF P_DIOPTRIA_CILINDRO <= 350 AND  P_DIOPTRIA_CILINDRO >= -325 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 6');
            V_BASE := 6;
            ELSIF P_DIOPTRIA_CILINDRO <= 650 AND  P_DIOPTRIA_CILINDRO >= 375 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 8');
            V_BASE := 8;
            ELSIF P_DIOPTRIA_CILINDRO <= 675 AND  P_DIOPTRIA_CILINDRO >= 975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 10');
            V_BASE := 10;
            ELSE
            DBMS_OUTPUT.PUT_LINE('Base No se Provee');
            v_adicion:= 999;
            V_BASE:= 99;
            END IF;
   WHEN P_DIOPTRIA_ESFERICO != 0 and P_DIOPTRIA_CILINDRO != 0 THEN
    DBMS_OUTPUT.PUT_LINE('Condicion Esferos Cilindricos');
            v_esferico_cilindrico := P_DIOPTRIA_ESFERICO + P_DIOPTRIA_CILINDRO;
            DBMS_OUTPUT.PUT('EL RESULTADO DE ESFEROS CILINDRICOS ES: ');
            DBMS_OUTPUT.PUT_LINE (v_esferico_cilindrico);
            if v_esferico_cilindrico <= -975  then
            DBMS_OUTPUT.PUT_LINE('Es Base 0');
            V_BASE := 0;
            ELSIF v_esferico_cilindrico <= -700 AND  v_esferico_cilindrico >= -975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 1');
            V_BASE := 1;
            ELSIF v_esferico_cilindrico <= -475 AND  v_esferico_cilindrico >= -675 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 2');
            V_BASE := 2;
            ELSIF v_esferico_cilindrico <= -350 AND  v_esferico_cilindrico >= -450 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 4');
            V_BASE := 4;
            ELSIF v_esferico_cilindrico <= 350 AND  v_esferico_cilindrico >= -325 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 6');
            V_BASE := 6;
            ELSIF v_esferico_cilindrico <= 650 AND  v_esferico_cilindrico >= 375 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 8');
            V_BASE := 8;
            ELSIF v_esferico_cilindrico <= 675 AND  v_esferico_cilindrico >= 975 THEN
            DBMS_OUTPUT.PUT_LINE('Es Base 10');
            V_BASE := 10;
            ELSE
            DBMS_OUTPUT.PUT_LINE('Base No se Provee');
            v_adicion:= 999;
            V_BASE:= 99;
            END IF;
END CASE;


    SELECT SDAI_OWNER.SDAI_BASE.COD_BASE
        INTO v_cod_base
        FROM SDAI_OWNER.SDAI_BASE
        WHERE CAN_DIOPTRIA_ADICION = v_adicion
        and CON_DIOPTRIA_BASE = V_BASE;

RETURN V_COD_BASE;

--FIN DE PROCESO
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
      DBMS_OUTPUT.PUT_LINE (SQLCODE
                         || ' -ERROR- '
                         || SQLERRM );
END FN_LENTE_CALCULO_BASE;
END;