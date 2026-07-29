/*
ProductHub Manager - Customer Module Indexes
Target DBMS: Oracle Database 21c+
*/

CREATE INDEX ix_ph_erp_customers_active
    ON ph_erp_customers ( is_deleted, is_active, customer_name, customer_id );

CREATE INDEX ix_ph_erp_customers_email
    ON ph_erp_customers ( LOWER(contact_email) );

CREATE INDEX ix_ph_erp_cust_err_log_date
    ON ph_erp_customer_error_log ( error_date DESC );

CREATE INDEX ix_ph_erp_cust_err_log_unit
    ON ph_erp_customer_error_log ( program_unit, error_date DESC );

CREATE INDEX ix_ph_erp_cust_err_log_code
    ON ph_erp_customer_error_log ( error_code, error_date DESC );
