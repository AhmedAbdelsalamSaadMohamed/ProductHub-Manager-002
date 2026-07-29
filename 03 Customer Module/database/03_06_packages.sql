/*
ProductHub Manager - Customer Module Package Runner
Target DBMS: Oracle Database 21c+
*/

PROMPT Creating customer error log package...
@"packages/03_ph_erp_customer_error_log_pkg.sql"

PROMPT Creating customer LOV package...
@"packages/03_ph_erp_customer_lov_pkg.sql"

PROMPT Creating customer and contract management package for customer APIs...
@"packages/03_ph_erp_customer_contract_pkg.sql"
