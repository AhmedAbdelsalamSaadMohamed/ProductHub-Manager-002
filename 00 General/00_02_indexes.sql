/*
ProductHub Manager - Oracle Indexes
*/

CREATE INDEX ix_ph_lookup_types_active
    ON ph_lookup_types ( is_deleted, is_active, lookup_type_name_en, lookup_type_code );

CREATE INDEX ix_ph_lookup_values_active
    ON ph_lookup_values ( lookup_type_code, is_deleted, is_active, display_order, lookup_value_code );

CREATE INDEX ix_ph_app_defaults_active
    ON ph_app_default_values ( is_deleted, is_active, default_key, default_code );

