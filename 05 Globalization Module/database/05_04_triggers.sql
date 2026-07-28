/*
ProductHub Manager - Oracle Triggers
*/

CREATE OR REPLACE TRIGGER trg_ph_languages_required_bu
BEFORE UPDATE OR DELETE ON ph_languages
FOR EACH ROW
BEGIN
    IF :OLD.language_code IN ('en', 'ar') THEN
        IF DELETING THEN
            RAISE_APPLICATION_ERROR(-20070, 'English and Arabic are required base languages and cannot be removed or deactivated.');
        END IF;

        IF :NEW.is_active = 0 THEN
            RAISE_APPLICATION_ERROR(-20070, 'English and Arabic are required base languages and cannot be removed or deactivated.');
        END IF;
    END IF;
END;
/

------------------------------------------------------------
-- Standard audit triggers
------------------------------------------------------------

CREATE OR REPLACE TRIGGER trg_aud_ph_languages
BEFORE INSERT OR UPDATE ON ph_languages
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

CREATE OR REPLACE TRIGGER trg_aud_ph_i18n_texts
BEFORE INSERT OR UPDATE ON ph_i18n_texts
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

CREATE OR REPLACE TRIGGER trg_aud_ph_i18n_messages
BEFORE INSERT OR UPDATE ON ph_i18n_messages
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

CREATE OR REPLACE TRIGGER trg_aud_ph_lookup_types
BEFORE INSERT OR UPDATE ON ph_lookup_types
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

CREATE OR REPLACE TRIGGER trg_aud_ph_lookup_values
BEFORE INSERT OR UPDATE ON ph_lookup_values
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

