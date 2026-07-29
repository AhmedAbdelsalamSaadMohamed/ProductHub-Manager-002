/*
ProductHub Manager - Product Module Triggers
Target DBMS: Oracle Database 21c+
*/

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_price_unit
BEFORE INSERT OR UPDATE ON ph_erp_pricing_unit_lkp
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_pay_cycle
BEFORE INSERT OR UPDATE ON ph_erp_payment_cycle_lkp
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_platform
BEFORE INSERT OR UPDATE ON ph_erp_platform_lkp
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_products
BEFORE INSERT OR UPDATE ON ph_erp_products
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_prod_mod_seq
BEFORE INSERT OR UPDATE ON ph_erp_product_module_seq
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_modules
BEFORE INSERT OR UPDATE ON ph_erp_modules
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_mod_plat
BEFORE INSERT OR UPDATE ON ph_erp_module_platforms
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_mod_feat_seq
BEFORE INSERT OR UPDATE ON ph_erp_module_feature_seq
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_features
BEFORE INSERT OR UPDATE ON ph_erp_features
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

CREATE OR REPLACE TRIGGER trg_ph_erp_products_ai
AFTER INSERT ON ph_erp_products
FOR EACH ROW
BEGIN
    INSERT INTO ph_erp_product_module_seq (
        product_id,
        next_module_id,
        created_by
    ) VALUES (
        :NEW.product_id,
        1,
        :NEW.created_by
    );
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_modules_bi
BEFORE INSERT ON ph_erp_modules
FOR EACH ROW
DECLARE
    v_next_module_id NUMBER(19);
BEGIN
    :NEW.created_by := NVL(:NEW.created_by, 1);
    :NEW.created_at := SYSTIMESTAMP;

    IF :NEW.module_id IS NULL THEN
        UPDATE ph_erp_product_module_seq
           SET next_module_id = next_module_id + 1
         WHERE product_id = :NEW.product_id
        RETURNING next_module_id - 1 INTO v_next_module_id;

        IF SQL%ROWCOUNT = 0 THEN
            BEGIN
                INSERT INTO ph_erp_product_module_seq (
                    product_id,
                    next_module_id,
                    created_by
                ) VALUES (
                    :NEW.product_id,
                    2,
                    :NEW.created_by
                );

                v_next_module_id := 1;
            EXCEPTION
                WHEN dup_val_on_index THEN
                    UPDATE ph_erp_product_module_seq
                       SET next_module_id = next_module_id + 1
                     WHERE product_id = :NEW.product_id
                    RETURNING next_module_id - 1 INTO v_next_module_id;
            END;
        END IF;

        :NEW.module_id := v_next_module_id;
    ELSE
        UPDATE ph_erp_product_module_seq
           SET next_module_id = GREATEST(next_module_id, :NEW.module_id + 1)
         WHERE product_id = :NEW.product_id;

        IF SQL%ROWCOUNT = 0 THEN
            BEGIN
                INSERT INTO ph_erp_product_module_seq (
                    product_id,
                    next_module_id,
                    created_by
                ) VALUES (
                    :NEW.product_id,
                    :NEW.module_id + 1,
                    :NEW.created_by
                );
            EXCEPTION
                WHEN dup_val_on_index THEN
                    UPDATE ph_erp_product_module_seq
                       SET next_module_id = GREATEST(next_module_id, :NEW.module_id + 1)
                     WHERE product_id = :NEW.product_id;
            END;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_module_platforms_ai
AFTER INSERT ON ph_erp_module_platforms
FOR EACH ROW
BEGIN
    INSERT INTO ph_erp_module_feature_seq (
        product_id,
        module_id,
        platform_id,
        next_feature_id,
        created_by
    ) VALUES (
        :NEW.product_id,
        :NEW.module_id,
        :NEW.platform_id,
        1,
        :NEW.created_by
    );
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_features_bi
BEFORE INSERT ON ph_erp_features
FOR EACH ROW
DECLARE
    v_next_feature_id NUMBER(19);
BEGIN
    :NEW.created_by := NVL(:NEW.created_by, 1);
    :NEW.created_at := SYSTIMESTAMP;

    IF :NEW.feature_id IS NULL THEN
        UPDATE ph_erp_module_feature_seq
           SET next_feature_id = next_feature_id + 1
         WHERE product_id = :NEW.product_id
           AND module_id = :NEW.module_id
           AND platform_id = :NEW.platform_id
        RETURNING next_feature_id - 1 INTO v_next_feature_id;

        IF SQL%ROWCOUNT = 0 THEN
            BEGIN
                INSERT INTO ph_erp_module_feature_seq (
                    product_id,
                    module_id,
                    platform_id,
                    next_feature_id,
                    created_by
                ) VALUES (
                    :NEW.product_id,
                    :NEW.module_id,
                    :NEW.platform_id,
                    2,
                    :NEW.created_by
                );

                v_next_feature_id := 1;
            EXCEPTION
                WHEN dup_val_on_index THEN
                    UPDATE ph_erp_module_feature_seq
                       SET next_feature_id = next_feature_id + 1
                     WHERE product_id = :NEW.product_id
                       AND module_id = :NEW.module_id
                       AND platform_id = :NEW.platform_id
                    RETURNING next_feature_id - 1 INTO v_next_feature_id;
            END;
        END IF;

        :NEW.feature_id := v_next_feature_id;
    ELSE
        UPDATE ph_erp_module_feature_seq
           SET next_feature_id = GREATEST(next_feature_id, :NEW.feature_id + 1)
         WHERE product_id = :NEW.product_id
           AND module_id = :NEW.module_id
           AND platform_id = :NEW.platform_id;

        IF SQL%ROWCOUNT = 0 THEN
            BEGIN
                INSERT INTO ph_erp_module_feature_seq (
                    product_id,
                    module_id,
                    platform_id,
                    next_feature_id,
                    created_by
                ) VALUES (
                    :NEW.product_id,
                    :NEW.module_id,
                    :NEW.platform_id,
                    :NEW.feature_id + 1,
                    :NEW.created_by
                );
            EXCEPTION
                WHEN dup_val_on_index THEN
                    UPDATE ph_erp_module_feature_seq
                       SET next_feature_id = GREATEST(next_feature_id, :NEW.feature_id + 1)
                     WHERE product_id = :NEW.product_id
                       AND module_id = :NEW.module_id
                       AND platform_id = :NEW.platform_id;
            END;
        END IF;
    END IF;
END;
/
