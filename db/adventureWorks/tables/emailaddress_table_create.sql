-- Table: prod.emailaddress

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SEQUENCE IF NOT EXISTS prod.emailaddress_emailaddressid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;


-- DROP TABLE IF EXISTS prod.emailaddress;

CREATE TABLE IF NOT EXISTS prod.emailaddress
(
    businessentityid integer NOT NULL,
    emailaddressid integer NOT NULL DEFAULT nextval('prod.emailaddress_emailaddressid_seq'::regclass),
    emailaddress character varying(50) COLLATE pg_catalog."default",
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY (businessentityid, emailaddressid),
    CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.person (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.emailaddress
    OWNER to postgres;

COMMENT ON TABLE prod.emailaddress
    IS 'Where to send a person email.';

COMMENT ON COLUMN prod.emailaddress.businessentityid
    IS 'Primary key. Person associated with this email address.  Foreign key to Person.BusinessEntityID';

COMMENT ON COLUMN prod.emailaddress.emailaddressid
    IS 'Primary key. ID of this email address.';

COMMENT ON COLUMN prod.emailaddress.emailaddress
    IS 'E-mail address for the person.';