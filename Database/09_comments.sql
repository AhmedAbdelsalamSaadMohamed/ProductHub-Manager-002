/*
    ProductHub Manager - Globalized Database Comments
    English and Arabic are required base documentation languages.
    Run after 03_views.sql so table and view columns are available.
*/

SET DEFINE OFF;

PROMPT Applying globalized comments to ProductHub Manager schema objects...

------------------------------------------------------------
-- Tables and table columns
------------------------------------------------------------
COMMENT ON TABLE ph_languages IS q'[Supported application languages. English and Arabic are required base languages.]';
COMMENT ON COLUMN ph_languages.language_code IS q'[BCP-47 style lowercase language code such as en, ar, fr, or en-gb.]';
COMMENT ON COLUMN ph_languages.language_name IS q'[Language name in the default language.]';
COMMENT ON COLUMN ph_languages.native_name IS q'[Language name in its own language.]';
COMMENT ON COLUMN ph_languages.is_rtl IS q'[Right-to-left flag.]';
COMMENT ON COLUMN ph_languages.is_default IS q'[Default language flag. Only one active language should be default.]';
COMMENT ON COLUMN ph_languages.is_active IS q'[Active language flag.]';

COMMENT ON TABLE ph_i18n_texts IS q'[Entity translation values by table/entity, key, field, and language.]';
COMMENT ON COLUMN ph_i18n_texts.i18n_text_id IS q'[Translation row identifier.]';
COMMENT ON COLUMN ph_i18n_texts.entity_name IS q'[Uppercase translated entity or table name.]';
COMMENT ON COLUMN ph_i18n_texts.entity_key IS q'[Business key for the translated entity row.]';
COMMENT ON COLUMN ph_i18n_texts.field_name IS q'[Uppercase logical translated field name.]';
COMMENT ON COLUMN ph_i18n_texts.language_code IS q'[Translation language code.]';
COMMENT ON COLUMN ph_i18n_texts.text_value IS q'[Translated text value.]';

COMMENT ON TABLE ph_i18n_messages IS q'[Translated application and API messages by message code and language.]';
COMMENT ON COLUMN ph_i18n_messages.message_code IS q'[Uppercase stable message code.]';
COMMENT ON COLUMN ph_i18n_messages.language_code IS q'[Message language code.]';
COMMENT ON COLUMN ph_i18n_messages.message_text IS q'[Translated message text.]';

COMMENT ON TABLE ph_erp_pricing_unit_lkp IS q'[pricing unit lkp Table | جدول pricing unit lkp]';
COMMENT ON COLUMN ph_erp_pricing_unit_lkp.pricing_unit_id IS q'[pricing unit id Identifier | معرف pricing unit id]';
COMMENT ON COLUMN ph_erp_pricing_unit_lkp.pricing_unit_name_en IS q'[pricing unit name en English Value | قيمة pricing unit name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_erp_pricing_unit_lkp.pricing_unit_name_ar IS q'[pricing unit name ar Arabic Value | قيمة pricing unit name ar باللغة العربية]';
COMMENT ON COLUMN ph_erp_pricing_unit_lkp.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_erp_payment_cycle_lkp IS q'[payment cycle lkp Table | جدول payment cycle lkp]';
COMMENT ON COLUMN ph_erp_payment_cycle_lkp.payment_cycle_id IS q'[payment cycle id Identifier | معرف payment cycle id]';
COMMENT ON COLUMN ph_erp_payment_cycle_lkp.payment_cycle_name_en IS q'[payment cycle name en English Value | قيمة payment cycle name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_erp_payment_cycle_lkp.payment_cycle_name_ar IS q'[payment cycle name ar Arabic Value | قيمة payment cycle name ar باللغة العربية]';
COMMENT ON COLUMN ph_erp_payment_cycle_lkp.months_count IS q'[months count | months count]';
COMMENT ON COLUMN ph_erp_payment_cycle_lkp.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_user_type_lkp IS q'[user type lkp Table | جدول user type lkp]';
COMMENT ON COLUMN ph_sec_user_type_lkp.user_type_id IS q'[user type id Identifier | معرف user type id]';
COMMENT ON COLUMN ph_sec_user_type_lkp.user_type_name_en IS q'[user type name en English Value | قيمة user type name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_user_type_lkp.user_type_name_ar IS q'[user type name ar Arabic Value | قيمة user type name ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_user_type_lkp.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_erp_platform_lkp IS q'[platform lkp Table | جدول platform lkp]';
COMMENT ON COLUMN ph_erp_platform_lkp.platform_id IS q'[platform id Identifier | معرف platform id]';
COMMENT ON COLUMN ph_erp_platform_lkp.platform_name_en IS q'[platform name en English Value | قيمة platform name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_erp_platform_lkp.platform_name_ar IS q'[platform name ar Arabic Value | قيمة platform name ar باللغة العربية]';
COMMENT ON COLUMN ph_erp_platform_lkp.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_erp_products IS q'[products Table | جدول المنتجات الرئيسي]';
COMMENT ON COLUMN ph_erp_products.product_id IS q'[product id Identifier | معرف product id]';
COMMENT ON COLUMN ph_erp_products.product_name_en IS q'[product name en English Value | قيمة product name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_erp_products.product_name_ar IS q'[product name ar Arabic Value | قيمة product name ar باللغة العربية]';
COMMENT ON COLUMN ph_erp_products.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_erp_products.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';
COMMENT ON COLUMN ph_erp_products.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_erp_products.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_erp_products.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_erp_products.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';
COMMENT ON COLUMN ph_erp_products.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_erp_product_module_seq IS q'[product module seq Table | جدول product module seq]';
COMMENT ON COLUMN ph_erp_product_module_seq.product_id IS q'[product id Identifier | معرف product id]';
COMMENT ON COLUMN ph_erp_product_module_seq.next_module_id IS q'[next module id Identifier | معرف next module id]';

COMMENT ON TABLE ph_erp_modules IS q'[modules Table | جدول وحدات المنتجات]';
COMMENT ON COLUMN ph_erp_modules.product_id IS q'[product id Identifier | معرف product id]';
COMMENT ON COLUMN ph_erp_modules.module_id IS q'[module id Identifier | معرف module id]';
COMMENT ON COLUMN ph_erp_modules.module_name_en IS q'[module name en English Value | قيمة module name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_erp_modules.module_name_ar IS q'[module name ar Arabic Value | قيمة module name ar باللغة العربية]';
COMMENT ON COLUMN ph_erp_modules.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_erp_modules.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';
COMMENT ON COLUMN ph_erp_modules.display_order IS q'[display order | display order]';
COMMENT ON COLUMN ph_erp_modules.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_erp_modules.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_erp_modules.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_erp_modules.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';
COMMENT ON COLUMN ph_erp_modules.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_erp_module_platforms IS q'[module platforms Table | جدول module platforms]';
COMMENT ON COLUMN ph_erp_module_platforms.product_id IS q'[product id Identifier | معرف product id]';
COMMENT ON COLUMN ph_erp_module_platforms.module_id IS q'[module id Identifier | معرف module id]';
COMMENT ON COLUMN ph_erp_module_platforms.platform_id IS q'[platform id Identifier | معرف platform id]';
COMMENT ON COLUMN ph_erp_module_platforms.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_erp_module_platforms.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_erp_module_platforms.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_erp_module_platforms.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';
COMMENT ON COLUMN ph_erp_module_platforms.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_erp_module_feature_seq IS q'[module feature seq Table | جدول module feature seq]';
COMMENT ON COLUMN ph_erp_module_feature_seq.product_id IS q'[product id Identifier | معرف product id]';
COMMENT ON COLUMN ph_erp_module_feature_seq.module_id IS q'[module id Identifier | معرف module id]';
COMMENT ON COLUMN ph_erp_module_feature_seq.platform_id IS q'[platform id Identifier | معرف platform id]';
COMMENT ON COLUMN ph_erp_module_feature_seq.next_feature_id IS q'[next feature id Identifier | معرف next feature id]';

COMMENT ON TABLE ph_erp_features IS q'[features Table | جدول ميزات المنتجات]';
COMMENT ON COLUMN ph_erp_features.product_id IS q'[product id Identifier | معرف product id]';
COMMENT ON COLUMN ph_erp_features.module_id IS q'[module id Identifier | معرف module id]';
COMMENT ON COLUMN ph_erp_features.platform_id IS q'[platform id Identifier | معرف platform id]';
COMMENT ON COLUMN ph_erp_features.feature_id IS q'[feature id Identifier | معرف feature id]';
COMMENT ON COLUMN ph_erp_features.feature_name_en IS q'[feature name en English Value | قيمة feature name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_erp_features.feature_name_ar IS q'[feature name ar Arabic Value | قيمة feature name ar باللغة العربية]';
COMMENT ON COLUMN ph_erp_features.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_erp_features.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';
COMMENT ON COLUMN ph_erp_features.price IS q'[price | price]';
COMMENT ON COLUMN ph_erp_features.pricing_unit_id IS q'[pricing unit id Identifier | معرف pricing unit id]';
COMMENT ON COLUMN ph_erp_features.usage_unit IS q'[usage unit | usage unit]';
COMMENT ON COLUMN ph_erp_features.display_order IS q'[display order | display order]';
COMMENT ON COLUMN ph_erp_features.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_erp_features.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_erp_features.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_erp_features.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';
COMMENT ON COLUMN ph_erp_features.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_erp_customers IS q'[customers Table | جدول العملاء]';
COMMENT ON COLUMN ph_erp_customers.customer_id IS q'[customer id Identifier | معرف customer id]';
COMMENT ON COLUMN ph_erp_customers.customer_name IS q'[customer name | customer name]';
COMMENT ON COLUMN ph_erp_customers.legal_name IS q'[legal name | legal name]';
COMMENT ON COLUMN ph_erp_customers.contact_email IS q'[contact email | contact email]';
COMMENT ON COLUMN ph_erp_customers.contact_phone IS q'[contact phone | contact phone]';
COMMENT ON COLUMN ph_erp_customers.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_erp_customers.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_erp_customers.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_erp_customers.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';
COMMENT ON COLUMN ph_erp_customers.updated_at IS q'[Update Timestamp | وقت التحديث]';

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

COMMENT ON TABLE ph_sec_object_type_lkp IS q'[object type lkp Table | جدول object type lkp]';
COMMENT ON COLUMN ph_sec_object_type_lkp.object_type_id IS q'[object type id Identifier | معرف object type id]';
COMMENT ON COLUMN ph_sec_object_type_lkp.object_type_name_en IS q'[object type name en English Value | قيمة object type name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_object_type_lkp.object_type_name_ar IS q'[object type name ar Arabic Value | قيمة object type name ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_object_type_lkp.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_objects IS q'[objects Table | جدول الكائنات المؤمنة]';
COMMENT ON COLUMN ph_sec_objects.object_id IS q'[object id Identifier | معرف object id]';
COMMENT ON COLUMN ph_sec_objects.parent_object_id IS q'[parent object id Identifier | معرف parent object id]';
COMMENT ON COLUMN ph_sec_objects.object_name IS q'[object name | object name]';
COMMENT ON COLUMN ph_sec_objects.object_type_id IS q'[object type id Identifier | معرف object type id]';
COMMENT ON COLUMN ph_sec_objects.object_path IS q'[object path | object path]';
COMMENT ON COLUMN ph_sec_objects.display_name_en IS q'[display name en English Value | قيمة display name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_objects.display_name_ar IS q'[display name ar Arabic Value | قيمة display name ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_objects.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_objects.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_objects.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_actions IS q'[actions Table | جدول actions]';
COMMENT ON COLUMN ph_sec_actions.action_id IS q'[action id Identifier | معرف action id]';
COMMENT ON COLUMN ph_sec_actions.action_name IS q'[action name | action name]';
COMMENT ON COLUMN ph_sec_actions.display_name_en IS q'[display name en English Value | قيمة display name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_actions.display_name_ar IS q'[display name ar Arabic Value | قيمة display name ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_actions.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_actions.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_actions.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_permissions IS q'[permissions Table | جدول الصلاحيات]';
COMMENT ON COLUMN ph_sec_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';
COMMENT ON COLUMN ph_sec_permissions.object_id IS q'[object id Identifier | معرف object id]';
COMMENT ON COLUMN ph_sec_permissions.action_id IS q'[action id Identifier | معرف action id]';
COMMENT ON COLUMN ph_sec_permissions.permission_name_en IS q'[permission name en English Value | قيمة permission name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_permissions.permission_name_ar IS q'[permission name ar Arabic Value | قيمة permission name ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_permissions.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_permissions.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_permissions.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_apex_page_type_lkp IS q'[apex page type lkp Table | جدول apex page type lkp]';
COMMENT ON COLUMN ph_sec_apex_page_type_lkp.apex_page_type_id IS q'[apex page type id Identifier | معرف apex page type id]';
COMMENT ON COLUMN ph_sec_apex_page_type_lkp.apex_page_type_code IS q'[apex page type code | apex page type code]';
COMMENT ON COLUMN ph_sec_apex_page_type_lkp.apex_page_type_name_en IS q'[apex page type name en English Value | قيمة apex page type name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_apex_page_type_lkp.apex_page_type_name_ar IS q'[apex page type name ar Arabic Value | قيمة apex page type name ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_apex_page_type_lkp.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_users IS q'[users Table | جدول المستخدمين]';
COMMENT ON COLUMN ph_sec_users.user_id IS q'[User Identifier | معرف المستخدم]';
COMMENT ON COLUMN ph_sec_users.customer_id IS q'[customer id Identifier | معرف customer id]';
COMMENT ON COLUMN ph_sec_users.user_type IS q'[user type | user type]';
COMMENT ON COLUMN ph_sec_users.email IS q'[Email Address | البريد الإلكتروني]';
COMMENT ON COLUMN ph_sec_users.display_name IS q'[Display Name | الاسم المعروض]';
COMMENT ON COLUMN ph_sec_users.password_hash IS q'[password hash | password hash]';
COMMENT ON COLUMN ph_sec_users.password_salt IS q'[password salt | password salt]';
COMMENT ON COLUMN ph_sec_users.must_change_password IS q'[must change password | must change password]';
COMMENT ON COLUMN ph_sec_users.is_initial_admin IS q'[is initial admin Flag | مؤشر is initial admin]';
COMMENT ON COLUMN ph_sec_users.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_sec_users.last_login_at IS q'[last login at Timestamp | وقت last login at]';
COMMENT ON COLUMN ph_sec_users.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_sec_users.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_sec_users.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';
COMMENT ON COLUMN ph_sec_users.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_user_preferences IS q'[User preferences such as language, theme, density, timezone, and page size | تفضيلات المستخدم مثل اللغة والمظهر والكثافة والمنطقة الزمنية وحجم الصفحة]';
COMMENT ON COLUMN ph_sec_user_preferences.user_id IS q'[User Identifier | معرف المستخدم]';
COMMENT ON COLUMN ph_sec_user_preferences.preference_code IS q'[Preference Code | رمز التفضيل]';
COMMENT ON COLUMN ph_sec_user_preferences.preference_value IS q'[Preference Value | قيمة التفضيل]';
COMMENT ON COLUMN ph_sec_user_preferences.value_type IS q'[Preference Value Type | نوع قيمة التفضيل]';
COMMENT ON COLUMN ph_sec_user_preferences.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_sec_user_preferences.created_by IS q'[Created By User Identifier | معرف مستخدم الإنشاء]';
COMMENT ON COLUMN ph_sec_user_preferences.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_sec_user_preferences.updated_by IS q'[Updated By User Identifier | معرف مستخدم التحديث]';
COMMENT ON COLUMN ph_sec_user_preferences.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_apex_pages IS q'[apex pages Table | جدول صفحات APEX]';
COMMENT ON COLUMN ph_sec_apex_pages.apex_page_id IS q'[apex page id Identifier | معرف apex page id]';
COMMENT ON COLUMN ph_sec_apex_pages.apex_app_id IS q'[apex app id Identifier | معرف apex app id]';
COMMENT ON COLUMN ph_sec_apex_pages.apex_page_no IS q'[apex page no | apex page no]';
COMMENT ON COLUMN ph_sec_apex_pages.apex_page_type_id IS q'[apex page type id Identifier | معرف apex page type id]';
COMMENT ON COLUMN ph_sec_apex_pages.page_alias IS q'[page alias | page alias]';
COMMENT ON COLUMN ph_sec_apex_pages.page_name_en IS q'[page name en English Value | قيمة page name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_apex_pages.page_name_ar IS q'[page name ar Arabic Value | قيمة page name ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_apex_pages.object_path IS q'[object path | object path]';
COMMENT ON COLUMN ph_sec_apex_pages.access_mode IS q'[access mode | access mode]';
COMMENT ON COLUMN ph_sec_apex_pages.is_public IS q'[is public Flag | مؤشر is public]';
COMMENT ON COLUMN ph_sec_apex_pages.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_sec_apex_pages.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_sec_apex_pages.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_sec_apex_pages.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';
COMMENT ON COLUMN ph_sec_apex_pages.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_apex_page_permissions IS q'[apex page permissions Table | جدول apex page permissions]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.apex_page_id IS q'[apex page id Identifier | معرف apex page id]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.is_an_access_permission IS q'[is an access permission Flag | مؤشر is an access permission]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_roles IS q'[roles Table | جدول الأدوار]';
COMMENT ON COLUMN ph_sec_roles.role_id IS q'[role id Identifier | معرف role id]';
COMMENT ON COLUMN ph_sec_roles.role_name_en IS q'[role name en English Value | قيمة role name en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_roles.role_name_ar IS q'[role name ar Arabic Value | قيمة role name ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_roles.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';
COMMENT ON COLUMN ph_sec_roles.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';
COMMENT ON COLUMN ph_sec_roles.user_type IS q'[user type | user type]';
COMMENT ON COLUMN ph_sec_roles.is_system_role IS q'[is system role Flag | مؤشر is system role]';
COMMENT ON COLUMN ph_sec_roles.is_active IS q'[Active Flag | مؤشر التفعيل]';
COMMENT ON COLUMN ph_sec_roles.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_sec_roles.created_at IS q'[Creation Timestamp | وقت الإنشاء]';
COMMENT ON COLUMN ph_sec_roles.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';
COMMENT ON COLUMN ph_sec_roles.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_role_permissions IS q'[role permissions Table | جدول role permissions]';
COMMENT ON COLUMN ph_sec_role_permissions.role_id IS q'[role id Identifier | معرف role id]';
COMMENT ON COLUMN ph_sec_role_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';
COMMENT ON COLUMN ph_sec_role_permissions.created_by IS q'[created by User Identifier | معرف مستخدم created by]';
COMMENT ON COLUMN ph_sec_role_permissions.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON TABLE ph_sec_user_roles IS q'[user roles Table | جدول user roles]';
COMMENT ON COLUMN ph_sec_user_roles.user_id IS q'[User Identifier | معرف المستخدم]';
COMMENT ON COLUMN ph_sec_user_roles.role_id IS q'[role id Identifier | معرف role id]';
COMMENT ON COLUMN ph_sec_user_roles.assigned_by IS q'[assigned by User Identifier | معرف مستخدم assigned by]';
COMMENT ON COLUMN ph_sec_user_roles.assigned_at IS q'[assigned at Timestamp | وقت assigned at]';

------------------------------------------------------------
-- Views and view columns
------------------------------------------------------------
COMMENT ON TABLE vw_ph_erp_customer_onboarding IS q'[ph erp customer onboarding View | عرض ph erp customer onboarding]';
COMMENT ON COLUMN vw_ph_erp_customer_onboarding.customer_id IS q'[customer id Identifier | معرف customer id]';
COMMENT ON COLUMN vw_ph_erp_customer_onboarding.customer_name IS q'[customer name | customer name]';
COMMENT ON COLUMN vw_ph_erp_customer_onboarding.initial_admin_user_id IS q'[initial admin user id Identifier | معرف initial admin user id]';
COMMENT ON COLUMN vw_ph_erp_customer_onboarding.initial_admin_email IS q'[initial admin email | initial admin email]';
COMMENT ON COLUMN vw_ph_erp_customer_onboarding.initial_admin_name IS q'[initial admin name | initial admin name]';

COMMENT ON TABLE vw_ph_sec_page_permissions IS q'[ph sec page permissions View | عرض ph sec page permissions]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_id IS q'[apex page id Identifier | معرف apex page id]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_app_id IS q'[apex app id Identifier | معرف apex app id]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_no IS q'[apex page no | apex page no]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_type_id IS q'[apex page type id Identifier | معرف apex page type id]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_type_code IS q'[apex page type code | apex page type code]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_type_name_en IS q'[apex page type name en English Value | قيمة apex page type name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_type_name_ar IS q'[apex page type name ar Arabic Value | قيمة apex page type name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.page_alias IS q'[page alias | page alias]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.page_name_en IS q'[page name en English Value | قيمة page name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.page_name_ar IS q'[page name ar Arabic Value | قيمة page name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.page_object_path IS q'[page object path | page object path]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.access_mode IS q'[access mode | access mode]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.is_public IS q'[is public Flag | مؤشر is public]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.page_is_active IS q'[page is active | page is active]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.is_an_access_permission IS q'[is an access permission Flag | مؤشر is an access permission]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.page_permission_is_active IS q'[page permission is active | page permission is active]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.permission_name_en IS q'[permission name en English Value | قيمة permission name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.permission_name_ar IS q'[permission name ar Arabic Value | قيمة permission name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.object_id IS q'[object id Identifier | معرف object id]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.object_name IS q'[object name | object name]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.object_path IS q'[object path | object path]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.action_id IS q'[action id Identifier | معرف action id]';
COMMENT ON COLUMN vw_ph_sec_page_permissions.action_name IS q'[action name | action name]';

COMMENT ON TABLE vw_ph_erp_product_catalog IS q'[ph erp product catalog View | عرض ph erp product catalog]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.product_id IS q'[product id Identifier | معرف product id]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.product_name_en IS q'[product name en English Value | قيمة product name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.product_name_ar IS q'[product name ar Arabic Value | قيمة product name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.product_description_en IS q'[product description en English Value | قيمة product description en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.product_description_ar IS q'[product description ar Arabic Value | قيمة product description ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.product_is_active IS q'[product is active | product is active]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.module_id IS q'[module id Identifier | معرف module id]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.module_name_en IS q'[module name en English Value | قيمة module name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.module_name_ar IS q'[module name ar Arabic Value | قيمة module name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.module_description_en IS q'[module description en English Value | قيمة module description en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.module_description_ar IS q'[module description ar Arabic Value | قيمة module description ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.module_display_order IS q'[module display order | module display order]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.module_is_active IS q'[module is active | module is active]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.platform_id IS q'[platform id Identifier | معرف platform id]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.platform_name_en IS q'[platform name en English Value | قيمة platform name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.platform_name_ar IS q'[platform name ar Arabic Value | قيمة platform name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.feature_id IS q'[feature id Identifier | معرف feature id]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.feature_name_en IS q'[feature name en English Value | قيمة feature name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.feature_name_ar IS q'[feature name ar Arabic Value | قيمة feature name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.feature_description_en IS q'[feature description en English Value | قيمة feature description en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.feature_description_ar IS q'[feature description ar Arabic Value | قيمة feature description ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.price IS q'[price | price]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.pricing_unit_id IS q'[pricing unit id Identifier | معرف pricing unit id]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.usage_unit IS q'[usage unit | usage unit]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.feature_display_order IS q'[feature display order | feature display order]';
COMMENT ON COLUMN vw_ph_erp_product_catalog.feature_is_active IS q'[feature is active | feature is active]';

COMMENT ON TABLE vw_ph_sec_user_page_access IS q'[ph sec user page access View | عرض ph sec user page access]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.user_id IS q'[User Identifier | معرف المستخدم]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.email IS q'[Email Address | البريد الإلكتروني]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.username IS q'[username | username]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.display_name IS q'[Display Name | الاسم المعروض]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.user_type IS q'[user type | user type]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.customer_id IS q'[customer id Identifier | معرف customer id]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_id IS q'[apex page id Identifier | معرف apex page id]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_app_id IS q'[apex app id Identifier | معرف apex app id]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_no IS q'[apex page no | apex page no]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_type_id IS q'[apex page type id Identifier | معرف apex page type id]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_type_code IS q'[apex page type code | apex page type code]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_type_name_en IS q'[apex page type name en English Value | قيمة apex page type name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_type_name_ar IS q'[apex page type name ar Arabic Value | قيمة apex page type name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.page_alias IS q'[page alias | page alias]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.page_name_en IS q'[page name en English Value | قيمة page name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.page_name_ar IS q'[page name ar Arabic Value | قيمة page name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.page_object_path IS q'[page object path | page object path]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.access_mode IS q'[access mode | access mode]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.is_public IS q'[is public Flag | مؤشر is public]';
COMMENT ON COLUMN vw_ph_sec_user_page_access.has_access IS q'[has access | has access]';

COMMENT ON TABLE vw_ph_sec_user_permissions IS q'[ph sec user permissions View | عرض ph sec user permissions]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.user_id IS q'[User Identifier | معرف المستخدم]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.email IS q'[Email Address | البريد الإلكتروني]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.display_name IS q'[Display Name | الاسم المعروض]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.user_type IS q'[user type | user type]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.customer_id IS q'[customer id Identifier | معرف customer id]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.role_id IS q'[role id Identifier | معرف role id]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.role_name_en IS q'[role name en English Value | قيمة role name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.role_name_ar IS q'[role name ar Arabic Value | قيمة role name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.permission_name_en IS q'[permission name en English Value | قيمة permission name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.permission_name_ar IS q'[permission name ar Arabic Value | قيمة permission name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.object_id IS q'[object id Identifier | معرف object id]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.object_name IS q'[object name | object name]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.object_type_id IS q'[object type id Identifier | معرف object type id]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.object_type_name_en IS q'[object type name en English Value | قيمة object type name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.object_type_name_ar IS q'[object type name ar Arabic Value | قيمة object type name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.object_path IS q'[object path | object path]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.object_display_name_en IS q'[object display name en English Value | قيمة object display name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.object_display_name_ar IS q'[object display name ar Arabic Value | قيمة object display name ar باللغة العربية]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.action_id IS q'[action id Identifier | معرف action id]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.action_name IS q'[action name | action name]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.action_display_name_en IS q'[action display name en English Value | قيمة action display name en باللغة الإنجليزية]';
COMMENT ON COLUMN vw_ph_sec_user_permissions.action_display_name_ar IS q'[action display name ar Arabic Value | قيمة action display name ar باللغة العربية]';

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


------------------------------------------------------------
-- Shared soft-delete audit column comments
------------------------------------------------------------
COMMENT ON COLUMN ph_languages.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_languages.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_languages.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_i18n_texts.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_i18n_texts.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_i18n_texts.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_i18n_messages.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_i18n_messages.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_i18n_messages.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_pricing_unit_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_pricing_unit_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_pricing_unit_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_payment_cycle_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_payment_cycle_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_payment_cycle_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_user_type_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_user_type_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_user_type_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_platform_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_platform_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_platform_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_products.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_products.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_products.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_product_module_seq.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_product_module_seq.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_product_module_seq.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_modules.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_modules.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_modules.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_module_platforms.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_module_platforms.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_module_platforms.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_module_feature_seq.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_module_feature_seq.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_module_feature_seq.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_features.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_features.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_features.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_erp_customers.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_erp_customers.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_erp_customers.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
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
COMMENT ON COLUMN ph_sec_object_type_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_object_type_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_object_type_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_objects.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_objects.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_objects.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_actions.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_actions.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_actions.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_permissions.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_permissions.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_permissions.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_apex_page_type_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_apex_page_type_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_apex_page_type_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_users.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_users.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_users.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_user_preferences.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_user_preferences.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_user_preferences.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_apex_pages.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_apex_pages.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_apex_pages.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_apex_page_permissions.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_roles.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_roles.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_roles.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_role_permissions.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_role_permissions.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_role_permissions.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON COLUMN ph_sec_user_roles.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';
COMMENT ON COLUMN ph_sec_user_roles.deleted_by IS q'[User identifier that soft-deleted the row.]';
COMMENT ON COLUMN ph_sec_user_roles.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
PROMPT Bilingual comments applied.
