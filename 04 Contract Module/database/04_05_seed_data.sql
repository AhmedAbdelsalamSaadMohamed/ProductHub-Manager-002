/*
ProductHub Manager - Contract Module Seed Data
Target DBMS: Oracle Database 21c+
*/

MERGE INTO ph_erp_contracts target
USING (
SELECT 1 contract_id, 'CTR-ACME-PHM-2026' contract_no, 1 customer_id, 1 product_id, DATE '2026-01-01' start_date, DATE '2026-12-31' end_date, 1 payment_cycle FROM dual
    UNION ALL SELECT 2, 'CTR-GHG-PHM-2026', 2, 1, DATE '2026-02-01', DATE '2027-01-31', 2 FROM dual
    UNION ALL SELECT 3, 'CTR-ACME-SUP-2026', 1, 2, DATE '2026-01-15', DATE '2026-12-31', 1 FROM dual
    UNION ALL SELECT 4, 'CTR-NAJD-PHM-2026', 3, 1, DATE '2026-03-01', DATE '2027-02-28', 4 FROM dual
    UNION ALL SELECT 5, 'CTR-REN-PHM-2026', 4, 1, DATE '2026-04-01', DATE '2027-03-31', 4 FROM dual
    UNION ALL SELECT 6, 'CTR-DFH-SUP-2026', 5, 2, DATE '2026-05-01', DATE '2027-04-30', 2 FROM dual
    UNION ALL SELECT 7, 'CTR-REN-ANH-2026', 4, 3, DATE '2026-04-15', DATE '2027-04-14', 4 FROM dual
    ) source
    ON (target.contract_id = source.contract_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.contract_no = source.contract_no,
    target.customer_id = source.customer_id,
    target.product_id = source.product_id,
    target.start_date = source.start_date,
    target.end_date = source.end_date,
    target.payment_cycle = source.payment_cycle,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL,
    target.updated_by = 1
    WHEN NOT MATCHED THEN
    INSERT (contract_id, contract_no, customer_id, product_id, start_date, end_date, payment_cycle, is_active, created_by)
    VALUES (source.contract_id, source.contract_no, source.customer_id, source.product_id, source.start_date, source.end_date, source.payment_cycle, 1, 1);

MERGE INTO ph_erp_contract_urls target
USING (
SELECT 1 contract_url_id, 1 contract_id, 'https://acme.producthub.example' access_url, 1 is_primary FROM dual
    UNION ALL SELECT 2, 2, 'https://gulf-health.producthub.example', 1 FROM dual
    UNION ALL SELECT 3, 3, 'https://support.acme-retail.example', 1 FROM dual
    UNION ALL SELECT 4, 4, 'https://najd.producthub.example', 1 FROM dual
    UNION ALL SELECT 5, 5, 'https://education.producthub.example', 1 FROM dual
    UNION ALL SELECT 6, 6, 'https://support.desert-finance.example', 1 FROM dual
    UNION ALL SELECT 7, 7, 'https://analytics.riyadh-education.example', 1 FROM dual
    ) source
    ON (target.contract_url_id = source.contract_url_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.contract_id = source.contract_id,
    target.access_url = source.access_url,
    target.is_primary = source.is_primary,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL,
    target.updated_by = 1
    WHEN NOT MATCHED THEN
    INSERT (contract_url_id, contract_id, access_url, is_primary, is_active, created_by)
    VALUES (source.contract_url_id, source.contract_id, source.access_url, source.is_primary, 1, 1);

MERGE INTO ph_erp_contract_modules target
USING (
SELECT 1 contract_id, 1 product_id, 1 module_id, DATE '2026-01-01' effective_from, DATE '2026-12-31' effective_to FROM dual
    UNION ALL SELECT 1, 1, 2, DATE '2026-01-01', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 2, 1, 2, DATE '2026-02-01', DATE '2027-01-31' FROM dual
    UNION ALL SELECT 3, 2, 1, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 4, 1, 1, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 5, 1, 2, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 5, 1, 4, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 6, 2, 1, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 6, 2, 2, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 7, 3, 1, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    ) source
    ON (target.contract_id = source.contract_id AND target.product_id = source.product_id AND target.module_id = source.module_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.effective_from = source.effective_from,
    target.effective_to = source.effective_to,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL,
    target.updated_by = 1
    WHEN NOT MATCHED THEN
    INSERT (contract_id, product_id, module_id, effective_from, effective_to, is_active, created_by)
    VALUES (source.contract_id, source.product_id, source.module_id, source.effective_from, source.effective_to, 1, 1);

MERGE INTO ph_erp_contract_platforms target
USING (
SELECT 1 contract_id, 1 product_id, 1 module_id, 1 platform_id, DATE '2026-01-01' effective_from, DATE '2026-12-31' effective_to FROM dual
    UNION ALL SELECT 1, 1, 2, 1, DATE '2026-01-01', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 2, 1, 2, 1, DATE '2026-02-01', DATE '2027-01-31' FROM dual
    UNION ALL SELECT 3, 2, 1, 1, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 3, 2, 1, 2, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 4, 1, 1, 1, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, 1, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, 4, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 5, 1, 2, 1, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 5, 1, 4, 1, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 6, 2, 1, 1, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 6, 2, 2, 1, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 7, 3, 1, 1, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 1, 2, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, 4, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, 6, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    ) source
    ON (target.contract_id = source.contract_id AND target.product_id = source.product_id AND target.module_id = source.module_id AND target.platform_id = source.platform_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.effective_from = source.effective_from,
    target.effective_to = source.effective_to,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL,
    target.updated_by = 1
    WHEN NOT MATCHED THEN
    INSERT (contract_id, product_id, module_id, platform_id, effective_from, effective_to, is_active, created_by)
    VALUES (source.contract_id, source.product_id, source.module_id, source.platform_id, source.effective_from, source.effective_to, 1, 1);

MERGE INTO ph_erp_contract_features target
USING (
SELECT 1 contract_id, 1 product_id, 1 module_id, 1 platform_id, 1 feature_id, CAST(NULL AS NUMBER(18,4)) agreed_price, DATE '2026-01-01' effective_from, DATE '2026-12-31' effective_to FROM dual
    UNION ALL SELECT 1, 1, 2, 1, 1, 225.0000, DATE '2026-01-01', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 2, 1, 2, 1, 1, 250.0000, DATE '2026-02-01', DATE '2027-01-31' FROM dual
    UNION ALL SELECT 3, 2, 1, 1, 1, 18.0000, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 3, 2, 1, 2, 1, 8.0000, DATE '2026-01-15', DATE '2026-12-31' FROM dual
    UNION ALL SELECT 4, 1, 1, 1, 1, NULL, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, 1, 1, 240.0000, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 4, 1, 2, 4, 1, 0.0180, DATE '2026-03-01', DATE '2027-02-28' FROM dual
    UNION ALL SELECT 5, 1, 2, 1, 1, 225.0000, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 5, 1, 4, 1, 1, 180.0000, DATE '2026-04-01', DATE '2027-03-31' FROM dual
    UNION ALL SELECT 6, 2, 1, 1, 1, 17.0000, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 6, 2, 2, 1, 1, 4.5000, DATE '2026-05-01', DATE '2027-04-30' FROM dual
    UNION ALL SELECT 7, 3, 1, 1, 1, 275.0000, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 1, 2, 1, 20.0000, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, 4, 1, 0.0250, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    UNION ALL SELECT 7, 3, 2, 6, 1, 115.0000, DATE '2026-04-15', DATE '2027-04-14' FROM dual
    ) source
    ON (target.contract_id = source.contract_id AND target.product_id = source.product_id AND target.module_id = source.module_id AND target.platform_id = source.platform_id AND target.feature_id = source.feature_id)
    WHEN MATCHED THEN
    UPDATE SET
    target.agreed_price = source.agreed_price,
    target.effective_from = source.effective_from,
    target.effective_to = source.effective_to,
    target.is_active = 1,
    target.is_deleted = 0,
    target.deleted_by = NULL,
    target.deleted_at = NULL,
    target.updated_by = 1
    WHEN NOT MATCHED THEN
    INSERT (contract_id, product_id, module_id, platform_id, feature_id, agreed_price, effective_from, effective_to, is_active, created_by)
    VALUES (source.contract_id, source.product_id, source.module_id, source.platform_id, source.feature_id, source.agreed_price, source.effective_from, source.effective_to, 1, 1);

ALTER TABLE ph_erp_contracts MODIFY contract_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);

ALTER TABLE ph_erp_contract_urls MODIFY contract_url_id GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
