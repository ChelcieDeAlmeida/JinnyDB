-- Table: prod.phonenumbertype


-- Sequence: prod.phonenumbertype_phonenumbertypeid_seq

-- DROP SEQUENCE IF EXISTS prod.phonenumbertype_phonenumbertypeid_seq;

CREATE SEQUENCE IF NOT EXISTS prod.phonenumbertype_phonenumbertypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.phonenumbertype;

CREATE TABLE IF NOT EXISTS prod.phonenumbertype
(
    phonenumbertypeid integer NOT NULL DEFAULT nextval('prod.phonenumbertype_phonenumbertypeid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY (phonenumbertypeid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.phonenumbertype
    OWNER to postgres;

COMMENT ON TABLE prod.phonenumbertype
    IS 'Type of phone number of a person.';

COMMENT ON COLUMN prod.phonenumbertype.phonenumbertypeid
    IS 'Primary key for telephone number type records.';

COMMENT ON COLUMN prod.phonenumbertype.name
    IS 'Name of the telephone number type';