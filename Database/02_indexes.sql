/*
    ProductHub Manager - Oracle Indexes
*/

CREATE UNIQUE INDEX ux_ph_languages_default
    ON ph_languages ( CASE WHEN is_default = 1 THEN is_default END );

CREATE INDEX ix_ph_languages_active
    ON ph_languages ( is_deleted, is_active, language_code );

CREATE INDEX ix_ph_i18n_lookup
    ON ph_i18n_texts ( is_deleted, entity_name, entity_key, field_name, language_code );

CREATE INDEX ix_ph_i18n_language
    ON ph_i18n_texts ( is_deleted, language_code, entity_name, field_name );

CREATE INDEX ix_ph_i18n_messages_language
    ON ph_i18n_messages ( is_deleted, language_code, message_code );

------------------------------------------------------------
-- ERP lookup indexes
------------------------------------------------------------

CREATE INDEX ix_ph_erp_price_unit_active
    ON ph_erp_pricing_unit_lkp ( is_deleted, is_active, pricing_unit_name_en, pricing_unit_id );

CREATE INDEX ix_ph_erp_pay_cycle_active
    ON ph_erp_payment_cycle_lkp ( is_deleted, is_active, months_count, payment_cycle_id );

CREATE INDEX ix_ph_erp_platform_active
    ON ph_erp_platform_lkp ( is_deleted, is_active, platform_name_en, platform_id );

------------------------------------------------------------
-- ERP catalog indexes
------------------------------------------------------------

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

------------------------------------------------------------
-- ERP customer and contract indexes
------------------------------------------------------------

CREATE INDEX ix_ph_erp_customers_active
    ON ph_erp_customers ( is_deleted, is_active, customer_name, customer_id );

CREATE INDEX ix_ph_erp_customers_email
    ON ph_erp_customers ( LOWER(contact_email) );

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

------------------------------------------------------------
-- Security user and preference indexes
------------------------------------------------------------

CREATE INDEX ix_ph_sec_user_type_active
    ON ph_sec_user_type_lkp ( is_deleted, is_active, user_type_name_en, user_type_id );

CREATE INDEX ix_ph_sec_users_lower_email
    ON ph_sec_users ( is_deleted, LOWER(email) );

CREATE INDEX ix_ph_sec_users_customer
    ON ph_sec_users ( customer_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_users_type
    ON ph_sec_users ( user_type, is_deleted, is_active );

CREATE INDEX ix_ph_sec_user_pref_code
    ON ph_sec_user_preferences ( preference_code, is_deleted, is_active );

------------------------------------------------------------
-- Security catalog indexes
------------------------------------------------------------

CREATE INDEX ix_ph_sec_obj_type_active
    ON ph_sec_object_type_lkp ( is_deleted, is_active, object_type_name_en, object_type_id );

CREATE INDEX ix_ph_sec_objects_parent
    ON ph_sec_objects ( parent_object_id, is_deleted, is_active, object_id );

CREATE INDEX ix_ph_sec_permissions_object
    ON ph_sec_permissions ( object_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_permissions_action
    ON ph_sec_permissions ( action_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_objects_type
    ON ph_sec_objects ( object_type_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_roles_type
    ON ph_sec_roles ( user_type, is_deleted, is_active, role_name_en, role_id );

CREATE INDEX ix_ph_sec_roles_active_name
    ON ph_sec_roles ( is_deleted, is_active, role_name_en, role_id );

CREATE INDEX ix_ph_sec_actions_active_name
    ON ph_sec_actions ( is_deleted, is_active, action_name, action_id );

CREATE INDEX ix_ph_sec_perm_active_name
    ON ph_sec_permissions ( is_deleted, is_active, permission_name_en, permission_id );

------------------------------------------------------------
-- APEX security indexes
------------------------------------------------------------

CREATE INDEX ix_ph_sec_apex_ptype_active
    ON ph_sec_apex_page_type_lkp ( is_deleted, is_active, apex_page_type_code, apex_page_type_id );

CREATE INDEX ix_ph_sec_apex_pages_lookup
    ON ph_sec_apex_pages ( apex_app_id, apex_page_no, is_deleted, is_active, is_public );

CREATE INDEX ix_ph_sec_apex_pages_type
    ON ph_sec_apex_pages ( apex_page_type_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_apex_pages_public
    ON ph_sec_apex_pages ( apex_app_id, is_deleted, is_active, is_public, access_mode, apex_page_id );

CREATE INDEX ix_ph_sec_apex_pages_object
    ON ph_sec_apex_pages ( object_path, is_deleted, is_active, apex_page_id );

CREATE INDEX ix_ph_sec_app_perm_page
    ON ph_sec_apex_page_permissions ( apex_page_id, is_deleted, is_active, is_an_access_permission, permission_id );

CREATE INDEX ix_ph_sec_apex_page_perm_perm
    ON ph_sec_apex_page_permissions ( permission_id, is_deleted, is_active, is_an_access_permission );

------------------------------------------------------------
-- Security assignment indexes
------------------------------------------------------------

CREATE INDEX ix_ph_sec_rp_permission
    ON ph_sec_role_permissions ( is_deleted, permission_id, role_id );

CREATE INDEX ix_ph_sec_ur_role
    ON ph_sec_user_roles ( is_deleted, role_id, user_id );


