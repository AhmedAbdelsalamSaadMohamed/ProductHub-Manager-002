/*
ProductHub Manager - Security Module Comments
Target DBMS: Oracle Database 21c+
*/

COMMENT ON TABLE ph_sec_user_type_lkp IS q'[user type lkp Table | جدول user type lkp]';

COMMENT ON COLUMN ph_sec_user_type_lkp.user_type_id IS q'[user type id Identifier | معرف user type id]';

COMMENT ON COLUMN ph_sec_user_type_lkp.user_type_name_en IS q'[user type name en English Value | قيمة user type name en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_user_type_lkp.user_type_name_ar IS q'[user type name ar Arabic Value | قيمة user type name ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_user_type_lkp.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_object_type_lkp IS q'[object type lkp Table | جدول object type lkp]';

COMMENT ON COLUMN ph_sec_object_type_lkp.object_type_id IS q'[object type id Identifier | معرف object type id]';

COMMENT ON COLUMN ph_sec_object_type_lkp.object_type_name_en IS q'[object type name en English Value | قيمة object type name en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_object_type_lkp.object_type_name_ar IS q'[object type name ar Arabic Value | قيمة object type name ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_object_type_lkp.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_objects IS q'[objects Table | جدول الكائنات المؤمنة]';

COMMENT ON COLUMN ph_sec_objects.object_id IS q'[object id Identifier | معرف object id]';

COMMENT ON COLUMN ph_sec_objects.parent_object_id IS q'[parent object id Identifier | معرف parent object id]';

COMMENT ON COLUMN ph_sec_objects.object_name IS q'[object name | object name]';

COMMENT ON COLUMN ph_sec_objects.object_type_id IS q'[object type id Identifier | معرف object type id]';

COMMENT ON COLUMN ph_sec_objects.object_path IS q'[object path | object path]';

COMMENT ON COLUMN ph_sec_objects.display_name_en IS q'[display name en English Value | قيمة display name en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_objects.display_name_ar IS q'[display name ar Arabic Value | قيمة display name ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_objects.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_objects.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_objects.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_actions IS q'[actions Table | جدول actions]';

COMMENT ON COLUMN ph_sec_actions.action_id IS q'[action id Identifier | معرف action id]';

COMMENT ON COLUMN ph_sec_actions.action_name IS q'[action name | action name]';

COMMENT ON COLUMN ph_sec_actions.display_name_en IS q'[display name en English Value | قيمة display name en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_actions.display_name_ar IS q'[display name ar Arabic Value | قيمة display name ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_actions.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_actions.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_actions.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_permissions IS q'[permissions Table | جدول الصلاحيات]';

COMMENT ON COLUMN ph_sec_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';

COMMENT ON COLUMN ph_sec_permissions.object_id IS q'[object id Identifier | معرف object id]';

COMMENT ON COLUMN ph_sec_permissions.action_id IS q'[action id Identifier | معرف action id]';

COMMENT ON COLUMN ph_sec_permissions.permission_name_en IS q'[permission name en English Value | قيمة permission name en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_permissions.permission_name_ar IS q'[permission name ar Arabic Value | قيمة permission name ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_permissions.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_permissions.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_permissions.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_apex_page_type_lkp IS q'[apex page type lkp Table | جدول apex page type lkp]';

COMMENT ON COLUMN ph_sec_apex_page_type_lkp.apex_page_type_id IS q'[apex page type id Identifier | معرف apex page type id]';

COMMENT ON COLUMN ph_sec_apex_page_type_lkp.apex_page_type_code IS q'[apex page type code | apex page type code]';

COMMENT ON COLUMN ph_sec_apex_page_type_lkp.apex_page_type_name_en IS q'[apex page type name en English Value | قيمة apex page type name en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_apex_page_type_lkp.apex_page_type_name_ar IS q'[apex page type name ar Arabic Value | قيمة apex page type name ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_apex_page_type_lkp.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON TABLE ph_sec_users IS q'[users Table | جدول المستخدمين]';

COMMENT ON COLUMN ph_sec_users.user_id IS q'[User Identifier | معرف المستخدم]';

COMMENT ON COLUMN ph_sec_users.customer_id IS q'[customer id Identifier | معرف customer id]';

COMMENT ON COLUMN ph_sec_users.user_type IS q'[user type | user type]';

COMMENT ON COLUMN ph_sec_users.email IS q'[Email Address | البريد الإلكتروني]';

COMMENT ON COLUMN ph_sec_users.display_name IS q'[Display Name | الاسم المعروض]';

COMMENT ON COLUMN ph_sec_users.password_hash IS q'[password hash | password hash]';

COMMENT ON COLUMN ph_sec_users.password_salt IS q'[password salt | password salt]';

COMMENT ON COLUMN ph_sec_users.must_change_password IS q'[must change password | must change password]';

COMMENT ON COLUMN ph_sec_users.is_initial_admin IS q'[is initial admin Flag | مؤشر is initial admin]';

COMMENT ON COLUMN ph_sec_users.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_sec_users.last_login_at IS q'[last login at Timestamp | وقت last login at]';

COMMENT ON COLUMN ph_sec_users.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_sec_users.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_sec_users.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_sec_users.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_user_preferences IS q'[User preferences such as language, theme, density, timezone, and page size | تفضيلات المستخدم مثل اللغة والمظهر والكثافة والمنطقة الزمنية وحجم الصفحة]';

COMMENT ON COLUMN ph_sec_user_preferences.user_id IS q'[User Identifier | معرف المستخدم]';

COMMENT ON COLUMN ph_sec_user_preferences.preference_code IS q'[Preference Code | رمز التفضيل]';

COMMENT ON COLUMN ph_sec_user_preferences.preference_value IS q'[Preference Value | قيمة التفضيل]';

COMMENT ON COLUMN ph_sec_user_preferences.value_type IS q'[Preference Value Type | نوع قيمة التفضيل]';

COMMENT ON COLUMN ph_sec_user_preferences.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_sec_user_preferences.created_by IS q'[Created By User Identifier | معرف مستخدم الإنشاء]';

COMMENT ON COLUMN ph_sec_user_preferences.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_sec_user_preferences.updated_by IS q'[Updated By User Identifier | معرف مستخدم التحديث]';

COMMENT ON COLUMN ph_sec_user_preferences.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_refresh_tokens IS q'[Refresh tokens for JWT authentication. Only the SHA-256 hash of the opaque refresh token is stored.]';

COMMENT ON COLUMN ph_sec_refresh_tokens.refresh_token_id IS q'[Refresh token identifier.]';

COMMENT ON COLUMN ph_sec_refresh_tokens.user_id IS q'[User that owns the refresh token.]';

COMMENT ON COLUMN ph_sec_refresh_tokens.token_hash IS q'[SHA-256 hash of the opaque refresh token. The plain token is returned only once.]';

COMMENT ON COLUMN ph_sec_refresh_tokens.issued_at IS q'[Refresh token issue timestamp.]';

COMMENT ON COLUMN ph_sec_refresh_tokens.expires_at IS q'[Refresh token expiry timestamp.]';

COMMENT ON COLUMN ph_sec_refresh_tokens.revoked_at IS q'[Timestamp when the refresh token was revoked.]';

COMMENT ON COLUMN ph_sec_refresh_tokens.replaced_by_token_id IS q'[New refresh token created when this token was rotated.]';

COMMENT ON TABLE ph_sec_password_reset_tokens IS q'[Password reset tokens. Only the SHA-256 hash of the opaque reset token is stored.]';

COMMENT ON COLUMN ph_sec_password_reset_tokens.reset_token_id IS q'[Password reset token identifier.]';

COMMENT ON COLUMN ph_sec_password_reset_tokens.user_id IS q'[User that owns the password reset token.]';

COMMENT ON COLUMN ph_sec_password_reset_tokens.token_hash IS q'[SHA-256 hash of the opaque password reset token. The plain token is returned only once.]';

COMMENT ON COLUMN ph_sec_password_reset_tokens.issued_at IS q'[Password reset token issue timestamp.]';

COMMENT ON COLUMN ph_sec_password_reset_tokens.expires_at IS q'[Password reset token expiry timestamp.]';

COMMENT ON COLUMN ph_sec_password_reset_tokens.used_at IS q'[Timestamp when the password reset token was consumed.]';

COMMENT ON TABLE ph_sec_apex_pages IS q'[apex pages Table | جدول صفحات APEX]';

COMMENT ON COLUMN ph_sec_apex_pages.apex_page_id IS q'[apex page id Identifier | معرف apex page id]';

COMMENT ON COLUMN ph_sec_apex_pages.apex_app_id IS q'[apex app id Identifier | معرف apex app id]';

COMMENT ON COLUMN ph_sec_apex_pages.apex_page_no IS q'[apex page no | apex page no]';

COMMENT ON COLUMN ph_sec_apex_pages.apex_page_type_id IS q'[apex page type id Identifier | معرف apex page type id]';

COMMENT ON COLUMN ph_sec_apex_pages.page_alias IS q'[page alias | page alias]';

COMMENT ON COLUMN ph_sec_apex_pages.page_name_en IS q'[page name en English Value | قيمة page name en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_apex_pages.page_name_ar IS q'[page name ar Arabic Value | قيمة page name ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_apex_pages.object_path IS q'[object path | object path]';

COMMENT ON COLUMN ph_sec_apex_pages.access_mode IS q'[access mode | access mode]';

COMMENT ON COLUMN ph_sec_apex_pages.is_public IS q'[is public Flag | مؤشر is public]';

COMMENT ON COLUMN ph_sec_apex_pages.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_sec_apex_pages.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_sec_apex_pages.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_sec_apex_pages.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_sec_apex_pages.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_apex_page_permissions IS q'[apex page permissions Table | جدول apex page permissions]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.apex_page_id IS q'[apex page id Identifier | معرف apex page id]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.is_an_access_permission IS q'[is an access permission Flag | مؤشر is an access permission]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_roles IS q'[roles Table | جدول الأدوار]';

COMMENT ON COLUMN ph_sec_roles.role_id IS q'[role id Identifier | معرف role id]';

COMMENT ON COLUMN ph_sec_roles.role_name_en IS q'[role name en English Value | قيمة role name en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_roles.role_name_ar IS q'[role name ar Arabic Value | قيمة role name ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_roles.description_en IS q'[description en English Value | قيمة description en باللغة الإنجليزية]';

COMMENT ON COLUMN ph_sec_roles.description_ar IS q'[description ar Arabic Value | قيمة description ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_roles.user_type IS q'[user type | user type]';

COMMENT ON COLUMN ph_sec_roles.is_system_role IS q'[is system role Flag | مؤشر is system role]';

COMMENT ON COLUMN ph_sec_roles.is_active IS q'[Active Flag | مؤشر التفعيل]';

COMMENT ON COLUMN ph_sec_roles.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_sec_roles.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON COLUMN ph_sec_roles.updated_by IS q'[updated by User Identifier | معرف مستخدم updated by]';

COMMENT ON COLUMN ph_sec_roles.updated_at IS q'[Update Timestamp | وقت التحديث]';

COMMENT ON TABLE ph_sec_role_permissions IS q'[role permissions Table | جدول role permissions]';

COMMENT ON COLUMN ph_sec_role_permissions.role_id IS q'[role id Identifier | معرف role id]';

COMMENT ON COLUMN ph_sec_role_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';

COMMENT ON COLUMN ph_sec_role_permissions.created_by IS q'[created by User Identifier | معرف مستخدم created by]';

COMMENT ON COLUMN ph_sec_role_permissions.created_at IS q'[Creation Timestamp | وقت الإنشاء]';

COMMENT ON TABLE ph_sec_user_roles IS q'[user roles Table | جدول user roles]';

COMMENT ON COLUMN ph_sec_user_roles.user_id IS q'[User Identifier | معرف المستخدم]';

COMMENT ON COLUMN ph_sec_user_roles.role_id IS q'[role id Identifier | معرف role id]';

COMMENT ON COLUMN ph_sec_user_roles.assigned_by IS q'[assigned by User Identifier | معرف مستخدم assigned by]';

COMMENT ON COLUMN ph_sec_user_roles.assigned_at IS q'[assigned at Timestamp | وقت assigned at]';

COMMENT ON TABLE vw_ph_sec_page_permissions IS q'[ph sec page permissions View | عرض ph sec page permissions]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_id IS q'[apex page id Identifier | معرف apex page id]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_app_id IS q'[apex app id Identifier | معرف apex app id]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_no IS q'[apex page no | apex page no]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_type_id IS q'[apex page type id Identifier | معرف apex page type id]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_type_code IS q'[apex page type code | apex page type code]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_type_name_en IS q'[apex page type name en English Value | قيمة apex page type name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.apex_page_type_name_ar IS q'[apex page type name ar Arabic Value | قيمة apex page type name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.page_alias IS q'[page alias | page alias]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.page_name_en IS q'[page name en English Value | قيمة page name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.page_name_ar IS q'[page name ar Arabic Value | قيمة page name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.page_object_path IS q'[page object path | page object path]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.access_mode IS q'[access mode | access mode]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.is_public IS q'[is public Flag | مؤشر is public]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.page_is_active IS q'[page is active | page is active]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.is_an_access_permission IS q'[is an access permission Flag | مؤشر is an access permission]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.page_permission_is_active IS q'[page permission is active | page permission is active]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.permission_name_en IS q'[permission name en English Value | قيمة permission name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.permission_name_ar IS q'[permission name ar Arabic Value | قيمة permission name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.object_id IS q'[object id Identifier | معرف object id]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.object_name IS q'[object name | object name]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.object_path IS q'[object path | object path]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.action_id IS q'[action id Identifier | معرف action id]';

COMMENT ON COLUMN vw_ph_sec_page_permissions.action_name IS q'[action name | action name]';

COMMENT ON TABLE vw_ph_sec_user_page_access IS q'[ph sec user page access View | عرض ph sec user page access]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.user_id IS q'[User Identifier | معرف المستخدم]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.email IS q'[Email Address | البريد الإلكتروني]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.username IS q'[username | username]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.display_name IS q'[Display Name | الاسم المعروض]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.user_type IS q'[user type | user type]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.customer_id IS q'[customer id Identifier | معرف customer id]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_id IS q'[apex page id Identifier | معرف apex page id]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_app_id IS q'[apex app id Identifier | معرف apex app id]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_no IS q'[apex page no | apex page no]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_type_id IS q'[apex page type id Identifier | معرف apex page type id]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_type_code IS q'[apex page type code | apex page type code]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_type_name_en IS q'[apex page type name en English Value | قيمة apex page type name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.apex_page_type_name_ar IS q'[apex page type name ar Arabic Value | قيمة apex page type name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.page_alias IS q'[page alias | page alias]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.page_name_en IS q'[page name en English Value | قيمة page name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.page_name_ar IS q'[page name ar Arabic Value | قيمة page name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.page_object_path IS q'[page object path | page object path]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.access_mode IS q'[access mode | access mode]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.is_public IS q'[is public Flag | مؤشر is public]';

COMMENT ON COLUMN vw_ph_sec_user_page_access.has_access IS q'[has access | has access]';

COMMENT ON TABLE vw_ph_sec_user_permissions IS q'[ph sec user permissions View | عرض ph sec user permissions]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.user_id IS q'[User Identifier | معرف المستخدم]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.email IS q'[Email Address | البريد الإلكتروني]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.display_name IS q'[Display Name | الاسم المعروض]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.user_type IS q'[user type | user type]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.customer_id IS q'[customer id Identifier | معرف customer id]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.role_id IS q'[role id Identifier | معرف role id]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.role_name_en IS q'[role name en English Value | قيمة role name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.role_name_ar IS q'[role name ar Arabic Value | قيمة role name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.permission_id IS q'[permission id Identifier | معرف permission id]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.permission_name_en IS q'[permission name en English Value | قيمة permission name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.permission_name_ar IS q'[permission name ar Arabic Value | قيمة permission name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.object_id IS q'[object id Identifier | معرف object id]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.object_name IS q'[object name | object name]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.object_type_id IS q'[object type id Identifier | معرف object type id]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.object_type_name_en IS q'[object type name en English Value | قيمة object type name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.object_type_name_ar IS q'[object type name ar Arabic Value | قيمة object type name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.object_path IS q'[object path | object path]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.object_display_name_en IS q'[object display name en English Value | قيمة object display name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.object_display_name_ar IS q'[object display name ar Arabic Value | قيمة object display name ar باللغة العربية]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.action_id IS q'[action id Identifier | معرف action id]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.action_name IS q'[action name | action name]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.action_display_name_en IS q'[action display name en English Value | قيمة action display name en باللغة الإنجليزية]';

COMMENT ON COLUMN vw_ph_sec_user_permissions.action_display_name_ar IS q'[action display name ar Arabic Value | قيمة action display name ar باللغة العربية]';

COMMENT ON COLUMN ph_sec_user_type_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_user_type_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_user_type_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_object_type_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_object_type_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_object_type_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_objects.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_objects.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_objects.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_actions.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_actions.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_actions.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_permissions.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_permissions.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_permissions.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_apex_page_type_lkp.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_apex_page_type_lkp.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_apex_page_type_lkp.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_users.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_users.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_users.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_user_preferences.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_user_preferences.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_user_preferences.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_apex_pages.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_apex_pages.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_apex_pages.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_apex_page_permissions.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_roles.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_roles.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_roles.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_role_permissions.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_role_permissions.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_role_permissions.deleted_at IS q'[Timestamp when the row was soft-deleted.]';

COMMENT ON COLUMN ph_sec_user_roles.is_deleted IS q'[Soft delete flag. 0 means visible/available; 1 means deleted and excluded from normal GET/query APIs.]';

COMMENT ON COLUMN ph_sec_user_roles.deleted_by IS q'[User identifier that soft-deleted the row.]';

COMMENT ON COLUMN ph_sec_user_roles.deleted_at IS q'[Timestamp when the row was soft-deleted.]';
COMMENT ON TABLE ph_sec_error_log IS 'Security module runtime error log captured from package exception handlers.';
COMMENT ON COLUMN ph_sec_error_log.program_unit IS 'PL/SQL package, procedure, function, or runtime unit where the error was handled.';
COMMENT ON COLUMN ph_sec_error_log.program_unit_parameters IS 'Serialized parameter values supplied by the caller when available.';
COMMENT ON COLUMN ph_sec_error_log.error_location IS 'Formatted PL/SQL error backtrace or other location hint.';
COMMENT ON COLUMN ph_sec_error_log.error_stack IS 'Formatted Oracle error stack.';
COMMENT ON COLUMN ph_sec_error_log.error_backtrace IS 'Formatted Oracle error backtrace.';
COMMENT ON COLUMN ph_sec_error_log.call_stack IS 'Formatted PL/SQL call stack at logging time.';
