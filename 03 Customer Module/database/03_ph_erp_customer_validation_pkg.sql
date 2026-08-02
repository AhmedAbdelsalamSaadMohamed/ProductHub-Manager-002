/*
ProductHub Manager - Customer Validation Package
Target DBMS: Oracle Database 21c+

Purpose:
- Validation service layer for ph_erp_customer_pkg actions.
- Each procedure returns o_is_valid as 1 or 0 and o_validation_message.
*/

CREATE OR REPLACE PACKAGE ph_erp_customer_validation_pkg AS
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

    PROCEDURE validate_create_customer(p_customer_name IN VARCHAR2, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_customer(p_customer_id IN NUMBER, p_customer_name IN VARCHAR2 DEFAULT NULL, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);

    PROCEDURE validate_create_customer_user(p_customer_id IN NUMBER, p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_is_initial_admin IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_update_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_email IN VARCHAR2 DEFAULT NULL, p_display_name IN VARCHAR2 DEFAULT NULL, p_is_initial_admin IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_delete_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
    PROCEDURE validate_restore_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2);
END ph_erp_customer_validation_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_erp_customer_validation_pkg AS
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
        INSERT INTO ph_erp_customer_error_log (
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

    FUNCTION exists_customer(p_customer_id IN NUMBER, p_active_only IN NUMBER DEFAULT 0, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_customers
            WHERE customer_id = p_customer_id
                AND (p_include_deleted = 1 OR is_deleted = 0)
                AND (p_active_only = 0 OR is_active = 1);
        RETURN ph_helpers_pkg.yes_no(l_count);
    END exists_customer;

    FUNCTION exists_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_include_deleted IN NUMBER DEFAULT 0) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_sec_users
            WHERE user_id = p_user_id
                AND customer_id = p_customer_id
                AND user_type = 2
                AND (p_include_deleted = 1 OR is_deleted = 0);
        RETURN ph_helpers_pkg.yes_no(l_count);
    END exists_customer_user;

    FUNCTION duplicate_customer_name(p_customer_name IN VARCHAR2, p_customer_id IN NUMBER DEFAULT NULL) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_customers
            WHERE UPPER(customer_name) = UPPER(TRIM(p_customer_name))
                AND is_deleted = 0
                AND (p_customer_id IS NULL OR customer_id <> p_customer_id);
        RETURN ph_helpers_pkg.yes_no(l_count);
    END duplicate_customer_name;

    FUNCTION duplicate_user_email(p_email IN VARCHAR2, p_user_id IN NUMBER DEFAULT NULL) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_sec_users
            WHERE email = LOWER(TRIM(p_email))
                AND (p_user_id IS NULL OR user_id <> p_user_id);
        RETURN ph_helpers_pkg.yes_no(l_count);
    END duplicate_user_email;

    FUNCTION has_active_contract(p_customer_id IN NUMBER) RETURN NUMBER IS
        l_count NUMBER(10);
    BEGIN
        SELECT COUNT(*)
            INTO l_count
            FROM ph_erp_contracts
            WHERE customer_id = p_customer_id
                AND is_active = 1
                AND is_deleted = 0;
        RETURN ph_helpers_pkg.yes_no(l_count);
    END has_active_contract;

    PROCEDURE validate_customer_values(
        p_customer_name      IN VARCHAR2,
        p_legal_name         IN VARCHAR2,
        p_contact_email      IN VARCHAR2,
        p_contact_phone      IN VARCHAR2,
        p_required_name      IN NUMBER,
        o_is_valid           OUT NUMBER,
        o_validation_message OUT VARCHAR2
    ) IS
    BEGIN
        IF p_required_name = 1 AND ph_helpers_pkg.text_missing(p_customer_name) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer name is required.');
        ELSIF p_customer_name IS NOT NULL AND ph_helpers_pkg.text_missing(p_customer_name) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer name is required.');
        ELSIF ph_helpers_pkg.text_too_long(p_customer_name, 250) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer name must not exceed 250 characters.');
        ELSIF ph_helpers_pkg.text_too_long(p_legal_name, 250) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Legal name must not exceed 250 characters.');
        ELSIF ph_helpers_pkg.text_too_long(p_contact_email, 320) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contact email must not exceed 320 characters.');
        ELSIF ph_helpers_pkg.text_too_long(p_contact_phone, 50) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Contact phone must not exceed 50 characters.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_customer_values;

    PROCEDURE validate_user_values(
        p_email              IN VARCHAR2,
        p_display_name       IN VARCHAR2,
        p_required_text      IN NUMBER,
        o_is_valid           OUT NUMBER,
        o_validation_message OUT VARCHAR2
    ) IS
    BEGIN
        IF p_required_text = 1 AND ph_helpers_pkg.text_missing(p_email) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Email is required.');
        ELSIF p_required_text = 1 AND ph_helpers_pkg.text_missing(p_display_name) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Display name is required.');
        ELSIF p_email IS NOT NULL AND ph_helpers_pkg.text_missing(p_email) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Email is required.');
        ELSIF p_display_name IS NOT NULL AND ph_helpers_pkg.text_missing(p_display_name) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Display name is required.');
        ELSIF ph_helpers_pkg.text_too_long(p_email, 320) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Email must not exceed 320 characters.');
        ELSIF ph_helpers_pkg.text_too_long(p_display_name, 200) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Display name must not exceed 200 characters.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_user_values;

    PROCEDURE validate_create_customer(p_customer_name IN VARCHAR2, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'CUSTOMERS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;

        validate_customer_values(p_customer_name, p_legal_name, p_contact_email, p_contact_phone, 1, o_is_valid, o_validation_message);
        IF o_is_valid = 1 AND duplicate_customer_name(p_customer_name) = 1 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer name already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, SQLERRM);
    END validate_create_customer;

    PROCEDURE validate_update_customer(p_customer_id IN NUMBER, p_customer_name IN VARCHAR2 DEFAULT NULL, p_legal_name IN VARCHAR2 DEFAULT NULL, p_contact_email IN VARCHAR2 DEFAULT NULL, p_contact_phone IN VARCHAR2 DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CUSTOMERS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;

        IF exists_customer(p_customer_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer was not found.');
        ELSIF NOT ph_helpers_pkg.valid_flag(p_is_active) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Active flag must be 0 or 1.');
        ELSE
            validate_customer_values(p_customer_name, p_legal_name, p_contact_email, p_contact_phone, 0, o_is_valid, o_validation_message);
            IF o_is_valid = 1 AND p_customer_name IS NOT NULL AND duplicate_customer_name(p_customer_name, p_customer_id) = 1 THEN
                ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer name already exists.');
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, SQLERRM);
    END validate_update_customer;

    PROCEDURE validate_delete_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CUSTOMERS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;

        IF exists_customer(p_customer_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer was not found.');
        ELSIF has_active_contract(p_customer_id) = 1 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer has active contracts.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_customer;

    PROCEDURE validate_restore_customer(p_customer_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CUSTOMERS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;

        IF exists_customer(p_customer_id, 0, 1) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer was not found.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_customer;

    PROCEDURE validate_create_customer_user(p_customer_id IN NUMBER, p_email IN VARCHAR2, p_display_name IN VARCHAR2, p_is_initial_admin IN NUMBER DEFAULT 0, p_created_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_created_by, 'CUSTOMERS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;

        IF exists_customer(p_customer_id, 1) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer is not active or was not found.');
        ELSIF NOT ph_helpers_pkg.valid_flag(p_is_initial_admin) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Initial admin flag must be 0 or 1.');
        ELSE
            validate_user_values(p_email, p_display_name, 1, o_is_valid, o_validation_message);
            IF o_is_valid = 1 AND duplicate_user_email(p_email) = 1 THEN
                ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Email already exists.');
            END IF;
        END IF;
    END validate_create_customer_user;

    PROCEDURE validate_update_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_email IN VARCHAR2 DEFAULT NULL, p_display_name IN VARCHAR2 DEFAULT NULL, p_is_initial_admin IN NUMBER DEFAULT NULL, p_is_active IN NUMBER DEFAULT NULL, p_updated_by IN NUMBER DEFAULT NULL, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CUSTOMERS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;

        IF exists_customer(p_customer_id, 1) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer is not active or was not found.');
        ELSIF exists_customer_user(p_user_id, p_customer_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer user was not found.');
        ELSIF NOT ph_helpers_pkg.valid_flag(p_is_initial_admin) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Initial admin flag must be 0 or 1.');
        ELSIF NOT ph_helpers_pkg.valid_flag(p_is_active) THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Active flag must be 0 or 1.');
        ELSE
            validate_user_values(p_email, p_display_name, 0, o_is_valid, o_validation_message);
            IF o_is_valid = 1 AND p_email IS NOT NULL AND duplicate_user_email(p_email, p_user_id) = 1 THEN
                ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Email already exists.');
            END IF;
        END IF;
    END validate_update_customer_user;

    PROCEDURE validate_delete_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CUSTOMERS', 'DELETE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;

        IF exists_customer_user(p_user_id, p_customer_id) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer user was not found.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_delete_customer_user;

    PROCEDURE validate_restore_customer_user(p_user_id IN NUMBER, p_customer_id IN NUMBER, p_updated_by IN NUMBER, o_is_valid OUT NUMBER, o_validation_message OUT VARCHAR2) IS
    BEGIN
        IF ph_sec_authorization_pkg.permission_is_valid(p_updated_by, 'CUSTOMERS', 'MANAGE', o_is_valid, o_validation_message) = 0 THEN
            RETURN;
        END IF;

        IF exists_customer(p_customer_id, 1) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer is not active or was not found.');
        ELSIF exists_customer_user(p_user_id, p_customer_id, 1) = 0 THEN
            ph_helpers_pkg.set_invalid(o_is_valid, o_validation_message, 'Customer user was not found.');
        ELSE
            ph_helpers_pkg.set_valid(o_is_valid, o_validation_message);
        END IF;
    END validate_restore_customer_user;
END ph_erp_customer_validation_pkg;
/
