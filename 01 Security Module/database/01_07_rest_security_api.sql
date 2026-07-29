/*
ProductHub Manager - Security Module REST API Installer
Target DBMS: Oracle Database 21c+
*/

SET DEFINE OFF
SET SERVEROUTPUT ON

PROMPT Enabling ORDS for the ProductHub schema...
BEGIN
    EXECUTE IMMEDIATE q'[
        BEGIN
            ORDS.ENABLE_SCHEMA(
                p_enabled             => TRUE,
                p_schema              => USER,
                p_url_mapping_type    => 'BASE_PATH',
                p_url_mapping_pattern => LOWER(USER),
                p_auto_rest_auth      => FALSE
            );
            COMMIT;
        END;
    ]';
    DBMS_OUTPUT.PUT_LINE('ORDS schema enabled.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Skipped ORDS schema enable: ' || SQLERRM);
END;
/

PROMPT Creating Security ORDS module...
BEGIN
    EXECUTE IMMEDIATE q'[
        BEGIN
            ORDS.DEFINE_MODULE(
                p_module_name    => 'ph_sec_auth_api',
                p_base_path      => 'security/',
                p_items_per_page => 25,
                p_status         => 'PUBLISHED'
            );
            COMMIT;
        END;
    ]';
    DBMS_OUTPUT.PUT_LINE('Security ORDS module created.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Skipped Security ORDS module: ' || SQLERRM);
END;
/
