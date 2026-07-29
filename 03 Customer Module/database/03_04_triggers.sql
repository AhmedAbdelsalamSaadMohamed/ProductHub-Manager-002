/*
ProductHub Manager - Customer Module Triggers
Target DBMS: Oracle Database 21c+
*/

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_customers
BEFORE INSERT OR UPDATE ON ph_erp_customers
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
