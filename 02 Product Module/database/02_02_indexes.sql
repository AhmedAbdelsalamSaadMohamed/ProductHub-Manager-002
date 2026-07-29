/*
ProductHub Manager - Product Module Indexes
Target DBMS: Oracle Database 21c+
*/

CREATE INDEX ix_ph_erp_price_unit_active
    ON ph_erp_pricing_unit_lkp ( is_deleted, is_active, pricing_unit_name_en, pricing_unit_id );

CREATE INDEX ix_ph_erp_pay_cycle_active
    ON ph_erp_payment_cycle_lkp ( is_deleted, is_active, months_count, payment_cycle_id );

CREATE INDEX ix_ph_erp_platform_active
    ON ph_erp_platform_lkp ( is_deleted, is_active, platform_name_en, platform_id );

CREATE INDEX ix_ph_erp_products_active
    ON ph_erp_products ( is_deleted, is_active, product_name_en, product_id );

CREATE INDEX ix_ph_erp_products_name_en
    ON ph_erp_products ( product_name_en );

CREATE INDEX ix_ph_erp_products_name_ar
    ON ph_erp_products ( product_name_ar );

CREATE INDEX ix_ph_erp_modules_product
    ON ph_erp_modules ( product_id, is_deleted, is_active, display_order, module_id );

CREATE INDEX ix_ph_erp_modules_name_en
    ON ph_erp_modules ( module_name_en );

CREATE INDEX ix_ph_erp_modules_name_ar
    ON ph_erp_modules ( module_name_ar );

CREATE INDEX ix_ph_erp_features_scope
    ON ph_erp_features ( product_id, module_id, platform_id, is_deleted, is_active, display_order );

CREATE INDEX ix_ph_erp_features_name_en
    ON ph_erp_features ( feature_name_en );

CREATE INDEX ix_ph_erp_features_name_ar
    ON ph_erp_features ( feature_name_ar );

CREATE INDEX ix_ph_erp_features_unit
    ON ph_erp_features ( pricing_unit_id, is_deleted, is_active, product_id, module_id, platform_id );

CREATE INDEX ix_ph_erp_mp_platform
    ON ph_erp_module_platforms ( platform_id, product_id, module_id );

CREATE INDEX ix_ph_erp_prod_err_log_date
    ON ph_erp_product_error_log ( error_date DESC );

CREATE INDEX ix_ph_erp_prod_err_log_unit
    ON ph_erp_product_error_log ( program_unit, error_date DESC );

CREATE INDEX ix_ph_erp_prod_err_log_code
    ON ph_erp_product_error_log ( error_code, error_date DESC );
