/*
ProductHub Manager - Contract LOV Package
Target DBMS: Oracle Database 21c+

Purpose:
- Contract entity LOV functions.
- Global lookup LOVs live in ph_globalization_lov_pkg.
*/

CREATE OR REPLACE PACKAGE ph_erp_contract_lov_pkg AS
    FUNCTION contracts(p_customer_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contract_display_value(p_return_value IN VARCHAR2, p_customer_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION contract_urls(p_contract_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contract_url_display_value(p_return_value IN VARCHAR2, p_contract_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION contract_modules(p_contract_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contract_module_display_value(p_return_value IN VARCHAR2, p_contract_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION contract_platforms(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contract_platform_display_value(p_return_value IN VARCHAR2, p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION contract_features(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION contract_feature_display_value(p_return_value IN VARCHAR2, p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
END ph_erp_contract_lov_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_erp_contract_lov_pkg AS
    FUNCTION localized_name(p_text_en IN VARCHAR2, p_text_ar IN VARCHAR2, p_language IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_localization_pkg.localized_text(p_text_en, p_text_ar, p_language);
    END localized_name;

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

    FUNCTION contract_display_value(p_return_value IN VARCHAR2, p_customer_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_contract_lov_pkg.contracts(p_customer_id => p_customer_id, p_product_id => p_product_id, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END contract_display_value;

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

    FUNCTION contract_url_display_value(p_return_value IN VARCHAR2, p_contract_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_contract_lov_pkg.contract_urls(p_contract_id => p_contract_id, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END contract_url_display_value;

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

    FUNCTION contract_module_display_value(p_return_value IN VARCHAR2, p_contract_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_contract_lov_pkg.contract_modules(p_contract_id => p_contract_id, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END contract_module_display_value;

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

    FUNCTION contract_platform_display_value(p_return_value IN VARCHAR2, p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_contract_lov_pkg.contract_platforms(p_contract_id => p_contract_id, p_product_id => p_product_id, p_module_id => p_module_id, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END contract_platform_display_value;

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

    FUNCTION contract_feature_display_value(p_return_value IN VARCHAR2, p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_contract_lov_pkg.contract_features(p_contract_id => p_contract_id, p_product_id => p_product_id, p_module_id => p_module_id, p_platform_id => p_platform_id, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END contract_feature_display_value;
END ph_erp_contract_lov_pkg;
/