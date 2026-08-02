/*
ProductHub Manager - Customer LOV Package
Target DBMS: Oracle Database 21c+

Purpose:
- Customer entity LOV functions.
- Global lookup LOVs live in ph_globalization_lov_pkg.
*/

CREATE OR REPLACE PACKAGE ph_erp_customer_lov_pkg AS
    FUNCTION customers(p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION customer_display_value(p_return_value IN VARCHAR2, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
    FUNCTION customer_users(p_customer_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION customer_user_display_value(p_return_value IN VARCHAR2, p_customer_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
END ph_erp_customer_lov_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_erp_customer_lov_pkg AS
    FUNCTION localized_name(p_text_en IN VARCHAR2, p_text_ar IN VARCHAR2, p_language IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_localization_pkg.localized_text(p_text_en, p_text_ar, p_language);
    END localized_name;

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

    FUNCTION customer_display_value(p_return_value IN VARCHAR2, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_customer_lov_pkg.customers(p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END customer_display_value;

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

    FUNCTION customer_user_display_value(p_return_value IN VARCHAR2, p_customer_id IN NUMBER DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_erp_customer_lov_pkg.customer_users(p_customer_id => p_customer_id, p_active_only => p_active_only))
         WHERE return_value = TRIM(p_return_value)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_return_value;
    END customer_user_display_value;
END ph_erp_customer_lov_pkg;
/