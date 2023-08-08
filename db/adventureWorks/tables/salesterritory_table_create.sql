-- Table: prod.salesterritory

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE SEQUENCE IF NOT EXISTS prod.salesterritory_territoryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.salesterritory;

CREATE TABLE IF NOT EXISTS prod.salesterritory
(
    territoryid integer NOT NULL DEFAULT nextval('prod.salesterritory_territoryid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    countryregioncode character varying(3) COLLATE pg_catalog."default" NOT NULL,
    "group" character varying(50) COLLATE pg_catalog."default" NOT NULL,
    salesytd numeric NOT NULL DEFAULT 0.00,
    saleslastyear numeric NOT NULL DEFAULT 0.00,
    costytd numeric NOT NULL DEFAULT 0.00,
    costlastyear numeric NOT NULL DEFAULT 0.00,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY (territoryid),
    CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode)
        REFERENCES prod.countryregion (countryregioncode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_SalesTerritory_SalesYTD" CHECK (salesytd >= 0.00),
    CONSTRAINT "CK_SalesTerritory_SalesLastYear" CHECK (saleslastyear >= 0.00),
    CONSTRAINT "CK_SalesTerritory_CostYTD" CHECK (costytd >= 0.00),
    CONSTRAINT "CK_SalesTerritory_CostLastYear" CHECK (costlastyear >= 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.salesterritory
    OWNER to postgres;

COMMENT ON TABLE prod.salesterritory
    IS 'Sales territory lookup table.';

COMMENT ON COLUMN prod.salesterritory.territoryid
    IS 'Primary key for SalesTerritory records.';

COMMENT ON COLUMN prod.salesterritory.name
    IS 'Sales territory description';

COMMENT ON COLUMN prod.salesterritory.countryregioncode
    IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';

COMMENT ON COLUMN prod.salesterritory."group"
    IS 'Geographic area to which the sales territory belong.';

COMMENT ON COLUMN prod.salesterritory.salesytd
    IS 'Sales in the territory year to date.';

COMMENT ON COLUMN prod.salesterritory.saleslastyear
    IS 'Sales in the territory the previous year.';

COMMENT ON COLUMN prod.salesterritory.costytd
    IS 'Business costs in the territory year to date.';

COMMENT ON COLUMN prod.salesterritory.costlastyear
    IS 'Business costs in the territory the previous year.';