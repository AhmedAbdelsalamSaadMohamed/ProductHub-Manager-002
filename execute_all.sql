/*
ProductHub Manager - APEX Workspace Static Files Runner

Upload the project folder to Shared Components > Static Workspace Files,
create execute_workspace_sql_file first, then run this block from SQL Commands.
*/

BEGIN
    DBMS_OUTPUT.PUT_LINE('ProductHub Manager install started.');

    execute_workspace_sql_file('00 General Module/database/00_01_tables_constraints.sql');
    execute_workspace_sql_file('05 Globalization Module/database/05_01_tables_constraints.sql');
    execute_workspace_sql_file('02 Product Module/database/02_01_tables_constraints.sql');
    execute_workspace_sql_file('03 Customer Module/database/03_01_tables_constraints.sql');
    execute_workspace_sql_file('01 Security Module/database/01_01_tables_constraints.sql');
    execute_workspace_sql_file('04 Contract Module/database/04_01_tables_constraints.sql');

    execute_workspace_sql_file('00 General Module/database/00_02_indexes.sql');
    execute_workspace_sql_file('05 Globalization Module/database/05_02_indexes.sql');
    execute_workspace_sql_file('02 Product Module/database/02_02_indexes.sql');
    execute_workspace_sql_file('03 Customer Module/database/03_02_indexes.sql');
    execute_workspace_sql_file('01 Security Module/database/01_02_indexes.sql');
    execute_workspace_sql_file('04 Contract Module/database/04_02_indexes.sql');

    execute_workspace_sql_file('00 General Module/database/00_04_triggers.sql');
    execute_workspace_sql_file('05 Globalization Module/database/05_04_triggers.sql');
    execute_workspace_sql_file('02 Product Module/database/02_04_triggers.sql');
    execute_workspace_sql_file('03 Customer Module/database/03_04_triggers.sql');
    execute_workspace_sql_file('01 Security Module/database/01_04_triggers.sql');
    execute_workspace_sql_file('04 Contract Module/database/04_04_triggers.sql');

    execute_workspace_sql_file('02 Product Module/database/02_03_views.sql');
    execute_workspace_sql_file('01 Security Module/database/01_03_views.sql');
    execute_workspace_sql_file('04 Contract Module/database/04_03_views.sql');
    execute_workspace_sql_file('03 Customer Module/database/03_03_views.sql');

    execute_workspace_sql_file('00 General Module/database/00_05_seed_data.sql');
    execute_workspace_sql_file('05 Globalization Module/database/05_05_seed_data.sql');
    execute_workspace_sql_file('02 Product Module/database/02_05_seed_data.sql');
    execute_workspace_sql_file('03 Customer Module/database/03_05_seed_data.sql');
    execute_workspace_sql_file('01 Security Module/database/01_05_seed_data.sql');
    execute_workspace_sql_file('04 Contract Module/database/04_05_seed_data.sql');

    execute_workspace_sql_file('00 General Module/database/packages/00_00_ph_helpers_pkg.sql');
    execute_workspace_sql_file('00 General Module/database/packages/00_ph_app_defaults_pkg.sql');
    execute_workspace_sql_file('00 General Module/database/packages/00_ph_lov_pkg.sql');
    execute_workspace_sql_file('05 Globalization Module/database/packages/05_ph_globalization_lov_pkg.sql');
    execute_workspace_sql_file('01 Security Module/database/packages/01_ph_sec_lov_pkg.sql');
    execute_workspace_sql_file('01 Security Module/database/packages/01_ph_sec_authentication_validation_pkg.sql');
    execute_workspace_sql_file('01 Security Module/database/packages/01_ph_sec_authorization_pkg.sql');
    execute_workspace_sql_file('01 Security Module/database/packages/01_ph_sec_management_validation_pkg.sql');
    execute_workspace_sql_file('01 Security Module/database/packages/01_ph_sec_authentication_pkg.sql');
    execute_workspace_sql_file('01 Security Module/database/packages/01_ph_sec_authentication_apex_pkg.sql');
    execute_workspace_sql_file('01 Security Module/database/packages/01_ph_sec_management_pkg.sql');
    execute_workspace_sql_file('05 Globalization Module/database/packages/05_ph_localization_pkg.sql');
    execute_workspace_sql_file('02 Product Module/database/packages/02_ph_erp_product_error_log_pkg.sql');
    execute_workspace_sql_file('02 Product Module/database/packages/02_ph_erp_lov_pkg.sql');
    execute_workspace_sql_file('02 Product Module/database/packages/02_ph_erp_management_validation_pkg.sql');
    execute_workspace_sql_file('02 Product Module/database/packages/02_ph_erp_management_pkg.sql');
    execute_workspace_sql_file('04 Contract Module/database/packages/04_ph_erp_contract_lov_pkg.sql');
    execute_workspace_sql_file('04 Contract Module/database/packages/04_ph_erp_contract_validation_pkg.sql');
    execute_workspace_sql_file('04 Contract Module/database/packages/04_ph_erp_contract_pkg.sql');
    execute_workspace_sql_file('03 Customer Module/database/packages/03_ph_erp_customer_lov_pkg.sql');
    execute_workspace_sql_file('03 Customer Module/database/packages/03_ph_erp_customer_validation_pkg.sql');
    execute_workspace_sql_file('03 Customer Module/database/packages/03_ph_erp_customer_pkg.sql');

    execute_workspace_sql_file('01 Security Module/database/01_08_set_default_user_passwords.sql');

    execute_workspace_sql_file('01 Security Module/database/01_07_rest_security_api.sql');
    execute_workspace_sql_file('02 Product Module/database/02_07_rest_api.sql');
    execute_workspace_sql_file('03 Customer Module/database/03_07_rest_api.sql');
    execute_workspace_sql_file('04 Contract Module/database/04_07_rest_api.sql');

    execute_workspace_sql_file('05 Globalization Module/database/05_09_comments.sql');
    execute_workspace_sql_file('02 Product Module/database/02_09_comments.sql');
    execute_workspace_sql_file('03 Customer Module/database/03_09_comments.sql');
    execute_workspace_sql_file('01 Security Module/database/01_09_comments.sql');
    execute_workspace_sql_file('04 Contract Module/database/04_09_comments.sql');

    DBMS_OUTPUT.PUT_LINE('ProductHub Manager install completed.');
END;
/
