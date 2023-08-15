-- Table: prod.scrapreason

CREATE SEQUENCE IF NOT EXISTS prod.scrapreason_scrapreasonid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.scrapreason;

CREATE TABLE IF NOT EXISTS prod.scrapreason
(
    scrapreasonid integer NOT NULL DEFAULT nextval('prod.scrapreason_scrapreasonid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY (scrapreasonid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.scrapreason
    OWNER to postgres;

COMMENT ON TABLE prod.scrapreason
    IS 'Manufacturing failure reasons lookup table.';

COMMENT ON COLUMN prod.scrapreason.scrapreasonid
    IS 'Primary key for ScrapReason records.';

COMMENT ON COLUMN prod.scrapreason.name
    IS 'Failure description.';