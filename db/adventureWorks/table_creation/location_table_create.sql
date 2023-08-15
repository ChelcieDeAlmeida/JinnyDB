-- Table: prod.location

CREATE SEQUENCE IF NOT EXISTS prod.location_locationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.location;

CREATE TABLE IF NOT EXISTS prod.location
(
    locationid integer NOT NULL DEFAULT nextval('prod.location_locationid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    costrate numeric NOT NULL DEFAULT 0.00,
    availability numeric(8,2) NOT NULL DEFAULT 0.00,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Location_LocationID" PRIMARY KEY (locationid),
    CONSTRAINT "CK_Location_CostRate" CHECK (costrate >= 0.00),
    CONSTRAINT "CK_Location_Availability" CHECK (availability >= 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.location
    OWNER to postgres;

COMMENT ON TABLE prod.location
    IS 'Product inventory and manufacturing locations.';

COMMENT ON COLUMN prod.location.locationid
    IS 'Primary key for Location records.';

COMMENT ON COLUMN prod.location.name
    IS 'Location description.';

COMMENT ON COLUMN prod.location.costrate
    IS 'Standard hourly cost of the manufacturing location.';

COMMENT ON COLUMN prod.location.availability
    IS 'Work capacity (in hours) of the manufacturing location.';