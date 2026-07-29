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

CREATE OR REPLACE PACKAGE ph_globalization_lov_pkg AS
    FUNCTION lookup_values(p_lookup_type_code IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION lookup_display_value(p_lookup_type_code IN VARCHAR2, p_return_value IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1, p_default_value IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;
    FUNCTION lookup_code_display_value(p_lookup_type_code IN VARCHAR2, p_lookup_value_code IN VARCHAR2, p_language IN VARCHAR2 DEFAULT NULL, p_active_only IN NUMBER DEFAULT 1, p_default_value IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;

    

    FUNCTION languages(p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION language_display_value(p_language_code IN VARCHAR2, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
END ph_globalization_lov_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_globalization_lov_pkg AS
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


    FUNCTION languages(p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED IS
    BEGIN
        FOR r IN (
            SELECT COALESCE(native_name, language_name) AS display_value,
                   language_code AS return_value,
                   ROW_NUMBER() OVER (ORDER BY is_default DESC, language_name, language_code) AS display_order
              FROM ph_languages
             WHERE is_deleted = 0
               AND (p_active_only = 0 OR is_active = 1)
             ORDER BY is_default DESC, language_name, language_code
        ) LOOP
            PIPE ROW (lov_row_ot(r.display_value, r.return_value, r.display_order));
        END LOOP;

        RETURN;
    END languages;

    FUNCTION language_display_value(p_language_code IN VARCHAR2, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
        l_display_value VARCHAR2(4000);
    BEGIN
        SELECT display_value
          INTO l_display_value
          FROM TABLE(ph_globalization_lov_pkg.languages(p_active_only => p_active_only))
         WHERE return_value = TRIM(p_language_code)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_language_code;
    END language_display_value;
END ph_globalization_lov_pkg;
/
