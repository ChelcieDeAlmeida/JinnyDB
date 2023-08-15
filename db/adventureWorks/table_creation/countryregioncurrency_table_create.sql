-- Table: prod.countryregioncurrency

-- DROP TABLE IF EXISTS prod.countryregioncurrency;

CREATE TABLE IF NOT EXISTS prod.countryregioncurrency
(
    countryregioncode character varying(3) COLLATE pg_catalog."default" NOT NULL,
    currencycode character(3) COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY (countryregioncode, currencycode),
    CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode)
        REFERENCES prod.countryregion (countryregioncode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY (currencycode)
        REFERENCES prod.currency (currencycode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.countryregioncurrency
    OWNER to postgres;

COMMENT ON TABLE prod.countryregioncurrency
    IS 'Cross-reference table mapping ISO currency codes to a country or region.';

COMMENT ON COLUMN prod.countryregioncurrency.countryregioncode
    IS 'ISO code for countries and regions. Foreign key to CountryRegion.CountryRegionCode.';

COMMENT ON COLUMN prod.countryregioncurrency.currencycode
    IS 'ISO standard currency code. Foreign key to Currency.CurrencyCode.';