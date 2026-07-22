/*
    ProductHub Manager - Generic Security Authentication Package
    Target DBMS: Oracle Database 21c+

    Purpose:
    - Environment-neutral authentication, authorization, password, session, preference, and security context helpers.
    - Do not call APEX runtime APIs from this package.
*/
create or replace package ph_sec_authentication_pkg as
   subtype t_username is varchar2(255);
   subtype t_password is varchar2(4000);
   function authenticate_user (
      p_username in t_username,
      p_password in t_password
   ) return boolean;
   function hash_password (
      p_password in t_password,
      p_salt     in varchar2
   ) return varchar2;

   function verify_password (
      p_password      in t_password,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return boolean;


   function is_user_active (
      p_username in t_username
   ) return boolean;

   function is_user_locked (
      p_username in t_username
   ) return boolean;

   function must_change_password (
      p_username in t_username
   ) return boolean;

   procedure register_failed_login (
      p_username in t_username
   );

   procedure register_success_login (
      p_username in t_username
   );

   procedure lock_user (
      p_username in t_username
   );

   procedure unlock_user (
      p_username in t_username
   );

    ----------------------------------------------------------------------
    -- Session Management
    ----------------------------------------------------------------------
   procedure create_user_session (
      p_username   in t_username,
      p_session_id in varchar2
   );

   procedure close_user_session (
      p_username   in t_username,
      p_session_id in varchar2
   );

   function is_valid_session (
      p_username   in t_username,
      p_session_id in varchar2
   ) return boolean;

    ----------------------------------------------------------------------
    -- Authorization Helpers
    ----------------------------------------------------------------------
   function has_role (
      p_username  in t_username,
      p_role_code in varchar2
   ) return boolean;

   function has_permission (
      p_username        in t_username,
      p_permission_code in varchar2
   ) return boolean;

   function has_page_access (
      p_username in t_username,
      p_app_id   in number,
      p_page_id  in number
   ) return boolean;

    ----------------------------------------------------------------------
    -- User Preference Helpers
    ----------------------------------------------------------------------
   function get_user_preference (
      p_username        in t_username,
      p_preference_code in varchar2,
      p_default_value   in varchar2 default null
   ) return varchar2;

   procedure set_user_preference (
      p_username         in t_username,
      p_preference_code  in varchar2,
      p_preference_value in varchar2,
      p_value_type       in varchar2 default 'STRING',
      p_updated_by       in number default null
   );

    ----------------------------------------------------------------------
    -- REST / ORDS Helpers
    ----------------------------------------------------------------------
   procedure set_password (
      p_user_id    in number,
      p_password   in t_password,
      p_updated_by in number default null
   );

    ----------------------------------------------------------------------
    -- Context Management
    ----------------------------------------------------------------------
   procedure set_security_context (
      p_username in t_username
   );

   procedure clear_security_context;

   function get_user_id return number;

   function get_org_id return number;

   function get_username return varchar2;
end ph_sec_authentication_pkg;
/

create or replace package body ph_sec_authentication_pkg as
   g_user_id    ph_sec_users.user_id%type;
   g_org_id     ph_sec_users.customer_id%type;
   g_username   ph_sec_users.email%type;
   g_session_id varchar2(255);

   function normalize_username (
      p_username in t_username
   ) return varchar2 is
   begin
      return lower(trim(p_username));
   end normalize_username;


   function normalize_preference_code (
      p_preference_code in varchar2
   ) return varchar2 is
   begin
      return upper(trim(p_preference_code));
   end normalize_preference_code;


   function current_session_id return varchar2 is
   begin
      return coalesce(
         g_session_id,
         sys_context(
            'USERENV',
            'CLIENT_IDENTIFIER'
         ),
         sys_context(
            'USERENV',
            'SESSIONID'
         )
      );
   end current_session_id;

   function get_user_record_id (
      p_username in t_username
   ) return number is
      l_user_id  ph_sec_users.user_id%type;
      l_username ph_sec_users.email%type := normalize_username(p_username);
   begin
      select user_id
        into l_user_id
        from ph_sec_users
       where lower(email) = l_username
         and is_deleted = 0;

      return l_user_id;
   exception
      when no_data_found then
         return null;
   end get_user_record_id;

   function get_user_preference (
      p_username        in t_username,
      p_preference_code in varchar2,
      p_default_value   in varchar2 default null
   ) return varchar2 is
      l_user_id         ph_sec_users.user_id%type := get_user_record_id(p_username);
      l_preference_code ph_sec_user_preferences.preference_code%type := normalize_preference_code(p_preference_code);
      l_value           ph_sec_user_preferences.preference_value%type;
   begin
      if l_user_id is null
      or l_preference_code is null then
         return p_default_value;
      end if;
      select preference_value
        into l_value
        from ph_sec_user_preferences
       where user_id = l_user_id
         and preference_code = l_preference_code
         and is_active = 1
         and is_deleted = 0;

      if l_preference_code = 'LANGUAGE' then
         return ph_localization_pkg.normalize_language(coalesce(
            l_value,
            p_default_value
         ));
      end if;

      return coalesce(
         l_value,
         p_default_value
      );
   exception
      when no_data_found then
         return p_default_value;
   end get_user_preference;

   procedure set_user_preference (
      p_username         in t_username,
      p_preference_code  in varchar2,
      p_preference_value in varchar2,
      p_value_type       in varchar2 default 'STRING',
      p_updated_by       in number default null
   ) is
      l_user_id         ph_sec_users.user_id%type := get_user_record_id(p_username);
      l_preference_code ph_sec_user_preferences.preference_code%type := normalize_preference_code(p_preference_code);
      l_value           ph_sec_user_preferences.preference_value%type := trim(p_preference_value);
      l_value_type      ph_sec_user_preferences.value_type%type := upper(trim(coalesce(
         p_value_type,
         'STRING'
      )));
   begin
      if l_user_id is null then
         raise_application_error(
            -20302,
            ph_localization_pkg.localized_message('USER_NOT_FOUND')
         );
      end if;

      if l_preference_code is null
      or l_value_type not in ( 'STRING',
                               'NUMBER',
                               'BOOLEAN',
                               'JSON' ) then
         raise_application_error(
            -20391,
            ph_localization_pkg.localized_message('INVALID_PREFERENCE')
         );
      end if;

      if l_preference_code = 'LANGUAGE' then
         l_value := ph_localization_pkg.normalize_language(l_value);
         l_value_type := 'STRING';
      elsif l_preference_code = 'THEME_MODE' then
         l_value := upper(coalesce(
            l_value,
            'SYSTEM'
         ));
         if l_value not in ( 'LIGHT',
                             'DARK',
                             'SYSTEM' ) then
            raise_application_error(
               -20391,
               ph_localization_pkg.localized_message('INVALID_PREFERENCE')
            );
         end if;
         l_value_type := 'STRING';
      elsif l_preference_code = 'DARK_MODE' then
         l_value :=
            case
               when lower(l_value) in ( '1',
                                        'true',
                                        'yes',
                                        'y' ) then
                  '1'
               else
                  '0'
            end;
         l_value_type := 'BOOLEAN';
      elsif l_preference_code = 'PAGE_SIZE' then
         if to_number ( l_value ) < 1 then
            raise_application_error(
               -20391,
               ph_localization_pkg.localized_message('INVALID_PREFERENCE')
            );
         end if;
         l_value_type := 'NUMBER';
      elsif l_preference_code = 'TIME_FORMAT' then
         l_value := upper(coalesce(
            l_value,
            '24H'
         ));
         if l_value not in ( '12H',
                             '24H' ) then
            raise_application_error(
               -20391,
               ph_localization_pkg.localized_message('INVALID_PREFERENCE')
            );
         end if;
         l_value_type := 'STRING';
      elsif l_preference_code = 'DENSITY' then
         l_value := upper(coalesce(
            l_value,
            'COMFORTABLE'
         ));
         if l_value not in ( 'COMPACT',
                             'COMFORTABLE',
                             'SPACIOUS' ) then
            raise_application_error(
               -20391,
               ph_localization_pkg.localized_message('INVALID_PREFERENCE')
            );
         end if;
         l_value_type := 'STRING';
      end if;

      merge into ph_sec_user_preferences target
      using (
         select l_user_id user_id,
                l_preference_code preference_code,
                l_value preference_value,
                l_value_type value_type
           from dual
      ) source on ( target.user_id = source.user_id
         and target.preference_code = source.preference_code )
      when matched then update
      set target.preference_value = source.preference_value,
          target.value_type = source.value_type,
          target.is_active = 1,
          target.is_deleted = 0,
          target.deleted_by = null,
          target.deleted_at = null,
          target.updated_by = p_updated_by,
          target.updated_at = systimestamp
      when not matched then
      insert (
         user_id,
         preference_code,
         preference_value,
         value_type,
         is_active,
         created_by )
      values
         ( source.user_id,
           source.preference_code,
           source.preference_value,
           source.value_type,
           1,
           nvl(
              p_updated_by,
              1
           ) );
   exception
      when value_error then
         raise_application_error(
            -20391,
            ph_localization_pkg.localized_message('INVALID_PREFERENCE')
         );
   end set_user_preference;
   function hash_password (
      p_password in t_password,
      p_salt     in varchar2
   ) return varchar2 is
      l_hash varchar2(128);
   begin
      if p_password is null
      or p_salt is null then
         return null;
      end if;
      select rawtohex(standard_hash(
         p_salt
         || ':'
         || p_password,
         'SHA512'
      ))
        into l_hash
        from dual;

      return l_hash;
   end hash_password;

   function verify_password (
      p_password      in t_password,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return boolean is
   begin
      return
         p_password_hash is not null
         and p_salt is not null
         and hash_password(
            p_password,
            p_salt
         ) = upper(p_password_hash);
   end verify_password;

   function is_user_active (
      p_username in t_username
   ) return boolean is
      l_count    number(10);
      l_username ph_sec_users.email%type := normalize_username(p_username);
   begin
      select count(*)
        into l_count
        from ph_sec_users
       where lower(email) = l_username
         and is_active = 1
         and is_deleted = 0;

      return l_count > 0;
   end is_user_active;

   function is_user_locked (
      p_username in t_username
   ) return boolean is
   begin
      return not is_user_active(p_username);
   end is_user_locked;

   function must_change_password (
      p_username in t_username
   ) return boolean is
      l_must_change ph_sec_users.must_change_password%type;
      l_username    ph_sec_users.email%type := normalize_username(p_username);
   begin
      select must_change_password
        into l_must_change
        from ph_sec_users
       where lower(email) = l_username
         and is_deleted = 0;

      return l_must_change = 1;
   exception
      when no_data_found then
         return false;
   end must_change_password;

   procedure register_failed_login (
      p_username in t_username
   ) is
   begin
      null;
   end register_failed_login;

   procedure register_success_login (
      p_username in t_username
   ) is
      l_username ph_sec_users.email%type := normalize_username(p_username);
   begin
      update ph_sec_users
         set
         last_login_at = systimestamp
       where lower(email) = l_username
         and is_deleted = 0;
   end register_success_login;

   procedure lock_user (
      p_username in t_username
   ) is
      l_username ph_sec_users.email%type := normalize_username(p_username);
   begin
      update ph_sec_users
         set
         is_active = 0
       where lower(email) = l_username
         and is_deleted = 0;
   end lock_user;

   procedure unlock_user (
      p_username in t_username
   ) is
      l_username ph_sec_users.email%type := normalize_username(p_username);
   begin
      update ph_sec_users
         set
         is_active = 1
       where lower(email) = l_username
         and is_deleted = 0;
   end unlock_user;

   procedure set_security_context (
      p_username in t_username
   ) is
      l_username ph_sec_users.email%type := normalize_username(p_username);
   begin
      select user_id,
             customer_id,
             email
        into
         g_user_id,
         g_org_id,
         g_username
        from ph_sec_users
       where lower(email) = l_username
         and is_active = 1
         and is_deleted = 0;

      dbms_session.set_identifier(g_username);
   exception
      when no_data_found then
         clear_security_context;
   end set_security_context;

   procedure clear_security_context is
   begin
      g_user_id := null;
      g_org_id := null;
      g_username := null;
      g_session_id := null;
      dbms_session.clear_identifier;
   end clear_security_context;

   function authenticate_user (
      p_username in t_username,
      p_password in t_password
   ) return boolean is
      l_password_hash ph_sec_users.password_hash%type;
      l_password_salt ph_sec_users.password_salt%type;
      l_is_valid      boolean;
      l_username      ph_sec_users.email%type := normalize_username(p_username);
   begin
      if p_username is null
      or p_password is null then
         return false;
      end if;
      select password_hash,
             password_salt
        into
         l_password_hash,
         l_password_salt
        from ph_sec_users
       where lower(email) = l_username
         and is_active = 1
         and is_deleted = 0;

      l_is_valid := verify_password(
         p_password      => p_password,
         p_password_hash => rawtohex(l_password_hash),
         p_salt          => rawtohex(l_password_salt)
      );

      if l_is_valid then
         register_success_login(p_username);
         set_security_context(p_username);
         return true;
      end if;

      register_failed_login(p_username);
      return false;
   exception
      when no_data_found then
         register_failed_login(p_username);
         return false;
   end authenticate_user;

   procedure create_user_session (
      p_username   in t_username,
      p_session_id in varchar2
   ) is
   begin
      g_session_id := p_session_id;
      set_security_context(p_username);
   end create_user_session;

   procedure close_user_session (
      p_username   in t_username,
      p_session_id in varchar2
   ) is
   begin
      if
         normalize_username(p_username) = normalize_username(g_username)
         and ( p_session_id is null
         or p_session_id = g_session_id )
      then
         clear_security_context;
      end if;
   end close_user_session;

   function is_valid_session (
      p_username   in t_username,
      p_session_id in varchar2
   ) return boolean is
   begin
      return
         is_user_active(p_username)
         and normalize_username(p_username) = normalize_username(g_username)
         and ( g_session_id is null
         or p_session_id is null
         or g_session_id = p_session_id );
   end is_valid_session;

   function has_role (
      p_username  in t_username,
      p_role_code in varchar2
   ) return boolean is
      l_count    number(10);
      l_username ph_sec_users.email%type := normalize_username(p_username);
   begin
      select count(*)
        into l_count
        from ph_sec_users u
        join ph_sec_user_roles ur
      on ur.user_id = u.user_id
        join ph_sec_roles r
      on r.role_id = ur.role_id
       where lower(u.email) = l_username
         and u.is_active = 1
         and u.is_deleted = 0
         and ur.is_deleted = 0
         and r.is_active = 1
         and r.is_deleted = 0
         and ( to_char(r.role_id) = trim(p_role_code)
          or upper(r.role_name_en) = upper(trim(p_role_code)) );

      return l_count > 0;
   end has_role;

   function has_permission (
      p_username        in t_username,
      p_permission_code in varchar2
   ) return boolean is
      l_count    number(10);
      l_username ph_sec_users.email%type := normalize_username(p_username);
   begin
      select count(*)
        into l_count
        from vw_ph_sec_user_permissions
       where lower(email) = l_username
         and ( to_char(permission_id) = trim(p_permission_code)
          or upper(permission_name_en) = upper(trim(p_permission_code))
          or upper(object_name
                   || ':' || action_name) = upper(trim(p_permission_code)) );

      return l_count > 0;
   end has_permission;

   function has_page_access (
      p_username in t_username,
      p_app_id   in number,
      p_page_id  in number
   ) return boolean is
      l_count    number(10);
      l_username ph_sec_users.email%type := normalize_username(p_username);
   begin
      if p_app_id is null
      or p_page_id is null then
         return false;
      end if;
      select count(*)
        into l_count
        from ph_sec_apex_pages pg
       where pg.apex_app_id = p_app_id
         and pg.apex_page_no = p_page_id
         and pg.is_active = 1
         and pg.is_deleted = 0
         and ( pg.is_public = 1
          or ( pg.access_mode = 'ANY'
         and exists (
         select 1
           from ph_sec_apex_page_permissions pp
           join vw_ph_sec_user_permissions up
         on up.permission_id = pp.permission_id
          where pp.apex_page_id = pg.apex_page_id
            and pp.is_active = 1
            and pp.is_deleted = 0
            and pp.is_an_access_permission = 1
            and lower(up.email) = l_username
      ) )
          or ( pg.access_mode = 'ALL'
         and exists (
         select 1
           from ph_sec_apex_page_permissions pp
          where pp.apex_page_id = pg.apex_page_id
            and pp.is_active = 1
            and pp.is_deleted = 0
            and pp.is_an_access_permission = 1
      )
         and not exists (
         select 1
           from ph_sec_apex_page_permissions pp
          where pp.apex_page_id = pg.apex_page_id
            and pp.is_active = 1
            and pp.is_deleted = 0
            and pp.is_an_access_permission = 1
            and not exists (
            select 1
              from vw_ph_sec_user_permissions up
             where up.permission_id = pp.permission_id
               and lower(up.email) = l_username
         )
      ) ) );

      return l_count > 0;
   end has_page_access;


   procedure set_password (
      p_user_id    in number,
      p_password   in t_password,
      p_updated_by in number default null
   ) is
      l_salt varchar2(32);
      l_hash varchar2(128);
   begin
      if p_password is null
      or length(p_password) < 8 then
         raise_application_error(
            -20301,
            ph_localization_pkg.localized_message('PASSWORD_MIN_LENGTH')
         );
      end if;

      l_salt := rawtohex(sys_guid());
      l_hash := hash_password(
         p_password,
         l_salt
      );
      update ph_sec_users
         set password_salt = hextoraw(l_salt),
             password_hash = hextoraw(l_hash),
             must_change_password = 0,
             updated_by = p_updated_by,
             updated_at = systimestamp
       where user_id = p_user_id
         and is_deleted = 0;

      if sql%rowcount = 0 then
         raise_application_error(
            -20302,
            ph_localization_pkg.localized_message('USER_NOT_FOUND')
         );
      end if;
   end set_password;

   function get_user_id return number is
   begin
      return g_user_id;
   end get_user_id;

   function get_org_id return number is
   begin
      return g_org_id;
   end get_org_id;

   function get_username return varchar2 is
   begin
      return g_username;
   end get_username;
end ph_sec_authentication_pkg;
/