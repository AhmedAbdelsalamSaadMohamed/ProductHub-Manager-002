-- DEV/TEST ONLY.
-- Drops all ProductHub Manager objects owned by the current schema, in dependency order,
-- so the module can be reinstalled from a clean slate.
--
-- This reset intentionally removes hard database objects. Application delete APIs use
-- IS_DELETED soft delete; this script is only for rebuilding a development schema.

SET SERVEROUTPUT ON
SET DEFINE OFF

DECLARE
    PROCEDURE drop_by_type(p_type IN VARCHAR2) IS
    BEGIN
        FOR r IN (
            SELECT object_type, object_name
            FROM user_objects
            WHERE (
                    object_name LIKE 'PH\_%' ESCAPE '\'
                    OR object_name LIKE 'VW\_PH\_%' ESCAPE '\'
                    OR object_name LIKE 'TRG\_PH\_%' ESCAPE '\'
                    OR object_name LIKE 'TRG\_AUD\_PH\_%' ESCAPE '\'
                    OR object_name LIKE 'IX\_PH\_%' ESCAPE '\'
                    OR object_name LIKE 'UX\_PH\_%' ESCAPE '\'
                    OR object_name LIKE 'LOV\_%' ESCAPE '\'
                )
                AND object_type = p_type
            ORDER BY
                CASE
                    WHEN object_type = 'TYPE' THEN object_name
                END DESC,
                object_name
        ) LOOP
            BEGIN
                EXECUTE IMMEDIATE 'DROP ' || r.object_type || ' "' || r.object_name || '"';
                DBMS_OUTPUT.PUT_LINE('Dropped ' || r.object_type || ' ' || r.object_name);
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('Skipped ' || r.object_type || ' ' || r.object_name || ': ' || SQLERRM);
            END;
        END LOOP;
    END drop_by_type;
BEGIN
    FOR m IN (
        SELECT 'ph_sec_auth_api' module_name FROM dual
        UNION ALL SELECT 'ph_erp_api' FROM dual
        UNION ALL SELECT 'ph_entity_api' FROM dual
    ) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'BEGIN ORDS.DELETE_MODULE(p_module_name => ''' || m.module_name || '''); END;';
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Dropped ORDS module ' || m.module_name);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Skipped ORDS module ' || m.module_name || ': ' || SQLERRM);
        END;
    END LOOP;

    drop_by_type('VIEW');
    drop_by_type('PACKAGE BODY');
    drop_by_type('PACKAGE');
    drop_by_type('TRIGGER');
    drop_by_type('INDEX');
    drop_by_type('SEQUENCE');
    drop_by_type('MATERIALIZED VIEW');
    drop_by_type('FUNCTION');
    drop_by_type('PROCEDURE');
    drop_by_type('TYPE BODY');
    drop_by_type('TYPE');

    FOR r IN (
        SELECT table_name
        FROM user_tables
        WHERE table_name LIKE 'PH\_%' ESCAPE '\'
        ORDER BY table_name
    ) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP TABLE "' || r.table_name || '" CASCADE CONSTRAINTS PURGE';
            DBMS_OUTPUT.PUT_LINE('Dropped TABLE ' || r.table_name);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Skipped TABLE ' || r.table_name || ': ' || SQLERRM);
        END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('ProductHub Manager cleanup completed.');
END;
/
