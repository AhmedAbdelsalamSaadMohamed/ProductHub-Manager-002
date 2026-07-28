/*
ProductHub Manager - Customer Module Views
Target DBMS: Oracle Database 21c+
*/

CREATE OR REPLACE VIEW vw_ph_erp_customer_onboarding AS
SELECT
    c.customer_id,
    c.customer_name,
    p.product_id,
    p.product_name_en,
    p.product_name_ar,
    ct.contract_id,
    ct.contract_no,
    ct.is_active AS contract_is_active,
    cu.access_url,
    u.user_id AS initial_admin_user_id,
    u.email AS initial_admin_email,
    u.display_name AS initial_admin_name
FROM ph_erp_customers c
JOIN ph_erp_contracts ct
    ON ct.customer_id = c.customer_id
    AND ct.is_deleted = 0
JOIN ph_erp_products p
    ON p.product_id = ct.product_id
    AND p.is_deleted = 0
LEFT JOIN ph_erp_contract_urls cu
    ON cu.contract_id = ct.contract_id
    AND cu.is_active = 1
    AND cu.is_primary = 1
    AND cu.is_deleted = 0
LEFT JOIN ph_sec_users u
    ON u.customer_id = c.customer_id
    AND u.is_initial_admin = 1
    AND u.is_active = 1
    AND u.is_deleted = 0
WHERE c.is_deleted = 0;
