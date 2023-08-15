-- Table: prod.address

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE SEQUENCE IF NOT EXISTS prod.address_addressid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.address;

CREATE TABLE IF NOT EXISTS prod.address
(
    addressid integer NOT NULL DEFAULT nextval('prod.address_addressid_seq'::regclass),
    addressline1 character varying(60) COLLATE pg_catalog."default" NOT NULL,
    addressline2 character varying(60) COLLATE pg_catalog."default",
    city character varying(30) COLLATE pg_catalog."default" NOT NULL,
    stateprovinceid integer NOT NULL,
    postalcode character varying(15) COLLATE pg_catalog."default" NOT NULL,
    spatiallocation bytea,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Address_AddressID" PRIMARY KEY (addressid),
    CONSTRAINT "FK_Address_StateProvince_StateProvinceID" FOREIGN KEY (stateprovinceid)
        REFERENCES prod.stateprovince (stateprovinceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.address
    OWNER to postgres;

COMMENT ON TABLE prod.address
    IS 'Street address information for customers, employees, and vendors.';

COMMENT ON COLUMN prod.address.addressid
    IS 'Primary key for Address records.';

COMMENT ON COLUMN prod.address.addressline1
    IS 'First street address line.';

COMMENT ON COLUMN prod.address.addressline2
    IS 'Second street address line.';

COMMENT ON COLUMN prod.address.city
    IS 'Name of the city.';

COMMENT ON COLUMN prod.address.stateprovinceid
    IS 'Unique identification number for the state or province. Foreign key to StateProvince table.';

COMMENT ON COLUMN prod.address.postalcode
    IS 'Postal code for the street address.';

COMMENT ON COLUMN prod.address.spatiallocation
    IS 'Latitude and longitude of this address.';