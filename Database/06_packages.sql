/*
    ProductHub Manager - PL/SQL Package Runner
    Target DBMS: Oracle Database 21c+

    Run this script from the database folder after tables, views,
    triggers, and seed data are installed.
*/

PROMPT Dropping obsolete package names, if they exist...
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP PACKAGE ph_sec_auth_pkg';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -4043 THEN
                RAISE;
            END IF;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP PACKAGE ph_erp_contract_pkg';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -4043 THEN
                RAISE;
            END IF;
    END;
END;
/

PROMPT Creating localization package...
@packages/01_ph_localization_pkg.sql

PROMPT Creating security authentication package...
@packages/02_ph_sec_authentication_pkg.sql

PROMPT Creating ERP management validation package...
@packages/03_ph_erp_management_validation_pkg.sql

PROMPT Creating security management validation package...
@packages/04_ph_sec_management_validation_pkg.sql

PROMPT Creating APEX security authentication package...
@packages/05_ph_sec_authentication_apex_pkg.sql

PROMPT Creating security management package...
@packages/06_ph_sec_management_pkg.sql

PROMPT Creating ERP management package...
@packages/07_ph_erp_management_pkg.sql

PROMPT Creating customer and contract management package...
@packages/08_ph_erp_customer_contract_pkg.sql
