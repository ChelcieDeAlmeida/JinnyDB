-- Table: prod.businessentity

-- Sequence: prod.department_departmentid_seq

-- DROP SEQUENCE IF EXISTS prod.department_departmentid_seq;

CREATE SEQUENCE IF NOT EXISTS prod.businessentity_businessentityid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- DROP TABLE IF EXISTS prod.businessentity;

CREATE TABLE IF NOT EXISTS prod.businessentity
(
    businessentityid integer NOT NULL DEFAULT nextval('prod.businessentity_businessentityid_seq'::regclass),
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY (businessentityid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.businessentity
    OWNER to postgres;

COMMENT ON TABLE prod.businessentity
    IS 'Source of the ID that connects vendors, customers, and employees with address and contact information.';

COMMENT ON COLUMN prod.businessentity.businessentityid
    IS 'Primary key for all customers, vendors, and employees.';