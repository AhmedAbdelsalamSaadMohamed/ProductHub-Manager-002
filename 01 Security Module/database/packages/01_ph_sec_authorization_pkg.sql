/*
ProductHub Manager - Security Authorization Package
Target DBMS: Oracle Database 21c+

Purpose:
- Environment-neutral role, permission, and page-access authorization helpers.
- Validation packages call this package instead of duplicating permission queries.
*/

CREATE OR REPLACE PACKAGE ph_sec_authorization_pkg AS
    SUBTYPE t_username IS VARCHAR2(255);

    FUNCTION has_role (
        p_username  IN t_username,
        p_role_code IN VARCHAR2
    ) RETURN BOOLEAN;

    FUNCTION has_permission (
        p_username        IN t_username,
        p_permission_code IN VARCHAR2
    ) RETURN BOOLEAN;

    FUNCTION has_page_access (
        p_username IN t_username,
        p_app_id   IN NUMBER,
        p_page_id  IN NUMBER
    ) RETURN BOOLEAN;

    FUNCTION user_has_permission (
        p_user_id     IN NUMBER,
        p_object_name IN VARCHAR2,
        p_action_name IN VARCHAR2
    ) RETURN NUMBER;

    FUNCTION permission_is_valid (
        p_user_id              IN NUMBER,
        p_object_name           IN VARCHAR2,
        p_action_name           IN VARCHAR2,
        o_is_valid              OUT NUMBER,
        o_validation_message    OUT VARCHAR2
    ) RETURN NUMBER;
END ph_sec_authorization_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_sec_authorization_pkg AS
    FUNCTION normalize_username(p_username IN t_username) RETURN VARCHAR2 IS
    BEGIN
        RETURN LOWER(TRIM(p_username));
    END normalize_username;

    FUNCTION yes_no(p_count IN NUMBER) RETURN NUMBER IS
    BEGIN
        IF p_count > 0 THEN
            RETURN 1;
        END IF;

        RETURN 0;
    END yes_no;

    PROCEDURE set_invalid (
        o_is_valid              OUT NUMBER,
        o_validation_message    OUT VARCHAR2,
        p_message               IN VARCHAR2
    ) IS
    BEGIN
        o_is_valid := 0;
        o_validation_message := p_message;
    END set_invalid;

    FUNCTION user_is_authenticated(p_user_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
          INTO l_count
          FROM ph_sec_users
         WHERE user_id = p_user_id
           AND is_active = 1
           AND is_deleted = 0;

        RETURN yes_no(l_count);
    END user_is_authenticated;

    FUNCTION has_role (
        p_username  IN t_username,
        p_role_code IN VARCHAR2
    ) RETURN BOOLEAN IS
        l_count     NUMBER(10);
        l_username  ph_sec_users.email%TYPE := normalize_username(p_username);
    BEGIN
        SELECT COUNT(*)
          INTO l_count
          FROM ph_sec_users u
          JOIN ph_sec_user_roles ur
            ON ur.user_id = u.user_id
          JOIN ph_sec_roles r
            ON r.role_id = ur.role_id
         WHERE LOWER(u.email) = l_username
           AND u.is_active = 1
           AND u.is_deleted = 0
           AND ur.is_deleted = 0
           AND r.is_active = 1
           AND r.is_deleted = 0
           AND (
                TO_CHAR(r.role_id) = TRIM(p_role_code)
                OR UPPER(r.role_name_en) = UPPER(TRIM(p_role_code))
           );

        RETURN l_count > 0;
    END has_role;

    FUNCTION has_permission (
        p_username        IN t_username,
        p_permission_code IN VARCHAR2
    ) RETURN BOOLEAN IS
        l_count     NUMBER(10);
        l_username  ph_sec_users.email%TYPE := normalize_username(p_username);
    BEGIN
        SELECT COUNT(*)
          INTO l_count
          FROM vw_ph_sec_user_permissions
         WHERE LOWER(email) = l_username
           AND (
                TO_CHAR(permission_id) = TRIM(p_permission_code)
                OR UPPER(permission_name_en) = UPPER(TRIM(p_permission_code))
                OR UPPER(object_name || ':' || action_name) = UPPER(TRIM(p_permission_code))
           );

        RETURN l_count > 0;
    END has_permission;

    FUNCTION has_page_access (
        p_username IN t_username,
        p_app_id   IN NUMBER,
        p_page_id  IN NUMBER
    ) RETURN BOOLEAN IS
        l_count     NUMBER(10);
        l_username  ph_sec_users.email%TYPE := normalize_username(p_username);
    BEGIN
        IF p_app_id IS NULL OR p_page_id IS NULL THEN
            RETURN FALSE;
        END IF;

        SELECT COUNT(*)
          INTO l_count
          FROM ph_sec_apex_pages pg
         WHERE pg.apex_app_id = p_app_id
           AND pg.apex_page_no = p_page_id
           AND pg.is_active = 1
           AND pg.is_deleted = 0
           AND (
                pg.is_public = 1
                OR (
                    pg.access_mode = 'ANY'
                    AND EXISTS (
                        SELECT 1
                          FROM ph_sec_apex_page_permissions pp
                          JOIN vw_ph_sec_user_permissions up
                            ON up.permission_id = pp.permission_id
                         WHERE pp.apex_page_id = pg.apex_page_id
                           AND pp.is_active = 1
                           AND pp.is_deleted = 0
                           AND pp.is_an_access_permission = 1
                           AND LOWER(up.email) = l_username
                    )
                )
                OR (
                    pg.access_mode = 'ALL'
                    AND EXISTS (
                        SELECT 1
                          FROM ph_sec_apex_page_permissions pp
                         WHERE pp.apex_page_id = pg.apex_page_id
                           AND pp.is_active = 1
                           AND pp.is_deleted = 0
                           AND pp.is_an_access_permission = 1
                    )
                    AND NOT EXISTS (
                        SELECT 1
                          FROM ph_sec_apex_page_permissions pp
                         WHERE pp.apex_page_id = pg.apex_page_id
                           AND pp.is_active = 1
                           AND pp.is_deleted = 0
                           AND pp.is_an_access_permission = 1
                           AND NOT EXISTS (
                                SELECT 1
                                  FROM vw_ph_sec_user_permissions up
                                 WHERE up.permission_id = pp.permission_id
                                   AND LOWER(up.email) = l_username
                           )
                    )
                )
           );

        RETURN l_count > 0;
    END has_page_access;

    FUNCTION user_has_permission (
        p_user_id     IN NUMBER,
        p_object_name IN VARCHAR2,
        p_action_name IN VARCHAR2
    ) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
          INTO l_count
          FROM vw_ph_sec_user_permissions
         WHERE user_id = p_user_id
           AND object_name = UPPER(TRIM(p_object_name))
           AND action_name = UPPER(TRIM(p_action_name));

        RETURN yes_no(l_count);
    END user_has_permission;

    FUNCTION permission_is_valid (
        p_user_id              IN NUMBER,
        p_object_name           IN VARCHAR2,
        p_action_name           IN VARCHAR2,
        o_is_valid              OUT NUMBER,
        o_validation_message    OUT VARCHAR2
    ) RETURN NUMBER IS
    BEGIN
        IF p_user_id IS NULL THEN
            set_invalid(
                o_is_valid,
                o_validation_message,
                ph_localization_pkg.localized_text(
                    'Authenticated user is required for validation.',
                    'Authenticated user is required for validation.'
                )
            );
            RETURN 0;
        ELSIF user_is_authenticated(p_user_id) = 0 THEN
            set_invalid(
                o_is_valid,
                o_validation_message,
                ph_localization_pkg.localized_text(
                    'Authenticated user is not active or was not found.',
                    'Authenticated user is not active or was not found.'
                )
            );
            RETURN 0;
        ELSIF user_has_permission(p_user_id, p_object_name, p_action_name) = 0 THEN
            set_invalid(
                o_is_valid,
                o_validation_message,
                ph_localization_pkg.localized_text(
                    'User does not have permission to perform this action.',
                    'User does not have permission to perform this action.'
                )
            );
            RETURN 0;
        END IF;

        RETURN 1;
    END permission_is_valid;
END ph_sec_authorization_pkg;
/
