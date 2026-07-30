/*
ProductHub Manager - Oracle Triggers
*/


CREATE OR REPLACE TRIGGER trg_aud_ph_lookup_types
BEFORE INSERT OR UPDATE ON ph_lookup_types
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.is_deleted := NVL(:NEW.is_deleted, 0);
        :NEW.created_by := NVL(:NEW.created_by, 1);
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by));
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
        :NEW.created_by := NVL(:NEW.created_by, 1);
        :NEW.created_at := SYSTIMESTAMP;
    ELSIF NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1 THEN
        :NEW.deleted_by := NVL(:NEW.deleted_by, NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by)));
        :NEW.deleted_at := SYSTIMESTAMP;
    ELSE
        :NEW.updated_by := NVL(:NEW.updated_by, NVL(:OLD.updated_by, :OLD.created_by));
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

