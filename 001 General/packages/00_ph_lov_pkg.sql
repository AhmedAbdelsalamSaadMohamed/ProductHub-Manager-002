/*
ProductHub Manager - Globalization List of Values Package
Target DBMS: Oracle Database 21c+

Purpose:
- Shared LOV row/table SQL types.
- Global lookup and language LOV functions.
*/

CREATE OR REPLACE TYPE lov_row_ot FORCE AS OBJECT
(
    display_value VARCHAR2(4000),
    return_value  VARCHAR2(4000),
    display_order NUMBER
);
/

CREATE OR REPLACE TYPE lov_table_nt FORCE AS TABLE OF lov_row_ot;
/

CREATE OR REPLACE PACKAGE ph_lov_pkg AS
    FUNCTION lookup_values(p_lookup_type_code IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION lookup_display_value(p_lookup_type_code IN VARCHAR2, p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1, p_default_value IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;
    FUNCTION lookup_code_display_value(p_lookup_type_code IN VARCHAR2, p_lookup_value_code IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1, p_default_value IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;

    FUNCTION yes_no(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION yes_no_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_return_value IN VARCHAR2) RETURN VARCHAR2;
    FUNCTION active_status(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION active_status_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_status_code IN VARCHAR2) RETURN VARCHAR2;
    FUNCTION access_modes(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION access_mode_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_return_value IN VARCHAR2) RETURN VARCHAR2;
    FUNCTION preference_value_types(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION preference_value_type_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_return_value IN VARCHAR2) RETURN VARCHAR2;
    FUNCTION page_types_static(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED;
    FUNCTION page_type_static_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_return_value IN VARCHAR2) RETURN VARCHAR2;

    
END ph_lov_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_lov_pkg AS
    FUNCTION localized_name(p_text_en IN VARCHAR2, p_text_ar IN VARCHAR2, p_language IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_localization_pkg.localized_text(p_text_en, p_text_ar, p_language);
    END localized_name;

    FUNCTION lookup_values(p_lookup_type_code IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT localized_name(v.display_value_en, v.display_value_ar, p_language) AS display_value,
                   v.return_value,
                   v.display_order
              FROM ph_lookup_values v
              JOIN ph_lookup_types t
                ON t.lookup_type_code = v.lookup_type_code
             WHERE v.lookup_type_code = UPPER(TRIM(p_lookup_type_code))
               AND v.is_deleted = 0
               AND t.is_deleted = 0
               AND (p_active_only = 0 OR (v.is_active = 1 AND t.is_active = 1))
             ORDER BY v.display_order, v.display_value_en, v.lookup_value_code
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END lookup_values;

    FUNCTION lookup_display_value(p_lookup_type_code IN VARCHAR2, p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1, p_default_value IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT localized_name(v.display_value_en, v.display_value_ar, p_language)
          INTO l_display_value
          FROM ph_lookup_values v
          JOIN ph_lookup_types t
            ON t.lookup_type_code = v.lookup_type_code
         WHERE v.lookup_type_code = UPPER(TRIM(p_lookup_type_code))
           AND v.return_value = TRIM(p_return_value)
           AND v.is_deleted = 0
           AND t.is_deleted = 0
           AND (p_active_only = 0 OR (v.is_active = 1 AND t.is_active = 1))
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_default_value;
    END lookup_display_value;

    FUNCTION lookup_code_display_value(p_lookup_type_code IN VARCHAR2, p_lookup_value_code IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1, p_default_value IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT localized_name(v.display_value_en, v.display_value_ar, p_language)
          INTO l_display_value
          FROM ph_lookup_values v
          JOIN ph_lookup_types t
            ON t.lookup_type_code = v.lookup_type_code
         WHERE v.lookup_type_code = UPPER(TRIM(p_lookup_type_code))
           AND v.lookup_value_code = UPPER(TRIM(p_lookup_value_code))
           AND v.is_deleted = 0
           AND t.is_deleted = 0
           AND (p_active_only = 0 OR (v.is_active = 1 AND t.is_active = 1))
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_default_value;
    END lookup_code_display_value;

    FUNCTION yes_no(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('YES_NO', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END yes_no;

    FUNCTION yes_no_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_return_value IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_lov_pkg.lookup_display_value('YES_NO', p_return_value, p_language, 1, p_return_value);
    END yes_no_display_value;

    FUNCTION active_status(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('ACTIVE_STATUS', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END active_status;

    FUNCTION active_status_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_status_code IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_lov_pkg.lookup_display_value(
            p_lookup_type_code => 'ACTIVE_STATUS',
            p_return_value     => p_status_code,
            p_language         => p_language,
            p_default_value    => p_status_code
        );
    END active_status_display_value;

    FUNCTION access_modes(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('ACCESS_MODE', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END access_modes;

    FUNCTION access_mode_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_return_value IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_lov_pkg.lookup_display_value('ACCESS_MODE', p_return_value, p_language, 1, p_return_value);
    END access_mode_display_value;

    FUNCTION preference_value_types(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('PREFERENCE_VALUE_TYPE', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END preference_value_types;

    FUNCTION preference_value_type_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_return_value IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_lov_pkg.lookup_display_value('PREFERENCE_VALUE_TYPE', p_return_value, p_language, 1, p_return_value);
    END preference_value_type_display_value;

    FUNCTION page_types_static(p_language IN VARCHAR2 DEFAULT NULL) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT display_value, return_value, display_order
              FROM TABLE(ph_lov_pkg.lookup_values('APEX_PAGE_TYPE_CODE', p_language))
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END page_types_static;

    FUNCTION page_type_static_display_value(p_language IN VARCHAR2 DEFAULT NULL, p_return_value IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_lov_pkg.lookup_display_value('APEX_PAGE_TYPE_CODE', p_return_value, p_language, 1, p_return_value);
    END page_type_static_display_value;
END ph_lov_pkg;
/
