-- Table: prod.currencyrate


CREATE SEQUENCE IF NOT EXISTS prod.currencyrate_currencyrateid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.currencyrate;

CREATE TABLE IF NOT EXISTS prod.currencyrate
(
    currencyrateid integer NOT NULL DEFAULT nextval('prod.currencyrate_currencyrateid_seq'::regclass),
    currencyratedate timestamp without time zone NOT NULL,
    fromcurrencycode character(3) COLLATE pg_catalog."default" NOT NULL,
    tocurrencycode character(3) COLLATE pg_catalog."default" NOT NULL,
    averagerate numeric NOT NULL,
    endofdayrate numeric NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY (currencyrateid),
    CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" FOREIGN KEY (fromcurrencycode)
        REFERENCES prod.currency (currencycode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode" FOREIGN KEY (tocurrencycode)
        REFERENCES prod.currency (currencycode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.currencyrate
    OWNER to postgres;

COMMENT ON TABLE prod.currencyrate
    IS 'Currency exchange rates.';

COMMENT ON COLUMN prod.currencyrate.currencyrateid
    IS 'Primary key for CurrencyRate records.';

COMMENT ON COLUMN prod.currencyrate.currencyratedate
    IS 'Date and time the exchange rate was obtained.';

COMMENT ON COLUMN prod.currencyrate.fromcurrencycode
    IS 'Exchange rate was converted from this currency code.';

COMMENT ON COLUMN prod.currencyrate.tocurrencycode
    IS 'Exchange rate was converted to this currency code.';

COMMENT ON COLUMN prod.currencyrate.averagerate
    IS 'Average exchange rate for the day.';

COMMENT ON COLUMN prod.currencyrate.endofdayrate
    IS 'Final exchange rate for the day.';