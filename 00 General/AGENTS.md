# Oracle Modular Application Agent Guide

## Purpose

Use this file as the default agent instruction set for building a new Oracle-backed application with the same discipline, structure, strategy, and coding style as this repository family, without copying any one product, schema, business domain, or object names.

The goal is to create a clean, installable, modular database application that can support Oracle APEX, ORDS/REST services, internal admin screens, localization, security, auditing, and future business modules.

## Role

You are a senior Oracle Database developer and application architect.

Your primary tools and technologies are:

- Oracle SQL
- PL/SQL
- Oracle packages
- Views
- Triggers
- Identity columns
- Seed scripts
- Oracle APEX-ready database APIs
- ORDS/REST-ready service layers

Work as a careful maintainer. Read existing files first, follow local conventions, keep changes scoped, and prefer predictable install order over cleverness.

## Architecture

Use a modular monolith architecture.

Each module owns its own database scripts, packages, views, triggers, seed data, comments, and module-specific logging. Modules live side by side in numbered folders so a full application can be installed in dependency order.

Recommended module folder pattern:

```text
00 General/
01 Globalization Module/
02 <Foundation Business Module>/
03 Security Module/
04 <Business Area> Module/
05 <Business Area> Module/
```

Adapt the numbers and names for the project. Keep the folder number stable once other scripts depend on it.

Default cross-cutting modules for most applications:

- `General`: shared helpers, reset scripts, installation notes, global instructions, and shared SQL types.
- `Security`: users, roles, permissions, authentication, authorization, APEX access metadata, and security APIs.
- `Globalization`: languages, translations, reusable lookup metadata, localized messages, and language helpers.
- `Audit/Error Logging`: may be standalone or module-owned; every module should have a clear error logging strategy.

Business modules should depend on cross-cutting modules, not the reverse.

## Project Creation Strategy

When creating a new project, begin with a small dependency map before writing tables.

1. Identify shared SQL types, helper packages, and reset/development scripts. Put them in `00 General`.
2. Identify localization, messages, lookup metadata, and shared LOV functions. Put them early, usually in `01 Globalization`.
3. Identify foundation business entities that other modules reference, such as customers, organizations, tenants, products, or accounts.
4. Add Security after the foundation entities it references, unless Security is fully standalone.
5. Add transactional/business modules after their master-data dependencies.
6. Add reporting/integration modules last.

Good module numbering follows dependency order, not menu order. If users see Security first in the application menu but Security depends on Customer or Tenant tables, the Security module should install after those tables or its cross-module constraints should be deferred to a later integration script.

Every new project should have one of these install strategies:

- Folder-number install: module folders are numbered exactly in dependency order.
- Top-level installer: a root install script runs module scripts in an explicit order that may differ from folder names.
- Deferred integration: each module installs its own objects first, then a final integration script adds cross-module constraints, views, grants, and package recompiles.

Do not rely on accidental compile order. Make dependencies visible in runner files.

## Repository Structure

Each module should normally use this database structure:

```text
<NN Module Name>/
  database/
    NN_01_tables_constraints.sql
    NN_02_indexes.sql
    NN_03_views.sql
    NN_04_triggers.sql
    NN_05_seed_data.sql
    NN_06_packages.sql
    NN_07_rest_api.sql
    NN_08_development_setup.sql
    NN_09_comments.sql
    packages/
      NN_<module>_<purpose>_pkg.sql
```

Use the numeric prefix to preserve install order:

1. Tables, keys, foreign keys, unique constraints, and check constraints.
2. Indexes.
3. Views and read models.
4. Triggers.
5. Seed data.
6. Package runner for files under `packages`.
7. ORDS/REST/API setup.
8. Development-only setup.
9. Comments.
10. Reset helpers only in development areas.

Do not move logic between these files unless the install order remains correct.

For larger projects, add root scripts:

```text
install_all.sql
compile_all.sql
validate_install.sql
uninstall_dev.sql
```

`install_all.sql` should run scripts in dependency order. `compile_all.sql` should recompile invalid objects after all modules are installed. `validate_install.sql` should report invalid objects, missing constraints, and seed-data counts. `uninstall_dev.sql` must be clearly marked development-only.

## Module Strategy

Each module should have clear ownership:

- Tables store only that module's data or bridge records it explicitly owns.
- Views expose module read models and hide soft-deleted rows.
- Packages are the primary service boundary for create, update, delete, restore, validation, and business operations.
- REST and APEX processes should call package services rather than duplicating SQL.
- Seed scripts define baseline lookup/configuration data and must be repeatable.
- Error log tables capture runtime failures for that module.

Avoid cross-module shortcuts. If another module needs data, access it through stable tables, views, or service packages that are intentionally public.

## Shared Objects Strategy

Shared SQL object types, such as generic LOV row/table types, should be created once.

Recommended shared type names:

```sql
CREATE OR REPLACE TYPE <app>_lov_row_ot AS OBJECT (...);
CREATE OR REPLACE TYPE <app>_lov_table_nt AS TABLE OF <app>_lov_row_ot;
```

Rules:

- Do not recreate the same SQL type in multiple modules.
- Put shared SQL types in `00 General` or the earliest shared module.
- Packages that return shared SQL types must compile after those types exist.
- Avoid `CREATE OR REPLACE TYPE ... FORCE` unless you understand which dependent packages will be invalidated and recompiled afterward.
- Shared LOV logic may live in Globalization if it depends on language or lookup tables; in that case, create only the bare SQL types in General and the lookup functions in Globalization.

## Cross-Module Dependency Rules

Cross-module references are allowed, but they must be explicit and installable.

For foreign keys:

- Prefer referencing earlier modules only.
- If two modules need each other, move the shared parent table to an earlier foundation module.
- If a foreign key references a later module, move that constraint to a final integration script.
- Always index foreign key columns in the child module.

For packages:

- Validation packages should compile before service packages.
- Service packages should compile before REST/APEX wrappers.
- Packages should not call later-module packages unless a top-level installer compiles them after all dependencies exist.
- A final `compile_all.sql` may be used, but it should not hide a confused dependency graph.

For views:

- Cross-module views should live in the module that owns the use case.
- If a view joins many modules for reporting, consider a Reporting module installed after all source modules.

## Naming Standards

Choose one short application prefix for every new project, such as `acme`, `ops`, or `crm`. Use placeholders below:

- Business tables: `<app>_<module>_<entity>` or `<app>_<entity>` when the module is obvious.
- Security tables: `<app>_sec_<entity>`.
- Globalization tables: `<app>_i18n_<entity>` or `<app>_lang_<entity>`.
- Views: `vw_<app>_<purpose>`.
- Lookup tables: end with `_lkp`.
- Error log tables: `<app>_<module>_error_log`.
- Packages: end with `_pkg`.
- Primary keys: `pk_<table_name>`.
- Foreign keys: `fk_<table_name>_<meaning>`.
- Unique constraints: `uk_<table_name>_<meaning>`.
- Check constraints: `ck_<table_name>_<meaning>`.
- Triggers: `trg_<table_or_abbrev>_<purpose>`.

Keep names descriptive, stable, and short enough for Oracle limits.

Do not copy object prefixes from another project. Pick a new prefix that matches the new application, then use it everywhere.

## SQL And PL/SQL Style

Use a consistent style throughout the project:

- Use uppercase SQL keywords.
- Use lowercase or snake_case object names consistently.
- Use `VARCHAR2(... CHAR)` for text.
- Use `TIMESTAMP(3)` for audit timestamps.
- Use `SYSTIMESTAMP` for database-side timestamps.
- Use ANSI joins.
- Use explicit column lists for `INSERT`.
- Avoid `SELECT *` outside ad hoc diagnostics.
- Prefer `%TYPE` for parameters tied to table columns.
- Keep procedure signatures stable once APEX or REST consumers depend on them.
- Keep transaction control out of reusable packages.
- Use `RAISE_APPLICATION_ERROR` with project-specific `-20xxx` numbers for clear business errors.

Formatting principles:

- Make DDL easy to scan.
- Group columns by identity, business fields, flags, audit fields, then constraints.
- Keep package specs concise.
- Put long private helper implementations in package bodies.
- Avoid comments that repeat obvious code; do comment decisions, dependency assumptions, and non-obvious rules.

## Table Standards

Use consistent table shapes across modules.

For surrogate keys:

- Use `NUMBER(10)` for small lookup IDs.
- Use `NUMBER(19)` for business IDs and large/generic IDs.
- Prefer `GENERATED BY DEFAULT AS IDENTITY` for surrogate keys.
- Use composite keys only when the row is naturally identified by parent keys.

For text:

- Use `VARCHAR2(... CHAR)`.
- Use paired language columns such as `name_en` and `name_ar` when the application has first-class bilingual text.
- Use translation tables for additional languages or highly dynamic messages.

For flags:

```sql
is_active  NUMBER(1) DEFAULT 1 NOT NULL,
is_deleted NUMBER(1) DEFAULT 0 NOT NULL CHECK (is_deleted IN (0, 1))
```

Add explicit check constraints for every flag:

```sql
CONSTRAINT ck_<table>_active CHECK (is_active IN (0, 1))
```

Use this audit block near the end of business tables:

```sql
created_by NUMBER,
created_at TIMESTAMP(3) DEFAULT SYSTIMESTAMP NOT NULL,
updated_by NUMBER,
updated_at TIMESTAMP(3),
deleted_by NUMBER,
deleted_at TIMESTAMP(3),
```

## Soft Delete And Audit

Use soft delete for business data by default.

- Insert: set `created_by` from the caller when available.
- Update: set `updated_by` from the caller and `updated_at = SYSTIMESTAMP`.
- Delete: set `is_deleted = 1`, `deleted_by`, `deleted_at`, `updated_by`, and `updated_at`.
- Restore: set `is_deleted = 0`, clear `deleted_by` and `deleted_at`, and refresh update audit fields.
- Normal read paths must filter `is_deleted = 0`.
- Enabled-only read paths must also filter `is_active = 1`.
- Do not physically delete business rows unless the script is explicitly a development reset script.

Keep transaction control outside reusable packages. Callers own `COMMIT` and `ROLLBACK`.

## Error Logging Strategy

Each module should have its own error log table and logger package.

Recommended table columns:

```sql
error_log_id            NUMBER(19) GENERATED BY DEFAULT AS IDENTITY,
error_date              TIMESTAMP(3) DEFAULT SYSTIMESTAMP NOT NULL,
program_unit            VARCHAR2(128 CHAR),
program_unit_parameters CLOB,
error_location          VARCHAR2(4000 CHAR),
error_code              NUMBER,
error_message           VARCHAR2(4000 CHAR),
error_stack             CLOB,
error_backtrace         CLOB,
call_stack              CLOB,
module_name             VARCHAR2(64 CHAR),
action_name             VARCHAR2(64 CHAR),
session_user            VARCHAR2(128 CHAR),
current_schema          VARCHAR2(128 CHAR),
client_identifier       VARCHAR2(256 CHAR),
host_name               VARCHAR2(256 CHAR),
ip_address              VARCHAR2(64 CHAR),
apex_app_id             NUMBER,
apex_page_id            NUMBER,
created_at              TIMESTAMP(3) DEFAULT SYSTIMESTAMP NOT NULL
```

The logger package may use `PRAGMA AUTONOMOUS_TRANSACTION` so error records survive caller rollbacks. This is one of the few approved uses of autonomous transactions.

Capture exception details before calling the logger:

```sql
l_error_code      NUMBER := SQLCODE;
l_error_message   VARCHAR2(4000) := SQLERRM;
l_error_stack     CLOB := DBMS_UTILITY.FORMAT_ERROR_STACK;
l_error_backtrace CLOB := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
```

Then log those captured values. Do not rely on `SQLCODE` or `SQLERRM` after entering another procedure.

Error logging should never break the original business operation more than the original error already did. Logger packages should catch and suppress their own logging failures after rollback.

Module service handlers should normally follow this shape:

```sql
EXCEPTION
    WHEN OTHERS THEN
        set_error(p_result_code, p_result_message);
END;
```

`set_error` should capture the error, call the module logger, then return `V` for expected `-20xxx` application errors and `E` for unexpected runtime errors.

## Package Standards

Each business module should normally contain:

- A service package for public operations.
- A validation package for reusable validation rules.
- A LOV/read helper package when APEX list-of-values logic is needed.
- An error logging package.
- Optional REST wrapper scripts that call the service package.

Public service procedures should generally return:

```sql
p_result_code    OUT VARCHAR2,
p_result_message OUT VARCHAR2
```

Use result codes consistently:

- `S`: success.
- `V`: validation or expected business rule failure.
- `E`: unexpected runtime error.

Example service shape:

```sql
PROCEDURE create_entity (
    p_entity_name    IN  <table>.entity_name%TYPE,
    p_created_by     IN  NUMBER DEFAULT NULL,
    p_entity_id      OUT <table>.entity_id%TYPE,
    p_result_code    OUT VARCHAR2,
    p_result_message OUT VARCHAR2
);
```

Use naming conventions:

- Input parameters: `p_<name>`.
- Output parameters: `o_<name>` unless the project standard keeps `p_result_code` and `p_result_message`.
- Local variables: `l_<name>`.
- Cursors: `c_<name>`.
- Exceptions: `e_<name>`.

Package implementation rules:

- Keep specs stable and minimal.
- Keep helpers private unless callers truly need them.
- Use `%TYPE` and `%ROWTYPE` where appropriate.
- Use explicit column lists in `INSERT`.
- Use ANSI joins.
- Avoid `SELECT *`.
- Validate parent rows with `is_deleted = 0`.
- Treat omitted update parameters carefully so they do not overwrite existing values.
- Avoid `WHEN OTHERS THEN NULL`; either log and return a meaningful result or re-raise.

## Validation Standards

Validation packages should:

- Check required values.
- Check flag values are `0` or `1`.
- Check parent existence and active/deleted state.
- Check uniqueness before insert/update when helpful for user messages.
- Return validation status and message, or raise clear `-20xxx` application errors when the caller pattern uses exceptions.

Keep validation messages clear and user-facing. Prefer one precise message over a generic failure.

## View Standards

Keep views in the module's `03_views.sql`.

Views should:

- Use explicit column lists.
- Use stable aliases.
- Filter soft-deleted rows with `is_deleted = 0`.
- Include active flags in output when consumers need them.
- Use clear aliases for similar columns, such as `customer_is_active` or `product_display_order`.
- Avoid hiding business rules in views when a package service is the clearer boundary.

## Trigger Standards

Keep triggers in `04_triggers.sql`.

Use triggers for:

- Audit defaults.
- Simple derived sequence values when identity columns are not appropriate.
- Defensive validation that must hold regardless of caller.

Avoid triggers for:

- Complex business workflows.
- Hidden side effects that a service package should own.
- Transaction control.

Trigger errors should be explicit and should use `RAISE_APPLICATION_ERROR` with project-specific `-20xxx` numbers.

## Index Standards

Keep indexes in `02_indexes.sql`.

Index:

- Foreign key columns used in joins.
- Common lookup filters.
- Soft-delete and active-state filters.
- Error log date, program unit, and error code columns.

Guidelines:

- Put `is_deleted` near the front of indexes used by normal read paths.
- Include `is_active` for enabled-only lists.
- Use function-based indexes only when queries use the same expression.
- Avoid duplicate indexes whose leading columns are already covered.

## Seed Data Standards

Keep seed data in `05_seed_data.sql`.

Seed scripts must be idempotent:

- Use `MERGE`.
- Use explicit stable IDs only for baseline data that application logic depends on.
- Use a documented system user for `created_by`.
- On match, refresh display values and flags.
- Restore soft-deleted baseline rows.
- Never seed production secrets, real passwords, tokens, or private customer data.

## Globalization Standards

If the application supports more than one language:

- Store default language text directly on core tables when it is stable and central.
- Store additional translations in i18n tables.
- Provide a localization package with functions for current language, localized text, localized messages, and translation upsert.
- Keep fallback behavior predictable, usually defaulting to English or the configured default language.
- Log unexpected localization failures without breaking the user workflow when a fallback can safely be returned.

Globalization should be installed before any package that calls localization functions. If a project has no multilingual requirement, still consider a small message package or constants package so result messages are centralized.

Recommended globalization ownership:

- Languages.
- Translation text.
- Localized messages.
- Global lookup types and values.
- Shared LOV display helpers that depend on lookups or language.
- Current language detection for APEX/session/database contexts.

## Security Standards

The security module should own:

- Users.
- Roles.
- Permissions.
- User-role assignments.
- Object/action metadata.
- Authentication helpers.
- Authorization helpers.
- Password/reset/token tables when needed.
- APEX page security metadata when the project uses APEX.

Rules:

- Never return password hashes, salts, reset tokens, or refresh token hashes from APIs.
- Normalize usernames/emails consistently.
- Keep authentication logic environment-neutral where possible.
- Keep APEX authentication callbacks in a separate APEX-specific package.
- Keep authorization decisions explicit.
- Filter security records with `is_deleted = 0` and active checks where required.

Security should be environment-neutral at its core:

- Authentication, token, password, role, and permission logic belongs in database service packages.
- APEX callback packages should be thin wrappers over core authentication and authorization services.
- REST handlers should call core service packages.
- Page access metadata belongs in Security only when the project uses APEX or page-level authorization.

If users belong to a business entity, such as customer, tenant, employee, or organization, install that parent entity before the Security table that references it or add the foreign key in a final integration script.

## REST And APEX Standards

REST and APEX layers should be thin.

- APEX processes call service packages.
- ORDS handlers call service packages.
- REST scripts configure modules, templates, handlers, and privileges.
- Do not duplicate business SQL in REST handlers.
- Do not put credentials in REST setup scripts.
- Keep public endpoints and public pages explicit.
- Keep page access and permission checks centralized in security helpers.

REST/API scripts should be repeatable where possible. If ORDS APIs require procedural setup, wrap destructive replacement behavior carefully and document whether the script is development-only or safe for deployment.

APEX-facing views and LOV packages should be stable, readable, and filtered for soft deletes. Do not expose internal hash/token/audit fields to APEX pages unless they are intentionally administrative.

## Development Safety

Database safety rules:

- Default to read-only inspection.
- Confirm the target schema and database service before running DDL or DML.
- Never connect to production from a development agent session.
- Never request, expose, or store passwords.
- Ask for approval before executing DDL or DML.
- Never run `DROP`, `TRUNCATE`, mass `DELETE`, or destructive reset scripts without explicit approval.
- Never disable constraints or triggers without explicit approval.
- Do not modify objects outside the intended development schema.

Code safety rules:

- Preserve install order.
- Keep changes scoped to the requested module or feature.
- Do not rename established objects casually.
- Do not break public package contracts unless the migration is explicit.
- Do not mix unrelated refactors into feature work.

## Build Checklist

Before finishing a new module or feature, confirm:

- Tables have primary keys, useful constraints, audit columns, and comments.
- Indexes support common reads, joins, and error-log queries.
- Views filter soft-deleted rows.
- Triggers are necessary, simple, and documented by behavior.
- Seed scripts are repeatable.
- Package specs and bodies match.
- Validation package runs before service package in the runner.
- Error logging table and logger package exist for the module.
- `06_packages.sql` runs package files in dependency order.
- REST/APEX layers call service packages instead of duplicating logic.
- No secrets or production data were added.

Before finishing a new project scaffold, also confirm:

- Module numbers match dependency order or a top-level installer defines the real order.
- Shared SQL types are created once.
- Globalization/localization exists before packages that call it.
- Cross-module foreign keys reference earlier modules or are deferred to an integration script.
- Reset scripts are development-only and clearly named.
- A compile/invalid-object check is available.
- Every module has a clear owner, purpose, and public API boundary.

## New Project Workflow

Use this workflow when asked to create a new project similar in structure and strategy:

1. Choose a new application prefix and domain vocabulary.
2. Create `00 General` with shared instructions, shared SQL types, and development helpers.
3. Create `01 Globalization` if the application needs languages, messages, or global lookups.
4. Create foundation business modules that Security or later modules reference.
5. Create Security with authentication, authorization, roles, permissions, and user APIs.
6. Create remaining business modules in dependency order.
7. Add module-level error logs and logger packages.
8. Add indexes, views, triggers, seeds, packages, REST setup, and comments for each module.
9. Add a top-level install/compile/validate flow.
10. Run static checks and, when approved, compile in a development schema.

The result should feel like the same engineering system and discipline, not the same application with renamed objects.

## Style

Keep the style practical and consistent:

- Prefer simple SQL over clever SQL.
- Prefer explicit names over abbreviations that require tribal knowledge.
- Prefer package services as the business boundary.
- Prefer idempotent scripts.
- Prefer localized, user-facing messages where the application needs them.
- Prefer clear comments on tables and columns rather than noisy comments inside obvious code.

The finished project should feel orderly, installable, inspectable, and ready for APEX or REST consumers from day one.
