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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_price_unit
BEFORE INSERT OR UPDATE ON ph_erp_pricing_unit_lkp
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_pay_cycle
BEFORE INSERT OR UPDATE ON ph_erp_payment_cycle_lkp
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_platform
BEFORE INSERT OR UPDATE ON ph_erp_platform_lkp
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_products
BEFORE INSERT OR UPDATE ON ph_erp_products
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_prod_mod_seq
BEFORE INSERT OR UPDATE ON ph_erp_product_module_seq
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_modules
BEFORE INSERT OR UPDATE ON ph_erp_modules
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_mod_plat
BEFORE INSERT OR UPDATE ON ph_erp_module_platforms
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_mod_feat_seq
BEFORE INSERT OR UPDATE ON ph_erp_module_feature_seq
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_features
BEFORE INSERT OR UPDATE ON ph_erp_features
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_customers
BEFORE INSERT OR UPDATE ON ph_erp_customers
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_contracts
BEFORE INSERT OR UPDATE ON ph_erp_contracts
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_cont_urls
BEFORE INSERT OR UPDATE ON ph_erp_contract_urls
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_cont_mods
BEFORE INSERT OR UPDATE ON ph_erp_contract_modules
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_cont_plats
BEFORE INSERT OR UPDATE ON ph_erp_contract_platforms
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

CREATE OR REPLACE TRIGGER trg_aud_ph_erp_cont_feats
BEFORE INSERT OR UPDATE ON ph_erp_contract_features
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

CREATE OR REPLACE TRIGGER trg_ph_languages_bu
BEFORE UPDATE ON ph_languages
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_i18n_texts_bu
BEFORE UPDATE ON ph_i18n_texts
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_i18n_messages_bu
BEFORE UPDATE ON ph_i18n_messages
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_products_bu
BEFORE UPDATE ON ph_erp_products
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_price_unit_bu
BEFORE UPDATE ON ph_erp_pricing_unit_lkp
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_pay_cycle_bu
BEFORE UPDATE ON ph_erp_payment_cycle_lkp
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_user_type_bu
BEFORE UPDATE ON ph_sec_user_type_lkp
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_platform_bu
BEFORE UPDATE ON ph_erp_platform_lkp
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
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

CREATE OR REPLACE TRIGGER trg_ph_erp_prod_mod_seq_bu
BEFORE UPDATE ON ph_erp_product_module_seq
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_modules_bi
BEFORE INSERT ON ph_erp_modules
FOR EACH ROW
DECLARE
    v_next_module_id NUMBER(19);
BEGIN
    :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
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

CREATE OR REPLACE TRIGGER trg_ph_erp_modules_bu
BEFORE UPDATE ON ph_erp_modules
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_module_platforms_bu
BEFORE UPDATE ON ph_erp_module_platforms
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
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

CREATE OR REPLACE TRIGGER trg_ph_erp_mod_feat_seq_bu
BEFORE UPDATE ON ph_erp_module_feature_seq
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_features_bi
BEFORE INSERT ON ph_erp_features
FOR EACH ROW
DECLARE
    v_next_feature_id NUMBER(19);
BEGIN
    :NEW.created_by := NVL(ph_sec_authentication_pkg.get_user_id, NVL(:NEW.created_by, 1));
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

CREATE OR REPLACE TRIGGER trg_ph_erp_features_bu
BEFORE UPDATE ON ph_erp_features
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_customers_bu
BEFORE UPDATE ON ph_erp_customers
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_cu_bu
BEFORE UPDATE ON ph_erp_contract_urls
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_contracts_bu
BEFORE UPDATE ON ph_erp_contracts
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_cm_bu
BEFORE UPDATE ON ph_erp_contract_modules
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_cp_bu
BEFORE UPDATE ON ph_erp_contract_platforms
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_erp_cf_bu
BEFORE UPDATE ON ph_erp_contract_features
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_users_bu
BEFORE UPDATE ON ph_sec_users
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_obj_type_bu
BEFORE UPDATE ON ph_sec_object_type_lkp
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_objects_bu
BEFORE UPDATE ON ph_sec_objects
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_actions_bu
BEFORE UPDATE ON ph_sec_actions
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_permissions_bu
BEFORE UPDATE ON ph_sec_permissions
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_apex_ptype_bu
BEFORE UPDATE ON ph_sec_apex_page_type_lkp
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_user_pref_bu
BEFORE UPDATE ON ph_sec_user_preferences
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_roles_bu
BEFORE UPDATE ON ph_sec_roles
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_apex_pages_bu
BEFORE UPDATE ON ph_sec_apex_pages
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_apex_page_perm_bu
BEFORE UPDATE ON ph_sec_apex_page_permissions
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_role_perm_bu
BEFORE UPDATE ON ph_sec_role_permissions
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ph_sec_user_roles_bu
BEFORE UPDATE ON ph_sec_user_roles
FOR EACH ROW
BEGIN
    IF NOT (NVL(:OLD.is_deleted, 0) = 0 AND NVL(:NEW.is_deleted, 0) = 1) THEN
        :NEW.updated_at := SYSTIMESTAMP;
    END IF;
END;
/



