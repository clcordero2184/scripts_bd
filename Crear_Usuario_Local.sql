-- CREAR USUARIOS
CREATE USER BUDGET IDENTIFIED BY "Asdf2022" DEFAULT TABLESPACE "USERS" TEMPORARY TABLESPACE "TEMP";
COMMIT;

--DAR CUOTAS
ALTER USER BUDGET QUOTA 300M ON USERS;
commit;

--ASIGNAR ROLES
GRANT "CONNECT" TO BUDGET;
GRANT "RESOURCE" TO BUDGET;
commit;

ALTER USER BUDGET quota unlimited on DATOS_01;
ALTER USER BUDGET quota unlimited on INDICES_01;

BEGIN
  DBMS_SERVICE.create_service(
    service_name => 'BUDGET_TAF',
    network_name => 'BUDGET_TAF'
  );
END;
/

BEGIN
  DBMS_SERVICE.start_service(
    service_name => 'BUDGET_TAF'
  );
END;
/
