/*
ProductHub Manager - Product Module Package Runner
Target DBMS: Oracle Database 21c+
*/

PROMPT Creating LOV package...
@"packages/02_ph_lov_pkg.sql"

PROMPT Creating ERP management validation package...
@"packages/02_ph_erp_management_validation_pkg.sql"

PROMPT Creating ERP management package...
@"packages/02_ph_erp_management_pkg.sql"
