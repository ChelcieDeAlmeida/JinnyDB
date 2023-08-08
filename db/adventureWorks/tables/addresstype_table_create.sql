-- Table: prod.addresstype

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- Sequence: prod.addresstype_addresstypeid_seq

-- DROP SEQUENCE IF EXISTS prod.addresstype_addresstypeid_seq;

CREATE SEQUENCE IF NOT EXISTS prod.addresstype_addresstypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.addresstype;

CREATE TABLE IF NOT EXISTS prod.addresstype
(
    addresstypeid integer NOT NULL DEFAULT nextval('prod.addresstype_addresstypeid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY (addresstypeid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.addresstype
    OWNER to postgres;

COMMENT ON TABLE prod.addresstype
    IS 'Types of addresses stored in the Address table.';

COMMENT ON COLUMN prod.addresstype.addresstypeid
    IS 'Primary key for AddressType records.';

COMMENT ON COLUMN prod.addresstype.name
    IS 'Address type description. For example, Billing, Home, or Shipping.';