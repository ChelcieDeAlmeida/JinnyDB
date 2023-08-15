-- Table: prod.salesreason

CREATE SEQUENCE IF NOT EXISTS prod.salesreason_salesreasonid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.salesreason;

CREATE TABLE IF NOT EXISTS prod.salesreason
(
    salesreasonid integer NOT NULL DEFAULT nextval('prod.salesreason_salesreasonid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    reasontype character varying COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY (salesreasonid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.salesreason
    OWNER to postgres;

COMMENT ON TABLE prod.salesreason
    IS 'Lookup table of customer purchase reasons.';

COMMENT ON COLUMN prod.salesreason.salesreasonid
    IS 'Primary key for SalesReason records.';

COMMENT ON COLUMN prod.salesreason.name
    IS 'Sales reason description.';

COMMENT ON COLUMN prod.salesreason.reasontype
    IS 'Category the sales reason belongs to.';