/*
ProductHub Manager - Security Module Package Runner
Target DBMS: Oracle Database 21c+
*/

PROMPT Creating security LOV package...
@"packages/01_ph_sec_lov_pkg.sql"

PROMPT Creating security authentication validation package...
@"packages/01_ph_sec_authentication_validation_pkg.sql"

PROMPT Creating security authorization package...
@"packages/01_ph_sec_authorization_pkg.sql"

PROMPT Creating security management validation package...
@"packages/01_ph_sec_management_validation_pkg.sql"

PROMPT Creating security authentication package...
@"packages/01_ph_sec_authentication_pkg.sql"

PROMPT Creating APEX security authentication package...
@"packages/01_ph_sec_authentication_apex_pkg.sql"

PROMPT Creating security management package...
@"packages/01_ph_sec_management_pkg.sql"
