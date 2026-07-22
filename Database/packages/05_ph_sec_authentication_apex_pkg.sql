/*
    ProductHub Manager - APEX Security Authentication Package
    Target DBMS: Oracle Database 21c+

    Purpose:
    - APEX authentication scheme callbacks and APEX-specific navigation helpers.
    - Delegates environment-neutral authentication logic to ph_sec_authentication_pkg.

    Authentication Function Name: ph_sec_authentication_apex_pkg.authenticate_user
    Sentry Function Name: ph_sec_authentication_apex_pkg.sentry_function
    Pre-Authentication Procedure Name: ph_sec_authentication_apex_pkg.pre_authentication
    Post-Authentication Procedure Name: ph_sec_authentication_apex_pkg.post_authentication
    Invalid Session Procedure Name: ph_sec_authentication_apex_pkg.invalid_session
    Post Logout Procedure Name: ph_sec_authentication_apex_pkg.post_logout
*/

CREATE OR REPLACE PACKAGE ph_sec_authentication_apex_pkg AS
    FUNCTION authenticate_user(
        p_username IN ph_sec_authentication_pkg.t_username,
        p_password IN ph_sec_authentication_pkg.t_password
    ) RETURN BOOLEAN;

    FUNCTION sentry_function RETURN BOOLEAN;

    PROCEDURE pre_authentication(
        p_username IN ph_sec_authentication_pkg.t_username DEFAULT NULL
    );

    PROCEDURE post_authentication(
        p_username IN ph_sec_authentication_pkg.t_username DEFAULT NULL
    );

    PROCEDURE invalid_session;

    PROCEDURE post_logout;

    FUNCTION navigation_menu_sql RETURN VARCHAR2;
END ph_sec_authentication_apex_pkg;
/

CREATE OR REPLACE PACKAGE BODY ph_sec_authentication_apex_pkg AS
    FUNCTION normalize_username(p_username IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN LOWER(TRIM(p_username));
    END normalize_username;

    FUNCTION current_apex_username RETURN VARCHAR2 IS
        l_username VARCHAR2(255);
    BEGIN
        l_username := normalize_username(COALESCE(
            APEX_APPLICATION.G_USER,
            V('P9999_USERNAME'),
            V('P101_USERNAME'),
            V('APP_USER'),
            SYS_CONTEXT('APEX$SESSION', 'APP_USER'),
            SYS_CONTEXT('USERENV', 'CLIENT_IDENTIFIER')
        ));

        IF l_username IN ('nobody', 'apex_public_user') THEN
            l_username := normalize_username(COALESCE(
                V('P9999_USERNAME'),
                V('P101_USERNAME'),
                SYS_CONTEXT('USERENV', 'CLIENT_IDENTIFIER')
            ));
        END IF;

        RETURN l_username;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN normalize_username(SYS_CONTEXT('USERENV', 'CLIENT_IDENTIFIER'));
    END current_apex_username;

    FUNCTION current_apex_session_id RETURN VARCHAR2 IS
    BEGIN
        RETURN COALESCE(
            V('APP_SESSION'),
            SYS_CONTEXT('APEX$SESSION', 'APP_SESSION'),
            SYS_CONTEXT('USERENV', 'CLIENT_IDENTIFIER'),
            SYS_CONTEXT('USERENV', 'SESSIONID')
        );
    END current_apex_session_id;

    FUNCTION authenticate_user(
        p_username IN ph_sec_authentication_pkg.t_username,
        p_password IN ph_sec_authentication_pkg.t_password
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

        IF ph_sec_authentication_pkg.is_user_active(l_username) THEN
            ph_sec_authentication_pkg.set_security_context(l_username);
            RETURN TRUE;
        END IF;

        IF ph_sec_authentication_pkg.get_username() IS NOT NULL THEN
            RETURN ph_sec_authentication_pkg.is_valid_session(
                ph_sec_authentication_pkg.get_username(),
                current_apex_session_id
            );
        END IF;

        RETURN FALSE;
    EXCEPTION
        WHEN OTHERS THEN
            ph_sec_authentication_pkg.clear_security_context;
            RETURN FALSE;
    END sentry_function;

    PROCEDURE pre_authentication(
        p_username IN ph_sec_authentication_pkg.t_username DEFAULT NULL
    ) IS
    BEGIN
        ph_sec_authentication_pkg.clear_security_context;
    END pre_authentication;

    PROCEDURE post_authentication(
        p_username IN ph_sec_authentication_pkg.t_username DEFAULT NULL
    ) IS
        l_username VARCHAR2(255) := COALESCE(normalize_username(p_username), current_apex_username);
    BEGIN
        IF l_username IS NOT NULL
           AND l_username NOT IN ('nobody', 'apex_public_user') THEN
            ph_sec_authentication_pkg.set_security_context(l_username);
            ph_sec_authentication_pkg.create_user_session(l_username, current_apex_session_id);
        END IF;
    END post_authentication;

    PROCEDURE invalid_session IS
    BEGIN
        ph_sec_authentication_pkg.clear_security_context;
    END invalid_session;

    PROCEDURE post_logout IS
    BEGIN
        IF ph_sec_authentication_pkg.get_username() IS NOT NULL THEN
            ph_sec_authentication_pkg.close_user_session(
                ph_sec_authentication_pkg.get_username(),
                current_apex_session_id
            );
        END IF;

        ph_sec_authentication_pkg.clear_security_context;
    END post_logout;

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
