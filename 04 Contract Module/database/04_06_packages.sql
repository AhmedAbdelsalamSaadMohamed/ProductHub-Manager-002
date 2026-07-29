/*
ProductHub Manager - Contract Module Package Runner
Target DBMS: Oracle Database 21c+
*/

PROMPT Creating contract error log package...
@"packages/04_ph_erp_contract_error_log_pkg.sql"

PROMPT Creating contract LOV package...
@"packages/04_ph_erp_contract_lov_pkg.sql"

PROMPT Creating customer and contract management package for contract APIs...
@"../../03 Customer Module/database/packages/03_ph_erp_customer_contract_pkg.sql"
