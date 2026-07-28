/*
ProductHub Manager - Product Module REST API Installer
Target DBMS: Oracle Database 21c+
*/

SET DEFINE OFF

PROMPT Enabling ORDS for the ProductHub schema...
@"../Database/packages/ords/rest_enable.sql"

PROMPT Creating ERP ORDS module used by Product, Customer, and Contract endpoints...
@"../Database/packages/ords/erp moduale/00_erp_module.sql"
@"../Database/packages/ords/erp moduale/01_templates.sql"
@"../Database/packages/ords/erp moduale/02_handlers.sql"
