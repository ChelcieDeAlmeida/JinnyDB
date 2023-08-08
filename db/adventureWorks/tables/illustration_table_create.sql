-- Table: prod.illustration

CREATE SEQUENCE IF NOT EXISTS prod.illustration_illustrationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.illustration;

CREATE TABLE IF NOT EXISTS prod.illustration
(
    illustrationid integer NOT NULL DEFAULT nextval('prod.illustration_illustrationid_seq'::regclass),
    diagram xml,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Illustration_IllustrationID" PRIMARY KEY (illustrationid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.illustration
    OWNER to postgres;

COMMENT ON TABLE prod.illustration
    IS 'Bicycle assembly diagrams.';

COMMENT ON COLUMN prod.illustration.illustrationid
    IS 'Primary key for Illustration records.';

COMMENT ON COLUMN prod.illustration.diagram
    IS 'Illustrations used in manufacturing instructions. Stored as XML.';