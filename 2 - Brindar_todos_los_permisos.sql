set SERVEROUTPUT on

GRANT DBA TO BUDGET;

GRANT
    DROP ANY PROCEDURE
TO BUDGET;

GRANT
    CREATE ANY PROCEDURE
TO BUDGET;

GRANT
    EXECUTE ANY PROCEDURE
TO BUDGET;

BEGIN
    FOR T IN (
        SELECT
            *
        FROM
            DBA_TABLES
        WHERE
            OWNER != 'BUDGET'
            AND OWNER NOT LIKE '%SYS%'
            AND OWNER NOT LIKE '%ORDDATA%'
            AND OWNER NOT LIKE '%ADMIN%'
            AND OWNER NOT LIKE '%APEX%'
            AND OWNER NOT LIKE '%XDB%'
            AND OWNER NOT LIKE '%FLOW_FILES%'
            AND OWNER NOT LIKE '%OE%'
            AND IOT_TYPE IS NULL
    ) LOOP
        EXECUTE IMMEDIATE 'GRANT ALL PRIVILEGES ON '
                          || T.OWNER
                          || '.'
                          || T.TABLE_NAME
                          || ' TO BUDGET';
    END LOOP;
END;