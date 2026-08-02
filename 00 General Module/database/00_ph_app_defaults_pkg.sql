/*
ProductHub Manager - Application Defaults Package
Target DBMS: Oracle Database 21c+

Purpose:
- Shared service layer for application-level default values.
*/

CREATE OR REPLACE PACKAGE ph_app_defaults_pkg AS
    FUNCTION get_default_code (
        p_default_key  IN VARCHAR2,
        p_default_code IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2;

    FUNCTION get_default_value (
        p_default_key   IN VARCHAR2,
        p_default_value IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2;

    FUNCTION get_value_type (
        p_default_key IN VARCHAR2
    ) RETURN VARCHAR2;

    PROCEDURE set_default_value (
        p_default_key       IN VARCHAR2,
        p_default_code      IN VARCHAR2 DEFAULT NULL,
        p_default_value     IN VARCHAR2 DEFAULT NULL,
        p_value_type        IN VARCHAR2 DEFAULT 'STRING',
        p_description_en    IN VARCHAR2 DEFAULT NULL,
        p_description_ar    IN VARCHAR2 DEFAULT NULL,
        p_is_system_default IN NUMBER DEFAULT 0,
        p_is_active         IN NUMBER DEFAULT 1,
        p_updated_by        IN NUMBER DEFAULT NULL,
        p_result_code       OUT VARCHAR2,
        p_result_message    OUT VARCHAR2
    );

    PROCEDURE delete_default_value (
        p_default_key    IN VARCHAR2,
        p_updated_by     IN NUMBER DEFAULT NULL,
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2
    );

    PROCEDURE restore_default_value (
        p_default_key    IN VARCHAR2,
        p_updated_by     IN NUMBER DEFAULT NULL,
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2
    );
END ph_app_defaults_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_app_defaults_pkg AS
    FUNCTION get_default_code (
        p_default_key  IN VARCHAR2,
        p_default_code IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_default_code ph_app_default_values.default_code%TYPE;
    BEGIN
        SELECT default_code
          INTO l_default_code
          FROM ph_app_default_values
         WHERE default_key = UPPER(TRIM(p_default_key))
           AND is_active = 1
           AND is_deleted = 0;

        RETURN COALESCE(l_default_code, p_default_code);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_default_code;
        WHEN OTHERS THEN
            RETURN p_default_code;
    END get_default_code;

    FUNCTION get_default_value (
        p_default_key   IN VARCHAR2,
        p_default_value IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_default_value ph_app_default_values.default_value%TYPE;
    BEGIN
        SELECT default_value
          INTO l_default_value
          FROM ph_app_default_values
         WHERE default_key = UPPER(TRIM(p_default_key))
           AND is_active = 1
           AND is_deleted = 0;

        RETURN COALESCE(l_default_value, p_default_value);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_default_value;
        WHEN OTHERS THEN
            RETURN p_default_value;
    END get_default_value;

    FUNCTION get_value_type (
        p_default_key IN VARCHAR2
    ) RETURN VARCHAR2 IS
        l_value_type ph_app_default_values.value_type%TYPE;
    BEGIN
        SELECT value_type
          INTO l_value_type
          FROM ph_app_default_values
         WHERE default_key = UPPER(TRIM(p_default_key))
           AND is_active = 1
           AND is_deleted = 0;

        RETURN l_value_type;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END get_value_type;

    PROCEDURE set_default_value (
        p_default_key       IN VARCHAR2,
        p_default_code      IN VARCHAR2 DEFAULT NULL,
        p_default_value     IN VARCHAR2 DEFAULT NULL,
        p_value_type        IN VARCHAR2 DEFAULT 'STRING',
        p_description_en    IN VARCHAR2 DEFAULT NULL,
        p_description_ar    IN VARCHAR2 DEFAULT NULL,
        p_is_system_default IN NUMBER DEFAULT 0,
        p_is_active         IN NUMBER DEFAULT 1,
        p_updated_by        IN NUMBER DEFAULT NULL,
        p_result_code       OUT VARCHAR2,
        p_result_message    OUT VARCHAR2
    ) IS
        l_default_key ph_app_default_values.default_key%TYPE := UPPER(TRIM(p_default_key));
        l_value_type  ph_app_default_values.value_type%TYPE := UPPER(TRIM(COALESCE(p_value_type, 'STRING')));
    BEGIN
        IF l_default_key IS NULL THEN
            ph_helpers_pkg.set_validation_error(p_result_code, p_result_message, 'Default key is required.');
            RETURN;
        ELSIF NOT ph_helpers_pkg.valid_default_value_type(l_value_type) THEN
            ph_helpers_pkg.set_validation_error(p_result_code, p_result_message, 'Default value type must be STRING, NUMBER, BOOLEAN, JSON, or CODE.');
            RETURN;
        ELSIF NOT ph_helpers_pkg.valid_flag(COALESCE(p_is_system_default, 0)) THEN
            ph_helpers_pkg.set_validation_error(p_result_code, p_result_message, 'System default flag must be 0 or 1.');
            RETURN;
        ELSIF NOT ph_helpers_pkg.valid_flag(COALESCE(p_is_active, 1)) THEN
            ph_helpers_pkg.set_validation_error(p_result_code, p_result_message, 'Active flag must be 0 or 1.');
            RETURN;
        END IF;

        MERGE INTO ph_app_default_values target
        USING (
            SELECT l_default_key default_key,
                   TRIM(p_default_code) default_code,
                   TRIM(p_default_value) default_value,
                   l_value_type value_type,
                   TRIM(p_description_en) description_en,
                   TRIM(p_description_ar) description_ar,
                   COALESCE(p_is_system_default, 0) is_system_default,
                   COALESCE(p_is_active, 1) is_active
              FROM dual
        ) source
        ON (target.default_key = source.default_key)
        WHEN MATCHED THEN
            UPDATE SET
                target.default_code = source.default_code,
                target.default_value = source.default_value,
                target.value_type = source.value_type,
                target.description_en = source.description_en,
                target.description_ar = source.description_ar,
                target.is_system_default = source.is_system_default,
                target.is_active = source.is_active,
                target.is_deleted = 0,
                target.deleted_by = NULL,
                target.deleted_at = NULL,
                target.updated_by = p_updated_by,
                target.updated_at = SYSTIMESTAMP
        WHEN NOT MATCHED THEN
            INSERT (
                default_key,
                default_code,
                default_value,
                value_type,
                description_en,
                description_ar,
                is_system_default,
                is_active,
                created_by
            ) VALUES (
                source.default_key,
                source.default_code,
                source.default_value,
                source.value_type,
                source.description_en,
                source.description_ar,
                source.is_system_default,
                source.is_active,
                NVL(p_updated_by, 1)
            );

        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Application default value saved successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            ph_helpers_pkg.set_error(p_result_code, p_result_message, 'Unexpected error while managing application default value.');
    END set_default_value;

    PROCEDURE delete_default_value (
        p_default_key    IN VARCHAR2,
        p_updated_by     IN NUMBER DEFAULT NULL,
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2
    ) IS
        l_default_key ph_app_default_values.default_key%TYPE := UPPER(TRIM(p_default_key));
    BEGIN
        IF l_default_key IS NULL THEN
            ph_helpers_pkg.set_validation_error(p_result_code, p_result_message, 'Default key is required.');
            RETURN;
        END IF;

        UPDATE ph_app_default_values
           SET is_deleted = 1,
               updated_by = p_updated_by,
               updated_at = SYSTIMESTAMP
         WHERE default_key = l_default_key
           AND is_deleted = 0;

        IF SQL%ROWCOUNT = 0 THEN
            ph_helpers_pkg.set_validation_error(p_result_code, p_result_message, 'Application default value was not found.');
        ELSE
            ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Application default value deleted successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ph_helpers_pkg.set_error(p_result_code, p_result_message, 'Unexpected error while managing application default value.');
    END delete_default_value;

    PROCEDURE restore_default_value (
        p_default_key    IN VARCHAR2,
        p_updated_by     IN NUMBER DEFAULT NULL,
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2
    ) IS
        l_default_key ph_app_default_values.default_key%TYPE := UPPER(TRIM(p_default_key));
    BEGIN
        IF l_default_key IS NULL THEN
            ph_helpers_pkg.set_validation_error(p_result_code, p_result_message, 'Default key is required.');
            RETURN;
        END IF;

        UPDATE ph_app_default_values
           SET is_deleted = 0,
               deleted_by = NULL,
               deleted_at = NULL,
               updated_by = p_updated_by,
               updated_at = SYSTIMESTAMP
         WHERE default_key = l_default_key;

        IF SQL%ROWCOUNT = 0 THEN
            ph_helpers_pkg.set_validation_error(p_result_code, p_result_message, 'Application default value was not found.');
        ELSE
            ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Application default value restored successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ph_helpers_pkg.set_error(p_result_code, p_result_message, 'Unexpected error while managing application default value.');
    END restore_default_value;
END ph_app_defaults_pkg;
/
