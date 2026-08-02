/*
ProductHub Manager - Security LOV Package
Target DBMS: Oracle Database 21c+

Purpose:
- Security entity LOV functions.
- Global lookup LOVs live in ph_globalization_lov_pkg.
*/

CREATE OR REPLACE PACKAGE ph_sec_lov_pkg AS
    FUNCTION user_types(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION user_type_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION object_types(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION object_type_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION security_objects(p_parent_object_id IN NUMBER DEFAULT NULL, p_object_type_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION security_object_display_value(p_return_value IN VARCHAR2, p_parent_object_id IN NUMBER DEFAULT NULL, p_object_type_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION actions(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION action_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION permissions(p_object_id IN NUMBER DEFAULT NULL, p_action_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION permission_display_value(p_return_value IN VARCHAR2, p_object_id IN NUMBER DEFAULT NULL, p_action_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION apex_page_types(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION apex_page_type_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION apex_pages(p_apex_app_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION apex_page_display_value(p_return_value IN VARCHAR2, p_apex_app_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION roles(p_user_type IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION role_display_value(p_return_value IN VARCHAR2, p_user_type IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION role_permissions(p_role_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION role_permission_display_value(p_return_value IN VARCHAR2, p_role_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;
    FUNCTION user_roles(p_user_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION user_role_display_value(p_return_value IN VARCHAR2, p_user_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;
    FUNCTION apex_page_permissions(p_apex_page_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_access_only IN NUMBER DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION apex_page_permission_display_value(p_return_value IN VARCHAR2, p_apex_page_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_access_only IN NUMBER DEFAULT NULL) RETURN VARCHAR2;
END ph_sec_lov_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_sec_lov_pkg AS
    FUNCTION localized_name(p_text_en IN VARCHAR2, p_text_ar IN VARCHAR2, p_language IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_localization_pkg.localized_text(p_text_en, p_text_ar, p_language);
    END localized_name;

    FUNCTION user_types(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(user_type_name_en, user_type_name_ar, p_language) AS display_value,
                   TO_CHAR(user_type_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY user_type_name_en, user_type_id) AS display_order
              FROM ph_sec_user_type_lkp
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY user_type_name_en, user_type_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END user_types;

    FUNCTION user_type_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.user_types(p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END user_type_display_value;

    FUNCTION object_types(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(object_type_name_en, object_type_name_ar, p_language) AS display_value,
                   TO_CHAR(object_type_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY object_type_name_en, object_type_id) AS display_order
              FROM ph_sec_object_type_lkp
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY object_type_name_en, object_type_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END object_types;

    FUNCTION object_type_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.object_types(p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END object_type_display_value;

    FUNCTION security_objects(p_parent_object_id IN NUMBER DEFAULT NULL, p_object_type_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(display_name_en, display_name_ar, p_language) AS display_value,
                   TO_CHAR(object_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY display_name_en, object_name, object_id) AS display_order
              FROM ph_sec_objects
             WHERE is_deleted = 0
               AND (p_parent_object_id IS NULL OR parent_object_id = p_parent_object_id)
               AND (p_object_type_id IS NULL OR object_type_id = p_object_type_id)
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY display_name_en, object_name, object_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END security_objects;

    FUNCTION security_object_display_value(p_return_value IN VARCHAR2, p_parent_object_id IN NUMBER DEFAULT NULL, p_object_type_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.security_objects(p_parent_object_id => p_parent_object_id, p_object_type_id => p_object_type_id, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END security_object_display_value;

    FUNCTION actions(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(display_name_en, display_name_ar, p_language) AS display_value,
                   TO_CHAR(action_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY display_name_en, action_name, action_id) AS display_order
              FROM ph_sec_actions
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY display_name_en, action_name, action_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END actions;

    FUNCTION action_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.actions(p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END action_display_value;

    FUNCTION permissions(p_object_id IN NUMBER DEFAULT NULL, p_action_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(permission_name_en, permission_name_ar, p_language) AS display_value,
                   TO_CHAR(permission_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY permission_name_en, permission_id) AS display_order
              FROM ph_sec_permissions
             WHERE is_deleted = 0
               AND (p_object_id IS NULL OR object_id = p_object_id)
               AND (p_action_id IS NULL OR action_id = p_action_id)
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY permission_name_en, permission_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END permissions;

    FUNCTION permission_display_value(p_return_value IN VARCHAR2, p_object_id IN NUMBER DEFAULT NULL, p_action_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.permissions(p_object_id => p_object_id, p_action_id => p_action_id, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END permission_display_value;

    FUNCTION apex_page_types(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(apex_page_type_name_en, apex_page_type_name_ar, p_language) AS display_value,
                   TO_CHAR(apex_page_type_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY apex_page_type_name_en, apex_page_type_id) AS display_order
              FROM ph_sec_apex_page_type_lkp
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY apex_page_type_name_en, apex_page_type_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END apex_page_types;

    FUNCTION apex_page_type_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.apex_page_types(p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END apex_page_type_display_value;

    FUNCTION apex_pages(p_apex_app_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(page_name_en, page_name_ar, p_language) || ' (' || apex_page_no || ')' AS display_value,
                   TO_CHAR(apex_page_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY apex_app_id, apex_page_no, page_name_en, apex_page_id) AS display_order
              FROM ph_sec_apex_pages
             WHERE is_deleted = 0
               AND (p_apex_app_id IS NULL OR apex_app_id = p_apex_app_id)
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY apex_app_id, apex_page_no, page_name_en, apex_page_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END apex_pages;

    FUNCTION apex_page_display_value(p_return_value IN VARCHAR2, p_apex_app_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.apex_pages(p_apex_app_id => p_apex_app_id, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END apex_page_display_value;

    FUNCTION roles(p_user_type IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(role_name_en, role_name_ar, p_language) AS display_value,
                   TO_CHAR(role_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY role_name_en, role_id) AS display_order
              FROM ph_sec_roles
             WHERE is_deleted = 0
               AND (p_user_type IS NULL OR user_type = p_user_type)
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY role_name_en, role_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END roles;

    FUNCTION role_display_value(p_return_value IN VARCHAR2, p_user_type IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.roles(p_user_type => p_user_type, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END role_display_value;

    FUNCTION role_permissions(p_role_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(r.role_name_en || ' - ' || p.permission_name_en, r.role_name_ar || ' - ' || p.permission_name_ar, p_language) AS display_value,
                   rp.role_id || ':' || rp.permission_id AS return_value,
                   ROW_NUMBER() OVER (ORDER BY r.role_name_en, p.permission_name_en, rp.permission_id) AS display_order
              FROM ph_sec_role_permissions rp
              JOIN ph_sec_roles r
                ON r.role_id = rp.role_id
              JOIN ph_sec_permissions p
                ON p.permission_id = rp.permission_id
             WHERE rp.is_deleted = 0
               AND r.is_deleted = 0
               AND p.is_deleted = 0
               AND (p_role_id IS NULL OR rp.role_id = p_role_id)
             ORDER BY r.role_name_en, p.permission_name_en, rp.permission_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END role_permissions;

    FUNCTION role_permission_display_value(p_return_value IN VARCHAR2, p_role_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.role_permissions(p_role_id => p_role_id, p_language => p_language))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END role_permission_display_value;

    FUNCTION user_roles(p_user_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(u.display_name || ' - ' || ro.role_name_en, u.display_name || ' - ' || ro.role_name_ar, p_language) AS display_value,
                   ur.user_id || ':' || ur.role_id AS return_value,
                   ROW_NUMBER() OVER (ORDER BY u.display_name, ro.role_name_en, ur.role_id) AS display_order
              FROM ph_sec_user_roles ur
              JOIN ph_sec_users u
                ON u.user_id = ur.user_id
              JOIN ph_sec_roles ro
                ON ro.role_id = ur.role_id
             WHERE ur.is_deleted = 0
               AND u.is_deleted = 0
               AND ro.is_deleted = 0
               AND (p_user_id IS NULL OR ur.user_id = p_user_id)
             ORDER BY u.display_name, ro.role_name_en, ur.role_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END user_roles;

    FUNCTION user_role_display_value(p_return_value IN VARCHAR2, p_user_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.user_roles(p_user_id => p_user_id, p_language => p_language))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END user_role_display_value;

    FUNCTION apex_page_permissions(p_apex_page_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_access_only IN NUMBER DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(pg.page_name_en || ' - ' || p.permission_name_en, pg.page_name_ar || ' - ' || p.permission_name_ar, p_language) AS display_value,
                   app.apex_page_id || ':' || app.permission_id AS return_value,
                   ROW_NUMBER() OVER (ORDER BY pg.apex_app_id, pg.apex_page_no, p.permission_name_en, app.permission_id) AS display_order
              FROM ph_sec_apex_page_permissions app
              JOIN ph_sec_apex_pages pg
                ON pg.apex_page_id = app.apex_page_id
              JOIN ph_sec_permissions p
                ON p.permission_id = app.permission_id
             WHERE app.is_deleted = 0
               AND pg.is_deleted = 0
               AND p.is_deleted = 0
               AND (p_apex_page_id IS NULL OR app.apex_page_id = p_apex_page_id)
               AND (p_access_only IS NULL OR app.is_an_access_permission = p_access_only)
             ORDER BY pg.apex_app_id, pg.apex_page_no, p.permission_name_en, app.permission_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END apex_page_permissions;

    FUNCTION apex_page_permission_display_value(p_return_value IN VARCHAR2, p_apex_page_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_access_only IN NUMBER DEFAULT NULL) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_sec_lov_pkg.apex_page_permissions(p_apex_page_id => p_apex_page_id, p_language => p_language, p_access_only => p_access_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END apex_page_permission_display_value;
END ph_sec_lov_pkg;
/