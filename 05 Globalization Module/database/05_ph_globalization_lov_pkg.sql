/*
ProductHub Manager - Globalization List of Values Package
Target DBMS: Oracle Database 21c+

Purpose:
- Global language LOV functions.
*/

CREATE OR REPLACE PACKAGE ph_globalization_lov_pkg AS
    FUNCTION languages(p_active_only IN NUMBER DEFAULT 1) RETURN lov_table_nt PIPELINED;
    FUNCTION language_display_value(p_language_code IN VARCHAR2, p_active_only IN NUMBER DEFAULT 1) RETURN VARCHAR2;
END ph_globalization_lov_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_globalization_lov_pkg AS
    FUNCTION localized_name(p_text_en IN VARCHAR2, p_text_ar IN VARCHAR2, p_language IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN ph_localization_pkg.localized_text(p_text_en, p_text_ar, p_language);
    END localized_name;

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
         WHERE return_value = ph_localization_pkg.normalize_code(p_language_code)
         FETCH FIRST 1 ROW ONLY;

        RETURN l_display_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN p_language_code;
    END language_display_value;
END ph_globalization_lov_pkg;
/
