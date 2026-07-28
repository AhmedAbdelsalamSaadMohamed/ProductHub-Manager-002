/*
    ProductHub Manager - Localization Package
    Target DBMS: Oracle Database 21c+

    Purpose:
    - Central service layer for language, translation, and localized message helpers.
*/

CREATE OR REPLACE PACKAGE ph_localization_pkg AS
    FUNCTION normalize_language(p_language IN VARCHAR2) RETURN VARCHAR2;

    FUNCTION current_language RETURN VARCHAR2;

    PROCEDURE set_language (
        p_language IN VARCHAR2
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
        p_message_code IN VARCHAR2
    ) RETURN VARCHAR2;
END ph_localization_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_localization_pkg AS

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
                NULL;
        END;

        RETURN 'en';
    END normalize_language;

    FUNCTION normalize_username(p_username IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN LOWER(TRIM(p_username));
    END normalize_username;

    FUNCTION current_apex_username RETURN VARCHAR2 IS
        l_username VARCHAR2(255);
    BEGIN
        l_username := normalize_username(COALESCE(
            APEX_APPLICATION.G_USER,
            V('P9999_USERNAME'),
            V('P101_USERNAME'),
            V('APP_USER'),
            SYS_CONTEXT('APEX$SESSION', 'APP_USER'),
            SYS_CONTEXT('USERENV', 'CLIENT_IDENTIFIER')
        ));

        IF l_username IN ('nobody', 'apex_public_user') THEN
            l_username := normalize_username(COALESCE(
                V('P9999_USERNAME'),
                V('P101_USERNAME'),
                SYS_CONTEXT('USERENV', 'CLIENT_IDENTIFIER')
            ));
        END IF;

        RETURN l_username;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN normalize_username(SYS_CONTEXT('USERENV', 'CLIENT_IDENTIFIER'));
    END current_apex_username;

    FUNCTION current_language RETURN VARCHAR2 IS
        l_language VARCHAR2(50);
        l_username ph_sec_users.email%TYPE;
    BEGIN
        BEGIN
            l_language := V('G_LANG');
        EXCEPTION
            WHEN OTHERS THEN
                l_language := NULL;
        END;

        IF l_language IS NULL THEN
            BEGIN
                l_username := current_apex_username;

                SELECT pref.preference_value
                  INTO l_language
                  FROM ph_sec_user_preferences pref
                  JOIN ph_sec_users u
                    ON u.user_id = pref.user_id
                 WHERE LOWER(u.email) = l_username
                   AND u.is_active = 1
                   AND u.is_deleted = 0
                   AND pref.preference_code = 'LANGUAGE'
                   AND pref.is_active = 1
                   AND pref.is_deleted = 0;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    l_language := NULL;
                WHEN OTHERS THEN
                    l_language := NULL;
            END;
        END IF;

        IF l_language IS NULL THEN
            BEGIN
                l_language := APEX_UTIL.GET_PREFERENCE('FSP_LANGUAGE_PREFERENCE');
            EXCEPTION
                WHEN OTHERS THEN
                    l_language := NULL;
            END;
        END IF;

        IF l_language IS NULL THEN
            BEGIN
                l_language := APEX_APPLICATION.G_BROWSER_LANGUAGE;
            EXCEPTION
                WHEN OTHERS THEN
                    l_language := NULL;
            END;
        END IF;

        IF l_language IS NULL THEN
            BEGIN
                l_language := V('APP_LANGUAGE');
            EXCEPTION
                WHEN OTHERS THEN
                    l_language := NULL;
            END;
        END IF;

        RETURN normalize_language(l_language);
    END current_language;

    PROCEDURE set_language (
        p_language IN VARCHAR2
    ) IS
        l_language VARCHAR2(20) := normalize_language(p_language);
        l_username ph_sec_users.email%TYPE;
        l_user_id ph_sec_users.user_id%TYPE;
    BEGIN
        APEX_UTIL.SET_SESSION_STATE('G_LANG', l_language);
        APEX_UTIL.SET_PREFERENCE(
            p_preference => 'FSP_LANGUAGE_PREFERENCE',
            p_value      => l_language
        );

        BEGIN
            l_username := current_apex_username;

            SELECT user_id
              INTO l_user_id
             FROM ph_sec_users
             WHERE LOWER(email) = l_username
               AND is_active = 1
               AND is_deleted = 0;

            MERGE INTO ph_sec_user_preferences target
            USING (
                SELECT l_user_id user_id,
                       'LANGUAGE' preference_code,
                       l_language preference_value,
                       'STRING' value_type
                  FROM dual
            ) source
            ON (target.user_id = source.user_id AND target.preference_code = source.preference_code)
            WHEN MATCHED THEN
                UPDATE SET
                    target.preference_value = source.preference_value,
                    target.value_type = source.value_type,
                    target.is_active = 1,
                    target.updated_by = l_user_id,
                    target.updated_at = SYSTIMESTAMP
            WHEN NOT MATCHED THEN
                INSERT (user_id, preference_code, preference_value, value_type, is_active, created_by)
                VALUES (source.user_id, source.preference_code, source.preference_value, source.value_type, 1, l_user_id);
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;
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
        p_message_code IN VARCHAR2
    ) RETURN VARCHAR2 IS
        l_message_code VARCHAR2(100) := UPPER(TRIM(p_message_code));
        l_language VARCHAR2(20) := current_language;
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
            WHEN 'SUCCESS' THEN localized_text('Success.', 'طھظ…طھ ط§ظ„ط¹ظ…ظ„ظٹط© ط¨ظ†ط¬ط§ط­.')
            WHEN 'AUTHENTICATED' THEN localized_text('Authenticated.', 'طھظ… طھط³ط¬ظٹظ„ ط§ظ„ط¯ط®ظˆظ„ ط¨ظ†ط¬ط§ط­.')
            WHEN 'INVALID_LOGIN' THEN localized_text('Invalid username or password.', 'ط§ط³ظ… ط§ظ„ظ…ط³طھط®ط¯ظ… ط£ظˆ ظƒظ„ظ…ط© ط§ظ„ظ…ط±ظˆط± ط؛ظٹط± طµط­ظٹط­ط©.')
            WHEN 'USER_NOT_FOUND' THEN localized_text('User was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ظ…ط³طھط®ط¯ظ….')
            WHEN 'USER_NOT_FOUND_INACTIVE' THEN localized_text('User was not found or is inactive.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ظ…ط³طھط®ط¯ظ… ط£ظˆ ط£ظ† ط§ظ„ظ…ط³طھط®ط¯ظ… ط؛ظٹط± ظ†ط´ط·.')
            WHEN 'PASSWORD_UPDATED' THEN localized_text('Password updated.', 'طھظ… طھط­ط¯ظٹط« ظƒظ„ظ…ط© ط§ظ„ظ…ط±ظˆط±.')
            WHEN 'PREFERENCES_UPDATED' THEN localized_text('Preferences updated.', 'طھظ… طھط­ط¯ظٹط« ط§ظ„طھظپط¶ظٹظ„ط§طھ.')
            WHEN 'INVALID_PREFERENCE' THEN localized_text('Invalid preference value.', 'ظ‚ظٹظ…ط© ط§ظ„طھظپط¶ظٹظ„ ط؛ظٹط± طµط­ظٹط­ط©.')
            WHEN 'PASSWORD_MIN_LENGTH' THEN localized_text('Password must contain at least 8 characters.', 'ظٹط¬ط¨ ط£ظ† طھط­طھظˆظٹ ظƒظ„ظ…ط© ط§ظ„ظ…ط±ظˆط± ط¹ظ„ظ‰ 8 ط£ط­ط±ظپ ط¹ظ„ظ‰ ط§ظ„ط£ظ‚ظ„.')
            WHEN 'ROLE_NOT_FOUND' THEN localized_text('Role was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ط¯ظˆط±.')
            WHEN 'OBJECT_NOT_FOUND' THEN localized_text('Object was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ظƒط§ط¦ظ†.')
            WHEN 'ACTION_NOT_FOUND' THEN localized_text('Action was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ط¥ط¬ط±ط§ط،.')
            WHEN 'PERMISSION_NOT_FOUND' THEN localized_text('Permission was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„طµظ„ط§ط­ظٹط©.')
            WHEN 'APEX_PAGE_TYPE_NOT_FOUND' THEN localized_text('APEX page type was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ظ†ظˆط¹ طµظپط­ط© APEX.')
            WHEN 'APEX_PAGE_NOT_FOUND' THEN localized_text('APEX page was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ طµظپط­ط© APEX.')
            WHEN 'APEX_PAGE_PERMISSION_NOT_FOUND' THEN localized_text('APEX page permission was not found.', 'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ طµظ„ط§ط­ظٹط© طµظپط­ط© APEX.')
            ELSE localized_text('Unknown message.', 'ط±ط³ط§ظ„ط© ط؛ظٹط± ظ…ط¹ط±ظˆظپط©.')
        END;
    END localized_message;
END ph_localization_pkg;
/
