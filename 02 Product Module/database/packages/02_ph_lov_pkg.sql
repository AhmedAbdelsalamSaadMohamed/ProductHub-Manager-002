/*
ProductHub Manager - List of Values Package
Target DBMS: Oracle Database 21c+

Purpose:
- Central pipelined LOV functions for ProductHub Manager lookup, ERP, and security entities.
*/

CREATE OR REPLACE TYPE lov_row_ot FORCE AS OBJECT
(
    display_value VARCHAR2(4000),
    return_value  VARCHAR2(4000),
    display_order NUMBER
);
/

CREATE OR REPLACE TYPE lov_table_nt FORCE AS TABLE OF lov_row_ot;
/

CREATE OR REPLACE PACKAGE ph_lov_pkg AS
    FUNCTION lookup_values(p_lookup_type_code IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION yes_no(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION active_status(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION access_modes(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION preference_value_types(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION page_types_static(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;

    FUNCTION languages(p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;

    FUNCTION pricing_units(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION payment_cycles(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION platforms(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION products(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION modules(p_product_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION module_platforms(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION features(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;

    FUNCTION customers(p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION customer_users(p_customer_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contracts(p_customer_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contract_urls(p_contract_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contract_modules(p_contract_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contract_platforms(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contract_features(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;

    FUNCTION user_types(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION object_types(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION security_objects(p_parent_object_id IN NUMBER DEFAULT NULL, p_object_type_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION actions(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION permissions(p_object_id IN NUMBER DEFAULT NULL, p_action_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION apex_page_types(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION apex_pages(p_apex_app_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION roles(p_user_type IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION role_permissions(p_role_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION user_roles(p_user_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION apex_page_permissions(p_apex_page_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_access_only IN NUMBER DEFAULT NULL) RETURN lov_table_nt PIPELINED;
END ph_lov_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_lov_pkg AS
    FUNCTION localized_name(p_text_en IN VARCHAR2, p_text_ar IN VARCHAR2, p_language IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_localization_pkg.localized_text(p_text_en, p_text_ar, p_language);
    END localized_name;

    FUNCTION lookup_values(p_lookup_type_code IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(v.display_value_en, v.display_value_ar, p_language) AS display_value,
                   v.return_value,
                   v.display_order
              FROM ph_lookup_values v
              JOIN ph_lookup_types t
                ON t.lookup_type_code = v.lookup_type_code
             WHERE v.lookup_type_code = UPPER(TRIM(p_lookup_type_code))
               AND v.is_deleted = 0
               AND t.is_deleted = 0
               AND (p_active_only = 0 OR (v.is_active = 1 AND t.is_active = 1))
             ORDER BY v.display_order, v.display_value_en, v.lookup_value_code
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END lookup_values;

    FUNCTION yes_no(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('YES_NO', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END yes_no;

    FUNCTION active_status(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('ACTIVE_STATUS', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END active_status;

    FUNCTION access_modes(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('ACCESS_MODE', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END access_modes;

    FUNCTION preference_value_types(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('PREFERENCE_VALUE_TYPE', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END preference_value_types;

    FUNCTION page_types_static(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('APEX_PAGE_TYPE_CODE', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END page_types_static;

    FUNCTION languages(p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT COALESCE(native_name, language_name) AS display_value,
                   language_code AS return_value,
                   ROW_NUMBER() OVER (ORDER BY is_default DESC, language_name, language_code) AS display_order
              FROM ph_languages
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY is_default DESC, language_name, language_code
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END languages;

    FUNCTION pricing_units(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(pricing_unit_name_en, pricing_unit_name_ar, p_language) AS display_value,
                   TO_CHAR(pricing_unit_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY pricing_unit_name_en, pricing_unit_id) AS display_order
              FROM ph_erp_pricing_unit_lkp
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY pricing_unit_name_en, pricing_unit_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END pricing_units;

    FUNCTION payment_cycles(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(payment_cycle_name_en, payment_cycle_name_ar, p_language) AS display_value,
                   TO_CHAR(payment_cycle_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY months_count, payment_cycle_name_en, payment_cycle_id) AS display_order
              FROM ph_erp_payment_cycle_lkp
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY months_count, payment_cycle_name_en, payment_cycle_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END payment_cycles;

    FUNCTION platforms(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(platform_name_en, platform_name_ar, p_language) AS display_value,
                   TO_CHAR(platform_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY platform_name_en, platform_id) AS display_order
              FROM ph_erp_platform_lkp
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY platform_name_en, platform_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END platforms;

    FUNCTION products(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(product_name_en, product_name_ar, p_language) AS display_value,
                   TO_CHAR(product_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY product_name_en, product_id) AS display_order
              FROM ph_erp_products
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY product_name_en, product_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END products;

    FUNCTION modules(p_product_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(p.product_name_en || ' - ' || m.module_name_en, p.product_name_ar || ' - ' || m.module_name_ar, p_language) AS display_value,
                   m.product_id || ':' || m.module_id AS return_value,
                   ROW_NUMBER() OVER (ORDER BY p.product_name_en, m.display_order, m.module_name_en, m.module_id) AS display_order
              FROM ph_erp_modules m
              JOIN ph_erp_products p
                ON p.product_id = m.product_id
             WHERE m.is_deleted = 0
               AND p.is_deleted = 0
               AND (p_product_id IS NULL OR m.product_id = p_product_id)
               AND (p_active_only = 0 OR (m.is_active = 1 AND p.is_active = 1))
             ORDER BY p.product_name_en, m.display_order, m.module_name_en, m.module_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END modules;

    FUNCTION module_platforms(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(p.product_name_en || ' - ' || m.module_name_en || ' - ' || pl.platform_name_en, p.product_name_ar || ' - ' || m.module_name_ar || ' - ' || pl.platform_name_ar, p_language) AS display_value,
                   mp.product_id || ':' || mp.module_id || ':' || mp.platform_id AS return_value,
                   ROW_NUMBER() OVER (ORDER BY p.product_name_en, m.display_order, pl.platform_name_en, mp.platform_id) AS display_order
              FROM ph_erp_module_platforms mp
              JOIN ph_erp_modules m
                ON m.product_id = mp.product_id
               AND m.module_id = mp.module_id
              JOIN ph_erp_products p
                ON p.product_id = mp.product_id
              JOIN ph_erp_platform_lkp pl
                ON pl.platform_id = mp.platform_id
             WHERE mp.is_deleted = 0
               AND m.is_deleted = 0
               AND p.is_deleted = 0
               AND pl.is_deleted = 0
               AND (p_product_id IS NULL OR mp.product_id = p_product_id)
               AND (p_module_id IS NULL OR mp.module_id = p_module_id)
               AND (p_active_only = 0 OR (mp.is_active = 1 AND m.is_active = 1 AND p.is_active = 1 AND pl.is_active = 1))
             ORDER BY p.product_name_en, m.display_order, pl.platform_name_en, mp.platform_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END module_platforms;

    FUNCTION features(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(p.product_name_en || ' - ' || m.module_name_en || ' - ' || pl.platform_name_en || ' - ' || f.feature_name_en, p.product_name_ar || ' - ' || m.module_name_ar || ' - ' || pl.platform_name_ar || ' - ' || f.feature_name_ar, p_language) AS display_value,
                   f.product_id || ':' || f.module_id || ':' || f.platform_id || ':' || f.feature_id AS return_value,
                   ROW_NUMBER() OVER (ORDER BY p.product_name_en, m.display_order, pl.platform_name_en, f.display_order, f.feature_name_en, f.feature_id) AS display_order
              FROM ph_erp_features f
              JOIN ph_erp_modules m
                ON m.product_id = f.product_id
               AND m.module_id = f.module_id
              JOIN ph_erp_products p
                ON p.product_id = f.product_id
              JOIN ph_erp_platform_lkp pl
                ON pl.platform_id = f.platform_id
             WHERE f.is_deleted = 0
               AND m.is_deleted = 0
               AND p.is_deleted = 0
               AND pl.is_deleted = 0
               AND (p_product_id IS NULL OR f.product_id = p_product_id)
               AND (p_module_id IS NULL OR f.module_id = p_module_id)
               AND (p_platform_id IS NULL OR f.platform_id = p_platform_id)
               AND (p_active_only = 0 OR (f.is_active = 1 AND m.is_active = 1 AND p.is_active = 1 AND pl.is_active = 1))
             ORDER BY p.product_name_en, m.display_order, pl.platform_name_en, f.display_order, f.feature_name_en, f.feature_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END features;

    FUNCTION customers(p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT customer_name AS display_value,
                   TO_CHAR(customer_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY customer_name, customer_id) AS display_order
              FROM ph_erp_customers
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY customer_name, customer_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END customers;

    FUNCTION customer_users(p_customer_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_name || ' <' || email || '>' AS display_value,
                   TO_CHAR(user_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY display_name, email, user_id) AS display_order
              FROM ph_sec_users
             WHERE is_deleted = 0
               AND (p_customer_id IS NULL OR customer_id = p_customer_id)
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY display_name, email, user_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END customer_users;

    FUNCTION contracts(p_customer_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT c.contract_no || ' - ' || cu.customer_name AS display_value,
                   TO_CHAR(c.contract_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY cu.customer_name, c.contract_no, c.contract_id) AS display_order
              FROM ph_erp_contracts c
              JOIN ph_erp_customers cu
                ON cu.customer_id = c.customer_id
             WHERE c.is_deleted = 0
               AND cu.is_deleted = 0
               AND (p_customer_id IS NULL OR c.customer_id = p_customer_id)
               AND (p_product_id IS NULL OR c.product_id = p_product_id)
               AND (p_active_only = 0 OR (c.is_active = 1 AND cu.is_active = 1))
             ORDER BY cu.customer_name, c.contract_no, c.contract_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END contracts;

    FUNCTION contract_urls(p_contract_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT c.contract_no || ' - ' || cu.access_url AS display_value,
                   TO_CHAR(cu.contract_url_id) AS return_value,
                   ROW_NUMBER() OVER (ORDER BY c.contract_no, cu.is_primary DESC, cu.access_url, cu.contract_url_id) AS display_order
              FROM ph_erp_contract_urls cu
              JOIN ph_erp_contracts c
                ON c.contract_id = cu.contract_id
             WHERE cu.is_deleted = 0
               AND c.is_deleted = 0
               AND (p_contract_id IS NULL OR cu.contract_id = p_contract_id)
               AND (p_active_only = 0 OR (cu.is_active = 1 AND c.is_active = 1))
             ORDER BY c.contract_no, cu.is_primary DESC, cu.access_url, cu.contract_url_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END contract_urls;

    FUNCTION contract_modules(p_contract_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(c.contract_no || ' - ' || m.module_name_en, c.contract_no || ' - ' || m.module_name_ar, p_language) AS display_value,
                   cm.contract_id || ':' || cm.product_id || ':' || cm.module_id AS return_value,
                   ROW_NUMBER() OVER (ORDER BY c.contract_no, m.display_order, m.module_name_en, cm.module_id) AS display_order
              FROM ph_erp_contract_modules cm
              JOIN ph_erp_contracts c
                ON c.contract_id = cm.contract_id
              JOIN ph_erp_modules m
                ON m.product_id = cm.product_id
               AND m.module_id = cm.module_id
             WHERE cm.is_deleted = 0
               AND c.is_deleted = 0
               AND m.is_deleted = 0
               AND (p_contract_id IS NULL OR cm.contract_id = p_contract_id)
               AND (p_active_only = 0 OR (cm.is_active = 1 AND c.is_active = 1 AND m.is_active = 1))
             ORDER BY c.contract_no, m.display_order, m.module_name_en, cm.module_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END contract_modules;

    FUNCTION contract_platforms(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(c.contract_no || ' - ' || m.module_name_en || ' - ' || pl.platform_name_en, c.contract_no || ' - ' || m.module_name_ar || ' - ' || pl.platform_name_ar, p_language) AS display_value,
                   cp.contract_id || ':' || cp.product_id || ':' || cp.module_id || ':' || cp.platform_id AS return_value,
                   ROW_NUMBER() OVER (ORDER BY c.contract_no, m.display_order, pl.platform_name_en, cp.platform_id) AS display_order
              FROM ph_erp_contract_platforms cp
              JOIN ph_erp_contracts c
                ON c.contract_id = cp.contract_id
              JOIN ph_erp_modules m
                ON m.product_id = cp.product_id
               AND m.module_id = cp.module_id
              JOIN ph_erp_platform_lkp pl
                ON pl.platform_id = cp.platform_id
             WHERE cp.is_deleted = 0
               AND c.is_deleted = 0
               AND m.is_deleted = 0
               AND pl.is_deleted = 0
               AND (p_contract_id IS NULL OR cp.contract_id = p_contract_id)
               AND (p_product_id IS NULL OR cp.product_id = p_product_id)
               AND (p_module_id IS NULL OR cp.module_id = p_module_id)
               AND (p_active_only = 0 OR (cp.is_active = 1 AND c.is_active = 1 AND m.is_active = 1 AND pl.is_active = 1))
             ORDER BY c.contract_no, m.display_order, pl.platform_name_en, cp.platform_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END contract_platforms;

    FUNCTION contract_features(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(c.contract_no || ' - ' || f.feature_name_en, c.contract_no || ' - ' || f.feature_name_ar, p_language) AS display_value,
                   cf.contract_id || ':' || cf.product_id || ':' || cf.module_id || ':' || cf.platform_id || ':' || cf.feature_id AS return_value,
                   ROW_NUMBER() OVER (ORDER BY c.contract_no, f.display_order, f.feature_name_en, cf.feature_id) AS display_order
              FROM ph_erp_contract_features cf
              JOIN ph_erp_contracts c
                ON c.contract_id = cf.contract_id
              JOIN ph_erp_features f
                ON f.product_id = cf.product_id
               AND f.module_id = cf.module_id
               AND f.platform_id = cf.platform_id
               AND f.feature_id = cf.feature_id
             WHERE cf.is_deleted = 0
               AND c.is_deleted = 0
               AND f.is_deleted = 0
               AND (p_contract_id IS NULL OR cf.contract_id = p_contract_id)
               AND (p_product_id IS NULL OR cf.product_id = p_product_id)
               AND (p_module_id IS NULL OR cf.module_id = p_module_id)
               AND (p_platform_id IS NULL OR cf.platform_id = p_platform_id)
               AND (p_active_only = 0 OR (cf.is_active = 1 AND c.is_active = 1 AND f.is_active = 1))
             ORDER BY c.contract_no, f.display_order, f.feature_name_en, cf.feature_id
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END contract_features;

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
END ph_lov_pkg;
/
