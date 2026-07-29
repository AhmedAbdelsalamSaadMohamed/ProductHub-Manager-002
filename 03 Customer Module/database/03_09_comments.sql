/*
ProductHub Manager - Customer Module Comments
Target DBMS: Oracle Database 21c+
*/

COMMENT ON TABLE ph_erp_customers IS q'[customers Table | جدول العملاء]';

COMMENT ON COLUMN ph_erp_customers.customer_id IS q'[customer id Identifier | معرف customer id]';

COMMENT ON COLUMN ph_erp_customers.customer_name IS q'[customer name | customer name]';

COMMENT ON COLUMN ph_erp_customers.legal_name IS q'[legal name | legal name]';

COMMENT ON COLUMN ph_erp_customers.contact_email IS q'[contact email | contact email]';

COMMENT ON COLUMN ph_erp_customers.contact_phone IS q'[contact phone | contact phone]';

COMMENT ON COLUMN ph_erp_customers.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_erp_customers.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_erp_customers.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_erp_customers.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_erp_customers.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE vw_ph_erp_customer_onboarding IS q'[ph erp customer onboarding View | عرض ph erp customer onboarding]';

COMMENT ON COLUMN vw_ph_erp_customer_onboarding.customer_id IS q'[customer id Identifier | معرف customer id]';

COMMENT ON COLUMN vw_ph_erp_customer_onboarding.customer_name IS q'[customer name | customer name]';

COMMENT ON COLUMN vw_ph_erp_customer_onboarding.initial_admin_user_id IS q'[initial admin user id Identifier | معرف initial admin user id]';

COMMENT ON COLUMN vw_ph_erp_customer_onboarding.initial_admin_email IS q'[initial admin email | initial admin email]';

COMMENT ON COLUMN vw_ph_erp_customer_onboarding.initial_admin_name IS q'[initial admin name | initial admin name]';

COMMENT ON COLUMN ph_erp_customers.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_erp_customers.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_erp_customers.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON TABLE ph_erp_customer_error_log IS 'Customer module runtime error log captured from package exception handlers.';
COMMENT ON COLUMN ph_erp_customer_error_log.program_unit IS 'PL/SQL package, procedure, function, or runtime unit where the error was handled.';
COMMENT ON COLUMN ph_erp_customer_error_log.program_unit_parameters IS 'Serialized parameter values supplied by the caller when available.';
COMMENT ON COLUMN ph_erp_customer_error_log.error_location IS 'Formatted PL/SQL error backtrace or other location hint.';
COMMENT ON COLUMN ph_erp_customer_error_log.error_stack IS 'Formatted Oracle error stack.';
COMMENT ON COLUMN ph_erp_customer_error_log.error_backtrace IS 'Formatted Oracle error backtrace.';
COMMENT ON COLUMN ph_erp_customer_error_log.call_stack IS 'Formatted PL/SQL call stack at logging time.';
