/*
ProductHub Manager - Security Module REST API Installer
Target DBMS: Oracle Database 21c+
*/

SET DEFINE OFF

PROMPT Enabling ORDS for the ProductHub schema...
@"../Database/packages/ords/rest_enable.sql"

PROMPT Creating Security ORDS module...
@"../Database/packages/ords/sec management moduale/00_sec_management_module.sql"
@"../Database/packages/ords/sec management moduale/01_templates.sql"
@"../Database/packages/ords/sec management moduale/02_handlers.sql"
