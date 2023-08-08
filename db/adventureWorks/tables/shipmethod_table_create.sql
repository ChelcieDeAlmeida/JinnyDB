-- Table: prod.shipmethod

SET search_path TO prod;

CREATE SEQUENCE IF NOT EXISTS prod.shipmethod_shipmethodid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.shipmethod;

CREATE TABLE IF NOT EXISTS prod.shipmethod
(
    shipmethodid integer NOT NULL DEFAULT nextval('prod.shipmethod_shipmethodid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    shipbase numeric NOT NULL DEFAULT 0.00,
    shiprate numeric NOT NULL DEFAULT 0.00,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY (shipmethodid),
    CONSTRAINT "CK_ShipMethod_ShipBase" CHECK (shipbase > 0.00),
    CONSTRAINT "CK_ShipMethod_ShipRate" CHECK (shiprate > 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.shipmethod
    OWNER to postgres;

COMMENT ON TABLE prod.shipmethod
    IS 'Shipping company lookup table.';

COMMENT ON COLUMN prod.shipmethod.shipmethodid
    IS 'Primary key for ShipMethod records.';

COMMENT ON COLUMN prod.shipmethod.name
    IS 'Shipping company name.';

COMMENT ON COLUMN prod.shipmethod.shipbase
    IS 'Minimum shipping charge.';

COMMENT ON COLUMN prod.shipmethod.shiprate
    IS 'Shipping charge per pound.';