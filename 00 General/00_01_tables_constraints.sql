

CREATE TABLE ph_lookup_types (
    lookup_type_code VARCHAR2(80 CHAR) NOT NULL,
    lookup_type_name_en VARCHAR2(200 CHAR) NOT NULL,
    lookup_type_name_ar VARCHAR2(200 CHAR) NOT NULL,
    description_en VARCHAR2(500 CHAR),
    description_ar VARCHAR2(500 CHAR),
    is_system_type NUMBER(1) DEFAULT 1 NOT NULL,
    is_active NUMBER(1) DEFAULT 1 NOT NULL,
    is_deleted NUMBER(1) DEFAULT 0 NOT NULL CHECK ( is_deleted IN (0, 1) ),
    created_by NUMBER,
    created_at TIMESTAMP(3) DEFAULT SYSTIMESTAMP NOT NULL,
    updated_by NUMBER,
    updated_at TIMESTAMP(3),
    deleted_by NUMBER,
    deleted_at TIMESTAMP(3),
    CONSTRAINT pk_ph_lookup_types PRIMARY KEY (lookup_type_code),
    CONSTRAINT ck_ph_lookup_types_code CHECK ( lookup_type_code = UPPER(lookup_type_code) ),
    CONSTRAINT ck_ph_lookup_types_flags CHECK ( is_system_type IN (0, 1)
        AND is_active IN (0, 1) )
);

CREATE TABLE ph_lookup_values (
    lookup_type_code VARCHAR2(80 CHAR) NOT NULL,
    lookup_value_code VARCHAR2(120 CHAR) NOT NULL,
    display_value_en VARCHAR2(4000 CHAR) NOT NULL,
    display_value_ar VARCHAR2(4000 CHAR) NOT NULL,
    return_value VARCHAR2(4000 CHAR) NOT NULL,
    display_order NUMBER(10) DEFAULT 0 NOT NULL,
    is_system_value NUMBER(1) DEFAULT 1 NOT NULL,
    is_active NUMBER(1) DEFAULT 1 NOT NULL,
    is_deleted NUMBER(1) DEFAULT 0 NOT NULL CHECK ( is_deleted IN (0, 1) ),
    created_by NUMBER,
    created_at TIMESTAMP(3) DEFAULT SYSTIMESTAMP NOT NULL,
    updated_by NUMBER,
    updated_at TIMESTAMP(3),
    deleted_by NUMBER,
    deleted_at TIMESTAMP(3),
    CONSTRAINT pk_ph_lookup_values PRIMARY KEY (lookup_type_code, lookup_value_code),
    CONSTRAINT fk_ph_lookup_values_type FOREIGN KEY (lookup_type_code) REFERENCES ph_lookup_types ( lookup_type_code ),
    CONSTRAINT ck_ph_lookup_values_code CHECK ( lookup_value_code = UPPER(lookup_value_code) ),
    CONSTRAINT ck_ph_lookup_values_flags CHECK ( is_system_value IN (0, 1)
        AND is_active IN (0, 1) )
);

