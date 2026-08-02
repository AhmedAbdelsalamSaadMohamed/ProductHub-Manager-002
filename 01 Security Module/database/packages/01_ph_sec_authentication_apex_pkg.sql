/*
ProductHub Manager - APEX Security Authentication Package
Target DBMS: Oracle Database 21c+

Purpose:
- APEX authentication scheme callbacks and APEX-specific navigation helpers.
- Delegates environment-neutral authentication logic to ph_sec_authentication_pkg.

Authentication Function Name: ph_sec_authentication_apex_pkg.authenticate_user
Sentry Function Name: ph_sec_authentication_apex_pkg.sentry_function
*/

CREATE OR REPLACE PACKAGE ph_sec_authentication_apex_pkg AS
    FUNCTION authenticate_user(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2
        ) RETURN BOOLEAN;

    FUNCTION sentry_function RETURN BOOLEAN;

    FUNCTION navigation_menu_sql RETURN VARCHAR2;
END ph_sec_authentication_apex_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_sec_authentication_apex_pkg AS

    FUNCTION current_apex_username RETURN VARCHAR2 IS
        l_username VARCHAR2(255);
    BEGIN
        l_username := LOWER(TRIM(COALESCE(
        APEX_APPLICATION.G_USER,
        V('P9999_USERNAME'),
        V('P101_USERNAME'),
        V('APP_USER')
        )));

        IF l_username IN ('nobody', 'apex_public_user') THEN
            l_username := LOWER(TRIM(COALESCE(
            V('P9999_USERNAME'),
            V('P101_USERNAME')
            )));
        END IF;

        RETURN l_username;
    EXCEPTION
        WHEN OTHERS THEN
            ph_sec_error_log_pkg.log_error(
                p_program_unit => $$PLSQL_UNIT || '.current_apex_username',
                p_error_location => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_error_code => SQLCODE,
                p_error_message => SQLERRM,
                p_error_stack => DBMS_UTILITY.FORMAT_ERROR_STACK,
                p_error_backtrace => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
            );
            RETURN NULL;
    END current_apex_username;

    FUNCTION authenticate_user(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2
    ) RETURN BOOLEAN IS
    BEGIN
        RETURN ph_sec_authentication_pkg.authenticate_user(p_username, p_password);
    END authenticate_user;

    FUNCTION sentry_function RETURN BOOLEAN IS
        l_username VARCHAR2(255);
    BEGIN
        l_username := current_apex_username;

        IF l_username IS NULL
                OR l_username IN ('nobody', 'apex_public_user') THEN
        RETURN FALSE;
        END IF;

        RETURN ph_sec_authentication_pkg.is_user_active(l_username);
    EXCEPTION
        WHEN OTHERS THEN
            ph_sec_error_log_pkg.log_error(
                p_program_unit => $$PLSQL_UNIT || '.sentry_function',
                p_error_location => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_error_code => SQLCODE,
                p_error_message => SQLERRM,
                p_error_stack => DBMS_UTILITY.FORMAT_ERROR_STACK,
                p_error_backtrace => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
            );
            RETURN FALSE;
    END sentry_function;

    FUNCTION navigation_menu_sql RETURN VARCHAR2 IS
    BEGIN
        RETURN q'[
        with user_pages as (
        select distinct
        u.user_id,
        lower(u.email) as username,
        o.object_id,
        o.object_name,
        o.display_name_en as module_name_en,
        o.display_name_ar as module_name_ar,
        pg.apex_page_id,
        pg.apex_page_no,
        pg.page_alias,
        pg.page_name_en,
        pg.page_name_ar,
        pt.apex_page_type_code
            from ph_sec_users u
        join ph_sec_user_roles ur
            on ur.user_id = u.user_id
        join ph_sec_roles r
            on r.role_id = ur.role_id
        join ph_sec_role_permissions rp
            on rp.role_id = r.role_id
        join ph_sec_permissions p
            on p.permission_id = rp.permission_id
        join ph_sec_objects o
            on o.object_id = p.object_id
        join ph_sec_apex_page_permissions app
            on app.permission_id = p.permission_id
        join ph_sec_apex_pages pg
            on pg.apex_page_id = app.apex_page_id
        join ph_sec_apex_page_type_lkp pt
            on pt.apex_page_type_id = pg.apex_page_type_id
            where lower(u.email) = lower(:APP_USER)
                and pg.apex_app_id = :APP_ID
                and :APP_ID is not null
                and :APP_USER is not null
                and :APP_SESSION is not null
                and u.is_active = 1
                and r.is_active = 1
                and p.is_active = 1
                and o.is_active = 1
                and app.is_active = 1
                and app.is_an_access_permission = 1
                and pg.is_active = 1
                and pt.is_active = 1
                and exists (
        select 1
            from vw_ph_sec_user_page_access v
            where v.apex_page_id = pg.apex_page_id
                and v.apex_app_id = pg.apex_app_id
                and lower(v.username) = lower(:APP_USER)
                and v.has_access = 1
        )
        ),
        nav_rows as (
        select
        1 as display_level,
        ph_localization_pkg.i18n_text('PH_SEC_OBJECTS', to_char(object_id), 'DISPLAY_NAME', module_name_en, module_name_ar) as label,
        cast(null as varchar2(4000)) as target,
        case
        when max(case when apex_page_no = :APP_PAGE_ID then 1 else 0 end) = 1 then 'YES'
        else 'NO'
            end as is_current,
            case object_name
        when 'PRODUCTS' then 'fa-cubes'
        when 'CUSTOMERS' then 'fa-users'
        when 'CONTRACTS' then 'fa-file-text-o'
        when 'SECURITY_ADMIN' then 'fa-lock'
        when 'REPORTS' then 'fa-table'
        when 'PLATFORM_SETUP' then 'fa-cog'
        when 'CUSTOMER_ONBOARDING' then 'fa-user-plus'
        when 'DASHBOARD' then 'fa-dashboard'
        else 'fa-folder'
            end as image,
            cast(null as varchar2(4000)) as image_attribute,
            ph_localization_pkg.i18n_text('PH_SEC_OBJECTS', to_char(object_id), 'DISPLAY_NAME', module_name_en, module_name_ar) as image_alt_attribute,
            cast(object_name as varchar2(4000)) as attribute1,
            cast('MODULE' as varchar2(4000)) as attribute2,
            object_id as sort_group,
            0 as sort_page
                from user_pages
                group by object_id, object_name, module_name_en, module_name_ar
            union all
            select
            2 as display_level,
            ph_localization_pkg.i18n_text('PH_SEC_APEX_PAGES', to_char(apex_page_id), 'PAGE_NAME', page_name_en, page_name_ar) as label,
            apex_util.prepare_url('f?p=' || :APP_ID || ':' || apex_page_no || ':' || :APP_SESSION) as target,
            case
        when apex_page_no = :APP_PAGE_ID then 'YES'
        else 'NO'
            end as is_current,
            case apex_page_type_code
        when 'DASHBOARD' then 'fa-dashboard'
        when 'REPORT' then 'fa-table'
        when 'ADMIN' then 'fa-lock'
        when 'FORM' then 'fa-edit'
        else 'fa-file'
            end as image,
            cast(null as varchar2(4000)) as image_attribute,
            ph_localization_pkg.i18n_text('PH_SEC_APEX_PAGES', to_char(apex_page_id), 'PAGE_NAME', page_name_en, page_name_ar) as image_alt_attribute,
            cast(page_alias as varchar2(4000)) as attribute1,
            cast(apex_page_type_code as varchar2(4000)) as attribute2,
            object_id as sort_group,
            apex_page_no as sort_page
                from user_pages
            )
            select
            display_level as "LEVEL",
            label,
            target,
            is_current,
            image,
            image_attribute,
            image_alt_attribute,
            attribute1,
            attribute2
                from nav_rows
                order by sort_group, display_level, sort_page, label]';
    END navigation_menu_sql;
END ph_sec_authentication_apex_pkg;
/

