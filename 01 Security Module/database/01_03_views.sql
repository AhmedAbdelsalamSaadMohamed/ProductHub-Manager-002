/*
ProductHub Manager - Security Module Views
Target DBMS: Oracle Database 21c+
*/

CREATE OR REPLACE VIEW vw_ph_sec_user_permissions AS
SELECT
    u.user_id,
    u.email,
    u.display_name,
    u.user_type,
    u.customer_id,
    r.role_id,
    r.role_name_en,
    r.role_name_ar,
    p.permission_id,
    p.permission_name_en,
    p.permission_name_ar,
    o.object_id,
    o.object_name,
    o.object_type_id,
    ot.object_type_name_en,
    ot.object_type_name_ar,
    o.object_path,
    o.display_name_en AS object_display_name_en,
    o.display_name_ar AS object_display_name_ar,
    a.action_id,
    a.action_name,
    a.display_name_en AS action_display_name_en,
    a.display_name_ar AS action_display_name_ar
FROM ph_sec_users u
JOIN ph_sec_user_roles ur
    ON ur.user_id = u.user_id
    AND ur.is_deleted = 0
JOIN ph_sec_roles r
    ON r.role_id = ur.role_id
    AND r.is_deleted = 0
JOIN ph_sec_role_permissions rp
    ON rp.role_id = r.role_id
    AND rp.is_deleted = 0
JOIN ph_sec_permissions p
    ON p.permission_id = rp.permission_id
    AND p.is_deleted = 0
JOIN ph_sec_objects o
    ON o.object_id = p.object_id
    AND o.is_deleted = 0
JOIN ph_sec_object_type_lkp ot
    ON ot.object_type_id = o.object_type_id
    AND ot.is_deleted = 0
JOIN ph_sec_actions a
    ON a.action_id = p.action_id
    AND a.is_deleted = 0
WHERE u.is_active = 1
    AND u.is_deleted = 0
    AND r.is_active = 1
    AND p.is_active = 1
    AND o.is_active = 1
    AND ot.is_active = 1
    AND a.is_active = 1;

CREATE OR REPLACE VIEW vw_ph_sec_page_permissions AS
SELECT
    pg.apex_page_id,
    pg.apex_app_id,
    pg.apex_page_no,
    pg.apex_page_type_id,
    pt.apex_page_type_code,
    pt.apex_page_type_name_en,
    pt.apex_page_type_name_ar,
    pg.page_alias,
    pg.page_name_en,
    pg.page_name_ar,
    pg.object_path AS page_object_path,
    pg.access_mode,
    pg.is_public,
    pg.is_active AS page_is_active,
    pp.permission_id,
    pp.is_an_access_permission,
    pp.is_active AS page_permission_is_active,
    p.permission_name_en,
    p.permission_name_ar,
    o.object_id,
    o.object_name,
    o.object_path,
    a.action_id,
    a.action_name
FROM ph_sec_apex_pages pg
JOIN ph_sec_apex_page_type_lkp pt
    ON pt.apex_page_type_id = pg.apex_page_type_id
    AND pt.is_deleted = 0
JOIN ph_sec_apex_page_permissions pp
    ON pp.apex_page_id = pg.apex_page_id
    AND pp.is_deleted = 0
JOIN ph_sec_permissions p
    ON p.permission_id = pp.permission_id
    AND p.is_deleted = 0
JOIN ph_sec_objects o
    ON o.object_id = p.object_id
    AND o.is_deleted = 0
JOIN ph_sec_actions a
    ON a.action_id = p.action_id
    AND a.is_deleted = 0
WHERE pg.is_active = 1
    AND pg.is_deleted = 0
    AND pp.is_active = 1
    AND pt.is_active = 1
    AND p.is_active = 1
    AND o.is_active = 1
    AND a.is_active = 1;

CREATE OR REPLACE VIEW vw_ph_sec_user_page_access AS
SELECT
    u.user_id,
    u.email,
    u.email AS username,
    u.display_name,
    u.user_type,
    u.customer_id,
    pg.apex_page_id,
    pg.apex_app_id,
    pg.apex_page_no,
    pg.apex_page_type_id,
    pt.apex_page_type_code,
    pt.apex_page_type_name_en,
    pt.apex_page_type_name_ar,
    pg.page_alias,
    pg.page_name_en,
    pg.page_name_ar,
    pg.object_path AS page_object_path,
    pg.access_mode,
    pg.is_public,
    1 AS has_access
FROM ph_sec_users u
CROSS JOIN ph_sec_apex_pages pg
JOIN ph_sec_apex_page_type_lkp pt
    ON pt.apex_page_type_id = pg.apex_page_type_id
    AND pt.is_deleted = 0
WHERE pg.is_active = 1
    AND pg.is_deleted = 0
    AND pt.is_active = 1
    AND u.is_active = 1
    AND u.is_deleted = 0
    AND (
    pg.is_public = 1
    OR (
    pg.access_mode = 'ANY'
    AND EXISTS (
SELECT
FROM ph_sec_apex_page_permissions app
JOIN ph_sec_role_permissions rp
    ON rp.permission_id = app.permission_id
    AND rp.is_deleted = 0
JOIN ph_sec_user_roles ur
    ON ur.role_id = rp.role_id
    AND ur.is_deleted = 0
JOIN ph_sec_roles r
    ON r.role_id = ur.role_id
    AND r.is_deleted = 0
JOIN ph_sec_permissions p
    ON p.permission_id = app.permission_id
    AND p.is_deleted = 0
WHERE app.apex_page_id = pg.apex_page_id
    AND ur.user_id = u.user_id
    AND app.is_active = 1
    AND app.is_deleted = 0
    AND app.is_an_access_permission = 1
    AND r.is_active = 1
    AND p.is_active = 1
    )
    )
    OR (
    pg.access_mode = 'ALL'
    AND EXISTS (
SELECT
FROM ph_sec_apex_page_permissions app
JOIN ph_sec_permissions p
    ON p.permission_id = app.permission_id
    AND p.is_deleted = 0
WHERE app.apex_page_id = pg.apex_page_id
    AND app.is_active = 1
    AND app.is_deleted = 0
    AND app.is_an_access_permission = 1
    AND p.is_active = 1
    )
    AND NOT EXISTS (
SELECT
FROM ph_sec_apex_page_permissions required_app
JOIN ph_sec_permissions required_p
    ON required_p.permission_id = required_app.permission_id
    AND required_p.is_deleted = 0
WHERE required_app.apex_page_id = pg.apex_page_id
    AND required_app.is_active = 1
    AND required_app.is_deleted = 0
    AND required_app.is_an_access_permission = 1
    AND required_p.is_active = 1
    AND NOT EXISTS (
SELECT
FROM ph_sec_role_permissions rp
JOIN ph_sec_user_roles ur
    ON ur.role_id = rp.role_id
    AND ur.is_deleted = 0
JOIN ph_sec_roles r
    ON r.role_id = ur.role_id
    AND r.is_deleted = 0
WHERE rp.permission_id = required_app.permission_id
    AND rp.is_deleted = 0
    AND ur.user_id = u.user_id
    AND r.is_active = 1
    )
    )
    )
    );

CREATE OR REPLACE VIEW vw_ph_sec_user_permissions_i18n AS
SELECT
    lang.language_code,
    lang.is_rtl,
    u.user_id,
    u.email,
    u.display_name,
    u.user_type,
    u.customer_id,
    r.role_id,
    COALESCE(rt_name.text_value, CASE lang.language_code WHEN 'ar' THEN r.role_name_ar ELSE r.role_name_en END, r.role_name_en, r.role_name_ar) AS role_name,
    p.permission_id,
    COALESCE(pt_name.text_value, CASE lang.language_code WHEN 'ar' THEN p.permission_name_ar ELSE p.permission_name_en END, p.permission_name_en, p.permission_name_ar) AS permission_name,
    o.object_id,
    o.object_name,
    o.object_type_id,
    COALESCE(ot_name.text_value, CASE lang.language_code WHEN 'ar' THEN ot.object_type_name_ar ELSE ot.object_type_name_en END, ot.object_type_name_en, ot.object_type_name_ar) AS object_type_name,
    o.object_path,
    COALESCE(o_name.text_value, CASE lang.language_code WHEN 'ar' THEN o.display_name_ar ELSE o.display_name_en END, o.display_name_en, o.display_name_ar) AS object_display_name,
    a.action_id,
    a.action_name,
    COALESCE(a_name.text_value, CASE lang.language_code WHEN 'ar' THEN a.display_name_ar ELSE a.display_name_en END, a.display_name_en, a.display_name_ar) AS action_display_name
FROM ph_languages lang
CROSS JOIN ph_sec_users u
JOIN ph_sec_user_roles ur
    ON ur.user_id = u.user_id
    AND ur.is_deleted = 0
JOIN ph_sec_roles r
    ON r.role_id = ur.role_id
    AND r.is_deleted = 0
JOIN ph_sec_role_permissions rp
    ON rp.role_id = r.role_id
    AND rp.is_deleted = 0
JOIN ph_sec_permissions p
    ON p.permission_id = rp.permission_id
    AND p.is_deleted = 0
JOIN ph_sec_objects o
    ON o.object_id = p.object_id
    AND o.is_deleted = 0
JOIN ph_sec_object_type_lkp ot
    ON ot.object_type_id = o.object_type_id
    AND ot.is_deleted = 0
JOIN ph_sec_actions a
    ON a.action_id = p.action_id
    AND a.is_deleted = 0
LEFT JOIN ph_i18n_texts rt_name
    ON rt_name.entity_name = 'PH_SEC_ROLES'
    AND rt_name.entity_key = TO_CHAR(r.role_id)
    AND rt_name.field_name = 'ROLE_NAME'
    AND rt_name.language_code = lang.language_code
    AND lang.language_code NOT IN ('en', 'ar')
    AND rt_name.is_deleted = 0
LEFT JOIN ph_i18n_texts pt_name
    ON pt_name.entity_name = 'PH_SEC_PERMISSIONS'
    AND pt_name.entity_key = TO_CHAR(p.permission_id)
    AND pt_name.field_name = 'PERMISSION_NAME'
    AND pt_name.language_code = lang.language_code
    AND lang.language_code NOT IN ('en', 'ar')
    AND pt_name.is_deleted = 0
LEFT JOIN ph_i18n_texts ot_name
    ON ot_name.entity_name = 'PH_SEC_OBJECT_TYPE_LKP'
    AND ot_name.entity_key = TO_CHAR(ot.object_type_id)
    AND ot_name.field_name = 'OBJECT_TYPE_NAME'
    AND ot_name.language_code = lang.language_code
    AND lang.language_code NOT IN ('en', 'ar')
    AND ot_name.is_deleted = 0
LEFT JOIN ph_i18n_texts o_name
    ON o_name.entity_name = 'PH_SEC_OBJECTS'
    AND o_name.entity_key = TO_CHAR(o.object_id)
    AND o_name.field_name = 'DISPLAY_NAME'
    AND o_name.language_code = lang.language_code
    AND lang.language_code NOT IN ('en', 'ar')
    AND o_name.is_deleted = 0
LEFT JOIN ph_i18n_texts a_name
    ON a_name.entity_name = 'PH_SEC_ACTIONS'
    AND a_name.entity_key = TO_CHAR(a.action_id)
    AND a_name.field_name = 'DISPLAY_NAME'
    AND a_name.language_code = lang.language_code
    AND lang.language_code NOT IN ('en', 'ar')
    AND a_name.is_deleted = 0
WHERE lang.is_active = 1
    AND lang.is_deleted = 0
    AND u.is_active = 1
    AND u.is_deleted = 0
    AND r.is_active = 1
    AND p.is_active = 1
    AND o.is_active = 1
    AND ot.is_active = 1
    AND a.is_active = 1;
