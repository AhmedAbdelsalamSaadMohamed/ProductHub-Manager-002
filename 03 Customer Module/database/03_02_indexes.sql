/*
ProductHub Manager - Customer Module Indexes
Target DBMS: Oracle Database 21c+
*/

CREATE INDEX ix_ph_erp_customers_active
    ON ph_erp_customers ( is_deleted, is_active, customer_name, customer_id );

CREATE INDEX ix_ph_erp_customers_email
    ON ph_erp_customers ( LOWER(contact_email) );
