/*
ProductHub Manager - Product Module Seed Data
Target DBMS: Oracle Database 21c+
*/

MERGE INTO ph_erp_pricing_unit_lkp target
USING (
SELECT 1 pricing_unit_id, 'Per Use' pricing_unit_name_en, 'لكل استخدام' pricing_unit_name_ar FROM dual
    UNION ALL SELECT 2, 'Per User', 'لكل مستخدم' FROM dual
    UNION ALL SELECT 3, 'Per Transaction', 'لكل عملية' FROM dual
    UNION ALL SELECT 4, 'Per Month', 'شهريا' FROM dual
    UNION ALL SELECT 5, 'Custom', 'مخصص' FROM dual
    UNION ALL SELECT 6, 'Per Invoice', 'لكل فاتورة' FROM dual
    UNION ALL SELECT 7, 'Per API Call', 'لكل استدعاء API' FROM dual
    UNION ALL SELECT 8, 'Per GB', 'لكل جيجابايت' FROM dual
    UNION ALL SELECT 9, 'Per Seat', 'لكل مقعد' FROM dual
    UNION ALL SELECT 10, 'One Time', 'مرة واحدة' FROM dual
    ) source
    ON (target.pricing_unit_id = source.pricing_unit_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.pricing_unit_name_en = source.pricing_unit_name_en,
    target.pricing_unit_name_ar = source.pricing_unit_name_ar,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL
    WHEN NOT MATCHED THEN
    INSERT (pricing_unit_id, pricing_unit_name_en, pricing_unit_name_ar, is_active, created_by)
    VALUES (source.pricing_unit_id, source.pricing_unit_name_en, source.pricing_unit_name_ar, 1, 1);

MERGE INTO ph_erp_payment_cycle_lkp target
USING (
SELECT 1 payment_cycle_id, 'Monthly' payment_cycle_name_en, 'شهري' payment_cycle_name_ar, 1 months_count FROM dual
    UNION ALL SELECT 2, 'Every 3 Months', 'كل 3 أشهر', 3 FROM dual
    UNION ALL SELECT 3, 'Every 6 Months', 'كل 6 أشهر', 6 FROM dual
    UNION ALL SELECT 4, 'Yearly', 'سنوي', 12 FROM dual
    UNION ALL SELECT 5, 'Every 2 Months', 'كل شهرين', 2 FROM dual
    UNION ALL SELECT 6, 'Every 4 Months', 'كل 4 أشهر', 4 FROM dual
    UNION ALL SELECT 7, 'Every 2 Years', 'كل سنتين', 24 FROM dual
    ) source
    ON (target.payment_cycle_id = source.payment_cycle_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.payment_cycle_name_en = source.payment_cycle_name_en,
    target.payment_cycle_name_ar = source.payment_cycle_name_ar,
    target.months_count = source.months_count,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL
    WHEN NOT MATCHED THEN
    INSERT (payment_cycle_id, payment_cycle_name_en, payment_cycle_name_ar, months_count, is_active, created_by)
    VALUES (source.payment_cycle_id, source.payment_cycle_name_en, source.payment_cycle_name_ar, source.months_count, 1, 1);

MERGE INTO ph_erp_platform_lkp target
USING (
SELECT 1 platform_id, 'Web' platform_name_en, 'الويب' platform_name_ar FROM dual
    UNION ALL SELECT 2, 'Mobile', 'الجوال' FROM dual
    UNION ALL SELECT 3, 'Desktop', 'سطح المكتب' FROM dual
    UNION ALL SELECT 4, 'API', 'واجهة برمجة التطبيقات' FROM dual
    UNION ALL SELECT 5, 'Kiosk', 'جهاز الخدمة الذاتية' FROM dual
    UNION ALL SELECT 6, 'Integration', 'التكامل' FROM dual
    ) source
    ON (target.platform_id = source.platform_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.platform_name_en = source.platform_name_en,
    target.platform_name_ar = source.platform_name_ar,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL
    WHEN NOT MATCHED THEN
    INSERT (platform_id, platform_name_en, platform_name_ar, is_active, created_by)
    VALUES (source.platform_id, source.platform_name_en, source.platform_name_ar, 1, 1);

MERGE INTO ph_erp_products target
USING (
SELECT 1 product_id, 'ProductHub Manager' product_name_en, 'مدير مركز المنتجات' product_name_ar,
    'Product catalog, customer contracts, subscriptions, and security administration.' description_en,
    'إدارة كتالوج المنتجات وعقود العملاء والاشتراكات وإدارة الصلاحيات.' description_ar
FROM dual
    UNION ALL
SELECT 2, 'Support Portal', 'بوابة الدعم',
    'Customer support portal for tickets, knowledge base, and service requests.',
    'بوابة دعم العملاء للتذاكر وقاعدة المعرفة وطلبات الخدمة.'
FROM dual
    UNION ALL
SELECT 3, 'Analytics Hub', 'مركز التحليلات',
    'Dashboards, connectors, and embedded analytics for customer operations.',
    'لوحات معلومات وموصلات وتحليلات مدمجة لعمليات العملاء.'
FROM dual
    ) source
    ON (target.product_id = source.product_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.product_name_en = source.product_name_en,
    target.product_name_ar = source.product_name_ar,
    target.description_en = source.description_en,
    target.description_ar = source.description_ar,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL,
    target.updated_by = 1
    WHEN NOT MATCHED THEN
    INSERT (product_id, product_name_en, product_name_ar, description_en, description_ar, is_active, created_by)
    VALUES (source.product_id, source.product_name_en, source.product_name_ar, source.description_en, source.description_ar, 1, 1);

MERGE INTO ph_erp_modules target
USING (
SELECT 1 product_id, 1 module_id, 'Catalog Management' module_name_en, 'إدارة الكتالوج' module_name_ar,
    'Manage products, modules, platforms, and features.' description_en,
    'إدارة المنتجات والوحدات والمنصات والميزات.' description_ar, 10 display_order
FROM dual
    UNION ALL SELECT 1, 2, 'Customer and Contracts', 'العملاء والعقود',
    'Manage customers, URLs, contracts, and subscriptions.',
    'إدارة العملاء والروابط والعقود والاشتراكات.', 20 FROM dual
    UNION ALL SELECT 1, 4, 'Security Administration', 'إدارة الأمن',
    'Manage secured objects, actions, permissions, roles, and users.',
    'إدارة الكائنات المؤمنة والأفعال والصلاحيات والأدوار والمستخدمين.', 40 FROM dual
    UNION ALL SELECT 2, 1, 'Ticket Management', 'إدارة التذاكر',
    'Create, assign, and follow customer support tickets.',
    'إنشاء تذاكر الدعم وإسنادها ومتابعتها.', 10 FROM dual
    UNION ALL SELECT 2, 2, 'Knowledge Base', 'قاعدة المعرفة',
    'Publish support articles and FAQs.',
    'نشر مقالات الدعم والأسئلة الشائعة.', 20 FROM dual
    UNION ALL SELECT 3, 1, 'Executive Dashboards', 'لوحات الإدارة التنفيذية',
    'Operational dashboards and KPI scorecards.',
    'لوحات تشغيلية ومؤشرات أداء رئيسية.', 10 FROM dual
    UNION ALL SELECT 3, 2, 'Data Connectors', 'موصلات البيانات',
    'Connect analytics to operational product and customer data.',
    'ربط التحليلات ببيانات المنتجات والعملاء التشغيلية.', 20 FROM dual
    ) source
    ON (target.product_id = source.product_id AND target.module_id = source.module_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.module_name_en = source.module_name_en,
    target.module_name_ar = source.module_name_ar,
    target.description_en = source.description_en,
    target.description_ar = source.description_ar,
    target.display_order = source.display_order,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL,
    target.updated_by = 1
    WHEN NOT MATCHED THEN
    INSERT (product_id, module_id, module_name_en, module_name_ar, description_en, description_ar, display_order, is_active, created_by)
    VALUES (source.product_id, source.module_id, source.module_name_en, source.module_name_ar, source.description_en, source.description_ar, source.display_order, 1, 1);

MERGE INTO ph_erp_module_platforms target
USING (
SELECT 1 product_id, 1 module_id, 1 platform_id FROM dual
    UNION ALL SELECT 1, 1, 4 FROM dual
    UNION ALL SELECT 1, 2, 1 FROM dual
    UNION ALL SELECT 1, 2, 4 FROM dual
    UNION ALL SELECT 1, 4, 1 FROM dual
    UNION ALL SELECT 2, 1, 1 FROM dual
    UNION ALL SELECT 2, 1, 2 FROM dual
    UNION ALL SELECT 2, 2, 1 FROM dual
    UNION ALL SELECT 3, 1, 1 FROM dual
    UNION ALL SELECT 3, 1, 2 FROM dual
    UNION ALL SELECT 3, 2, 4 FROM dual
    UNION ALL SELECT 3, 2, 6 FROM dual
    ) source
    ON (target.product_id = source.product_id AND target.module_id = source.module_id AND target.platform_id = source.platform_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL,
    target.updated_by = 1
    WHEN NOT MATCHED THEN
    INSERT (product_id, module_id, platform_id, is_active, created_by)
    VALUES (source.product_id, source.module_id, source.platform_id, 1, 1);

MERGE INTO ph_erp_features target
USING (
SELECT 1 product_id, 1 module_id, 1 platform_id, 1 feature_id, 'Product Catalog' feature_name_en, 'كتالوج المنتجات' feature_name_ar,
    'Create and maintain products, modules, and features.' description_en,
    'إنشاء وصيانة المنتجات والوحدات والميزات.' description_ar, 0 price, 10 pricing_unit_id, 'MODULE' usage_unit, 10 display_order
FROM dual
    UNION ALL SELECT 1, 1, 4, 1, 'Catalog API', 'واجهة كتالوج المنتجات',
    'Expose catalog data through API endpoints.',
    'إتاحة بيانات الكتالوج من خلال واجهات API.', 0.0100, 7, 'CALL', 20 FROM dual
    UNION ALL SELECT 1, 2, 1, 1, 'Contract Workspace', 'مساحة عمل العقود',
    'Manage customers, contracts, URLs, modules, and feature subscriptions.',
    'إدارة العملاء والعقود والروابط واشتراكات الوحدات والميزات.', 250.0000, 4, 'MONTH', 10 FROM dual
    UNION ALL SELECT 1, 2, 4, 1, 'Contract API', 'واجهة العقود',
    'Integrate contract and subscription data with external systems.',
    'تكامل بيانات العقود والاشتراكات مع الأنظمة الخارجية.', 0.0200, 7, 'CALL', 20 FROM dual
    UNION ALL SELECT 1, 4, 1, 1, 'Role and Permission Admin', 'إدارة الأدوار والصلاحيات',
    'Manage IAM roles, users, and permissions.',
    'إدارة أدوار الهوية والمستخدمين والصلاحيات.', 200.0000, 4, 'MONTH', 10 FROM dual
    UNION ALL SELECT 2, 1, 1, 1, 'Ticket Board', 'لوحة التذاكر',
    'Create and manage support tickets from the web portal.',
    'إنشاء وإدارة تذاكر الدعم من بوابة الويب.', 20.0000, 2, 'USER', 10 FROM dual
    UNION ALL SELECT 2, 1, 2, 1, 'Mobile Ticket Updates', 'تحديثات التذاكر عبر الجوال',
    'Receive and update assigned tickets from mobile devices.',
    'استلام وتحديث التذاكر المسندة من أجهزة الجوال.', 10.0000, 2, 'USER', 20 FROM dual
    UNION ALL SELECT 2, 2, 1, 1, 'Knowledge Articles', 'مقالات المعرفة',
    'Publish and browse knowledge-base articles.',
    'نشر وتصفح مقالات قاعدة المعرفة.', 5.0000, 3, 'ARTICLE', 10 FROM dual
    UNION ALL SELECT 3, 1, 1, 1, 'KPI Dashboard', 'لوحة مؤشرات الأداء',
    'View operational KPIs for products, customers, contracts, and subscriptions.',
    'عرض مؤشرات تشغيلية للمنتجات والعملاء والعقود والاشتراكات.', 300.0000, 4, 'MONTH', 10 FROM dual
    UNION ALL SELECT 3, 1, 2, 1, 'Mobile Executive View', 'عرض الإدارة عبر الجوال',
    'Review executive dashboards from mobile devices.',
    'استعراض لوحات الإدارة التنفيذية من أجهزة الجوال.', 25.0000, 2, 'USER', 20 FROM dual
    UNION ALL SELECT 3, 2, 4, 1, 'Analytics API Feed', 'تغذية واجهة التحليلات',
    'Publish analytics-ready data through API endpoints.',
    'نشر بيانات جاهزة للتحليلات عبر واجهات API.', 0.0300, 7, 'CALL', 10 FROM dual
    UNION ALL SELECT 3, 2, 6, 1, 'Warehouse Sync', 'مزامنة مستودع البيانات',
    'Synchronize product and customer metrics with a data warehouse.',
    'مزامنة مقاييس المنتجات والعملاء مع مستودع البيانات.', 125.0000, 4, 'MONTH', 20 FROM dual
    ) source
    ON (target.product_id = source.product_id AND target.module_id = source.module_id AND target.platform_id = source.platform_id AND target.feature_id = source.feature_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.feature_name_en = source.feature_name_en,
    target.feature_name_ar = source.feature_name_ar,
    target.description_en = source.description_en,
    target.description_ar = source.description_ar,
    target.price = source.price,
    target.pricing_unit_id = source.pricing_unit_id,
    target.usage_unit = source.usage_unit,
    target.display_order = source.display_order,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL,
    target.updated_by = 1
    WHEN NOT MATCHED THEN
    INSERT (product_id, module_id, platform_id, feature_id, feature_name_en, feature_name_ar, description_en, description_ar, price, pricing_unit_id, usage_unit, display_order, is_active, created_by)
    VALUES (source.product_id, source.module_id, source.platform_id, source.feature_id, source.feature_name_en, source.feature_name_ar, source.description_en, source.description_ar, source.price, source.pricing_unit_id, source.usage_unit, source.display_order, 1, 1);

ALTER TABLE ph_erp_pricing_unit_lkp MODIFY pricing_unit_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);

ALTER TABLE ph_erp_payment_cycle_lkp MODIFY payment_cycle_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);

ALTER TABLE ph_erp_platform_lkp MODIFY platform_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);

ALTER TABLE ph_erp_products MODIFY product_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
