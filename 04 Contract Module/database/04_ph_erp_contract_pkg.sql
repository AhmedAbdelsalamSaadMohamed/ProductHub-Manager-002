/*
ProductHub Manager - Contract Management Package
Target DBMS: Oracle Database 21c+
*/

CREATE OR REPLACE PACKAGE ph_erp_contract_pkg AS
    ----------------------------------------------------------------------
    -- Read operations
    ----------------------------------------------------------------------
    FUNCTION get_contracts(p_customer_id IN NUMBER DEFAULT NULL, p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_contract_urls(p_contract_id IN NUMBER DEFAULT NULL, p_contract_url_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_contract_modules(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_contract_platforms(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_contract_features(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_feature_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;

    ----------------------------------------------------------------------
    -- Create/update/delete/restore operations
    ----------------------------------------------------------------------
    PROCEDURE create_contract(p_contract_no IN VARCHAR2, p_customer_id IN NUMBER, p_product_id IN NUMBER, p_start_date IN DATE, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_contract_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE put_contract(p_contract_no IN VARCHAR2, p_customer_id IN NUMBER, p_product_id IN NUMBER, p_start_date IN DATE, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_contract_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_contract(p_contract_id IN NUMBER, p_contract_no IN VARCHAR2 DEFAULT NULL, p_customer_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_start_date IN DATE DEFAULT NULL, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER DEFAULT NULL, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE create_contract_url(p_contract_id IN NUMBER, p_access_url IN VARCHAR2, p_is_primary IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, p_contract_url_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE put_contract_url(p_contract_id IN NUMBER, p_access_url IN VARCHAR2, p_is_primary IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, p_contract_url_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_contract_url(p_contract_url_id IN NUMBER, p_access_url IN VARCHAR2 DEFAULT NULL, p_is_primary IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE create_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE put_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT NULL, p_effective_to IN DATE DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE create_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE put_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT NULL, p_effective_to IN DATE DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);

    ----------------------------------------------------------------------
    -- Maintenance operations
    ----------------------------------------------------------------------
    PROCEDURE set_primary_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL);
    PROCEDURE ensure_primary_url(p_contract_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL);
END ph_erp_contract_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_erp_contract_pkg AS
    ----------------------------------------------------------------------
    -- Private helpers
    ----------------------------------------------------------------------
FUNCTION bool_to_number(p_count IN NUMBER) RETURN NUMBER IS
    BEGIN
        IF p_count > 0 THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END bool_to_number;

    ----------------------------------------------------------------------
    -- Private validation and lookup implementations
    ----------------------------------------------------------------------

FUNCTION is_active_customer(p_customer_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count
            FROM ph_erp_customers
            WHERE customer_id = p_customer_id
                AND is_active = 1
                AND is_deleted = 0;
        RETURN bool_to_number(l_count);
    END is_active_customer;

FUNCTION get_contract_customer_id(p_contract_id IN NUMBER) RETURN NUMBER IS
        l_customer_id ph_erp_contracts.customer_id%TYPE;
    BEGIN
        SELECT customer_id INTO l_customer_id
            FROM ph_erp_contracts
            WHERE contract_id = p_contract_id
                AND is_deleted = 0;
        RETURN l_customer_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END get_contract_customer_id;

FUNCTION get_contract_product_id(p_contract_id IN NUMBER) RETURN NUMBER IS
        l_product_id ph_erp_contracts.product_id%TYPE;
    BEGIN
        SELECT product_id INTO l_product_id
            FROM ph_erp_contracts
            WHERE contract_id = p_contract_id
                AND is_deleted = 0;
        RETURN l_product_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END get_contract_product_id;

FUNCTION is_module_valid_for_contract(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count
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
        RETURN bool_to_number(l_count);
    END is_module_valid_for_contract;

FUNCTION is_feature_valid_for_contract(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count
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
        RETURN bool_to_number(l_count);
    END is_feature_valid_for_contract;

FUNCTION has_primary_url(p_contract_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count
            FROM ph_erp_contract_urls
            WHERE contract_id = p_contract_id
                AND is_primary = 1
                AND is_active = 1
                AND is_deleted = 0;
        RETURN bool_to_number(l_count);
    END has_primary_url;

PROCEDURE require_flag(p_value IN NUMBER, p_name IN VARCHAR2) IS
    BEGIN
        IF NVL(p_value, -1) NOT IN (0, 1) THEN
            RAISE_APPLICATION_ERROR(-20290, ph_localization_pkg.localized_text(p_name || ' must be 0 or 1.', p_name || ' ط¸ظ¹ط·آ¬ط·آ¨ ط·آ£ط¸â€  ط¸ظ¹ط¸ئ’ط¸ث†ط¸â€  0 ط·آ£ط¸ث† 1.'));
        END IF;
    END require_flag;

PROCEDURE require_text(p_value IN VARCHAR2, p_name IN VARCHAR2) IS
    BEGIN
        IF TRIM(p_value) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20291, ph_localization_pkg.localized_text(p_name || ' is required.', p_name || ' ط¸â€¦ط·آ·ط¸â€‍ط¸ث†ط·آ¨.'));
        END IF;
    END require_text;

PROCEDURE require_contract_product(p_product_id IN NUMBER) IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_products
            WHERE product_id = p_product_id
                AND is_active = 1
                AND is_deleted = 0;

        IF l_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20201, ph_localization_pkg.localized_text('Product is not active or was not found.', 'Product is not active or was not found.'));
        END IF;
    END require_contract_product;

PROCEDURE require_contract_payment_cycle(p_payment_cycle IN NUMBER) IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_payment_cycle_lkp
            WHERE payment_cycle_id = p_payment_cycle
                AND is_active = 1
                AND is_deleted = 0;

        IF l_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20202, ph_localization_pkg.localized_text('Payment cycle is not active or was not found.', 'Payment cycle is not active or was not found.'));
        END IF;
    END require_contract_payment_cycle;

PROCEDURE require_contract_dates(p_start_date IN DATE, p_end_date IN DATE) IS
    BEGIN
        IF p_start_date IS NULL THEN
            RAISE_APPLICATION_ERROR(-20292, ph_localization_pkg.localized_text('Contract start date is required.', 'ط·ع¾ط·آ§ط·آ±ط¸ظ¹ط·آ® ط·آ¨ط·آ¯ط·آ§ط¸ظ¹ط·آ© ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯ ط¸â€¦ط·آ·ط¸â€‍ط¸ث†ط·آ¨.'));
        END IF;

        IF p_end_date IS NOT NULL AND p_end_date < p_start_date THEN
            RAISE_APPLICATION_ERROR(-20293, ph_localization_pkg.localized_text('Contract end date cannot be before start date.', 'ط¸â€‍ط·آ§ ط¸ظ¹ط¸â€¦ط¸ئ’ط¸â€  ط·آ£ط¸â€  ط¸ظ¹ط¸ئ’ط¸ث†ط¸â€  ط·ع¾ط·آ§ط·آ±ط¸ظ¹ط·آ® ط¸â€ ط¸â€،ط·آ§ط¸ظ¹ط·آ© ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯ ط¸â€ڑط·آ¨ط¸â€‍ ط·ع¾ط·آ§ط·آ±ط¸ظ¹ط·آ® ط·آ§ط¸â€‍ط·آ¨ط·آ¯ط·آ§ط¸ظ¹ط·آ©.'));
        END IF;
    END require_contract_dates;

PROCEDURE require_effective_dates(p_effective_from IN DATE, p_effective_to IN DATE) IS
    BEGIN
        IF p_effective_from IS NULL THEN
            RAISE_APPLICATION_ERROR(-20294, ph_localization_pkg.localized_text('Effective from date is required.', 'ط·ع¾ط·آ§ط·آ±ط¸ظ¹ط·آ® ط·آ¨ط·آ¯ط·آ§ط¸ظ¹ط·آ© ط·آ§ط¸â€‍ط·آ³ط·آ±ط¸ظ¹ط·آ§ط¸â€  ط¸â€¦ط·آ·ط¸â€‍ط¸ث†ط·آ¨.'));
        END IF;

        IF p_effective_to IS NOT NULL AND p_effective_to < p_effective_from THEN
            RAISE_APPLICATION_ERROR(-20295, ph_localization_pkg.localized_text('Effective to date cannot be before effective from date.', 'ط¸â€‍ط·آ§ ط¸ظ¹ط¸â€¦ط¸ئ’ط¸â€  ط·آ£ط¸â€  ط¸ظ¹ط¸ئ’ط¸ث†ط¸â€  ط·ع¾ط·آ§ط·آ±ط¸ظ¹ط·آ® ط¸â€ ط¸â€،ط·آ§ط¸ظ¹ط·آ© ط·آ§ط¸â€‍ط·آ³ط·آ±ط¸ظ¹ط·آ§ط¸â€  ط¸â€ڑط·آ¨ط¸â€‍ ط·ع¾ط·آ§ط·آ±ط¸ظ¹ط·آ® ط·آ§ط¸â€‍ط·آ¨ط·آ¯ط·آ§ط¸ظ¹ط·آ©.'));
        END IF;
    END require_effective_dates;

    ----------------------------------------------------------------------
    -- Read implementations
    ----------------------------------------------------------------------

PROCEDURE set_error(p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_error_code      NUMBER := SQLCODE;
        l_error_message   VARCHAR2(4000) := SQLERRM;
        l_error_stack     CLOB := DBMS_UTILITY.FORMAT_ERROR_STACK;
        l_error_backtrace CLOB := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    BEGIN
        ph_erp_contract_validation_pkg.log_error(
            p_program_unit => $$PLSQL_UNIT,
            p_error_location => l_error_backtrace,
            p_error_code => l_error_code,
            p_error_message => l_error_message,
            p_error_stack => l_error_stack,
            p_error_backtrace => l_error_backtrace
        );
        p_result_code := CASE WHEN l_error_code BETWEEN -20999 AND -20000 THEN 'V' ELSE 'E' END;
        p_result_message := l_error_message;
    END set_error;

    PROCEDURE raise_when_invalid(p_is_valid IN NUMBER, p_validation_message IN VARCHAR2) IS
    BEGIN
        IF NVL(p_is_valid, 0) = 0 THEN
            RAISE_APPLICATION_ERROR(-20190, p_validation_message);
        END IF;
    END raise_when_invalid;

FUNCTION get_contracts(p_customer_id IN NUMBER DEFAULT NULL, p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT c.contract_id,
        c.contract_no,
        c.customer_id,
        cu.customer_name,
        c.product_id,
        p.product_name_en,
        p.product_name_ar,
        c.start_date,
        c.end_date,
        c.payment_cycle,
        pc.payment_cycle_name_en,
        pc.payment_cycle_name_ar,
        c.is_active,
        c.notes_en,
        c.notes_ar,
        c.created_by,
        c.created_at,
        c.updated_by,
        c.updated_at
            FROM ph_erp_contracts c
        JOIN ph_erp_customers cu
            ON cu.customer_id = c.customer_id
        JOIN ph_erp_products p
            ON p.product_id = c.product_id
        JOIN ph_erp_payment_cycle_lkp pc
            ON pc.payment_cycle_id = c.payment_cycle
            WHERE (p_customer_id IS NULL OR c.customer_id = p_customer_id)
                AND (p_contract_id IS NULL OR c.contract_id = p_contract_id)
                AND (p_product_id IS NULL OR c.product_id = p_product_id)
                AND (p_is_active IS NULL OR c.is_active = p_is_active)
                AND c.is_deleted = 0
                AND cu.is_deleted = 0
                AND p.is_deleted = 0
                AND pc.is_deleted = 0
            ORDER BY c.customer_id, c.start_date DESC, c.contract_no, c.contract_id;
        RETURN l_result;
    END get_contracts;

FUNCTION get_contract_urls(p_contract_id IN NUMBER DEFAULT NULL, p_contract_url_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT cu.contract_url_id,
        cu.contract_id,
        c.contract_no,
        cu.access_url,
        cu.is_primary,
        cu.is_active,
        cu.created_by,
        cu.created_at,
        cu.updated_by,
        cu.updated_at
            FROM ph_erp_contract_urls cu
        JOIN ph_erp_contracts c
            ON c.contract_id = cu.contract_id
            WHERE (p_contract_id IS NULL OR cu.contract_id = p_contract_id)
                AND (p_contract_url_id IS NULL OR cu.contract_url_id = p_contract_url_id)
                AND (p_is_active IS NULL OR cu.is_active = p_is_active)
                AND cu.is_deleted = 0
                AND c.is_deleted = 0
            ORDER BY cu.contract_id, cu.is_primary DESC, cu.contract_url_id;
        RETURN l_result;
    END get_contract_urls;

FUNCTION get_contract_modules(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT cm.contract_id,
        c.contract_no,
        cm.product_id,
        p.product_name_en,
        p.product_name_ar,
        cm.module_id,
        m.module_name_en,
        m.module_name_ar,
        cm.effective_from,
        cm.effective_to,
        cm.is_active,
        cm.created_by,
        cm.created_at,
        cm.updated_by,
        cm.updated_at
            FROM ph_erp_contract_modules cm
        JOIN ph_erp_contracts c
            ON c.contract_id = cm.contract_id
                AND c.product_id = cm.product_id
        JOIN ph_erp_products p
            ON p.product_id = cm.product_id
        JOIN ph_erp_modules m
            ON m.product_id = cm.product_id
                AND m.module_id = cm.module_id
            WHERE (p_contract_id IS NULL OR cm.contract_id = p_contract_id)
                AND (p_product_id IS NULL OR cm.product_id = p_product_id)
                AND (p_module_id IS NULL OR cm.module_id = p_module_id)
                AND (p_is_active IS NULL OR cm.is_active = p_is_active)
                AND cm.is_deleted = 0
                AND c.is_deleted = 0
                AND p.is_deleted = 0
                AND m.is_deleted = 0
            ORDER BY cm.contract_id, m.display_order, m.module_name_en, cm.module_id;
        RETURN l_result;
    END get_contract_modules;

FUNCTION get_contract_platforms(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT cp.contract_id,
        c.contract_no,
        cp.product_id,
        p.product_name_en,
        p.product_name_ar,
        cp.module_id,
        m.module_name_en,
        m.module_name_ar,
        cp.platform_id,
        pl.platform_name_en,
        pl.platform_name_ar,
        cp.effective_from,
        cp.effective_to,
        cp.is_active,
        cp.created_by,
        cp.created_at,
        cp.updated_by,
        cp.updated_at
            FROM ph_erp_contract_platforms cp
        JOIN ph_erp_contracts c
            ON c.contract_id = cp.contract_id
                AND c.product_id = cp.product_id
        JOIN ph_erp_products p
            ON p.product_id = cp.product_id
        JOIN ph_erp_modules m
            ON m.product_id = cp.product_id
                AND m.module_id = cp.module_id
        JOIN ph_erp_platform_lkp pl
            ON pl.platform_id = cp.platform_id
            WHERE (p_contract_id IS NULL OR cp.contract_id = p_contract_id)
                AND (p_product_id IS NULL OR cp.product_id = p_product_id)
                AND (p_module_id IS NULL OR cp.module_id = p_module_id)
                AND (p_platform_id IS NULL OR cp.platform_id = p_platform_id)
                AND (p_is_active IS NULL OR cp.is_active = p_is_active)
                AND cp.is_deleted = 0
                AND c.is_deleted = 0
                AND p.is_deleted = 0
                AND m.is_deleted = 0
                AND pl.is_deleted = 0
            ORDER BY cp.contract_id, cp.module_id, pl.platform_name_en, cp.platform_id;
        RETURN l_result;
    END get_contract_platforms;

FUNCTION get_contract_features(p_contract_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_module_id IN NUMBER DEFAULT NULL, p_platform_id IN NUMBER DEFAULT NULL, p_feature_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT cf.contract_id,
        c.contract_no,
        cf.product_id,
        p.product_name_en,
        p.product_name_ar,
        cf.module_id,
        m.module_name_en,
        m.module_name_ar,
        cf.platform_id,
        pl.platform_name_en,
        pl.platform_name_ar,
        cf.feature_id,
        f.feature_name_en,
        f.feature_name_ar,
        cf.agreed_price,
        cf.effective_from,
        cf.effective_to,
        cf.is_active,
        cf.created_by,
        cf.created_at,
        cf.updated_by,
        cf.updated_at
            FROM ph_erp_contract_features cf
        JOIN ph_erp_contracts c
            ON c.contract_id = cf.contract_id
                AND c.product_id = cf.product_id
        JOIN ph_erp_products p
            ON p.product_id = cf.product_id
        JOIN ph_erp_modules m
            ON m.product_id = cf.product_id
                AND m.module_id = cf.module_id
        JOIN ph_erp_platform_lkp pl
            ON pl.platform_id = cf.platform_id
        JOIN ph_erp_features f
            ON f.product_id = cf.product_id
                AND f.module_id = cf.module_id
                AND f.platform_id = cf.platform_id
                AND f.feature_id = cf.feature_id
            WHERE (p_contract_id IS NULL OR cf.contract_id = p_contract_id)
                AND (p_product_id IS NULL OR cf.product_id = p_product_id)
                AND (p_module_id IS NULL OR cf.module_id = p_module_id)
                AND (p_platform_id IS NULL OR cf.platform_id = p_platform_id)
                AND (p_feature_id IS NULL OR cf.feature_id = p_feature_id)
                AND (p_is_active IS NULL OR cf.is_active = p_is_active)
                AND cf.is_deleted = 0
                AND c.is_deleted = 0
                AND p.is_deleted = 0
                AND m.is_deleted = 0
                AND pl.is_deleted = 0
                AND f.is_deleted = 0
            ORDER BY cf.contract_id, cf.module_id, cf.platform_id, f.display_order, f.feature_name_en, cf.feature_id;
        RETURN l_result;
    END get_contract_features;

    ----------------------------------------------------------------------
    -- Customer create/update/delete implementations
    ----------------------------------------------------------------------

PROCEDURE do_update_contract(
        p_contract_id IN NUMBER,
        p_contract_no IN VARCHAR2 DEFAULT NULL,
        p_customer_id IN NUMBER DEFAULT NULL,
        p_product_id  IN NUMBER DEFAULT NULL,
        p_start_date  IN DATE DEFAULT NULL,
        p_end_date    IN DATE DEFAULT NULL,
        p_payment_cycle IN NUMBER DEFAULT NULL,
        p_notes_en    IN VARCHAR2 DEFAULT NULL,
        p_notes_ar    IN VARCHAR2 DEFAULT NULL,
        p_is_active   IN NUMBER DEFAULT NULL,
        p_updated_by  IN NUMBER DEFAULT NULL
    ) IS
        l_start_date ph_erp_contracts.start_date%TYPE;
        l_end_date ph_erp_contracts.end_date%TYPE;
    BEGIN
        BEGIN
            SELECT start_date, end_date
                INTO l_start_date, l_end_date
                FROM ph_erp_contracts
                WHERE contract_id = p_contract_id
                    AND is_deleted = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20211, ph_localization_pkg.localized_text('Contract was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
            END;

            IF p_customer_id IS NOT NULL THEN
                require_active_customer(p_customer_id);
            END IF;

            IF p_product_id IS NOT NULL THEN
                require_contract_product(p_product_id);
            END IF;

            IF p_payment_cycle IS NOT NULL THEN
                require_contract_payment_cycle(p_payment_cycle);
            END IF;

            UPDATE ph_erp_contracts
                SET contract_no = CASE WHEN p_contract_no IS NOT NULL THEN TRIM(p_contract_no) ELSE contract_no END,
                    customer_id = CASE WHEN p_customer_id IS NOT NULL THEN p_customer_id ELSE customer_id END,
                    product_id = CASE WHEN p_product_id IS NOT NULL THEN p_product_id ELSE product_id END,
                    start_date = CASE WHEN p_start_date IS NOT NULL THEN p_start_date ELSE start_date END,
                    end_date = CASE WHEN p_end_date IS NOT NULL THEN p_end_date ELSE end_date END,
                    payment_cycle = CASE WHEN p_payment_cycle IS NOT NULL THEN p_payment_cycle ELSE payment_cycle END,
                    notes_en = CASE WHEN p_notes_en IS NOT NULL THEN p_notes_en ELSE notes_en END,
                    notes_ar = CASE WHEN p_notes_ar IS NOT NULL THEN p_notes_ar ELSE notes_ar END,
                    is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                    updated_by = p_updated_by
                WHERE contract_id = p_contract_id
                    AND is_deleted = 0
                    AND ((p_contract_no IS NOT NULL AND DECODE(contract_no, TRIM(p_contract_no), 0, 1) = 1)
                    OR (p_customer_id IS NOT NULL AND DECODE(customer_id, p_customer_id, 0, 1) = 1)
                    OR (p_product_id IS NOT NULL AND DECODE(product_id, p_product_id, 0, 1) = 1)
                    OR (p_start_date IS NOT NULL AND DECODE(start_date, p_start_date, 0, 1) = 1)
                    OR (p_end_date IS NOT NULL AND DECODE(end_date, p_end_date, 0, 1) = 1)
                    OR (p_payment_cycle IS NOT NULL AND DECODE(payment_cycle, p_payment_cycle, 0, 1) = 1)
                    OR (p_notes_en IS NOT NULL AND DECODE(notes_en, p_notes_en, 0, 1) = 1)
                    OR (p_notes_ar IS NOT NULL AND DECODE(notes_ar, p_notes_ar, 0, 1) = 1)
                    OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

    END do_update_contract;

PROCEDURE do_delete_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_contract_features
            SET is_deleted = 1, updated_by = p_updated_by
            WHERE contract_id = p_contract_id;

        UPDATE ph_erp_contract_platforms
            SET is_deleted = 1, updated_by = p_updated_by
            WHERE contract_id = p_contract_id;

        UPDATE ph_erp_contract_modules
            SET is_deleted = 1, updated_by = p_updated_by
            WHERE contract_id = p_contract_id;

        UPDATE ph_erp_contract_urls
            SET is_deleted = 1, is_primary = 0, updated_by = p_updated_by
            WHERE contract_id = p_contract_id;

        UPDATE ph_erp_contracts
            SET is_deleted = 1, updated_by = p_updated_by
            WHERE contract_id = p_contract_id
                AND is_deleted = 0;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20211, ph_localization_pkg.localized_text('Contract was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
        END IF;
    END do_delete_contract;

PROCEDURE do_restore_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_contracts
            SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP
            WHERE contract_id = p_contract_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20211, ph_localization_pkg.localized_text('Contract was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
        END IF;
    END do_restore_contract;

    ----------------------------------------------------------------------
    -- Contract URL create/update/delete implementations
    ----------------------------------------------------------------------

PROCEDURE do_update_contract_url(
        p_contract_url_id IN NUMBER,
        p_access_url      IN VARCHAR2 DEFAULT NULL,
        p_is_primary      IN NUMBER DEFAULT NULL,
        p_is_active       IN NUMBER DEFAULT NULL,
        p_updated_by      IN NUMBER DEFAULT NULL
    ) IS
        l_exists NUMBER;
        l_is_primary ph_erp_contract_urls.is_primary%TYPE;
        l_is_active ph_erp_contract_urls.is_active%TYPE;
    BEGIN
        SELECT COUNT(*) INTO l_exists FROM ph_erp_contract_urls WHERE contract_url_id = p_contract_url_id AND is_deleted = 0;
        IF l_exists = 0 THEN
            RAISE_APPLICATION_ERROR(-20212, ph_localization_pkg.localized_text('Contract URL was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ±ط·آ§ط·آ¨ط·آ· ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
        END IF;

        UPDATE ph_erp_contract_urls
            SET access_url = CASE WHEN p_access_url IS NOT NULL THEN TRIM(p_access_url) ELSE access_url END,
                is_primary = CASE WHEN p_is_primary IS NOT NULL THEN p_is_primary ELSE is_primary END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by
            WHERE contract_url_id = p_contract_url_id
                AND ((p_access_url IS NOT NULL AND DECODE(access_url, TRIM(p_access_url), 0, 1) = 1)
                OR (p_is_primary IS NOT NULL AND DECODE(is_primary, p_is_primary, 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));

        SELECT is_primary, is_active
            INTO l_is_primary, l_is_active
            FROM ph_erp_contract_urls
            WHERE contract_url_id = p_contract_url_id
                AND is_deleted = 0;

        IF l_is_primary = 1 AND l_is_active = 1 THEN
            set_primary_url(p_contract_url_id, p_updated_by);
        END IF;
    END do_update_contract_url;

PROCEDURE do_delete_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER) IS
        l_contract_id ph_erp_contract_urls.contract_id%TYPE;
    BEGIN
        SELECT contract_id
            INTO l_contract_id
            FROM ph_erp_contract_urls
            WHERE contract_url_id = p_contract_url_id;

        UPDATE ph_erp_contract_urls
            SET is_deleted = 1, is_primary = 0, updated_by = p_updated_by
            WHERE contract_url_id = p_contract_url_id
                AND is_deleted = 0;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20212, ph_localization_pkg.localized_text('Contract URL was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ±ط·آ§ط·آ¨ط·آ· ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
        END IF;

        ensure_primary_url(l_contract_id, p_updated_by);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20212, ph_localization_pkg.localized_text('Contract URL was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ±ط·آ§ط·آ¨ط·آ· ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
    END do_delete_contract_url;

PROCEDURE do_restore_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER) IS
        l_contract_id ph_erp_contract_urls.contract_id%TYPE;
    BEGIN
        SELECT contract_id
            INTO l_contract_id
            FROM ph_erp_contract_urls
            WHERE contract_url_id = p_contract_url_id;

        UPDATE ph_erp_contract_urls
            SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP
            WHERE contract_url_id = p_contract_url_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20212, ph_localization_pkg.localized_text('Contract URL was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ±ط·آ§ط·آ¨ط·آ· ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
        END IF;

        ensure_primary_url(l_contract_id, p_updated_by);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20212, ph_localization_pkg.localized_text('Contract URL was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ±ط·آ§ط·آ¨ط·آ· ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
    END do_restore_contract_url;

    ----------------------------------------------------------------------
    -- Contract module create/update/delete implementations
    ----------------------------------------------------------------------

PROCEDURE do_update_contract_module(
        p_contract_id    IN NUMBER,
        p_product_id     IN NUMBER,
        p_module_id      IN NUMBER,
        p_effective_from IN DATE DEFAULT NULL,
        p_effective_to   IN DATE DEFAULT NULL,
        p_is_active      IN NUMBER DEFAULT NULL,
        p_updated_by     IN NUMBER DEFAULT NULL
    ) IS
        l_effective_from ph_erp_contract_modules.effective_from%TYPE;
        l_effective_to ph_erp_contract_modules.effective_to%TYPE;
    BEGIN
        BEGIN
            SELECT effective_from, effective_to
                INTO l_effective_from, l_effective_to
                FROM ph_erp_contract_modules
                WHERE contract_id = p_contract_id
                    AND product_id = p_product_id
                    AND module_id = p_module_id
                    AND is_deleted = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20213, ph_localization_pkg.localized_text('Contract module was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط¸ث†ط·آ­ط·آ¯ط·آ© ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
            END;

            UPDATE ph_erp_contract_modules
                SET effective_from = CASE WHEN p_effective_from IS NOT NULL THEN p_effective_from ELSE effective_from END,
                    effective_to = CASE WHEN p_effective_to IS NOT NULL THEN p_effective_to ELSE effective_to END,
                    is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                    updated_by = p_updated_by
                WHERE contract_id = p_contract_id
                    AND product_id = p_product_id
                    AND module_id = p_module_id
                    AND ((p_effective_from IS NOT NULL AND DECODE(effective_from, p_effective_from, 0, 1) = 1)
                    OR (p_effective_to IS NOT NULL AND DECODE(effective_to, p_effective_to, 0, 1) = 1)
                    OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));
    END do_update_contract_module;

PROCEDURE do_delete_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_contract_features
            SET is_deleted = 1, updated_by = p_updated_by
            WHERE contract_id = p_contract_id
                AND product_id = p_product_id
                AND module_id = p_module_id;

        UPDATE ph_erp_contract_platforms
            SET is_deleted = 1, updated_by = p_updated_by
            WHERE contract_id = p_contract_id
                AND product_id = p_product_id
                AND module_id = p_module_id;

        UPDATE ph_erp_contract_modules
            SET is_deleted = 1, updated_by = p_updated_by
            WHERE contract_id = p_contract_id
                AND product_id = p_product_id
                AND module_id = p_module_id
                AND is_deleted = 0;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20213, ph_localization_pkg.localized_text('Contract module was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط¸ث†ط·آ­ط·آ¯ط·آ© ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
        END IF;
    END do_delete_contract_module;

PROCEDURE do_restore_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        require_valid_contract_module(p_contract_id, p_product_id, p_module_id);

        UPDATE ph_erp_contract_modules
            SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP
            WHERE contract_id = p_contract_id
                AND product_id = p_product_id
                AND module_id = p_module_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20213, ph_localization_pkg.localized_text('Contract module was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط¸ث†ط·آ­ط·آ¯ط·آ© ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
        END IF;
    END do_restore_contract_module;

    ----------------------------------------------------------------------
    -- Contract feature create/update/delete implementations
    ----------------------------------------------------------------------

PROCEDURE do_update_contract_feature(
        p_contract_id    IN NUMBER,
        p_product_id     IN NUMBER,
        p_module_id      IN NUMBER,
        p_platform_id    IN NUMBER,
        p_feature_id     IN NUMBER,
        p_agreed_price   IN NUMBER DEFAULT NULL,
        p_effective_from IN DATE DEFAULT NULL,
        p_effective_to   IN DATE DEFAULT NULL,
        p_is_active      IN NUMBER DEFAULT NULL,
        p_updated_by     IN NUMBER DEFAULT NULL
    ) IS
        l_effective_from ph_erp_contract_features.effective_from%TYPE;
        l_effective_to ph_erp_contract_features.effective_to%TYPE;
    BEGIN
        BEGIN
            SELECT effective_from, effective_to
                INTO l_effective_from, l_effective_to
                FROM ph_erp_contract_features
                WHERE contract_id = p_contract_id
                    AND product_id = p_product_id
                    AND module_id = p_module_id
                    AND platform_id = p_platform_id
                    AND feature_id = p_feature_id
                    AND is_deleted = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20214, ph_localization_pkg.localized_text('Contract feature was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط¸â€¦ط¸ظ¹ط·آ²ط·آ© ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
            END;

            UPDATE ph_erp_contract_features
                SET agreed_price = CASE WHEN p_agreed_price IS NOT NULL THEN p_agreed_price ELSE agreed_price END,
                    effective_from = CASE WHEN p_effective_from IS NOT NULL THEN p_effective_from ELSE effective_from END,
                    effective_to = CASE WHEN p_effective_to IS NOT NULL THEN p_effective_to ELSE effective_to END,
                    is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                    updated_by = p_updated_by
                WHERE contract_id = p_contract_id
                    AND product_id = p_product_id
                    AND module_id = p_module_id
                    AND platform_id = p_platform_id
                    AND feature_id = p_feature_id
                    AND ((p_agreed_price IS NOT NULL AND DECODE(agreed_price, p_agreed_price, 0, 1) = 1)
                    OR (p_effective_from IS NOT NULL AND DECODE(effective_from, p_effective_from, 0, 1) = 1)
                    OR (p_effective_to IS NOT NULL AND DECODE(effective_to, p_effective_to, 0, 1) = 1)
                    OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));
    END do_update_contract_feature;

PROCEDURE do_delete_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_contract_features
            SET is_deleted = 1, updated_by = p_updated_by
            WHERE contract_id = p_contract_id
                AND product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND feature_id = p_feature_id
                AND is_deleted = 0;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20214, ph_localization_pkg.localized_text('Contract feature was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط¸â€¦ط¸ظ¹ط·آ²ط·آ© ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
        END IF;
    END do_delete_contract_feature;

PROCEDURE do_restore_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        require_valid_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id);

        UPDATE ph_erp_contract_features
            SET is_deleted = 0, deleted_by = NULL, deleted_at = NULL, updated_by = p_updated_by, updated_at = SYSTIMESTAMP
            WHERE contract_id = p_contract_id
                AND product_id = p_product_id
                AND module_id = p_module_id
                AND platform_id = p_platform_id
                AND feature_id = p_feature_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20214, ph_localization_pkg.localized_text('Contract feature was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط¸â€¦ط¸ظ¹ط·آ²ط·آ© ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
        END IF;
    END do_restore_contract_feature;

    ----------------------------------------------------------------------
    -- Result-returning create/update/delete/restore implementations
    ----------------------------------------------------------------------

PROCEDURE create_contract(p_contract_no IN VARCHAR2, p_customer_id IN NUMBER, p_product_id IN NUMBER, p_start_date IN DATE, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_contract_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_create_contract(p_contract_no, p_customer_id, p_product_id, p_start_date, p_end_date, p_payment_cycle, p_notes_en, p_notes_ar, p_created_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        require_text(p_contract_no, 'Contract number');
        require_active_customer(p_customer_id);
        require_contract_product(p_product_id);
        require_contract_payment_cycle(p_payment_cycle);
        require_contract_dates(p_start_date, p_end_date);

        INSERT INTO ph_erp_contracts (
        contract_no, customer_id, product_id, start_date, end_date, payment_cycle,
        is_active, notes_en, notes_ar, created_by
        ) VALUES (
        TRIM(p_contract_no), p_customer_id, p_product_id, p_start_date, p_end_date, p_payment_cycle,
        1, p_notes_en, p_notes_ar, p_created_by
        ) RETURNING contract_id INTO p_contract_id;

        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_contract;

PROCEDURE put_contract(p_contract_no IN VARCHAR2, p_customer_id IN NUMBER, p_product_id IN NUMBER, p_start_date IN DATE, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_contract_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_contract_id NUMBER;
    BEGIN
        SELECT MIN(contract_id) INTO l_contract_id
          FROM ph_erp_contracts
         WHERE contract_no = TRIM(p_contract_no);

        IF l_contract_id IS NOT NULL THEN
            p_contract_id := l_contract_id;
            restore_contract(l_contract_id, p_created_by, p_result_code, p_result_message);
            IF p_result_code <> 'S' THEN RETURN; END IF;
            update_contract(l_contract_id, p_contract_no, p_customer_id, p_product_id, p_start_date, p_end_date, p_payment_cycle, p_notes_en, p_notes_ar, 1, p_created_by, p_result_code, p_result_message);
            RETURN;
        END IF;

        create_contract(p_contract_no, p_customer_id, p_product_id, p_start_date, p_end_date, p_payment_cycle, p_notes_en, p_notes_ar, p_created_by, p_contract_id, p_result_code, p_result_message);
    END put_contract;

PROCEDURE update_contract(p_contract_id IN NUMBER, p_contract_no IN VARCHAR2 DEFAULT NULL, p_customer_id IN NUMBER DEFAULT NULL, p_product_id IN NUMBER DEFAULT NULL, p_start_date IN DATE DEFAULT NULL, p_end_date IN DATE DEFAULT NULL, p_payment_cycle IN NUMBER DEFAULT NULL, p_notes_en IN VARCHAR2 DEFAULT NULL, p_notes_ar IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_update_contract(p_contract_id, p_contract_no, p_customer_id, p_product_id, p_start_date, p_end_date, p_payment_cycle, p_notes_en, p_notes_ar, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_contract(p_contract_id, p_contract_no, p_customer_id, p_product_id, p_start_date, p_end_date, p_payment_cycle, p_notes_en, p_notes_ar, p_is_active, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_contract;

PROCEDURE delete_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_delete_contract(p_contract_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_contract(p_contract_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_contract;

PROCEDURE restore_contract(p_contract_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_restore_contract(p_contract_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_contract(p_contract_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_contract;

PROCEDURE create_contract_url(p_contract_id IN NUMBER, p_access_url IN VARCHAR2, p_is_primary IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, p_contract_url_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_create_contract_url(p_contract_id, p_access_url, p_is_primary, p_created_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        require_text(p_access_url, 'Contract access URL');
        require_flag(p_is_primary, 'Primary URL flag');

        INSERT INTO ph_erp_contract_urls (
        contract_id, access_url, is_primary, is_active, created_by
        ) VALUES (
        p_contract_id, TRIM(p_access_url), p_is_primary, 1, p_created_by
        ) RETURNING contract_url_id INTO p_contract_url_id;

        IF p_is_primary = 1 THEN
            set_primary_url(p_contract_url_id, p_created_by);
        ELSE
            ensure_primary_url(p_contract_id, p_created_by);
        END IF;

        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract URL created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_contract_url;

PROCEDURE put_contract_url(p_contract_id IN NUMBER, p_access_url IN VARCHAR2, p_is_primary IN NUMBER DEFAULT 1, p_created_by IN NUMBER DEFAULT NULL, p_contract_url_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_contract_url_id NUMBER;
    BEGIN
        SELECT MIN(contract_url_id) INTO l_contract_url_id
          FROM ph_erp_contract_urls
         WHERE contract_id = p_contract_id
           AND access_url = TRIM(p_access_url);

        IF l_contract_url_id IS NOT NULL THEN
            p_contract_url_id := l_contract_url_id;
            restore_contract_url(l_contract_url_id, p_created_by, p_result_code, p_result_message);
            IF p_result_code <> 'S' THEN RETURN; END IF;
            update_contract_url(l_contract_url_id, p_access_url, p_is_primary, 1, p_created_by, p_result_code, p_result_message);
            RETURN;
        END IF;

        create_contract_url(p_contract_id, p_access_url, p_is_primary, p_created_by, p_contract_url_id, p_result_code, p_result_message);
    END put_contract_url;

PROCEDURE update_contract_url(p_contract_url_id IN NUMBER, p_access_url IN VARCHAR2 DEFAULT NULL, p_is_primary IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_update_contract_url(p_contract_url_id, p_access_url, p_is_primary, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_contract_url(p_contract_url_id, p_access_url, p_is_primary, p_is_active, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract URL updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_contract_url;

PROCEDURE delete_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_delete_contract_url(p_contract_url_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_contract_url(p_contract_url_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract URL deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_contract_url;

PROCEDURE restore_contract_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_restore_contract_url(p_contract_url_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_contract_url(p_contract_url_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract URL restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_contract_url;

PROCEDURE create_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_create_contract_module(p_contract_id, p_product_id, p_module_id, p_effective_from, p_effective_to, p_created_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        require_valid_contract_module(p_contract_id, p_product_id, p_module_id);
        require_effective_dates(p_effective_from, p_effective_to);

        MERGE INTO ph_erp_contract_modules target
            USING (
        SELECT p_contract_id contract_id, p_product_id product_id, p_module_id module_id FROM dual
        ) source
            ON (target.contract_id = source.contract_id AND target.product_id = source.product_id AND target.module_id = source.module_id)
            WHEN MATCHED THEN
        UPDATE SET target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.effective_from = p_effective_from,
        target.effective_to = p_effective_to,
        target.updated_by = p_created_by,
        target.updated_at = SYSTIMESTAMP
            WHEN NOT MATCHED THEN
        INSERT (contract_id, product_id, module_id, is_active, effective_from, effective_to, created_by)
            VALUES (source.contract_id, source.product_id, source.module_id, 1, p_effective_from, p_effective_to, p_created_by);

        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract module created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_contract_module;

PROCEDURE put_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        create_contract_module(p_contract_id, p_product_id, p_module_id, p_effective_from, p_effective_to, p_created_by, p_result_code, p_result_message);
    END put_contract_module;

PROCEDURE update_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_effective_from IN DATE DEFAULT NULL, p_effective_to IN DATE DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_update_contract_module(p_contract_id, p_product_id, p_module_id, p_effective_from, p_effective_to, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_contract_module(p_contract_id, p_product_id, p_module_id, p_effective_from, p_effective_to, p_is_active, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract module updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_contract_module;

PROCEDURE delete_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_delete_contract_module(p_contract_id, p_product_id, p_module_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_contract_module(p_contract_id, p_product_id, p_module_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract module deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_contract_module;

PROCEDURE restore_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_restore_contract_module(p_contract_id, p_product_id, p_module_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_contract_module(p_contract_id, p_product_id, p_module_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract module restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_contract_module;

PROCEDURE create_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_create_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id, p_agreed_price, p_effective_from, p_effective_to, p_created_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        require_valid_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id);
        require_effective_dates(p_effective_from, p_effective_to);

        MERGE INTO ph_erp_contract_platforms target
            USING (
        SELECT p_contract_id contract_id, p_product_id product_id, p_module_id module_id,
        p_platform_id platform_id FROM dual
        ) source
            ON (target.contract_id = source.contract_id
                AND target.product_id = source.product_id
                AND target.module_id = source.module_id
                AND target.platform_id = source.platform_id)
            WHEN MATCHED THEN
        UPDATE SET target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.effective_from = p_effective_from,
        target.effective_to = p_effective_to,
        target.updated_by = p_created_by,
        target.updated_at = SYSTIMESTAMP
            WHEN NOT MATCHED THEN
        INSERT (contract_id, product_id, module_id, platform_id, is_active, effective_from, effective_to, created_by)
            VALUES (source.contract_id, source.product_id, source.module_id, source.platform_id, 1, p_effective_from, p_effective_to, p_created_by);

        MERGE INTO ph_erp_contract_features target
            USING (
        SELECT p_contract_id contract_id, p_product_id product_id, p_module_id module_id,
        p_platform_id platform_id, p_feature_id feature_id FROM dual
        ) source
            ON (target.contract_id = source.contract_id
                AND target.product_id = source.product_id
                AND target.module_id = source.module_id
                AND target.platform_id = source.platform_id
                AND target.feature_id = source.feature_id)
            WHEN MATCHED THEN
        UPDATE SET target.agreed_price = p_agreed_price,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.effective_from = p_effective_from,
        target.effective_to = p_effective_to,
        target.updated_by = p_created_by,
        target.updated_at = SYSTIMESTAMP
            WHEN NOT MATCHED THEN
        INSERT (contract_id, product_id, module_id, platform_id, feature_id, agreed_price, is_active, effective_from, effective_to, created_by)
            VALUES (source.contract_id, source.product_id, source.module_id, source.platform_id, source.feature_id, p_agreed_price, 1, p_effective_from, p_effective_to, p_created_by);

        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract feature created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_contract_feature;

PROCEDURE put_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT TRUNC(SYSDATE), p_effective_to IN DATE DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
    BEGIN
        create_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id, p_agreed_price, p_effective_from, p_effective_to, p_created_by, p_result_code, p_result_message);
    END put_contract_feature;

PROCEDURE update_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_agreed_price IN NUMBER DEFAULT NULL, p_effective_from IN DATE DEFAULT NULL, p_effective_to IN DATE DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_update_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id, p_agreed_price, p_effective_from, p_effective_to, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id, p_agreed_price, p_effective_from, p_effective_to, p_is_active, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract feature updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_contract_feature;

PROCEDURE delete_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_delete_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract feature deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_contract_feature;

PROCEDURE restore_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_contract_validation_pkg.validate_restore_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_contract_feature(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Contract feature restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_contract_feature;

    ----------------------------------------------------------------------
    -- Contract URL maintenance implementations
    ----------------------------------------------------------------------

PROCEDURE set_primary_url(p_contract_url_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL) IS
        l_contract_id ph_erp_contract_urls.contract_id%TYPE;
    BEGIN
        SELECT contract_id INTO l_contract_id
            FROM ph_erp_contract_urls
            WHERE contract_url_id = p_contract_url_id
                AND is_deleted = 0;

        UPDATE ph_erp_contract_urls
            SET is_primary = 0,
                updated_by = p_updated_by,
                updated_at = SYSTIMESTAMP
            WHERE contract_id = l_contract_id
                AND contract_url_id <> p_contract_url_id
                AND is_primary = 1
                AND is_deleted = 0;

        UPDATE ph_erp_contract_urls
            SET is_primary = 1,
                is_active = 1,
                updated_by = p_updated_by,
                updated_at = SYSTIMESTAMP
            WHERE contract_url_id = p_contract_url_id
                AND is_deleted = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20200, ph_localization_pkg.localized_text('Contract URL was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ±ط·آ§ط·آ¨ط·آ· ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯.'));
    END set_primary_url;

PROCEDURE ensure_primary_url(p_contract_id IN NUMBER, p_updated_by IN NUMBER DEFAULT NULL) IS
        l_contract_url_id ph_erp_contract_urls.contract_url_id%TYPE;
    BEGIN
        IF has_primary_url(p_contract_id) = 1 THEN
            RETURN;
        END IF;

        SELECT MIN(contract_url_id) INTO l_contract_url_id
            FROM ph_erp_contract_urls
            WHERE contract_id = p_contract_id
                AND is_active = 1
                AND is_deleted = 0;

        IF l_contract_url_id IS NOT NULL THEN
            set_primary_url(l_contract_url_id, p_updated_by);
        END IF;
    END ensure_primary_url;

    ----------------------------------------------------------------------
    -- Public requirement wrappers
    ----------------------------------------------------------------------

PROCEDURE require_active_customer(p_customer_id IN NUMBER) IS
    BEGIN
        IF is_active_customer(p_customer_id) = 0 THEN
            RAISE_APPLICATION_ERROR(-20201, ph_localization_pkg.localized_text('Customer is not active or was not found.', 'ط·آ§ط¸â€‍ط·آ¹ط¸â€¦ط¸ظ¹ط¸â€‍ ط·ط›ط¸ظ¹ط·آ± ط¸â€ ط·آ´ط·آ· ط·آ£ط¸ث† ط·ط›ط¸ظ¹ط·آ± ط¸â€¦ط¸ث†ط·آ¬ط¸ث†ط·آ¯.'));
        END IF;
    END require_active_customer;

PROCEDURE require_valid_contract_module(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER) IS
    BEGIN
        IF is_module_valid_for_contract(p_contract_id, p_product_id, p_module_id) = 0 THEN
            RAISE_APPLICATION_ERROR(-20202, ph_localization_pkg.localized_text('Module is not valid for the selected contract.', 'ط·آ§ط¸â€‍ط¸ث†ط·آ­ط·آ¯ط·آ© ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ§ط¸â€‍ط·آ­ط·آ© ط¸â€‍ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯ ط·آ§ط¸â€‍ط¸â€¦ط·آ­ط·آ¯ط·آ¯.'));
        END IF;
    END require_valid_contract_module;

PROCEDURE require_valid_contract_feature(p_contract_id IN NUMBER, p_product_id IN NUMBER, p_module_id IN NUMBER, p_platform_id IN NUMBER, p_feature_id IN NUMBER) IS
    BEGIN
        IF is_feature_valid_for_contract(p_contract_id, p_product_id, p_module_id, p_platform_id, p_feature_id) = 0 THEN
            RAISE_APPLICATION_ERROR(-20203, ph_localization_pkg.localized_text('Feature is not valid for the selected contract module.', 'ط·آ§ط¸â€‍ط¸â€¦ط¸ظ¹ط·آ²ط·آ© ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ§ط¸â€‍ط·آ­ط·آ© ط¸â€‍ط¸ث†ط·آ­ط·آ¯ط·آ© ط·آ§ط¸â€‍ط·آ¹ط¸â€ڑط·آ¯ ط·آ§ط¸â€‍ط¸â€¦ط·آ­ط·آ¯ط·آ¯ط·آ©.'));
        END IF;
    END require_valid_contract_feature;
END ph_erp_contract_pkg;
/

