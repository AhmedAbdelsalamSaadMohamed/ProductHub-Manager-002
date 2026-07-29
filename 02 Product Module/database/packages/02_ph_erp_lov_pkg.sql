/*
ProductHub Manager - Product LOV Package
Target DBMS: Oracle Database 21c+

Purpose:
- Product and ERP entity LOV functions.
- Global lookup LOVs live in ph_globalization_lov_pkg.
*/

CREATE OR REPLACE PACKAGE ph_erp_lov_pkg AS
    FUNCTION pricing_units(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION pricing_unit_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION payment_cycles(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION payment_cycle_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION platforms(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION platform_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION products(p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION product_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION modules(p_product_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION module_display_value(p_return_value IN VARCHAR2, p_product_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION module_platforms(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION module_platform_display_value(p_return_value IN VARCHAR2, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION features(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION feature_display_value(p_return_value IN VARCHAR2, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
END ph_erp_lov_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_erp_lov_pkg AS
    FUNCTION localized_name(p_text_en IN VARCHAR2, p_text_ar IN VARCHAR2, p_language IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_localization_pkg.localized_text(p_text_en, p_text_ar, p_language);
    END localized_name;

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

    FUNCTION pricing_unit_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_lov_pkg.pricing_units(p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END pricing_unit_display_value;

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

    FUNCTION payment_cycle_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_lov_pkg.payment_cycles(p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END payment_cycle_display_value;

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

    FUNCTION platform_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_lov_pkg.platforms(p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END platform_display_value;

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

    FUNCTION product_display_value(p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_lov_pkg.products(p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END product_display_value;

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

    FUNCTION module_display_value(p_return_value IN VARCHAR2, p_product_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_lov_pkg.modules(p_product_id => p_product_id, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END module_display_value;

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

    FUNCTION module_platform_display_value(p_return_value IN VARCHAR2, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_lov_pkg.module_platforms(p_product_id => p_product_id, p_module_id => p_module_id, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END module_platform_display_value;

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

    FUNCTION feature_display_value(p_return_value IN VARCHAR2, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_lov_pkg.features(p_product_id => p_product_id, p_module_id => p_module_id, p_platform_id => p_platform_id, p_language => p_language, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END feature_display_value;
END ph_erp_lov_pkg;
/