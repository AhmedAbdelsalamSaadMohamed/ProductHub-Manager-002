/*
ProductHub Manager - ERP Management Package
Target DBMS: Oracle Database 21c+

Purpose:
- Central service layer for ERP catalog and setup management.
- Supports add, edit, and soft-delete operations for ERP setup lookups,
products, modules, module platforms, and features.
- Designed for Oracle APEX processes and ORDS/REST handlers.
*/

CREATE OR REPLACE PACKAGE ph_erp_management_pkg AS
    ----------------------------------------------------------------------
    -- Read operations
    ----------------------------------------------------------------------
    FUNCTION get_platforms(p_platform_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_pricing_units(p_pricing_unit_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_payment_cycles(p_payment_cycle_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_products(p_product_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_modules(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_module_platforms(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_features(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_feature_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;

    ----------------------------------------------------------------------
    -- Create/update/delete/restore operations
    ----------------------------------------------------------------------
    PROCEDURE create_platform(p_platform_name_en IN VARCHAR2, p_platform_name_ar IN VARCHAR2, p_platform_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_platform(p_platform_id IN NUMBER, p_platform_name_en IN VARCHAR2 DEFAULT NULL, p_platform_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_platform(p_platform_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_platform(p_platform_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_pricing_unit(p_pricing_unit_name_en IN VARCHAR2, p_pricing_unit_name_ar IN VARCHAR2, p_pricing_unit_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_pricing_unit(p_pricing_unit_id IN NUMBER, p_pricing_unit_name_en IN VARCHAR2 DEFAULT NULL, p_pricing_unit_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_pricing_unit(p_pricing_unit_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_pricing_unit(p_pricing_unit_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_payment_cycle(p_payment_cycle_name_en IN VARCHAR2, p_payment_cycle_name_ar IN VARCHAR2, p_months_count IN NUMBER, p_payment_cycle_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_payment_cycle(p_payment_cycle_id IN NUMBER, p_payment_cycle_name_en IN VARCHAR2 DEFAULT NULL, p_payment_cycle_name_ar IN VARCHAR2 DEFAULT NULL, p_months_count IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_payment_cycle(p_payment_cycle_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_payment_cycle(p_payment_cycle_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_product(p_product_name_en IN VARCHAR2, p_product_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_product_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_product(p_product_id IN NUMBER, p_product_name_en IN VARCHAR2 DEFAULT NULL, p_product_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_product(p_product_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_product(p_product_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_module(p_product_id IN NUMBER, p_module_name_en IN VARCHAR2, p_module_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_module_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_module_name_en IN VARCHAR2 DEFAULT NULL, p_module_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    PROCEDURE create_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_name_en IN VARCHAR2, p_feature_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_price IN NUMBER, p_pricing_unit_id IN NUMBER, p_usage_unit IN VARCHAR2 DEFAULT 'USE', p_display_order IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_feature_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_feature_name_en IN VARCHAR2 DEFAULT NULL, p_feature_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_price IN NUMBER DEFAULT NULL, p_pricing_unit_id IN NUMBER DEFAULT NULL, p_usage_unit IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
END ph_erp_management_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_erp_management_pkg AS
    ----------------------------------------------------------------------
    -- Core create/update/delete implementations
    ----------------------------------------------------------------------
    PROCEDURE do_update_platform(
        p_platform_id       IN NUMBER,
        p_platform_name_en  IN VARCHAR2 DEFAULT NULL,
        p_platform_name_ar  IN VARCHAR2 DEFAULT NULL,
        p_is_active         IN NUMBER DEFAULT NULL
    ) IS
    BEGIN

        UPDATE ph_erp_platform_lkp
            SET platform_name_en = CASE WHEN p_platform_name_en IS NOT NULL THEN TRIM(p_platform_name_en) ELSE platform_name_en END,
                platform_name_ar = CASE WHEN p_platform_name_ar IS NOT NULL THEN TRIM(p_platform_name_ar) ELSE platform_name_ar END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END
            WHERE platform_id = p_platform_id
                AND ((p_platform_name_en IS NOT NULL AND DECODE(platform_name_en, TRIM(p_platform_name_en), 0, 1) = 1)
                OR (p_platform_name_ar IS NOT NULL AND DECODE(platform_name_ar, TRIM(p_platform_name_ar), 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

    END do_update_platform;

    PROCEDURE do_delete_platform(p_platform_id IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_platform_lkp
            SET is_deleted = 1
            WHERE platform_id = p_platform_id
                AND is_deleted = 0;
    END do_delete_platform;

    PROCEDURE do_restore_platform(p_platform_id IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_platform_lkp
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL
            WHERE platform_id = p_platform_id;
    END do_restore_platform;

    PROCEDURE do_update_pricing_unit(
        p_pricing_unit_id       IN NUMBER,
        p_pricing_unit_name_en  IN VARCHAR2 DEFAULT NULL,
        p_pricing_unit_name_ar  IN VARCHAR2 DEFAULT NULL,
        p_is_active             IN NUMBER DEFAULT NULL
    ) IS
    BEGIN

        UPDATE ph_erp_pricing_unit_lkp
            SET pricing_unit_name_en = CASE WHEN p_pricing_unit_name_en IS NOT NULL THEN TRIM(p_pricing_unit_name_en) ELSE pricing_unit_name_en END,
                pricing_unit_name_ar = CASE WHEN p_pricing_unit_name_ar IS NOT NULL THEN TRIM(p_pricing_unit_name_ar) ELSE pricing_unit_name_ar END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END
            WHERE pricing_unit_id = p_pricing_unit_id
                AND ((p_pricing_unit_name_en IS NOT NULL AND DECODE(pricing_unit_name_en, TRIM(p_pricing_unit_name_en), 0, 1) = 1)
                OR (p_pricing_unit_name_ar IS NOT NULL AND DECODE(pricing_unit_name_ar, TRIM(p_pricing_unit_name_ar), 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

    END do_update_pricing_unit;

    PROCEDURE do_delete_pricing_unit(p_pricing_unit_id IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_pricing_unit_lkp
            SET is_deleted = 1
            WHERE pricing_unit_id = p_pricing_unit_id
                AND is_deleted = 0;
    END do_delete_pricing_unit;

    PROCEDURE do_restore_pricing_unit(p_pricing_unit_id IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_pricing_unit_lkp
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL
            WHERE pricing_unit_id = p_pricing_unit_id;
    END do_restore_pricing_unit;

    PROCEDURE do_update_payment_cycle(
        p_payment_cycle_id      IN NUMBER,
        p_payment_cycle_name_en IN VARCHAR2 DEFAULT NULL,
        p_payment_cycle_name_ar IN VARCHAR2 DEFAULT NULL,
        p_months_count          IN NUMBER DEFAULT NULL,
        p_is_active             IN NUMBER DEFAULT NULL
    ) IS
    BEGIN

        UPDATE ph_erp_payment_cycle_lkp
            SET payment_cycle_name_en = CASE WHEN p_payment_cycle_name_en IS NOT NULL THEN TRIM(p_payment_cycle_name_en) ELSE payment_cycle_name_en END,
                payment_cycle_name_ar = CASE WHEN p_payment_cycle_name_ar IS NOT NULL THEN TRIM(p_payment_cycle_name_ar) ELSE payment_cycle_name_ar END,
                months_count = CASE WHEN p_months_count IS NOT NULL THEN p_months_count ELSE months_count END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END
            WHERE payment_cycle_id = p_payment_cycle_id
                AND ((p_payment_cycle_name_en IS NOT NULL AND DECODE(payment_cycle_name_en, TRIM(p_payment_cycle_name_en), 0, 1) = 1)
                OR (p_payment_cycle_name_ar IS NOT NULL AND DECODE(payment_cycle_name_ar, TRIM(p_payment_cycle_name_ar), 0, 1) = 1)
                OR (p_months_count IS NOT NULL AND DECODE(months_count, p_months_count, 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

    END do_update_payment_cycle;

    PROCEDURE do_delete_payment_cycle(p_payment_cycle_id IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_payment_cycle_lkp
            SET is_deleted = 1
            WHERE payment_cycle_id = p_payment_cycle_id
                AND is_deleted = 0;
    END do_delete_payment_cycle;

    PROCEDURE do_restore_payment_cycle(p_payment_cycle_id IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_payment_cycle_lkp
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL
            WHERE payment_cycle_id = p_payment_cycle_id;
    END do_restore_payment_cycle;

    PROCEDURE do_update_product(
        p_product_id        IN NUMBER,
        p_product_name_en   IN VARCHAR2 DEFAULT NULL,
        p_product_name_ar   IN VARCHAR2 DEFAULT NULL,
        p_description_en    IN VARCHAR2 DEFAULT NULL,
        p_description_ar    IN VARCHAR2 DEFAULT NULL,
        p_is_active         IN NUMBER DEFAULT NULL,
        p_updated_by        IN NUMBER DEFAULT NULL
    ) IS
    BEGIN

        UPDATE ph_erp_products
            SET product_name_en = CASE WHEN p_product_name_en IS NOT NULL THEN TRIM(p_product_name_en) ELSE product_name_en END,
                product_name_ar = CASE WHEN p_product_name_ar IS NOT NULL THEN TRIM(p_product_name_ar) ELSE product_name_ar END,
                description_en = CASE WHEN p_description_en IS NOT NULL THEN p_description_en ELSE description_en END,
                description_ar = CASE WHEN p_description_ar IS NOT NULL THEN p_description_ar ELSE description_ar END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND ((p_product_name_en IS NOT NULL AND DECODE(product_name_en, TRIM(p_product_name_en), 0, 1) = 1)
                OR (p_product_name_ar IS NOT NULL AND DECODE(product_name_ar, TRIM(p_product_name_ar), 0, 1) = 1)
                OR (p_description_en IS NOT NULL AND DECODE(description_en, p_description_en, 0, 1) = 1)
                OR (p_description_ar IS NOT NULL AND DECODE(description_ar, p_description_ar, 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

    END do_update_product;

    PROCEDURE do_delete_product(p_product_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_features
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id;

        UPDATE ph_erp_module_platforms
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id;

        UPDATE ph_erp_modules
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id;

        UPDATE ph_erp_products
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND is_deleted = 0;
    END do_delete_product;

    PROCEDURE do_restore_product(p_product_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_products
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by
            WHERE product_id = p_product_id;
    END do_restore_product;

    PROCEDURE do_update_module(
        p_product_id       IN NUMBER,
        p_module_id        IN NUMBER,
        p_module_name_en   IN VARCHAR2 DEFAULT NULL,
        p_module_name_ar   IN VARCHAR2 DEFAULT NULL,
        p_description_en   IN VARCHAR2 DEFAULT NULL,
        p_description_ar   IN VARCHAR2 DEFAULT NULL,
        p_display_order    IN NUMBER DEFAULT NULL,
        p_is_active        IN NUMBER DEFAULT NULL,
        p_updated_by       IN NUMBER DEFAULT NULL
    ) IS
    BEGIN

        UPDATE ph_erp_modules
            SET module_name_en = CASE WHEN p_module_name_en IS NOT NULL THEN TRIM(p_module_name_en) ELSE module_name_en END,
                module_name_ar = CASE WHEN p_module_name_ar IS NOT NULL THEN TRIM(p_module_name_ar) ELSE module_name_ar END,
                description_en = CASE WHEN p_description_en IS NOT NULL THEN p_description_en ELSE description_en END,
                description_ar = CASE WHEN p_description_ar IS NOT NULL THEN p_description_ar ELSE description_ar END,
                display_order = CASE WHEN p_display_order IS NOT NULL THEN p_display_order ELSE display_order END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND ((p_module_name_en IS NOT NULL AND DECODE(module_name_en, TRIM(p_module_name_en), 0, 1) = 1)
                OR (p_module_name_ar IS NOT NULL AND DECODE(module_name_ar, TRIM(p_module_name_ar), 0, 1) = 1)
                OR (p_description_en IS NOT NULL AND DECODE(description_en, p_description_en, 0, 1) = 1)
                OR (p_description_ar IS NOT NULL AND DECODE(description_ar, p_description_ar, 0, 1) = 1)
                OR (p_display_order IS NOT NULL AND DECODE(display_order, p_display_order, 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

    END do_update_module;

    PROCEDURE do_delete_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_features
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id;

        UPDATE ph_erp_module_platforms
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id;

        UPDATE ph_erp_modules
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND is_deleted = 0;
    END do_delete_module;

    PROCEDURE do_restore_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_modules
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id;
    END do_restore_module;

    PROCEDURE do_update_module_platform(
        p_product_id    IN NUMBER,
        p_module_id     IN NUMBER,
        p_platform_id   IN NUMBER,
        p_is_active     IN NUMBER DEFAULT NULL,
        p_updated_by    IN NUMBER DEFAULT NULL
    ) IS
    BEGIN

        UPDATE ph_erp_module_platforms
            SET is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1);
    END do_update_module_platform;

    PROCEDURE do_delete_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_features
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id;

        UPDATE ph_erp_module_platforms
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND is_deleted = 0;
    END do_delete_module_platform;

    PROCEDURE do_restore_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_module_platforms
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id;
    END do_restore_module_platform;

    PROCEDURE do_update_feature(
        p_product_id       IN NUMBER,
        p_module_id        IN NUMBER,
        p_platform_id      IN NUMBER,
        p_feature_id       IN NUMBER,
        p_feature_name_en  IN VARCHAR2 DEFAULT NULL,
        p_feature_name_ar  IN VARCHAR2 DEFAULT NULL,
        p_description_en   IN VARCHAR2 DEFAULT NULL,
        p_description_ar   IN VARCHAR2 DEFAULT NULL,
        p_price            IN NUMBER DEFAULT NULL,
        p_pricing_unit_id  IN NUMBER DEFAULT NULL,
        p_usage_unit       IN VARCHAR2 DEFAULT NULL,
        p_display_order    IN NUMBER DEFAULT NULL,
        p_is_active        IN NUMBER DEFAULT NULL,
        p_updated_by       IN NUMBER DEFAULT NULL
    ) IS
    BEGIN

        UPDATE ph_erp_features
            SET feature_name_en = CASE WHEN p_feature_name_en IS NOT NULL THEN TRIM(p_feature_name_en) ELSE feature_name_en END,
                feature_name_ar = CASE WHEN p_feature_name_ar IS NOT NULL THEN TRIM(p_feature_name_ar) ELSE feature_name_ar END,
                description_en = CASE WHEN p_description_en IS NOT NULL THEN p_description_en ELSE description_en END,
                description_ar = CASE WHEN p_description_ar IS NOT NULL THEN p_description_ar ELSE description_ar END,
                price = CASE WHEN p_price IS NOT NULL THEN p_price ELSE price END,
                pricing_unit_id = CASE WHEN p_pricing_unit_id IS NOT NULL THEN p_pricing_unit_id ELSE pricing_unit_id END,
                usage_unit = CASE WHEN p_usage_unit IS NOT NULL THEN TRIM(p_usage_unit) ELSE usage_unit END,
                display_order = CASE WHEN p_display_order IS NOT NULL THEN p_display_order ELSE display_order END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND feature_id = p_feature_id
                AND ((p_feature_name_en IS NOT NULL AND DECODE(feature_name_en, TRIM(p_feature_name_en), 0, 1) = 1)
                OR (p_feature_name_ar IS NOT NULL AND DECODE(feature_name_ar, TRIM(p_feature_name_ar), 0, 1) = 1)
                OR (p_description_en IS NOT NULL AND DECODE(description_en, p_description_en, 0, 1) = 1)
                OR (p_description_ar IS NOT NULL AND DECODE(description_ar, p_description_ar, 0, 1) = 1)
                OR (p_price IS NOT NULL AND DECODE(price, p_price, 0, 1) = 1)
                OR (p_pricing_unit_id IS NOT NULL AND DECODE(pricing_unit_id, p_pricing_unit_id, 0, 1) = 1)
                OR (p_usage_unit IS NOT NULL AND DECODE(usage_unit, TRIM(p_usage_unit), 0, 1) = 1)
                OR (p_display_order IS NOT NULL AND DECODE(display_order, p_display_order, 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

    END do_update_feature;

    PROCEDURE do_delete_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_features
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND feature_id = p_feature_id
                AND is_deleted = 0;
    END do_delete_feature;

    PROCEDURE do_restore_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_features
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND feature_id = p_feature_id;
    END do_restore_feature;

    ----------------------------------------------------------------------
    -- Read implementations
    ----------------------------------------------------------------------
    FUNCTION get_platforms(p_platform_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT platform_id,
        platform_name_en,
        platform_name_ar,
        is_active,
        created_by,
        created_at,
        updated_by,
        updated_at
            FROM ph_erp_platform_lkp
            WHERE (p_platform_id IS NULL OR platform_id = p_platform_id)
                AND (p_is_active IS NULL OR is_active = p_is_active)
                AND is_deleted = 0
            ORDER BY platform_name_en, platform_id;
        RETURN l_result;
    END get_platforms;

    FUNCTION get_pricing_units(p_pricing_unit_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT pricing_unit_id,
        pricing_unit_name_en,
        pricing_unit_name_ar,
        is_active,
        created_by,
        created_at,
        updated_by,
        updated_at
            FROM ph_erp_pricing_unit_lkp
            WHERE (p_pricing_unit_id IS NULL OR pricing_unit_id = p_pricing_unit_id)
                AND (p_is_active IS NULL OR is_active = p_is_active)
                AND is_deleted = 0
            ORDER BY pricing_unit_name_en, pricing_unit_id;
        RETURN l_result;
    END get_pricing_units;

    FUNCTION get_payment_cycles(p_payment_cycle_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT payment_cycle_id,
        payment_cycle_name_en,
        payment_cycle_name_ar,
        months_count,
        is_active,
        created_by,
        created_at,
        updated_by,
        updated_at
            FROM ph_erp_payment_cycle_lkp
            WHERE (p_payment_cycle_id IS NULL OR payment_cycle_id = p_payment_cycle_id)
                AND (p_is_active IS NULL OR is_active = p_is_active)
                AND is_deleted = 0
            ORDER BY months_count, payment_cycle_name_en, payment_cycle_id;
        RETURN l_result;
    END get_payment_cycles;

    FUNCTION get_products(p_product_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT product_id,
        product_name_en,
        product_name_ar,
        description_en,
        description_ar,
        is_active,
        created_by,
        created_at,
        updated_by,
        updated_at
            FROM ph_erp_products
            WHERE (p_product_id IS NULL OR product_id = p_product_id)
                AND (p_is_active IS NULL OR is_active = p_is_active)
                AND is_deleted = 0
            ORDER BY product_name_en, product_id;
        RETURN l_result;
    END get_products;

    FUNCTION get_modules(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT m.product_id,
        p.product_name_en,
        p.product_name_ar,
        m.module_id,
        m.module_name_en,
        m.module_name_ar,
        m.description_en,
        m.description_ar,
        m.display_order,
        m.is_active,
        m.created_by,
        m.created_at,
        m.updated_by,
        m.updated_at
            FROM ph_erp_modules m
        JOIN ph_erp_products p
            ON p.product_id = m.product_id
            WHERE (p_product_id IS NULL OR m.product_id = p_product_id)
                AND (p_module_id IS NULL OR m.module_id = p_module_id)
                AND (p_is_active IS NULL OR m.is_active = p_is_active)
                AND m.is_deleted = 0
                AND p.is_deleted = 0
            ORDER BY m.product_id, m.display_order, m.module_name_en, m.module_id;
        RETURN l_result;
    END get_modules;

    FUNCTION get_module_platforms(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT mp.product_id,
        p.product_name_en,
        p.product_name_ar,
        mp.module_id,
        m.module_name_en,
        m.module_name_ar,
        mp.platform_id,
        pl.platform_name_en,
        pl.platform_name_ar,
        mp.is_active,
        mp.created_by,
        mp.created_at,
        mp.updated_by,
        mp.updated_at
            FROM ph_erp_module_platforms mp
        JOIN ph_erp_products p
            ON p.product_id = mp.product_id
        JOIN ph_erp_modules m
            ON m.product_id = mp.product_id
                AND m.module_id = mp.module_id
        JOIN ph_erp_platform_lkp pl
            ON pl.platform_id = mp.platform_id
            WHERE (p_product_id IS NULL OR mp.product_id = p_product_id)
                AND (p_module_id IS NULL OR mp.module_id = p_module_id)
                AND (p_platform_id IS NULL OR mp.platform_id = p_platform_id)
                AND (p_is_active IS NULL OR mp.is_active = p_is_active)
                AND mp.is_deleted = 0
                AND p.is_deleted = 0
                AND m.is_deleted = 0
                AND pl.is_deleted = 0
            ORDER BY mp.product_id, mp.module_id, pl.platform_name_en, mp.platform_id;
        RETURN l_result;
    END get_module_platforms;

    FUNCTION get_features(p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_feature_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT f.product_id,
        p.product_name_en,
        p.product_name_ar,
        f.module_id,
        m.module_name_en,
        m.module_name_ar,
        f.platform_id,
        pl.platform_name_en,
        pl.platform_name_ar,
        f.feature_id,
        f.feature_name_en,
        f.feature_name_ar,
        f.description_en,
        f.description_ar,
        f.price,
        f.pricing_unit_id,
        pu.pricing_unit_name_en,
        pu.pricing_unit_name_ar,
        f.usage_unit,
        f.display_order,
        f.is_active,
        f.created_by,
        f.created_at,
        f.updated_by,
        f.updated_at
            FROM ph_erp_features f
        JOIN ph_erp_products p
            ON p.product_id = f.product_id
        JOIN ph_erp_modules m
            ON m.product_id = f.product_id
                AND m.module_id = f.module_id
        JOIN ph_erp_platform_lkp pl
            ON pl.platform_id = f.platform_id
        JOIN ph_erp_pricing_unit_lkp pu
            ON pu.pricing_unit_id = f.pricing_unit_id
            WHERE (p_product_id IS NULL OR f.product_id = p_product_id)
                AND (p_module_id IS NULL OR f.module_id = p_module_id)
                AND (p_platform_id IS NULL OR f.platform_id = p_platform_id)
                AND (p_feature_id IS NULL OR f.feature_id = p_feature_id)
                AND (p_is_active IS NULL OR f.is_active = p_is_active)
                AND f.is_deleted = 0
                AND p.is_deleted = 0
                AND m.is_deleted = 0
                AND pl.is_deleted = 0
                AND pu.is_deleted = 0
            ORDER BY f.product_id, f.module_id, f.platform_id, f.display_order, f.feature_name_en, f.feature_id;
        RETURN l_result;
    END get_features;

    PROCEDURE raise_when_invalid(p_is_valid IN NUMBER, p_validation_message IN VARCHAR2) IS
    BEGIN
        IF NVL(p_is_valid, 0) = 0 THEN
            RAISE_APPLICATION_ERROR(-20190, p_validation_message);
        END IF;
    END raise_when_invalid;

    ----------------------------------------------------------------------
    -- REST-friendly create/update/delete helper implementations
    ----------------------------------------------------------------------
    PROCEDURE message_update_platform(
        p_platform_id       IN  NUMBER,
        p_platform_name_en  IN  VARCHAR2 DEFAULT NULL,
        p_platform_name_ar  IN  VARCHAR2 DEFAULT NULL,
        p_is_active         IN  NUMBER DEFAULT NULL,
        p_message           OUT VARCHAR2
    ) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_update_platform(p_platform_id, p_platform_name_en, p_platform_name_ar, p_is_active, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_platform(p_platform_id, p_platform_name_en, p_platform_name_ar, p_is_active);
        p_message := ph_localization_pkg.localized_text('Platform updated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_update_platform;

    PROCEDURE message_delete_platform(p_platform_id IN NUMBER, p_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_delete_platform(p_platform_id, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_platform(p_platform_id);
        p_message := ph_localization_pkg.localized_text('Platform deactivated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_delete_platform;

    PROCEDURE message_update_pricing_unit(
        p_pricing_unit_id       IN  NUMBER,
        p_pricing_unit_name_en  IN  VARCHAR2 DEFAULT NULL,
        p_pricing_unit_name_ar  IN  VARCHAR2 DEFAULT NULL,
        p_is_active             IN  NUMBER DEFAULT NULL,
        p_message               OUT VARCHAR2
    ) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_update_pricing_unit(p_pricing_unit_id, p_pricing_unit_name_en, p_pricing_unit_name_ar, p_is_active, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_pricing_unit(p_pricing_unit_id, p_pricing_unit_name_en, p_pricing_unit_name_ar, p_is_active);
        p_message := ph_localization_pkg.localized_text('Pricing unit updated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_update_pricing_unit;

    PROCEDURE message_delete_pricing_unit(p_pricing_unit_id IN NUMBER, p_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_delete_pricing_unit(p_pricing_unit_id, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_pricing_unit(p_pricing_unit_id);
        p_message := ph_localization_pkg.localized_text('Pricing unit deactivated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_delete_pricing_unit;

    PROCEDURE message_update_payment_cycle(
        p_payment_cycle_id      IN  NUMBER,
        p_payment_cycle_name_en IN  VARCHAR2 DEFAULT NULL,
        p_payment_cycle_name_ar IN  VARCHAR2 DEFAULT NULL,
        p_months_count          IN  NUMBER DEFAULT NULL,
        p_is_active             IN  NUMBER DEFAULT NULL,
        p_message               OUT VARCHAR2
    ) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_update_payment_cycle(p_payment_cycle_id, p_payment_cycle_name_en, p_payment_cycle_name_ar, p_months_count, p_is_active, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_payment_cycle(p_payment_cycle_id, p_payment_cycle_name_en, p_payment_cycle_name_ar, p_months_count, p_is_active);
        p_message := ph_localization_pkg.localized_text('Payment cycle updated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_update_payment_cycle;

    PROCEDURE message_delete_payment_cycle(p_payment_cycle_id IN NUMBER, p_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_delete_payment_cycle(p_payment_cycle_id, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_payment_cycle(p_payment_cycle_id);
        p_message := ph_localization_pkg.localized_text('Payment cycle deactivated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_delete_payment_cycle;

    PROCEDURE message_update_product(
        p_product_id        IN  NUMBER,
        p_product_name_en   IN  VARCHAR2 DEFAULT NULL,
        p_product_name_ar   IN  VARCHAR2 DEFAULT NULL,
        p_description_en    IN  VARCHAR2 DEFAULT NULL,
        p_description_ar    IN  VARCHAR2 DEFAULT NULL,
        p_is_active         IN  NUMBER DEFAULT NULL,
        p_updated_by        IN  NUMBER DEFAULT NULL,
        p_message           OUT VARCHAR2
    ) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_update_product(p_product_id, p_product_name_en, p_product_name_ar, p_description_en, p_description_ar, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_product(p_product_id, p_product_name_en, p_product_name_ar, p_description_en, p_description_ar, p_is_active, p_updated_by);
        p_message := ph_localization_pkg.localized_text('Product updated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_update_product;

    PROCEDURE message_delete_product(p_product_id IN NUMBER, p_updated_by IN NUMBER, p_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_delete_product(p_product_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_product(p_product_id, p_updated_by);
        p_message := ph_localization_pkg.localized_text('Product and related catalog entries deactivated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_delete_product;

    PROCEDURE message_update_module(
        p_product_id       IN  NUMBER,
        p_module_id        IN  NUMBER,
        p_module_name_en   IN  VARCHAR2 DEFAULT NULL,
        p_module_name_ar   IN  VARCHAR2 DEFAULT NULL,
        p_description_en   IN  VARCHAR2 DEFAULT NULL,
        p_description_ar   IN  VARCHAR2 DEFAULT NULL,
        p_display_order    IN  NUMBER DEFAULT NULL,
        p_is_active        IN  NUMBER DEFAULT NULL,
        p_updated_by       IN  NUMBER DEFAULT NULL,
        p_message          OUT VARCHAR2
    ) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_update_module(p_product_id, p_module_id, p_module_name_en, p_module_name_ar, p_description_en, p_description_ar, p_display_order, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_module(p_product_id, p_module_id, p_module_name_en, p_module_name_ar, p_description_en, p_description_ar, p_display_order, p_is_active, p_updated_by);
        p_message := ph_localization_pkg.localized_text('Module updated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_update_module;

    PROCEDURE message_delete_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, p_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_delete_module(p_product_id, p_module_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_module(p_product_id, p_module_id, p_updated_by);
        p_message := ph_localization_pkg.localized_text('Module and related platforms/features deactivated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_delete_module;

    PROCEDURE message_update_module_platform(
        p_product_id    IN  NUMBER,
        p_module_id     IN  NUMBER,
        p_platform_id   IN  NUMBER,
        p_is_active     IN  NUMBER DEFAULT NULL,
        p_updated_by    IN  NUMBER DEFAULT NULL,
        p_message       OUT VARCHAR2
    ) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_update_module_platform(p_product_id, p_module_id, p_platform_id, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_module_platform(p_product_id, p_module_id, p_platform_id, p_is_active, p_updated_by);
        p_message := ph_localization_pkg.localized_text('Module platform updated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_update_module_platform;

    PROCEDURE message_delete_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER, p_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_delete_module_platform(p_product_id, p_module_id, p_platform_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_module_platform(p_product_id, p_module_id, p_platform_id, p_updated_by);
        p_message := ph_localization_pkg.localized_text('Module platform and related features deactivated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_delete_module_platform;

    PROCEDURE message_update_feature(
        p_product_id       IN  NUMBER,
        p_module_id        IN  NUMBER,
        p_platform_id      IN  NUMBER,
        p_feature_id       IN  NUMBER,
        p_feature_name_en  IN  VARCHAR2 DEFAULT NULL,
        p_feature_name_ar  IN  VARCHAR2 DEFAULT NULL,
        p_description_en   IN  VARCHAR2 DEFAULT NULL,
        p_description_ar   IN  VARCHAR2 DEFAULT NULL,
        p_price            IN  NUMBER DEFAULT NULL,
        p_pricing_unit_id  IN  NUMBER DEFAULT NULL,
        p_usage_unit       IN  VARCHAR2 DEFAULT NULL,
        p_display_order    IN  NUMBER DEFAULT NULL,
        p_is_active        IN  NUMBER DEFAULT NULL,
        p_updated_by       IN  NUMBER DEFAULT NULL,
        p_message          OUT VARCHAR2
    ) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_update_feature(p_product_id, p_module_id, p_platform_id, p_feature_id, p_feature_name_en, p_feature_name_ar, p_description_en, p_description_ar, p_price, p_pricing_unit_id, p_usage_unit, p_display_order, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_feature(p_product_id, p_module_id, p_platform_id, p_feature_id, p_feature_name_en, p_feature_name_ar, p_description_en, p_description_ar, p_price, p_pricing_unit_id, p_usage_unit, p_display_order, p_is_active, p_updated_by);
        p_message := ph_localization_pkg.localized_text('Feature updated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_update_feature;

    PROCEDURE message_delete_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, p_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_delete_feature(p_product_id, p_module_id, p_platform_id, p_feature_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_feature(p_product_id, p_module_id, p_platform_id, p_feature_id, p_updated_by);
        p_message := ph_localization_pkg.localized_text('Feature deactivated successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.');
    END message_delete_feature;

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
    BEGIN
        p_result_code := CASE WHEN SQLCODE BETWEEN -20999 AND -20000 THEN 'V' ELSE 'E' END;
        p_result_message := SQLERRM;
    END set_error;

    PROCEDURE create_platform(p_platform_name_en IN VARCHAR2, p_platform_name_ar IN VARCHAR2, p_platform_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_create_platform(p_platform_name_en, p_platform_name_ar, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        INSERT INTO ph_erp_platform_lkp (platform_name_en, platform_name_ar, is_active, created_by)
            VALUES (TRIM(p_platform_name_en), TRIM(p_platform_name_ar), 1, 1)
            RETURNING platform_id INTO p_platform_id;

        set_success(p_result_code, p_result_message, ph_localization_pkg.localized_text('Platform created successfully.', 'ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½ï؟½ ï؟½ï؟½ï؟½ï؟½ï؟½.'));
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_platform;

    PROCEDURE update_platform(p_platform_id IN NUMBER, p_platform_name_en IN VARCHAR2 DEFAULT NULL, p_platform_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_update_platform(p_platform_id, p_platform_name_en, p_platform_name_ar, p_is_active, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_platform;

    PROCEDURE delete_platform(p_platform_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_delete_platform(p_platform_id, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_platform;

    PROCEDURE restore_platform(p_platform_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_restore_platform(p_platform_id, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_platform(p_platform_id);
        set_success(p_result_code, p_result_message, 'Platform restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_platform;

    PROCEDURE create_pricing_unit(p_pricing_unit_name_en IN VARCHAR2, p_pricing_unit_name_ar IN VARCHAR2, p_pricing_unit_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_create_pricing_unit(p_pricing_unit_name_en, p_pricing_unit_name_ar, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        INSERT INTO ph_erp_pricing_unit_lkp (pricing_unit_name_en, pricing_unit_name_ar, is_active, created_by)
            VALUES (TRIM(p_pricing_unit_name_en), TRIM(p_pricing_unit_name_ar), 1, 1)
            RETURNING pricing_unit_id INTO p_pricing_unit_id;

        set_success(p_result_code, p_result_message, ph_localization_pkg.localized_text('Pricing unit created successfully.', 'Pricing unit created successfully.'));
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_pricing_unit;

    PROCEDURE update_pricing_unit(p_pricing_unit_id IN NUMBER, p_pricing_unit_name_en IN VARCHAR2 DEFAULT NULL, p_pricing_unit_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_update_pricing_unit(p_pricing_unit_id, p_pricing_unit_name_en, p_pricing_unit_name_ar, p_is_active, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_pricing_unit;

    PROCEDURE delete_pricing_unit(p_pricing_unit_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_delete_pricing_unit(p_pricing_unit_id, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_pricing_unit;

    PROCEDURE restore_pricing_unit(p_pricing_unit_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_restore_pricing_unit(p_pricing_unit_id, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_pricing_unit(p_pricing_unit_id);
        set_success(p_result_code, p_result_message, 'Pricing unit restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_pricing_unit;

    PROCEDURE create_payment_cycle(p_payment_cycle_name_en IN VARCHAR2, p_payment_cycle_name_ar IN VARCHAR2, p_months_count IN NUMBER, p_payment_cycle_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_create_payment_cycle(p_payment_cycle_name_en, p_payment_cycle_name_ar, p_months_count, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        INSERT INTO ph_erp_payment_cycle_lkp (payment_cycle_name_en, payment_cycle_name_ar, months_count, is_active, created_by)
            VALUES (TRIM(p_payment_cycle_name_en), TRIM(p_payment_cycle_name_ar), p_months_count, 1, 1)
            RETURNING payment_cycle_id INTO p_payment_cycle_id;

        set_success(p_result_code, p_result_message, ph_localization_pkg.localized_text('Payment cycle created successfully.', 'Payment cycle created successfully.'));
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_payment_cycle;

    PROCEDURE update_payment_cycle(p_payment_cycle_id IN NUMBER, p_payment_cycle_name_en IN VARCHAR2 DEFAULT NULL, p_payment_cycle_name_ar IN VARCHAR2 DEFAULT NULL, p_months_count IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_update_payment_cycle(p_payment_cycle_id, p_payment_cycle_name_en, p_payment_cycle_name_ar, p_months_count, p_is_active, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_payment_cycle;

    PROCEDURE delete_payment_cycle(p_payment_cycle_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_delete_payment_cycle(p_payment_cycle_id, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_payment_cycle;

    PROCEDURE restore_payment_cycle(p_payment_cycle_id IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_restore_payment_cycle(p_payment_cycle_id, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_payment_cycle(p_payment_cycle_id);
        set_success(p_result_code, p_result_message, 'Payment cycle restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_payment_cycle;

    PROCEDURE create_product(p_product_name_en IN VARCHAR2, p_product_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_product_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_create_product(p_product_name_en, p_product_name_ar, p_description_en, p_description_ar, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        INSERT INTO ph_erp_products (product_name_en, product_name_ar, description_en, description_ar, is_active, created_by)
            VALUES (TRIM(p_product_name_en), TRIM(p_product_name_ar), p_description_en, p_description_ar, 1, p_created_by)
            RETURNING product_id INTO p_product_id;

        set_success(p_result_code, p_result_message, ph_localization_pkg.localized_text('Product created successfully.', 'Product created successfully.'));
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_product;

    PROCEDURE update_product(p_product_id IN NUMBER, p_product_name_en IN VARCHAR2 DEFAULT NULL, p_product_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_update_product(p_product_id, p_product_name_en, p_product_name_ar, p_description_en, p_description_ar, p_is_active, p_updated_by, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_product;

    PROCEDURE delete_product(p_product_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_delete_product(p_product_id, p_updated_by, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_product;

    PROCEDURE restore_product(p_product_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_restore_product(p_product_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_product(p_product_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'Product restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_product;

    PROCEDURE create_module(p_product_id IN NUMBER, p_module_name_en IN VARCHAR2, p_module_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_module_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_create_module(p_product_id, p_module_name_en, p_module_name_ar, p_description_en, p_description_ar, p_display_order, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        INSERT INTO ph_erp_modules (
        product_id,
        module_id,
        module_name_en,
        module_name_ar,
        description_en,
        description_ar,
        display_order,
        is_active,
        created_by
        ) VALUES (
        p_product_id,
        NULL,
        TRIM(p_module_name_en),
        TRIM(p_module_name_ar),
        p_description_en,
        p_description_ar,
        NVL(p_display_order, 0),
        1,
        p_created_by
        ) RETURNING module_id INTO p_module_id;

        set_success(p_result_code, p_result_message, ph_localization_pkg.localized_text('Module created successfully.', 'Module created successfully.'));
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_module;

    PROCEDURE update_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_module_name_en IN VARCHAR2 DEFAULT NULL, p_module_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_update_module(p_product_id, p_module_id, p_module_name_en, p_module_name_ar, p_description_en, p_description_ar, p_display_order, p_is_active, p_updated_by, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_module;

    PROCEDURE delete_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_delete_module(p_product_id, p_module_id, p_updated_by, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_module;

    PROCEDURE restore_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_restore_module(p_product_id, p_module_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_module(p_product_id, p_module_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'Module restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_module;

    PROCEDURE create_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_create_module_platform(p_product_id, p_module_id, p_platform_id, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        MERGE INTO ph_erp_module_platforms target
            USING (
        SELECT p_product_id product_id,
        p_module_id module_id,
        p_platform_id platform_id
            FROM dual
        ) source
            ON (target.product_id = source.product_id
                AND target.module_id = source.module_id
                AND target.platform_id = source.platform_id)
            WHEN MATCHED THEN
        UPDATE SET
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = p_created_by
            WHEN NOT MATCHED THEN
        INSERT (product_id, module_id, platform_id, is_active, created_by)
            VALUES (source.product_id, source.module_id, source.platform_id, 1, p_created_by);

        set_success(p_result_code, p_result_message, ph_localization_pkg.localized_text('Module platform created successfully.', 'Module platform created successfully.'));
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_module_platform;

    PROCEDURE update_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_update_module_platform(p_product_id, p_module_id, p_platform_id, p_is_active, p_updated_by, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_module_platform;

    PROCEDURE delete_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_delete_module_platform(p_product_id, p_module_id, p_platform_id, p_updated_by, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_module_platform;

    PROCEDURE restore_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_restore_module_platform(p_product_id, p_module_id, p_platform_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_module_platform(p_product_id, p_module_id, p_platform_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'Module platform restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_module_platform;

    PROCEDURE create_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_name_en IN VARCHAR2, p_feature_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_price IN NUMBER, p_pricing_unit_id IN NUMBER, p_usage_unit IN VARCHAR2 DEFAULT 'USE', p_display_order IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_feature_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_create_feature(p_product_id, p_module_id, p_platform_id, p_feature_name_en, p_feature_name_ar, p_description_en, p_description_ar, p_price, p_pricing_unit_id, p_usage_unit, p_display_order, p_created_by, l_is_valid, l_validation_message);
        IF l_is_valid = 0 THEN
            set_validation_error(p_result_code, p_result_message, l_validation_message);
            RETURN;
        END IF;

        INSERT INTO ph_erp_features (
        product_id,
        module_id,
        platform_id,
        feature_id,
        feature_name_en,
        feature_name_ar,
        description_en,
        description_ar,
        price,
        pricing_unit_id,
        usage_unit,
        display_order,
        is_active,
        created_by
        ) VALUES (
        p_product_id,
        p_module_id,
        p_platform_id,
        NULL,
        TRIM(p_feature_name_en),
        TRIM(p_feature_name_ar),
        p_description_en,
        p_description_ar,
        p_price,
        p_pricing_unit_id,
        NVL(TRIM(p_usage_unit), 'USE'),
        NVL(p_display_order, 0),
        1,
        p_created_by
        ) RETURNING feature_id INTO p_feature_id;

        set_success(p_result_code, p_result_message, ph_localization_pkg.localized_text('Feature created successfully.', 'Feature created successfully.'));
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_feature;

    PROCEDURE update_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_feature_name_en IN VARCHAR2 DEFAULT NULL, p_feature_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_price IN NUMBER DEFAULT NULL, p_pricing_unit_id IN NUMBER DEFAULT NULL, p_usage_unit IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_update_feature(p_product_id, p_module_id, p_platform_id, p_feature_id, p_feature_name_en, p_feature_name_ar, p_description_en, p_description_ar, p_price, p_pricing_unit_id, p_usage_unit, p_display_order, p_is_active, p_updated_by, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_feature;

    PROCEDURE delete_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        message_delete_feature(p_product_id, p_module_id, p_platform_id, p_feature_id, p_updated_by, p_result_message);
        p_result_code := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_feature;

    PROCEDURE restore_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_management_validation_pkg.validate_restore_feature(p_product_id, p_module_id, p_platform_id, p_feature_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_feature(p_product_id, p_module_id, p_platform_id, p_feature_id, p_updated_by);
        set_success(p_result_code, p_result_message, 'Feature restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_feature;
END ph_erp_management_pkg;
/

