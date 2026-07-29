/*
ProductHub Manager - Security Management Package
Target DBMS: Oracle Database 21c+

Purpose:
- Create, update, delete, and restore security setup entities.
*/

CREATE OR REPLACE PACKAGE ph_sec_management_pkg AS
    ----------------------------------------------------------------------
    -- Create/update/delete/restore operations
    ----------------------------------------------------------------------
    ----------------------------------------------------------------------
    -- Security Entity Management
    ----------------------------------------------------------------------
    PROCEDURE create_user_type(p_user_type_name_en IN VARCHAR2, p_user_type_name_ar IN VARCHAR2, p_user_type_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_user_type(p_user_type_id IN NUMBER, p_user_type_name_en IN VARCHAR2 DEFAULT NULL, p_user_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_user_type(p_user_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_user_type(p_user_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_object_type(p_object_type_name_en IN VARCHAR2, p_object_type_name_ar IN VARCHAR2, p_object_type_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_object_type(p_object_type_id IN NUMBER, p_object_type_name_en IN VARCHAR2 DEFAULT NULL, p_object_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_object_type(p_object_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_object_type(p_object_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_object(p_parent_object_id IN NUMBER DEFAULT NULL, p_object_name IN VARCHAR2, p_object_type_id IN NUMBER, p_object_path IN VARCHAR2, p_display_name_en IN VARCHAR2, p_display_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_object_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_object(p_object_id IN NUMBER, p_parent_object_id IN NUMBER DEFAULT NULL, p_object_name IN VARCHAR2 DEFAULT NULL, p_object_type_id IN NUMBER DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_display_name_en IN VARCHAR2 DEFAULT NULL, p_display_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_object(p_object_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_object(p_object_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_action(p_action_name IN VARCHAR2, p_display_name_en IN VARCHAR2, p_display_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_action_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_action(p_action_id IN NUMBER, p_action_name IN VARCHAR2 DEFAULT NULL, p_display_name_en IN VARCHAR2 DEFAULT NULL, p_display_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_action(p_action_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_action(p_action_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_permission(p_object_id IN NUMBER, p_action_id IN NUMBER, p_permission_name_en IN VARCHAR2, p_permission_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_permission_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_permission(p_permission_id IN NUMBER, p_object_id IN NUMBER DEFAULT NULL, p_action_id IN NUMBER DEFAULT NULL, p_permission_name_en IN VARCHAR2 DEFAULT NULL, p_permission_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_permission(p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_permission(p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_user(p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_user_type IN NUMBER, p_customer_id IN NUMBER DEFAULT NULL, p_password IN VARCHAR2 DEFAULT NULL, p_must_change_password IN NUMBER DEFAULT 1, p_is_initial_admin IN NUMBER DEFAULT 0, p_user_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_user(p_user_id IN NUMBER, p_email IN VARCHAR2 DEFAULT NULL, p_display_name IN VARCHAR2 DEFAULT NULL, p_user_type IN NUMBER DEFAULT NULL, p_customer_id IN NUMBER DEFAULT NULL, p_must_change_password IN NUMBER DEFAULT NULL, p_is_initial_admin IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_user(p_user_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_user(p_user_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_preference_value IN VARCHAR2, p_value_type IN VARCHAR2 DEFAULT 'STRING', p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_preference_value IN VARCHAR2 DEFAULT NULL, p_value_type IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_role(p_role_name_en IN VARCHAR2, p_role_name_ar IN VARCHAR2, p_user_type IN NUMBER, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_system_role IN NUMBER DEFAULT 0, p_role_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_role(p_role_id IN NUMBER, p_role_name_en IN VARCHAR2 DEFAULT NULL, p_role_name_ar IN VARCHAR2 DEFAULT NULL, p_user_type IN NUMBER DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_system_role IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_role(p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_role(p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE grant_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE revoke_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE assign_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_assigned_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE revoke_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_apex_page_type(p_page_type_code IN VARCHAR2, p_page_type_name_en IN VARCHAR2, p_page_type_name_ar IN VARCHAR2, p_page_type_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_apex_page_type(p_page_type_id IN NUMBER, p_page_type_code IN VARCHAR2 DEFAULT NULL, p_page_type_name_en IN VARCHAR2 DEFAULT NULL, p_page_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_apex_page_type(p_page_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_apex_page_type(p_page_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_apex_page(p_apex_app_id IN NUMBER, p_apex_page_no IN NUMBER, p_apex_page_type_id IN NUMBER, p_page_name_en IN VARCHAR2, p_page_name_ar IN VARCHAR2, p_apex_page_id OUT NUMBER, p_page_alias IN VARCHAR2 DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_access_mode IN VARCHAR2 DEFAULT 'ANY', p_is_public IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_apex_page(p_apex_page_id IN NUMBER, p_apex_app_id IN NUMBER DEFAULT NULL, p_apex_page_no IN NUMBER DEFAULT NULL, p_apex_page_type_id IN NUMBER DEFAULT NULL, p_page_name_en IN VARCHAR2 DEFAULT NULL, p_page_name_ar IN VARCHAR2 DEFAULT NULL, p_page_alias IN VARCHAR2 DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_access_mode IN VARCHAR2 DEFAULT NULL, p_is_public IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_apex_page(p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_apex_page(p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_is_an_access_permission IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_is_an_access_permission IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
END ph_sec_management_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_sec_management_pkg AS
    FUNCTION normalize_username(p_username IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN LOWER(TRIM(p_username));
    END normalize_username;

    FUNCTION normalize_preference_code(p_preference_code IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN UPPER(TRIM(p_preference_code));
    END normalize_preference_code;

    PROCEDURE do_update_apex_page_type (
        p_page_type_id      IN NUMBER,
        p_page_type_code    IN VARCHAR2 DEFAULT NULL,
        p_page_type_name_en IN VARCHAR2 DEFAULT NULL,
        p_page_type_name_ar IN VARCHAR2 DEFAULT NULL,
        p_is_active         IN NUMBER DEFAULT NULL,
        p_updated_by        IN NUMBER DEFAULT NULL
    ) IS
    BEGIN
        UPDATE ph_sec_apex_page_type_lkp
            SET apex_page_type_code = CASE WHEN p_page_type_code IS NOT NULL THEN UPPER(TRIM(p_page_type_code)) ELSE apex_page_type_code END,
                apex_page_type_name_en = CASE WHEN p_page_type_name_en IS NOT NULL THEN TRIM(p_page_type_name_en) ELSE apex_page_type_name_en END,
                apex_page_type_name_ar = CASE WHEN p_page_type_name_ar IS NOT NULL THEN TRIM(p_page_type_name_ar) ELSE apex_page_type_name_ar END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by,
                updated_at = SYSTIMESTAMP
            WHERE apex_page_type_id = p_page_type_id
                AND is_deleted = 0
                AND ((p_page_type_code IS NOT NULL AND DECODE(apex_page_type_code, UPPER(TRIM(p_page_type_code)), 0, 1) = 1)
                OR (p_page_type_name_en IS NOT NULL AND DECODE(apex_page_type_name_en, TRIM(p_page_type_name_en), 0, 1) = 1)
                OR (p_page_type_name_ar IS NOT NULL AND DECODE(apex_page_type_name_ar, TRIM(p_page_type_name_ar), 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

    END do_update_apex_page_type;

    PROCEDURE do_delete_apex_page_type (
        p_page_type_id IN NUMBER,
        p_updated_by   IN NUMBER DEFAULT NULL
    ) IS
    BEGIN
        UPDATE ph_sec_apex_page_type_lkp
            SET is_deleted = 1,
                deleted_by = p_updated_by,
                deleted_at = SYSTIMESTAMP
            WHERE apex_page_type_id = p_page_type_id
                AND is_deleted = 0;

    END do_delete_apex_page_type;

    PROCEDURE do_restore_apex_page_type (
        p_page_type_id IN NUMBER,
        p_updated_by   IN NUMBER DEFAULT NULL
    ) IS
    BEGIN
        UPDATE ph_sec_apex_page_type_lkp
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by,
                updated_at = SYSTIMESTAMP
            WHERE apex_page_type_id = p_page_type_id;

    END do_restore_apex_page_type;

    PROCEDURE do_update_apex_page (
        p_apex_page_id      IN NUMBER,
        p_apex_app_id       IN NUMBER DEFAULT NULL,
        p_apex_page_no      IN NUMBER DEFAULT NULL,
        p_apex_page_type_id IN NUMBER DEFAULT NULL,
        p_page_name_en      IN VARCHAR2 DEFAULT NULL,
        p_page_name_ar      IN VARCHAR2 DEFAULT NULL,
        p_page_alias        IN VARCHAR2 DEFAULT NULL,
        p_object_path       IN VARCHAR2 DEFAULT NULL,
        p_access_mode       IN VARCHAR2 DEFAULT NULL,
        p_is_public         IN NUMBER DEFAULT NULL,
        p_is_active         IN NUMBER DEFAULT NULL,
        p_updated_by        IN NUMBER DEFAULT NULL
    ) IS
    BEGIN
        UPDATE ph_sec_apex_pages
            SET apex_app_id = CASE WHEN p_apex_app_id IS NOT NULL THEN p_apex_app_id ELSE apex_app_id END,
                apex_page_no = CASE WHEN p_apex_page_no IS NOT NULL THEN p_apex_page_no ELSE apex_page_no END,
                apex_page_type_id = CASE WHEN p_apex_page_type_id IS NOT NULL THEN p_apex_page_type_id ELSE apex_page_type_id END,
                page_alias = CASE WHEN p_page_alias IS NOT NULL THEN UPPER(TRIM(p_page_alias)) ELSE page_alias END,
                page_name_en = CASE WHEN p_page_name_en IS NOT NULL THEN TRIM(p_page_name_en) ELSE page_name_en END,
                page_name_ar = CASE WHEN p_page_name_ar IS NOT NULL THEN TRIM(p_page_name_ar) ELSE page_name_ar END,
                object_path = CASE WHEN p_object_path IS NOT NULL THEN TRIM(p_object_path) ELSE object_path END,
                access_mode = CASE WHEN p_access_mode IS NOT NULL THEN UPPER(TRIM(p_access_mode)) ELSE access_mode END,
                is_public = CASE WHEN p_is_public IS NOT NULL THEN p_is_public ELSE is_public END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by
            WHERE apex_page_id = p_apex_page_id
                AND is_deleted = 0
                AND ((p_apex_app_id IS NOT NULL AND DECODE(apex_app_id, p_apex_app_id, 0, 1) = 1)
                OR (p_apex_page_no IS NOT NULL AND DECODE(apex_page_no, p_apex_page_no, 0, 1) = 1)
                OR (p_apex_page_type_id IS NOT NULL AND DECODE(apex_page_type_id, p_apex_page_type_id, 0, 1) = 1)
                OR (p_page_alias IS NOT NULL AND DECODE(page_alias, UPPER(TRIM(p_page_alias)), 0, 1) = 1)
                OR (p_page_name_en IS NOT NULL AND DECODE(page_name_en, TRIM(p_page_name_en), 0, 1) = 1)
                OR (p_page_name_ar IS NOT NULL AND DECODE(page_name_ar, TRIM(p_page_name_ar), 0, 1) = 1)
                OR (p_object_path IS NOT NULL AND DECODE(object_path, TRIM(p_object_path), 0, 1) = 1)
                OR (p_access_mode IS NOT NULL AND DECODE(access_mode, UPPER(TRIM(p_access_mode)), 0, 1) = 1)
                OR (p_is_public IS NOT NULL AND DECODE(is_public, p_is_public, 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

    END do_update_apex_page;

    PROCEDURE do_delete_apex_page (p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL) IS
    BEGIN
        UPDATE ph_sec_apex_page_permissions
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE apex_page_id = p_apex_page_id
                AND is_deleted = 0;

        UPDATE ph_sec_apex_pages
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE apex_page_id = p_apex_page_id
                AND is_deleted = 0;

    END do_delete_apex_page;

    PROCEDURE do_restore_apex_page (p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL) IS
    BEGIN
        UPDATE ph_sec_apex_pages
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by,
                updated_at = SYSTIMESTAMP
            WHERE apex_page_id = p_apex_page_id;

    END do_restore_apex_page;

    PROCEDURE do_update_apex_page_permission (
        p_apex_page_id            IN NUMBER,
        p_permission_id           IN NUMBER,
        p_is_an_access_permission IN NUMBER DEFAULT NULL,
        p_is_active               IN NUMBER DEFAULT NULL,
        p_updated_by              IN NUMBER DEFAULT NULL
    ) IS
    BEGIN
        UPDATE ph_sec_apex_page_permissions
            SET is_an_access_permission = CASE WHEN p_is_an_access_permission IS NOT NULL THEN p_is_an_access_permission ELSE is_an_access_permission END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by
            WHERE apex_page_id = p_apex_page_id
                AND permission_id = p_permission_id
                AND is_deleted = 0
                AND ((p_is_an_access_permission IS NOT NULL AND DECODE(is_an_access_permission, p_is_an_access_permission, 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));
    END do_update_apex_page_permission;

    PROCEDURE revoke_apex_page_permission (
        p_apex_page_id IN NUMBER,
        p_permission_id IN NUMBER,
        p_updated_by IN NUMBER DEFAULT NULL
    ) IS
    BEGIN
        UPDATE ph_sec_apex_page_permissions
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE apex_page_id = p_apex_page_id
                AND permission_id = p_permission_id
                AND is_deleted = 0;

    END revoke_apex_page_permission;

    PROCEDURE do_restore_apex_page_permission (
        p_apex_page_id IN NUMBER,
        p_permission_id IN NUMBER,
        p_updated_by IN NUMBER DEFAULT NULL
    ) IS
    BEGIN
        UPDATE ph_sec_apex_page_permissions
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by,
                updated_at = SYSTIMESTAMP
            WHERE apex_page_id = p_apex_page_id
                AND permission_id = p_permission_id;

    END do_restore_apex_page_permission;

    ----------------------------------------------------------------------
    -- Result-returning create/update/delete/restore implementations
    ----------------------------------------------------------------------
    PROCEDURE set_success(p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2, p_message IN VARCHAR2) IS
    BEGIN
        p_result_code := 'S';
        p_result_message := p_message;
    END set_success;

    PROCEDURE set_validation_error(p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2, p_message IN VARCHAR2) IS
    BEGIN
        p_result_code := 'V';
        p_result_message := p_message;
    END set_validation_error;

    PROCEDURE set_error(p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_error_code      NUMBER := SQLCODE;
        l_error_message   VARCHAR2(4000) := SQLERRM;
        l_error_stack     CLOB := DBMS_UTILITY.FORMAT_ERROR_STACK;
        l_error_backtrace CLOB := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    BEGIN
        ph_sec_error_log_pkg.log_error(
            p_program_unit => $$PLSQL_UNIT,
            p_error_location => l_error_backtrace,
            p_error_code => l_error_code,
            p_error_message => l_error_message,
            p_error_stack => l_error_stack,
            p_error_backtrace => l_error_backtrace
        );
        p_result_code := CASE WHEN l_error_code BETWEEN -20999 AND -20000 THEN 'V' ELSE 'E' END;
        p_result_message := l_error_message;
    END set_error;

    ----------------------------------------------------------------------
    -- Security Entity Management
    ----------------------------------------------------------------------
    PROCEDURE create_user_type(p_user_type_name_en IN VARCHAR2, p_user_type_name_ar IN VARCHAR2, p_user_type_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_create_user_type(p_user_type_name_en, p_user_type_name_ar, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        INSERT INTO ph_sec_user_type_lkp (user_type_name_en, user_type_name_ar, is_active, created_by)
            VALUES (TRIM(p_user_type_name_en), TRIM(p_user_type_name_ar), 1, NVL(p_created_by, 1))
            RETURNING user_type_id INTO p_user_type_id;
        set_success(p_result_code, p_result_message, 'User type created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_user_type;

    PROCEDURE update_user_type(p_user_type_id IN NUMBER, p_user_type_name_en IN VARCHAR2 DEFAULT NULL, p_user_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_user_type(p_user_type_id, p_user_type_name_en, p_user_type_name_ar, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_user_type_lkp
            SET user_type_name_en = COALESCE(TRIM(p_user_type_name_en), user_type_name_en),
                user_type_name_ar = COALESCE(TRIM(p_user_type_name_ar), user_type_name_ar),
                is_active = COALESCE(p_is_active, is_active),
                updated_by = p_updated_by
            WHERE user_type_id = p_user_type_id
                AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'User type updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_user_type;

    PROCEDURE delete_user_type(p_user_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_user_type(p_user_type_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_user_type_lkp SET is_deleted = 1, updated_by = p_updated_by WHERE user_type_id = p_user_type_id AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'User type deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_user_type;

    PROCEDURE restore_user_type(p_user_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_user_type(p_user_type_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_user_type_lkp SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP WHERE user_type_id = p_user_type_id;
        set_success(p_result_code, p_result_message, 'User type restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_user_type;

    PROCEDURE create_object_type(p_object_type_name_en IN VARCHAR2, p_object_type_name_ar IN VARCHAR2, p_object_type_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_create_object_type(p_object_type_name_en, p_object_type_name_ar, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        INSERT INTO ph_sec_object_type_lkp (object_type_name_en, object_type_name_ar, is_active, created_by)
            VALUES (TRIM(p_object_type_name_en), TRIM(p_object_type_name_ar), 1, NVL(p_created_by, 1))
            RETURNING object_type_id INTO p_object_type_id;
        set_success(p_result_code, p_result_message, 'Object type created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_object_type;

    PROCEDURE update_object_type(p_object_type_id IN NUMBER, p_object_type_name_en IN VARCHAR2 DEFAULT NULL, p_object_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_object_type(p_object_type_id, p_object_type_name_en, p_object_type_name_ar, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_object_type_lkp
            SET object_type_name_en = COALESCE(TRIM(p_object_type_name_en), object_type_name_en),
                object_type_name_ar = COALESCE(TRIM(p_object_type_name_ar), object_type_name_ar),
                is_active = COALESCE(p_is_active, is_active),
                updated_by = p_updated_by
            WHERE object_type_id = p_object_type_id
                AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Object type updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_object_type;

    PROCEDURE delete_object_type(p_object_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_object_type(p_object_type_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_object_type_lkp SET is_deleted = 1, updated_by = p_updated_by WHERE object_type_id = p_object_type_id AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Object type deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_object_type;

    PROCEDURE restore_object_type(p_object_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_object_type(p_object_type_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_object_type_lkp SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP WHERE object_type_id = p_object_type_id;
        set_success(p_result_code, p_result_message, 'Object type restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_object_type;

    PROCEDURE create_object(p_parent_object_id IN NUMBER DEFAULT NULL, p_object_name IN VARCHAR2, p_object_type_id IN NUMBER, p_object_path IN VARCHAR2, p_display_name_en IN VARCHAR2, p_display_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_object_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_create_object(p_parent_object_id, p_object_name, p_object_type_id, p_object_path, p_display_name_en, p_display_name_ar, p_description_en, p_description_ar, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        INSERT INTO ph_sec_objects (parent_object_id, object_name, object_type_id, object_path, display_name_en, display_name_ar, description_en, description_ar, is_active, created_by)
            VALUES (p_parent_object_id, UPPER(TRIM(p_object_name)), p_object_type_id, TRIM(p_object_path), TRIM(p_display_name_en), TRIM(p_display_name_ar), TRIM(p_description_en), TRIM(p_description_ar), 1, NVL(p_created_by, 1))
            RETURNING object_id INTO p_object_id;
        set_success(p_result_code, p_result_message, 'Object created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_object;

    PROCEDURE update_object(p_object_id IN NUMBER, p_parent_object_id IN NUMBER DEFAULT NULL, p_object_name IN VARCHAR2 DEFAULT NULL, p_object_type_id IN NUMBER DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_display_name_en IN VARCHAR2 DEFAULT NULL, p_display_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_object(p_object_id, p_parent_object_id, p_object_name, p_object_type_id, p_object_path, p_display_name_en, p_display_name_ar, p_description_en, p_description_ar, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_objects
            SET parent_object_id = COALESCE(p_parent_object_id, parent_object_id),
                object_name = COALESCE(UPPER(TRIM(p_object_name)), object_name),
                object_type_id = COALESCE(p_object_type_id, object_type_id),
                object_path = COALESCE(TRIM(p_object_path), object_path),
                display_name_en = COALESCE(TRIM(p_display_name_en), display_name_en),
                display_name_ar = COALESCE(TRIM(p_display_name_ar), display_name_ar),
                description_en = COALESCE(TRIM(p_description_en), description_en),
                description_ar = COALESCE(TRIM(p_description_ar), description_ar),
                is_active = COALESCE(p_is_active, is_active),
                updated_by = p_updated_by
            WHERE object_id = p_object_id
                AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Object updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_object;

    PROCEDURE delete_object(p_object_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_object(p_object_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_permissions SET is_deleted = 1, updated_by = p_updated_by WHERE object_id = p_object_id AND is_deleted = 0;
        UPDATE ph_sec_objects SET is_deleted = 1, updated_by = p_updated_by WHERE object_id = p_object_id AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Object deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_object;

    PROCEDURE restore_object(p_object_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_object(p_object_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_objects SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP WHERE object_id = p_object_id;
        set_success(p_result_code, p_result_message, 'Object restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_object;

    PROCEDURE create_action(p_action_name IN VARCHAR2, p_display_name_en IN VARCHAR2, p_display_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_action_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_create_action(p_action_name, p_display_name_en, p_display_name_ar, p_description_en, p_description_ar, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        INSERT INTO ph_sec_actions (action_name, display_name_en, display_name_ar, description_en, description_ar, is_active, created_by)
            VALUES (UPPER(TRIM(p_action_name)), TRIM(p_display_name_en), TRIM(p_display_name_ar), TRIM(p_description_en), TRIM(p_description_ar), 1, NVL(p_created_by, 1))
            RETURNING action_id INTO p_action_id;
        set_success(p_result_code, p_result_message, 'Action created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_action;

    PROCEDURE update_action(p_action_id IN NUMBER, p_action_name IN VARCHAR2 DEFAULT NULL, p_display_name_en IN VARCHAR2 DEFAULT NULL, p_display_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_action(p_action_id, p_action_name, p_display_name_en, p_display_name_ar, p_description_en, p_description_ar, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_actions
            SET action_name = COALESCE(UPPER(TRIM(p_action_name)), action_name),
                display_name_en = COALESCE(TRIM(p_display_name_en), display_name_en),
                display_name_ar = COALESCE(TRIM(p_display_name_ar), display_name_ar),
                description_en = COALESCE(TRIM(p_description_en), description_en),
                description_ar = COALESCE(TRIM(p_description_ar), description_ar),
                is_active = COALESCE(p_is_active, is_active),
                updated_by = p_updated_by
            WHERE action_id = p_action_id
                AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Action updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_action;

    PROCEDURE delete_action(p_action_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_action(p_action_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_permissions SET is_deleted = 1, updated_by = p_updated_by WHERE action_id = p_action_id AND is_deleted = 0;
        UPDATE ph_sec_actions SET is_deleted = 1, updated_by = p_updated_by WHERE action_id = p_action_id AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Action deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_action;

    PROCEDURE restore_action(p_action_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_action(p_action_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_actions SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP WHERE action_id = p_action_id;
        set_success(p_result_code, p_result_message, 'Action restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_action;

    PROCEDURE create_permission(p_object_id IN NUMBER, p_action_id IN NUMBER, p_permission_name_en IN VARCHAR2, p_permission_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_permission_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_create_permission(p_object_id, p_action_id, p_permission_name_en, p_permission_name_ar, p_description_en, p_description_ar, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        INSERT INTO ph_sec_permissions (object_id, action_id, permission_name_en, permission_name_ar, description_en, description_ar, is_active, created_by)
            VALUES (p_object_id, p_action_id, TRIM(p_permission_name_en), TRIM(p_permission_name_ar), TRIM(p_description_en), TRIM(p_description_ar), 1, NVL(p_created_by, 1))
            RETURNING permission_id INTO p_permission_id;
        set_success(p_result_code, p_result_message, 'Permission created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_permission;

    PROCEDURE update_permission(p_permission_id IN NUMBER, p_object_id IN NUMBER DEFAULT NULL, p_action_id IN NUMBER DEFAULT NULL, p_permission_name_en IN VARCHAR2 DEFAULT NULL, p_permission_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_permission(p_permission_id, p_object_id, p_action_id, p_permission_name_en, p_permission_name_ar, p_description_en, p_description_ar, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_permissions
            SET object_id = COALESCE(p_object_id, object_id),
                action_id = COALESCE(p_action_id, action_id),
                permission_name_en = COALESCE(TRIM(p_permission_name_en), permission_name_en),
                permission_name_ar = COALESCE(TRIM(p_permission_name_ar), permission_name_ar),
                description_en = COALESCE(TRIM(p_description_en), description_en),
                description_ar = COALESCE(TRIM(p_description_ar), description_ar),
                is_active = COALESCE(p_is_active, is_active),
                updated_by = p_updated_by
            WHERE permission_id = p_permission_id
                AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Permission updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_permission;

    PROCEDURE delete_permission(p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_permission(p_permission_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_role_permissions SET is_deleted = 1, updated_by = p_updated_by WHERE permission_id = p_permission_id AND is_deleted = 0;
        UPDATE ph_sec_apex_page_permissions SET is_deleted = 1, updated_by = p_updated_by WHERE permission_id = p_permission_id AND is_deleted = 0;
        UPDATE ph_sec_permissions SET is_deleted = 1, updated_by = p_updated_by WHERE permission_id = p_permission_id AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Permission deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_permission;

    PROCEDURE restore_permission(p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_permission(p_permission_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_permissions SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP WHERE permission_id = p_permission_id;
        set_success(p_result_code, p_result_message, 'Permission restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_permission;

    PROCEDURE create_user(p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_user_type IN NUMBER, p_customer_id IN NUMBER DEFAULT NULL, p_password IN VARCHAR2 DEFAULT NULL, p_must_change_password IN NUMBER DEFAULT 1, p_is_initial_admin IN NUMBER DEFAULT 0, p_user_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        p_user_id := NULL;

        ph_sec_management_validation_pkg.validate_create_user(p_email, p_display_name, p_user_type, p_customer_id, p_must_change_password, p_is_initial_admin, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        IF p_password IS NOT NULL THEN
            ph_sec_authentication_validation_pkg.validate_password(p_password, l_is_valid, l_validation_message);
            IF l_is_valid = 0 THEN
                set_validation_error(p_result_code, p_result_message, l_validation_message);
                RETURN;
            END IF;
        END IF;

        INSERT INTO ph_sec_users (customer_id, user_type, email, display_name, must_change_password, is_initial_admin, is_active, created_by)
            VALUES (p_customer_id, p_user_type, normalize_username(p_email), TRIM(p_display_name), p_must_change_password, p_is_initial_admin, 1, NVL(p_created_by, 1))
            RETURNING user_id INTO p_user_id;
        IF p_password IS NOT NULL THEN
            ph_sec_authentication_pkg.set_password(p_user_id, p_password, p_created_by);
        END IF;
        set_success(p_result_code, p_result_message, 'User created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_user;

    PROCEDURE update_user(p_user_id IN NUMBER, p_email IN VARCHAR2 DEFAULT NULL, p_display_name IN VARCHAR2 DEFAULT NULL, p_user_type IN NUMBER DEFAULT NULL, p_customer_id IN NUMBER DEFAULT NULL, p_must_change_password IN NUMBER DEFAULT NULL, p_is_initial_admin IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_user(p_user_id, p_email, p_display_name, p_user_type, p_customer_id, p_must_change_password, p_is_initial_admin, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_users
            SET customer_id = COALESCE(p_customer_id, customer_id),
                user_type = COALESCE(p_user_type, user_type),
                email = COALESCE(normalize_username(p_email), email),
                display_name = COALESCE(TRIM(p_display_name), display_name),
                must_change_password = COALESCE(p_must_change_password, must_change_password),
                is_initial_admin = COALESCE(p_is_initial_admin, is_initial_admin),
                is_active = COALESCE(p_is_active, is_active),
                updated_by = p_updated_by
            WHERE user_id = p_user_id
                AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'User updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_user;

    PROCEDURE delete_user(p_user_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_user(p_user_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_user_roles SET is_deleted = 1, updated_by = p_updated_by WHERE user_id = p_user_id AND is_deleted = 0;
        UPDATE ph_sec_user_preferences SET is_deleted = 1, updated_by = p_updated_by WHERE user_id = p_user_id AND is_deleted = 0;
        UPDATE ph_sec_users SET is_deleted = 1, is_active = 0, updated_by = p_updated_by WHERE user_id = p_user_id AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'User deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_user;

    PROCEDURE restore_user(p_user_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_user(p_user_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_users SET is_deleted = 0, is_active = 1, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP WHERE user_id = p_user_id;
        set_success(p_result_code, p_result_message, 'User restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_user;

    PROCEDURE create_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_preference_value IN VARCHAR2, p_value_type IN VARCHAR2 DEFAULT 'STRING', p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
        l_preference_code ph_sec_user_preferences.preference_code%TYPE := normalize_preference_code(p_preference_code);
        l_value_type ph_sec_user_preferences.value_type%TYPE := UPPER(TRIM(COALESCE(p_value_type, 'STRING')));
    BEGIN
        ph_sec_management_validation_pkg.validate_create_user_preference(p_user_id, p_preference_code, p_preference_value, p_value_type, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        INSERT INTO ph_sec_user_preferences (user_id, preference_code, preference_value, value_type, is_active, created_by)
            VALUES (p_user_id, l_preference_code, TRIM(p_preference_value), l_value_type, 1, NVL(p_created_by, 1));
        set_success(p_result_code, p_result_message, 'User preference created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_user_preference;

    PROCEDURE update_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_preference_value IN VARCHAR2 DEFAULT NULL, p_value_type IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
        l_preference_code ph_sec_user_preferences.preference_code%TYPE := normalize_preference_code(p_preference_code);
        l_value_type ph_sec_user_preferences.value_type%TYPE := UPPER(TRIM(p_value_type));
    BEGIN
        ph_sec_management_validation_pkg.validate_update_user_preference(p_user_id, p_preference_code, p_preference_value, p_value_type, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        UPDATE ph_sec_user_preferences
            SET preference_value = COALESCE(TRIM(p_preference_value), preference_value),
                value_type = COALESCE(l_value_type, value_type),
                is_active = COALESCE(p_is_active, is_active),
                updated_by = p_updated_by
            WHERE user_id = p_user_id
                AND preference_code = l_preference_code
                AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'User preference updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_user_preference;

    PROCEDURE delete_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_user_preference(p_user_id, p_preference_code, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_user_preferences
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE user_id = p_user_id
                AND preference_code = normalize_preference_code(p_preference_code)
                AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'User preference deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_user_preference;

    PROCEDURE restore_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_user_preference(p_user_id, p_preference_code, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_user_preferences
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by,
                updated_at = SYSTIMESTAMP
            WHERE user_id = p_user_id
                AND preference_code = normalize_preference_code(p_preference_code);
        set_success(p_result_code, p_result_message, 'User preference restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_user_preference;

    PROCEDURE create_role(p_role_name_en IN VARCHAR2, p_role_name_ar IN VARCHAR2, p_user_type IN NUMBER, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_system_role IN NUMBER DEFAULT 0, p_role_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_create_role(p_role_name_en, p_role_name_ar, p_user_type, p_description_en, p_description_ar, p_is_system_role, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        INSERT INTO ph_sec_roles (role_name_en, role_name_ar, description_en, description_ar, user_type, is_system_role, is_active, created_by)
            VALUES (TRIM(p_role_name_en), TRIM(p_role_name_ar), TRIM(p_description_en), TRIM(p_description_ar), p_user_type, p_is_system_role, 1, NVL(p_created_by, 1))
            RETURNING role_id INTO p_role_id;
        set_success(p_result_code, p_result_message, 'Role created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_role;

    PROCEDURE update_role(p_role_id IN NUMBER, p_role_name_en IN VARCHAR2 DEFAULT NULL, p_role_name_ar IN VARCHAR2 DEFAULT NULL, p_user_type IN NUMBER DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_system_role IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_role(p_role_id, p_role_name_en, p_role_name_ar, p_user_type, p_description_en, p_description_ar, p_is_system_role, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_roles
            SET role_name_en = COALESCE(TRIM(p_role_name_en), role_name_en),
                role_name_ar = COALESCE(TRIM(p_role_name_ar), role_name_ar),
                user_type = COALESCE(p_user_type, user_type),
                description_en = COALESCE(TRIM(p_description_en), description_en),
                description_ar = COALESCE(TRIM(p_description_ar), description_ar),
                is_system_role = COALESCE(p_is_system_role, is_system_role),
                is_active = COALESCE(p_is_active, is_active),
                updated_by = p_updated_by
            WHERE role_id = p_role_id
                AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Role updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_role;

    PROCEDURE delete_role(p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_role(p_role_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_role_permissions SET is_deleted = 1, updated_by = p_updated_by WHERE role_id = p_role_id AND is_deleted = 0;
        UPDATE ph_sec_user_roles SET is_deleted = 1, updated_by = p_updated_by WHERE role_id = p_role_id AND is_deleted = 0;
        UPDATE ph_sec_roles SET is_deleted = 1, is_active = 0, updated_by = p_updated_by WHERE role_id = p_role_id AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Role deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_role;

    PROCEDURE restore_role(p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_role(p_role_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_roles SET is_deleted = 0, is_active = 1, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP WHERE role_id = p_role_id;
        set_success(p_result_code, p_result_message, 'Role restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_role;

    PROCEDURE grant_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_grant_role_permission(p_role_id, p_permission_id, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        MERGE INTO ph_sec_role_permissions target
            USING (SELECT p_role_id role_id, p_permission_id permission_id FROM dual) source
            ON (target.role_id = source.role_id AND target.permission_id = source.permission_id)
            WHEN MATCHED THEN UPDATE SET target.is_deleted = 0, target.deleted_by = NULL, target.deleted_at = NULL, target.updated_by = p_created_by, target.updated_at = SYSTIMESTAMP
            WHEN NOT MATCHED THEN INSERT (role_id, permission_id, created_by) VALUES (source.role_id, source.permission_id, NVL(p_created_by, 1));
        set_success(p_result_code, p_result_message, 'Role permission granted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END grant_role_permission;

    PROCEDURE revoke_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_revoke_role_permission(p_role_id, p_permission_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_role_permissions SET is_deleted = 1, updated_by = p_updated_by WHERE role_id = p_role_id AND permission_id = p_permission_id AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'Role permission revoked successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END revoke_role_permission;

    PROCEDURE restore_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_role_permission(p_role_id, p_permission_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_role_permissions SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP WHERE role_id = p_role_id AND permission_id = p_permission_id;
        set_success(p_result_code, p_result_message, 'Role permission restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_role_permission;

    PROCEDURE assign_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_assigned_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_assign_user_role(p_user_id, p_role_id, p_assigned_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        MERGE INTO ph_sec_user_roles target
            USING (SELECT p_user_id user_id, p_role_id role_id FROM dual) source
            ON (target.user_id = source.user_id AND target.role_id = source.role_id)
            WHEN MATCHED THEN UPDATE SET target.assigned_by = p_assigned_by, target.assigned_at = SYSTIMESTAMP, target.is_deleted = 0, target.deleted_by = NULL, target.deleted_at = NULL, target.updated_by = p_assigned_by, target.updated_at = SYSTIMESTAMP
            WHEN NOT MATCHED THEN INSERT (user_id, role_id, assigned_by, created_by) VALUES (source.user_id, source.role_id, p_assigned_by, NVL(p_assigned_by, 1));
        set_success(p_result_code, p_result_message, 'User role assigned successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END assign_user_role;

    PROCEDURE revoke_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_revoke_user_role(p_user_id, p_role_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_user_roles SET is_deleted = 1, updated_by = p_updated_by WHERE user_id = p_user_id AND role_id = p_role_id AND is_deleted = 0;
        set_success(p_result_code, p_result_message, 'User role revoked successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END revoke_user_role;

    PROCEDURE restore_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_user_role(p_user_id, p_role_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        UPDATE ph_sec_user_roles SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP WHERE user_id = p_user_id AND role_id = p_role_id;
        set_success(p_result_code, p_result_message, 'User role restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_user_role;

    ----------------------------------------------------------------------
    -- APEX Security Entity Management
    ----------------------------------------------------------------------
    PROCEDURE create_apex_page_type(p_page_type_code IN VARCHAR2, p_page_type_name_en IN VARCHAR2, p_page_type_name_ar IN VARCHAR2, p_page_type_id OUT NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_create_apex_page_type(p_page_type_code, p_page_type_name_en, p_page_type_name_ar, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        INSERT INTO ph_sec_apex_page_type_lkp (
        apex_page_type_code,
        apex_page_type_name_en,
        apex_page_type_name_ar,
        is_active,
        created_by
        ) VALUES (
        UPPER(TRIM(p_page_type_code)),
        TRIM(p_page_type_name_en),
        TRIM(p_page_type_name_ar),
        1,
        NVL(p_created_by, 1)
        ) RETURNING apex_page_type_id INTO p_page_type_id;

        set_success(p_result_code, p_result_message, 'APEX page type created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_apex_page_type;

    PROCEDURE update_apex_page_type(p_page_type_id IN NUMBER, p_page_type_code IN VARCHAR2 DEFAULT NULL, p_page_type_name_en IN VARCHAR2 DEFAULT NULL, p_page_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_apex_page_type(p_page_type_id, p_page_type_code, p_page_type_name_en, p_page_type_name_ar, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        do_update_apex_page_type(p_page_type_id, p_page_type_code, p_page_type_name_en, p_page_type_name_ar, p_is_active, p_updated_by);
        set_success(p_result_code, p_result_message, 'APEX page type updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_apex_page_type;

    PROCEDURE delete_apex_page_type(p_page_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_apex_page_type(p_page_type_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        do_delete_apex_page_type(p_page_type_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'APEX page type deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_apex_page_type;

    PROCEDURE restore_apex_page_type(p_page_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_apex_page_type(p_page_type_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        do_restore_apex_page_type(p_page_type_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'APEX page type restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_apex_page_type;

    PROCEDURE create_apex_page(p_apex_app_id IN NUMBER, p_apex_page_no IN NUMBER, p_apex_page_type_id IN NUMBER, p_page_name_en IN VARCHAR2, p_page_name_ar IN VARCHAR2, p_apex_page_id OUT NUMBER, p_page_alias IN VARCHAR2 DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_access_mode IN VARCHAR2 DEFAULT 'ANY', p_is_public IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_create_apex_page(p_apex_app_id, p_apex_page_no, p_apex_page_type_id, p_page_name_en, p_page_name_ar, p_page_alias, p_object_path, p_access_mode, p_is_public, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        INSERT INTO ph_sec_apex_pages (
        apex_app_id,
        apex_page_no,
        apex_page_type_id,
        page_alias,
        page_name_en,
        page_name_ar,
        object_path,
        access_mode,
        is_public,
        is_active,
        created_by
        ) VALUES (
        p_apex_app_id,
        p_apex_page_no,
        p_apex_page_type_id,
        UPPER(TRIM(p_page_alias)),
        TRIM(p_page_name_en),
        TRIM(p_page_name_ar),
        TRIM(p_object_path),
        UPPER(TRIM(p_access_mode)),
        p_is_public,
        1,
        NVL(p_created_by, 1)
        ) RETURNING apex_page_id INTO p_apex_page_id;

        set_success(p_result_code, p_result_message, 'APEX page created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_apex_page;

    PROCEDURE update_apex_page(p_apex_page_id IN NUMBER, p_apex_app_id IN NUMBER DEFAULT NULL, p_apex_page_no IN NUMBER DEFAULT NULL, p_apex_page_type_id IN NUMBER DEFAULT NULL, p_page_name_en IN VARCHAR2 DEFAULT NULL, p_page_name_ar IN VARCHAR2 DEFAULT NULL, p_page_alias IN VARCHAR2 DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_access_mode IN VARCHAR2 DEFAULT NULL, p_is_public IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_apex_page(p_apex_page_id, p_apex_app_id, p_apex_page_no, p_apex_page_type_id, p_page_name_en, p_page_name_ar, p_page_alias, p_object_path, p_access_mode, p_is_public, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        do_update_apex_page(p_apex_page_id, p_apex_app_id, p_apex_page_no, p_apex_page_type_id, p_page_name_en, p_page_name_ar, p_page_alias, p_object_path, p_access_mode, p_is_public, p_is_active, p_updated_by);
        set_success(p_result_code, p_result_message, 'APEX page updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_apex_page;

    PROCEDURE delete_apex_page(p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_apex_page(p_apex_page_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        do_delete_apex_page(p_apex_page_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'APEX page deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_apex_page;

    PROCEDURE restore_apex_page(p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_apex_page(p_apex_page_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        do_restore_apex_page(p_apex_page_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'APEX page restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_apex_page;

    PROCEDURE create_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_is_an_access_permission IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_create_apex_page_permission(p_apex_page_id, p_permission_id, p_is_an_access_permission, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        MERGE INTO ph_sec_apex_page_permissions target
            USING (
        SELECT p_apex_page_id apex_page_id, p_permission_id permission_id FROM dual
        ) source
            ON (target.apex_page_id = source.apex_page_id AND target.permission_id = source.permission_id)
            WHEN MATCHED THEN
        UPDATE SET target.is_an_access_permission = p_is_an_access_permission,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = p_created_by,
        target.updated_at = SYSTIMESTAMP
            WHEN NOT MATCHED THEN
        INSERT (apex_page_id, permission_id, is_an_access_permission, is_active, created_by)
            VALUES (source.apex_page_id, source.permission_id, p_is_an_access_permission, 1, NVL(p_created_by, 1));

        set_success(p_result_code, p_result_message, 'APEX page permission created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_apex_page_permission;

    PROCEDURE update_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_is_an_access_permission IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_update_apex_page_permission(p_apex_page_id, p_permission_id, p_is_an_access_permission, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        do_update_apex_page_permission(p_apex_page_id, p_permission_id, p_is_an_access_permission, p_is_active, p_updated_by);
        set_success(p_result_code, p_result_message, 'APEX page permission updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_apex_page_permission;

    PROCEDURE delete_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_delete_apex_page_permission(p_apex_page_id, p_permission_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        revoke_apex_page_permission(p_apex_page_id, p_permission_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'APEX page permission deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_apex_page_permission;

    PROCEDURE restore_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_sec_management_validation_pkg.validate_restore_apex_page_permission(p_apex_page_id, p_permission_id, p_updated_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;
        do_restore_apex_page_permission(p_apex_page_id, p_permission_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'APEX page permission restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_apex_page_permission;
END ph_sec_management_pkg;
/

