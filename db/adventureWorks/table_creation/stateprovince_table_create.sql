-- Table: prod.stateprovince

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SEQUENCE IF NOT EXISTS prod.stateprovince_stateprovinceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.stateprovince;

CREATE TABLE IF NOT EXISTS prod.stateprovince
(
    stateprovinceid integer NOT NULL DEFAULT nextval('prod.stateprovince_stateprovinceid_seq'::regclass),
    stateprovincecode character(3) COLLATE pg_catalog."default" NOT NULL,
    countryregioncode character varying(3) COLLATE pg_catalog."default" NOT NULL,
    isonlystateprovinceflag boolean NOT NULL DEFAULT true,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    territoryid integer NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY (stateprovinceid),
    CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode)
        REFERENCES prod.countryregion (countryregioncode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid)
        REFERENCES prod.salesterritory (territoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.stateprovince
    OWNER to postgres;

COMMENT ON TABLE prod.stateprovince
    IS 'State and province lookup table.';

COMMENT ON COLUMN prod.stateprovince.stateprovinceid
    IS 'Primary key for StateProvince records.';

COMMENT ON COLUMN prod.stateprovince.stateprovincecode
    IS 'ISO standard state or province code.';

COMMENT ON COLUMN prod.stateprovince.countryregioncode
    IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';

COMMENT ON COLUMN prod.stateprovince.isonlystateprovinceflag
    IS '0 = StateProvinceCode exists. 1 = StateProvinceCode unavailable, using CountryRegionCode.';

COMMENT ON COLUMN prod.stateprovince.name
    IS 'State or province description.';

COMMENT ON COLUMN prod.stateprovince.territoryid
    IS 'ID of the territory in which the state or province is located. Foreign key to SalesTerritory.SalesTerritoryID.';