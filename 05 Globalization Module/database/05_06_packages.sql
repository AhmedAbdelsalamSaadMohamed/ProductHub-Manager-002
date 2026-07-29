/*
ProductHub Manager - Globalization Module Package Runner
Target DBMS: Oracle Database 21c+
*/

PROMPT Creating globalization error log package...
@"packages/05_ph_globalization_error_log_pkg.sql"

PROMPT Creating localization package...
@"packages/05_ph_localization_pkg.sql"

PROMPT Creating globalization LOV package...
@"packages/05_ph_globalization_lov_pkg.sql"
