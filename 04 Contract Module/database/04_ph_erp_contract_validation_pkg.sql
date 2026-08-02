/*
ProductHub Manager - Contract Validation Package
Target DBMS: Oracle Database 21c+

Purpose:
- Validation service layer for ph_erp_contract_pkg actions.
- Each procedure returns o_is_valid as 1 or 0 and o_validation_message.
*/

CREATE OR REPLACE PACKAGE ph_erp_contract_validation_pkg AS
    PROCEDURE log_error (
        p_program_unit            IN VARCHAR2,
        p_program_unit_parameters IN CLOB DEFAULT NULL,
        p_error_location          IN VARCHAR2 DEFAULT NULL,
        p_action_name             IN VARCHAR2 DEFAULT NULL,
        p_error_code              IN NUMBER DEFAULT NULL,
        p_error_message           IN VARCHAR2 DEFAULT NULL,
        p_error_stack             IN CLOB DEFAULT NULL,
        p_error_backtrace         IN CLOB DEFAULT NULL
    );

    PROCEDURE validate_create_contract(p_contract_no IN VARCHAR2, p_customer_id IN NUMBER, p_product_id IN NUMBER, p_start_date IN DATE, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_contract(p_contract_id IN NUMBER, p_contract_no IN VARCHAR2 DEFAULT NULL, p_customer_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_start_date IN DATE DEFAULT NULL, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER DEFAULT NULL, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_contract_url(p_contract_id IN NUMBER, p_access_url IN VARCHAR2, p_is_primary IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_contract_url(p_contract_url_id IN NUMBER, p_access_url IN VARCHAR2 DEFAULT NULL, p_is_primary IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT NULL, p_effective_to IN DATE DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT NULL, p_effective_to IN DATE DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
END ph_erp_contract_validation_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_erp_contract_validation_pkg AS
    PROCEDURE log_error (
        p_program_unit            IN VARCHAR2,
        p_program_unit_parameters IN CLOB DEFAULT NULL,
        p_error_location          IN VARCHAR2 DEFAULT NULL,
        p_action_name             IN VARCHAR2 DEFAULT NULL,
        p_error_code              IN NUMBER DEFAULT NULL,
        p_error_message           IN VARCHAR2 DEFAULT NULL,
        p_error_stack             IN CLOB DEFAULT NULL,
        p_error_backtrace         IN CLOB DEFAULT NULL
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO ph_erp_contract_error_log (
            program_unit,
            program_unit_parameters,
            error_location,
            error_code,
            error_message,
            error_stack,
            error_backtrace,
            call_stack,
            action_name
        ) VALUES (
            p_program_unit,
            p_program_unit_parameters,
            p_error_location,
            p_error_code,
            p_error_message,
            p_error_stack,
            p_error_backtrace,
            DBMS_UTILITY.FORMAT_CALL_STACK,
            p_action_name
        );

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
    END log_error;

    FUNCTION exists_contract(p_contract_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_contracts
            WHERE contract_id = p_contract_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN ph_helpers_pkg.yes_no(l_count);
    END exists_contract;

    FUNCTION exists_contract_url(p_contract_url_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_contract_urls
            WHERE contract_url_id = p_contract_url_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN ph_helpers_pkg.yes_no(l_count);
    END exists_contract_url;

    FUNCTION exists_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_contract_modules
            WHERE contract_id = p_contract_id
                AND product_id = p_product_id
                AND module_id = p_module_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN ph_helpers_pkg.yes_no(l_count);
    END exists_contract_module;

    FUNCTION exists_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_contract_features
            WHERE contract_id = p_contract_id
                AND product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND feature_id = p_feature_id
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN ph_helpers_pkg.yes_no(l_count);
    END exists_contract_feature;

    FUNCTION duplicate_contract_no(p_contract_no IN VARCHAR2, p_contract_id IN NUMBER DEFAULT NULL) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_contracts
            WHERE UPPER(contract_no) = UPPER(TRIM(p_contract_no))
                AND (p_contract_id IS NULL OR contract_id <> p_contract_id);
        RETURN ph_helpers_pkg.yes_no(l_count);
    END duplicate_contract_no;

    FUNCTION active_customer(p_customer_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_customers
            WHERE customer_id = p_customer_id
                AND is_active = 1
                AND is_deleted = 0;
        RETURN ph_helpers_pkg.yes_no(l_count);
    END active_customer;

    FUNCTION active_product(p_product_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_products
            WHERE product_id = p_product_id
                AND is_active = 1
                AND is_deleted = 0;
        RETURN ph_helpers_pkg.yes_no(l_count);
    END active_product;

    FUNCTION active_payment_cycle(p_payment_cycle IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_payment_cycle_lkp
            WHERE payment_cycle_id = p_payment_cycle
                AND is_active = 1
                AND is_deleted = 0;
        RETURN ph_helpers_pkg.yes_no(l_count);
    END active_payment_cycle;

    FUNCTION valid_module_for_contract(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_contracts c
            JOIN ph_erp_modules m
                ON m.product_id = c.product_id
            WHERE c.contract_id = p_contract_id
                AND c.product_id = p_product_id
                AND m.module_id = p_module_id
                AND c.is_active = 1
                AND m.is_active = 1
                AND c.is_deleted = 0
                AND m.is_deleted = 0;
        RETURN ph_helpers_pkg.yes_no(l_count);
    END valid_module_for_contract;

    FUNCTION valid_feature_for_contract(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_contracts c
            JOIN ph_erp_contract_modules cm
                ON cm.contract_id = c.contract_id
                AND cm.product_id = c.product_id
            JOIN ph_erp_features f
                ON f.product_id = cm.product_id
                AND f.module_id = cm.module_id
            WHERE c.contract_id = p_contract_id
                AND c.product_id = p_product_id
                AND cm.module_id = p_module_id
                AND f.platform_id = p_platform_id
                AND f.feature_id = p_feature_id
                AND c.is_active = 1
                AND cm.is_active = 1
                AND f.is_active = 1
                AND c.is_deleted = 0
                AND cm.is_deleted = 0
                AND f.is_deleted = 0;
        RETURN ph_helpers_pkg.yes_no(l_count);
    END valid_feature_for_contract;

    PROCEDURE validate_text_required(p_value IN VARCHAR2, p_label IN VARCHAR2, p_max_length IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_helpers_pkg.text_missing(p_value) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, p_label || ' is required.');
        ELSIF ph_helpers_pkg.text_too_long(p_value, p_max_length) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, p_label || ' must not exceed ' || p_max_length || ' characters.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_text_required;

    PROCEDURE validate_contract_dates(p_start_date IN DATE, p_end_date IN DATE, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF p_start_date IS NULL THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract start date is required.');
        ELSIF p_end_date IS NOT NULL AND p_end_date < p_start_date THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract end date cannot be before start date.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_contract_dates;

    PROCEDURE validate_effective_dates(p_effective_from IN DATE, p_effective_to IN DATE, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF p_effective_from IS NULL THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Effective from date is required.');
        ELSIF p_effective_to IS NOT NULL AND p_effective_to < p_effective_from THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Effective to date cannot be before effective from date.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_effective_dates;

    PROCEDURE validate_create_contract(p_contract_no IN VARCHAR2, p_customer_id IN NUMBER, p_product_id IN NUMBER, p_start_date IN DATE, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        validate_text_required(p_contract_no, 'Contract number', 80, o_is_valid, o_validation_message);
        IF o_is_valid = 0 THEN RETURN; END IF;

        IF duplicate_contract_no(p_contract_no) = 1 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract number already exists.');
        ELSIF active_customer(p_customer_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer is not active or was not found.');
        ELSIF active_product(p_product_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Product is not active or was not found.');
        ELSIF active_payment_cycle(p_payment_cycle) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Payment cycle is not active or was not found.');
        ELSIF ph_helpers_pkg.text_too_long(p_notes_en, 1000) OR ph_helpers_pkg.text_too_long(p_notes_ar, 1000) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract notes must not exceed 1000 characters.');
        ELSE
            validate_contract_dates(p_start_date, p_end_date, o_is_valid, o_validation_message);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, SQLERRM);
    END validate_create_contract;

    PROCEDURE validate_update_contract(p_contract_id IN NUMBER, p_contract_no IN VARCHAR2 DEFAULT NULL, p_customer_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_start_date IN DATE DEFAULT NULL, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER DEFAULT NULL, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
        l_start_date ph_erp_contracts.start_date%TYPE;
        l_end_date   ph_erp_contracts.end_date%TYPE;
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;
        IF exists_contract(p_contract_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract was not found.');
            RETURN;
        END IF;

        SELECT start_date, end_date
            INTO l_start_date, l_end_date
            FROM ph_erp_contracts
            WHERE contract_id = p_contract_id;

        IF p_contract_no IS NOT NULL AND ph_helpers_pkg.text_missing(p_contract_no) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract number is required.');
        ELSIF ph_helpers_pkg.text_too_long(p_contract_no, 80) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract number must not exceed 80 characters.');
        ELSIF p_contract_no IS NOT NULL AND duplicate_contract_no(p_contract_no, p_contract_id) = 1 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract number already exists.');
        ELSIF p_customer_id IS NOT NULL AND active_customer(p_customer_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer is not active or was not found.');
        ELSIF p_product_id IS NOT NULL AND active_product(p_product_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Product is not active or was not found.');
        ELSIF p_payment_cycle IS NOT NULL AND active_payment_cycle(p_payment_cycle) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Payment cycle is not active or was not found.');
        ELSIF ph_helpers_pkg.text_too_long(p_notes_en, 1000) OR ph_helpers_pkg.text_too_long(p_notes_ar, 1000) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract notes must not exceed 1000 characters.');
        ELSIF NOT ph_helpers_pkg.valid_flag(p_is_active) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Active flag must be 0 or 1.');
        ELSE
            validate_contract_dates(NVL(p_start_date, l_start_date), CASE WHEN p_end_date IS NOT NULL THEN p_end_date ELSE l_end_date END, o_is_valid, o_validation_message);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, SQLERRM);
    END validate_update_contract;

    PROCEDURE validate_delete_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract(p_contract_id) = 0 THEN ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract was not found.'); ELSE ph_helpers_pkg.set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_contract;

    PROCEDURE validate_restore_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract(p_contract_id, 0, 1) = 0 THEN ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract was not found.'); ELSE ph_helpers_pkg.set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_contract;

    PROCEDURE validate_create_contract_url(p_contract_id IN NUMBER, p_access_url IN VARCHAR2, p_is_primary IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract(p_contract_id, 1) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Active contract was not found.');
        ELSIF NOT ph_helpers_pkg.valid_flag(p_is_primary) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Primary URL flag must be 0 or 1.');
        ELSE
            validate_text_required(p_access_url, 'Contract access URL', 1000, o_is_valid, o_validation_message);
        END IF;
    END validate_create_contract_url;

    PROCEDURE validate_update_contract_url(p_contract_url_id IN NUMBER, p_access_url IN VARCHAR2 DEFAULT NULL, p_is_primary IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract_url(p_contract_url_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract URL was not found.');
        ELSIF p_access_url IS NOT NULL AND ph_helpers_pkg.text_missing(p_access_url) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract access URL is required.');
        ELSIF ph_helpers_pkg.text_too_long(p_access_url, 1000) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract access URL must not exceed 1000 characters.');
        ELSIF NOT ph_helpers_pkg.valid_flag(p_is_primary) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Primary URL flag must be 0 or 1.');
        ELSIF NOT ph_helpers_pkg.valid_flag(p_is_active) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Active flag must be 0 or 1.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_update_contract_url;

    PROCEDURE validate_delete_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract_url(p_contract_url_id) = 0 THEN ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract URL was not found.'); ELSE ph_helpers_pkg.set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_contract_url;

    PROCEDURE validate_restore_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract_url(p_contract_url_id, 1) = 0 THEN ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract URL was not found.'); ELSE ph_helpers_pkg.set_valid(o_is_valid, o_validation_message); END IF;
    END validate_restore_contract_url;

    PROCEDURE validate_create_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF valid_module_for_contract(p_contract_id, p_product_id, p_module_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Module is not valid for the selected contract.');
        ELSE
            validate_effective_dates(p_effective_from, p_effective_to, o_is_valid, o_validation_message);
        END IF;
    END validate_create_contract_module;

    PROCEDURE validate_update_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT NULL, p_effective_to IN DATE DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
        l_effective_from ph_erp_contract_modules.effective_from%TYPE;
        l_effective_to   ph_erp_contract_modules.effective_to%TYPE;
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract_module(p_contract_id, p_product_id, p_module_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract module was not found.');
            RETURN;
        END IF;
        SELECT effective_from, effective_to INTO l_effective_from, l_effective_to FROM ph_erp_contract_modules WHERE contract_id = p_contract_id AND product_id = p_product_id AND module_id = p_module_id;
        IF NOT ph_helpers_pkg.valid_flag(p_is_active) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Active flag must be 0 or 1.');
        ELSE
            validate_effective_dates(NVL(p_effective_from, l_effective_from), CASE WHEN p_effective_to IS NOT NULL THEN p_effective_to ELSE l_effective_to END, o_is_valid, o_validation_message);
        END IF;
    END validate_update_contract_module;

    PROCEDURE validate_delete_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract_module(p_contract_id, p_product_id, p_module_id) = 0 THEN ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract module was not found.'); ELSE ph_helpers_pkg.set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_contract_module;

    PROCEDURE validate_restore_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF valid_module_for_contract(p_contract_id, p_product_id, p_module_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Module is not valid for the selected contract.');
        ELSIF exists_contract_module(p_contract_id, p_product_id, p_module_id, 1) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract module was not found.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_contract_module;

    PROCEDURE validate_create_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF valid_feature_for_contract(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Feature is not valid for the selected contract module.');
        ELSIF p_agreed_price IS NOT NULL AND p_agreed_price < 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Agreed price must be greater than or equal to zero.');
        ELSE
            validate_effective_dates(p_effective_from, p_effective_to, o_is_valid, o_validation_message);
        END IF;
    END validate_create_contract_feature;

    PROCEDURE validate_update_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT NULL, p_effective_to IN DATE DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
        l_effective_from ph_erp_contract_features.effective_from%TYPE;
        l_effective_to   ph_erp_contract_features.effective_to%TYPE;
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract feature was not found.');
            RETURN;
        END IF;
        SELECT effective_from, effective_to INTO l_effective_from, l_effective_to FROM ph_erp_contract_features WHERE contract_id = p_contract_id AND product_id = p_product_id AND module_id = p_module_id AND platform_id = p_platform_id AND feature_id = p_feature_id;
        IF p_agreed_price IS NOT NULL AND p_agreed_price < 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Agreed price must be greater than or equal to zero.');
        ELSIF NOT ph_helpers_pkg.valid_flag(p_is_active) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Active flag must be 0 or 1.');
        ELSE
            validate_effective_dates(NVL(p_effective_from, l_effective_from), CASE WHEN p_effective_to IS NOT NULL THEN p_effective_to ELSE l_effective_to END, o_is_valid, o_validation_message);
        END IF;
    END validate_update_contract_feature;

    PROCEDURE validate_delete_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF exists_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id) = 0 THEN ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract feature was not found.'); ELSE ph_helpers_pkg.set_valid(o_is_valid, o_validation_message); END IF;
    END validate_delete_contract_feature;

    PROCEDURE validate_restore_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CONTRACTS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN RETURN; END IF;
        IF valid_feature_for_contract(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Feature is not valid for the selected contract module.');
        ELSIF exists_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id, 1) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contract feature was not found.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_contract_feature;
END ph_erp_contract_validation_pkg;
/
