/*
ProductHub Manager - Contract Module Views
Target DBMS: Oracle Database 21c+
*/

CREATE OR REPLACE VIEW vw_ph_erp_customer_subscriptions AS
SELECT
    c.customer_id,
    c.customer_name,
    ct.contract_id,
    ct.contract_no,
    ct.is_active AS contract_is_active,
    ct.payment_cycle,
    ct.start_date,
    ct.end_date,
    p.product_id,
    p.product_name_en,
    p.product_name_ar,
    m.module_id,
    m.module_name_en,
    m.module_name_ar,
    cm.is_active AS module_subscription_is_active,
    cp.platform_id,
    pl.platform_name_en,
    pl.platform_name_ar,
    cp.is_active AS platform_subscription_is_active,
    cf.feature_id,
    f.feature_name_en,
    f.feature_name_ar,
    NVL(cf.agreed_price, f.price) AS subscribed_price,
    cf.is_active AS feature_subscription_is_active
FROM ph_erp_customers c
JOIN ph_erp_contracts ct
    ON ct.customer_id = c.customer_id
    AND ct.is_deleted = 0
JOIN ph_erp_products p
    ON p.product_id = ct.product_id
    AND p.is_deleted = 0
JOIN ph_erp_contract_modules cm
    ON cm.contract_id = ct.contract_id
    AND cm.product_id = ct.product_id
    AND cm.is_deleted = 0
JOIN ph_erp_modules m
    ON m.product_id = cm.product_id
    AND m.module_id = cm.module_id
    AND m.is_deleted = 0
JOIN ph_erp_contract_platforms cp
    ON cp.contract_id = cm.contract_id
    AND cp.product_id = cm.product_id
    AND cp.module_id = cm.module_id
    AND cp.is_deleted = 0
JOIN ph_erp_contract_features cf
    ON cf.contract_id = cp.contract_id
    AND cf.product_id = cp.product_id
    AND cf.module_id = cp.module_id
    AND cf.platform_id = cp.platform_id
    AND cf.is_deleted = 0
JOIN ph_erp_platform_lkp pl
    ON pl.platform_id = cp.platform_id
    AND pl.is_deleted = 0
JOIN ph_erp_features f
    ON f.product_id = cf.product_id
    AND f.module_id = cf.module_id
    AND f.platform_id = cf.platform_id
    AND f.feature_id = cf.feature_id
    AND f.is_deleted = 0
WHERE c.is_deleted = 0;
