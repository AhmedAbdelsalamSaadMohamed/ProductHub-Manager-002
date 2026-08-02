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

COMMENT ON TABLE ph_lookup_types IS q'[Reusable technical lookup type headers for system-wide LOV values.]';
COMMENT ON COLUMN ph_lookup_types.lookup_type_code IS q'[Uppercase lookup type code, such as YES_NO or ACCESS_MODE.]';
COMMENT ON COLUMN ph_lookup_types.lookup_type_name_en IS q'[Lookup type English name.]';
COMMENT ON COLUMN ph_lookup_types.lookup_type_name_ar IS q'[Lookup type Arabic name.]';
COMMENT ON COLUMN ph_lookup_types.description_en IS q'[Lookup type English description.]';
COMMENT ON COLUMN ph_lookup_types.description_ar IS q'[Lookup type Arabic description.]';
COMMENT ON COLUMN ph_lookup_types.is_system_type IS q'[System-managed lookup type flag.]';
COMMENT ON COLUMN ph_lookup_types.is_active IS q'[Active lookup type flag.]';

COMMENT ON TABLE ph_lookup_values IS q'[Reusable technical lookup values for system-wide LOV functions.]';
COMMENT ON COLUMN ph_lookup_values.lookup_type_code IS q'[Owning lookup type code.]';
COMMENT ON COLUMN ph_lookup_values.lookup_value_code IS q'[Uppercase lookup value code unique inside the lookup type.]';
COMMENT ON COLUMN ph_lookup_values.display_value_en IS q'[English display value.]';
COMMENT ON COLUMN ph_lookup_values.display_value_ar IS q'[Arabic display value.]';
COMMENT ON COLUMN ph_lookup_values.return_value IS q'[Value returned to the application.]';
COMMENT ON COLUMN ph_lookup_values.display_order IS q'[LOV display order.]';
COMMENT ON COLUMN ph_lookup_values.is_system_value IS q'[System-managed lookup value flag.]';
COMMENT ON COLUMN ph_lookup_values.is_active IS q'[Active lookup value flag.]';







































































































































































































































































































------------------------------------------------------------
-- Views and view columns
------------------------------------------------------------





































































































































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




















































































PROMPT Bilingual comments applied.
COMMENT ON TABLE ph_globalization_error_log IS 'Globalization module runtime error log captured from package exception handlers.';
COMMENT ON COLUMN ph_globalization_error_log.program_unit IS 'PL/SQL package, procedure, function, or runtime unit where the error was handled.';
COMMENT ON COLUMN ph_globalization_error_log.program_unit_parameters IS 'Serialized parameter values supplied by the caller when available.';
COMMENT ON COLUMN ph_globalization_error_log.error_location IS 'Formatted PL/SQL error backtrace or other location hint.';
COMMENT ON COLUMN ph_globalization_error_log.error_stack IS 'Formatted Oracle error stack.';
COMMENT ON COLUMN ph_globalization_error_log.error_backtrace IS 'Formatted Oracle error backtrace.';
COMMENT ON COLUMN ph_globalization_error_log.call_stack IS 'Formatted PL/SQL call stack at logging time.';
