/*
ProductHub Manager - Security Authentication Validation Package
Target DBMS: Oracle Database 21c+

Purpose:
- Validation service layer for ph_sec_authentication_pkg actions.
- Each procedure returns o_is_valid as 1 or 0 and o_validation_message.
*/

CREATE OR REPLACE PACKAGE ph_sec_authentication_validation_pkg AS
    PROCEDURE validate_password(
        p_password IN VARCHAR2,
        o_is_valid OUT NUMBER,
        o_validation_message OUT VARCHAR2
    );

    PROCEDURE validate_set_password(
        p_user_id IN NUMBER,
        p_password IN VARCHAR2,
        o_is_valid OUT NUMBER,
        o_validation_message OUT VARCHAR2
    );

    PROCEDURE validate_set_user_preference(
        p_username IN VARCHAR2,
        p_preference_code IN VARCHAR2,
        p_preference_value IN VARCHAR2,
        p_value_type IN VARCHAR2 DEFAULT 'STRING',
        o_user_id OUT NUMBER,
        o_preference_code OUT VARCHAR2,
        o_preference_value OUT VARCHAR2,
        o_value_type OUT VARCHAR2,
        o_is_valid OUT NUMBER,
        o_validation_message OUT VARCHAR2
    );
END ph_sec_authentication_validation_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_sec_authentication_validation_pkg AS
    PROCEDURE set_valid(o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        o_is_valid := 1;
        o_validation_message := ph_localization_pkg.localized_text('Valid.', 'Valid.');
    END set_valid;

    PROCEDURE set_invalid(o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2, p_message IN VARCHAR2) IS
    BEGIN
        o_is_valid := 0;
        o_validation_message := p_message;
    END set_invalid;



    FUNCTION user_exists(p_user_id IN NUMBER) RETURN BOOLEAN IS
        l_count NUMBER;
    BEGIN
        SELECT COUNT(*)
          INTO l_count
          FROM ph_sec_users
         WHERE user_id = p_user_id
           AND is_deleted = 0;

        RETURN l_count > 0;
    END user_exists;

    PROCEDURE validate_password(
        p_password IN VARCHAR2,
        o_is_valid OUT NUMBER,
        o_validation_message OUT VARCHAR2
    ) IS
    BEGIN
        IF p_password IS NULL OR LENGTH(p_password) < 8 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('PASSWORD_MIN_LENGTH'));
            RETURN;
        END IF;

        set_valid(o_is_valid, o_validation_message);
    END validate_password;

    PROCEDURE validate_set_password(
        p_user_id IN NUMBER,
        p_password IN VARCHAR2,
        o_is_valid OUT NUMBER,
        o_validation_message OUT VARCHAR2
    ) IS
    BEGIN
        validate_password(p_password, o_is_valid, o_validation_message);
        IF o_is_valid = 0 THEN
            RETURN;
        END IF;

        IF NOT user_exists(p_user_id) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('USER_NOT_FOUND'));
            RETURN;
        END IF;

        set_valid(o_is_valid, o_validation_message);
    END validate_set_password;

    PROCEDURE validate_set_user_preference(
        p_username IN VARCHAR2,
        p_preference_code IN VARCHAR2,
        p_preference_value IN VARCHAR2,
        p_value_type IN VARCHAR2 DEFAULT 'STRING',
        o_user_id OUT NUMBER,
        o_preference_code OUT VARCHAR2,
        o_preference_value OUT VARCHAR2,
        o_value_type OUT VARCHAR2,
        o_is_valid OUT NUMBER,
        o_validation_message OUT VARCHAR2
    ) IS
    BEGIN
        o_user_id := NULL;
        o_preference_code := UPPER(TRIM(p_preference_code));
        o_preference_value := TRIM(p_preference_value);
        o_value_type := UPPER(TRIM(COALESCE(p_value_type, 'STRING')));

        BEGIN
            SELECT user_id
              INTO o_user_id
              FROM ph_sec_users
             WHERE LOWER(email) = LOWER(TRIM(p_username))
               AND is_deleted = 0;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('USER_NOT_FOUND'));
                RETURN;
        END;

        IF o_preference_code IS NULL OR o_value_type NOT IN ('STRING', 'NUMBER', 'BOOLEAN', 'JSON') THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
            RETURN;
        END IF;

        IF o_preference_code = 'LANGUAGE' THEN
            o_preference_value := ph_localization_pkg.normalize_code(o_preference_value);
            o_value_type := 'STRING';
        ELSIF o_preference_code = 'THEME_MODE' THEN
            o_preference_value := UPPER(COALESCE(o_preference_value, 'SYSTEM'));
            IF o_preference_value NOT IN ('LIGHT', 'DARK', 'SYSTEM') THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
                RETURN;
            END IF;
            o_value_type := 'STRING';
        ELSIF o_preference_code = 'DARK_MODE' THEN
            o_preference_value := CASE WHEN LOWER(o_preference_value) IN ('1', 'true', 'yes', 'y') THEN '1' ELSE '0' END;
            o_value_type := 'BOOLEAN';
        ELSIF o_preference_code = 'PAGE_SIZE' THEN
            BEGIN
                IF TO_NUMBER(o_preference_value) < 1 THEN
                    set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
                    RETURN;
                END IF;
            EXCEPTION
                WHEN VALUE_ERROR THEN
                    set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
                    RETURN;
            END;
            o_value_type := 'NUMBER';
        ELSIF o_preference_code = 'TIME_FORMAT' THEN
            o_preference_value := UPPER(COALESCE(o_preference_value, '24H'));
            IF o_preference_value NOT IN ('12H', '24H') THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
                RETURN;
            END IF;
            o_value_type := 'STRING';
        ELSIF o_preference_code = 'DENSITY' THEN
            o_preference_value := UPPER(COALESCE(o_preference_value, 'COMFORTABLE'));
            IF o_preference_value NOT IN ('COMPACT', 'COMFORTABLE', 'SPACIOUS') THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
                RETURN;
            END IF;
            o_value_type := 'STRING';
        END IF;

        set_valid(o_is_valid, o_validation_message);
    END validate_set_user_preference;
END ph_sec_authentication_validation_pkg;
/
