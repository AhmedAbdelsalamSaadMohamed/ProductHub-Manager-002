/*
ProductHub Manager - Contract Module Comments
Target DBMS: Oracle Database 21c+
*/

COMMENT ON TABLE ph_erp_contracts IS q'[contracts Table | جدول العقود]';

COMMENT ON COLUMN ph_erp_contracts.contract_id IS q'[contract id Identifier | معرف contract id]';

COMMENT ON COLUMN ph_erp_contracts.contract_no IS q'[contract no | contract no]';

COMMENT ON COLUMN ph_erp_contracts.customer_id IS q'[customer id Identifier | معرف customer id]';

COMMENT ON COLUMN ph_erp_contracts.product_id IS q'[product id Identifier | معرف product id]';

COMMENT ON COLUMN ph_erp_contracts.start_date IS q'[start date | start date]';

COMMENT ON COLUMN ph_erp_contracts.end_date IS q'[end date | end date]';

COMMENT ON COLUMN ph_erp_contracts.payment_cycle IS q'[payment cycle | payment cycle]';

COMMENT ON COLUMN ph_erp_contracts.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_erp_contracts.notes_en IS q'[notes en English Value | قيمة notes en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_erp_contracts.notes_ar IS q'[notes ar Arabic Value | قيمة notes ar باللغة العربية]';

COMMENT ON COLUMN ph_erp_contracts.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_erp_contracts.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_erp_contracts.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_erp_contracts.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_erp_contract_urls IS q'[contract urls Table | جدول contract urls]';

COMMENT ON COLUMN ph_erp_contract_urls.contract_url_id IS q'[contract url id Identifier | معرف contract url id]';

COMMENT ON COLUMN ph_erp_contract_urls.contract_id IS q'[contract id Identifier | معرف contract id]';

COMMENT ON COLUMN ph_erp_contract_urls.access_url IS q'[access url | access url]';

COMMENT ON COLUMN ph_erp_contract_urls.is_primary IS q'[is primary Flag | مؤشر is primary]';

COMMENT ON COLUMN ph_erp_contract_urls.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_erp_contract_urls.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_erp_contract_urls.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_erp_contract_urls.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_erp_contract_urls.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_erp_contract_modules IS q'[contract modules Table | جدول contract modules]';

COMMENT ON COLUMN ph_erp_contract_modules.contract_id IS q'[contract id Identifier | معرف contract id]';

COMMENT ON COLUMN ph_erp_contract_modules.product_id IS q'[product id Identifier | معرف product id]';

COMMENT ON COLUMN ph_erp_contract_modules.module_id IS q'[module id Identifier | معرف module id]';

COMMENT ON COLUMN ph_erp_contract_modules.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_erp_contract_modules.effective_from IS q'[effective from | effective from]';

COMMENT ON COLUMN ph_erp_contract_modules.effective_to IS q'[effective to | effective to]';

COMMENT ON COLUMN ph_erp_contract_modules.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_erp_contract_modules.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_erp_contract_modules.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_erp_contract_modules.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_erp_contract_platforms IS q'[contract platforms Table | جدول منصات العقد]';

COMMENT ON COLUMN ph_erp_contract_platforms.contract_id IS q'[contract id Identifier | معرف contract id]';

COMMENT ON COLUMN ph_erp_contract_platforms.product_id IS q'[product id Identifier | معرف product id]';

COMMENT ON COLUMN ph_erp_contract_platforms.module_id IS q'[module id Identifier | معرف module id]';

COMMENT ON COLUMN ph_erp_contract_platforms.platform_id IS q'[platform id Identifier | معرف platform id]';

COMMENT ON COLUMN ph_erp_contract_platforms.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_erp_contract_platforms.effective_from IS q'[effective from | effective from]';

COMMENT ON COLUMN ph_erp_contract_platforms.effective_to IS q'[effective to | effective to]';

COMMENT ON COLUMN ph_erp_contract_platforms.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_erp_contract_platforms.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_erp_contract_platforms.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_erp_contract_platforms.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_erp_contract_features IS q'[contract features Table | جدول contract features]';

COMMENT ON COLUMN ph_erp_contract_features.contract_id IS q'[contract id Identifier | معرف contract id]';

COMMENT ON COLUMN ph_erp_contract_features.product_id IS q'[product id Identifier | معرف product id]';

COMMENT ON COLUMN ph_erp_contract_features.module_id IS q'[module id Identifier | معرف module id]';

COMMENT ON COLUMN ph_erp_contract_features.platform_id IS q'[platform id Identifier | معرف platform id]';

COMMENT ON COLUMN ph_erp_contract_features.feature_id IS q'[feature id Identifier | معرف feature id]';

COMMENT ON COLUMN ph_erp_contract_features.agreed_price IS q'[agreed price | agreed price]';

COMMENT ON COLUMN ph_erp_contract_features.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_erp_contract_features.effective_from IS q'[effective from | effective from]';

COMMENT ON COLUMN ph_erp_contract_features.effective_to IS q'[effective to | effective to]';

COMMENT ON COLUMN ph_erp_contract_features.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_erp_contract_features.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_erp_contract_features.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_erp_contract_features.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE vw_ph_erp_customer_subscriptions IS q'[ph erp customer subscriptions View | عرض ph erp customer subscriptions]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.customer_id IS q'[customer id Identifier | معرف customer id]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.customer_name IS q'[customer name | customer name]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.contract_id IS q'[contract id Identifier | معرف contract id]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.contract_no IS q'[contract no | contract no]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.contract_is_active IS q'[contract is active | contract is active]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.payment_cycle IS q'[payment cycle | payment cycle]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.start_date IS q'[start date | start date]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.end_date IS q'[end date | end date]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.product_id IS q'[product id Identifier | معرف product id]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.product_name_en IS q'[product name en English Value | قيمة product name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.product_name_ar IS q'[product name ar Arabic Value | قيمة product name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.module_id IS q'[module id Identifier | معرف module id]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.module_name_en IS q'[module name en English Value | قيمة module name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.module_name_ar IS q'[module name ar Arabic Value | قيمة module name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.module_subscription_is_active IS q'[module subscription is active | module subscription is active]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.platform_id IS q'[platform id Identifier | معرف platform id]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.platform_name_en IS q'[platform name en English Value | قيمة platform name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.platform_name_ar IS q'[platform name ar Arabic Value | قيمة platform name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.feature_id IS q'[feature id Identifier | معرف feature id]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.feature_name_en IS q'[feature name en English Value | قيمة feature name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.feature_name_ar IS q'[feature name ar Arabic Value | قيمة feature name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.subscribed_price IS q'[subscribed price | subscribed price]';

COMMENT ON COLUMN vw_ph_erp_customer_subscriptions.feature_subscription_is_active IS q'[feature subscription is active | feature subscription is active]';

COMMENT ON COLUMN ph_erp_contracts.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_erp_contracts.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_erp_contracts.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_erp_contract_urls.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_erp_contract_urls.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_erp_contract_urls.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_erp_contract_modules.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_erp_contract_modules.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_erp_contract_modules.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_erp_contract_platforms.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_erp_contract_platforms.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_erp_contract_platforms.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_erp_contract_features.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_erp_contract_features.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_erp_contract_features.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
