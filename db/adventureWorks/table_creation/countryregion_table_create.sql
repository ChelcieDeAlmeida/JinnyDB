-- Table: prod.countryregion


-- DROP TABLE IF EXISTS prod.countryregion;

CREATE TABLE IF NOT EXISTS prod.countryregion
(
    countryregioncode character varying(3) COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY (countryregioncode)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.countryregion
    OWNER to postgres;

COMMENT ON TABLE prod.countryregion
    IS 'Lookup table containing the ISO standard codes for countries and regions.';

COMMENT ON COLUMN prod.countryregion.countryregioncode
    IS 'ISO standard code for countries and regions.';

COMMENT ON COLUMN prod.countryregion.name
    IS 'Country or region name.';