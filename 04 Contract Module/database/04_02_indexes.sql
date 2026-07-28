/*
ProductHub Manager - Contract Module Indexes
Target DBMS: Oracle Database 21c+
*/

CREATE INDEX ix_ph_erp_cu_contract
    ON ph_erp_contract_urls ( contract_id, is_deleted, is_active, is_primary );

CREATE INDEX ix_ph_erp_contracts_customer
    ON ph_erp_contracts ( customer_id, is_deleted, is_active, start_date, end_date );

CREATE INDEX ix_ph_erp_contracts_product
    ON ph_erp_contracts ( product_id, is_deleted, is_active );

CREATE INDEX ix_ph_erp_contracts_cycle
    ON ph_erp_contracts ( payment_cycle, is_deleted, is_active, customer_id );

CREATE INDEX ix_ph_erp_cm_contract_active
    ON ph_erp_contract_modules ( contract_id, is_deleted, is_active, product_id, module_id );

CREATE INDEX ix_ph_erp_cm_module
    ON ph_erp_contract_modules ( product_id, module_id, is_deleted, is_active );

CREATE INDEX ix_ph_erp_cp_contract_active
    ON ph_erp_contract_platforms ( contract_id, product_id, module_id, is_deleted, is_active, platform_id );

CREATE INDEX ix_ph_erp_cp_platform
    ON ph_erp_contract_platforms ( product_id, module_id, platform_id, is_deleted, is_active );

CREATE INDEX ix_ph_erp_cf_contract_active
    ON ph_erp_contract_features ( contract_id, product_id, module_id, is_deleted, is_active, platform_id, feature_id );

CREATE INDEX ix_ph_erp_cf_feature
    ON ph_erp_contract_features ( product_id, module_id, platform_id, feature_id, is_deleted, is_active );
