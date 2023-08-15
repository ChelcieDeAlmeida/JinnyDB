-- Table: prod.currency

-- DROP TABLE IF EXISTS prod.currency;

CREATE TABLE IF NOT EXISTS prod.currency
(
    currencycode character(3) COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY (currencycode)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.currency
    OWNER to postgres;

COMMENT ON TABLE prod.currency
    IS 'Lookup table containing standard ISO currencies.';

COMMENT ON COLUMN prod.currency.currencycode
    IS 'The ISO code for the Currency.';

COMMENT ON COLUMN prod.currency.name
    IS 'Currency name.';