/*
ProductHub Manager - Product Module Comments
Target DBMS: Oracle Database 21c+
*/

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

COMMENT ON COLUMN ph_erp_pricing_unit_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_erp_pricing_unit_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_erp_pricing_unit_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_erp_payment_cycle_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_erp_payment_cycle_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_erp_payment_cycle_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

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
