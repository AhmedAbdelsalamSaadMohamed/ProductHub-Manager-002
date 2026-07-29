/*
ProductHub Manager - Globalization Error Log Package
Target DBMS: Oracle Database 21c+
*/

CREATE OR REPLACE PACKAGE ph_globalization_error_log_pkg AS
    PROCEDURE log_error (
        p_program_unit            IN VARCHAR2,
        p_program_unit_parameters IN CLOB DEFAULT NULL,
        p_error_location          IN VARCHAR2 DEFAULT NULL,
        p_action_name             IN VARCHAR2 DEFAULT NULL,
        p_error_code              IN NUMBER DEFAULT NULL,
        p_error_message           IN VARCHAR2 DEFAULT NULL,
        p_error_stack             IN CLOB DEFAULT NULL,
        p_error_backtrace         IN CLOB DEFAULT NULL
    );
END ph_globalization_error_log_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_globalization_error_log_pkg AS
    PROCEDURE log_error (
        p_program_unit            IN VARCHAR2,
        p_program_unit_parameters IN CLOB DEFAULT NULL,
        p_error_location          IN VARCHAR2 DEFAULT NULL,
        p_action_name             IN VARCHAR2 DEFAULT NULL,
        p_error_code              IN NUMBER DEFAULT NULL,
        p_error_message           IN VARCHAR2 DEFAULT NULL,
        p_error_stack             IN CLOB DEFAULT NULL,
        p_error_backtrace         IN CLOB DEFAULT NULL
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO ph_globalization_error_log (
            program_unit,
            program_unit_parameters,
            error_location,
            error_code,
            error_message,
            error_stack,
            error_backtrace,
            call_stack,
            action_name
        ) VALUES (
            p_program_unit,
            p_program_unit_parameters,
            p_error_location,
            p_error_code,
            p_error_message,
            p_error_stack,
            p_error_backtrace,
            DBMS_UTILITY.FORMAT_CALL_STACK,
            p_action_name
        );

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
    END log_error;
END ph_globalization_error_log_pkg;
/
