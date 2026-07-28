/*
ProductHub Manager - Product Module Views
Target DBMS: Oracle Database 21c+
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
