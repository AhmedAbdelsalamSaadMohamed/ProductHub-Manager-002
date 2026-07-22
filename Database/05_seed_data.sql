/*
    ProductHub Manager - Oracle Baseline Seed Data
*/

MERGE INTO ph_languages target
USING (
    SELECT 'en' language_code, 'English' language_name, 'English' native_name, 0 is_rtl, 1 is_default FROM dual
    UNION ALL SELECT 'ar', 'Arabic', 'العربية', 1, 0 FROM dual
) source
ON (target.language_code = source.language_code)
WHEN MATCHED THEN
    UPDATE SET
        target.language_name = source.language_name,
        target.native_name = source.native_name,
        target.is_rtl = source.is_rtl,
        target.is_default = source.is_default,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL
WHEN NOT MATCHED THEN
    INSERT (language_code, language_name, native_name, is_rtl, is_default, is_active, created_by)
    VALUES (source.language_code, source.language_name, source.native_name, source.is_rtl, source.is_default, 1, 1);

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

MERGE INTO ph_sec_user_type_lkp target
USING (
    SELECT 1 user_type_id, 'Internal User' user_type_name_en, 'مستخدم داخلي' user_type_name_ar FROM dual
    UNION ALL SELECT 2, 'Customer User', 'مستخدم عميل' FROM dual
) source
ON (target.user_type_id = source.user_type_id)
WHEN MATCHED THEN
    UPDATE SET
        target.user_type_name_en = source.user_type_name_en,
        target.user_type_name_ar = source.user_type_name_ar,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL
WHEN NOT MATCHED THEN
    INSERT (user_type_id, user_type_name_en, user_type_name_ar, is_active, created_by)
    VALUES (source.user_type_id, source.user_type_name_en, source.user_type_name_ar, 1, 1);

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

MERGE INTO ph_sec_object_type_lkp target
USING (
    SELECT 1 object_type_id, 'Business' object_type_name_en, 'أعمال' object_type_name_ar FROM dual
    UNION ALL SELECT 2, 'Security', 'أمان' FROM dual
    UNION ALL SELECT 3, 'Report', 'تقرير' FROM dual
    UNION ALL SELECT 4, 'API', 'واجهة برمجة التطبيقات' FROM dual
    UNION ALL SELECT 5, 'Administration', 'إدارة' FROM dual
) source
ON (target.object_type_id = source.object_type_id)
WHEN MATCHED THEN
    UPDATE SET
        target.object_type_name_en = source.object_type_name_en,
        target.object_type_name_ar = source.object_type_name_ar,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL
WHEN NOT MATCHED THEN
    INSERT (object_type_id, object_type_name_en, object_type_name_ar, is_active, created_by)
    VALUES (source.object_type_id, source.object_type_name_en, source.object_type_name_ar, 1, 1);

MERGE INTO ph_sec_apex_page_type_lkp target
USING (
    SELECT 1 apex_page_type_id, 'STANDARD' apex_page_type_code, 'Standard Page' apex_page_type_name_en, 'صفحة قياسية' apex_page_type_name_ar FROM dual
    UNION ALL SELECT 2, 'REPORT', 'Report Page', 'صفحة تقرير' FROM dual
    UNION ALL SELECT 3, 'FORM', 'Form Page', 'صفحة نموذج' FROM dual
    UNION ALL SELECT 4, 'DASHBOARD', 'Dashboard Page', 'صفحة لوحة معلومات' FROM dual
    UNION ALL SELECT 5, 'ADMIN', 'Administration Page', 'صفحة إدارة' FROM dual
    UNION ALL SELECT 6, 'PUBLIC', 'Public Page', 'صفحة عامة' FROM dual
) source
ON (target.apex_page_type_id = source.apex_page_type_id)
WHEN MATCHED THEN
    UPDATE SET
        target.apex_page_type_code = source.apex_page_type_code,
        target.apex_page_type_name_en = source.apex_page_type_name_en,
        target.apex_page_type_name_ar = source.apex_page_type_name_ar,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL
WHEN NOT MATCHED THEN
    INSERT (apex_page_type_id, apex_page_type_code, apex_page_type_name_en, apex_page_type_name_ar, is_active, created_by)
    VALUES (source.apex_page_type_id, source.apex_page_type_code, source.apex_page_type_name_en, source.apex_page_type_name_ar, 1, 1);

MERGE INTO ph_sec_objects target
USING (
    SELECT 1 object_id, CAST(NULL AS NUMBER(19)) parent_object_id, 'PRODUCTS' object_name, 1 object_type_id, '/erp/products' object_path, 'Products' display_name_en, 'المنتجات' display_name_ar FROM dual
    UNION ALL SELECT 2, NULL, 'CUSTOMERS', 1, '/erp/customers', 'Customers', 'العملاء' FROM dual
    UNION ALL SELECT 3, NULL, 'CONTRACTS', 1, '/erp/contracts', 'Contracts', 'العقود' FROM dual
    UNION ALL SELECT 5, NULL, 'SECURITY_ADMIN', 2, '/security/admin', 'Users and Roles', 'المستخدمون والأدوار' FROM dual
    UNION ALL SELECT 7, NULL, 'REPORTS', 3, '/reports', 'Reports', 'التقارير' FROM dual
    UNION ALL SELECT 9, NULL, 'PLATFORM_SETUP', 5, '/admin/platform-setup', 'Platform Setup', 'إعداد المنصات' FROM dual
    UNION ALL SELECT 10, NULL, 'CUSTOMER_ONBOARDING', 1, '/erp/customer-onboarding', 'Customer Onboarding', 'تهيئة العملاء' FROM dual
    UNION ALL SELECT 11, NULL, 'DASHBOARD', 1, '/dashboard', 'Dashboard', 'لوحة المعلومات' FROM dual
) source
ON (target.object_id = source.object_id)
WHEN MATCHED THEN
    UPDATE SET
        target.parent_object_id = source.parent_object_id,
        target.object_name = source.object_name,
        target.object_type_id = source.object_type_id,
        target.object_path = source.object_path,
        target.display_name_en = source.display_name_en,
        target.display_name_ar = source.display_name_ar,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL
WHEN NOT MATCHED THEN
    INSERT (object_id, parent_object_id, object_name, object_type_id, object_path, display_name_en, display_name_ar, is_active, created_by)
    VALUES (source.object_id, source.parent_object_id, source.object_name, source.object_type_id, source.object_path, source.display_name_en, source.display_name_ar, 1, 1);

MERGE INTO ph_sec_actions target
USING (
    SELECT 1 action_id, 'VIEW' action_name, 'View' display_name_en, 'عرض' display_name_ar FROM dual
    UNION ALL SELECT 2, 'MANAGE', 'Manage', 'إدارة' FROM dual
    UNION ALL SELECT 3, 'CREATE', 'Create', 'إنشاء' FROM dual
    UNION ALL SELECT 4, 'APPROVE', 'Approve', 'اعتماد' FROM dual
    UNION ALL SELECT 5, 'EXPORT', 'Export', 'تصدير' FROM dual
    UNION ALL SELECT 6, 'DELETE', 'Delete', 'حذف' FROM dual
) source
ON (target.action_id = source.action_id)
WHEN MATCHED THEN
    UPDATE SET
        target.action_name = source.action_name,
        target.display_name_en = source.display_name_en,
        target.display_name_ar = source.display_name_ar,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL
WHEN NOT MATCHED THEN
    INSERT (action_id, action_name, display_name_en, display_name_ar, is_active, created_by)
    VALUES (source.action_id, source.action_name, source.display_name_en, source.display_name_ar, 1, 1);

MERGE INTO ph_sec_permissions target
USING (
    SELECT 1 permission_id, 1 object_id, 1 action_id, 'View products' permission_name_en, 'عرض المنتجات' permission_name_ar FROM dual
    UNION ALL SELECT 2, 1, 2, 'Manage products, modules, and features', 'إدارة المنتجات والوحدات والميزات' FROM dual
    UNION ALL SELECT 3, 2, 1, 'View customers', 'عرض العملاء' FROM dual
    UNION ALL SELECT 4, 2, 2, 'Manage customers', 'إدارة العملاء' FROM dual
    UNION ALL SELECT 5, 3, 1, 'View contracts', 'عرض العقود' FROM dual
    UNION ALL SELECT 6, 3, 2, 'Manage contracts', 'إدارة العقود' FROM dual
    UNION ALL SELECT 8, 5, 2, 'Manage users and roles', 'إدارة المستخدمين والأدوار' FROM dual
    UNION ALL SELECT 11, 7, 1, 'View reports', 'عرض التقارير' FROM dual
    UNION ALL SELECT 12, 7, 5, 'Export reports', 'تصدير التقارير' FROM dual
    UNION ALL SELECT 14, 9, 2, 'Manage platform setup', 'إدارة إعداد المنصات' FROM dual
    UNION ALL SELECT 15, 10, 1, 'View customer onboarding', 'عرض تهيئة العملاء' FROM dual
    UNION ALL SELECT 16, 10, 2, 'Manage customer onboarding', 'إدارة تهيئة العملاء' FROM dual
    UNION ALL SELECT 17, 1, 6, 'Delete products, modules, and features', 'حذف المنتجات والوحدات والميزات' FROM dual
    UNION ALL SELECT 18, 2, 6, 'Delete customers', 'حذف العملاء' FROM dual
    UNION ALL SELECT 19, 3, 6, 'Delete contracts', 'حذف العقود' FROM dual
    UNION ALL SELECT 20, 11, 1, 'View dashboard', 'عرض لوحة المعلومات' FROM dual
) source
ON (target.permission_id = source.permission_id)
WHEN MATCHED THEN
    UPDATE SET
        target.object_id = source.object_id,
        target.action_id = source.action_id,
        target.permission_name_en = source.permission_name_en,
        target.permission_name_ar = source.permission_name_ar,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL
WHEN NOT MATCHED THEN
    INSERT (permission_id, object_id, action_id, permission_name_en, permission_name_ar, is_active, created_by)
    VALUES (source.permission_id, source.object_id, source.action_id, source.permission_name_en, source.permission_name_ar, 1, 1);

MERGE INTO ph_sec_apex_pages target
USING (
    SELECT 1 apex_page_id, 100 apex_app_id, 1 apex_page_no, 4 apex_page_type_id, 'DASHBOARD' page_alias, 'Dashboard' page_name_en, 'لوحة المعلومات' page_name_ar, '/dashboard' object_path, 'ANY' access_mode FROM dual
    UNION ALL SELECT 10, 100, 10, 2, 'PRODUCTS', 'Products', 'المنتجات', '/erp/products', 'ANY' FROM dual
    UNION ALL SELECT 11, 100, 11, 3, 'PRODUCT_FORM', 'Product Form', 'نموذج المنتج', '/erp/products/form', 'ANY' FROM dual
    UNION ALL SELECT 12, 100, 12, 1, 'PRODUCT_DETAIL', 'Product Detail', 'تفاصيل المنتج', '/erp/products/detail', 'ANY' FROM dual
    UNION ALL SELECT 20, 100, 20, 3, 'PRODUCT_MODULES', 'Product Modules', 'وحدات المنتج', '/erp/products/modules', 'ANY' FROM dual
    UNION ALL SELECT 30, 100, 30, 3, 'MODULE_PLATFORMS', 'Module Platforms', 'منصات الوحدات', '/erp/products/module-platforms', 'ANY' FROM dual
    UNION ALL SELECT 40, 100, 40, 3, 'MODULE_FEATURES', 'Module Features', 'ميزات الوحدات', '/erp/products/features', 'ANY' FROM dual
    UNION ALL SELECT 50, 100, 50, 2, 'CUSTOMERS', 'Customers', 'العملاء', '/erp/customers', 'ANY' FROM dual
    UNION ALL SELECT 51, 100, 51, 3, 'CUSTOMER_FORM', 'Customer Form', 'نموذج العميل', '/erp/customers/form', 'ANY' FROM dual
    UNION ALL SELECT 52, 100, 52, 3, 'CUSTOMER_ONBOARDING', 'Customer Onboarding', 'تهيئة العملاء', '/erp/customer-onboarding', 'ANY' FROM dual
    UNION ALL SELECT 53, 100, 53, 1, 'CUSTOMER_DETAIL', 'Customer Detail', 'تفاصيل العميل', '/erp/customers/detail', 'ANY' FROM dual
    UNION ALL SELECT 54, 100, 54, 3, 'CUSTOMER_USERS', 'Customer Users', 'مستخدمو العميل', '/erp/customers/users', 'ANY' FROM dual
    UNION ALL SELECT 60, 100, 60, 2, 'CONTRACTS', 'Contracts', 'العقود', '/erp/contracts', 'ANY' FROM dual
    UNION ALL SELECT 61, 100, 61, 3, 'CONTRACT_FORM', 'Contract Form', 'نموذج العقد', '/erp/contracts/form', 'ANY' FROM dual
    UNION ALL SELECT 62, 100, 62, 1, 'CONTRACT_DETAIL', 'Contract Detail', 'تفاصيل العقد', '/erp/contracts/detail', 'ANY' FROM dual
    UNION ALL SELECT 63, 100, 63, 3, 'CONTRACT_URLS', 'Contract URLs', 'روابط العقد', '/erp/contracts/urls', 'ANY' FROM dual
    UNION ALL SELECT 64, 100, 64, 3, 'CONTRACT_MODULES', 'Contract Modules', 'وحدات العقد', '/erp/contracts/modules', 'ANY' FROM dual
    UNION ALL SELECT 65, 100, 65, 3, 'CONTRACT_FEATURES', 'Contract Features', 'ميزات العقد', '/erp/contracts/features', 'ANY' FROM dual
    UNION ALL SELECT 70, 100, 70, 5, 'SECURITY_USERS', 'Users', 'المستخدمون', '/security/users', 'ANY' FROM dual
    UNION ALL SELECT 71, 100, 71, 3, 'SECURITY_USER_FORM', 'User Form', 'نموذج المستخدم', '/security/users/form', 'ANY' FROM dual
    UNION ALL SELECT 72, 100, 72, 5, 'SECURITY_ROLES', 'Roles', 'الأدوار', '/security/roles', 'ANY' FROM dual
    UNION ALL SELECT 73, 100, 73, 3, 'SECURITY_ROLE_FORM', 'Role Form', 'نموذج الدور', '/security/roles/form', 'ANY' FROM dual
    UNION ALL SELECT 74, 100, 74, 5, 'SECURITY_ROLE_PERMS', 'Role Permissions', 'صلاحيات الدور', '/security/role-permissions', 'ANY' FROM dual
    UNION ALL SELECT 75, 100, 75, 5, 'SECURITY_OBJECTS', 'Secured Objects', 'الكائنات المؤمنة', '/security/objects', 'ANY' FROM dual
    UNION ALL SELECT 76, 100, 76, 5, 'SECURITY_PERMISSIONS', 'Permissions', 'الصلاحيات', '/security/permissions', 'ANY' FROM dual
    UNION ALL SELECT 77, 100, 77, 5, 'APEX_PAGE_TYPES', 'APEX Page Types', 'أنواع صفحات APEX', '/security/apex-page-types', 'ANY' FROM dual
    UNION ALL SELECT 78, 100, 78, 5, 'APEX_PAGES', 'APEX Pages', 'صفحات APEX', '/security/apex-pages', 'ANY' FROM dual
    UNION ALL SELECT 79, 100, 79, 5, 'APEX_PAGE_PERMS', 'APEX Page Permissions', 'صلاحيات صفحات APEX', '/security/apex-page-permissions', 'ANY' FROM dual
    UNION ALL SELECT 80, 100, 80, 5, 'SECURITY_ADMIN', 'Security Administration', 'إدارة الأمن', '/security/admin', 'ANY' FROM dual
    UNION ALL SELECT 90, 100, 90, 5, 'PLATFORM_SETUP', 'Platform Setup', 'إعداد المنصات', '/admin/platform-setup', 'ANY' FROM dual
    UNION ALL SELECT 91, 100, 91, 5, 'PRICING_UNITS', 'Pricing Units', 'وحدات التسعير', '/admin/pricing-units', 'ANY' FROM dual
    UNION ALL SELECT 92, 100, 92, 5, 'PAYMENT_CYCLES', 'Payment Cycles', 'دورات الدفع', '/admin/payment-cycles', 'ANY' FROM dual
    UNION ALL SELECT 93, 100, 93, 5, 'OBJECT_TYPES', 'Object Types', 'أنواع الكائنات', '/admin/object-types', 'ANY' FROM dual
    UNION ALL SELECT 94, 100, 94, 5, 'ACTIONS', 'Actions', 'الإجراءات', '/admin/actions', 'ANY' FROM dual
    UNION ALL SELECT 95, 100, 95, 5, 'USER_TYPES', 'User Types', 'أنواع المستخدمين', '/admin/user-types', 'ANY' FROM dual
    UNION ALL SELECT 96, 100, 96, 5, 'SECURITY_AUDIT', 'Security Audit', 'تدقيق الأمن', '/security/audit', 'ANY' FROM dual
    UNION ALL SELECT 100, 100, 100, 2, 'REPORTS', 'Reports', 'التقارير', '/reports', 'ANY' FROM dual
    UNION ALL SELECT 101, 100, 101, 2, 'SUBSCRIPTION_REPORT', 'Subscription Report', 'تقرير الاشتراكات', '/reports/subscriptions', 'ANY' FROM dual
    UNION ALL SELECT 102, 100, 102, 2, 'CUSTOMER_ACCESS_REPORT', 'Customer Access Report', 'تقرير وصول العملاء', '/reports/customer-access', 'ANY' FROM dual
    UNION ALL SELECT 103, 100, 103, 2, 'REVENUE_REPORT', 'Revenue Report', 'تقرير الإيرادات', '/reports/revenue', 'ANY' FROM dual
    UNION ALL SELECT 104, 100, 104, 2, 'PAGE_ACCESS_REPORT', 'Page Access Report', 'تقرير وصول الصفحات', '/reports/page-access', 'ANY' FROM dual
) source
ON (target.apex_page_id = source.apex_page_id)
WHEN MATCHED THEN
    UPDATE SET
        target.apex_app_id = source.apex_app_id,
        target.apex_page_no = source.apex_page_no,
        target.apex_page_type_id = source.apex_page_type_id,
        target.page_alias = source.page_alias,
        target.page_name_en = source.page_name_en,
        target.page_name_ar = source.page_name_ar,
        target.object_path = source.object_path,
        target.access_mode = source.access_mode,
        target.is_public = 0,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = NULL,
        target.updated_at = SYSTIMESTAMP
WHEN NOT MATCHED THEN
    INSERT (apex_page_id, apex_app_id, apex_page_no, apex_page_type_id, page_alias, page_name_en, page_name_ar, object_path, access_mode, is_public, is_active, created_by)
    VALUES (source.apex_page_id, source.apex_app_id, source.apex_page_no, source.apex_page_type_id, source.page_alias, source.page_name_en, source.page_name_ar, source.object_path, source.access_mode, 0, 1, NULL);

MERGE INTO ph_sec_apex_page_permissions target
USING (
    SELECT 1 apex_page_id, 20 permission_id, 1 is_an_access_permission FROM dual
    UNION ALL SELECT 10, 1, 1 FROM dual
    UNION ALL SELECT 11, 2, 1 FROM dual
    UNION ALL SELECT 12, 1, 1 FROM dual
    UNION ALL SELECT 20, 2, 1 FROM dual
    UNION ALL SELECT 30, 2, 1 FROM dual
    UNION ALL SELECT 40, 2, 1 FROM dual
    UNION ALL SELECT 50, 3, 1 FROM dual
    UNION ALL SELECT 51, 4, 1 FROM dual
    UNION ALL SELECT 52, 15, 1 FROM dual
    UNION ALL SELECT 52, 16, 1 FROM dual
    UNION ALL SELECT 53, 3, 1 FROM dual
    UNION ALL SELECT 54, 4, 1 FROM dual
    UNION ALL SELECT 60, 5, 1 FROM dual
    UNION ALL SELECT 61, 6, 1 FROM dual
    UNION ALL SELECT 62, 5, 1 FROM dual
    UNION ALL SELECT 63, 6, 1 FROM dual
    UNION ALL SELECT 64, 6, 1 FROM dual
    UNION ALL SELECT 65, 6, 1 FROM dual
    UNION ALL SELECT 70, 8, 1 FROM dual
    UNION ALL SELECT 71, 8, 1 FROM dual
    UNION ALL SELECT 72, 8, 1 FROM dual
    UNION ALL SELECT 73, 8, 1 FROM dual
    UNION ALL SELECT 74, 8, 1 FROM dual
    UNION ALL SELECT 75, 8, 1 FROM dual
    UNION ALL SELECT 76, 8, 1 FROM dual
    UNION ALL SELECT 77, 8, 1 FROM dual
    UNION ALL SELECT 78, 8, 1 FROM dual
    UNION ALL SELECT 79, 8, 1 FROM dual
    UNION ALL SELECT 80, 8, 1 FROM dual
    UNION ALL SELECT 90, 14, 1 FROM dual
    UNION ALL SELECT 91, 14, 1 FROM dual
    UNION ALL SELECT 92, 14, 1 FROM dual
    UNION ALL SELECT 93, 14, 1 FROM dual
    UNION ALL SELECT 94, 8, 1 FROM dual
    UNION ALL SELECT 95, 8, 1 FROM dual
    UNION ALL SELECT 96, 8, 1 FROM dual
    UNION ALL SELECT 100, 11, 1 FROM dual
    UNION ALL SELECT 101, 11, 1 FROM dual
    UNION ALL SELECT 102, 11, 1 FROM dual
    UNION ALL SELECT 103, 11, 1 FROM dual
    UNION ALL SELECT 104, 11, 1 FROM dual
) source
ON (target.apex_page_id = source.apex_page_id AND target.permission_id = source.permission_id)
WHEN MATCHED THEN
    UPDATE SET
        target.is_an_access_permission = source.is_an_access_permission,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = NULL,
        target.updated_at = SYSTIMESTAMP
WHEN NOT MATCHED THEN
    INSERT (apex_page_id, permission_id, is_an_access_permission, is_active, created_by)
    VALUES (source.apex_page_id, source.permission_id, source.is_an_access_permission, 1, NULL);

MERGE INTO ph_sec_users target
USING (
    SELECT 1 user_id, 1 user_type, 'system@producthub.local' email, 'System User' display_name FROM dual
) source
ON (target.user_id = source.user_id)
WHEN MATCHED THEN
    UPDATE SET
        target.user_type = source.user_type,
        target.email = source.email,
        target.display_name = source.display_name,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (
        user_id,
        user_type,
        email,
        display_name,
        must_change_password,
        is_initial_admin,
        is_active,
        created_by
    ) VALUES (
        source.user_id,
        source.user_type,
        source.email,
        source.display_name,
        0,
        0,
        1,
        1
    );

MERGE INTO ph_sec_roles target
USING (
    SELECT 1 role_id, 'System Administrator' role_name_en, 'مسؤول النظام' role_name_ar, 1 user_type, 1 is_system_role FROM dual
    UNION ALL SELECT 2, 'Product Manager', 'مدير المنتج', 1, 1 FROM dual
    UNION ALL SELECT 3, 'Sales/Account Manager', 'مدير المبيعات والحسابات', 1, 1 FROM dual
    UNION ALL SELECT 4, 'Finance User', 'مستخدم المالية', 1, 1 FROM dual
    UNION ALL SELECT 5, 'Support User', 'مستخدم الدعم', 1, 1 FROM dual
    UNION ALL SELECT 6, 'Customer Administrator', 'مسؤول العميل', 2, 1 FROM dual
    UNION ALL SELECT 7, 'Customer Manager', 'مدير العميل', 2, 1 FROM dual
    UNION ALL SELECT 8, 'Customer User', 'مستخدم العميل', 2, 1 FROM dual
) source
ON (target.role_id = source.role_id)
WHEN MATCHED THEN
    UPDATE SET
        target.role_name_en = source.role_name_en,
        target.role_name_ar = source.role_name_ar,
        target.user_type = source.user_type,
        target.is_system_role = source.is_system_role,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (role_id, role_name_en, role_name_ar, user_type, is_system_role, is_active, created_by)
    VALUES (source.role_id, source.role_name_en, source.role_name_ar, source.user_type, source.is_system_role, 1, 1);

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

MERGE INTO ph_erp_customers target
USING (
    SELECT 1 customer_id, 'Acme Retail' customer_name, 'Acme Retail LLC' legal_name, 'it@acme-retail.example' contact_email, '+966500000001' contact_phone FROM dual
    UNION ALL SELECT 2, 'Gulf Health Group', 'Gulf Health Group Co.', 'systems@gulf-health.example', '+966500000002' FROM dual
    UNION ALL SELECT 3, 'Najd Logistics', 'Najd Logistics Company', 'ops@najd-logistics.example', '+966500000003' FROM dual
    UNION ALL SELECT 4, 'Riyadh Education Network', 'Riyadh Education Network', 'platform@riyadh-education.example', '+966500000004' FROM dual
    UNION ALL SELECT 5, 'Desert Finance House', 'Desert Finance House', 'digital@desert-finance.example', '+966500000005' FROM dual
) source
ON (target.customer_id = source.customer_id)
WHEN MATCHED THEN
    UPDATE SET
        target.customer_name = source.customer_name,
        target.legal_name = source.legal_name,
        target.contact_email = source.contact_email,
        target.contact_phone = source.contact_phone,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (customer_id, customer_name, legal_name, contact_email, contact_phone, is_active, created_by)
    VALUES (source.customer_id, source.customer_name, source.legal_name, source.contact_email, source.contact_phone, 1, 1);

MERGE INTO ph_sec_users target
USING (
    SELECT 2 user_id, 1 customer_id, 2 user_type, 'admin@acme-retail.example' email, 'Acme Retail Admin' display_name, 1 is_initial_admin FROM dual
    UNION ALL SELECT 3, 2, 2, 'admin@gulf-health.example', 'Gulf Health Admin', 1 FROM dual
    UNION ALL SELECT 4, CAST(NULL AS NUMBER(19)), 1, 'product.manager@producthub.local', 'Product Manager', 0 FROM dual
    UNION ALL SELECT 5, CAST(NULL AS NUMBER(19)), 1, 'finance@producthub.local', 'Finance User', 0 FROM dual
    UNION ALL SELECT 6, CAST(NULL AS NUMBER(19)), 1, 'support@producthub.local', 'Support User', 0 FROM dual
    UNION ALL SELECT 7, CAST(NULL AS NUMBER(19)), 1, 'sales.lead@producthub.local', 'Sales Lead', 0 FROM dual
    UNION ALL SELECT 8, CAST(NULL AS NUMBER(19)), 1, 'platform.admin@producthub.local', 'Platform Administrator', 0 FROM dual
    UNION ALL SELECT 9, 3, 2, 'admin@najd-logistics.example', 'Najd Logistics Admin', 1 FROM dual
    UNION ALL SELECT 10, 4, 2, 'admin@riyadh-education.example', 'Riyadh Education Admin', 1 FROM dual
    UNION ALL SELECT 11, 5, 2, 'admin@desert-finance.example', 'Desert Finance Admin', 1 FROM dual
) source
ON (target.user_id = source.user_id)
WHEN MATCHED THEN
    UPDATE SET
        target.customer_id = source.customer_id,
        target.user_type = source.user_type,
        target.email = source.email,
        target.display_name = source.display_name,
        target.is_initial_admin = source.is_initial_admin,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (user_id, customer_id, user_type, email, display_name, must_change_password, is_initial_admin, is_active, created_by)
    VALUES (source.user_id, source.customer_id, source.user_type, source.email, source.display_name, 1, source.is_initial_admin, 1, 1);

MERGE INTO ph_sec_user_preferences target
USING (
    SELECT user_id, 'LANGUAGE' preference_code, 'en' preference_value, 'STRING' value_type FROM ph_sec_users WHERE is_deleted = 0
    UNION ALL SELECT user_id, 'THEME_MODE', 'SYSTEM', 'STRING' FROM ph_sec_users WHERE is_deleted = 0
    UNION ALL SELECT user_id, 'DARK_MODE', '0', 'BOOLEAN' FROM ph_sec_users WHERE is_deleted = 0
    UNION ALL SELECT user_id, 'TIME_ZONE', 'Asia/Riyadh', 'STRING' FROM ph_sec_users WHERE is_deleted = 0
    UNION ALL SELECT user_id, 'DATE_FORMAT', 'YYYY-MM-DD', 'STRING' FROM ph_sec_users WHERE is_deleted = 0
    UNION ALL SELECT user_id, 'TIME_FORMAT', '24H', 'STRING' FROM ph_sec_users WHERE is_deleted = 0
    UNION ALL SELECT user_id, 'PAGE_SIZE', '25', 'NUMBER' FROM ph_sec_users WHERE is_deleted = 0
    UNION ALL SELECT user_id, 'DENSITY', 'COMFORTABLE', 'STRING' FROM ph_sec_users WHERE is_deleted = 0
) source
ON (target.user_id = source.user_id AND target.preference_code = source.preference_code)
WHEN MATCHED THEN
    UPDATE SET
        target.preference_value = source.preference_value,
        target.value_type = source.value_type,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (user_id, preference_code, preference_value, value_type, is_active, created_by)
    VALUES (source.user_id, source.preference_code, source.preference_value, source.value_type, 1, 1);

MERGE INTO ph_erp_contracts target
USING (
    SELECT 1 contract_id, 'CTR-ACME-PHM-2026' contract_no, 1 customer_id, 1 product_id, DATE '2026-01-01' start_date, DATE '2026-12-31' end_date, 1 payment_cycle FROM dual
    UNION ALL SELECT 2, 'CTR-GHG-PHM-2026', 2, 1, DATE '2026-02-01', DATE '2027-01-31', 2 FROM dual
    UNION ALL SELECT 3, 'CTR-ACME-SUP-2026', 1, 2, DATE '2026-01-15', DATE '2026-12-31', 1 FROM dual
    UNION ALL SELECT 4, 'CTR-NAJD-PHM-2026', 3, 1, DATE '2026-03-01', DATE '2027-02-28', 4 FROM dual
    UNION ALL SELECT 5, 'CTR-REN-PHM-2026', 4, 1, DATE '2026-04-01', DATE '2027-03-31', 4 FROM dual
    UNION ALL SELECT 6, 'CTR-DFH-SUP-2026', 5, 2, DATE '2026-05-01', DATE '2027-04-30', 2 FROM dual
    UNION ALL SELECT 7, 'CTR-REN-ANH-2026', 4, 3, DATE '2026-04-15', DATE '2027-04-14', 4 FROM dual
) source
ON (target.contract_id = source.contract_id)
WHEN MATCHED THEN
    UPDATE SET
        target.contract_no = source.contract_no,
        target.customer_id = source.customer_id,
        target.product_id = source.product_id,
        target.start_date = source.start_date,
        target.end_date = source.end_date,
        target.payment_cycle = source.payment_cycle,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (contract_id, contract_no, customer_id, product_id, start_date, end_date, payment_cycle, is_active, created_by)
    VALUES (source.contract_id, source.contract_no, source.customer_id, source.product_id, source.start_date, source.end_date, source.payment_cycle, 1, 1);

MERGE INTO ph_erp_contract_urls target
USING (
    SELECT 1 contract_url_id, 1 contract_id, 'https://acme.producthub.example' access_url, 1 is_primary FROM dual
    UNION ALL SELECT 2, 2, 'https://gulf-health.producthub.example', 1 FROM dual
    UNION ALL SELECT 3, 3, 'https://support.acme-retail.example', 1 FROM dual
    UNION ALL SELECT 4, 4, 'https://najd.producthub.example', 1 FROM dual
    UNION ALL SELECT 5, 5, 'https://education.producthub.example', 1 FROM dual
    UNION ALL SELECT 6, 6, 'https://support.desert-finance.example', 1 FROM dual
    UNION ALL SELECT 7, 7, 'https://analytics.riyadh-education.example', 1 FROM dual
) source
ON (target.contract_url_id = source.contract_url_id)
WHEN MATCHED THEN
    UPDATE SET
        target.contract_id = source.contract_id,
        target.access_url = source.access_url,
        target.is_primary = source.is_primary,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (contract_url_id, contract_id, access_url, is_primary, is_active, created_by)
    VALUES (source.contract_url_id, source.contract_id, source.access_url, source.is_primary, 1, 1);

MERGE INTO ph_erp_contract_modules target
USING (
    SELECT 1 contract_id, 1 product_id, 1 module_id, DATE '2026-01-01' effective_from, DATE '2026-12-31' effective_to FROM dual
    UNION ALL SELECT 1, 1, 2, DATE '2026-01-01', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 2, 1, 2, DATE '2026-02-01', DATE '2027-01-31' FROM dual
    UNION ALL SELECT 3, 2, 1, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 4, 1, 1, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 5, 1, 2, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 5, 1, 4, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 6, 2, 1, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 6, 2, 2, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 7, 3, 1, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, DATE '2026-04-15', DATE '2027-04-14' FROM dual
) source
ON (target.contract_id = source.contract_id AND target.product_id = source.product_id AND target.module_id = source.module_id)
WHEN MATCHED THEN
    UPDATE SET
        target.effective_from = source.effective_from,
        target.effective_to = source.effective_to,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (contract_id, product_id, module_id, effective_from, effective_to, is_active, created_by)
    VALUES (source.contract_id, source.product_id, source.module_id, source.effective_from, source.effective_to, 1, 1);

MERGE INTO ph_erp_contract_platforms target
USING (
    SELECT 1 contract_id, 1 product_id, 1 module_id, 1 platform_id, DATE '2026-01-01' effective_from, DATE '2026-12-31' effective_to FROM dual
    UNION ALL SELECT 1, 1, 2, 1, DATE '2026-01-01', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 2, 1, 2, 1, DATE '2026-02-01', DATE '2027-01-31' FROM dual
    UNION ALL SELECT 3, 2, 1, 1, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 3, 2, 1, 2, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 4, 1, 1, 1, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, 1, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, 4, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 5, 1, 2, 1, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 5, 1, 4, 1, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 6, 2, 1, 1, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 6, 2, 2, 1, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 7, 3, 1, 1, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 1, 2, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, 4, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, 6, DATE '2026-04-15', DATE '2027-04-14' FROM dual
) source
ON (target.contract_id = source.contract_id AND target.product_id = source.product_id AND target.module_id = source.module_id AND target.platform_id = source.platform_id)
WHEN MATCHED THEN
    UPDATE SET
        target.effective_from = source.effective_from,
        target.effective_to = source.effective_to,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (contract_id, product_id, module_id, platform_id, effective_from, effective_to, is_active, created_by)
    VALUES (source.contract_id, source.product_id, source.module_id, source.platform_id, source.effective_from, source.effective_to, 1, 1);

MERGE INTO ph_erp_contract_features target
USING (
    SELECT 1 contract_id, 1 product_id, 1 module_id, 1 platform_id, 1 feature_id, CAST(NULL AS NUMBER(18,4)) agreed_price, DATE '2026-01-01' effective_from, DATE '2026-12-31' effective_to FROM dual
    UNION ALL SELECT 1, 1, 2, 1, 1, 225.0000, DATE '2026-01-01', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 2, 1, 2, 1, 1, 250.0000, DATE '2026-02-01', DATE '2027-01-31' FROM dual
    UNION ALL SELECT 3, 2, 1, 1, 1, 18.0000, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 3, 2, 1, 2, 1, 8.0000, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 4, 1, 1, 1, 1, NULL, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, 1, 1, 240.0000, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, 4, 1, 0.0180, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 5, 1, 2, 1, 1, 225.0000, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 5, 1, 4, 1, 1, 180.0000, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 6, 2, 1, 1, 1, 17.0000, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 6, 2, 2, 1, 1, 4.5000, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 7, 3, 1, 1, 1, 275.0000, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 1, 2, 1, 20.0000, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, 4, 1, 0.0250, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, 6, 1, 115.0000, DATE '2026-04-15', DATE '2027-04-14' FROM dual
) source
ON (target.contract_id = source.contract_id AND target.product_id = source.product_id AND target.module_id = source.module_id AND target.platform_id = source.platform_id AND target.feature_id = source.feature_id)
WHEN MATCHED THEN
    UPDATE SET
        target.agreed_price = source.agreed_price,
        target.effective_from = source.effective_from,
        target.effective_to = source.effective_to,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (contract_id, product_id, module_id, platform_id, feature_id, agreed_price, effective_from, effective_to, is_active, created_by)
    VALUES (source.contract_id, source.product_id, source.module_id, source.platform_id, source.feature_id, source.agreed_price, source.effective_from, source.effective_to, 1, 1);

MERGE INTO ph_sec_user_roles target
USING (
    SELECT 1 user_id, 1 role_id FROM dual
    UNION ALL SELECT 2, 6 FROM dual
    UNION ALL SELECT 3, 6 FROM dual
    UNION ALL SELECT 4, 2 FROM dual
    UNION ALL SELECT 5, 4 FROM dual
    UNION ALL SELECT 6, 5 FROM dual
    UNION ALL SELECT 7, 3 FROM dual
    UNION ALL SELECT 8, 1 FROM dual
    UNION ALL SELECT 9, 6 FROM dual
    UNION ALL SELECT 10, 6 FROM dual
    UNION ALL SELECT 11, 6 FROM dual
) source
ON (target.user_id = source.user_id AND target.role_id = source.role_id)
WHEN MATCHED THEN
    UPDATE SET
        target.assigned_by = 1,
        target.is_active = 1,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1
WHEN NOT MATCHED THEN
    INSERT (user_id, role_id, assigned_by, created_by)
    VALUES (source.user_id, source.role_id, 1, 1);

UPDATE ph_sec_role_permissions rp
   SET is_active = 1,
       is_deleted = 0,
       deleted_by = NULL,
       deleted_at = NULL,
       updated_by = 1
 WHERE (
           rp.role_id = 1
        OR (rp.role_id = 2 AND rp.permission_id IN (1, 2, 11, 12, 14, 17, 20))
        OR (rp.role_id = 3 AND rp.permission_id IN (3, 4, 5, 6, 15, 16, 18, 19, 20))
        OR (rp.role_id = 4 AND rp.permission_id IN (5, 11, 12, 20))
        OR (rp.role_id = 5 AND rp.permission_id IN (1, 3, 5, 11, 15, 20))
        OR (rp.role_id = 6 AND rp.permission_id IN (1, 5, 8, 11, 12, 15, 16, 20))
        OR (rp.role_id = 7 AND rp.permission_id IN (1, 5, 11, 12, 15, 20))
        OR (rp.role_id = 8 AND rp.permission_id IN (1, 5, 11, 15, 20))
       )
   AND EXISTS (
       SELECT 1
       FROM ph_sec_roles r
       WHERE r.role_id = rp.role_id
         AND r.is_deleted = 0
   )
   AND EXISTS (
       SELECT 1
       FROM ph_sec_permissions p
       WHERE p.permission_id = rp.permission_id
         AND p.is_deleted = 0
   );

INSERT INTO ph_sec_role_permissions (role_id, permission_id, created_by)
SELECT r.role_id, p.permission_id, 1
FROM ph_sec_roles r
CROSS JOIN ph_sec_permissions p
WHERE r.role_id = 1
  AND r.is_deleted = 0
  AND p.is_deleted = 0
  AND NOT EXISTS (
      SELECT 1
      FROM ph_sec_role_permissions rp
      WHERE rp.role_id = r.role_id
        AND rp.permission_id = p.permission_id
  );

INSERT INTO ph_sec_role_permissions (role_id, permission_id, created_by)
SELECT 2, p.permission_id, 1
FROM ph_sec_permissions p
WHERE p.permission_id IN (1, 2, 11, 12, 14, 17, 20)
  AND p.is_deleted = 0
  AND NOT EXISTS (SELECT 1 FROM ph_sec_role_permissions rp WHERE rp.role_id = 2 AND rp.permission_id = p.permission_id);

INSERT INTO ph_sec_role_permissions (role_id, permission_id, created_by)
SELECT 3, p.permission_id, 1
FROM ph_sec_permissions p
WHERE p.permission_id IN (3, 4, 5, 6, 15, 16, 18, 19, 20)
  AND p.is_deleted = 0
  AND NOT EXISTS (SELECT 1 FROM ph_sec_role_permissions rp WHERE rp.role_id = 3 AND rp.permission_id = p.permission_id);

INSERT INTO ph_sec_role_permissions (role_id, permission_id, created_by)
SELECT 4, p.permission_id, 1
FROM ph_sec_permissions p
WHERE p.permission_id IN (5, 11, 12, 20)
  AND p.is_deleted = 0
  AND NOT EXISTS (SELECT 1 FROM ph_sec_role_permissions rp WHERE rp.role_id = 4 AND rp.permission_id = p.permission_id);

INSERT INTO ph_sec_role_permissions (role_id, permission_id, created_by)
SELECT 5, p.permission_id, 1
FROM ph_sec_permissions p
WHERE p.permission_id IN (1, 3, 5, 11, 15, 20)
  AND p.is_deleted = 0
  AND NOT EXISTS (SELECT 1 FROM ph_sec_role_permissions rp WHERE rp.role_id = 5 AND rp.permission_id = p.permission_id);

INSERT INTO ph_sec_role_permissions (role_id, permission_id, created_by)
SELECT 6, p.permission_id, 1
FROM ph_sec_permissions p
WHERE p.permission_id IN (1, 5, 8, 11, 12, 15, 16, 20)
  AND p.is_deleted = 0
  AND NOT EXISTS (SELECT 1 FROM ph_sec_role_permissions rp WHERE rp.role_id = 6 AND rp.permission_id = p.permission_id);

INSERT INTO ph_sec_role_permissions (role_id, permission_id, created_by)
SELECT 7, p.permission_id, 1
FROM ph_sec_permissions p
WHERE p.permission_id IN (1, 5, 11, 12, 15, 20)
  AND p.is_deleted = 0
  AND NOT EXISTS (SELECT 1 FROM ph_sec_role_permissions rp WHERE rp.role_id = 7 AND rp.permission_id = p.permission_id);

INSERT INTO ph_sec_role_permissions (role_id, permission_id, created_by)
SELECT 8, p.permission_id, 1
FROM ph_sec_permissions p
WHERE p.permission_id IN (1, 5, 11, 15, 20)
  AND p.is_deleted = 0
  AND NOT EXISTS (SELECT 1 FROM ph_sec_role_permissions rp WHERE rp.role_id = 8 AND rp.permission_id = p.permission_id);


MERGE INTO ph_i18n_messages target
USING (
    SELECT 'SUCCESS' message_code, 'en' language_code, 'Success.' message_text FROM dual
    UNION ALL SELECT 'SUCCESS', 'ar', 'تمت العملية بنجاح.' FROM dual
    UNION ALL SELECT 'AUTHENTICATED', 'en', 'Authenticated.' FROM dual
    UNION ALL SELECT 'AUTHENTICATED', 'ar', 'تم تسجيل الدخول بنجاح.' FROM dual
    UNION ALL SELECT 'INVALID_LOGIN', 'en', 'Invalid username or password.' FROM dual
    UNION ALL SELECT 'INVALID_LOGIN', 'ar', 'اسم المستخدم أو كلمة المرور غير صحيحة.' FROM dual
    UNION ALL SELECT 'USER_NOT_FOUND', 'en', 'User was not found.' FROM dual
    UNION ALL SELECT 'USER_NOT_FOUND', 'ar', 'لم يتم العثور على المستخدم.' FROM dual
    UNION ALL SELECT 'USER_NOT_FOUND_INACTIVE', 'en', 'User was not found or is inactive.' FROM dual
    UNION ALL SELECT 'USER_NOT_FOUND_INACTIVE', 'ar', 'لم يتم العثور على المستخدم أو أن المستخدم غير نشط.' FROM dual
    UNION ALL SELECT 'PASSWORD_UPDATED', 'en', 'Password updated.' FROM dual
    UNION ALL SELECT 'PASSWORD_UPDATED', 'ar', 'تم تحديث كلمة المرور.' FROM dual
    UNION ALL SELECT 'PREFERENCES_UPDATED', 'en', 'Preferences updated.' FROM dual
    UNION ALL SELECT 'PREFERENCES_UPDATED', 'ar', 'تم تحديث التفضيلات.' FROM dual
    UNION ALL SELECT 'INVALID_PREFERENCE', 'en', 'Invalid preference value.' FROM dual
    UNION ALL SELECT 'INVALID_PREFERENCE', 'ar', 'قيمة التفضيل غير صحيحة.' FROM dual
    UNION ALL SELECT 'PASSWORD_MIN_LENGTH', 'en', 'Password must contain at least 8 characters.' FROM dual
    UNION ALL SELECT 'PASSWORD_MIN_LENGTH', 'ar', 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل.' FROM dual
    UNION ALL SELECT 'ROLE_NOT_FOUND', 'en', 'Role was not found.' FROM dual
    UNION ALL SELECT 'ROLE_NOT_FOUND', 'ar', 'لم يتم العثور على الدور.' FROM dual
    UNION ALL SELECT 'OBJECT_NOT_FOUND', 'en', 'Object was not found.' FROM dual
    UNION ALL SELECT 'OBJECT_NOT_FOUND', 'ar', 'لم يتم العثور على الكائن.' FROM dual
    UNION ALL SELECT 'ACTION_NOT_FOUND', 'en', 'Action was not found.' FROM dual
    UNION ALL SELECT 'ACTION_NOT_FOUND', 'ar', 'لم يتم العثور على الإجراء.' FROM dual
    UNION ALL SELECT 'PERMISSION_NOT_FOUND', 'en', 'Permission was not found.' FROM dual
    UNION ALL SELECT 'PERMISSION_NOT_FOUND', 'ar', 'لم يتم العثور على الصلاحية.' FROM dual
    UNION ALL SELECT 'APEX_PAGE_TYPE_NOT_FOUND', 'en', 'APEX page type was not found.' FROM dual
    UNION ALL SELECT 'APEX_PAGE_TYPE_NOT_FOUND', 'ar', 'لم يتم العثور على نوع صفحة APEX.' FROM dual
    UNION ALL SELECT 'APEX_PAGE_NOT_FOUND', 'en', 'APEX page was not found.' FROM dual
    UNION ALL SELECT 'APEX_PAGE_NOT_FOUND', 'ar', 'لم يتم العثور على صفحة APEX.' FROM dual
    UNION ALL SELECT 'APEX_PAGE_PERMISSION_NOT_FOUND', 'en', 'APEX page permission was not found.' FROM dual
    UNION ALL SELECT 'APEX_PAGE_PERMISSION_NOT_FOUND', 'ar', 'لم يتم العثور على صلاحية صفحة APEX.' FROM dual
) source
ON (target.message_code = source.message_code AND target.language_code = source.language_code)
WHEN MATCHED THEN
    UPDATE SET
        target.message_text = source.message_text,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_at = SYSTIMESTAMP
WHEN NOT MATCHED THEN
    INSERT (message_code, language_code, message_text, created_by)
    VALUES (source.message_code, source.language_code, source.message_text, 1);

UPDATE ph_i18n_texts
   SET is_deleted = 1
 WHERE language_code IN ('en', 'ar')
   AND is_deleted = 0;

------------------------------------------------------------
-- Keep identity generators ahead of seeded explicit IDs.
------------------------------------------------------------

ALTER TABLE ph_i18n_texts MODIFY i18n_text_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_erp_pricing_unit_lkp MODIFY pricing_unit_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_erp_payment_cycle_lkp MODIFY payment_cycle_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_sec_user_type_lkp MODIFY user_type_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_erp_platform_lkp MODIFY platform_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_erp_products MODIFY product_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_erp_customers MODIFY customer_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_erp_contracts MODIFY contract_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_erp_contract_urls MODIFY contract_url_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_sec_object_type_lkp MODIFY object_type_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_sec_objects MODIFY object_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_sec_actions MODIFY action_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_sec_permissions MODIFY permission_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_sec_apex_page_type_lkp MODIFY apex_page_type_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_sec_users MODIFY user_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_sec_apex_pages MODIFY apex_page_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE ph_sec_roles MODIFY role_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);

COMMIT;


