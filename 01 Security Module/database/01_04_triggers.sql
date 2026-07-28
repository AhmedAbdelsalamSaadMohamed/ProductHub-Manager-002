/*
ProductHub Manager - Security Module Triggers
Target DBMS: Oracle Database 21c+
*/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_user_type
BEFORE INSERT OR UPDATE ON ph_sec_user_type_lkp
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_obj_type
BEFORE INSERT OR UPDATE ON ph_sec_object_type_lkp
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_objects
BEFORE INSERT OR UPDATE ON ph_sec_objects
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_actions
BEFORE INSERT OR UPDATE ON ph_sec_actions
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_perms
BEFORE INSERT OR UPDATE ON ph_sec_permissions
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_apex_ptype
BEFORE INSERT OR UPDATE ON ph_sec_apex_page_type_lkp
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_users
BEFORE INSERT OR UPDATE ON ph_sec_users
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_user_pref
BEFORE INSERT OR UPDATE ON ph_sec_user_preferences
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_refresh_tokens
BEFORE INSERT OR UPDATE ON ph_sec_refresh_tokens
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_pwd_reset_tokens
BEFORE INSERT OR UPDATE ON ph_sec_password_reset_tokens
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_apex_pages
BEFORE INSERT OR UPDATE ON ph_sec_apex_pages
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_app_perms
BEFORE INSERT OR UPDATE ON ph_sec_apex_page_permissions
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_roles
BEFORE INSERT OR UPDATE ON ph_sec_roles
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_role_perms
BEFORE INSERT OR UPDATE ON ph_sec_role_permissions
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aud_ph_sec_user_roles
BEFORE INSERT OR UPDATE ON ph_sec_user_roles
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by))));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/
