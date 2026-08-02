/*
ProductHub Manager - Shared Helpers Package
Target DBMS: Oracle Database 21c+

Purpose:
- Common stateless helper routines used across packages.
*/

CREATE OR REPLACE PACKAGE ph_helpers_pkg AS
    PROCEDURE set_success(
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2,
        p_message        IN VARCHAR2
    );

    PROCEDURE set_validation_error(
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2,
        p_message        IN VARCHAR2
    );

    PROCEDURE set_error(
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2,
        p_message        IN VARCHAR2 DEFAULT 'Unexpected error.'
    );

    PROCEDURE set_valid(
        o_is_valid           OUT NUMBER,
        o_validation_message OUT VARCHAR2
    );

    PROCEDURE set_invalid(
        o_is_valid           OUT NUMBER,
        o_validation_message OUT VARCHAR2,
        p_message            IN VARCHAR2
    );

    FUNCTION yes_no(p_count IN NUMBER) RETURN NUMBER;
    FUNCTION text_missing(p_value IN VARCHAR2) RETURN BOOLEAN;
    FUNCTION text_too_long(p_value IN VARCHAR2, p_max_length IN NUMBER) RETURN BOOLEAN;
    FUNCTION valid_flag(p_value IN NUMBER) RETURN BOOLEAN;
    FUNCTION valid_value_type(p_value_type IN VARCHAR2) RETURN BOOLEAN;
    FUNCTION valid_default_value_type(p_value_type IN VARCHAR2) RETURN BOOLEAN;
END ph_helpers_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_helpers_pkg AS
    PROCEDURE set_success(
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2,
        p_message        IN VARCHAR2
    ) IS
    BEGIN
        p_result_code := 'S';
        p_result_message := p_message;
    END set_success;

    PROCEDURE set_validation_error(
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2,
        p_message        IN VARCHAR2
    ) IS
    BEGIN
        p_result_code := 'V';
        p_result_message := p_message;
    END set_validation_error;

    PROCEDURE set_error(
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2,
        p_message        IN VARCHAR2 DEFAULT 'Unexpected error.'
    ) IS
    BEGIN
        p_result_code := 'E';
        p_result_message := p_message;
    END set_error;

    PROCEDURE set_valid(
        o_is_valid           OUT NUMBER,
        o_validation_message OUT VARCHAR2
    ) IS
    BEGIN
        o_is_valid := 1;
        o_validation_message := ph_localization_pkg.localized_text('Valid.', 'Valid.');
    END set_valid;

    PROCEDURE set_invalid(
        o_is_valid           OUT NUMBER,
        o_validation_message OUT VARCHAR2,
        p_message            IN VARCHAR2
    ) IS
    BEGIN
        o_is_valid := 0;
        o_validation_message := p_message;
    END set_invalid;

    FUNCTION yes_no(p_count IN NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN CASE WHEN p_count > 0 THEN 1 ELSE 0 END;
    END yes_no;

    FUNCTION text_missing(p_value IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN TRIM(p_value) IS NULL;
    END text_missing;

    FUNCTION text_too_long(p_value IN VARCHAR2, p_max_length IN NUMBER) RETURN BOOLEAN IS
    BEGIN
        RETURN p_value IS NOT NULL AND LENGTH(TRIM(p_value)) > p_max_length;
    END text_too_long;

    FUNCTION valid_flag(p_value IN NUMBER) RETURN BOOLEAN IS
    BEGIN
        RETURN p_value IS NULL OR p_value IN (0, 1);
    END valid_flag;

    FUNCTION valid_value_type(p_value_type IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN p_value_type IS NULL OR UPPER(TRIM(p_value_type)) IN ('STRING', 'NUMBER', 'BOOLEAN', 'JSON');
    END valid_value_type;

    FUNCTION valid_default_value_type(p_value_type IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN UPPER(TRIM(COALESCE(p_value_type, 'STRING'))) IN ('STRING', 'NUMBER', 'BOOLEAN', 'JSON', 'CODE');
    END valid_default_value_type;
END ph_helpers_pkg;
/
