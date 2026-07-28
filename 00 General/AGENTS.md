# Oracle Development Agent Instructions

## Role

You are a senior Oracle Database developer working on this repository.

Your primary technologies are:

- Oracle SQL
- PL/SQL
- Oracle Packages
- Views
- Triggers
- Sequences
- Oracle APEX database APIs
- REST-ready database services

## Application

### Architectural Design Pattern
- Modular Monolith Architecture
    - Each module hase its own foloed maned modulenumber moduleName like (01 Security Module)

## Database Environment

- Use only the saved SQLcl connection named `oracle_dev`.
- Never connect to production.
- Never request or expose database passwords.
- Never store credentials in repository files.
- Before executing database operations, confirm the current user and service name.

## Safety Rules

- Default to read-only inspection.
- Ask for approval before executing DDL or DML.
- Never execute DROP, TRUNCATE, mass DELETE, or ALTER USER.
- Never disable constraints or triggers without explicit approval.
- Never use COMMIT or ROLLBACK inside reusable package procedures.
- Never use autonomous transactions except for approved audit logging.
- Never modify objects outside the current development schema.
- Show planned database changes before executing them.

## Oracle Coding Standards

- Use uppercase SQL keywords.
- Use snake_case for local variables and parameters.
- Prefix input parameters with `p_`.
- Prefix ordinary output parameters with `o_`; keep existing repository service outputs as `p_result_code` and `p_result_message`.
- Prefix local variables with `l_`.
- Prefix cursors with `c_`.
- Prefix exceptions with `e_`.
- Use `%TYPE` and `%ROWTYPE` where appropriate.
- Use explicit column lists in INSERT statements.
- Avoid `SELECT *` in production code.
- Avoid functions on indexed columns in WHERE predicates when possible.
- Use ANSI JOIN syntax.
- Handle `NO_DATA_FOUND` and `TOO_MANY_ROWS` intentionally.
- Do not use `WHEN OTHERS THEN NULL`.
- Return meaningful result codes and result messages from service procedures.
- Keep transaction control outside reusable packages; callers own COMMIT and ROLLBACK.

## Package Standards

Each business module should normally contain:

1. Package specification.
2. Package body.
3. Public procedures and functions.
4. Calls to the matching validation package.
5. Consistent exception handling.
6. Result code and result message outputs where appropriate.

Example service signature:

```sql
PROCEDURE create_customer (
    p_customer_name  IN  ph_erp_customers.customer_name%TYPE,
    p_contact_email  IN  ph_erp_customers.contact_email%TYPE DEFAULT NULL,
    p_created_by     IN  NUMBER DEFAULT NULL,
    p_customer_id    OUT ph_erp_customers.customer_id%TYPE,
    p_result_code    OUT VARCHAR2,
    p_result_message OUT VARCHAR2
);
```

Keep public package APIs consistent with this `p_result_code OUT VARCHAR2` and `p_result_message OUT VARCHAR2` pattern unless you are intentionally refactoring a whole package contract.

## Repository Structure

The `Database` folder is ordered as installable SQL scripts:

1. `01_tables_constraints.sql`: tables, primary keys, foreign keys, check constraints, and unique constraints.
2. `02_indexes.sql`: performance indexes after table creation.
3. `03_views.sql`: read models and APEX-friendly views.
4. `04_triggers.sql`: audit, validation, sequencing, and business-rule triggers.
5. `05_seed_data.sql`: baseline lookup and demo/configuration data.
6. `06_packages.sql`: package runner for all package files under `packages`.
7. `07_rest_security_api.sql`: REST/security setup entry point.
8. `08_set_default_user_passwords.sql`: development-only password setup.
9. `09_comments.sql`: table and column comments.
10. `98_reset_dev.sql`: development reset helper only.

Do not move logic between these files without preserving the install order. New package files belong under `Database/packages` and should be added to `06_packages.sql` in dependency order.

Package files under `Database/packages` use numeric prefixes only for dependency-safe execution order:

- Lower numbers must compile before higher numbers.
- Keep shared packages first, validation packages before the packages that call them, and REST/API wrappers after their service packages.
- Do not add `logic` or `technical` words to package filenames; the package name should remain the filename after the numeric prefix.

## Naming Standards

- ERP/business objects use the `ph_erp_` prefix.
- Security/auth objects use the `ph_sec_` prefix.
- Internationalization objects use the `ph_i18n_` prefix.
- Views use the `vw_` prefix.
- Lookup tables end with `_lkp`.
- Primary keys use `pk_<table_name>`.
- Foreign keys use `fk_<table_name>_<meaning>` or the closest existing local style.
- Unique constraints use `uk_<table_name>_<meaning>`.
- Check constraints use `ck_<table_name>_<meaning>`.
- Triggers use `trg_<table_name_or_abbrev>_<timing_event_or_purpose>`.
- Package names end with `_pkg`.

## Table Standards

- Use identity columns for numeric surrogate keys: `number(10)` for normal IDs and `number(19)` for large/generic IDs.
- Use composite primary keys only where the relationship is naturally identified by multiple parent keys.
- Store English and Arabic display text in paired `*_name_en` / `*_name_ar` or `*_description_en` / `*_description_ar` columns.
- Use `varchar2(... char)` for text columns.
- Use `number(1)` flags with explicit check constraints.
- Use `is_active number(1) default 1 not null` for enabled/disabled state when the record can be visible but inactive.
- Use `is_deleted number(1) default 0 not null` for soft-delete state.
- Put audit columns before constraints and keep column ordering consistent across tables.
- Add comments for every new table and user-facing column in `09_comments.sql`.

## Soft Delete And Audit

Use this column block near the end of every table definition, before constraints:

```sql
is_deleted number(1) default 0 not null check ( is_deleted in ( 0, 1 ) ),
created_by number,
created_at timestamp(3) default systimestamp not null,
updated_by number,
updated_at timestamp(3),
deleted_by number,
deleted_at timestamp(3),
```

Handle these columns consistently:

- Insert: set `created_by` from the caller when available; let `created_at` default or be set by the audit trigger.
- Update: set `updated_by` from the caller; let `updated_at` be set to `systimestamp` by the package or audit trigger.
- Soft delete: never physically delete business data; set `is_deleted = 1`, `deleted_by`, `deleted_at`, `updated_by`, and `updated_at`.
- Restore: set `is_deleted = 0`, clear `deleted_by` and `deleted_at`, and refresh `updated_by` plus `updated_at`.
- Queries and views: filter normal read paths with `is_deleted = 0`; add `is_active = 1` only when the caller needs enabled records.
- Seed merges: when reactivating baseline records, set `is_deleted = 0`, clear delete audit columns, and preserve stable IDs.

## Index Standards

- Keep indexes in `02_indexes.sql`.
- Include `is_deleted` near the front of indexes used by normal read paths.
- Include `is_active` in indexes for enabled-only lookup screens.
- Index foreign key columns used in joins and cascade checks.
- Use function-based indexes intentionally, such as `LOWER(email)`, only when the query uses the same expression.
- Avoid duplicate indexes whose leading columns are already covered by another index.

## View Standards

- Keep views in `03_views.sql`.
- Always filter each participating table or joined alias with `is_deleted = 0`.
- Use explicit column lists and stable aliases; do not expose `SELECT *`.
- Alias duplicate semantic columns clearly, such as `product_is_active`, `module_is_active`, or `feature_display_order`.
- Use ANSI joins and keep join filters beside their joined table.
- Use i18n views when the output needs language-specific text from `ph_i18n_texts` or `ph_i18n_messages`.

## Trigger Standards

- Keep triggers in `04_triggers.sql`.
- Standard audit triggers should set defaults on insert and audit fields on update/delete transitions.
- Validation triggers should raise `raise_application_error` with project-specific `-20xxx` error numbers and clear messages.
- Do not hide trigger errors.
- Avoid business logic in triggers when a package procedure is the clearer service boundary.
- If a table is added, add any required audit trigger, validation trigger, comments, indexes, and seed-data handling in the same change.

## Seed Data Standards

- Keep seed data idempotent with `MERGE`.
- Use explicit ID values for baseline lookup data that application logic depends on.
- Use `created_by = 1` for system-owned baseline seed rows unless a different system user is documented.
- On matched rows, refresh display text and flags, restore soft-deleted baseline rows, and clear delete audit columns.
- Do not put environment secrets, real passwords, or production customer data in seed scripts.

## Package Implementation Standards

- Package specs should expose stable service procedures and functions only.
- Package bodies should keep validation helpers private unless callers need them.
- Use `p_created_by` for create routines and `p_updated_by` for update/delete/restore routines.
- Return `S`, `V`, or `E` through `p_result_code` and a meaningful message through `p_result_message` for service-style procedures.
- Validate parent records with `is_deleted = 0` before inserting child records.
- For update procedures, use `COALESCE` or `NVL` carefully so omitted parameters do not overwrite existing values.
- Delete procedures should soft-delete and be idempotent where practical.
- Restore procedures should clear delete audit fields and reactivate related rows only when that is the documented behavior.
- Do not commit inside reusable package procedures; let the caller control the transaction.
- In exception handlers, set a useful result status/message or re-raise. Never swallow errors with `WHEN OTHERS THEN NULL`.

## REST And APEX Standards

- Keep environment-neutral authentication, sessions, authorization helpers, user preference helpers, and password/security context helpers in `ph_sec_authentication_pkg`.
- Keep APEX authentication scheme callbacks and APEX runtime helpers in `ph_sec_authentication_apex_pkg`.
- Keep security entity create/update/delete/restore logic, including non-APEX security entities and APEX page setup entities, in `ph_sec_management_pkg`; keep REST-facing wrappers in the REST API packages.
- Never return password hashes or reset tokens from API functions.
- Check page, role, object, permission, and user records with `is_deleted = 0`.
- Keep public page/access decisions explicit; avoid relying on nulls for security behavior.
- REST wrappers should call package services rather than duplicating core business logic.

## Validation Checklist

Before finishing database changes:

- Confirm each new table has keys, checks, audit columns, comments, and useful indexes.
- Confirm views and package queries exclude soft-deleted rows.
- Confirm package specs and bodies compile together.
- Confirm `06_packages.sql` runs package files in dependency order.
- Confirm seed scripts are repeatable.
- Confirm no production credentials, real passwords, or environment secrets were added.
