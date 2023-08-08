-- Table: prod.contacttype

CREATE SEQUENCE IF NOT EXISTS prod.contacttype_contacttypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;


-- DROP TABLE IF EXISTS person.contacttype;

CREATE TABLE IF NOT EXISTS prod.contacttype
(
    contacttypeid integer NOT NULL DEFAULT nextval('prod.contacttype_contacttypeid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY (contacttypeid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.contacttype
    OWNER to postgres;

COMMENT ON TABLE prod.contacttype
    IS 'Lookup table containing the types of business entity contacts.';

COMMENT ON COLUMN prod.contacttype.contacttypeid
    IS 'Primary key for ContactType records.';

COMMENT ON COLUMN prod.contacttype.name
    IS 'Contact type description.';