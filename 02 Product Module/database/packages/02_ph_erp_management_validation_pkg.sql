/*
ProductHub Manager - ERP Management Validation Package
Target DBMS: Oracle Database 21c+

Purpose:
- Validation service layer for ph_erp_management_pkg actions.
- Each procedure returns o_is_valid as 1 or 0 and o_validation_message.
*/

CREATE OR REPLACE PACKAGE ph_erp_management_validation_pkg AS

    PROCEDURE validate_create_platform(p_platform_name_en IN VARCHAR2, p_platform_name_ar IN VARCHAR2, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_platform(p_platform_id IN NUMBER, p_platform_name_en IN VARCHAR2 DEFAULT NULL, p_platform_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_platform(p_platform_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_platform(p_platform_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_pricing_unit(p_pricing_unit_name_en IN VARCHAR2, p_pricing_unit_name_ar IN VARCHAR2, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_pricing_unit(p_pricing_unit_id IN NUMBER, p_pricing_unit_name_en IN VARCHAR2 DEFAULT NULL, p_pricing_unit_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_pricing_unit(p_pricing_unit_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_pricing_unit(p_pricing_unit_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_payment_cycle(p_payment_cycle_name_en IN VARCHAR2, p_payment_cycle_name_ar IN VARCHAR2, p_months_count IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_payment_cycle(p_payment_cycle_id IN NUMBER, p_payment_cycle_name_en IN VARCHAR2 DEFAULT NULL, p_payment_cycle_name_ar IN VARCHAR2 DEFAULT NULL, p_months_count IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_payment_cycle(p_payment_cycle_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_payment_cycle(p_payment_cycle_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_product(p_product_name_en IN VARCHAR2, p_product_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_product(p_product_id IN NUMBER, p_product_name_en IN VARCHAR2 DEFAULT NULL, p_product_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_product(p_product_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_product(p_product_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_module(p_product_id IN NUMBER, p_module_name_en IN VARCHAR2, p_module_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_module_name_en IN VARCHAR2 DEFAULT NULL, p_module_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_name_en IN VARCHAR2, p_feature_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_price IN NUMBER, p_pricing_unit_id IN NUMBER, p_usage_unit IN VARCHAR2 DEFAULT 'USE', p_display_order IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_feature_name_en IN VARCHAR2 DEFAULT NULL, p_feature_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_price IN NUMBER DEFAULT NULL, p_pricing_unit_id IN NUMBER DEFAULT NULL, p_usage_unit IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
END ph_erp_management_validation_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_erp_management_validation_pkg AS
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

    FUNCTION exists_platform(p_platform_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_platform_lkp
            WHERE platform_id = p_platform_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN yes_no(l_count);
    END exists_platform;

    FUNCTION exists_pricing_unit(p_pricing_unit_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_pricing_unit_lkp
            WHERE pricing_unit_id = p_pricing_unit_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN yes_no(l_count);
    END exists_pricing_unit;

    FUNCTION exists_payment_cycle(p_payment_cycle_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_payment_cycle_lkp
            WHERE payment_cycle_id = p_payment_cycle_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN yes_no(l_count);
    END exists_payment_cycle;

    FUNCTION exists_product(p_product_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_products
            WHERE product_id = p_product_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_product;

    FUNCTION exists_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_modules
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_module;

    FUNCTION exists_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_module_platforms
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN yes_no(l_count);
    END exists_module_platform;

    FUNCTION exists_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_features
            WHERE product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND feature_id = p_feature_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN yes_no(l_count);
    END exists_feature;

    FUNCTION active_platform(p_platform_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_platform_lkp
            WHERE platform_id = p_platform_id
                AND is_active = 1
                AND is_deleted = 0;
        RETURN yes_no(l_count);
    END active_platform;

    FUNCTION active_pricing_unit(p_pricing_unit_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_pricing_unit_lkp
            WHERE pricing_unit_id = p_pricing_unit_id
                AND is_active = 1
                AND is_deleted = 0;
        RETURN yes_no(l_count);
    END active_pricing_unit;

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

    FUNCTION duplicate_platform_name(p_platform_name_en IN VARCHAR2, p_platform_name_ar IN VARCHAR2, p_platform_id IN NUMBER DEFAULT NULL) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_platform_lkp
            WHERE is_deleted = 0
                AND (p_platform_id IS NULL OR platform_id <> p_platform_id)
                AND (UPPER(platform_name_en) = UPPER(TRIM(p_platform_name_en))
                OR UPPER(platform_name_ar) = UPPER(TRIM(p_platform_name_ar)));
        RETURN yes_no(l_count);
    END duplicate_platform_name;

    PROCEDURE validate_name_pair(
        p_name_en              IN VARCHAR2,
        p_name_ar              IN VARCHAR2,
        p_name_label_en        IN VARCHAR2,
        p_name_label_ar        IN VARCHAR2,
        p_max_length           IN NUMBER,
        o_is_valid             OUT NUMBER,
        o_validation_message   OUT VARCHAR2
    ) IS
    BEGIN
        IF text_missing(p_name_en) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text(p_name_label_en || ' English name is required.', p_name_label_en || ' English name is required.'));
        ELSIF text_missing(p_name_ar) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text(p_name_label_ar || ' Arabic name is required.', p_name_label_ar || ' Arabic name is required.'));
        ELSIF text_too_long(p_name_en, p_max_length) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text(p_name_label_en || ' English name must not exceed ' || p_max_length || ' characters.', p_name_label_en || ' English name must not exceed ' || p_max_length || ' characters.'));
        ELSIF text_too_long(p_name_ar, p_max_length) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text(p_name_label_ar || ' Arabic name must not exceed ' || p_max_length || ' characters.', p_name_label_ar || ' Arabic name must not exceed ' || p_max_length || ' characters.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_name_pair;

    PROCEDURE validate_optional_name_pair(
        p_name_en              IN VARCHAR2,
        p_name_ar              IN VARCHAR2,
        p_name_label_en        IN VARCHAR2,
        p_name_label_ar        IN VARCHAR2,
        p_max_length           IN NUMBER,
        o_is_valid             OUT NUMBER,
        o_validation_message   OUT VARCHAR2
    ) IS
    BEGIN
        IF text_too_long(p_name_en, p_max_length) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text(p_name_label_en || ' English name must not exceed ' || p_max_length || ' characters.', p_name_label_en || ' English name must not exceed ' || p_max_length || ' characters.'));
        ELSIF text_too_long(p_name_ar, p_max_length) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text(p_name_label_ar || ' Arabic name must not exceed ' || p_max_length || ' characters.', p_name_label_ar || ' Arabic name must not exceed ' || p_max_length || ' characters.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_optional_name_pair;

    PROCEDURE validate_create_platform(p_platform_name_en IN VARCHAR2, p_platform_name_ar IN VARCHAR2, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        validate_name_pair(p_platform_name_en, p_platform_name_ar, 'Platform', 'Platform', 100, o_is_valid, o_validation_message);
        IF o_is_valid = 1 AND duplicate_platform_name(p_platform_name_en, p_platform_name_ar) = 1 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Platform name already exists.', 'Platform name already exists.'));
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            set_invalid(o_is_valid, o_validation_message, SQLERRM);
    END validate_create_platform;

    PROCEDURE validate_update_platform(p_platform_id IN NUMBER, p_platform_name_en IN VARCHAR2 DEFAULT NULL, p_platform_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_platform(p_platform_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Platform was not found.', 'Platform was not found.'));
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Active flag must be 0 or 1.', 'Active flag must be 0 or 1.'));
        ELSE
            validate_optional_name_pair(p_platform_name_en, p_platform_name_ar, 'Platform', 'Platform', 100, o_is_valid, o_validation_message);
            IF o_is_valid = 1 AND (p_platform_name_en IS NOT NULL OR p_platform_name_ar IS NOT NULL) AND duplicate_platform_name(COALESCE(p_platform_name_en, CHR(0)), COALESCE(p_platform_name_ar, CHR(0)), p_platform_id) = 1 THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Platform name already exists.', 'Platform name already exists.'));
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            set_invalid(o_is_valid, o_validation_message, SQLERRM);
    END validate_update_platform;

    PROCEDURE validate_delete_platform(p_platform_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_platform(p_platform_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Platform was not found.', 'Platform was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_platform;

    PROCEDURE validate_restore_platform(p_platform_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_platform(p_platform_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Platform was not found.', 'Platform was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_platform;

    PROCEDURE validate_create_pricing_unit(p_pricing_unit_name_en IN VARCHAR2, p_pricing_unit_name_ar IN VARCHAR2, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        validate_name_pair(p_pricing_unit_name_en, p_pricing_unit_name_ar, 'Pricing unit', 'Pricing unit', 100, o_is_valid, o_validation_message);
    END validate_create_pricing_unit;

    PROCEDURE validate_update_pricing_unit(p_pricing_unit_id IN NUMBER, p_pricing_unit_name_en IN VARCHAR2 DEFAULT NULL, p_pricing_unit_name_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_pricing_unit(p_pricing_unit_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Pricing unit was not found.', 'Pricing unit was not found.'));
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Active flag must be 0 or 1.', 'Active flag must be 0 or 1.'));
        ELSE
            validate_optional_name_pair(p_pricing_unit_name_en, p_pricing_unit_name_ar, 'Pricing unit', 'Pricing unit', 100, o_is_valid, o_validation_message);
        END IF;
    END validate_update_pricing_unit;

    PROCEDURE validate_delete_pricing_unit(p_pricing_unit_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_pricing_unit(p_pricing_unit_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Pricing unit was not found.', 'Pricing unit was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_pricing_unit;

    PROCEDURE validate_restore_pricing_unit(p_pricing_unit_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_pricing_unit(p_pricing_unit_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Pricing unit was not found.', 'Pricing unit was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_pricing_unit;

    PROCEDURE validate_create_payment_cycle(p_payment_cycle_name_en IN VARCHAR2, p_payment_cycle_name_ar IN VARCHAR2, p_months_count IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        validate_name_pair(p_payment_cycle_name_en, p_payment_cycle_name_ar, 'Payment cycle', 'Payment cycle', 100, o_is_valid, o_validation_message);
        IF o_is_valid = 1 AND NVL(p_months_count, 0) <= 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Payment cycle months count must be greater than zero.', 'Payment cycle months count must be greater than zero.'));
        END IF;
    END validate_create_payment_cycle;

    PROCEDURE validate_update_payment_cycle(p_payment_cycle_id IN NUMBER, p_payment_cycle_name_en IN VARCHAR2 DEFAULT NULL, p_payment_cycle_name_ar IN VARCHAR2 DEFAULT NULL, p_months_count IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_payment_cycle(p_payment_cycle_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Payment cycle was not found.', 'Payment cycle was not found.'));
        ELSIF p_months_count IS NOT NULL AND p_months_count <= 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Payment cycle months count must be greater than zero.', 'Payment cycle months count must be greater than zero.'));
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Active flag must be 0 or 1.', 'Active flag must be 0 or 1.'));
        ELSE
            validate_optional_name_pair(p_payment_cycle_name_en, p_payment_cycle_name_ar, 'Payment cycle', 'Payment cycle', 100, o_is_valid, o_validation_message);
        END IF;
    END validate_update_payment_cycle;

    PROCEDURE validate_delete_payment_cycle(p_payment_cycle_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_payment_cycle(p_payment_cycle_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Payment cycle was not found.', 'Payment cycle was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_payment_cycle;

    PROCEDURE validate_restore_payment_cycle(p_payment_cycle_id IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(NULL, 'PLATFORM_SETUP', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_payment_cycle(p_payment_cycle_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Payment cycle was not found.', 'Payment cycle was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_payment_cycle;

    PROCEDURE validate_create_product(p_product_name_en IN VARCHAR2, p_product_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        validate_name_pair(p_product_name_en, p_product_name_ar, 'Product', 'Product', 200, o_is_valid, o_validation_message);
        IF o_is_valid = 1 AND (text_too_long(p_description_en, 1000) OR text_too_long(p_description_ar, 1000)) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Product description must not exceed 1000 characters.', 'Product description must not exceed 1000 characters.'));
        END IF;
    END validate_create_product;

    PROCEDURE validate_update_product(p_product_id IN NUMBER, p_product_name_en IN VARCHAR2 DEFAULT NULL, p_product_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_product(p_product_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Product was not found.', 'Product was not found.'));
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Active flag must be 0 or 1.', 'Active flag must be 0 or 1.'));
        ELSE
            validate_optional_name_pair(p_product_name_en, p_product_name_ar, 'Product', 'Product', 200, o_is_valid, o_validation_message);
            IF o_is_valid = 1 AND (text_too_long(p_description_en, 1000) OR text_too_long(p_description_ar, 1000)) THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Product description must not exceed 1000 characters.', 'Product description must not exceed 1000 characters.'));
            END IF;
        END IF;
    END validate_update_product;

    PROCEDURE validate_delete_product(p_product_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_product(p_product_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Product was not found.', 'Product was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_product;

    PROCEDURE validate_restore_product(p_product_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_product(p_product_id, 0, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Product was not found.', 'Product was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_product;

    PROCEDURE validate_create_module(p_product_id IN NUMBER, p_module_name_en IN VARCHAR2, p_module_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_product(p_product_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Product is not active or was not found.', 'Product is not active or was not found.'));
        ELSE
            validate_name_pair(p_module_name_en, p_module_name_ar, 'Module', 'Module', 200, o_is_valid, o_validation_message);
            IF o_is_valid = 1 AND (text_too_long(p_description_en, 1000) OR text_too_long(p_description_ar, 1000)) THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module description must not exceed 1000 characters.', 'Module description must not exceed 1000 characters.'));
            END IF;
        END IF;
    END validate_create_module;

    PROCEDURE validate_update_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_module_name_en IN VARCHAR2 DEFAULT NULL, p_module_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_module(p_product_id, p_module_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module was not found.', 'Module was not found.'));
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Active flag must be 0 or 1.', 'Active flag must be 0 or 1.'));
        ELSE
            validate_optional_name_pair(p_module_name_en, p_module_name_ar, 'Module', 'Module', 200, o_is_valid, o_validation_message);
            IF o_is_valid = 1 AND (text_too_long(p_description_en, 1000) OR text_too_long(p_description_ar, 1000)) THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module description must not exceed 1000 characters.', 'Module description must not exceed 1000 characters.'));
            END IF;
        END IF;
    END validate_update_module;

    PROCEDURE validate_delete_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_module(p_product_id, p_module_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module was not found.', 'Module was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_module;

    PROCEDURE validate_restore_module(p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_product(p_product_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Product is not active or was not found.', 'Product is not active or was not found.'));
        ELSIF exists_module(p_product_id, p_module_id, 0, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module was not found.', 'Module was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_module;

    PROCEDURE validate_create_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_module(p_product_id, p_module_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module is not active for the selected product.', 'Module is not active for the selected product.'));
        ELSIF active_platform(p_platform_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Platform is not active or was not found.', 'Platform is not active or was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_create_module_platform;

    PROCEDURE validate_update_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_module_platform(p_product_id, p_module_id, p_platform_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module platform was not found.', 'Module platform was not found.'));
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Active flag must be 0 or 1.', 'Active flag must be 0 or 1.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_update_module_platform;

    PROCEDURE validate_delete_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_module_platform(p_product_id, p_module_id, p_platform_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module platform was not found.', 'Module platform was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_module_platform;

    PROCEDURE validate_restore_module_platform(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_module(p_product_id, p_module_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module is not active for the selected product.', 'Module is not active for the selected product.'));
        ELSIF exists_module_platform(p_product_id, p_module_id, p_platform_id, 0, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module platform was not found.', 'Module platform was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_module_platform;

    PROCEDURE validate_create_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_name_en IN VARCHAR2, p_feature_name_ar IN VARCHAR2, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_price IN NUMBER, p_pricing_unit_id IN NUMBER, p_usage_unit IN VARCHAR2 DEFAULT 'USE', p_display_order IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_module_platform(p_product_id, p_module_id, p_platform_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module platform is not active for the selected product and module.', 'Module platform is not active for the selected product and module.'));
        ELSIF NVL(p_price, -1) < 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Feature price must be greater than or equal to zero.', 'Feature price must be greater than or equal to zero.'));
        ELSIF active_pricing_unit(p_pricing_unit_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Pricing unit is not active or was not found.', 'Pricing unit is not active or was not found.'));
        ELSE
            validate_name_pair(p_feature_name_en, p_feature_name_ar, 'Feature', 'Feature', 200, o_is_valid, o_validation_message);
            IF o_is_valid = 1 AND (text_too_long(p_description_en, 1000) OR text_too_long(p_description_ar, 1000) OR text_too_long(p_usage_unit, 50)) THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Feature text values exceed the allowed length.', 'Feature text values exceed the allowed length.'));
            END IF;
        END IF;
    END validate_create_feature;

    PROCEDURE validate_update_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_feature_name_en IN VARCHAR2 DEFAULT NULL, p_feature_name_ar IN VARCHAR2 DEFAULT NULL, p_description_en IN VARCHAR2 DEFAULT NULL, p_description_ar IN VARCHAR2 DEFAULT NULL, p_price IN NUMBER DEFAULT NULL, p_pricing_unit_id IN NUMBER DEFAULT NULL, p_usage_unit IN VARCHAR2 DEFAULT NULL, p_display_order IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_feature(p_product_id, p_module_id, p_platform_id, p_feature_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Feature was not found.', 'Feature was not found.'));
        ELSIF p_price IS NOT NULL AND p_price < 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Feature price must be greater than or equal to zero.', 'Feature price must be greater than or equal to zero.'));
        ELSIF p_pricing_unit_id IS NOT NULL AND active_pricing_unit(p_pricing_unit_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Pricing unit is not active or was not found.', 'Pricing unit is not active or was not found.'));
        ELSIF NOT valid_flag(p_is_active) THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Active flag must be 0 or 1.', 'Active flag must be 0 or 1.'));
        ELSE
            validate_optional_name_pair(p_feature_name_en, p_feature_name_ar, 'Feature', 'Feature', 200, o_is_valid, o_validation_message);
            IF o_is_valid = 1 AND (text_too_long(p_description_en, 1000) OR text_too_long(p_description_ar, 1000) OR text_too_long(p_usage_unit, 50)) THEN
                set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Feature text values exceed the allowed length.', 'Feature text values exceed the allowed length.'));
            END IF;
        END IF;
    END validate_update_feature;

    PROCEDURE validate_delete_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_feature(p_product_id, p_module_id, p_platform_id, p_feature_id) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Feature was not found.', 'Feature was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_feature;

    PROCEDURE validate_restore_feature(p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'PRODUCTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_module_platform(p_product_id, p_module_id, p_platform_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Module platform is not active for the selected product and module.', 'Module platform is not active for the selected product and module.'));
        ELSIF exists_feature(p_product_id, p_module_id, p_platform_id, p_feature_id, 1) = 0 THEN
            set_invalid(o_is_valid, o_validation_message, ph_localization_pkg.localized_text('Feature was not found.', 'Feature was not found.'));
        ELSE
            set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_feature;
END ph_erp_management_validation_pkg;
/


