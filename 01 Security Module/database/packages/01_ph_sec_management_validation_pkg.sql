/*
ProductHub Manager - Security Management Validation Package
Target DBMS: Oracle Database 21c+

Purpose:
- Validation service layer for ph_sec_management_pkg actions.
- Each procedure returns o_is_valid as 1 or 0 and o_validation_message.
*/

CREATE OR REPLACE PACKAGE ph_sec_management_validation_pkg AS
    PROCEDURE validate_create_user_type(p_user_type_name_en IN VARCHAR2, p_user_type_name_ar IN VARCHAR2, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_user_type(p_user_type_id IN NUMBER, p_user_type_name_en IN VARCHAR2 DEFAULT NULL, p_user_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_user_type(p_user_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_user_type(p_user_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_object_type(p_object_type_name_en IN VARCHAR2, p_object_type_name_ar IN VARCHAR2, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_object_type(p_object_type_id IN NUMBER, p_object_type_name_en IN VARCHAR2 DEFAULT NULL, p_object_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_object_type(p_object_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_object_type(p_object_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_object(p_parent_object_id IN NUMBER DEFAULT NULL, p_object_name IN VARCHAR2, p_object_type_id IN NUMBER, p_object_path IN VARCHAR2, p_display_name_en IN VARCHAR2, p_display_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_object(p_object_id IN NUMBER, p_parent_object_id IN NUMBER DEFAULT NULL, p_object_name IN VARCHAR2 DEFAULT NULL, p_object_type_id IN NUMBER DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_display_name_en IN VARCHAR2 DEFAULT NULL, p_display_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_object(p_object_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_object(p_object_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_action(p_action_name IN VARCHAR2, p_display_name_en IN VARCHAR2, p_display_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_action(p_action_id IN NUMBER, p_action_name IN VARCHAR2 DEFAULT NULL, p_display_name_en IN VARCHAR2 DEFAULT NULL, p_display_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_action(p_action_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_action(p_action_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_permission(p_object_id IN NUMBER, p_action_id IN NUMBER, p_permission_name_en IN VARCHAR2, p_permission_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_permission(p_permission_id IN NUMBER, p_object_id IN NUMBER DEFAULT NULL, p_action_id IN NUMBER DEFAULT NULL, p_permission_name_en IN VARCHAR2 DEFAULT NULL, p_permission_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_permission(p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_permission(p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_user(p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_user_type IN NUMBER, p_customer_id IN NUMBER DEFAULT NULL, p_must_change_password IN NUMBER DEFAULT 1, p_is_initial_admin IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_user(p_user_id IN NUMBER, p_email IN VARCHAR2 DEFAULT NULL, p_display_name IN VARCHAR2 DEFAULT NULL, p_user_type IN NUMBER DEFAULT NULL, p_customer_id IN NUMBER DEFAULT NULL, p_must_change_password IN NUMBER DEFAULT NULL, p_is_initial_admin IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_user(p_user_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_user(p_user_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_preference_value IN VARCHAR2, p_value_type IN VARCHAR2 DEFAULT 'STRING', p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_preference_value IN VARCHAR2 DEFAULT NULL, p_value_type IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_role(p_role_name_en IN VARCHAR2, p_role_name_ar IN VARCHAR2, p_user_type IN NUMBER, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_system_role IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_role(p_role_id IN NUMBER, p_role_name_en IN VARCHAR2 DEFAULT NULL, p_role_name_ar IN VARCHAR2 DEFAULT NULL, p_user_type IN NUMBER DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_system_role IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_role(p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_role(p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_grant_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_revoke_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_assign_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_assigned_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_revoke_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_apex_page_type(p_page_type_code IN VARCHAR2, p_page_type_name_en IN VARCHAR2, p_page_type_name_ar IN VARCHAR2, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_apex_page_type(p_page_type_id IN NUMBER, p_page_type_code IN VARCHAR2 DEFAULT NULL, p_page_type_name_en IN VARCHAR2 DEFAULT NULL, p_page_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_apex_page_type(p_page_type_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_apex_page_type(p_page_type_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_apex_page(p_apex_app_id IN NUMBER, p_apex_page_no IN NUMBER, p_apex_page_type_id IN NUMBER, p_page_name_en IN VARCHAR2, p_page_name_ar IN VARCHAR2, p_page_alias IN VARCHAR2 DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_access_mode IN VARCHAR2 DEFAULT 'ANY', p_is_public IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_apex_page(p_apex_page_id IN NUMBER, p_apex_app_id IN NUMBER DEFAULT NULL, p_apex_page_no IN NUMBER DEFAULT NULL, p_apex_page_type_id IN NUMBER DEFAULT NULL, p_page_name_en IN VARCHAR2 DEFAULT NULL, p_page_name_ar IN VARCHAR2 DEFAULT NULL, p_page_alias IN VARCHAR2 DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_access_mode IN VARCHAR2 DEFAULT NULL, p_is_public IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_apex_page(p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_apex_page(p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_is_an_access_permission IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_is_an_access_permission IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
END ph_sec_management_validation_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_sec_management_validation_pkg AS
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

    FUNCTION yes_no(p_count IN NUMBER) RETURN NUMBER IS
    BEGIN
        IF p_count > 0 THEN
            RETURN 1;
        END IF;
        RETURN 0;
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

    FUNCTION valid_access_mode(p_access_mode IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN p_access_mode IS NULL OR UPPER(TRIM(p_access_mode)) IN ('ANY', 'ALL');
    END valid_access_mode;

    FUNCTION valid_value_type(p_value_type IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN p_value_type IS NULL OR UPPER(TRIM(p_value_type)) IN ('STRING', 'NUMBER', 'BOOLEAN', 'JSON');
    END valid_value_type;

    FUNCTION exists_user_type(p_user_type_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count FROM ph_sec_user_type_lkp
            WHERE user_type_id = p_user_type_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_user_type;

    FUNCTION exists_object_type(p_object_type_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count FROM ph_sec_object_type_lkp
            WHERE object_type_id = p_object_type_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_object_type;

    FUNCTION exists_object(p_object_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count FROM ph_sec_objects
            WHERE object_id = p_object_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_object;

    FUNCTION exists_action(p_action_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count FROM ph_sec_actions
            WHERE action_id = p_action_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_action;

    FUNCTION exists_user(p_user_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count FROM ph_sec_users
            WHERE user_id = p_user_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_user;

    FUNCTION exists_customer(p_customer_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        IF p_customer_id IS NULL THEN
            RETURN 1;
        END IF;

        SELECT COUNT(*) INTO l_count FROM ph_erp_customers
            WHERE customer_id = p_customer_id
                AND is_deleted = 0
                AND is_active = 1;
        RETURN yes_no(l_count);
    END exists_customer;

    FUNCTION exists_role(p_role_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count FROM ph_sec_roles
            WHERE role_id = p_role_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_role;

    FUNCTION exists_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count FROM ph_sec_user_preferences
            WHERE user_id = p_user_id
                AND preference_code = UPPER(TRIM(p_preference_code))
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN yes_no(l_count);
    END exists_user_preference;

    FUNCTION exists_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count FROM ph_sec_role_permissions
            WHERE role_id = p_role_id
                AND permission_id = p_permission_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN yes_no(l_count);
    END exists_role_permission;

    FUNCTION exists_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count FROM ph_sec_user_roles
            WHERE user_id = p_user_id
                AND role_id = p_role_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN yes_no(l_count);
    END exists_user_role;

    FUNCTION exists_apex_page_type(p_page_type_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_sec_apex_page_type_lkp
            WHERE apex_page_type_id = p_page_type_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_apex_page_type;

    FUNCTION exists_apex_page(p_apex_page_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_sec_apex_pages
            WHERE apex_page_id = p_apex_page_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_apex_page;

    FUNCTION exists_permission(p_permission_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_sec_permissions
            WHERE permission_id = p_permission_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_permission;

    FUNCTION exists_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_sec_apex_page_permissions
            WHERE apex_page_id = p_apex_page_id
                AND permission_id = p_permission_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN yes_no(l_count);
    END exists_apex_page_permission;

    FUNCTION duplicate_apex_page_type_code(p_page_type_code IN VARCHAR2, p_page_type_id IN NUMBER DEFAULT NULL) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_sec_apex_page_type_lkp
            WHERE is_deleted = 0
                AND (p_page_type_id IS NULL OR apex_page_type_id <> p_page_type_id)
                AND UPPER(apex_page_type_code) = UPPER(TRIM(p_page_type_code));
        RETURN yes_no(l_count);
    END duplicate_apex_page_type_code;

    FUNCTION duplicate_apex_page_no(p_apex_app_id IN NUMBER, p_apex_page_no IN NUMBER, p_apex_page_id IN NUMBER DEFAULT NULL) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_sec_apex_pages
            WHERE is_deleted = 0
                AND (p_apex_page_id IS NULL OR apex_page_id <> p_apex_page_id)
                AND apex_app_id = p_apex_app_id
                AND apex_page_no = p_apex_page_no;
        RETURN yes_no(l_count);
    END duplicate_apex_page_no;

    FUNCTION duplicate_apex_page_alias(p_apex_app_id IN NUMBER, p_page_alias IN VARCHAR2, p_apex_page_id IN NUMBER DEFAULT NULL) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        IF TRIM(p_page_alias) IS NULL THEN
            RETURN 0;
        END IF;

        SELECT COUNT(*)
            INTO l_count
            FROM ph_sec_apex_pages
            WHERE is_deleted = 0
                AND (p_apex_page_id IS NULL OR apex_page_id <> p_apex_page_id)
                AND apex_app_id = p_apex_app_id
                AND UPPER(page_alias) = UPPER(TRIM(p_page_alias));
        RETURN yes_no(l_count);
    END duplicate_apex_page_alias;

    PROCEDURE validate_name_pair(
        p_name_en            IN VARCHAR2,
        p_name_ar            IN VARCHAR2,
        p_label              IN VARCHAR2,
        p_max_length         IN NUMBER,
        o_is_valid           OUT NUMBER,
        o_validation_message OUT VARCHAR2
    ) IS
    BEGIN
        IF text_missing(p_name_en) THEN
            set_invalid(o_is_valid, o_validation_message, p_label || ' English name is required.');
        ELSIF text_missing(p_name_ar) THEN
            set_invalid(o_is_valid, o_validation_message, p_label || ' Arabic name is required.');
        ELSIF text_too_long(p_name_en, p_max_length) THEN
            set_invalid(o_is_valid, o_validation_message, p_label || ' English name must not exceed ' || p_max_length || ' characters.');
        ELSIF text_too_long(p_name_ar, p_max_length) THEN
            set_invalid(o_is_valid, o_validation_message, p_label || ' Arabic name must not exceed ' || p_max_length || ' characters.');
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_name_pair;

    PROCEDURE validate_create_user_type(p_user_type_name_en IN VARCHAR2, p_user_type_name_ar IN VARCHAR2, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        validate_name_pair(p_user_type_name_en, p_user_type_name_ar, 'User type', 100, o_is_valid, o_validation_message);
    END validate_create_user_type;

    PROCEDURE validate_update_user_type(p_user_type_id IN NUMBER, p_user_type_name_en IN VARCHAR2 DEFAULT NULL, p_user_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user_type(p_user_type_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User type was not found.');
        ELSIF NOT valid_flag(p_is_active) THEN set_invalid(o_is_valid, o_validation_message, 'User type active flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_update_user_type;

    PROCEDURE validate_delete_user_type(p_user_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user_type(p_user_type_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User type was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_user_type;

    PROCEDURE validate_restore_user_type(p_user_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user_type(p_user_type_id, 0, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User type was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_user_type;

    PROCEDURE validate_create_object_type(p_object_type_name_en IN VARCHAR2, p_object_type_name_ar IN VARCHAR2, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        validate_name_pair(p_object_type_name_en, p_object_type_name_ar, 'Object type', 100, o_is_valid, o_validation_message);
    END validate_create_object_type;

    PROCEDURE validate_update_object_type(p_object_type_id IN NUMBER, p_object_type_name_en IN VARCHAR2 DEFAULT NULL, p_object_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_object_type(p_object_type_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Object type was not found.');
        ELSIF NOT valid_flag(p_is_active) THEN set_invalid(o_is_valid, o_validation_message, 'Object type active flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_update_object_type;

    PROCEDURE validate_delete_object_type(p_object_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_object_type(p_object_type_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Object type was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_object_type;

    PROCEDURE validate_restore_object_type(p_object_type_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_object_type(p_object_type_id, 0, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Object type was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_object_type;

    PROCEDURE validate_create_object(p_parent_object_id IN NUMBER DEFAULT NULL, p_object_name IN VARCHAR2, p_object_type_id IN NUMBER, p_object_path IN VARCHAR2, p_display_name_en IN VARCHAR2, p_display_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF text_missing(p_object_name) THEN set_invalid(o_is_valid, o_validation_message, 'Object name is required.');
        ELSIF exists_object_type(p_object_type_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active object type was not found.');
        ELSIF p_parent_object_id IS NOT NULL AND exists_object(p_parent_object_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active parent object was not found.');
        ELSIF text_missing(p_object_path) THEN set_invalid(o_is_valid, o_validation_message, 'Object path is required.');
        ELSE validate_name_pair(p_display_name_en, p_display_name_ar, 'Object display', 200, o_is_valid, o_validation_message); END IF;
    END validate_create_object;

    PROCEDURE validate_update_object(p_object_id IN NUMBER, p_parent_object_id IN NUMBER DEFAULT NULL, p_object_name IN VARCHAR2 DEFAULT NULL, p_object_type_id IN NUMBER DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_display_name_en IN VARCHAR2 DEFAULT NULL, p_display_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_object(p_object_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Object was not found.');
        ELSIF p_parent_object_id IS NOT NULL AND (p_parent_object_id = p_object_id OR exists_object(p_parent_object_id, 1) = 0) THEN set_invalid(o_is_valid, o_validation_message, 'Active parent object was not found or is invalid.');
        ELSIF p_object_type_id IS NOT NULL AND exists_object_type(p_object_type_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active object type was not found.');
        ELSIF NOT valid_flag(p_is_active) THEN set_invalid(o_is_valid, o_validation_message, 'Object active flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_update_object;

    PROCEDURE validate_delete_object(p_object_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_object(p_object_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Object was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_object;

    PROCEDURE validate_restore_object(p_object_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_object(p_object_id, 0, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Object was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_object;

    PROCEDURE validate_create_action(p_action_name IN VARCHAR2, p_display_name_en IN VARCHAR2, p_display_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF text_missing(p_action_name) THEN set_invalid(o_is_valid, o_validation_message, 'Action name is required.');
        ELSE validate_name_pair(p_display_name_en, p_display_name_ar, 'Action display', 100, o_is_valid, o_validation_message); END IF;
    END validate_create_action;

    PROCEDURE validate_update_action(p_action_id IN NUMBER, p_action_name IN VARCHAR2 DEFAULT NULL, p_display_name_en IN VARCHAR2 DEFAULT NULL, p_display_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_action(p_action_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Action was not found.');
        ELSIF NOT valid_flag(p_is_active) THEN set_invalid(o_is_valid, o_validation_message, 'Action active flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_update_action;

    PROCEDURE validate_delete_action(p_action_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_action(p_action_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Action was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_action;

    PROCEDURE validate_restore_action(p_action_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_action(p_action_id, 0, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Action was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_action;

    PROCEDURE validate_create_permission(p_object_id IN NUMBER, p_action_id IN NUMBER, p_permission_name_en IN VARCHAR2, p_permission_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_object(p_object_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active object was not found.');
        ELSIF exists_action(p_action_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active action was not found.');
        ELSE validate_name_pair(p_permission_name_en, p_permission_name_ar, 'Permission', 200, o_is_valid, o_validation_message); END IF;
    END validate_create_permission;

    PROCEDURE validate_update_permission(p_permission_id IN NUMBER, p_object_id IN NUMBER DEFAULT NULL, p_action_id IN NUMBER DEFAULT NULL, p_permission_name_en IN VARCHAR2 DEFAULT NULL, p_permission_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_permission(p_permission_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Permission was not found.');
        ELSIF p_object_id IS NOT NULL AND exists_object(p_object_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active object was not found.');
        ELSIF p_action_id IS NOT NULL AND exists_action(p_action_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active action was not found.');
        ELSIF NOT valid_flag(p_is_active) THEN set_invalid(o_is_valid, o_validation_message, 'Permission active flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_update_permission;

    PROCEDURE validate_delete_permission(p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_permission(p_permission_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Permission was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_permission;

    PROCEDURE validate_restore_permission(p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_permission(p_permission_id, 0, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Permission was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_permission;

    PROCEDURE validate_create_user(p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_user_type IN NUMBER, p_customer_id IN NUMBER DEFAULT NULL, p_must_change_password IN NUMBER DEFAULT 1, p_is_initial_admin IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF text_missing(p_email) THEN set_invalid(o_is_valid, o_validation_message, 'User email is required.');
        ELSIF text_missing(p_display_name) THEN set_invalid(o_is_valid, o_validation_message, 'User display name is required.');
        ELSIF exists_user_type(p_user_type, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active user type was not found.');
        ELSIF exists_customer(p_customer_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active customer was not found.');
        ELSIF NOT valid_flag(p_must_change_password) THEN set_invalid(o_is_valid, o_validation_message, 'Must change password flag must be 0 or 1.');
        ELSIF NOT valid_flag(p_is_initial_admin) THEN set_invalid(o_is_valid, o_validation_message, 'Initial admin flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_create_user;

    PROCEDURE validate_update_user(p_user_id IN NUMBER, p_email IN VARCHAR2 DEFAULT NULL, p_display_name IN VARCHAR2 DEFAULT NULL, p_user_type IN NUMBER DEFAULT NULL, p_customer_id IN NUMBER DEFAULT NULL, p_must_change_password IN NUMBER DEFAULT NULL, p_is_initial_admin IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user(p_user_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User was not found.');
        ELSIF p_user_type IS NOT NULL AND exists_user_type(p_user_type, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active user type was not found.');
        ELSIF exists_customer(p_customer_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active customer was not found.');
        ELSIF NOT valid_flag(p_must_change_password) THEN set_invalid(o_is_valid, o_validation_message, 'Must change password flag must be 0 or 1.');
        ELSIF NOT valid_flag(p_is_initial_admin) THEN set_invalid(o_is_valid, o_validation_message, 'Initial admin flag must be 0 or 1.');
        ELSIF NOT valid_flag(p_is_active) THEN set_invalid(o_is_valid, o_validation_message, 'User active flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_update_user;

    PROCEDURE validate_delete_user(p_user_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user(p_user_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_user;

    PROCEDURE validate_restore_user(p_user_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user(p_user_id, 0, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_user;

    PROCEDURE validate_create_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_preference_value IN VARCHAR2, p_value_type IN VARCHAR2 DEFAULT 'STRING', p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user(p_user_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active user was not found.');
        ELSIF text_missing(p_preference_code) THEN set_invalid(o_is_valid, o_validation_message, 'Preference code is required.');
        ELSIF NOT valid_value_type(COALESCE(p_value_type, 'STRING')) THEN set_invalid(o_is_valid, o_validation_message, 'Preference value type must be STRING, NUMBER, BOOLEAN, or JSON.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_create_user_preference;

    PROCEDURE validate_update_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_preference_value IN VARCHAR2 DEFAULT NULL, p_value_type IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user_preference(p_user_id, p_preference_code) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User preference was not found.');
        ELSIF NOT valid_value_type(p_value_type) THEN set_invalid(o_is_valid, o_validation_message, 'Preference value type must be STRING, NUMBER, BOOLEAN, or JSON.');
        ELSIF NOT valid_flag(p_is_active) THEN set_invalid(o_is_valid, o_validation_message, 'User preference active flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_update_user_preference;

    PROCEDURE validate_delete_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user_preference(p_user_id, p_preference_code) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User preference was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_user_preference;

    PROCEDURE validate_restore_user_preference(p_user_id IN NUMBER, p_preference_code IN VARCHAR2, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user_preference(p_user_id, p_preference_code, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User preference was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_user_preference;

    PROCEDURE validate_create_role(p_role_name_en IN VARCHAR2, p_role_name_ar IN VARCHAR2, p_user_type IN NUMBER, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_system_role IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        validate_name_pair(p_role_name_en, p_role_name_ar, 'Role', 100, o_is_valid, o_validation_message);
        IF o_is_valid = 0 THEN
            RETURN;
        END IF;
        IF exists_user_type(p_user_type, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active user type was not found.');
        ELSIF NOT valid_flag(p_is_system_role) THEN set_invalid(o_is_valid, o_validation_message, 'System role flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_create_role;

    PROCEDURE validate_update_role(p_role_id IN NUMBER, p_role_name_en IN VARCHAR2 DEFAULT NULL, p_role_name_ar IN VARCHAR2 DEFAULT NULL, p_user_type IN NUMBER DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_system_role IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_role(p_role_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Role was not found.');
        ELSIF p_user_type IS NOT NULL AND exists_user_type(p_user_type, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active user type was not found.');
        ELSIF NOT valid_flag(p_is_system_role) THEN set_invalid(o_is_valid, o_validation_message, 'System role flag must be 0 or 1.');
        ELSIF NOT valid_flag(p_is_active) THEN set_invalid(o_is_valid, o_validation_message, 'Role active flag must be 0 or 1.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_update_role;

    PROCEDURE validate_delete_role(p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_role(p_role_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Role was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_role;

    PROCEDURE validate_restore_role(p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_role(p_role_id, 0, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Role was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_role;

    PROCEDURE validate_grant_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_role(p_role_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active role was not found.');
        ELSIF exists_permission(p_permission_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active permission was not found.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_grant_role_permission;

    PROCEDURE validate_revoke_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_role_permission(p_role_id, p_permission_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Role permission was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_revoke_role_permission;

    PROCEDURE validate_restore_role_permission(p_role_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_role_permission(p_role_id, p_permission_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Role permission was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_role_permission;

    PROCEDURE validate_assign_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_assigned_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_assigned_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user(p_user_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active user was not found.');
        ELSIF exists_role(p_role_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'Active role was not found.');
        ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_assign_user_role;

    PROCEDURE validate_revoke_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user_role(p_user_id, p_role_id) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User role was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_revoke_user_role;

    PROCEDURE validate_restore_user_role(p_user_id IN NUMBER, p_role_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_user_role(p_user_id, p_role_id, 1) = 0 THEN set_invalid(o_is_valid, o_validation_message, 'User role was not found.'); ELSE set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_user_role;

    PROCEDURE validate_create_apex_page_type(p_page_type_code IN VARCHAR2, p_page_type_name_en IN VARCHAR2, p_page_type_name_ar IN VARCHAR2, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF text_missing(p_page_type_code) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type code is required.');
        ELSIF text_too_long(p_page_type_code, 50) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type code must not exceed 50 characters.');
        ELSIF duplicate_apex_page_type_code(p_page_type_code) = 1 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type code already exists.');
        ELSE
            validate_name_pair(p_page_type_name_en, p_page_type_name_ar, 'APEX page type', 100, o_is_valid, o_validation_message);
        END IF;
    END validate_create_apex_page_type;

    PROCEDURE validate_update_apex_page_type(p_page_type_id IN NUMBER, p_page_type_code IN VARCHAR2 DEFAULT NULL, p_page_type_name_en IN VARCHAR2 DEFAULT NULL, p_page_type_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page_type(p_page_type_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('APEX_PAGE_TYPE_NOT_FOUND'));
        ELSIF p_page_type_code IS NOT NULL AND text_missing(p_page_type_code) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type code is required.');
        ELSIF text_too_long(p_page_type_code, 50) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type code must not exceed 50 characters.');
        ELSIF duplicate_apex_page_type_code(p_page_type_code, p_page_type_id) = 1 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type code already exists.');
        ELSIF p_page_type_name_en IS NOT NULL AND text_missing(p_page_type_name_en) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type English name is required.');
        ELSIF p_page_type_name_ar IS NOT NULL AND text_missing(p_page_type_name_ar) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type Arabic name is required.');
        ELSIF text_too_long(p_page_type_name_en, 100) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type English name must not exceed 100 characters.');
        ELSIF text_too_long(p_page_type_name_ar, 100) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type Arabic name must not exceed 100 characters.');
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type active flag must be 0 or 1.');
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_update_apex_page_type;

    PROCEDURE validate_delete_apex_page_type(p_page_type_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page_type(p_page_type_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('APEX_PAGE_TYPE_NOT_FOUND'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_apex_page_type;

    PROCEDURE validate_restore_apex_page_type(p_page_type_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page_type(p_page_type_id, 0, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('APEX_PAGE_TYPE_NOT_FOUND'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_apex_page_type;

    PROCEDURE validate_create_apex_page(p_apex_app_id IN NUMBER, p_apex_page_no IN NUMBER, p_apex_page_type_id IN NUMBER, p_page_name_en IN VARCHAR2, p_page_name_ar IN VARCHAR2, p_page_alias IN VARCHAR2 DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_access_mode IN VARCHAR2 DEFAULT 'ANY', p_is_public IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF p_apex_app_id IS NULL OR p_apex_app_id <= 0 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX app id must be greater than zero.');
        ELSIF p_apex_page_no IS NULL OR p_apex_page_no < 0 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page number must be greater than or equal to zero.');
        ELSIF exists_apex_page_type(p_apex_page_type_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type is not active or was not found.');
        ELSIF text_too_long(p_page_alias, 128) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page alias must not exceed 128 characters.');
        ELSIF text_too_long(p_object_path, 300) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page object path must not exceed 300 characters.');
        ELSIF NOT valid_access_mode(p_access_mode) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page access mode must be ANY or ALL.');
        ELSIF NOT valid_flag(p_is_public) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page public flag must be 0 or 1.');
        ELSIF duplicate_apex_page_no(p_apex_app_id, p_apex_page_no) = 1 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX app page number already exists.');
        ELSIF duplicate_apex_page_alias(p_apex_app_id, p_page_alias) = 1 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page alias already exists for this app.');
        ELSE
            validate_name_pair(p_page_name_en, p_page_name_ar, 'APEX page', 200, o_is_valid, o_validation_message);
        END IF;
    END validate_create_apex_page;

    PROCEDURE validate_update_apex_page(p_apex_page_id IN NUMBER, p_apex_app_id IN NUMBER DEFAULT NULL, p_apex_page_no IN NUMBER DEFAULT NULL, p_apex_page_type_id IN NUMBER DEFAULT NULL, p_page_name_en IN VARCHAR2 DEFAULT NULL, p_page_name_ar IN VARCHAR2 DEFAULT NULL, p_page_alias IN VARCHAR2 DEFAULT NULL, p_object_path IN VARCHAR2 DEFAULT NULL, p_access_mode IN VARCHAR2 DEFAULT NULL, p_is_public IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
        l_apex_app_id  ph_sec_apex_pages.apex_app_id%TYPE;
        l_apex_page_no ph_sec_apex_pages.apex_page_no%TYPE;
        l_page_alias   ph_sec_apex_pages.page_alias%TYPE;
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page(p_apex_page_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('APEX_PAGE_NOT_FOUND'));
            RETURN;
        END IF;

        SELECT apex_app_id,
        apex_page_no,
        page_alias
            INTO l_apex_app_id,
        l_apex_page_no,
        l_page_alias
            FROM ph_sec_apex_pages
            WHERE apex_page_id = p_apex_page_id;

        l_apex_app_id := NVL(p_apex_app_id, l_apex_app_id);
        l_apex_page_no := NVL(p_apex_page_no, l_apex_page_no);
        l_page_alias := CASE WHEN p_page_alias IS NOT NULL THEN p_page_alias ELSE l_page_alias END;

        IF p_apex_app_id IS NOT NULL AND p_apex_app_id <= 0 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX app id must be greater than zero.');
        ELSIF p_apex_page_no IS NOT NULL AND p_apex_page_no < 0 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page number must be greater than or equal to zero.');
        ELSIF p_apex_page_type_id IS NOT NULL AND exists_apex_page_type(p_apex_page_type_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page type is not active or was not found.');
        ELSIF p_page_name_en IS NOT NULL AND text_missing(p_page_name_en) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page English name is required.');
        ELSIF p_page_name_ar IS NOT NULL AND text_missing(p_page_name_ar) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page Arabic name is required.');
        ELSIF text_too_long(p_page_name_en, 200) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page English name must not exceed 200 characters.');
        ELSIF text_too_long(p_page_name_ar, 200) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page Arabic name must not exceed 200 characters.');
        ELSIF text_too_long(p_page_alias, 128) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page alias must not exceed 128 characters.');
        ELSIF text_too_long(p_object_path, 300) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page object path must not exceed 300 characters.');
        ELSIF NOT valid_access_mode(p_access_mode) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page access mode must be ANY or ALL.');
        ELSIF NOT valid_flag(p_is_public) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page public flag must be 0 or 1.');
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page active flag must be 0 or 1.');
        ELSIF duplicate_apex_page_no(l_apex_app_id, l_apex_page_no, p_apex_page_id) = 1 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX app page number already exists.');
        ELSIF duplicate_apex_page_alias(l_apex_app_id, l_page_alias, p_apex_page_id) = 1 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page alias already exists for this app.');
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_update_apex_page;

    PROCEDURE validate_delete_apex_page(p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page(p_apex_page_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('APEX_PAGE_NOT_FOUND'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_apex_page;

    PROCEDURE validate_restore_apex_page(p_apex_page_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page(p_apex_page_id, 0, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('APEX_PAGE_NOT_FOUND'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_apex_page;

    PROCEDURE validate_create_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_is_an_access_permission IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page(p_apex_page_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page is not active or was not found.');
        ELSIF exists_permission(p_permission_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, 'Permission is not active or was not found.');
        ELSIF NOT valid_flag(p_is_an_access_permission) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page access permission flag must be 0 or 1.');
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_create_apex_page_permission;

    PROCEDURE validate_update_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_is_an_access_permission IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page_permission(p_apex_page_id, p_permission_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('APEX_PAGE_PERMISSION_NOT_FOUND'));
        ELSIF NOT valid_flag(p_is_an_access_permission) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page access permission flag must be 0 or 1.');
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, 'APEX page permission active flag must be 0 or 1.');
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_update_apex_page_permission;

    PROCEDURE validate_delete_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page_permission(p_apex_page_id, p_permission_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('APEX_PAGE_PERMISSION_NOT_FOUND'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_apex_page_permission;

    PROCEDURE validate_restore_apex_page_permission(p_apex_page_id IN NUMBER, p_permission_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'SECURITY_ADMIN', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_apex_page_permission(p_apex_page_id, p_permission_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_message('APEX_PAGE_PERMISSION_NOT_FOUND'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_apex_page_permission;
END ph_sec_management_validation_pkg;
/


