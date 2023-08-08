-- Table: prod.salestaxrate
SET search_path TO prod;

CREATE SEQUENCE IF NOT EXISTS prod.salestaxrate_salestaxrateid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.salestaxrate;

CREATE TABLE IF NOT EXISTS prod.salestaxrate
(
    salestaxrateid integer NOT NULL DEFAULT nextval('prod.salestaxrate_salestaxrateid_seq'::regclass),
    stateprovinceid integer NOT NULL,
    taxtype smallint NOT NULL,
    taxrate numeric NOT NULL DEFAULT 0.00,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY (salestaxrateid),
    CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" FOREIGN KEY (stateprovinceid)
        REFERENCES prod.stateprovince (stateprovinceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK (taxtype >= 1 AND taxtype <= 3)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.salestaxrate
    OWNER to postgres;

COMMENT ON TABLE prod.salestaxrate
    IS 'Tax rate lookup table.';

COMMENT ON COLUMN prod.salestaxrate.salestaxrateid
    IS 'Primary key for SalesTaxRate records.';

COMMENT ON COLUMN prod.salestaxrate.stateprovinceid
    IS 'State, province, or country/region the sales tax applies to.';

COMMENT ON COLUMN prod.salestaxrate.taxtype
    IS '1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 3 = Tax applied to all sales (retail and wholesale) transactions.';

COMMENT ON COLUMN prod.salestaxrate.taxrate
    IS 'Tax rate amount.';

COMMENT ON COLUMN prod.salestaxrate.name
    IS 'Tax rate description.';