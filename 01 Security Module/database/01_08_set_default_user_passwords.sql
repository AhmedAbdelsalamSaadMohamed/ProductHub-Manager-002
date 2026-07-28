/*
ProductHub Manager - Set default password for all users

Purpose:
- Sets every PH_SEC_USERS password to ChangeMe123!.
- Forces users to change password on next login.
*/

SET DEFINE OFF

DECLARE
    c_default_password CONSTANT VARCHAR2(4000) := 'ChangeMe123!';
    l_count            NUMBER := 0;
BEGIN
    FOR r IN (
        SELECT user_id
        FROM ph_sec_users
        WHERE is_deleted = 0
        ORDER BY user_id
    ) LOOP
        ph_sec_authentication_pkg.set_password(r.user_id, c_default_password, NULL);

        UPDATE ph_sec_users
            SET must_change_password = 1,
                updated_by = NULL,
                updated_at = SYSTIMESTAMP
            WHERE user_id = r.user_id
                AND is_deleted = 0;

        l_count := l_count + 1;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Default password ChangeMe123! set for ' || l_count || ' users.');
END;
/
