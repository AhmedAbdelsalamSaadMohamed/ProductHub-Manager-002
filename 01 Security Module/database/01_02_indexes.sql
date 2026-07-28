/*
ProductHub Manager - Security Module Indexes
Target DBMS: Oracle Database 21c+
*/

CREATE INDEX ix_ph_sec_user_type_active
    ON ph_sec_user_type_lkp ( is_deleted, is_active, user_type_name_en, user_type_id );

CREATE INDEX ix_ph_sec_users_lower_email
    ON ph_sec_users ( is_deleted, LOWER(email) );

CREATE INDEX ix_ph_sec_users_customer
    ON ph_sec_users ( customer_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_users_type
    ON ph_sec_users ( user_type, is_deleted, is_active );

CREATE INDEX ix_ph_sec_user_pref_code
    ON ph_sec_user_preferences ( preference_code, is_deleted, is_active );

CREATE INDEX ix_ph_sec_rt_user_active
    ON ph_sec_refresh_tokens ( user_id, revoked_at, expires_at );

CREATE INDEX ix_ph_sec_rt_expiry
    ON ph_sec_refresh_tokens ( expires_at, revoked_at );

CREATE INDEX ix_ph_sec_prt_user_active
    ON ph_sec_password_reset_tokens ( user_id, used_at, expires_at );

CREATE INDEX ix_ph_sec_prt_expiry
    ON ph_sec_password_reset_tokens ( expires_at, used_at );

CREATE INDEX ix_ph_sec_obj_type_active
    ON ph_sec_object_type_lkp ( is_deleted, is_active, object_type_name_en, object_type_id );

CREATE INDEX ix_ph_sec_objects_parent
    ON ph_sec_objects ( parent_object_id, is_deleted, is_active, object_id );

CREATE INDEX ix_ph_sec_permissions_object
    ON ph_sec_permissions ( object_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_permissions_action
    ON ph_sec_permissions ( action_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_objects_type
    ON ph_sec_objects ( object_type_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_roles_type
    ON ph_sec_roles ( user_type, is_deleted, is_active, role_name_en, role_id );

CREATE INDEX ix_ph_sec_roles_active_name
    ON ph_sec_roles ( is_deleted, is_active, role_name_en, role_id );

CREATE INDEX ix_ph_sec_actions_active_name
    ON ph_sec_actions ( is_deleted, is_active, action_name, action_id );

CREATE INDEX ix_ph_sec_perm_active_name
    ON ph_sec_permissions ( is_deleted, is_active, permission_name_en, permission_id );

CREATE INDEX ix_ph_sec_apex_ptype_active
    ON ph_sec_apex_page_type_lkp ( is_deleted, is_active, apex_page_type_code, apex_page_type_id );

CREATE INDEX ix_ph_sec_apex_pages_lookup
    ON ph_sec_apex_pages ( apex_app_id, apex_page_no, is_deleted, is_active, is_public );

CREATE INDEX ix_ph_sec_apex_pages_type
    ON ph_sec_apex_pages ( apex_page_type_id, is_deleted, is_active );

CREATE INDEX ix_ph_sec_apex_pages_public
    ON ph_sec_apex_pages ( apex_app_id, is_deleted, is_active, is_public, access_mode, apex_page_id );

CREATE INDEX ix_ph_sec_apex_pages_object
    ON ph_sec_apex_pages ( object_path, is_deleted, is_active, apex_page_id );

CREATE INDEX ix_ph_sec_app_perm_page
    ON ph_sec_apex_page_permissions ( apex_page_id, is_deleted, is_active, is_an_access_permission, permission_id );

CREATE INDEX ix_ph_sec_apex_page_perm_perm
    ON ph_sec_apex_page_permissions ( permission_id, is_deleted, is_active, is_an_access_permission );

CREATE INDEX ix_ph_sec_rp_permission
    ON ph_sec_role_permissions ( is_deleted, permission_id, role_id );

CREATE INDEX ix_ph_sec_ur_role
    ON ph_sec_user_roles ( is_deleted, role_id, user_id );
