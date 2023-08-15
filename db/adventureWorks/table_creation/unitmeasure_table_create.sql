-- Table: prod.unitmeasure

-- DROP TABLE IF EXISTS prod.unitmeasure;

CREATE TABLE IF NOT EXISTS prod.unitmeasure
(
    unitmeasurecode character(3) COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY (unitmeasurecode)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.unitmeasure
    OWNER to postgres;

COMMENT ON TABLE prod.unitmeasure
    IS 'Unit of measure lookup table.';

COMMENT ON COLUMN prod.unitmeasure.unitmeasurecode
    IS 'Primary key.';

COMMENT ON COLUMN prod.unitmeasure.name
    IS 'Unit of measure description.';