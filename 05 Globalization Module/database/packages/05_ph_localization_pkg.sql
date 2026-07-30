/*
    ProductHub Manager - Localization Package
    Target DBMS: Oracle Database 21c+

    Purpose:
    - Central service layer for language, translation, and localized message helpers.
*/

CREATE OR REPLACE PACKAGE ph_localization_pkg AS
    FUNCTION normalize_language(p_language IN VARCHAR2) RETURN VARCHAR2;

    FUNCTION current_language RETURN VARCHAR2;

    FUNCTION current_language (
        p_user_id IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION get_user_default_language (
        p_user_id IN NUMBER
    ) RETURN VARCHAR2;

    PROCEDURE set_language (
        p_language IN VARCHAR2
    );

    PROCEDURE set_language (
        p_user_id        IN NUMBER,
        p_language       IN VARCHAR2,
        p_updated_by     IN NUMBER DEFAULT NULL,
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2
    );

    PROCEDURE set_user_default_language (
        p_user_id        IN NUMBER,
        p_language       IN VARCHAR2,
        p_updated_by     IN NUMBER DEFAULT NULL,
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2
    );

    FUNCTION localized_text (
        p_text_en  IN VARCHAR2,
        p_text_ar  IN VARCHAR2,
        p_language IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2;

    FUNCTION i18n_text (
        p_entity_name      IN VARCHAR2,
        p_entity_key       IN VARCHAR2,
        p_field_name       IN VARCHAR2,
        p_default_text_en  IN VARCHAR2 DEFAULT NULL,
        p_default_text_ar  IN VARCHAR2 DEFAULT NULL,
        p_language         IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2;

    PROCEDURE upsert_translation (
        p_entity_name   IN VARCHAR2,
        p_entity_key    IN VARCHAR2,
        p_field_name    IN VARCHAR2,
        p_language_code IN VARCHAR2,
        p_text_value    IN VARCHAR2,
        p_user_id       IN NUMBER DEFAULT NULL
    );

    FUNCTION localized_message (
        p_message_code IN VARCHAR2,
        p_user_id      IN NUMBER DEFAULT NULL
    ) RETURN VARCHAR2;
END ph_localization_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_localization_pkg AS
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

    FUNCTION normalize_language(p_language IN VARCHAR2) RETURN VARCHAR2 IS
        l_language VARCHAR2(50) := LOWER(TRIM(REPLACE(p_language, '_', '-')));
        l_base_language VARCHAR2(20);
        l_count NUMBER(10);
    BEGIN
        IF l_language IS NULL THEN
            BEGIN
                SELECT language_code
                  INTO l_language
                 FROM ph_languages
                 WHERE is_default = 1
                   AND is_active = 1
                   AND is_deleted = 0
                   AND ROWNUM = 1;
                RETURN l_language;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RETURN 'en';
                WHEN OTHERS THEN
                    log_error(
                        p_program_unit => $$PLSQL_UNIT || '.normalize_language',
                        p_error_location => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                        p_error_code => SQLCODE,
                        p_error_message => SQLERRM,
                        p_error_stack => DBMS_UTILITY.FORMAT_ERROR_STACK,
                        p_error_backtrace => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
                    );
                    RETURN 'en';
            END;
        END IF;

        BEGIN
            SELECT COUNT(*)
              INTO l_count
             FROM ph_languages
             WHERE language_code = l_language
               AND is_active = 1
               AND is_deleted = 0;

            IF l_count > 0 THEN
                RETURN l_language;
            END IF;

            l_base_language := REGEXP_SUBSTR(l_language, '^[a-z]{2,3}');

            SELECT COUNT(*)
              INTO l_count
             FROM ph_languages
             WHERE language_code = l_base_language
               AND is_active = 1
               AND is_deleted = 0;

            IF l_count > 0 THEN
                RETURN l_base_language;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                log_error(
                    p_program_unit => $$PLSQL_UNIT || '.normalize_language',
                    p_error_location => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                    p_error_code => SQLCODE,
                    p_error_message => SQLERRM,
                    p_error_stack => DBMS_UTILITY.FORMAT_ERROR_STACK,
                    p_error_backtrace => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
                );
                NULL;
        END;

        RETURN 'en';
    END normalize_language;

    FUNCTION current_language RETURN VARCHAR2 IS
        l_language VARCHAR2(20);
    BEGIN
        l_language := ph_app_defaults_pkg.get_default_code(
            p_default_key  => 'LANGUAGE',
            p_default_code => NULL
        );

        RETURN normalize_language(l_language);
    EXCEPTION
        WHEN OTHERS THEN
            log_error(
                p_program_unit => $$PLSQL_UNIT || '.current_language',
                p_error_location => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_error_code => SQLCODE,
                p_error_message => SQLERRM,
                p_error_stack => DBMS_UTILITY.FORMAT_ERROR_STACK,
                p_error_backtrace => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
            );
            RETURN normalize_language(NULL);
    END current_language;

    FUNCTION current_language (
        p_user_id IN NUMBER
    ) RETURN VARCHAR2 IS
        l_language VARCHAR2(4000);
    BEGIN
        IF p_user_id IS NULL THEN
            RETURN current_language;
        END IF;

        l_language := ph_sec_management_pkg.get_user_preference(
            p_user_id         => p_user_id,
            p_preference_code => 'LANGUAGE',
            p_default_value   => NULL
        );
        RETURN normalize_language(l_language);
    EXCEPTION
        WHEN OTHERS THEN
            log_error(
                p_program_unit => $$PLSQL_UNIT || '.current_language',
                p_program_unit_parameters => 'p_user_id=' || TO_CHAR(p_user_id),
                p_error_location => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_error_code => SQLCODE,
                p_error_message => SQLERRM,
                p_error_stack => DBMS_UTILITY.FORMAT_ERROR_STACK,
                p_error_backtrace => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
            );
            RETURN current_language;
    END current_language;

    FUNCTION get_user_default_language (
        p_user_id IN NUMBER
    ) RETURN VARCHAR2 IS
    BEGIN
        RETURN current_language(p_user_id);
    END get_user_default_language;

    PROCEDURE set_language (
        p_language IN VARCHAR2
    ) IS
    BEGIN
        NULL;
    END set_language;

    PROCEDURE set_user_default_language (
        p_user_id        IN NUMBER,
        p_language       IN VARCHAR2,
        p_updated_by     IN NUMBER DEFAULT NULL,
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2
    ) IS
    BEGIN
        set_language(
            p_user_id        => p_user_id,
            p_language       => p_language,
            p_updated_by     => p_updated_by,
            p_result_code    => p_result_code,
            p_result_message => p_result_message
        );
    END set_user_default_language;

    PROCEDURE set_language (
        p_user_id        IN NUMBER,
        p_language       IN VARCHAR2,
        p_updated_by     IN NUMBER DEFAULT NULL,
        p_result_code    OUT VARCHAR2,
        p_result_message OUT VARCHAR2
    ) IS
        l_language VARCHAR2(20) := normalize_language(p_language);
    BEGIN
        IF p_user_id IS NULL THEN
            p_result_code := 'V';
            p_result_message := 'User id is required.';
            RETURN;
        END IF;

        ph_sec_management_pkg.update_user_preference(
            p_user_id          => p_user_id,
            p_preference_code  => 'LANGUAGE',
            p_preference_value => l_language,
            p_value_type       => 'STRING',
            p_is_active        => 1,
            p_updated_by       => p_updated_by,
            p_result_code      => p_result_code,
            p_result_message   => p_result_message
        );

        IF NVL(p_result_code, 'E') = 'S' THEN
            RETURN;
        END IF;

        ph_sec_management_pkg.restore_user_preference(
            p_user_id         => p_user_id,
            p_preference_code => 'LANGUAGE',
            p_updated_by      => p_updated_by,
            p_result_code     => p_result_code,
            p_result_message  => p_result_message
        );

        IF NVL(p_result_code, 'E') = 'S' THEN
            ph_sec_management_pkg.update_user_preference(
                p_user_id          => p_user_id,
                p_preference_code  => 'LANGUAGE',
                p_preference_value => l_language,
                p_value_type       => 'STRING',
                p_is_active        => 1,
                p_updated_by       => p_updated_by,
                p_result_code      => p_result_code,
                p_result_message   => p_result_message
            );
            RETURN;
        END IF;

        ph_sec_management_pkg.create_user_preference(
            p_user_id          => p_user_id,
            p_preference_code  => 'LANGUAGE',
            p_preference_value => l_language,
            p_value_type       => 'STRING',
            p_created_by       => p_updated_by,
            p_result_code      => p_result_code,
            p_result_message   => p_result_message
        );
    EXCEPTION
        WHEN OTHERS THEN
            log_error(
                p_program_unit => $$PLSQL_UNIT || '.set_language',
                p_program_unit_parameters => 'p_user_id=' || TO_CHAR(p_user_id) || ',p_language=' || p_language,
                p_error_location => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_error_code => SQLCODE,
                p_error_message => SQLERRM,
                p_error_stack => DBMS_UTILITY.FORMAT_ERROR_STACK,
                p_error_backtrace => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
            );
            p_result_code := 'E';
            p_result_message := 'Unexpected error while setting user language.';
    END set_language;

    FUNCTION localized_text (
        p_text_en  IN VARCHAR2,
        p_text_ar  IN VARCHAR2,
        p_language IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_language VARCHAR2(20) := normalize_language(COALESCE(p_language, current_language));
    BEGIN
        IF l_language = 'ar' THEN
            RETURN COALESCE(p_text_ar, p_text_en);
        END IF;

        RETURN COALESCE(p_text_en, p_text_ar);
    END localized_text;

    FUNCTION i18n_text (
        p_entity_name      IN VARCHAR2,
        p_entity_key       IN VARCHAR2,
        p_field_name       IN VARCHAR2,
        p_default_text_en  IN VARCHAR2 DEFAULT NULL,
        p_default_text_ar  IN VARCHAR2 DEFAULT NULL,
        p_language         IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_language VARCHAR2(20) := normalize_language(COALESCE(p_language, current_language));
        l_text ph_i18n_texts.text_value%TYPE;
    BEGIN
        IF l_language IN ('en', 'ar') THEN
            RETURN localized_text(p_default_text_en, p_default_text_ar, l_language);
        END IF;

        BEGIN
            SELECT text_value
              INTO l_text
              FROM ph_i18n_texts
             WHERE entity_name = UPPER(TRIM(p_entity_name))
               AND entity_key = TRIM(p_entity_key)
               AND field_name = UPPER(TRIM(p_field_name))
               AND language_code = l_language
               AND is_deleted = 0;

            IF l_text IS NOT NULL THEN
                RETURN l_text;
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                NULL;
        END;

        IF l_language <> 'en' THEN
            BEGIN
                SELECT text_value
                  INTO l_text
                  FROM ph_i18n_texts
                 WHERE entity_name = UPPER(TRIM(p_entity_name))
                   AND entity_key = TRIM(p_entity_key)
                   AND field_name = UPPER(TRIM(p_field_name))
                   AND language_code = 'en'
                   AND is_deleted = 0;

                IF l_text IS NOT NULL THEN
                    RETURN l_text;
                END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    NULL;
            END;
        END IF;

        RETURN localized_text(p_default_text_en, p_default_text_ar, l_language);
    END i18n_text;

    PROCEDURE upsert_translation (
        p_entity_name   IN VARCHAR2,
        p_entity_key    IN VARCHAR2,
        p_field_name    IN VARCHAR2,
        p_language_code IN VARCHAR2,
        p_text_value    IN VARCHAR2,
        p_user_id       IN NUMBER DEFAULT NULL
    ) IS
        l_language VARCHAR2(20) := normalize_language(p_language_code);
    BEGIN
        IF l_language IN ('en', 'ar') THEN
            RETURN;
        END IF;

        MERGE INTO ph_i18n_texts target
        USING (
            SELECT UPPER(TRIM(p_entity_name)) entity_name,
                   TRIM(p_entity_key) entity_key,
                   UPPER(TRIM(p_field_name)) field_name,
                   l_language language_code,
                   p_text_value text_value
              FROM dual
        ) source
        ON (target.entity_name = source.entity_name
            AND target.entity_key = source.entity_key
            AND target.field_name = source.field_name
            AND target.language_code = source.language_code)
        WHEN MATCHED THEN
            UPDATE SET
                target.text_value = source.text_value,
                target.updated_by = p_user_id,
                target.updated_at = SYSTIMESTAMP
        WHEN NOT MATCHED THEN
            INSERT (entity_name, entity_key, field_name, language_code, text_value, created_by)
            VALUES (source.entity_name, source.entity_key, source.field_name, source.language_code, source.text_value, NVL(p_user_id, 1));
    END upsert_translation;


    FUNCTION localized_message (
        p_message_code IN VARCHAR2,
        p_user_id      IN NUMBER DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_message_code VARCHAR2(100) := UPPER(TRIM(p_message_code));
        l_language VARCHAR2(20) := current_language(p_user_id);
        l_message ph_i18n_messages.message_text%TYPE;
    BEGIN
        BEGIN
            SELECT message_text
              INTO l_message
             FROM ph_i18n_messages
             WHERE message_code = l_message_code
               AND language_code = l_language
               AND is_deleted = 0;
            RETURN l_message;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                NULL;
        END;

        IF l_language <> 'en' THEN
            BEGIN
                SELECT message_text
                  INTO l_message
                 FROM ph_i18n_messages
                 WHERE message_code = l_message_code
                   AND language_code = 'en'
                   AND is_deleted = 0;
                RETURN l_message;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    NULL;
            END;
        END IF;

        RETURN CASE l_message_code
            WHEN 'SUCCESS' THEN localized_text('Success.', 'طھظ…طھ ط§ظ„ط¹ظ…ظ„ظٹط© ط¨ظ†ط¬ط§ط­.', l_language)
            WHEN 'AUTHENTICATED' THEN localized_text('Authenticated.', 'طھظ… طھط³ط¬ظٹظ„ ط§ظ„ط¯ط®ظˆظ„ ط¨ظ†ط¬ط§ط­.', l_language)
            WHEN 'INVALID_LOGIN' THEN localized_text('Invalid username or password.', 'ط§ط³ظ… ط§ظ„ظ…ط³طھط®ط¯ظ… ط£ظˆ ظƒظ„ظ…ط© ط§ظ„ظ…ط±ظˆط± ط؛ظٹط± طµط­ظٹط­ط©.', l_language)
            WHEN 'USER_NOT_FOUND' THEN localized_text('User was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ظ…ط³طھط®ط¯ظ….', l_language)
            WHEN 'USER_NOT_FOUND_INACTIVE' THEN localized_text('User was not found or is inactive.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ظ…ط³طھط®ط¯ظ… ط£ظˆ ط£ظ† ط§ظ„ظ…ط³طھط®ط¯ظ… ط؛ظٹط± ظ†ط´ط·.', l_language)
            WHEN 'PASSWORD_UPDATED' THEN localized_text('Password updated.', 'طھظ… طھط­ط¯ظٹط« ظƒظ„ظ…ط© ط§ظ„ظ…ط±ظˆط±.', l_language)
            WHEN 'PREFERENCES_UPDATED' THEN localized_text('Preferences updated.', 'طھظ… طھط­ط¯ظٹط« ط§ظ„طھظپط¶ظٹظ„ط§طھ.', l_language)
            WHEN 'INVALID_PREFERENCE' THEN localized_text('Invalid preference value.', 'ظ‚ظٹظ…ط© ط§ظ„طھظپط¶ظٹظ„ ط؛ظٹط± طµط­ظٹط­ط©.', l_language)
            WHEN 'PASSWORD_MIN_LENGTH' THEN localized_text('Password must contain at least 8 characters.', 'ظٹط¬ط¨ ط£ظ† طھط­طھظˆظٹ ظƒظ„ظ…ط© ط§ظ„ظ…ط±ظˆط± ط¹ظ„ظ‰ 8 ط£ط­ط±ظپ ط¹ظ„ظ‰ ط§ظ„ط£ظ‚ظ„.', l_language)
            WHEN 'ROLE_NOT_FOUND' THEN localized_text('Role was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ط¯ظˆط±.', l_language)
            WHEN 'OBJECT_NOT_FOUND' THEN localized_text('Object was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ظƒط§ط¦ظ†.', l_language)
            WHEN 'ACTION_NOT_FOUND' THEN localized_text('Action was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ط¥ط¬ط±ط§ط،.', l_language)
            WHEN 'PERMISSION_NOT_FOUND' THEN localized_text('Permission was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„طµظ„ط§ط­ظٹط©.', l_language)
            WHEN 'APEX_PAGE_TYPE_NOT_FOUND' THEN localized_text('APEX page type was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ظ†ظˆط¹ طµظپط­ط© APEX.', l_language)
            WHEN 'APEX_PAGE_NOT_FOUND' THEN localized_text('APEX page was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ طµظپط­ط© APEX.', l_language)
            WHEN 'APEX_PAGE_PERMISSION_NOT_FOUND' THEN localized_text('APEX page permission was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ طµظ„ط§ط­ظٹط© طµظپط­ط© APEX.', l_language)
            ELSE localized_text('Unknown message.', 'ط±ط³ط§ظ„ط© ط؛ظٹط± ظ…ط¹ط±ظˆظپط©.', l_language)
        END;
    END localized_message;
END ph_localization_pkg;
/
