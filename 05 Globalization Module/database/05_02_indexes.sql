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

CREATE INDEX ix_ph_glob_err_log_date
    ON ph_globalization_error_log ( error_date DESC );

CREATE INDEX ix_ph_glob_err_log_unit
    ON ph_globalization_error_log ( program_unit, error_date DESC );

CREATE INDEX ix_ph_glob_err_log_code
    ON ph_globalization_error_log ( error_code, error_date DESC );
