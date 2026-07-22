/*
    ProductHub Manager - Oracle Views
*/

CREATE OR REPLACE VIEW vw_ph_erp_product_catalog AS
SELECT
    p.product_id,
    p.product_name_en,
    p.product_name_ar,
    p.description_en AS product_description_en,
    p.description_ar AS product_description_ar,
    p.is_active AS product_is_active,
    m.module_id,
    m.module_name_en,
    m.module_name_ar,
    m.description_en AS module_description_en,
    m.description_ar AS module_description_ar,
    m.display_order AS module_display_order,
    m.is_active AS module_is_active,
    pl.platform_id,
    pl.platform_name_en,
    pl.platform_name_ar,
    f.feature_id,
    f.feature_name_en,
    f.feature_name_ar,
    f.description_en AS feature_description_en,
    f.description_ar AS feature_description_ar,
    f.price,
    f.pricing_unit_id,
    f.usage_unit,
    f.display_order AS feature_display_order,
    f.is_active AS feature_is_active
FROM ph_erp_products p
LEFT JOIN ph_erp_modules m
    ON m.product_id = p.product_id
   AND m.is_deleted = 0
LEFT JOIN ph_erp_module_platforms mp
    ON mp.product_id = m.product_id
   AND mp.module_id = m.module_id
   AND mp.is_deleted = 0
LEFT JOIN ph_erp_platform_lkp pl
    ON pl.platform_id = mp.platform_id
   AND pl.is_deleted = 0
LEFT JOIN ph_erp_features f
    ON f.product_id = mp.product_id
   AND f.module_id = mp.module_id
   AND f.platform_id = mp.platform_id
   AND f.is_deleted = 0
WHERE p.is_deleted = 0;

CREATE OR REPLACE VIEW vw_ph_erp_customer_subscriptions AS
SELECT
    c.customer_id,
    c.customer_name,
    ct.contract_id,
    ct.contract_no,
    ct.is_active AS contract_is_active,
    ct.payment_cycle,
    ct.start_date,
    ct.end_date,
    p.product_id,
    p.product_name_en,
    p.product_name_ar,
    m.module_id,
    m.module_name_en,
    m.module_name_ar,
    cm.is_active AS module_subscription_is_active,
    cp.platform_id,
    pl.platform_name_en,
    pl.platform_name_ar,
    cp.is_active AS platform_subscription_is_active,
    cf.feature_id,
    f.feature_name_en,
    f.feature_name_ar,
    NVL(cf.agreed_price, f.price) AS subscribed_price,
    cf.is_active AS feature_subscription_is_active
FROM ph_erp_customers c
JOIN ph_erp_contracts ct
    ON ct.customer_id = c.customer_id
   AND ct.is_deleted = 0
JOIN ph_erp_products p
    ON p.product_id = ct.product_id
   AND p.is_deleted = 0
JOIN ph_erp_contract_modules cm
    ON cm.contract_id = ct.contract_id
   AND cm.product_id = ct.product_id
   AND cm.is_deleted = 0
JOIN ph_erp_modules m
    ON m.product_id = cm.product_id
   AND m.module_id = cm.module_id
   AND m.is_deleted = 0
JOIN ph_erp_contract_platforms cp
    ON cp.contract_id = cm.contract_id
   AND cp.product_id = cm.product_id
   AND cp.module_id = cm.module_id
   AND cp.is_deleted = 0
JOIN ph_erp_contract_features cf
    ON cf.contract_id = cp.contract_id
   AND cf.product_id = cp.product_id
   AND cf.module_id = cp.module_id
   AND cf.platform_id = cp.platform_id
   AND cf.is_deleted = 0
JOIN ph_erp_platform_lkp pl
    ON pl.platform_id = cp.platform_id
   AND pl.is_deleted = 0
JOIN ph_erp_features f
    ON f.product_id = cf.product_id
   AND f.module_id = cf.module_id
   AND f.platform_id = cf.platform_id
   AND f.feature_id = cf.feature_id
   AND f.is_deleted = 0
WHERE c.is_deleted = 0;

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
              SELECT 1
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
              SELECT 1
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
              SELECT 1
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
                    SELECT 1
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

CREATE OR REPLACE VIEW vw_ph_erp_customer_onboarding AS
SELECT
    c.customer_id,
    c.customer_name,
    p.product_id,
    p.product_name_en,
    p.product_name_ar,
    ct.contract_id,
    ct.contract_no,
    ct.is_active AS contract_is_active,
    cu.access_url,
    u.user_id AS initial_admin_user_id,
    u.email AS initial_admin_email,
    u.display_name AS initial_admin_name
FROM ph_erp_customers c
JOIN ph_erp_contracts ct
    ON ct.customer_id = c.customer_id
   AND ct.is_deleted = 0
JOIN ph_erp_products p
    ON p.product_id = ct.product_id
   AND p.is_deleted = 0
LEFT JOIN ph_erp_contract_urls cu
    ON cu.contract_id = ct.contract_id
   AND cu.is_active = 1
   AND cu.is_primary = 1
   AND cu.is_deleted = 0
LEFT JOIN ph_sec_users u
    ON u.customer_id = c.customer_id
   AND u.is_initial_admin = 1
   AND u.is_active = 1
   AND u.is_deleted = 0
WHERE c.is_deleted = 0;

CREATE OR REPLACE VIEW vw_ph_erp_product_catalog_i18n AS
SELECT
    lang.language_code,
    lang.is_rtl,
    p.product_id,
    COALESCE(pt_name.text_value, CASE lang.language_code WHEN 'ar' THEN p.product_name_ar ELSE p.product_name_en END, p.product_name_en, p.product_name_ar) AS product_name,
    COALESCE(pt_desc.text_value, CASE lang.language_code WHEN 'ar' THEN p.description_ar ELSE p.description_en END, p.description_en, p.description_ar) AS product_description,
    p.is_active AS product_is_active,
    m.module_id,
    COALESCE(mt_name.text_value, CASE lang.language_code WHEN 'ar' THEN m.module_name_ar ELSE m.module_name_en END, m.module_name_en, m.module_name_ar) AS module_name,
    COALESCE(mt_desc.text_value, CASE lang.language_code WHEN 'ar' THEN m.description_ar ELSE m.description_en END, m.description_en, m.description_ar) AS module_description,
    m.display_order AS module_display_order,
    m.is_active AS module_is_active,
    pl.platform_id,
    COALESCE(plt_name.text_value, CASE lang.language_code WHEN 'ar' THEN pl.platform_name_ar ELSE pl.platform_name_en END, pl.platform_name_en, pl.platform_name_ar) AS platform_name,
    f.feature_id,
    COALESCE(ft_name.text_value, CASE lang.language_code WHEN 'ar' THEN f.feature_name_ar ELSE f.feature_name_en END, f.feature_name_en, f.feature_name_ar) AS feature_name,
    COALESCE(ft_desc.text_value, CASE lang.language_code WHEN 'ar' THEN f.description_ar ELSE f.description_en END, f.description_en, f.description_ar) AS feature_description,
    f.price,
    f.pricing_unit_id,
    f.usage_unit,
    f.display_order AS feature_display_order,
    f.is_active AS feature_is_active
FROM ph_languages lang
CROSS JOIN ph_erp_products p
LEFT JOIN ph_erp_modules m
    ON m.product_id = p.product_id
   AND m.is_deleted = 0
LEFT JOIN ph_erp_module_platforms mp
    ON mp.product_id = m.product_id
   AND mp.module_id = m.module_id
   AND mp.is_deleted = 0
LEFT JOIN ph_erp_platform_lkp pl
    ON pl.platform_id = mp.platform_id
   AND pl.is_deleted = 0
LEFT JOIN ph_erp_features f
    ON f.product_id = mp.product_id
   AND f.module_id = mp.module_id
   AND f.platform_id = mp.platform_id
   AND f.is_deleted = 0
LEFT JOIN ph_i18n_texts pt_name
    ON pt_name.entity_name = 'PH_ERP_PRODUCTS'
   AND pt_name.entity_key = TO_CHAR(p.product_id)
   AND pt_name.field_name = 'PRODUCT_NAME'
   AND pt_name.language_code = lang.language_code
   AND lang.language_code NOT IN ('en', 'ar')
   AND pt_name.is_deleted = 0
LEFT JOIN ph_i18n_texts pt_desc
    ON pt_desc.entity_name = 'PH_ERP_PRODUCTS'
   AND pt_desc.entity_key = TO_CHAR(p.product_id)
   AND pt_desc.field_name = 'DESCRIPTION'
   AND pt_desc.language_code = lang.language_code
   AND lang.language_code NOT IN ('en', 'ar')
   AND pt_desc.is_deleted = 0
LEFT JOIN ph_i18n_texts mt_name
    ON mt_name.entity_name = 'PH_ERP_MODULES'
   AND mt_name.entity_key = p.product_id || ':' || m.module_id
   AND mt_name.field_name = 'MODULE_NAME'
   AND mt_name.language_code = lang.language_code
   AND lang.language_code NOT IN ('en', 'ar')
   AND mt_name.is_deleted = 0
LEFT JOIN ph_i18n_texts mt_desc
    ON mt_desc.entity_name = 'PH_ERP_MODULES'
   AND mt_desc.entity_key = p.product_id || ':' || m.module_id
   AND mt_desc.field_name = 'DESCRIPTION'
   AND mt_desc.language_code = lang.language_code
   AND lang.language_code NOT IN ('en', 'ar')
   AND mt_desc.is_deleted = 0
LEFT JOIN ph_i18n_texts plt_name
    ON plt_name.entity_name = 'PH_ERP_PLATFORM_LKP'
   AND plt_name.entity_key = TO_CHAR(pl.platform_id)
   AND plt_name.field_name = 'PLATFORM_NAME'
   AND plt_name.language_code = lang.language_code
   AND lang.language_code NOT IN ('en', 'ar')
   AND plt_name.is_deleted = 0
LEFT JOIN ph_i18n_texts ft_name
    ON ft_name.entity_name = 'PH_ERP_FEATURES'
   AND ft_name.entity_key = f.product_id || ':' || f.module_id || ':' || f.platform_id || ':' || f.feature_id
   AND ft_name.field_name = 'FEATURE_NAME'
   AND ft_name.language_code = lang.language_code
   AND lang.language_code NOT IN ('en', 'ar')
   AND ft_name.is_deleted = 0
LEFT JOIN ph_i18n_texts ft_desc
    ON ft_desc.entity_name = 'PH_ERP_FEATURES'
   AND ft_desc.entity_key = f.product_id || ':' || f.module_id || ':' || f.platform_id || ':' || f.feature_id
   AND ft_desc.field_name = 'DESCRIPTION'
   AND ft_desc.language_code = lang.language_code
   AND lang.language_code NOT IN ('en', 'ar')
   AND ft_desc.is_deleted = 0
WHERE lang.is_active = 1
  AND lang.is_deleted = 0
  AND p.is_deleted = 0;

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

