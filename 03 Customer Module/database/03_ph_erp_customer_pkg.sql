/*
ProductHub Manager - Customer Management Package
Target DBMS: Oracle Database 21c+
*/

CREATE OR REPLACE PACKAGE ph_erp_customer_pkg AS
    ----------------------------------------------------------------------
    -- Read operations
    ----------------------------------------------------------------------
    FUNCTION get_customers(p_customer_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;
    FUNCTION get_customer_users(p_customer_id IN NUMBER DEFAULT NULL, p_user_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR;

    ----------------------------------------------------------------------
    -- Create/update/delete/restore operations
    ----------------------------------------------------------------------
    PROCEDURE create_customer(p_customer_name IN VARCHAR2, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_customer_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE put_customer(p_customer_name IN VARCHAR2, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_customer_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_customer(p_customer_id IN NUMBER, p_customer_name IN VARCHAR2 DEFAULT NULL, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE create_customer_user(p_customer_id IN NUMBER, p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_is_initial_admin IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_user_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE put_customer_user(p_customer_id IN NUMBER, p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_is_initial_admin IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_user_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE update_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_email IN VARCHAR2 DEFAULT NULL, p_display_name IN VARCHAR2 DEFAULT NULL, p_is_initial_admin IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE delete_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
    PROCEDURE restore_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2);
END ph_erp_customer_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_erp_customer_pkg AS
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

FUNCTION has_initial_admin(p_customer_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count
            FROM ph_sec_users
            WHERE customer_id = p_customer_id
                AND is_initial_admin = 1
                AND is_active = 1
                AND is_deleted = 0;
        RETURN bool_to_number(l_count);
    END has_initial_admin;

FUNCTION has_active_contract(p_customer_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*) INTO l_count
            FROM ph_erp_contracts
            WHERE customer_id = p_customer_id
                AND is_active = 1
                AND is_deleted = 0;
        RETURN bool_to_number(l_count);
    END has_active_contract;

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

PROCEDURE set_error(p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_error_code      NUMBER := SQLCODE;
        l_error_message   VARCHAR2(4000) := SQLERRM;
        l_error_stack     CLOB := DBMS_UTILITY.FORMAT_ERROR_STACK;
        l_error_backtrace CLOB := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    BEGIN
        ph_erp_customer_validation_pkg.log_error(
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

FUNCTION get_customers(p_customer_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT customer_id,
        customer_name,
        legal_name,
        contact_email,
        contact_phone,
        is_active,
        created_by,
        created_at,
        updated_by,
        updated_at
            FROM ph_erp_customers
            WHERE (p_customer_id IS NULL OR customer_id = p_customer_id)
                AND (p_is_active IS NULL OR is_active = p_is_active)
                AND is_deleted = 0
            ORDER BY customer_name, customer_id;
        RETURN l_result;
    END get_customers;

FUNCTION get_customer_users(p_customer_id IN NUMBER DEFAULT NULL, p_user_id IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL) RETURN SYS_REFCURSOR IS
        l_result SYS_REFCURSOR;
    BEGIN
        OPEN l_result FOR
        SELECT u.user_id,
        u.customer_id,
        c.customer_name,
        u.user_type,
        u.email,
        u.display_name,
        u.must_change_password,
        u.is_initial_admin,
        u.is_active,
        u.last_login_at,
        u.created_by,
        u.created_at,
        u.updated_by,
        u.updated_at
            FROM ph_sec_users u
        LEFT JOIN ph_erp_customers c
            ON c.customer_id = u.customer_id
                AND c.is_deleted = 0
            WHERE (p_customer_id IS NULL OR u.customer_id = p_customer_id)
                AND (p_user_id IS NULL OR u.user_id = p_user_id)
                AND (p_is_active IS NULL OR u.is_active = p_is_active)
                AND u.is_deleted = 0
            ORDER BY u.customer_id, u.display_name, u.user_id;
        RETURN l_result;
    END get_customer_users;

PROCEDURE do_update_customer(
        p_customer_id   IN NUMBER,
        p_customer_name IN VARCHAR2 DEFAULT NULL,
        p_legal_name    IN VARCHAR2 DEFAULT NULL,
        p_contact_email IN VARCHAR2 DEFAULT NULL,
        p_contact_phone IN VARCHAR2 DEFAULT NULL,
        p_is_active     IN NUMBER DEFAULT NULL,
        p_updated_by    IN NUMBER DEFAULT NULL
    ) IS
        l_exists NUMBER;
    BEGIN
        SELECT COUNT(*) INTO l_exists FROM ph_erp_customers WHERE customer_id = p_customer_id AND is_deleted = 0;
        IF l_exists = 0 THEN
            RAISE_APPLICATION_ERROR(-20210, ph_localization_pkg.localized_text('Customer was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ§ط¸â€‍ط·آ¹ط¸â€¦ط¸ظ¹ط¸â€‍.'));
        END IF;

        UPDATE ph_erp_customers
            SET customer_name = CASE WHEN p_customer_name IS NOT NULL THEN TRIM(p_customer_name) ELSE customer_name END,
                legal_name = CASE WHEN p_legal_name IS NOT NULL THEN TRIM(p_legal_name) ELSE legal_name END,
                contact_email = CASE WHEN p_contact_email IS NOT NULL THEN LOWER(TRIM(p_contact_email)) ELSE contact_email END,
                contact_phone = CASE WHEN p_contact_phone IS NOT NULL THEN TRIM(p_contact_phone) ELSE contact_phone END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by
            WHERE customer_id = p_customer_id
                AND ((p_customer_name IS NOT NULL AND DECODE(customer_name, TRIM(p_customer_name), 0, 1) = 1)
                OR (p_legal_name IS NOT NULL AND DECODE(legal_name, TRIM(p_legal_name), 0, 1) = 1)
                OR (p_contact_email IS NOT NULL AND DECODE(contact_email, LOWER(TRIM(p_contact_email)), 0, 1) = 1)
                OR (p_contact_phone IS NOT NULL AND DECODE(contact_phone, TRIM(p_contact_phone), 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));
    END do_update_customer;

PROCEDURE do_delete_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_customers
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE customer_id = p_customer_id
                AND is_deleted = 0;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20210, ph_localization_pkg.localized_text('Customer was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ§ط¸â€‍ط·آ¹ط¸â€¦ط¸ظ¹ط¸â€‍.'));
        END IF;
    END do_delete_customer;

PROCEDURE do_restore_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_erp_customers
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by,
                updated_at = SYSTIMESTAMP
            WHERE customer_id = p_customer_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20210, ph_localization_pkg.localized_text('Customer was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط·آ§ط¸â€‍ط·آ¹ط¸â€¦ط¸ظ¹ط¸â€‍.'));
        END IF;
    END do_restore_customer;

    ----------------------------------------------------------------------
    -- Customer user create/update/delete implementations
    ----------------------------------------------------------------------

PROCEDURE do_update_customer_user(
        p_user_id           IN NUMBER,
        p_customer_id       IN NUMBER,
        p_email             IN VARCHAR2 DEFAULT NULL,
        p_display_name      IN VARCHAR2 DEFAULT NULL,
        p_is_initial_admin  IN NUMBER DEFAULT NULL,
        p_is_active         IN NUMBER DEFAULT NULL,
        p_updated_by        IN NUMBER DEFAULT NULL
    ) IS
        l_exists NUMBER;
    BEGIN
        require_active_customer(p_customer_id);

        SELECT COUNT(*) INTO l_exists
            FROM ph_sec_users
            WHERE user_id = p_user_id
                AND customer_id = p_customer_id
                AND user_type = 2
                AND is_deleted = 0;
        IF l_exists = 0 THEN
            RAISE_APPLICATION_ERROR(-20220, ph_localization_pkg.localized_text('Customer user was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط¸â€¦ط·آ³ط·ع¾ط·آ®ط·آ¯ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط¸â€¦ط¸ظ¹ط¸â€‍.'));
        END IF;

        UPDATE ph_sec_users
            SET email = CASE WHEN p_email IS NOT NULL THEN LOWER(TRIM(p_email)) ELSE email END,
                display_name = CASE WHEN p_display_name IS NOT NULL THEN TRIM(p_display_name) ELSE display_name END,
                is_initial_admin = CASE WHEN p_is_initial_admin IS NOT NULL THEN p_is_initial_admin ELSE is_initial_admin END,
                is_active = CASE WHEN p_is_active IS NOT NULL THEN p_is_active ELSE is_active END,
                updated_by = p_updated_by
            WHERE user_id = p_user_id
                AND customer_id = p_customer_id
                AND user_type = 2
                AND ((p_email IS NOT NULL AND DECODE(email, LOWER(TRIM(p_email)), 0, 1) = 1)
                OR (p_display_name IS NOT NULL AND DECODE(display_name, TRIM(p_display_name), 0, 1) = 1)
                OR (p_is_initial_admin IS NOT NULL AND DECODE(is_initial_admin, p_is_initial_admin, 0, 1) = 1)
                OR (p_is_active IS NOT NULL AND DECODE(is_active, p_is_active, 0, 1) = 1));
    END do_update_customer_user;

PROCEDURE do_delete_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        UPDATE ph_sec_users
            SET is_deleted = 1,
                updated_by = p_updated_by
            WHERE user_id = p_user_id
                AND customer_id = p_customer_id
                AND user_type = 2
                AND is_deleted = 0;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20220, ph_localization_pkg.localized_text('Customer user was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط¸â€¦ط·آ³ط·ع¾ط·آ®ط·آ¯ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط¸â€¦ط¸ظ¹ط¸â€‍.'));
        END IF;
    END do_delete_customer_user;

PROCEDURE do_restore_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER) IS
    BEGIN
        require_active_customer(p_customer_id);

        UPDATE ph_sec_users
            SET is_deleted = 0,
                deleted_by = NULL,
                deleted_at = NULL,
                updated_by = p_updated_by,
                updated_at = SYSTIMESTAMP
            WHERE user_id = p_user_id
                AND customer_id = p_customer_id
                AND user_type = 2;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20220, ph_localization_pkg.localized_text('Customer user was not found.', 'ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° ط¸â€¦ط·آ³ط·ع¾ط·آ®ط·آ¯ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط¸â€¦ط¸ظ¹ط¸â€‍.'));
        END IF;
    END do_restore_customer_user;

    ----------------------------------------------------------------------
    -- Contract create/update/delete implementations
    ----------------------------------------------------------------------

PROCEDURE create_customer(p_customer_name IN VARCHAR2, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_customer_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_customer_validation_pkg.validate_create_customer(p_customer_name, p_legal_name, p_contact_email, p_contact_phone, p_created_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        require_text(p_customer_name, 'Customer name');

        INSERT INTO ph_erp_customers (
        customer_name, legal_name, contact_email, contact_phone, is_active, created_by
        ) VALUES (
        TRIM(p_customer_name), TRIM(p_legal_name), LOWER(TRIM(p_contact_email)), TRIM(p_contact_phone), 1, p_created_by
        ) RETURNING customer_id INTO p_customer_id;

        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Customer created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_customer;

PROCEDURE put_customer(p_customer_name IN VARCHAR2, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, p_customer_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_customer_id NUMBER;
    BEGIN
        SELECT MIN(customer_id) INTO l_customer_id
          FROM ph_erp_customers
         WHERE customer_name = TRIM(p_customer_name);

        IF l_customer_id IS NOT NULL THEN
            p_customer_id := l_customer_id;
            restore_customer(l_customer_id, p_created_by, p_result_code, p_result_message);
            IF p_result_code <> 'S' THEN RETURN; END IF;
            update_customer(l_customer_id, p_customer_name, p_legal_name, p_contact_email, p_contact_phone, 1, p_created_by, p_result_code, p_result_message);
            RETURN;
        END IF;

        create_customer(p_customer_name, p_legal_name, p_contact_email, p_contact_phone, p_created_by, p_customer_id, p_result_code, p_result_message);
    END put_customer;

PROCEDURE update_customer(p_customer_id IN NUMBER, p_customer_name IN VARCHAR2 DEFAULT NULL, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_customer_validation_pkg.validate_update_customer(p_customer_id, p_customer_name, p_legal_name, p_contact_email, p_contact_phone, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_customer(p_customer_id, p_customer_name, p_legal_name, p_contact_email, p_contact_phone, p_is_active, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Customer updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_customer;

PROCEDURE delete_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_customer_validation_pkg.validate_delete_customer(p_customer_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_customer(p_customer_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Customer deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_customer;

PROCEDURE restore_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_customer_validation_pkg.validate_restore_customer(p_customer_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_customer(p_customer_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Customer restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_customer;

PROCEDURE create_customer_user(p_customer_id IN NUMBER, p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_is_initial_admin IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_user_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_customer_validation_pkg.validate_create_customer_user(p_customer_id, p_email, p_display_name, p_is_initial_admin, p_created_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        require_active_customer(p_customer_id);
        require_text(p_email, 'Email');
        require_text(p_display_name, 'Display name');
        require_flag(p_is_initial_admin, 'Initial admin flag');

        INSERT INTO ph_sec_users (
        customer_id,
        user_type,
        email,
        display_name,
        must_change_password,
        is_initial_admin,
        is_active,
        created_by
        ) VALUES (
        p_customer_id,
        2,
        LOWER(TRIM(p_email)),
        TRIM(p_display_name),
        1,
        p_is_initial_admin,
        1,
        p_created_by
        ) RETURNING user_id INTO p_user_id;

        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Customer user created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END create_customer_user;

PROCEDURE put_customer_user(p_customer_id IN NUMBER, p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_is_initial_admin IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, p_user_id OUT NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_user_id NUMBER;
    BEGIN
        SELECT MIN(user_id) INTO l_user_id
          FROM ph_sec_users
         WHERE email = LOWER(TRIM(p_email));

        IF l_user_id IS NOT NULL THEN
            p_user_id := l_user_id;
            restore_customer_user(l_user_id, p_customer_id, p_created_by, p_result_code, p_result_message);
            IF p_result_code <> 'S' THEN RETURN; END IF;
            update_customer_user(l_user_id, p_customer_id, p_email, p_display_name, p_is_initial_admin, 1, p_created_by, p_result_code, p_result_message);
            RETURN;
        END IF;

        create_customer_user(p_customer_id, p_email, p_display_name, p_is_initial_admin, p_created_by, p_user_id, p_result_code, p_result_message);
    END put_customer_user;

PROCEDURE update_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_email IN VARCHAR2 DEFAULT NULL, p_display_name IN VARCHAR2 DEFAULT NULL, p_is_initial_admin IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_customer_validation_pkg.validate_update_customer_user(p_user_id, p_customer_id, p_email, p_display_name, p_is_initial_admin, p_is_active, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_update_customer_user(p_user_id, p_customer_id, p_email, p_display_name, p_is_initial_admin, p_is_active, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Customer user updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END update_customer_user;

PROCEDURE delete_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_customer_validation_pkg.validate_delete_customer_user(p_user_id, p_customer_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_delete_customer_user(p_user_id, p_customer_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Customer user deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END delete_customer_user;

PROCEDURE restore_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER, p_result_code OUT VARCHAR2, p_result_message OUT VARCHAR2) IS
        l_is_valid NUMBER;
        l_validation_message VARCHAR2(4000);
    BEGIN
        ph_erp_customer_validation_pkg.validate_restore_customer_user(p_user_id, p_customer_id, p_updated_by, l_is_valid, l_validation_message);
        raise_when_invalid(l_is_valid, l_validation_message);
        do_restore_customer_user(p_user_id, p_customer_id, p_updated_by);
        ph_helpers_pkg.set_success(p_result_code, p_result_message, 'Customer user restored successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            set_error(p_result_code, p_result_message);
    END restore_customer_user;

PROCEDURE require_active_customer(p_customer_id IN NUMBER) IS
    BEGIN
        IF is_active_customer(p_customer_id) = 0 THEN
            RAISE_APPLICATION_ERROR(-20201, ph_localization_pkg.localized_text('Customer is not active or was not found.', 'ط·آ§ط¸â€‍ط·آ¹ط¸â€¦ط¸ظ¹ط¸â€‍ ط·ط›ط¸ظ¹ط·آ± ط¸â€ ط·آ´ط·آ· ط·آ£ط¸ث† ط·ط›ط¸ظ¹ط·آ± ط¸â€¦ط¸ث†ط·آ¬ط¸ث†ط·آ¯.'));
        END IF;
    END require_active_customer;
END ph_erp_customer_pkg;
/

