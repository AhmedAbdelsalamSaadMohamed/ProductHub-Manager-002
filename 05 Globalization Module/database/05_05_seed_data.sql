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

MERGE INTO ph_lookup_types target
USING (
SELECT 'YES_NO' lookup_type_code, 'Yes / No' lookup_type_name_en, 'Yes / No' lookup_type_name_ar, 'Reusable yes/no boolean values.' description_en, 'Reusable yes/no boolean values.' description_ar FROM dual
    UNION ALL SELECT 'ACTIVE_STATUS', 'Active Status', 'Active Status', 'Reusable active/inactive status values.', 'Reusable active/inactive status values.' FROM dual
    UNION ALL SELECT 'ACCESS_MODE', 'Access Mode', 'Access Mode', 'Reusable APEX page access mode values.', 'Reusable APEX page access mode values.' FROM dual
    UNION ALL SELECT 'PREFERENCE_VALUE_TYPE', 'Preference Value Type', 'Preference Value Type', 'Reusable user preference value type values.', 'Reusable user preference value type values.' FROM dual
    UNION ALL SELECT 'APEX_PAGE_TYPE_CODE', 'APEX Page Type Code', 'APEX Page Type Code', 'Reusable APEX page type code values.', 'Reusable APEX page type code values.' FROM dual
    ) source
    ON (target.lookup_type_code = source.lookup_type_code)
    WHEN MATCHED THEN
    UPDATE SET
    target.lookup_type_name_en = source.lookup_type_name_en,
    target.lookup_type_name_ar = source.lookup_type_name_ar,
    target.description_en = source.description_en,
    target.description_ar = source.description_ar,
    target.is_system_type = 1,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL
    WHEN NOT MATCHED THEN
    INSERT (lookup_type_code, lookup_type_name_en, lookup_type_name_ar, description_en, description_ar, is_system_type, is_active, created_by)
    VALUES (source.lookup_type_code, source.lookup_type_name_en, source.lookup_type_name_ar, source.description_en, source.description_ar, 1, 1, 1);

MERGE INTO ph_lookup_values target
USING (
SELECT 'YES_NO' lookup_type_code, 'YES' lookup_value_code, 'Yes' display_value_en, 'Yes' display_value_ar, '1' return_value, 1 display_order FROM dual
    UNION ALL SELECT 'YES_NO', 'NO', 'No', 'No', '0', 2 FROM dual
    UNION ALL SELECT 'ACTIVE_STATUS', 'ACTIVE', 'Active', 'Active', '1', 1 FROM dual
    UNION ALL SELECT 'ACTIVE_STATUS', 'INACTIVE', 'Inactive', 'Inactive', '0', 2 FROM dual
    UNION ALL SELECT 'ACCESS_MODE', 'ANY', 'Any permission', 'Any permission', 'ANY', 1 FROM dual
    UNION ALL SELECT 'ACCESS_MODE', 'ALL', 'All permissions', 'All permissions', 'ALL', 2 FROM dual
    UNION ALL SELECT 'PREFERENCE_VALUE_TYPE', 'STRING', 'Text', 'Text', 'STRING', 1 FROM dual
    UNION ALL SELECT 'PREFERENCE_VALUE_TYPE', 'NUMBER', 'Number', 'Number', 'NUMBER', 2 FROM dual
    UNION ALL SELECT 'PREFERENCE_VALUE_TYPE', 'BOOLEAN', 'Boolean', 'Boolean', 'BOOLEAN', 3 FROM dual
    UNION ALL SELECT 'PREFERENCE_VALUE_TYPE', 'JSON', 'JSON', 'JSON', 'JSON', 4 FROM dual
    UNION ALL SELECT 'APEX_PAGE_TYPE_CODE', 'DASHBOARD', 'Dashboard', 'Dashboard', 'DASHBOARD', 1 FROM dual
    UNION ALL SELECT 'APEX_PAGE_TYPE_CODE', 'REPORT', 'Report', 'Report', 'REPORT', 2 FROM dual
    UNION ALL SELECT 'APEX_PAGE_TYPE_CODE', 'FORM', 'Form', 'Form', 'FORM', 3 FROM dual
    UNION ALL SELECT 'APEX_PAGE_TYPE_CODE', 'ADMIN', 'Admin', 'Admin', 'ADMIN', 4 FROM dual
    ) source
    ON (target.lookup_type_code = source.lookup_type_code AND target.lookup_value_code = source.lookup_value_code)
    WHEN MATCHED THEN
    UPDATE SET
    target.display_value_en = source.display_value_en,
    target.display_value_ar = source.display_value_ar,
    target.return_value = source.return_value,
    target.display_order = source.display_order,
    target.is_system_value = 1,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL
    WHEN NOT MATCHED THEN
    INSERT (lookup_type_code, lookup_value_code, display_value_en, display_value_ar, return_value, display_order, is_system_value, is_active, created_by)
    VALUES (source.lookup_type_code, source.lookup_value_code, source.display_value_en, source.display_value_ar, source.return_value, source.display_order, 1, 1, 1);


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
COMMIT;
