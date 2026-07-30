/*
ProductHub Manager - General Seed Data
Target DBMS: Oracle Database 21c+
*/

MERGE INTO ph_app_default_values target
USING (
    SELECT 'LANGUAGE' default_key,
           'en' default_code,
           'en' default_value,
           'CODE' value_type,
           'Default application language.' description_en,
           'لغة التطبيق الافتراضية.' description_ar,
           1 is_system_default,
           1 is_active
      FROM dual
) source
ON (target.default_key = source.default_key)
WHEN MATCHED THEN
    UPDATE SET
        target.default_code = source.default_code,
        target.default_value = source.default_value,
        target.value_type = source.value_type,
        target.description_en = source.description_en,
        target.description_ar = source.description_ar,
        target.is_system_default = source.is_system_default,
        target.is_active = source.is_active,
        target.is_deleted = 0,
        target.deleted_by = NULL,
        target.deleted_at = NULL,
        target.updated_by = 1,
        target.updated_at = SYSTIMESTAMP
WHEN NOT MATCHED THEN
    INSERT (
        default_key,
        default_code,
        default_value,
        value_type,
        description_en,
        description_ar,
        is_system_default,
        is_active,
        created_by
    ) VALUES (
        source.default_key,
        source.default_code,
        source.default_value,
        source.value_type,
        source.description_en,
        source.description_ar,
        source.is_system_default,
        source.is_active,
        1
    );

