/*
ProductHub Manager - Generic Security Authentication Package
Target DBMS: Oracle Database 21c+

Purpose:
- Environment-neutral authentication, password, JWT access token, refresh token, preference, and security context helpers.
- Access Token = signed JWT, valid for 15 minutes.
- Refresh Token = random opaque token; only its SHA-256 hash is stored in the database.
- Do not use database sessions for login state.
- Do not call APEX runtime APIs from this package.
*/
CREATE OR REPLACE PACKAGE ph_sec_authentication_pkg AS
    SUBTYPE t_username IS VARCHAR2(255);
    SUBTYPE t_password IS VARCHAR2(4000);
    SUBTYPE t_token IS VARCHAR2(4000);

    c_access_token_minutes CONSTANT PLS_INTEGER := 15;
    c_refresh_token_days CONSTANT PLS_INTEGER := 30;
    c_password_reset_minutes CONSTANT PLS_INTEGER := 30;

    FUNCTION authenticate_user (
        p_username IN t_username,
        p_password IN t_password
    ) RETURN BOOLEAN;

    PROCEDURE login (
        p_username                 IN t_username,
        p_password                 IN t_password,
        o_access_token             OUT CLOB,
        o_access_token_expires_in  OUT NUMBER,
        o_refresh_token            OUT t_token,
        o_refresh_token_expires_at OUT TIMESTAMP,
        o_user_id                  OUT NUMBER,
        o_customer_id              OUT NUMBER,
        o_result_code              OUT VARCHAR2,
        o_result_message           OUT VARCHAR2
    );

    PROCEDURE refresh_access_token (
        p_refresh_token            IN t_token,
        o_access_token             OUT CLOB,
        o_access_token_expires_in  OUT NUMBER,
        o_refresh_token            OUT t_token,
        o_refresh_token_expires_at OUT TIMESTAMP,
        o_user_id                  OUT NUMBER,
        o_customer_id              OUT NUMBER,
        o_result_code              OUT VARCHAR2,
        o_result_message           OUT VARCHAR2
    );

    PROCEDURE revoke_refresh_token (
        p_refresh_token  IN t_token,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    );

    PROCEDURE logout (
        p_refresh_token  IN t_token,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    );

    PROCEDURE logout_all_devices (
        p_access_token   IN CLOB,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    );

    PROCEDURE get_current_user (
        p_access_token   IN CLOB,
        o_user_id        OUT NUMBER,
        o_customer_id    OUT NUMBER,
        o_username       OUT VARCHAR2,
        o_display_name   OUT VARCHAR2,
        o_user_type      OUT NUMBER,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    );

    PROCEDURE forgot_password (
        p_username               IN t_username,
        o_reset_token            OUT t_token,
        o_reset_token_expires_at OUT TIMESTAMP,
        o_result_code            OUT VARCHAR2,
        o_result_message         OUT VARCHAR2
    );

    PROCEDURE reset_password (
        p_reset_token    IN t_token,
        p_new_password   IN t_password,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    );

    FUNCTION validate_access_token (
        p_access_token IN CLOB
    ) RETURN BOOLEAN;

    FUNCTION hash_password (
        p_password IN t_password,
        p_salt     IN VARCHAR2
    ) RETURN VARCHAR2;

    FUNCTION verify_password (
        p_password      IN t_password,
        p_password_hash IN VARCHAR2,
        p_salt          IN VARCHAR2
    ) RETURN BOOLEAN;

    FUNCTION is_user_active (
        p_username IN t_username
    ) RETURN BOOLEAN;

    FUNCTION is_user_locked (
        p_username IN t_username
    ) RETURN BOOLEAN;

    FUNCTION must_change_password (
        p_username IN t_username
    ) RETURN BOOLEAN;

    PROCEDURE register_failed_login (
        p_username IN t_username
    );

    PROCEDURE register_success_login (
        p_username IN t_username
    );

    PROCEDURE lock_user (
        p_username IN t_username
    );

    PROCEDURE unlock_user (
        p_username IN t_username
    );

    FUNCTION get_user_preference (
        p_username        IN t_username,
        p_preference_code IN VARCHAR2,
        p_default_value   IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2;

    PROCEDURE set_user_preference (
        p_username         IN t_username,
        p_preference_code  IN VARCHAR2,
        p_preference_value IN VARCHAR2,
        p_value_type       IN VARCHAR2 DEFAULT 'STRING',
        p_updated_by       IN NUMBER DEFAULT NULL
    );

    PROCEDURE set_password (
        p_user_id    IN NUMBER,
        p_password   IN t_password,
        p_updated_by IN NUMBER DEFAULT NULL
    );

    PROCEDURE set_security_context (
        p_username IN t_username
    );

    PROCEDURE set_security_context_from_token (
        p_access_token IN CLOB
    );

    PROCEDURE clear_security_context;

    FUNCTION get_user_id RETURN NUMBER;

    FUNCTION get_org_id RETURN NUMBER;

    FUNCTION get_username RETURN VARCHAR2;
END ph_sec_authentication_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_sec_authentication_pkg AS
    g_user_id  ph_sec_users.user_id%TYPE;
    g_org_id   ph_sec_users.customer_id%TYPE;
    g_username ph_sec_users.email%TYPE;

    c_jwt_issuer CONSTANT VARCHAR2(100) := 'ProductHub Manager';
    c_jwt_secret CONSTANT VARCHAR2(4000) := 'CHANGE_THIS_SECRET_IN_EACH_ENVIRONMENT';

    FUNCTION normalize_username (
        p_username IN t_username
    ) RETURN VARCHAR2 IS
    BEGIN
        RETURN LOWER(TRIM(p_username));
    END normalize_username;

    FUNCTION normalize_preference_code (
        p_preference_code IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        RETURN UPPER(TRIM(p_preference_code));
    END normalize_preference_code;

    FUNCTION epoch_seconds RETURN NUMBER IS
    BEGIN
        RETURN FLOOR((CAST(SYS_EXTRACT_UTC(SYSTIMESTAMP) AS DATE) - DATE '1970-01-01') * 86400);
    END epoch_seconds;

    FUNCTION json_escape (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        RETURN REPLACE(REPLACE(REPLACE(p_value, '\', '\\'), '"', '\"'), CHR(10), '\n');
    END json_escape;

    FUNCTION base64url_encode_raw (
        p_raw IN RAW
    ) RETURN VARCHAR2 IS
        l_value VARCHAR2(32767);
    BEGIN
        l_value := UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(p_raw));
        l_value := REPLACE(REPLACE(REPLACE(REPLACE(l_value, CHR(10), NULL), CHR(13), NULL), '+', '-'), '/', '_');
        RETURN RTRIM(l_value, '=');
    END base64url_encode_raw;

    FUNCTION base64url_encode (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        RETURN base64url_encode_raw(UTL_RAW.CAST_TO_RAW(p_value));
    END base64url_encode;

    FUNCTION base64url_decode (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2 IS
        l_value VARCHAR2(32767) := REPLACE(REPLACE(p_value, '-', '+'), '_', '/');
    BEGIN
        WHILE MOD(LENGTH(l_value), 4) <> 0 LOOP
            l_value := l_value || '=';
        END LOOP;

        RETURN UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_DECODE(UTL_RAW.CAST_TO_RAW(l_value)));
    END base64url_decode;

    FUNCTION jwt_signature (
        p_signing_input IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        RETURN base64url_encode_raw(DBMS_CRYPTO.MAC(
            src => UTL_RAW.CAST_TO_RAW(p_signing_input),
            typ => DBMS_CRYPTO.HMAC_SH256,
            key => UTL_RAW.CAST_TO_RAW(c_jwt_secret)
        ));
    END jwt_signature;

    FUNCTION hash_token (
        p_token IN t_token
    ) RETURN RAW IS
    BEGIN
        RETURN STANDARD_HASH(p_token, 'SHA256');
    END hash_token;

    FUNCTION new_refresh_token RETURN t_token IS
    BEGIN
        RETURN RAWTOHEX(DBMS_CRYPTO.RANDOMBYTES(32));
    END new_refresh_token;

    FUNCTION new_opaque_token RETURN t_token IS
    BEGIN
        RETURN RAWTOHEX(DBMS_CRYPTO.RANDOMBYTES(32));
    END new_opaque_token;

    PROCEDURE load_security_context (
        p_user_id IN NUMBER
    ) IS
    BEGIN
        SELECT user_id, customer_id, email
          INTO g_user_id, g_org_id, g_username
          FROM ph_sec_users
         WHERE user_id = p_user_id
           AND is_active = 1
           AND is_deleted = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            clear_security_context;
    END load_security_context;

    FUNCTION create_access_token (
        p_user_id     IN NUMBER,
        p_username    IN VARCHAR2,
        p_customer_id IN NUMBER
    ) RETURN CLOB IS
        l_iat NUMBER := epoch_seconds;
        l_exp NUMBER := l_iat + (c_access_token_minutes * 60);
        l_header VARCHAR2(32767);
        l_payload VARCHAR2(32767);
        l_signing_input VARCHAR2(32767);
    BEGIN
        l_header := '{"alg":"HS256","typ":"JWT"}';
        l_payload := '{"iss":"' || json_escape(c_jwt_issuer)
            || '","sub":"' || TO_CHAR(p_user_id)
            || '","username":"' || json_escape(p_username)
            || '","customer_id":' || COALESCE(TO_CHAR(p_customer_id), 'null')
            || ',"iat":' || TO_CHAR(l_iat)
            || ',"exp":' || TO_CHAR(l_exp)
            || ',"typ":"access"}';

        l_signing_input := base64url_encode(l_header) || '.' || base64url_encode(l_payload);
        RETURN l_signing_input || '.' || jwt_signature(l_signing_input);
    END create_access_token;

    PROCEDURE issue_refresh_token (
        p_user_id      IN NUMBER,
        p_replaces_id  IN NUMBER DEFAULT NULL,
        o_token        OUT t_token,
        o_expires_at   OUT TIMESTAMP,
        o_token_id     OUT NUMBER
    ) IS
    BEGIN
        o_token := new_refresh_token;
        o_expires_at := SYSTIMESTAMP + NUMTODSINTERVAL(c_refresh_token_days, 'DAY');

        INSERT INTO ph_sec_refresh_tokens (
            user_id,
            token_hash,
            issued_at,
            expires_at,
            created_by
        ) VALUES (
            p_user_id,
            hash_token(o_token),
            SYSTIMESTAMP,
            o_expires_at,
            p_user_id
        )
        RETURNING refresh_token_id INTO o_token_id;

        IF p_replaces_id IS NOT NULL THEN
            UPDATE ph_sec_refresh_tokens
               SET revoked_at = COALESCE(revoked_at, SYSTIMESTAMP),
                   replaced_by_token_id = o_token_id,
                   updated_by = p_user_id,
                   updated_at = SYSTIMESTAMP
             WHERE refresh_token_id = p_replaces_id;
        END IF;
    END issue_refresh_token;

    PROCEDURE issue_password_reset_token (
        p_user_id    IN NUMBER,
        o_token      OUT t_token,
        o_expires_at OUT TIMESTAMP
    ) IS
    BEGIN
        UPDATE ph_sec_password_reset_tokens
           SET used_at = COALESCE(used_at, SYSTIMESTAMP),
               updated_by = p_user_id,
               updated_at = SYSTIMESTAMP
         WHERE user_id = p_user_id
           AND used_at IS NULL
           AND expires_at > SYSTIMESTAMP;

        o_token := new_opaque_token;
        o_expires_at := SYSTIMESTAMP + NUMTODSINTERVAL(c_password_reset_minutes, 'MINUTE');

        INSERT INTO ph_sec_password_reset_tokens (
            user_id,
            token_hash,
            issued_at,
            expires_at,
            created_by
        ) VALUES (
            p_user_id,
            hash_token(o_token),
            SYSTIMESTAMP,
            o_expires_at,
            p_user_id
        );
    END issue_password_reset_token;

    FUNCTION get_user_record_id (
        p_username IN t_username
    ) RETURN NUMBER IS
        l_user_id ph_sec_users.user_id%TYPE;
    BEGIN
        SELECT user_id
          INTO l_user_id
          FROM ph_sec_users
         WHERE LOWER(email) = normalize_username(p_username)
           AND is_deleted = 0;

        RETURN l_user_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END get_user_record_id;

    FUNCTION get_user_preference (
        p_username        IN t_username,
        p_preference_code IN VARCHAR2,
        p_default_value   IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_user_id         ph_sec_users.user_id%TYPE := get_user_record_id(p_username);
        l_preference_code ph_sec_user_preferences.preference_code%TYPE := normalize_preference_code(p_preference_code);
        l_value           ph_sec_user_preferences.preference_value%TYPE;
    BEGIN
        IF l_user_id IS NULL OR l_preference_code IS NULL THEN
            RETURN p_default_value;
        END IF;

        SELECT preference_value
          INTO l_value
          FROM ph_sec_user_preferences
         WHERE user_id = l_user_id
           AND preference_code = l_preference_code
           AND is_active = 1
           AND is_deleted = 0;

        IF l_preference_code = 'LANGUAGE' THEN
            RETURN ph_localization_pkg.normalize_language(COALESCE(l_value, p_default_value));
        END IF;

        RETURN COALESCE(l_value, p_default_value);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_default_value;
    END get_user_preference;

    PROCEDURE set_user_preference (
        p_username         IN t_username,
        p_preference_code  IN VARCHAR2,
        p_preference_value IN VARCHAR2,
        p_value_type       IN VARCHAR2 DEFAULT 'STRING',
        p_updated_by       IN NUMBER DEFAULT NULL
    ) IS
        l_user_id         ph_sec_users.user_id%TYPE := get_user_record_id(p_username);
        l_preference_code ph_sec_user_preferences.preference_code%TYPE := normalize_preference_code(p_preference_code);
        l_value           ph_sec_user_preferences.preference_value%TYPE := TRIM(p_preference_value);
        l_value_type      ph_sec_user_preferences.value_type%TYPE := UPPER(TRIM(COALESCE(p_value_type, 'STRING')));
    BEGIN
        IF l_user_id IS NULL THEN
            raise_application_error(-20302, ph_localization_pkg.localized_message('USER_NOT_FOUND'));
        END IF;

        IF l_preference_code IS NULL OR l_value_type NOT IN ('STRING', 'NUMBER', 'BOOLEAN', 'JSON') THEN
            raise_application_error(-20391, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
        END IF;

        IF l_preference_code = 'LANGUAGE' THEN
            l_value := ph_localization_pkg.normalize_language(l_value);
            l_value_type := 'STRING';
        ELSIF l_preference_code = 'THEME_MODE' THEN
            l_value := UPPER(COALESCE(l_value, 'SYSTEM'));
            IF l_value NOT IN ('LIGHT', 'DARK', 'SYSTEM') THEN
                raise_application_error(-20391, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
            END IF;
            l_value_type := 'STRING';
        ELSIF l_preference_code = 'DARK_MODE' THEN
            l_value := CASE WHEN LOWER(l_value) IN ('1', 'true', 'yes', 'y') THEN '1' ELSE '0' END;
            l_value_type := 'BOOLEAN';
        ELSIF l_preference_code = 'PAGE_SIZE' THEN
            IF TO_NUMBER(l_value) < 1 THEN
                raise_application_error(-20391, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
            END IF;
            l_value_type := 'NUMBER';
        ELSIF l_preference_code = 'TIME_FORMAT' THEN
            l_value := UPPER(COALESCE(l_value, '24H'));
            IF l_value NOT IN ('12H', '24H') THEN
                raise_application_error(-20391, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
            END IF;
            l_value_type := 'STRING';
        ELSIF l_preference_code = 'DENSITY' THEN
            l_value := UPPER(COALESCE(l_value, 'COMFORTABLE'));
            IF l_value NOT IN ('COMPACT', 'COMFORTABLE', 'SPACIOUS') THEN
                raise_application_error(-20391, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
            END IF;
            l_value_type := 'STRING';
        END IF;

        MERGE INTO ph_sec_user_preferences target
        USING (
            SELECT l_user_id user_id,
                   l_preference_code preference_code,
                   l_value preference_value,
                   l_value_type value_type
              FROM dual
        ) source
           ON (target.user_id = source.user_id AND target.preference_code = source.preference_code)
         WHEN MATCHED THEN UPDATE SET
              target.preference_value = source.preference_value,
              target.value_type = source.value_type,
              target.is_active = 1,
              target.is_deleted = 0,
              target.deleted_by = NULL,
              target.deleted_at = NULL,
              target.updated_by = p_updated_by,
              target.updated_at = SYSTIMESTAMP
         WHEN NOT MATCHED THEN INSERT (
              user_id,
              preference_code,
              preference_value,
              value_type,
              is_active,
              created_by
         ) VALUES (
              source.user_id,
              source.preference_code,
              source.preference_value,
              source.value_type,
              1,
              NVL(p_updated_by, 1)
         );
    EXCEPTION
        WHEN VALUE_ERROR THEN
            raise_application_error(-20391, ph_localization_pkg.localized_message('INVALID_PREFERENCE'));
    END set_user_preference;

    FUNCTION hash_password (
        p_password IN t_password,
        p_salt     IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        IF p_password IS NULL OR p_salt IS NULL THEN
            RETURN NULL;
        END IF;

        RETURN RAWTOHEX(STANDARD_HASH(p_salt || ':' || p_password, 'SHA512'));
    END hash_password;

    FUNCTION verify_password (
        p_password      IN t_password,
        p_password_hash IN VARCHAR2,
        p_salt          IN VARCHAR2
    ) RETURN BOOLEAN IS
    BEGIN
        RETURN p_password_hash IS NOT NULL
           AND p_salt IS NOT NULL
           AND hash_password(p_password, p_salt) = UPPER(p_password_hash);
    END verify_password;

    FUNCTION is_user_active (
        p_username IN t_username
    ) RETURN BOOLEAN IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
          INTO l_count
          FROM ph_sec_users
         WHERE LOWER(email) = normalize_username(p_username)
           AND is_active = 1
           AND is_deleted = 0;

        RETURN l_count > 0;
    END is_user_active;

    FUNCTION is_user_locked (
        p_username IN t_username
    ) RETURN BOOLEAN IS
    BEGIN
        RETURN NOT is_user_active(p_username);
    END is_user_locked;

    FUNCTION must_change_password (
        p_username IN t_username
    ) RETURN BOOLEAN IS
        l_must_change ph_sec_users.must_change_password%TYPE;
    BEGIN
        SELECT must_change_password
          INTO l_must_change
          FROM ph_sec_users
         WHERE LOWER(email) = normalize_username(p_username)
           AND is_deleted = 0;

        RETURN l_must_change = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END must_change_password;

    PROCEDURE register_failed_login (
        p_username IN t_username
    ) IS
    BEGIN
        NULL;
    END register_failed_login;

    PROCEDURE register_success_login (
        p_username IN t_username
    ) IS
    BEGIN
        UPDATE ph_sec_users
           SET last_login_at = SYSTIMESTAMP
         WHERE LOWER(email) = normalize_username(p_username)
           AND is_deleted = 0;
    END register_success_login;

    PROCEDURE lock_user (
        p_username IN t_username
    ) IS
    BEGIN
        UPDATE ph_sec_users
           SET is_active = 0
         WHERE LOWER(email) = normalize_username(p_username)
           AND is_deleted = 0;
    END lock_user;

    PROCEDURE unlock_user (
        p_username IN t_username
    ) IS
    BEGIN
        UPDATE ph_sec_users
           SET is_active = 1
         WHERE LOWER(email) = normalize_username(p_username)
           AND is_deleted = 0;
    END unlock_user;

    PROCEDURE set_security_context (
        p_username IN t_username
    ) IS
        l_user_id ph_sec_users.user_id%TYPE;
    BEGIN
        SELECT user_id
          INTO l_user_id
          FROM ph_sec_users
         WHERE LOWER(email) = normalize_username(p_username)
           AND is_active = 1
           AND is_deleted = 0;

        load_security_context(l_user_id);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            clear_security_context;
    END set_security_context;

    PROCEDURE clear_security_context IS
    BEGIN
        g_user_id := NULL;
        g_org_id := NULL;
        g_username := NULL;
    END clear_security_context;

    FUNCTION authenticate_user (
        p_username IN t_username,
        p_password IN t_password
    ) RETURN BOOLEAN IS
        l_password_hash ph_sec_users.password_hash%TYPE;
        l_password_salt ph_sec_users.password_salt%TYPE;
        l_user_id       ph_sec_users.user_id%TYPE;
    BEGIN
        IF p_username IS NULL OR p_password IS NULL THEN
            RETURN FALSE;
        END IF;

        SELECT user_id, password_hash, password_salt
          INTO l_user_id, l_password_hash, l_password_salt
          FROM ph_sec_users
         WHERE LOWER(email) = normalize_username(p_username)
           AND is_active = 1
           AND is_deleted = 0;

        IF verify_password(p_password, RAWTOHEX(l_password_hash), RAWTOHEX(l_password_salt)) THEN
            register_success_login(p_username);
            load_security_context(l_user_id);
            RETURN TRUE;
        END IF;

        register_failed_login(p_username);
        RETURN FALSE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            register_failed_login(p_username);
            RETURN FALSE;
    END authenticate_user;

    PROCEDURE login (
        p_username                 IN t_username,
        p_password                 IN t_password,
        o_access_token             OUT CLOB,
        o_access_token_expires_in  OUT NUMBER,
        o_refresh_token            OUT t_token,
        o_refresh_token_expires_at OUT TIMESTAMP,
        o_user_id                  OUT NUMBER,
        o_customer_id              OUT NUMBER,
        o_result_code              OUT VARCHAR2,
        o_result_message           OUT VARCHAR2
    ) IS
        l_token_id NUMBER;
    BEGIN
        o_access_token := NULL;
        o_refresh_token := NULL;
        o_user_id := NULL;
        o_customer_id := NULL;
        o_access_token_expires_in := c_access_token_minutes * 60;

        IF NOT authenticate_user(p_username, p_password) THEN
            o_result_code := 'INVALID_LOGIN';
            o_result_message := ph_localization_pkg.localized_message('INVALID_LOGIN');
            RETURN;
        END IF;

        o_user_id := g_user_id;
        o_customer_id := g_org_id;
        o_access_token := create_access_token(g_user_id, g_username, g_org_id);
        issue_refresh_token(g_user_id, NULL, o_refresh_token, o_refresh_token_expires_at, l_token_id);
        o_result_code := 'SUCCESS';
        o_result_message := ph_localization_pkg.localized_message('AUTHENTICATED');
    END login;

    PROCEDURE refresh_access_token (
        p_refresh_token            IN t_token,
        o_access_token             OUT CLOB,
        o_access_token_expires_in  OUT NUMBER,
        o_refresh_token            OUT t_token,
        o_refresh_token_expires_at OUT TIMESTAMP,
        o_user_id                  OUT NUMBER,
        o_customer_id              OUT NUMBER,
        o_result_code              OUT VARCHAR2,
        o_result_message           OUT VARCHAR2
    ) IS
        l_old_token_id ph_sec_refresh_tokens.refresh_token_id%TYPE;
        l_new_token_id ph_sec_refresh_tokens.refresh_token_id%TYPE;
    BEGIN
        o_access_token := NULL;
        o_refresh_token := NULL;
        o_user_id := NULL;
        o_customer_id := NULL;
        o_access_token_expires_in := c_access_token_minutes * 60;

        SELECT rt.refresh_token_id, u.user_id, u.customer_id
          INTO l_old_token_id, o_user_id, o_customer_id
          FROM ph_sec_refresh_tokens rt
          JOIN ph_sec_users u
            ON u.user_id = rt.user_id
         WHERE rt.token_hash = hash_token(p_refresh_token)
           AND rt.revoked_at IS NULL
           AND rt.expires_at > SYSTIMESTAMP
           AND u.is_active = 1
           AND u.is_deleted = 0;

        load_security_context(o_user_id);
        o_access_token := create_access_token(g_user_id, g_username, g_org_id);
        issue_refresh_token(g_user_id, l_old_token_id, o_refresh_token, o_refresh_token_expires_at, l_new_token_id);
        o_result_code := 'SUCCESS';
        o_result_message := ph_localization_pkg.localized_message('AUTHENTICATED');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            clear_security_context;
            o_result_code := 'INVALID_REFRESH_TOKEN';
            o_result_message := 'Invalid or expired refresh token.';
    END refresh_access_token;

    PROCEDURE revoke_refresh_token (
        p_refresh_token  IN t_token,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    ) IS
    BEGIN
        UPDATE ph_sec_refresh_tokens rt
           SET revoked_at = COALESCE(revoked_at, SYSTIMESTAMP),
               updated_at = SYSTIMESTAMP
         WHERE rt.token_hash = hash_token(p_refresh_token)
           AND revoked_at IS NULL;

        o_result_code := 'SUCCESS';
        o_result_message := ph_localization_pkg.localized_message('SUCCESS');
    END revoke_refresh_token;

    PROCEDURE logout (
        p_refresh_token  IN t_token,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    ) IS
    BEGIN
        revoke_refresh_token(p_refresh_token, o_result_code, o_result_message);
        clear_security_context;
    END logout;

    PROCEDURE logout_all_devices (
        p_access_token   IN CLOB,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    ) IS
    BEGIN
        IF NOT validate_access_token(p_access_token) THEN
            o_result_code := 'INVALID_ACCESS_TOKEN';
            o_result_message := 'Invalid or expired access token.';
            RETURN;
        END IF;

        UPDATE ph_sec_refresh_tokens
           SET revoked_at = COALESCE(revoked_at, SYSTIMESTAMP),
               updated_by = g_user_id,
               updated_at = SYSTIMESTAMP
         WHERE user_id = g_user_id
           AND revoked_at IS NULL;

        o_result_code := 'SUCCESS';
        o_result_message := ph_localization_pkg.localized_message('SUCCESS');
    END logout_all_devices;

    PROCEDURE get_current_user (
        p_access_token   IN CLOB,
        o_user_id        OUT NUMBER,
        o_customer_id    OUT NUMBER,
        o_username       OUT VARCHAR2,
        o_display_name   OUT VARCHAR2,
        o_user_type      OUT NUMBER,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    ) IS
    BEGIN
        o_user_id := NULL;
        o_customer_id := NULL;
        o_username := NULL;
        o_display_name := NULL;
        o_user_type := NULL;

        IF NOT validate_access_token(p_access_token) THEN
            o_result_code := 'INVALID_ACCESS_TOKEN';
            o_result_message := 'Invalid or expired access token.';
            RETURN;
        END IF;

        SELECT user_id, customer_id, email, display_name, user_type
          INTO o_user_id, o_customer_id, o_username, o_display_name, o_user_type
          FROM ph_sec_users
         WHERE user_id = g_user_id
           AND is_active = 1
           AND is_deleted = 0;

        o_result_code := 'SUCCESS';
        o_result_message := ph_localization_pkg.localized_message('SUCCESS');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            clear_security_context;
            o_result_code := 'USER_NOT_FOUND';
            o_result_message := ph_localization_pkg.localized_message('USER_NOT_FOUND');
    END get_current_user;

    PROCEDURE forgot_password (
        p_username               IN t_username,
        o_reset_token            OUT t_token,
        o_reset_token_expires_at OUT TIMESTAMP,
        o_result_code            OUT VARCHAR2,
        o_result_message         OUT VARCHAR2
    ) IS
        l_user_id ph_sec_users.user_id%TYPE;
    BEGIN
        o_reset_token := NULL;
        o_reset_token_expires_at := NULL;

        SELECT user_id
          INTO l_user_id
          FROM ph_sec_users
         WHERE LOWER(email) = normalize_username(p_username)
           AND is_active = 1
           AND is_deleted = 0;

        issue_password_reset_token(l_user_id, o_reset_token, o_reset_token_expires_at);
        o_result_code := 'SUCCESS';
        o_result_message := 'Password reset token created.';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            o_result_code := 'SUCCESS';
            o_result_message := 'If the user exists, a password reset token will be issued.';
    END forgot_password;

    PROCEDURE reset_password (
        p_reset_token    IN t_token,
        p_new_password   IN t_password,
        o_result_code    OUT VARCHAR2,
        o_result_message OUT VARCHAR2
    ) IS
        l_reset_token_id ph_sec_password_reset_tokens.reset_token_id%TYPE;
        l_user_id ph_sec_users.user_id%TYPE;
    BEGIN
        SELECT prt.reset_token_id, prt.user_id
          INTO l_reset_token_id, l_user_id
          FROM ph_sec_password_reset_tokens prt
          JOIN ph_sec_users u
            ON u.user_id = prt.user_id
         WHERE prt.token_hash = hash_token(p_reset_token)
           AND prt.used_at IS NULL
           AND prt.expires_at > SYSTIMESTAMP
           AND u.is_active = 1
           AND u.is_deleted = 0;

        set_password(l_user_id, p_new_password, l_user_id);

        UPDATE ph_sec_password_reset_tokens
           SET used_at = SYSTIMESTAMP,
               updated_by = l_user_id,
               updated_at = SYSTIMESTAMP
         WHERE reset_token_id = l_reset_token_id;

        UPDATE ph_sec_refresh_tokens
           SET revoked_at = COALESCE(revoked_at, SYSTIMESTAMP),
               updated_by = l_user_id,
               updated_at = SYSTIMESTAMP
         WHERE user_id = l_user_id
           AND revoked_at IS NULL;

        o_result_code := 'SUCCESS';
        o_result_message := ph_localization_pkg.localized_message('PASSWORD_UPDATED');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            o_result_code := 'INVALID_RESET_TOKEN';
            o_result_message := 'Invalid or expired password reset token.';
    END reset_password;

    FUNCTION validate_access_token (
        p_access_token IN CLOB
    ) RETURN BOOLEAN IS
        l_token VARCHAR2(32767) := DBMS_LOB.SUBSTR(p_access_token, 32767, 1);
        l_dot1 PLS_INTEGER;
        l_dot2 PLS_INTEGER;
        l_header VARCHAR2(32767);
        l_payload VARCHAR2(32767);
        l_signature VARCHAR2(32767);
        l_expected_signature VARCHAR2(32767);
        l_payload_json JSON_OBJECT_T;
        l_user_id NUMBER;
        l_exp NUMBER;
    BEGIN
        l_dot1 := INSTR(l_token, '.');
        l_dot2 := INSTR(l_token, '.', l_dot1 + 1);

        IF l_dot1 = 0 OR l_dot2 = 0 THEN
            RETURN FALSE;
        END IF;

        l_header := SUBSTR(l_token, 1, l_dot1 - 1);
        l_payload := SUBSTR(l_token, l_dot1 + 1, l_dot2 - l_dot1 - 1);
        l_signature := SUBSTR(l_token, l_dot2 + 1);
        l_expected_signature := jwt_signature(l_header || '.' || l_payload);

        IF l_signature <> l_expected_signature THEN
            RETURN FALSE;
        END IF;

        l_payload_json := JSON_OBJECT_T.parse(base64url_decode(l_payload));
        IF l_payload_json.get_string('iss') <> c_jwt_issuer
           OR l_payload_json.get_string('typ') <> 'access' THEN
            RETURN FALSE;
        END IF;

        l_exp := l_payload_json.get_number('exp');
        IF l_exp <= epoch_seconds THEN
            RETURN FALSE;
        END IF;

        l_user_id := TO_NUMBER(l_payload_json.get_string('sub'));
        load_security_context(l_user_id);
        RETURN g_user_id IS NOT NULL;
    EXCEPTION
        WHEN OTHERS THEN
            clear_security_context;
            RETURN FALSE;
    END validate_access_token;

    PROCEDURE set_security_context_from_token (
        p_access_token IN CLOB
    ) IS
    BEGIN
        IF NOT validate_access_token(p_access_token) THEN
            clear_security_context;
        END IF;
    END set_security_context_from_token;

    PROCEDURE set_password (
        p_user_id    IN NUMBER,
        p_password   IN t_password,
        p_updated_by IN NUMBER DEFAULT NULL
    ) IS
        l_salt VARCHAR2(32);
        l_hash VARCHAR2(128);
    BEGIN
        IF p_password IS NULL OR LENGTH(p_password) < 8 THEN
            raise_application_error(-20301, ph_localization_pkg.localized_message('PASSWORD_MIN_LENGTH'));
        END IF;

        l_salt := RAWTOHEX(SYS_GUID());
        l_hash := hash_password(p_password, l_salt);

        UPDATE ph_sec_users
           SET password_salt = HEXTORAW(l_salt),
               password_hash = HEXTORAW(l_hash),
               must_change_password = 0,
               updated_by = p_updated_by,
               updated_at = SYSTIMESTAMP
         WHERE user_id = p_user_id
           AND is_deleted = 0;

        IF SQL%ROWCOUNT = 0 THEN
            raise_application_error(-20302, ph_localization_pkg.localized_message('USER_NOT_FOUND'));
        END IF;
    END set_password;

    FUNCTION get_user_id RETURN NUMBER IS
    BEGIN
        RETURN g_user_id;
    END get_user_id;

    FUNCTION get_org_id RETURN NUMBER IS
    BEGIN
        RETURN g_org_id;
    END get_org_id;

    FUNCTION get_username RETURN VARCHAR2 IS
    BEGIN
        RETURN g_username;
    END get_username;
END ph_sec_authentication_pkg;
/
