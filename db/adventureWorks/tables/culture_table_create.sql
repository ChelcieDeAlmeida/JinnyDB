-- Table: prod.culture

-- DROP TABLE IF EXISTS prod.culture;

CREATE TABLE IF NOT EXISTS prod.culture
(
    cultureid character(6) COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY (cultureid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.culture
    OWNER to postgres;

COMMENT ON TABLE prod.culture
    IS 'Lookup table containing the languages in which some AdventureWorks data is stored.';

COMMENT ON COLUMN prod.culture.cultureid
    IS 'Primary key for Culture records.';

COMMENT ON COLUMN prod.culture.name
    IS 'Culture description.';